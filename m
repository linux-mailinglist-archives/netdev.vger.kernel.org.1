Return-Path: <netdev+bounces-209381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9948FB0F6A4
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F643B263A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A665A2FE30D;
	Wed, 23 Jul 2025 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFtH+KM3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CBA2FF46A
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282892; cv=none; b=oCEmLwFx+lax/MPcqeskoKYOwNm3n8q+YXRG68gXZfHGy0XjO2olLeCSCJzPAyTMl7zFXUaRzCqpW4Bt19TMsKPgMHOL12B/wTuU0hGcnJsfcB1RSf0Rhmniwu3mCmBY24HMSrEtmDttfATn4nEOgmgNaxmuS1aLzEW1IcWgspc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282892; c=relaxed/simple;
	bh=VDLUGcA0gbnC6EJUTTDEZFwd7RyKKeY6sb+Zim1+kdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChG4tKhm1MmwhGR6GHUa5mtYvKYuBNqsIe1wPiDmJvGHmbx1igkwpUd718Ta5tPcgTvHQN9MhK549BoWkmKAHS0h6hj28fftc2yS0CWO/cdJ1i5QHeMjClUTqq2Btlf/XmApEhYTkHkhWqtfmNOv8bczmpzQ/A5vIzdzCSZkTP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFtH+KM3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4561607166aso53106925e9.2
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753282819; x=1753887619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01xDJNsjXpY5nVbJCHB2ynhXnQv/NxY1C7kuG3yCAPc=;
        b=eFtH+KM31uvmLYs/NrHTmOPPANWc3n2EfpCaw0SAQQEEzdCB1In1E8BO+SsE8QhRhg
         wvfXmogNC454tAqqotjcZoJnuvv5GZ+FUvnBZxmrvNK/PgenhEMayUzCQMoaLA7UcYxA
         a96UT7jUFHD9Q6WgRoRWGXJNqrbiBP5ubH6iLbec/3Y3yny+vLdsF730wlkDOn1mVFex
         Tue4g/xTlWM3ip5um5JDKr/dIXabfH6gmeB35X8ipnhk9uLwnd+Dp4z4enqIAV09c06c
         jgsLPLgmRpPrYAPuVwS5UaeTrcvsjiphx2yl4G2mrh3wDnGkhd6xCjNZJE4AnKi/83Zq
         IyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282819; x=1753887619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01xDJNsjXpY5nVbJCHB2ynhXnQv/NxY1C7kuG3yCAPc=;
        b=m7gy6QotHv5wDw1u1pMlhEs7Uer5rdB0xR9rZwbq8O6g/EryMVAcuJxyGxAKtm5aw7
         Zgq9w/nospkFooffEM22PBwPp3F8/qABsdXhbQyiLrxrcb9CHmaWSRJMvqmPe4BQesGM
         yeJ6pO0f/zBuOD+V/qugmiFzH0VWMfQwcUsvYJoGusgS5Vc0g+P2Uk1eWiIPWRQFaCps
         911EjfFjDmv8P/kfQL2H7ZgzF5c6G4f3Kl4fawGQuDIGOio2pTXrFlYAan8cltdxqNZ2
         kxrrSpNM0iMzFD5KU3gurfFtrsFtC5U3W+i1y+STRpTEAL6vZIq0urmGppN0NsuvwGHe
         eQoQ==
X-Gm-Message-State: AOJu0YxVYsBVTlKiS/fXQ4NLimWdir426U3cuNgcTsS3f4dt4psgzqAy
	i5tob00LiE+reQsYAsWKH1dGP18d+AjE6wFCWXPEqjjtoNKfDNJXUeB3NYb2X3Kz
X-Gm-Gg: ASbGncv6A9ggpI7XUGDODXIrPlMWO5mSI8qG8lfJdjggYu4vul6tvrJRZtdVnZ3AeQ3
	dKlPyZ3wa8n0bJ7jh4Gbb7k02WxfEj3YXphiZdqWNKhQp+EkXcOXYkB+IU+lkGMAzxeoFosHamP
	9VKU5QhE48XwuGtZ8MmYoZFq5k29m+KuB2BGI46h95d/Yn+8DOU2MPKu8Sln9YnDi8RIQsYK2rk
	BJX3ce/y5g+T676hh9nlBqUagXy6o2ubujirjQARNHYGTTlFUxQnTqx+201G1bbLmlXhl5EZdEq
	0JDXOZAQBA2DF9yWmZgUHkIKjLX0Bk3cCf3WtfmGL7mxFKDbpCOg3CIX9V/NjMeogO+zZYUAGKN
	Z820Wa5eTR0Ip0l77
X-Google-Smtp-Source: AGHT+IFrdkkCs6arMVIkf9CMOWY+QLtLesNKfetNzUwPdcdhgj4bcdhApzf541okcbkrwuGsHlYOAQ==
X-Received: by 2002:a05:600c:a109:b0:453:78f:fa9f with SMTP id 5b1f17b1804b1-45869d7b44bmr18419435e9.11.1753282818758;
        Wed, 23 Jul 2025 08:00:18 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458693e20absm26365625e9.24.2025.07.23.08.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 08:00:18 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mohsin.bashr@gmail.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	jdamato@fastly.com,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Subject: [PATCH net-next 8/9] eth: fbnic: Collect packet statistics for XDP
Date: Wed, 23 Jul 2025 07:59:25 -0700
Message-ID: <20250723145926.4120434-9-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
References: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for XDP statistics collection and reporting via rtnl_link
and netdev_queue API.

For XDP programs without frags support, fbnic requires MTU to be less
than the HDS threshold. If an over-sized frame is received, the frame
is dropped and recorded as rx_length_errors reported via ip stats to
highlight that this is an error.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 .../device_drivers/ethernet/meta/fbnic.rst    | 10 +++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 30 +++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 44 +++++++++++++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  1 +
 4 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
index afb8353daefd..ad5e2cba7afc 100644
--- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
+++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
@@ -160,3 +160,13 @@ behavior and potential performance bottlenecks.
 	  credit exhaustion
         - ``pcie_ob_rd_no_np_cred``: Read requests dropped due to non-posted
 	  credit exhaustion
+
+XDP Length Error:
+~~~~~~~~~~~~~~~~~
+
+For XDP programs without frags support, fbnic tries to make sure that MTU fits
+into a single buffer. If an oversized frame is received and gets fragmented,
+it is dropped and the following netlink counters are updated
+   - ``rx-length``: number of frames dropped due to lack of fragmentation
+   support in the attached XDP program
+   - ``rx-errors``: total number of packets with errors received on the interface
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 0621b89cbf3d..4991f9214c0d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -485,6 +485,7 @@ static void fbnic_get_stats64(struct net_device *dev,
 	stats64->rx_missed_errors = rx_missed;
 
 	for (i = 0; i < fbn->num_rx_queues; i++) {
+		struct fbnic_ring *xdpr = fbn->tx[FBNIC_MAX_TXQS + i];
 		struct fbnic_ring *rxr = fbn->rx[i];
 
 		if (!rxr)
@@ -501,6 +502,21 @@ static void fbnic_get_stats64(struct net_device *dev,
 		stats64->rx_bytes += rx_bytes;
 		stats64->rx_packets += rx_packets;
 		stats64->rx_dropped += rx_dropped;
+
+		if (!xdpr)
+			continue;
+
+		stats = &xdpr->stats;
+		do {
+			start = u64_stats_fetch_begin(&stats->syncp);
+			tx_bytes = stats->bytes;
+			tx_packets = stats->packets;
+			tx_dropped = stats->dropped;
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+		stats64->tx_bytes += tx_bytes;
+		stats64->tx_packets += tx_packets;
+		stats64->tx_dropped += tx_dropped;
 	}
 }
 
@@ -599,6 +615,7 @@ static void fbnic_get_queue_stats_tx(struct net_device *dev, int idx,
 	struct fbnic_ring *txr = fbn->tx[idx];
 	struct fbnic_queue_stats *stats;
 	u64 stop, wake, csum, lso;
+	struct fbnic_ring *xdpr;
 	unsigned int start;
 	u64 bytes, packets;
 
@@ -622,6 +639,19 @@ static void fbnic_get_queue_stats_tx(struct net_device *dev, int idx,
 	tx->hw_gso_wire_packets = lso;
 	tx->stop = stop;
 	tx->wake = wake;
+
+	xdpr = fbn->tx[FBNIC_MAX_TXQS + idx];
+	if (xdpr) {
+		stats = &xdpr->stats;
+		do {
+			start = u64_stats_fetch_begin(&stats->syncp);
+			bytes = stats->bytes;
+			packets = stats->packets;
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+		tx->bytes += bytes;
+		tx->packets += packets;
+	}
 }
 
 static void fbnic_get_base_stats(struct net_device *dev,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index a1656c66a512..eb5d071b727a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -650,6 +650,18 @@ static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
 		return;
 
 	ring->head = head;
+
+	if (discard) {
+		u64_stats_update_begin(&ring->stats.syncp);
+		ring->stats.dropped += total_packets;
+		u64_stats_update_end(&ring->stats.syncp);
+		return;
+	}
+
+	u64_stats_update_begin(&ring->stats.syncp);
+	ring->stats.bytes += total_bytes;
+	ring->stats.packets += total_packets;
+	u64_stats_update_end(&ring->stats.syncp);
 }
 
 static void fbnic_clean_tsq(struct fbnic_napi_vector *nv,
@@ -1044,8 +1056,12 @@ static long fbnic_pkt_tx(struct fbnic_napi_vector *nv,
 		frag = &shinfo->frags[0];
 	}
 
-	if (fbnic_desc_unused(ring) < nsegs)
+	if (fbnic_desc_unused(ring) < nsegs) {
+		u64_stats_update_begin(&ring->stats.syncp);
+		ring->stats.dropped++;
+		u64_stats_update_end(&ring->stats.syncp);
 		return -FBNIC_XDP_CONSUME;
+	}
 
 	page = virt_to_page(pkt->buff.data_hard_start);
 	offset = offset_in_page(pkt->buff.data);
@@ -1184,8 +1200,8 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 			   struct fbnic_q_triad *qt, int budget)
 {
 	unsigned int packets = 0, bytes = 0, dropped = 0, alloc_failed = 0;
+	u64 csum_complete = 0, csum_none = 0, length_errors = 0;
 	s32 head0 = -1, head1 = -1, pkt_tail = -1;
-	u64 csum_complete = 0, csum_none = 0;
 	struct fbnic_ring *rcq = &qt->cmpl;
 	struct fbnic_pkt_buff *pkt;
 	__le64 *raw_rcd, done;
@@ -1250,6 +1266,8 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 				if (!skb) {
 					alloc_failed++;
 					dropped++;
+				} else if (PTR_ERR(skb) == -FBNIC_XDP_LEN_ERR) {
+					length_errors++;
 				} else {
 					dropped++;
 				}
@@ -1279,6 +1297,7 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 	rcq->stats.rx.alloc_failed += alloc_failed;
 	rcq->stats.rx.csum_complete += csum_complete;
 	rcq->stats.rx.csum_none += csum_none;
+	rcq->stats.rx.length_errors += length_errors;
 	u64_stats_update_end(&rcq->stats.syncp);
 
 	if (pkt_tail >= 0)
@@ -1362,8 +1381,9 @@ void fbnic_aggregate_ring_rx_counters(struct fbnic_net *fbn,
 	fbn->rx_stats.rx.alloc_failed += stats->rx.alloc_failed;
 	fbn->rx_stats.rx.csum_complete += stats->rx.csum_complete;
 	fbn->rx_stats.rx.csum_none += stats->rx.csum_none;
+	fbn->rx_stats.rx.length_errors += stats->rx.length_errors;
 	/* Remember to add new stats here */
-	BUILD_BUG_ON(sizeof(fbn->rx_stats.rx) / 8 != 3);
+	BUILD_BUG_ON(sizeof(fbn->rx_stats.rx) / 8 != 4);
 }
 
 void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
@@ -1385,6 +1405,22 @@ void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
 	BUILD_BUG_ON(sizeof(fbn->tx_stats.twq) / 8 != 6);
 }
 
+static void fbnic_aggregate_ring_xdp_counters(struct fbnic_net *fbn,
+					      struct fbnic_ring *xdpr)
+{
+	struct fbnic_queue_stats *stats = &xdpr->stats;
+
+	if (!(xdpr->flags & FBNIC_RING_F_STATS))
+		return;
+
+	/* Capture stats from queues before dissasociating them */
+	fbn->rx_stats.bytes += stats->bytes;
+	fbn->rx_stats.packets += stats->packets;
+	fbn->rx_stats.dropped += stats->dropped;
+	fbn->tx_stats.bytes += stats->bytes;
+	fbn->tx_stats.packets += stats->packets;
+}
+
 static void fbnic_remove_tx_ring(struct fbnic_net *fbn,
 				 struct fbnic_ring *txr)
 {
@@ -1404,6 +1440,8 @@ static void fbnic_remove_xdp_ring(struct fbnic_net *fbn,
 	if (!(xdpr->flags & FBNIC_RING_F_STATS))
 		return;
 
+	fbnic_aggregate_ring_xdp_counters(fbn, xdpr);
+
 	/* Remove pointer to the Tx ring */
 	WARN_ON(fbn->tx[xdpr->q_idx] && fbn->tx[xdpr->q_idx] != xdpr);
 	fbn->tx[xdpr->q_idx] = NULL;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index b31b450c10fd..c927a4a5f1ca 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -89,6 +89,7 @@ struct fbnic_queue_stats {
 			u64 alloc_failed;
 			u64 csum_complete;
 			u64 csum_none;
+			u64 length_errors;
 		} rx;
 	};
 	u64 dropped;
-- 
2.47.1


