Return-Path: <netdev+bounces-167813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4561BA3C71A
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 19:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570FA1886B61
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80E7214817;
	Wed, 19 Feb 2025 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="LiV51oB/"
X-Original-To: netdev@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D15E1AC88B;
	Wed, 19 Feb 2025 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988835; cv=pass; b=uUKquAq7B8wrHWGVFJ/f8WWdX0h/xzHrxDNyQDOeOW7Hfpy9zEwbpMtVyujUPPPIKqzSib/U6QM3jy2wFcdSmbY4CcWxRZkDlxbYWWVpsttzy9b5ryZhoAv0BOg5+ApE/2XiZZ2W1UxwQv/5Zm0LKgTNsSzD/RifqomWCVTNaaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988835; c=relaxed/simple;
	bh=OZH7kTm8/KswgBdIM6QM91MfGzhUfImkC8LHhnSfU/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpU0kh+ohDPh3PjSBBP5yUfrK/elGvzv2H4+52aF0DpcI59mXGY0s/7DzN20jXRseNULu4WG4tOB0b/t1LY1caplPUaaWwASH7fCbqhi/YHLMpDV6/pKSpWZ1EXGydYVR9NKCRWiFJ32ING2Ebvf35wrQKD5+j3uWu632F+2mns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=LiV51oB/; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Yykzf20ngz102v;
	Wed, 19 Feb 2025 20:13:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1739988831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8L4/5XoOJkThlJm4nTKqNeqJshEiSJlOG+4iUlWNVQ0=;
	b=LiV51oB/RCUFg+RVJ+KMLs0/XbqHhW6PzOsn0yt0fWTPVfKvif/yIdyDCQmMN+MEAceLpu
	+TaV7VlYD/SMcvDPGASZCy+gWD3Rb01bju9Q2UbIhHh6bYT14vdUe8IMNEU3SVxeXKc0Yq
	H6NDAVJQD7x8vPe0Qmf+tgHyeQvRcsw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1739988831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8L4/5XoOJkThlJm4nTKqNeqJshEiSJlOG+4iUlWNVQ0=;
	b=Z6CwBVb8dgZAGh9sCchwXPmwhi2d3WaSCQalSp2ryGjBPIGpKAdlfbq5/jE7yOOzcOePbd
	DZgl3DMYpY8VVEvgMjlAqvbmMZk2BOT0dkOn5i6uGgHTpIqy303wN46J09DqPlc5YcxR2Z
	QcGEcH/yCdjKzs9F1Umv6i5YhoL2aUg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1739988831; a=rsa-sha256; cv=none;
	b=m/3Y9kqTUyTFJDPYiLq3NI6PQz2cmTditLF8D8UaiC1Nw69DS63dwPwmCklegwmKUdTdFm
	WCdY0AJ1e3p/XFB3aV6Z6RavTjH6HSlr3YOqtO41IIzIdv5EZNPwZD5ZPpnl23jyekE8RZ
	4KcGXLT18FN/cspeK9t+FfbkJWhV/L4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH v4 3/5] Bluetooth: ISO: add TX timestamping
Date: Wed, 19 Feb 2025 20:13:35 +0200
Message-ID: <79e7f7ff1b31a45022cbd2fbb4252add9c17e4c2.1739988644.git.pav@iki.fi>
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

Add BT_SCM_ERROR socket CMSG type.

Support TX timestamping in ISO sockets.

Support MSG_ERRQUEUE in ISO recvmsg.

If a packet from sendmsg() is fragmented, only the first ACL fragment is
timestamped.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v4: no changes

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


