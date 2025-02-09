Return-Path: <netdev+bounces-164422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478D1A2DC90
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 11:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DCB41886040
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 10:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DF518A959;
	Sun,  9 Feb 2025 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="dgIVmwdJ"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E014B086;
	Sun,  9 Feb 2025 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739097580; cv=pass; b=i3UNB36NGfo6tZsBrbxT0+ih90WzhAp+uQchd0FAZU/GgabnoX7q4tMNhe8qkBMEGttQ9olSosGwYioAqnNPSrN3kPfx1kULw5xD4ccAY201r83+GHQ9wHRhb8dBpGGeV3vTHvZSc8zkBWtx9EIn2bdHFzOPS3qNklzAb9hx0Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739097580; c=relaxed/simple;
	bh=yq+PxtCT1XEqM2tclX7zRW5AebbnVCT6qrTXaMIFDwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SE4yfdeYg5NICWaFXi60Jar8j5cXXL9LV5dB9dMI2I/2ur3YU0bdvj8E9McowWfBQh085qrT7Szymfnis/s796xiEkF0xRvZAeIiQLNVom/xNTlBAPKlrbpsRZXwLzY+DkvMg37LdGEjZGBKmftbhd1K6mUwNBGrgoaojNKqm70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=dgIVmwdJ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YrPN74Y20z49Q9m;
	Sun,  9 Feb 2025 12:39:35 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739097577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLdvqv6OII/Bb6c0yRVH3trjPIx8DvbHtZaJMHiBODQ=;
	b=dgIVmwdJqilunSC/MxUjdUPwD9LYyPLvB0SeZ190DNw/be3m0GExe9fD/X7QFeU6XakExH
	zzlM4YO9QVYe516cDvnRtLAoEIiDt6xFmuq/u621wF4cTtcNH4mFYVOfMA5JEgQOJ+fGeE
	1OWaZtK4iWzezi/p3UuiNadD0kSZsDUWI66nowOONARe/0OHbyJeFb8ULnSeGy1X77qTQ6
	fAOw9Q4Uav3JRAjIIx3xNI8AU7sZL67TDSQlXDA08u1r6i54t53Ldil3vVsJH0haZobyEE
	kOOCW0GWXpyPNcbO89NYHgcqKy1o7SOcKgIHNfWG9YMcbXX9UrIGeLynPNDpeA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739097577; a=rsa-sha256;
	cv=none;
	b=Lgedlsximf7oDGtAMh0DDjmvkY3YkUFKcLh9ierCHese8xjLt5mBKYFfE5SOIkSSFJVKyq
	KfqOOyaoYdesVBOFsXq+jNezirthCaZtdLXI35cyTmRRuQMiwhETUXK2dUOsPavP+lgIKL
	nzE9Ltfyi0IU2/aGVT6rmtgXUBlUBRwuWYmQNOHOqz3+wraWryVgTXb79hb2rvhTnlqcAX
	InblwU/5J1vl2IGZmLUJAt/qKFu0cQ47YDjTy8jMI/9+B8iBU+Qw9kjbhycO2Xi2+utOP4
	55hEj+1hMpLiUuBiVI55P2KtnYe5Gh5LjckJJ/2MmagGV+vlhkIEpUOHMKF62g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739097577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLdvqv6OII/Bb6c0yRVH3trjPIx8DvbHtZaJMHiBODQ=;
	b=SoRfRp/xcwmsXuYs61sF0VdMF6I/fraYCcm3kSisFLoZ6ZgiGb6Rt1rE7oxnGxVg4mwjLf
	OGRlgtkxU4pKECq0dyPZqRZl1NIFV4rXkBm+hZWi4HmAcgeTq61gahHgtzJCQAmo+RtbQ0
	18EsO6pK4GlqpHF4SvjTjjE+1cME61Ap5AaTBrgLBABOAL8cQKHimv8mJJCxICvWTTV0DK
	nF/oqAodpSuizgAzdG1HN0lYvd7RGP3hUrJb003GLi4QnLt4GlQI4AWKhS8sehzzhgjY8X
	UnXvDewEDWvjPLBP9gau0kNHupiFkZIyuuqzcJaEwSW7PPDmDUiOKtx9B2QWgQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH v3 4/5] Bluetooth: L2CAP: add TX timestamping
Date: Sun,  9 Feb 2025 12:39:16 +0200
Message-ID: <815b26d1780ee04095aaeff4f0d43e57b50d1a3f.1739097311.git.pav@iki.fi>
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
 include/net/bluetooth/l2cap.h |  3 ++-
 net/bluetooth/6lowpan.c       |  2 +-
 net/bluetooth/l2cap_core.c    | 41 ++++++++++++++++++++++++++++++++---
 net/bluetooth/l2cap_sock.c    | 15 ++++++++++++-
 net/bluetooth/smp.c           |  2 +-
 5 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 9189354c568f..00e182a22720 100644
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
index 50cfec8ccac4..0eb1ecb54105 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -443,7 +443,7 @@ static int send_pkt(struct l2cap_chan *chan, struct sk_buff *skb,
 	memset(&msg, 0, sizeof(msg));
 	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iv, 1, skb->len);
 
-	err = l2cap_chan_send(chan, &msg, skb->len);
+	err = l2cap_chan_send(chan, &msg, skb->len, NULL);
 	if (err > 0) {
 		netdev->stats.tx_bytes += err;
 		netdev->stats.tx_packets++;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6cdc1dc3a7f9..6865a0f51df5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2514,7 +2514,33 @@ static void l2cap_le_flowctl_send(struct l2cap_chan *chan)
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
@@ -2529,6 +2555,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
+		l2cap_tx_timestamp(skb, sockc, len);
+
 		l2cap_do_send(chan, skb);
 		return len;
 	}
@@ -2552,6 +2580,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 		if (err)
 			return err;
 
+		l2cap_tx_timestamp_seg(&seg_queue, sockc, len);
+
 		skb_queue_splice_tail_init(&seg_queue, &chan->tx_q);
 
 		l2cap_le_flowctl_send(chan);
@@ -2573,6 +2603,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
+		l2cap_tx_timestamp(skb, sockc, len);
+
 		l2cap_do_send(chan, skb);
 		err = len;
 		break;
@@ -2596,10 +2628,13 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
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
index acd11b268b98..92305530e2e5 100644
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
 
+	sockcm_init(&sockc, sk);
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
index 8b9724fd752a..f5e5c2f111b9 100644
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


