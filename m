Return-Path: <netdev+bounces-167817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3849AA3C720
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 19:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39441887F0A
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7748521506C;
	Wed, 19 Feb 2025 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="HUiu4XHP"
X-Original-To: netdev@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEDD215052;
	Wed, 19 Feb 2025 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988839; cv=pass; b=g3AlqvU5ux7ivIfe8b3FE8P3eTIsB/8QyQaP9LG40gGCQzTM307TzIK1C2dTCc/EHhWY3E46iLUDXaLI3UOa0rmzxm/+ws1rGrkxzWJF2uCWWM4S1btP+P+/6VQxJjaNRp6MlxKSZtXH5VH2FZr2ZVD/mk/d0xSMjg/+Mrsgk5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988839; c=relaxed/simple;
	bh=tFjxQ4xwKJ5WYk4VHccCnN0hp6U7ni1nBRfMdKbhUR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmTfn/H5mTZ4tqB/ablm9Z6fhAua0/RsTRJmhJsM10kuePI5QVOPbF6uHFigJVXeAUYvIsSNbIdp2pZAIP7+0IKmtiPqfm0ca8wHZMMnZtdt/zl1gfDoMdwGuFfAbOnOc5+e2jfIF7FFVr7kpHun5eOZ9amblyw7CeuVvzRx2Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=HUiu4XHP; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Yykzj3Tndz10DN;
	Wed, 19 Feb 2025 20:13:53 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1739988834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJNzXI82cDFYIUX+q6pOVmeAvH8m6xfO5n99kk/kpC8=;
	b=HUiu4XHPcHn17HK/B5oEjc8D9KvnDdDYG0zGhZc8xb2hz91DXZVPC1gIvyzEL8w0UApV6z
	yv5QlDNzrnedYiqfLAu70TvJKa7cI+Avq3lhk0TLazYZEKl1dtMyIFMAJTzTXJDR3zloXp
	MkW3ySAqwAJllPiTPCHrHPIuzuD/VI0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1739988834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJNzXI82cDFYIUX+q6pOVmeAvH8m6xfO5n99kk/kpC8=;
	b=ZPBUqBC//+XBvrBL32pwhdVDOb2gY02YQM161pmwUlqqHAI+UHWxrZ9Dscq+e+sg6SRoQN
	2OS58sS91/90kswqTZNpmjeWt6K2yL0d7kMwm9UJDhvxIxFkoMUFHzmPPztGDhtHqT0JEN
	4C24jXoofi4/Y+Lhmlh9l9SoQPv7PXA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1739988834; a=rsa-sha256; cv=none;
	b=ZDaoMVt1ov3YWhawEjeE0Hyb9ffuzB4V+8LFIx8Yw2RigOjdrpNDBperOw5Vnk/KatgiSa
	jkcdefYMIiUT7BLxyON7UvcqklPAJyoqxBlzxJ94habarC5bh+wwEFySHqX8BHluR7f9fx
	YGHV68LpKDDJcCOI71Yk3TUU1CEv1NE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH v4 5/5] Bluetooth: SCO: add TX timestamping socket-level mechanism
Date: Wed, 19 Feb 2025 20:13:37 +0200
Message-ID: <79a6ebae9e43c390a9d06278a38f00c8d3af81b6.1739988644.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739988644.git.pav@iki.fi>
References: <cover.1739988644.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support TX timestamping in SCO sockets.

Support MSG_ERRQUEUE in SCO recvmsg.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v4: no changes

 net/bluetooth/sco.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index aa7bfe26cb40..f39c57ac594f 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -370,7 +370,8 @@ static int sco_connect(struct sock *sk)
 	return err;
 }
 
-static int sco_send_frame(struct sock *sk, struct sk_buff *skb)
+static int sco_send_frame(struct sock *sk, struct sk_buff *skb,
+			  const struct sockcm_cookie *sockc)
 {
 	struct sco_conn *conn = sco_pi(sk)->conn;
 	int len = skb->len;
@@ -381,6 +382,7 @@ static int sco_send_frame(struct sock *sk, struct sk_buff *skb)
 
 	BT_DBG("sk %p len %d", sk, len);
 
+	hci_setup_tx_timestamp(skb, 1, sockc);
 	hci_send_sco(conn->hcon, skb);
 
 	return len;
@@ -776,6 +778,7 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb;
+	struct sockcm_cookie sockc;
 	int err;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
@@ -787,6 +790,14 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (msg->msg_flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
+	sockcm_init(&sockc, sk);
+
+	if (msg->msg_controllen) {
+		err = sock_cmsg_send(sk, msg, &sockc);
+		if (err)
+			return err;
+	}
+
 	skb = bt_skb_sendmsg(sk, msg, len, len, 0, 0);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
@@ -794,7 +805,7 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	lock_sock(sk);
 
 	if (sk->sk_state == BT_CONNECTED)
-		err = sco_send_frame(sk, skb);
+		err = sco_send_frame(sk, skb, &sockc);
 	else
 		err = -ENOTCONN;
 
@@ -860,6 +871,10 @@ static int sco_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct sock *sk = sock->sk;
 	struct sco_pinfo *pi = sco_pi(sk);
 
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return sock_recv_errqueue(sk, msg, len, SOL_BLUETOOTH,
+					  BT_SCM_ERROR);
+
 	lock_sock(sk);
 
 	if (sk->sk_state == BT_CONNECT2 &&
-- 
2.48.1


