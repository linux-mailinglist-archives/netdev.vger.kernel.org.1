Return-Path: <netdev+bounces-236030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D588EC37F46
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 22:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3123BD802
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 21:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C8035A136;
	Wed,  5 Nov 2025 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZS3CmXmb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20622359F86
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376842; cv=none; b=Z+LYe43/SPz8plo7210w0pvAMCnOnpq/GNgJ2spLqLlb8B1zazcfbeUnugu320iDl6QrX7s4jRLvqHB6GcUGdeFyi1+W7v1i2DQaYBcYF4VE+fEd39b2NinRkjdjjvAe5XcU1IUqU4Qbyc57QgjHiEyJzN6fYDDc51VOtpFcqVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376842; c=relaxed/simple;
	bh=Z+iNgR7A3aqU394PqDxWa/II2wAO5hBF06V7ijjqcBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kpa0K1JloRkM/RnhH+J4+psT9ovtKoWBdZ1YjGWPAxkQ3kofZVI/1PEQbGBkMHY95Dt32hjf1q+92WLntjBlde78dUZG+ZZ3DIMP0YQTggebIaRwSQEOTB02sI/xMmaiH3ZloOCIpHbLJ5ss71VKo2wh7dpTvcepIzb1KF80fHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZS3CmXmb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762376840; x=1793912840;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Z+iNgR7A3aqU394PqDxWa/II2wAO5hBF06V7ijjqcBA=;
  b=ZS3CmXmb/eNj0H5WAazrn+jFvIWf+aSMOwrFDe3WEwq8cGnUTWtd+TbK
   4URxeK/Wy97jGrBtJ9VOE+wxgLCaiEIa9nETAwC66yCCbTD1ECd59ogAz
   yaSiu+m2ofWEyjq/Zd3Ru/jqpCP6AKE8SRKY2z8iF/w9AejTaRk8q5R2m
   lMFJU16ebLe1tC0hCHvhxrnHsGCtpqnEy9TtkmOrFtPt/oxgYqqQWK3Xv
   p8y43d5pvG2uTZUbrfi6SEySQuUuEhDz4KmVpYD9LcataQo9m/URjloEE
   bLDFJ86IjMZS7HB1lqakQ6ha5AezNU39AeBaDgi//CShHCDewCQuxsMt7
   A==;
X-CSE-ConnectionGUID: nd0wCEOgQE2LpeKOwV9ZSg==
X-CSE-MsgGUID: Bb3abgY6QdavIHxvpr2Qww==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64201033"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="64201033"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:07:13 -0800
X-CSE-ConnectionGUID: 2f7MdbgkSIeXEOef7PsfPw==
X-CSE-MsgGUID: zomOHQBsQxCqIqhkFeWWDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="187513293"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:07:13 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 05 Nov 2025 13:06:37 -0800
Subject: [PATCH iwl-next v2 5/9] ice: pass pointer to
 ice_fetch_u64_stats_per_ring
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-jk-refactor-queue-stats-v2-5-8652557f9572@intel.com>
References: <20251105-jk-refactor-queue-stats-v2-0-8652557f9572@intel.com>
In-Reply-To: <20251105-jk-refactor-queue-stats-v2-0-8652557f9572@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=3937;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Z+iNgR7A3aqU394PqDxWa/II2wAO5hBF06V7ijjqcBA=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkzuPfVZPdm/upUtvv759MZr45VX3NG6jM07eDhKq7I+X
 r3/492rjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACbS+4bhf8iM60ofHKpZItq2
 P9hvel7ZWGX/3I2uDvuntC47Uihz+grDb/aNYipsF7X6FVlSDP/VXFF+xLV9ToJMP7uFgnvz7kX
 zOQA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The ice_fetch_u64_stats_per_ring function takes a pointer to the syncp from
the ring stats to synchronize reading of the packet stats. It also takes a
*copy* of the ice_q_stats fields instead of a pointer to the stats. This
completely defeats the point of using the u64_stats API. We pass the stats
by value, so they are static at the point of reading within the
u64_stats_fetch_retry loop.

Simplify the function to take a pointer to the ice_ring_stats instead of
two separate parameters. Additionally, since we never call this outside of
ice_main.c, make it a static function.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  3 ---
 drivers/net/ethernet/intel/ice/ice_main.c | 24 +++++++++---------------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 147aaee192a7..5c01e886e83e 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -957,9 +957,6 @@ u16 ice_get_avail_rxq_count(struct ice_pf *pf);
 int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked);
 void ice_update_vsi_stats(struct ice_vsi *vsi);
 void ice_update_pf_stats(struct ice_pf *pf);
-void
-ice_fetch_u64_stats_per_ring(struct u64_stats_sync *syncp,
-			     struct ice_q_stats stats, u64 *pkts, u64 *bytes);
 int ice_up(struct ice_vsi *vsi);
 int ice_down(struct ice_vsi *vsi);
 int ice_down_up(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index df5da7b4ec62..5a3bcbb5f63c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6826,25 +6826,23 @@ int ice_up(struct ice_vsi *vsi)
 
 /**
  * ice_fetch_u64_stats_per_ring - get packets and bytes stats per ring
- * @syncp: pointer to u64_stats_sync
- * @stats: stats that pkts and bytes count will be taken from
+ * @stats: pointer to ring stats structure
  * @pkts: packets stats counter
  * @bytes: bytes stats counter
  *
  * This function fetches stats from the ring considering the atomic operations
  * that needs to be performed to read u64 values in 32 bit machine.
  */
-void
-ice_fetch_u64_stats_per_ring(struct u64_stats_sync *syncp,
-			     struct ice_q_stats stats, u64 *pkts, u64 *bytes)
+static void ice_fetch_u64_stats_per_ring(struct ice_ring_stats *stats,
+					 u64 *pkts, u64 *bytes)
 {
 	unsigned int start;
 
 	do {
-		start = u64_stats_fetch_begin(syncp);
-		*pkts = stats.pkts;
-		*bytes = stats.bytes;
-	} while (u64_stats_fetch_retry(syncp, start));
+		start = u64_stats_fetch_begin(&stats->syncp);
+		*pkts = stats->stats.pkts;
+		*bytes = stats->stats.bytes;
+	} while (u64_stats_fetch_retry(&stats->syncp, start));
 }
 
 /**
@@ -6868,9 +6866,7 @@ ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi,
 		ring = READ_ONCE(rings[i]);
 		if (!ring || !ring->ring_stats)
 			continue;
-		ice_fetch_u64_stats_per_ring(&ring->ring_stats->syncp,
-					     ring->ring_stats->stats, &pkts,
-					     &bytes);
+		ice_fetch_u64_stats_per_ring(ring->ring_stats, &pkts, &bytes);
 		vsi_stats->tx_packets += pkts;
 		vsi_stats->tx_bytes += bytes;
 		vsi->tx_restart += ring->ring_stats->tx_stats.restart_q;
@@ -6914,9 +6910,7 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 		struct ice_ring_stats *ring_stats;
 
 		ring_stats = ring->ring_stats;
-		ice_fetch_u64_stats_per_ring(&ring_stats->syncp,
-					     ring_stats->stats, &pkts,
-					     &bytes);
+		ice_fetch_u64_stats_per_ring(ring_stats, &pkts, &bytes);
 		vsi_stats->rx_packets += pkts;
 		vsi_stats->rx_bytes += bytes;
 		vsi->rx_buf_failed += ring_stats->rx_stats.alloc_buf_failed;

-- 
2.51.0.rc1.197.g6d975e95c9d7


