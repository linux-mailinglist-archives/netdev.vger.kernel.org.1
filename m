Return-Path: <netdev+bounces-175860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD35A67CB9
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D0D4243B0
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 19:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E64D21422C;
	Tue, 18 Mar 2025 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="u1SmbPA3"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974A2135DD;
	Tue, 18 Mar 2025 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324821; cv=pass; b=GcX/Z/6RkOwxge5cxuvVF2Q9k/VpwVmCoaik5r5BbUGHCixAKpAOCmnezQa8kRpqmouH6GHCSXpfNUqOUX2l1HIq9hdmsRq8vMtnL977mmDhOy1ln42r4Bz7so4nNvwVU4awFI0OIZVLhjdbYxiCOg5FZdVjRNbMQEHHc54Boz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324821; c=relaxed/simple;
	bh=q70UAXhsENkm9ZeXmtS2XijVh5iSYWo7ckxIbMjrRH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9qCTI1sZlf1iRbRUOJGCfOBAAlVIg+HAsPdGcSwTHYxaySHFk5fZxXxWKa5fRmdnjHCRVBCBB6NrTKS1ktdjcNVDA42NbGk3bWA9LkWrb5XX6nkRcoUUcWf4n235kxtyem6fsmK7P9ZYxgTeOPDL9bc+xLVVSK42UBOtslycxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=u1SmbPA3; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZHLtR4rFYz49Q6T;
	Tue, 18 Mar 2025 21:06:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1742324816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+AxRvhWzK8Bfth2Uhhm+w7hR/Z5mABCOIn/69HeMbQ=;
	b=u1SmbPA3jbAH9ZxJfNzJilgsZg1ZgmeNnLp0Y6TMTm7saWtqmZCnN5+rm7vQjE8uDL0GGW
	DvZMHkWegpK480xwyhONxT/lDaQvGJFjDo0B9xfyVBPDgM/KK3T0aMhxySPtmPKR/7ZPjQ
	cLX2dpeUHzCgAxacG2hh0clB1YfbMKHFFvGWd+Gz6ZPnr7QaLcRhyikblcUOAX33w9NwRb
	Jayj3OlHHQzIe+Lua9YU1jyireiAsyUczH+YWwt5y/8wm/bqKV2tHKGRjstincDw25/GnZ
	BBXaKPuJwmTAFFHckOEYuKyoxNfi5CuWCPXNJtPVaEhoA8W61PO8c6uXER5jvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1742324816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+AxRvhWzK8Bfth2Uhhm+w7hR/Z5mABCOIn/69HeMbQ=;
	b=QznujIy+EqYO2vZAZdxuteyssZYpyQvIqOS/9FkNSJzLMWWFuwzxQlw3uQBUHMq1Pxxavy
	kGMskjxRonyEGRQQXjmHWAWBQYQC/4uNfgsDO2zoJGrCeVyC2V9dPESZfNK7oSmYvAwQZJ
	L9yD7U9GKuvZAqB8h/2U8tXAdMA0/aI4xPyw9VRKilssmOt6mLaHZUZnnJc4cq6hZR//ak
	O0E4uQSyHLJAf+XIPMg2WR8SO9WCw36daG7icThmRT0WxWexgnLT8+IfArka3Ace3EJcu3
	v1cbYADxqJjom3WCa8LQbyOJBuvaT2A6UAVs2ulKcGRi3cnfUR31H50gzFlIVg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1742324816; a=rsa-sha256;
	cv=none;
	b=JyL+djjeyL5qS3KcInAhp0RtQU+nmIeMtFQYhumIjcPSV6e7dhLSuVoYw/TyR3Qnxt03jN
	jGYcJ6ytO1MX0Nr2fmcdC4Vza1TpzbwovGEO8OgUUOdTtMGCdyOrMvAAzZmpqoifbPyyta
	YtKqrc94mvymm+WtJQxfqlsWC8YEEKCyLdd0z3FCYGzEdsRJFtBmNisPl1gycmIAdc9QoG
	JBx58zGKRzFaEcqHiJRr5joAx16KTDbY/6inABCaBkHST47hqpLEMpJdabbM8Kav4hKVuo
	ENZMSUE+OW05m7j5yiGAIlnaTbH4+PrwDxE323iIpxtodIGs1S+KeHRvMjbhfA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH v5 3/5] Bluetooth: ISO: add TX timestamping
Date: Tue, 18 Mar 2025 21:06:44 +0200
Message-ID: <af69c75a4d38e42bb11b344defc96adc5f703357.1742324341.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742324341.git.pav@iki.fi>
References: <cover.1742324341.git.pav@iki.fi>
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

Notes:
    v5:
    - use sockcm_init -> hci_sockcm_init

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
index 0cb52a3308ba..3501a991f1c6 100644
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
 
+	hci_sockcm_init(&sockc, sk);
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


