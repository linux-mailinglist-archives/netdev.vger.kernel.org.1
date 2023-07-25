Return-Path: <netdev+bounces-21035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A63CB762392
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 22:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5FA91C21024
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BF825937;
	Tue, 25 Jul 2023 20:37:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281362418A;
	Tue, 25 Jul 2023 20:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20913C433C7;
	Tue, 25 Jul 2023 20:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690317461;
	bh=9gtBJHvUD+J8t2kUg24neaLbu7jEg3huz6j+x8XlohA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=meL9TDWGcrgtmYmL8+/zGwZbXXjaWlalUhVma4Xq8rf358RYU/l8IHOstbO9Kxm2c
	 2rBoEWAcoJLW8AH+Hsb4K07zzdOSlTsw+CcFeVFp3i4uAtTXao/6TJ8dkt+/lkmfqU
	 2o3fpq2Z/p/I657Jux+TtEGIAKs8n3Rc7E/1hbFP1sfiGwG3QzDUKWPEmkk56iVjPH
	 ZHvZtlhLGJpUQCBth7nNDVA9HZfNMlkgVxuMrHmsMgt1N1V6UJSupt2neSWnrLp5DG
	 +1iTtpLE8nt4ur7binpny5s22lvcr6h5n2BP1apFUSqZKx/q5e1eezDoRimO17sEGv
	 9/dzt3IUpwGPg==
Subject: [PATCH net-next v2 5/7] net/handshake: Add helpers for parsing
 incoming TLS Alerts
From: Chuck Lever <cel@kernel.org>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date: Tue, 25 Jul 2023 16:37:30 -0400
Message-ID: 
 <169031744823.15386.12253453581563018622.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: 
 <169031700320.15386.6923217931442885226.stgit@oracle-102.nfsv4bat.org>
References: 
 <169031700320.15386.6923217931442885226.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Kernel TLS consumers can replace common TLS Alert parsing code with
these helpers.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/net/handshake.h |    4 ++++
 net/handshake/alert.c   |   42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/net/handshake.h b/include/net/handshake.h
index bb88dfa6e3c9..8ebd4f9ed26e 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -42,4 +42,8 @@ int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
 bool tls_handshake_cancel(struct sock *sk);
 void tls_handshake_close(struct socket *sock);
 
+u8 tls_get_record_type(const struct sock *sk, const struct cmsghdr *msg);
+void tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
+		    u8 *level, u8 *description);
+
 #endif /* _NET_HANDSHAKE_H */
diff --git a/net/handshake/alert.c b/net/handshake/alert.c
index 999d3ffaf3e3..4cb76fc2c531 100644
--- a/net/handshake/alert.c
+++ b/net/handshake/alert.c
@@ -60,3 +60,45 @@ int tls_alert_send(struct socket *sock, u8 level, u8 description)
 	ret = sock_sendmsg(sock, &msg);
 	return ret < 0 ? ret : 0;
 }
+
+/**
+ * tls_get_record_type - Look for TLS RECORD_TYPE information
+ * @sk: socket (for IP address information)
+ * @cmsg: incoming message to be parsed
+ *
+ * Returns zero or a TLS_RECORD_TYPE value.
+ */
+u8 tls_get_record_type(const struct sock *sk, const struct cmsghdr *cmsg)
+{
+	u8 record_type;
+
+	if (cmsg->cmsg_level != SOL_TLS)
+		return 0;
+	if (cmsg->cmsg_type != TLS_GET_RECORD_TYPE)
+		return 0;
+
+	record_type = *((u8 *)CMSG_DATA(cmsg));
+	return record_type;
+}
+EXPORT_SYMBOL(tls_get_record_type);
+
+/**
+ * tls_alert_recv - Parse TLS Alert messages
+ * @sk: socket (for IP address information)
+ * @msg: incoming message to be parsed
+ * @level: OUT - TLS AlertLevel value
+ * @description: OUT - TLS AlertDescription value
+ *
+ */
+void tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
+		    u8 *level, u8 *description)
+{
+	const struct kvec *iov;
+	u8 *data;
+
+	iov = msg->msg_iter.kvec;
+	data = iov->iov_base;
+	*level = data[0];
+	*description = data[1];
+}
+EXPORT_SYMBOL(tls_alert_recv);



