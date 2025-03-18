Return-Path: <netdev+bounces-175863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD8EA67CBF
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E6619C4A0A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 19:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E79214805;
	Tue, 18 Mar 2025 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="PWQv3dTk"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE721324D;
	Tue, 18 Mar 2025 19:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324824; cv=pass; b=D1fSkOaBPpFbG8DzFlCqHsvViZlw1BKTOsdCB9lCtrIHJ2zNguoPUVW++ru+rFEY1+zta8nJppaGIvUSsacFYqbW3ZWeqa823muS4FQCeo7EGE5bS9n/KBkwsrgXNB3ofxLEq4JuDtAYKCjImX8D8jyc49MYb7GSLtq8b36sUOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324824; c=relaxed/simple;
	bh=wPvrA1y8uUp1lKzoy4p2pXtLSy8dqiOIpk/y+m4Jtls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLoJJPnvJPSKXr+G0pkQtnkgBhUxpNipr66Oatkm2EkL+RGYMr0od6sloOTK3npuJiDaJkk8yT9BRQt59Enmtr44QL998Gtbpt3yrcURowqn+gaTHqEPsIEk1W3TscAdXFkRkxsrCNnGEtITaZW6ktN9LC+OzpeOskaXvOSZ3ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=PWQv3dTk; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZHLtQ36wMz49Q5h;
	Tue, 18 Mar 2025 21:06:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1742324815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzPouGS5qaPZCSN0s7wyNkaAzre/9QfFwJkVANQZ6pg=;
	b=PWQv3dTk4FAca6xn+7kefQGdkNbOOKZI9VIh45cGN/66w0+qbfLB2ai1MoqyyTWLTJBTGy
	A2iMVNS28fIWx2mkcmay2y6ee8SUj9sHyVcMbQk3DuWzBHtla0Sd33Dsdv9PJIL+LLU3PU
	ISG1ftlk3/c5rH7a1unsx+q0iMZfEpfnWDLLFRZ6Sp5K34VcQinxvflMflOWCd7kc67Ipr
	vXq/a/kqNAjE+smqRkCUfQJgt9N39cSqGA/+bkX2J0JeLRSOk8bdLPhUU9EI+6uE8QTY5b
	EUai0WxNhUwKA7e2wTWXeTnkDVPKEATSSIR49ZU/jnHZY+tEsjmXNV8B/CWt5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1742324815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzPouGS5qaPZCSN0s7wyNkaAzre/9QfFwJkVANQZ6pg=;
	b=kH0GuL2LflwUl6MshMPQ5oYVzUavigRhu+e7gJxSiJCtJkwSN5A5lpLm+CQJqwwgaxBvRJ
	PMb94eAFnWUf8Q04ykWO9A0WteDuNMnbQ9MhcDtuTMn1IgP4+vTzC9Sif7b7ZBNQ6i775F
	jYjOKi6CzEVcwc03zBT3DGx4bjtntliE8cnzu8I0jmDqNWI1HhG+pg/Qhi7GUfU8mPCAVj
	qtgwWu++8GPk8p5H+930asgGNWbSHJANWGgKky5/d9NZLnedtpqY0HmB2gKNNehshBemC4
	BbAMr+jHSRSDFW1DWhl28ZrG9/PCmG+r2phGhQzvF80SAq6DHykfSybJAOD3rg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1742324815; a=rsa-sha256;
	cv=none;
	b=ORrcH2w8Ecj1Q2ifFGILL7VHTrQLtqEreqszAoIW0rA9UIA/Q1kS0idcMHeQuifUAEw/0q
	3rv06Z7vJH/BLx1L6QiOqH9fK+OuAtXs8ec1sgq8kq9Oa1GYWh7aIqHSb5X2WgJOJilqsZ
	Jvcg9gbX5XBJlgbbmqpUvgDW9PwlmVUU+C11mfIrttnAKbDPODVwld3gLOzFGE9HjYFdMA
	HuH9m30jTzH1+Bn9sX+Y0XfeaMdSoQ4N45cuo192bAuIQI4wm1xDUYEldPzYX7ldA/28a7
	a/fmtOQY1vn0gq1Vc3q2g0vdEQb5VP13i+i7sqX1+4T7HqFE0e+FBVXu4lh4pg==
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
Subject: [PATCH v5 2/5] Bluetooth: add support for skb TX SND/COMPLETION timestamping
Date: Tue, 18 Mar 2025 21:06:43 +0200
Message-ID: <a5c1b2110e567f499e17a4a67f1cc7c2036566c4.1742324341.git.pav@iki.fi>
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
    v5:
    - Add hci_sockm_init()
    - Back to decoupled COMPLETION & SND, like in v3
    - Handle SCO flow controlled case

 include/net/bluetooth/hci_core.h |  20 +++++
 net/bluetooth/hci_conn.c         | 122 +++++++++++++++++++++++++++++++
 net/bluetooth/hci_core.c         |  15 +++-
 net/bluetooth/hci_event.c        |   4 +
 4 files changed, 157 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f78e4298e39a..5115da34f881 100644
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
@@ -1572,6 +1580,18 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active);
 void hci_conn_failed(struct hci_conn *conn, u8 status);
 u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle);
 
+void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb);
+void hci_conn_tx_dequeue(struct hci_conn *conn);
+void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
+			    const struct sockcm_cookie *sockc);
+
+static inline void hci_sockcm_init(struct sockcm_cookie *sockc, struct sock *sk)
+{
+	*sockc = (struct sockcm_cookie) {
+		.tsflags = READ_ONCE(sk->sk_tsflags),
+	};
+}
+
 /*
  * hci_conn_get() and hci_conn_put() are used to control the life-time of an
  * "hci_conn" object. They do not guarantee that the hci_conn object is running,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d097e308a755..95972fd4c784 100644
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
@@ -3064,3 +3067,122 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
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
+	 * TODO: SCO support without flowctl (needs to be done in drivers)
+	 */
+	switch (conn->type) {
+	case ISO_LINK:
+	case ACL_LINK:
+	case LE_LINK:
+		break;
+	case SCO_LINK:
+	case ESCO_LINK:
+		if (!hci_dev_test_flag(conn->hdev, HCI_SCO_FLOWCTL))
+			return;
+		break;
+	default:
+		return;
+	}
+
+	if (skb->sk && (skb_shinfo(skb)->tx_flags & SKBTX_COMPLETION_TSTAMP))
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
index 94d9147612da..5eb0600bbd03 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3029,6 +3029,13 @@ static int hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -3575,7 +3582,7 @@ static void hci_sched_sco(struct hci_dev *hdev, __u8 type)
 	while (*cnt && (conn = hci_low_sent(hdev, type, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(hdev, skb);
+			hci_send_conn_frame(hdev, conn, skb);
 
 			conn->sent++;
 			if (conn->sent == ~0)
@@ -3618,7 +3625,7 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 			hci_conn_enter_active_mode(chan->conn,
 						   bt_cb(skb)->force_active);
 
-			hci_send_frame(hdev, skb);
+			hci_send_conn_frame(hdev, chan->conn, skb);
 			hdev->acl_last_tx = jiffies;
 
 			hdev->acl_cnt--;
@@ -3674,7 +3681,7 @@ static void hci_sched_le(struct hci_dev *hdev)
 
 			skb = skb_dequeue(&chan->data_q);
 
-			hci_send_frame(hdev, skb);
+			hci_send_conn_frame(hdev, chan->conn, skb);
 			hdev->le_last_tx = jiffies;
 
 			(*cnt)--;
@@ -3708,7 +3715,7 @@ static void hci_sched_iso(struct hci_dev *hdev)
 	while (*cnt && (conn = hci_low_sent(hdev, ISO_LINK, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(hdev, skb);
+			hci_send_conn_frame(hdev, conn, skb);
 
 			conn->sent++;
 			if (conn->sent == ~0)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0df4a0e082c8..83990c975c1f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4415,6 +4415,7 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 		struct hci_comp_pkts_info *info = &ev->handles[i];
 		struct hci_conn *conn;
 		__u16  handle, count;
+		unsigned int i;
 
 		handle = __le16_to_cpu(info->handle);
 		count  = __le16_to_cpu(info->count);
@@ -4425,6 +4426,9 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 
 		conn->sent -= count;
 
+		for (i = 0; i < count; ++i)
+			hci_conn_tx_dequeue(conn);
+
 		switch (conn->type) {
 		case ACL_LINK:
 			hdev->acl_cnt += count;
-- 
2.48.1


