Return-Path: <netdev+bounces-164420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEF8A2DC8C
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 11:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C49516300F
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 10:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECF71632DF;
	Sun,  9 Feb 2025 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="bOQQMdeL"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A5A13BC0C;
	Sun,  9 Feb 2025 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739097579; cv=pass; b=rFA8aZflPOa9Q7YVnMQbYguTKQWsyztY+/bd1qjPnQVDT7DL6/W6dxkOSXiciOJ45GpMo7PFHjZb9KE4JiVoQGbTkJs2kjB8nG+aYNw11TiJUrNkK3dhMN1CX0KdjtkIOwWpAXb2AXEothYnB21JOR2yGIyaV0tEjfkcS7UKi7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739097579; c=relaxed/simple;
	bh=YgFPnBlAjdJ7kKacFYw8oZRvMTNxV7hsmxrUOCel/Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmHpw1ej1U6N9Atr4akCLdv23OkEnsoZBKumtQ6mvyikiZdtzOQiAHIeJs+ycZ4RpuwbSUvpMJ//xNJO3jRhketfUBef//qg2F2CP0xOGsm1pTLy9Je301rSmf7q5en+9BXq/Sdk5JN72LSd5KPgsi60YI/t8/BbvVIJWUyD0+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=bOQQMdeL; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YrPN54dZ1z49Q94;
	Sun,  9 Feb 2025 12:39:33 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739097575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SDcfYIgWirj2irWZu5yqgLL8XZKsytvOPvE0gOE+0Zo=;
	b=bOQQMdeLHu8LqkFERaAs3xneQMfUftMZzsN9x1nwF1FfsJoetyIhwHVdmR86oJjftbOeKr
	3j/2LYjhC7ymKUL6My768kiSehEoqbi0+kSirK6aPRTn9Z+4Ee4uoyCF5KMCfhzogjMwH5
	upRt+JlPLHLdX/B9q514b8gBc5kH7ekEd2cvdQ33LgzPRYYLIAEV5w+PlfTvU9y5dMsln6
	dbAl9UTZGEtIXSDUguz9daG0YxW69Vk/oeiw9+wPByGyS2Zrz/eZjrfgN1RxKw6uZzJC0M
	9eBY75EBUm6CMHTvhq6+AidmLTkX1HKzWZL88fDHkZTNCJmsHWiZwKlRsvWRTw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739097575; a=rsa-sha256;
	cv=none;
	b=KOl7Bf01802qaKjP55YzcYhdxlmDgIzGPjTLXM+pBFSIIE4hFoD8MHRObnfGUw7IvJuGVk
	y7z5HWfFC2VM2wEvafhoCysCUDVk3Xvny4VuvgSxFGLLqM2YFdJI0KqZ+2YwOZYN/pQZdM
	hOIuavXyz4jMI11cg9yDroreY+UzDr8xdB/HtOU5rffgtKnmCUVDqr9Vl/257Fu4NWoGqd
	IJLf6+WcDJAysmOCWtBvefNhx3U6+mpxp1hTVEJT72MoAwfqMu4k38ds8jLKcEl1HW/xdz
	hHDfdp3Rf8fddLK3MnvUYc7DaUSwJPjXaKrLnOZJkFzxx2FNq6jB8Me0Rg9UeQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739097575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SDcfYIgWirj2irWZu5yqgLL8XZKsytvOPvE0gOE+0Zo=;
	b=lZ1kN3rq4LzA/HJ0Q4iT6EDJUJ02hDsTkyx3dmhxehPhshzhdKOvbl+R+YlHsIZ2yTbUWv
	EmAc70t+GUDFh4vYOiPdD4QhyX2v+63qRdBp+qTVJk5RIMqX5O6wSqntjlPHx03bkqfLlZ
	3CeB+5dcZC/xwaO1JKzja6uLekrIPzbsx6VP+9tOcH/rXLRSbZSVqf0REpODgQT5Dz7mZ3
	kPOGI+CQ4k9BK1PY0jiAOwqr/ZP4GrU4z13PWgdNXg441KeOVR79Z4FQhLcmCJJR/i6sWD
	J2mR2ZOxVz8D77RPszvhO32pgaSEy0l4qGNE1HcNmV01QVdkkT/2HHDkTgmRsw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH v3 3/5] Bluetooth: ISO: add TX timestamping
Date: Sun,  9 Feb 2025 12:39:15 +0200
Message-ID: <f3f0fa8615fbfebbf58212bd407e51579f85412a.1739097311.git.pav@iki.fi>
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

Add BT_SCM_ERROR socket CMSG type.

Support TX timestamping in ISO sockets.

Support MSG_ERRQUEUE in ISO recvmsg.

If a packet from sendmsg() is fragmented, only the first ACL fragment is
timestamped.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/iso.c               | 24 ++++++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 435250c72d56..bbefde319f95 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -156,6 +156,7 @@ struct bt_voice {
 #define BT_PKT_STATUS           16
 
 #define BT_SCM_PKT_STATUS	0x03
+#define BT_SCM_ERROR		0x04
 
 #define BT_ISO_QOS		17
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 44acddf58a0c..f497759a2af5 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -518,7 +518,8 @@ static struct bt_iso_qos *iso_sock_get_qos(struct sock *sk)
 	return &iso_pi(sk)->qos;
 }
 
-static int iso_send_frame(struct sock *sk, struct sk_buff *skb)
+static int iso_send_frame(struct sock *sk, struct sk_buff *skb,
+			  const struct sockcm_cookie *sockc)
 {
 	struct iso_conn *conn = iso_pi(sk)->conn;
 	struct bt_iso_qos *qos = iso_sock_get_qos(sk);
@@ -538,10 +539,12 @@ static int iso_send_frame(struct sock *sk, struct sk_buff *skb)
 	hdr->slen = cpu_to_le16(hci_iso_data_len_pack(len,
 						      HCI_ISO_STATUS_VALID));
 
-	if (sk->sk_state == BT_CONNECTED)
+	if (sk->sk_state == BT_CONNECTED) {
+		hci_setup_tx_timestamp(skb, 1, sockc);
 		hci_send_iso(conn->hcon, skb);
-	else
+	} else {
 		len = -ENOTCONN;
+	}
 
 	return len;
 }
@@ -1348,6 +1351,7 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb, **frag;
+	struct sockcm_cookie sockc;
 	size_t mtu;
 	int err;
 
@@ -1360,6 +1364,14 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
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
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_CONNECTED) {
@@ -1405,7 +1417,7 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	lock_sock(sk);
 
 	if (sk->sk_state == BT_CONNECTED)
-		err = iso_send_frame(sk, skb);
+		err = iso_send_frame(sk, skb, &sockc);
 	else
 		err = -ENOTCONN;
 
@@ -1474,6 +1486,10 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 
 	BT_DBG("sk %p", sk);
 
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return sock_recv_errqueue(sk, msg, len, SOL_BLUETOOTH,
+					  BT_SCM_ERROR);
+
 	if (test_and_clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
 		sock_hold(sk);
 		lock_sock(sk);
-- 
2.48.1


