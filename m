Return-Path: <netdev+bounces-175864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9F0A67CC2
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B8618866F1
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 19:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5EF214A65;
	Tue, 18 Mar 2025 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="r/y2PBVn"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC6F214219;
	Tue, 18 Mar 2025 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324825; cv=pass; b=nmlWlrgE6dN518qeBtW4H7avaBryaCmpGk1JSPGEA2LuZ3dXtq5nlaCpuQi8CHkY/noc1goDl8hf0m6N1rMHy0GsCfY5+MLH8WJlXX163Y5zAZd9y2caEvfgKC56oUP9LES5+9/REZJhc3Wi/zQytNltqqFD50Aquw99iqK+p+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324825; c=relaxed/simple;
	bh=tRVFNTsKojc/50B4DgS9Ojfr39Wt/kh13HKvLIzdgBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGlNd8vbkibe5ZmsXB0h1UoWoOlhAIhjCjy0Jz91RT8ZHXXOzgj3rGRXqoH3Ft1IqCsFAJC95z9F3R4xOwQ+hOnCevxQm8FTNnoqQHBQM5zZenA6VEktcMflbeVKc9hKpy1gVrGNk8QDtgO3a5LUZCY8W8kzHUUDyyhzs79P9L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=r/y2PBVn; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZHLtS6Z3Cz49Q76;
	Tue, 18 Mar 2025 21:06:56 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1742324817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uW1ii6STbnODF+dVT4csyhHMUsgD2VcN1KW2DqhZkk8=;
	b=r/y2PBVnWqFZ2imqX1+f5oEAhDzUDuBojlfvbLtMgHobYOeGAeNO07r2D2zyBHsLK8RtIa
	zyhvMcj/muDZtj12Pga+SvZRQmT5nqGP7LrDhCkRcTquLZ3i5zfhJEKyZL3+YcmOfif2cZ
	7TRj/Kc6tkRkzmnyD2zosXRiC3IVTQzutUdgcL7n6aPkLAAnkWNrmKGijJnyw4PimQbLbU
	p5WR1aCVWf+6X9A4tTQlMbwbeTuHQNfbWcD6L3pUC17bHzlpGq26jCGAJFNPL8Cmx81eOt
	2XOmhifY2bI/0dCBEWaKCgzGpONEqTPeLvMhL3IHx+bUIFgxfcHJPD0GqvbOTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1742324817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uW1ii6STbnODF+dVT4csyhHMUsgD2VcN1KW2DqhZkk8=;
	b=Yw2yclYwSBv8pkQTb3ajIja+oSDnaWj2zxBNZRGxwvCQRbdsT7shkeYgdZ6oeyE9MN4naC
	4FXO0jtbIIq27Tl90P11hKhRqnmsOo4L02p1YZNsWcGyNq8aqR3os4ZFnbLFKMkTQyqhX2
	cHLU1r6hj0PFyoMagfdZGjqzPwTMdrCg5CWszw7Fk/qYBI/x32Et9vdFg78daRyKNgn8NC
	30GkReF4bBxfWyIzsCvRpBkz5MDpxjM+JYLduNZz3+36A6A9g+lz7XtvEmcTQQQG3SKi9O
	UFziL9cW/Fzx/9HWK3WStdXqrqVDMecBqyvw8qWFeZho+jnn3MO0fI2BETLeOw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1742324817; a=rsa-sha256;
	cv=none;
	b=G6kUKFm6UESeJD8g6TZuJxxRncEgphl4h91fT8PASwuk8ZPvH+o3QzW8KjdS05wbFogL7m
	gFWv6MGuaMrD3Jn+CVsHOHVP1oaPRVXqoysllerXbp5NWbyAscOgMPNRaBMkXuRrC4/d8f
	RlvCBigPEzx0xreTRCOMZ0udHg3F99gwiM6sbd8UZHJsdQjG2qZRt7Bg4LR2BU9uBBn/eN
	X0sTo07VtYmsyxGzqKaLKRCgbJyerokV+N+qDLeResP53cQ0nZHyJIGKwW04L+Jp0rtHA3
	tJNxYC76k8vUJPmwK1ULBGEoPyDUscWHC9YEGXQv0xAi9hxg1uIzkSuPw8RY6A==
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
Subject: [PATCH v5 4/5] Bluetooth: L2CAP: add TX timestamping
Date: Tue, 18 Mar 2025 21:06:45 +0200
Message-ID: <4c97d14963e4007d46e32409fdfed8273bd8b5ba.1742324341.git.pav@iki.fi>
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

Support TX timestamping in L2CAP sockets.

Support MSG_ERRQUEUE recvmsg.

For other than SOCK_STREAM L2CAP sockets, if a packet from sendmsg() is
fragmented, only the first ACL fragment is timestamped.

For SOCK_STREAM L2CAP sockets, use the bytestream convention and
timestamp the last fragment and count bytes in tskey.

Timestamps are not generated in the Enhanced Retransmission mode, as
meaning of COMPLETION stamp is unclear if L2CAP layer retransmits.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v5:
    - use sockcm_init -> hci_sockcm_init

 include/net/bluetooth/l2cap.h |  3 ++-
 net/bluetooth/6lowpan.c       |  2 +-
 net/bluetooth/l2cap_core.c    | 41 ++++++++++++++++++++++++++++++++---
 net/bluetooth/l2cap_sock.c    | 15 ++++++++++++-
 net/bluetooth/smp.c           |  2 +-
 5 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0bf8cb17a6e8..4bb0eaedda18 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -955,7 +955,8 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason);
 int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		       bdaddr_t *dst, u8 dst_type, u16 timeout);
 int l2cap_chan_reconfigure(struct l2cap_chan *chan, __u16 mtu);
-int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
+int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
+		    const struct sockcm_cookie *sockc);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail);
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 73530b8e1eae..f0c862091bff 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -444,7 +444,7 @@ static int send_pkt(struct l2cap_chan *chan, struct sk_buff *skb,
 	memset(&msg, 0, sizeof(msg));
 	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iv, 1, skb->len);
 
-	err = l2cap_chan_send(chan, &msg, skb->len);
+	err = l2cap_chan_send(chan, &msg, skb->len, NULL);
 	if (err > 0) {
 		netdev->stats.tx_bytes += err;
 		netdev->stats.tx_packets++;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7b4adab353cf..c7b66b2ea9f2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2515,7 +2515,33 @@ static void l2cap_le_flowctl_send(struct l2cap_chan *chan)
 	       skb_queue_len(&chan->tx_q));
 }
 
-int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
+static void l2cap_tx_timestamp(struct sk_buff *skb,
+			       const struct sockcm_cookie *sockc,
+			       size_t len)
+{
+	struct sock *sk = skb ? skb->sk : NULL;
+
+	if (sk && sk->sk_type == SOCK_STREAM)
+		hci_setup_tx_timestamp(skb, len, sockc);
+	else
+		hci_setup_tx_timestamp(skb, 1, sockc);
+}
+
+static void l2cap_tx_timestamp_seg(struct sk_buff_head *queue,
+				   const struct sockcm_cookie *sockc,
+				   size_t len)
+{
+	struct sk_buff *skb = skb_peek(queue);
+	struct sock *sk = skb ? skb->sk : NULL;
+
+	if (sk && sk->sk_type == SOCK_STREAM)
+		l2cap_tx_timestamp(skb_peek_tail(queue), sockc, len);
+	else
+		l2cap_tx_timestamp(skb, sockc, len);
+}
+
+int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
+		    const struct sockcm_cookie *sockc)
 {
 	struct sk_buff *skb;
 	int err;
@@ -2530,6 +2556,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
+		l2cap_tx_timestamp(skb, sockc, len);
+
 		l2cap_do_send(chan, skb);
 		return len;
 	}
@@ -2553,6 +2581,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 		if (err)
 			return err;
 
+		l2cap_tx_timestamp_seg(&seg_queue, sockc, len);
+
 		skb_queue_splice_tail_init(&seg_queue, &chan->tx_q);
 
 		l2cap_le_flowctl_send(chan);
@@ -2574,6 +2604,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
+		l2cap_tx_timestamp(skb, sockc, len);
+
 		l2cap_do_send(chan, skb);
 		err = len;
 		break;
@@ -2597,10 +2629,13 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 		if (err)
 			break;
 
-		if (chan->mode == L2CAP_MODE_ERTM)
+		if (chan->mode == L2CAP_MODE_ERTM) {
+			/* TODO: ERTM mode timestamping */
 			l2cap_tx(chan, NULL, &seg_queue, L2CAP_EV_DATA_REQUEST);
-		else
+		} else {
+			l2cap_tx_timestamp_seg(&seg_queue, sockc, len);
 			l2cap_streaming_send(chan, &seg_queue);
+		}
 
 		err = len;
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index acd11b268b98..5aa55fa69594 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1106,6 +1106,7 @@ static int l2cap_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	struct sockcm_cookie sockc;
 	int err;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
@@ -1120,6 +1121,14 @@ static int l2cap_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (sk->sk_state != BT_CONNECTED)
 		return -ENOTCONN;
 
+	hci_sockcm_init(&sockc, sk);
+
+	if (msg->msg_controllen) {
+		err = sock_cmsg_send(sk, msg, &sockc);
+		if (err)
+			return err;
+	}
+
 	lock_sock(sk);
 	err = bt_sock_wait_ready(sk, msg->msg_flags);
 	release_sock(sk);
@@ -1127,7 +1136,7 @@ static int l2cap_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		return err;
 
 	l2cap_chan_lock(chan);
-	err = l2cap_chan_send(chan, msg, len);
+	err = l2cap_chan_send(chan, msg, len, &sockc);
 	l2cap_chan_unlock(chan);
 
 	return err;
@@ -1168,6 +1177,10 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	int err;
 
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return sock_recv_errqueue(sk, msg, len, SOL_BLUETOOTH,
+					  BT_SCM_ERROR);
+
 	lock_sock(sk);
 
 	if (sk->sk_state == BT_CONNECT2 && test_bit(BT_SK_DEFER_SETUP,
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index a31c6acf1df2..47f359f24d1f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -608,7 +608,7 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 
 	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, iv, 2, 1 + len);
 
-	l2cap_chan_send(chan, &msg, 1 + len);
+	l2cap_chan_send(chan, &msg, 1 + len, NULL);
 
 	if (!chan->data)
 		return;
-- 
2.48.1


