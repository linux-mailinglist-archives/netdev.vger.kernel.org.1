Return-Path: <netdev+bounces-18704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F9B758544
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 21:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202E328173A
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A683168A7;
	Tue, 18 Jul 2023 19:01:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D659168A1;
	Tue, 18 Jul 2023 19:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBB0C433C8;
	Tue, 18 Jul 2023 19:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689706868;
	bh=ul3QKqb8ksgugpGdVbvWdYxqyYBG1CBdiY1luwCTRYw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AfyoZfgVHoXor39CTkg0WCEbjgzURCc6DPE1CajwVxA7Vekia8bbrEcX4YVoPdGOR
	 AugAG8IuYvKGHobXCxGx7ADNMVD1m7Es/czopnG7GA7cw7cxN/mpiu0viQJ/aRD/jW
	 bwAjYK9mwdGJWk31DoewQ5M8Tt7C8nvZ8kRgzR6pQrjzZrd/5E7svk8IcCE8SPqt6w
	 en6H/wPNVuOXJvHCBntdcqR3OPSEoWk81m83/NVQHW6812YW7HIgYNIBJG22aD1cZx
	 manPE7Js9sRWz746/G1XjAuPqH3ISqFlQw/9yCJTglr8ZSZHev99IiAEqmN1qitCaj
	 BcDLhvyYiLr5g==
Subject: [PATCH net-next v1 5/7] net/handshake: Add helpers for parsing
 incoming TLS Alerts
From: Chuck Lever <cel@kernel.org>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date: Tue, 18 Jul 2023 15:00:56 -0400
Message-ID: 
 <168970685465.5330.12951636644707988195.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: 
 <168970659111.5330.9206348580241518146.stgit@oracle-102.nfsv4bat.org>
References: 
 <168970659111.5330.9206348580241518146.stgit@oracle-102.nfsv4bat.org>
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
 net/handshake/alert.c   |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/net/handshake.h b/include/net/handshake.h
index bb88dfa6e3c9..d0fd6a3898c6 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -42,4 +42,8 @@ int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
 bool tls_handshake_cancel(struct sock *sk);
 void tls_handshake_close(struct socket *sock);
 
+u8 tls_record_type(const struct sock *sk, const struct cmsghdr *msg);
+bool tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
+		    u8 *level, u8 *description);
+
 #endif /* _NET_HANDSHAKE_H */
diff --git a/net/handshake/alert.c b/net/handshake/alert.c
index 999d3ffaf3e3..93e05d8d599c 100644
--- a/net/handshake/alert.c
+++ b/net/handshake/alert.c
@@ -60,3 +60,49 @@ int tls_alert_send(struct socket *sock, u8 level, u8 description)
 	ret = sock_sendmsg(sock, &msg);
 	return ret < 0 ? ret : 0;
 }
+
+/**
+ * tls_record_type - Look for TLS RECORD_TYPE information
+ * @sk: socket (for IP address information)
+ * @cmsg: incoming message to be parsed
+ *
+ * Returns zero or a TLS_RECORD_TYPE value.
+ */
+u8 tls_record_type(const struct sock *sk, const struct cmsghdr *cmsg)
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
+EXPORT_SYMBOL(tls_record_type);
+
+/**
+ * tls_alert_recv - Look for TLS Alert messages
+ * @sk: socket (for IP address information)
+ * @msg: incoming message to be parsed
+ * @level: OUT - TLS AlertLevel value
+ * @description: OUT - TLS AlertDescription value
+ *
+ * Return values:
+ *   %true: @msg contained a TLS Alert; @level and @description filled in
+ *   %false: @msg did not contain a TLS Alert
+ */
+bool tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
+		    u8 *level, u8 *description)
+{
+	const struct kvec *iov;
+	u8 *data;
+
+	iov = msg->msg_iter.kvec;
+	data = iov->iov_base;
+	*level = data[0];
+	*description = data[1];
+	return true;
+}
+EXPORT_SYMBOL(tls_alert_recv);



