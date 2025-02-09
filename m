Return-Path: <netdev+bounces-164423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32332A2DC93
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 11:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E943A3A3D
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FC013DBA0;
	Sun,  9 Feb 2025 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="bj/k046j"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8047D243370;
	Sun,  9 Feb 2025 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739097582; cv=pass; b=NZDyEK+m49qZ6xvZ/JoSkf7Uf3N27dBV3FQl+zzdCcOt+ZjcizrIYf12/OjWHamJay/q4sdeqqlR1GndeeytmCWZkmEw70zEQlz/8dSYAdme7QN39OxqvaoYVOTGtZHgsPDf1w5DFW6UlfNJjHRtZ/1LrrlCYE5MnPVdAAoDSrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739097582; c=relaxed/simple;
	bh=pRj1P6xt5VnRUSC44/bBifRMJtk42pamaKar/KCrJDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvZ2FZsVRFzyZKcWGaBW//p7cVUwCBt+XGKhqsLODORpvx5/7bfx4Vy/dTUSJ005QnSSMhDJFPqBRO6JtPGE5frQ+1VWtO/DFr9Rj6yx1WrSn4umpbPKVoBP9X98/AWVclasJy9ic8fqRPTwC02SHRzx4UikENRGSJ/LEiox6Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=bj/k046j; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YrPN93Xffz49QC9;
	Sun,  9 Feb 2025 12:39:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739097579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIHlb2ApKngockyPdMNG31MC4jnN36aCmtwjnch4pHo=;
	b=bj/k046jp96fgsmejo4YCbJlc5FthrP7pJzba9cddr6jFYbc17bw70llsiIrbdbknHD5hW
	lo2MSFCQKKVD1ppXynxyh2tkL990yrwiNflrvdfhHn3gokeg88c4Y4VndEekkqSCwfGHIz
	TQk3ZVEFJKir3FYHXSCBA5YSoZqqEI+tqwr0XP506SQ8Np/iNieP13lDw9wBrwYabdK7Wn
	IyUQLsMLKGlEGejhF1VijeJmrrEDUNn5+Vmx2R0sSu8S/+6NzBP3wkYIlaCzX9u4vqI50s
	go0hCBu7u2HDy2qZ20EbYgOEOLSez7PFvlMlXunFvHp6xWJb2UX7oh4B3TBlQA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739097578; a=rsa-sha256;
	cv=none;
	b=T/rGog2zmcnvO/Ud/IKdQolrBkqqxj8LGDNpJ7dS25oz+AFaSfidN6hAv1AlUeIvXTbLIz
	5yiZjtk5z856xJiuKp/bdl7tL7jIG5o3rRIV5EMJKXK9ng4ZRdfs8cjrg8GdIdyqS+tUEK
	JkjS46aAjaQ01N241LpFErNHgk1/tRULMYAcwiymRBdN+mj9d80GfYmV4sWQ+HG9P7bMSv
	jr1gWFMvFngu9h5jHrKF4g3kOHymr5r/V02RV+9RyFV2EBR1PwwkGS6PelQ/6CP7VkFiAq
	P4wWBeZtnEfhhz06ErupR75IUn41rjByBdqMTiVWtvzVEGOu1He06yx4fZ8a5w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739097578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIHlb2ApKngockyPdMNG31MC4jnN36aCmtwjnch4pHo=;
	b=gyCxm1rtXgkvgil/usJ5hBKXb04yosvg7xglCn7CZ0GCVFBlHL6gUq+GXro9khf6lmnHkX
	QjgtW9fOOIdvg7pX21y6UiQs2f7C/hJ2X8npEwRRxQETs+7U1EPZgSqF2CxTorCWFlfukE
	wPYchjPOyDScjMdANjo1BOFeiXK9AfnETj9JJ3eQN/kUjFCXG8V3u4BAXR87p1fI47xI4l
	y/5s7mWVFSHZV9Hphu6U4c/78Wd5scIRaKzMpFmwnHW2QUt3ISYSVjl+I+2hBFpFzVn++7
	QcIK3zBvaRI/C3o/MkJVyWPJo9sD/bxydJTPBiRT8E5Ym6iJXGccfpkp0J//Mw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH v3 5/5] Bluetooth: SCO: add TX timestamping socket-level mechanism
Date: Sun,  9 Feb 2025 12:39:17 +0200
Message-ID: <5e5ed3e5fd972b1f1f191045a890e5e23b8a1276.1739097311.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739097311.git.pav@iki.fi>
References: <cover.1739097311.git.pav@iki.fi>
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


