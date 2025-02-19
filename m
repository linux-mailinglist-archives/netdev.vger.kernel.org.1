Return-Path: <netdev+bounces-167818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA157A3C727
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 19:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52626176FC5
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF79215079;
	Wed, 19 Feb 2025 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Mtocu184"
X-Original-To: netdev@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27891A7264;
	Wed, 19 Feb 2025 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988839; cv=pass; b=hs5iI7cSO5cBhimErd2sExH8yn90W6PThs/Q325G9PPnutc1jt3OMzS0H4u5+nDuZtkaRe5SM3+9GS5CPraE2on5YYTOVCaCGYcgUgTh/hfFQXJ/kW6h4JuVPrrZoi1jUQsLPbsudSn9o+wc5ugb5l+Y8OMpvKHiMGBPkyUQVAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988839; c=relaxed/simple;
	bh=GMOpuX5O0bEAH+ufbo5j9uzfAKfWIhdHkgJ7JCrvrzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spJM5Lpemx1rja6wF/wpvZcfTYFcTwUiHDrR20G+80StOksDSgY8bhS+xzDsGIJdwbCzEc6IjP7bx0R1KvL1Poji2upnp8JUKrWF4dIVFqTLvmahgr1phlxuCIx5HrUinf+c948Tf1DH63OEpA3Ipej8mN2vXRlWoLdruylgiJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Mtocu184; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Yykzc5WQ2zyw5;
	Wed, 19 Feb 2025 20:13:48 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1739988829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uhk6IBfXIWvtMmYZPWsQhxkIF6lvx+Wp0N86/64DGCE=;
	b=Mtocu184Upj6GCPnsch33gRRcRvmXh4O+nfsTf620NiG54xPjBgvRkxqwhUrJbAQebo1T2
	UqwgbT5Oz8Pzas6Ol49JjqQ45lltpA0x2wJgNusNyFYCfr7qghvdDp362OLdpNLfdwTVNz
	mj88NTDjs1sZRCzytpaNxV5f+VtztOg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1739988829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uhk6IBfXIWvtMmYZPWsQhxkIF6lvx+Wp0N86/64DGCE=;
	b=Z0iEuX0dP/f96hUGm3Q9CvvaR12I93FZa7fXXZ9PQBQjNH5DWT6Rqhlrt4zkgI4g4Z09xh
	qqzn1SO+GPtflFS7/CjRkVA3nroZ0xSad+nKOMK0cHaMFDCUQiuB19JKaNfUEVbCILOT0l
	de9g/x8Usvw2/GCZz5JASqfm4koZVEU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1739988829; a=rsa-sha256; cv=none;
	b=TIq6vBsc+y11K4xuT/IkpWG6V7nnk62vEPfpDp76vtvKovlCW5w12Oqb60XRTtOMJcIZ5/
	ZYBc2aH3RXESugrHk47b0mrA8IUXbk6zbp/NVWfL6Y5s+Ak+Yv7o25WuUk2S3P2Ka5nDah
	rKeXsy3EJ7FsBBJYisHhsAW6kYCSiJc=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH v4 2/5] Bluetooth: add support for skb TX SND/COMPLETION timestamping
Date: Wed, 19 Feb 2025 20:13:34 +0200
Message-ID: <5daf2ca1670d4ad0f7f319469fec7850992fb4a9.1739988644.git.pav@iki.fi>
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

Support enabling TX timestamping for some skbs, and track them until
packet completion. Generate software SCM_TSTAMP_COMPLETION when getting
completion report from hardware.

Generate software SCM_TSTAMP_SND before sending to driver. Sending from
driver requires changes in the driver API, and drivers mostly are going
to send the skb immediately.

Make the default situation with no COMPLETION TX timestamping more
efficient by only counting packets in the queue when there is nothing to
track.  When there is something to track, we need to make clones, since
the driver may modify sent skbs.

The tx_q queue length is bounded by the hdev flow control, which will
not send new packets before it has got completion reports for old ones.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v4: coupled COMPLETION & SND

 include/net/bluetooth/hci_core.h |  13 ++++
 net/bluetooth/hci_conn.c         | 118 +++++++++++++++++++++++++++++++
 net/bluetooth/hci_core.c         |  17 +++--
 net/bluetooth/hci_event.c        |   4 ++
 4 files changed, 147 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 05919848ea95..1f539a9881ad 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -261,6 +261,12 @@ struct adv_info {
 	struct delayed_work	rpa_expired_cb;
 };
 
+struct tx_queue {
+	struct sk_buff_head queue;
+	unsigned int extra;
+	unsigned int tracked;
+};
+
 #define HCI_MAX_ADV_INSTANCES		5
 #define HCI_DEFAULT_ADV_DURATION	2
 
@@ -733,6 +739,8 @@ struct hci_conn {
 	struct sk_buff_head data_q;
 	struct list_head chan_list;
 
+	struct tx_queue tx_q;
+
 	struct delayed_work disc_work;
 	struct delayed_work auto_accept_work;
 	struct delayed_work idle_work;
@@ -1571,6 +1579,11 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active);
 void hci_conn_failed(struct hci_conn *conn, u8 status);
 u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle);
 
+void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb);
+void hci_conn_tx_dequeue(struct hci_conn *conn);
+void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
+			    const struct sockcm_cookie *sockc);
+
 /*
  * hci_conn_get() and hci_conn_put() are used to control the life-time of an
  * "hci_conn" object. They do not guarantee that the hci_conn object is running,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d097e308a755..f09206155456 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -27,6 +27,7 @@
 
 #include <linux/export.h>
 #include <linux/debugfs.h>
+#include <linux/errqueue.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -1002,6 +1003,7 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t
 	}
 
 	skb_queue_head_init(&conn->data_q);
+	skb_queue_head_init(&conn->tx_q.queue);
 
 	INIT_LIST_HEAD(&conn->chan_list);
 	INIT_LIST_HEAD(&conn->link_list);
@@ -1155,6 +1157,7 @@ void hci_conn_del(struct hci_conn *conn)
 	}
 
 	skb_queue_purge(&conn->data_q);
+	skb_queue_purge(&conn->tx_q.queue);
 
 	/* Remove the connection from the list and cleanup its remaining
 	 * state. This is a separate function since for some cases like
@@ -3064,3 +3067,118 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	 */
 	return hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
 }
+
+void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
+			    const struct sockcm_cookie *sockc)
+{
+	struct sock *sk = skb ? skb->sk : NULL;
+
+	/* This shall be called on a single skb of those generated by user
+	 * sendmsg(), and only when the sendmsg() does not return error to
+	 * user. This is required for keeping the tskey that increments here in
+	 * sync with possible sendmsg() counting by user.
+	 *
+	 * Stream sockets shall set key_offset to sendmsg() length in bytes
+	 * and call with the last fragment, others to 1 and first fragment.
+	 */
+
+	if (!skb || !sockc || !sk || !key_offset)
+		return;
+
+	sock_tx_timestamp(sk, sockc, &skb_shinfo(skb)->tx_flags);
+
+	if (sockc->tsflags & SOF_TIMESTAMPING_OPT_ID &&
+	    sockc->tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
+		if (sockc->tsflags & SOCKCM_FLAG_TS_OPT_ID) {
+			skb_shinfo(skb)->tskey = sockc->ts_opt_id;
+		} else {
+			int key = atomic_add_return(key_offset, &sk->sk_tskey);
+
+			skb_shinfo(skb)->tskey = key - 1;
+		}
+	}
+}
+
+void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb)
+{
+	struct tx_queue *comp = &conn->tx_q;
+	bool track = false;
+
+	/* Emit SND now, ie. just before sending to driver */
+	if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
+		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SND);
+
+	/* COMPLETION tstamp is emitted for tracked skb later in Number of
+	 * Completed Packets event. Available only for flow controlled cases.
+	 *
+	 * TODO: SCO support (needs to be done in drivers)
+	 */
+	switch (conn->type) {
+	case ISO_LINK:
+	case ACL_LINK:
+	case LE_LINK:
+		break;
+	default:
+		return;
+	}
+
+	if (skb->sk && (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP) &&
+	    READ_ONCE(skb->sk->sk_tsflags) & SOF_TIMESTAMPING_TX_COMPLETION)
+		track = true;
+
+	/* If nothing is tracked, just count extra skbs at the queue head */
+	if (!track && !comp->tracked) {
+		comp->extra++;
+		return;
+	}
+
+	if (track) {
+		skb = skb_clone_sk(skb);
+		if (!skb)
+			goto count_only;
+
+		comp->tracked++;
+	} else {
+		skb = skb_clone(skb, GFP_KERNEL);
+		if (!skb)
+			goto count_only;
+	}
+
+	skb_queue_tail(&comp->queue, skb);
+	return;
+
+count_only:
+	/* Stop tracking skbs, and only count. This will not emit timestamps for
+	 * the packets, but if we get here something is more seriously wrong.
+	 */
+	comp->tracked = 0;
+	comp->extra += skb_queue_len(&comp->queue) + 1;
+	skb_queue_purge(&comp->queue);
+}
+
+void hci_conn_tx_dequeue(struct hci_conn *conn)
+{
+	struct tx_queue *comp = &conn->tx_q;
+	struct sk_buff *skb;
+
+	/* If there are tracked skbs, the counted extra go before dequeuing real
+	 * skbs, to keep ordering. When nothing is tracked, the ordering doesn't
+	 * matter so dequeue real skbs first to get rid of them ASAP.
+	 */
+	if (comp->extra && (comp->tracked || skb_queue_empty(&comp->queue))) {
+		comp->extra--;
+		return;
+	}
+
+	skb = skb_dequeue(&comp->queue);
+	if (!skb)
+		return;
+
+	if (skb->sk) {
+		comp->tracked--;
+		__skb_tstamp_tx(skb, NULL, NULL, skb->sk,
+				SCM_TSTAMP_COMPLETION);
+	}
+
+	kfree_skb(skb);
+}
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e7ec12437c8b..e0845188f626 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3025,6 +3025,13 @@ static int hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+static int hci_send_conn_frame(struct hci_dev *hdev, struct hci_conn *conn,
+			       struct sk_buff *skb)
+{
+	hci_conn_tx_queue(conn, skb);
+	return hci_send_frame(hdev, skb);
+}
+
 /* Send HCI command */
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 		 const void *param)
@@ -3562,7 +3569,7 @@ static void hci_sched_sco(struct hci_dev *hdev)
 	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(hdev, skb);
+			hci_send_conn_frame(hdev, conn, skb);
 
 			conn->sent++;
 			if (conn->sent == ~0)
@@ -3586,7 +3593,7 @@ static void hci_sched_esco(struct hci_dev *hdev)
 						     &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(hdev, skb);
+			hci_send_conn_frame(hdev, conn, skb);
 
 			conn->sent++;
 			if (conn->sent == ~0)
@@ -3620,7 +3627,7 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 			hci_conn_enter_active_mode(chan->conn,
 						   bt_cb(skb)->force_active);
 
-			hci_send_frame(hdev, skb);
+			hci_send_conn_frame(hdev, chan->conn, skb);
 			hdev->acl_last_tx = jiffies;
 
 			hdev->acl_cnt--;
@@ -3676,7 +3683,7 @@ static void hci_sched_le(struct hci_dev *hdev)
 
 			skb = skb_dequeue(&chan->data_q);
 
-			hci_send_frame(hdev, skb);
+			hci_send_conn_frame(hdev, chan->conn, skb);
 			hdev->le_last_tx = jiffies;
 
 			(*cnt)--;
@@ -3710,7 +3717,7 @@ static void hci_sched_iso(struct hci_dev *hdev)
 	while (*cnt && (conn = hci_low_sent(hdev, ISO_LINK, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(hdev, skb);
+			hci_send_conn_frame(hdev, conn, skb);
 
 			conn->sent++;
 			if (conn->sent == ~0)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2cc7a9306350..144b442180f7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4405,6 +4405,7 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 		struct hci_comp_pkts_info *info = &ev->handles[i];
 		struct hci_conn *conn;
 		__u16  handle, count;
+		unsigned int i;
 
 		handle = __le16_to_cpu(info->handle);
 		count  = __le16_to_cpu(info->count);
@@ -4415,6 +4416,9 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 
 		conn->sent -= count;
 
+		for (i = 0; i < count; ++i)
+			hci_conn_tx_dequeue(conn);
+
 		switch (conn->type) {
 		case ACL_LINK:
 			hdev->acl_cnt += count;
-- 
2.48.1


