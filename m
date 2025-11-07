Return-Path: <netdev+bounces-236900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4204C41F5F
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 00:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0411896E69
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 23:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D368314B95;
	Fri,  7 Nov 2025 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hD+xtKMC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552C121D3F8
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 23:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762558344; cv=none; b=laNEh9U0oBs/Nc33c2uB5r1OjrCb9g3jihBiv7IzJY8NcxFj50TYfjgSIo14tgREWXX+mM7uAY09s9odGcjackUyFbxZGuqhE+JmJU1zR9M60tdbyV2bWTrcaDuujbADLGP28N2aJbAfC27vqQd8SiAclUQEISDSb7bwWerDSN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762558344; c=relaxed/simple;
	bh=N14jooCdbjxdMTibgGX7jieDfuSxz1rOyy7hLaIefRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mumrw73FZ4HoopyfOstodWIc2CwumBiLVXeNjNFS+k2koDJ/xQ1UG/K7cBt59i2HxsUDrrHXYPz4GrfOvHB5QJbKsM+G/KxMFgltQfBcCKl9o0c8BYGjhyXIx3dpJSJ4+n+3tH65PULaYR8Leqh0iR5A1fJ0KYBbAWcOXFV0QHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hD+xtKMC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762558341; x=1794094341;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=N14jooCdbjxdMTibgGX7jieDfuSxz1rOyy7hLaIefRQ=;
  b=hD+xtKMCpmDpv+ifD5Z24dkrwhITk/vv5+liDTFaE+uzvZEBt6aDZT6q
   GDkIvYBu0SVe8tKc+jn4PyNohzK/n0gil8v18RrF4ba4pOpoS/tKpo7gm
   qknSgDU8CMa1wSG71M5chU80tvY7R/Yzz7O6sndTvq3VCEYy6iRv/leGO
   Bu8pF2HSrje2WtdSoZWnykMTrO9sQ8N5j4ZCkP9KOGHGKCULIIrXcFuO5
   ds5MJVCz9KgWvD3JArBCUX/OQ1NYa0nQPA6M0bn9Jsc5CGsT33zqOdy0E
   rL8ULztnc7s8H40WR5ZskVeEiWWEo/YbtE17Zk/D28fgjkUBPfp/yQvhn
   Q==;
X-CSE-ConnectionGUID: NWMH/05WRm6SyLngAp+klA==
X-CSE-MsgGUID: GTCpJm4jT2andyajc8NVsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="75405474"
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="75405474"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 15:32:20 -0800
X-CSE-ConnectionGUID: L9Bj4B7/T9qukzblr6dSOQ==
X-CSE-MsgGUID: DjPTnkdmT6yt+mpY78e2WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="218815434"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 15:32:20 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 07 Nov 2025 15:31:51 -0800
Subject: [PATCH iwl-next v3 7/9] ice: use u64_stats API to access
 pkts/bytes in dim sample
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-jk-refactor-queue-stats-v3-7-771ae1414b2e@intel.com>
References: <20251107-jk-refactor-queue-stats-v3-0-771ae1414b2e@intel.com>
In-Reply-To: <20251107-jk-refactor-queue-stats-v3-0-771ae1414b2e@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=6434;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=N14jooCdbjxdMTibgGX7jieDfuSxz1rOyy7hLaIefRQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhky+xqbjIQcXTFRf+/TqnWyd8N9TTxfNMrS03hxfX9o66
 cXi2TkXOkpZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZjIf06G/6kv+p6Wf+3mUZq3
 aal5+Xalsx7XeiTuFQY+E/H8fYGn5yfDP7XDB09ohHot5rE8q5P7XWWPYKamIOfPxCcfF+xSZG2
 rYgUA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The __ice_update_sample and __ice_get_ethtool_stats functions directly
accesses the pkts and bytes counters from the ring stats. A following
change is going to update the fields to be u64_stats_t type, and will need
to be accessed appropriately. This will ensure that the accesses do not
cause load/store tearing.

Add helper functions similar to the ones used for updating the stats
values, and use them. This ensures use of the syncp pointer on 32-bit
architectures. Once the fields are updated to u64_stats_t, it will then
properly avoid tears on all architectures.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.h     |  6 +++++
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 26 +++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_lib.c     | 36 ++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_txrx.c    | 29 +++++++++++-----------
 4 files changed, 75 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 2cb1eb98b9da..49454d98dcfe 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -92,6 +92,12 @@ void ice_update_tx_ring_stats(struct ice_tx_ring *ring, u64 pkts, u64 bytes);
 
 void ice_update_rx_ring_stats(struct ice_rx_ring *ring, u64 pkts, u64 bytes);
 
+void ice_fetch_tx_ring_stats(const struct ice_tx_ring *ring,
+			     u64 *pkts, u64 *bytes);
+
+void ice_fetch_rx_ring_stats(const struct ice_rx_ring *ring,
+			     u64 *pkts, u64 *bytes);
+
 void ice_write_intrl(struct ice_q_vector *q_vector, u8 intrl);
 void ice_write_itr(struct ice_ring_container *rc, u16 itr);
 void ice_set_q_vector_intrl(struct ice_q_vector *q_vector);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 0bc6f31a2b06..6c93e0e91ef5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1942,25 +1942,35 @@ __ice_get_ethtool_stats(struct net_device *netdev,
 	rcu_read_lock();
 
 	ice_for_each_alloc_txq(vsi, j) {
+		u64 pkts, bytes;
+
 		tx_ring = READ_ONCE(vsi->tx_rings[j]);
-		if (tx_ring && tx_ring->ring_stats) {
-			data[i++] = tx_ring->ring_stats->stats.pkts;
-			data[i++] = tx_ring->ring_stats->stats.bytes;
-		} else {
+		if (!tx_ring || !tx_ring->ring_stats) {
 			data[i++] = 0;
 			data[i++] = 0;
+			continue;
 		}
+
+		ice_fetch_tx_ring_stats(tx_ring, &pkts, &bytes);
+
+		data[i++] = pkts;
+		data[i++] = bytes;
 	}
 
 	ice_for_each_alloc_rxq(vsi, j) {
+		u64 pkts, bytes;
+
 		rx_ring = READ_ONCE(vsi->rx_rings[j]);
-		if (rx_ring && rx_ring->ring_stats) {
-			data[i++] = rx_ring->ring_stats->stats.pkts;
-			data[i++] = rx_ring->ring_stats->stats.bytes;
-		} else {
+		if (!rx_ring || !rx_ring->ring_stats) {
 			data[i++] = 0;
 			data[i++] = 0;
+			continue;
 		}
+
+		ice_fetch_rx_ring_stats(rx_ring, &pkts, &bytes);
+
+		data[i++] = pkts;
+		data[i++] = bytes;
 	}
 
 	rcu_read_unlock();
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 26d17813f426..897df9362638 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3474,6 +3474,42 @@ void ice_update_rx_ring_stats(struct ice_rx_ring *rx_ring, u64 pkts, u64 bytes)
 	u64_stats_update_end(&rx_ring->ring_stats->syncp);
 }
 
+/**
+ * ice_fetch_tx_ring_stats - Fetch Tx ring packet and byte counters
+ * @ring: ring to update
+ * @pkts: number of processed packets
+ * @bytes: number of processed bytes
+ */
+void ice_fetch_tx_ring_stats(const struct ice_tx_ring *ring,
+			     u64 *pkts, u64 *bytes)
+{
+	unsigned int start;
+
+	do  {
+		start = u64_stats_fetch_begin(&ring->ring_stats->syncp);
+		*pkts = ring->ring_stats->pkts;
+		*bytes = ring->ring_stats->bytes;
+	} while (u64_stats_fetch_retry(&ring->ring_stats->syncp, start));
+}
+
+/**
+ * ice_fetch_rx_ring_stats - Fetch Rx ring packet and byte counters
+ * @ring: ring to read
+ * @pkts: number of processed packets
+ * @bytes: number of processed bytes
+ */
+void ice_fetch_rx_ring_stats(const struct ice_rx_ring *ring,
+			     u64 *pkts, u64 *bytes)
+{
+	unsigned int start;
+
+	do  {
+		start = u64_stats_fetch_begin(&ring->ring_stats->syncp);
+		*pkts = ring->ring_stats->pkts;
+		*bytes = ring->ring_stats->bytes;
+	} while (u64_stats_fetch_retry(&ring->ring_stats->syncp, start));
+}
+
 /**
  * ice_is_dflt_vsi_in_use - check if the default forwarding VSI is being used
  * @pi: port info of the switch with default VSI
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 30073ed9ca99..f0f5133c389f 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1087,35 +1087,36 @@ static void __ice_update_sample(struct ice_q_vector *q_vector,
 				struct dim_sample *sample,
 				bool is_tx)
 {
-	u64 packets = 0, bytes = 0;
+	u64 total_packets = 0, total_bytes = 0, pkts, bytes;
 
 	if (is_tx) {
 		struct ice_tx_ring *tx_ring;
 
 		ice_for_each_tx_ring(tx_ring, *rc) {
-			struct ice_ring_stats *ring_stats;
-
-			ring_stats = tx_ring->ring_stats;
-			if (!ring_stats)
+			if (!tx_ring->ring_stats)
 				continue;
-			packets += ring_stats->stats.pkts;
-			bytes += ring_stats->stats.bytes;
+
+			ice_fetch_tx_ring_stats(tx_ring, &pkts, &bytes);
+
+			total_packets += pkts;
+			total_bytes += bytes;
 		}
 	} else {
 		struct ice_rx_ring *rx_ring;
 
 		ice_for_each_rx_ring(rx_ring, *rc) {
-			struct ice_ring_stats *ring_stats;
-
-			ring_stats = rx_ring->ring_stats;
-			if (!ring_stats)
+			if (!rx_ring->ring_stats)
 				continue;
-			packets += ring_stats->stats.pkts;
-			bytes += ring_stats->stats.bytes;
+
+			ice_fetch_rx_ring_stats(rx_ring, &pkts, &bytes);
+
+			total_packets += pkts;
+			total_bytes += bytes;
 		}
 	}
 
-	dim_update_sample(q_vector->total_events, packets, bytes, sample);
+	dim_update_sample(q_vector->total_events,
+			  total_packets, total_bytes, sample);
 	sample->comp_ctr = 0;
 
 	/* if dim settings get stale, like when not updated for 1

-- 
2.51.0.rc1.197.g6d975e95c9d7


