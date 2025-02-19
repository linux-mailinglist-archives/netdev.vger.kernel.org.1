Return-Path: <netdev+bounces-167815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB3A3C725
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 19:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CED3B0F1B
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C179B214A90;
	Wed, 19 Feb 2025 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="gItkgGAR"
X-Original-To: netdev@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F220B2144CE;
	Wed, 19 Feb 2025 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988836; cv=pass; b=Rz+vTI8mkLUB3MxK7xed4TA2nUD7axMZSDmvlWNgigeioXiN4cqrRIgczncX28pB3QjXfNJM49BHAXOIDwp2WXjala9dk0K0txHROvNO1FznxgQq/wsnNKDJWRAJKMHWKT2foc7YIGRXCZ0FAlfur6wNyrVFuaHXRd4kszhTGCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988836; c=relaxed/simple;
	bh=HSFaJJqu3GoePGcxgys65r8yGgY1ywVhXIhQs2IKWdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c56j9+3XbLvIyXkrFcG8chrVrKySEW4iPeLFWtY07kYRyLA8sNin2GNSOTjr/R0pJ8TKzU73WUE7ZP9kBsfWXPb9EfUy4wY2EFzZBsmdxuP67wO4Cf/L2X0wwGTye2Rq7s+dbhMd4azUYzHfS/uF7ongXh1t7xqhd1FLjnPAJJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=gItkgGAR; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Yykzg6v8lz104S;
	Wed, 19 Feb 2025 20:13:51 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1739988833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CdGQ9Qt2yIFp0o61zDWGYrcwevLbsfdetIovOGDGsJI=;
	b=gItkgGAR+qhgt1HZGWwxTE0StYkMjnrh8WdnprJfbjzkYGfEW4LJWhfS0PjRM/N3dYf5D9
	yeGSRT92MBxiosmMGIFi3uMCk0qOpjdXybgtzMTqgTvCsBjKLcQVrCJqPutUcq2yvFNFVu
	DWg/ykLcQbgsMANk0VBg/e5wcWj2rhQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1739988833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CdGQ9Qt2yIFp0o61zDWGYrcwevLbsfdetIovOGDGsJI=;
	b=TijBdP+MJqpDwYPa4jKSH0qDZRrjY+TkbrudARxEiUqllAKPD8PDNo3pci3eFZLP5+zv03
	aEf7L60Spnc0X0ftF2m6Ix8JI/pBeAil/fU+hZj0P/rassxyN3kMF4EffwhV7WQnyFOtld
	Ohld8RXIfiMlcHg6dMF6VFzvKZAt92A=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1739988833; a=rsa-sha256; cv=none;
	b=H/JDI5SOQkefkWUT11qZLuNuE9ulEaZhtI5CF2NJ0bxMGEAfty2LuJABHeqV38EkIkB84v
	qMSb7YGhBGsLQkHm93IOwkfMfIlWWllp0QuQ6h1kbVM11Iq/E7nL1zq2aYYatLoCxWzSOl
	9TsbD0Gz6C1sMrmegHRKDF0OPNmkNf4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH v4 4/5] Bluetooth: L2CAP: add TX timestamping
Date: Wed, 19 Feb 2025 20:13:36 +0200
Message-ID: <3c625adab75d7b07d2a6e5705de970e0d8ddb399.1739988644.git.pav@iki.fi>
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
    v4: no changes

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
index fec11e576f31..56a36e872e7b 100644
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


