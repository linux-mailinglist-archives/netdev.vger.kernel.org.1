Return-Path: <netdev+bounces-262743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L/JL3XCpWnEFgAAu9opvQ
	(envelope-from <netdev+bounces-262743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 18:01:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA351DD6D4
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 18:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 993F33147CDA
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 16:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6068425CDD;
	Mon,  2 Mar 2026 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBL1MUMc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED50425CCF
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469739; cv=none; b=ZWpLRpsR26MIw5+mvPxyylU6NmqljCwNyGY5PPEoA1fKzLb0Q3YwMrcO/2gsAOKcyDKpc+wRoWoVxbDjHHqhxO8R36njlKL2QWsy/78tRWIOQy7OVl1hOPx1EcAqdsvXRn4wHoeL2gbk26sYTQ6NKumHYI7UGYmF6R38PteY/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469739; c=relaxed/simple;
	bh=VFASPJvhciehL7F+IA6+SdXs77TNKb/sys4Vs9JnaxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E6U20Iy7i5tfVKQLBdDXtCBsXSe8B4ov2LF45/lcGNLAxzYFA/IB9/KIzJcw2rTN7yy2gi6A0u8LqLe1iN2h/KtnYk2TWGjQkdg/T90FJtQ6DZRF6wzRGAYwSHX3fVtyqfSu2HkF2woOGd0hpJvNXZaDYTJkLiFrMOEND5ry0os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBL1MUMc; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8273e0fb87aso2550096b3a.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 08:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772469738; x=1773074538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IZaKRJcz+mujuLo0S8DFt3UkN8fu6YsunVoMPBDL58A=;
        b=bBL1MUMcATKeHSlLaFfPJ0G65MBtqUjujyU55x6acpvbQI9mGKIFtD/UV7vzhAPeFx
         hDIRO8MeSnghj8Aos22qJugse5zw90Yv5KYFg4eUPfl4VW32OTmvfjPwJG+G98K6zssF
         7PJBrb0QyskUX57K3CnpCcoPhoS6uHAXGOGgH7xuKml2s52VhnjsLZzAz0KwJzM02I50
         7h0WVYdjs5PZF34ZMhYCOKaRUhYRXlQID5OpUjxMjkFCURzeWbePvzsECg42xhLvFL3n
         FYda5Elz+MsBGBRFDYH0ShcFPHi9QSm6GECKqgiz17bSvbJsTGVUlMDr5MuxpQMCbtOz
         78Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772469738; x=1773074538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZaKRJcz+mujuLo0S8DFt3UkN8fu6YsunVoMPBDL58A=;
        b=gQ6mKCtC7G57kNOBtdxX9yVoFQEvBQ6GMCy7lzV8mqDk4huqzvptfivrQ0mIkdZssi
         UgUifyBVA3k3uuPQKmiNKQmcFbM+13ufrjELm1wHZJsyjGXel4cETshkCHxpR53Kff7E
         syyo0xggDshDQZH0kN5eAnCHXLyXHW3ggl3WmW/KYTaW2zYfPFaZMkv9tOgkG+z8IvDr
         VneLymmtvEpM4+7so/Y+wp52oetY9lQqHNvYZH57AQ/KYukzvvJIVhPYhRJQATf/cq3R
         ZaYROWl8am4Eko+P7DRgYd4Hg1Krz0MSSOXffKRYbpKhdAm0IoRQZipC8eraChf2Obk5
         I2PQ==
X-Gm-Message-State: AOJu0YwljUnvuv6kNExBjKPRsQ7gsD78VMteS7Y5d14cgHknLrAu0w5u
	ZcwxRctH/Ll+1k2mtlrcn1i2+znaASN8B33G9ph0LFiFcMw6W/fIvL84NQsXaC/hcLE=
X-Gm-Gg: ATEYQzy7EgkCKRDHeSPP83wvJ9YwBDwHcTiIO1m7xImdKq9SOXLK4VzpG9n2ALivHzK
	EezfBU1EaAtdT2PufOTNx8LlcaYb5JJ3BXhkdC6gBSAc6zoNKQOTuvXwbinGdhu883hz/ICgGgU
	iLGB+tqxSUkAC0iBjiWdpEMEt5ChUrRQJD5UoWKTVRRlAZ6wEVl5GUv2ymO6za7ANN8n4ag9n4V
	D7+NOxt0rxDyOayHgD/iHxxUPp1gpGmfGWPz/EA+8RmRfHFE3eVyOjjDE2IIMeXPfhSlpEWRF1B
	WN0Zws2XOjx7HIG4h1EKIAKeqNxal5hddLJmmp2zKDgHylo1XVziLnpKI2WaUbi9n64MRM/NT+R
	m+MYMIN96Q1r3nRN/iAYeOZl2ElkZ427cVZXKJ2h0RFe0YBSafsax5DmbERto143puawc4uazaN
	0omEA72jx1zwIxfFn6vEI=
X-Received: by 2002:a05:6a20:a10d:b0:38d:efcb:2e84 with SMTP id adf61e73a8af0-395c3a86fb2mr12074081637.32.1772469737400;
        Mon, 02 Mar 2026 08:42:17 -0800 (PST)
Received: from minh.192.168.1.1 ([2a09:bac1:31c0:8::246:f5])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c70fa801849sm12681295a12.20.2026.03.02.08.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 08:42:15 -0800 (PST)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net-next v2] virtio-net: xsk: Support wakeup on RX side
Date: Mon,  2 Mar 2026 23:41:58 +0700
Message-ID: <20260302164158.4394-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6FA351DD6D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,lists.linux.dev,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-262743-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minhquangbui99@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
is allocated on RX side, allow RX NAPI to be descheduled. This avoids
wasting CPU cycles on polling. Users will be notified and they need to
make a wakeup call after refilling the ring.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v2:
- Fix the flag check in virtnet_xsk_wakeup
- Link to v1: https://lore.kernel.org/netdev/20260227150949.13089-1-minhquangbui99@gmail.com/
---
 drivers/net/virtio_net.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index db88dcaefb20..3614002fc87c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1454,8 +1454,19 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
 	xsk_buffs = rq->xsk_buffs;
 
 	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
-	if (!num)
+	if (!num) {
+		if (xsk_uses_need_wakeup(pool)) {
+			xsk_set_rx_need_wakeup(pool);
+			/* Return 0 instead of -ENOMEM so that NAPI is
+			 * descheduled.
+			 */
+			return 0;
+		}
+
 		return -ENOMEM;
+	} else {
+		xsk_clear_rx_need_wakeup(pool);
+	}
 
 	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
 
@@ -1588,20 +1599,19 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	return sent;
 }
 
-static void xsk_wakeup(struct send_queue *sq)
+static void xsk_wakeup(struct napi_struct *napi, struct virtqueue *vq)
 {
-	if (napi_if_scheduled_mark_missed(&sq->napi))
+	if (napi_if_scheduled_mark_missed(napi))
 		return;
 
 	local_bh_disable();
-	virtqueue_napi_schedule(&sq->napi, sq->vq);
+	virtqueue_napi_schedule(napi, vq);
 	local_bh_enable();
 }
 
 static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	struct send_queue *sq;
 
 	if (!netif_running(dev))
 		return -ENETDOWN;
@@ -1609,9 +1619,18 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 	if (qid >= vi->curr_queue_pairs)
 		return -EINVAL;
 
-	sq = &vi->sq[qid];
+	if (flag & XDP_WAKEUP_TX) {
+		struct send_queue *sq = &vi->sq[qid];
+
+		xsk_wakeup(&sq->napi, sq->vq);
+	}
+
+	if (flag & XDP_WAKEUP_RX) {
+		struct receive_queue *rq = &vi->rq[qid];
+
+		xsk_wakeup(&rq->napi, rq->vq);
+	}
 
-	xsk_wakeup(sq);
 	return 0;
 }
 
@@ -1623,7 +1642,7 @@ static void virtnet_xsk_completed(struct send_queue *sq, int num)
 	 * wakeup the tx napi to consume the xsk tx queue, because the tx
 	 * interrupt may not be triggered.
 	 */
-	xsk_wakeup(sq);
+	xsk_wakeup(&sq->napi, sq->vq);
 }
 
 static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
-- 
2.43.0


