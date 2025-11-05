Return-Path: <netdev+bounces-236026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8EEC37E9D
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 22:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 465564F780F
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 21:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEE1359F85;
	Wed,  5 Nov 2025 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WsnSOrQR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3892735971B
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376839; cv=none; b=PwQ6rsKvU5wFp8F2LujeX4/uVCcDWoq7IFn9NMomXKwWyIjzd+AJEipgY3B17FK7klkgrb/zHjcyfPronffGqKXcJ94gOqO7P6XqbSkP/D5NKyLDLl0o/Wr1Z5SV2rJWKem1oB6SuRY8iIPrtmaRmq1l3vq4Y9IHumBZilc4S9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376839; c=relaxed/simple;
	bh=iqxIG0ZzVgcJVaH4z2Ckbzsoowt78usB4UinxMgSWn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s9QpB10kCp1Lz4acuCn/XAKiARcUNdNqzGyD4beEA9WoaXdMYxWZF6AiJvGHE0OTtjiLpX6La0Xo+sdV7wrdohwr0sSQvfHKJzlwWTo9Om98rWy244RsPVEbFOqDqN1bpZjye3Jlx2braYZSnM+YQ9K81y0hUF5rZwZl93RN5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WsnSOrQR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762376838; x=1793912838;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=iqxIG0ZzVgcJVaH4z2Ckbzsoowt78usB4UinxMgSWn0=;
  b=WsnSOrQRZIZ5s22Ghdm4/nA+baK3Y2hOaE/lQ/Bdzq/5Lz3fxypchHZq
   daQPRIqdLC3mO+D2lZLYaXyrz5jWVADQK0fck/fvRGfMcIZCjfr9g6Sey
   uqyMpuVgkGFevxcje6Xe6S30LJ+qHBsZbm4xOEXS6Y1kmUO9jZnL9une7
   9zFY8NSQkXeO9WM/pOlvuOI5P7TrkIHx44AGifdzVcuRxQmZ2HlD8bL2D
   Whub3BA0bGUpFXeY0Vkgn7NpR4G+TcOx/szWiBX5Zl2rV5fFLvSa8OCzS
   ZeIP5ieNrq9Xu4qrry2UwE9KZzMjbQRWV8xxKd9B9IJX89fvg4j7q+exI
   w==;
X-CSE-ConnectionGUID: yyMgZL7hQ/aDZ+kKuEBuxA==
X-CSE-MsgGUID: hVPEj8XKSvWu+voIyY8EoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64201032"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="64201032"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:07:13 -0800
X-CSE-ConnectionGUID: qKtUDBLQRuqwpU1PgQolPA==
X-CSE-MsgGUID: HM/ECcWmTxSV4sivYoZHIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="187513290"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:07:13 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 05 Nov 2025 13:06:36 -0800
Subject: [PATCH iwl-next v2 4/9] ice: move prev_pkt from ice_txq_stats to
 ice_tx_ring
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-jk-refactor-queue-stats-v2-4-8652557f9572@intel.com>
References: <20251105-jk-refactor-queue-stats-v2-0-8652557f9572@intel.com>
In-Reply-To: <20251105-jk-refactor-queue-stats-v2-0-8652557f9572@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=3185;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=iqxIG0ZzVgcJVaH4z2Ckbzsoowt78usB4UinxMgSWn0=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkzuPfW9PBIP+B9+8Vh1S8rTff+l9u8p5bzRxVnGcx/EJ
 rwy7j7WUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwESW9TAyfHgicjAx4sKjos2x
 4cps/9arf9ERj5zzbmEXj0U/T8HKAwz/VLh+Kq54+XRnWbuE618hmy6OJ548mxzeVxWZPfq1/9s
 6VgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The prev_pkt field in ice_txq_stats is used by ice_check_for_hung_subtask
as a way to detect potential Tx hangs due to missed interrupts.

The value is based on the packet count, but its an int and not really a
"statistic". The value is signed so that we can use -1 as a "no work
pending" value. A following change is going to refactor the stats to all
use the u64_stat_t type and accessor functions. Leaving prev_pkt as the
lone int feels a bit strange.

Instead, move it out of ice_txq_stats and place it in the ice_tx_ring. We
have 8 bytes still available in the 3rd cacheline, so this move saves a
small amount of memory. It also shouldn't impact the Tx path heavily since
its only accessed during initialization and the hang subtask.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.h | 3 ++-
 drivers/net/ethernet/intel/ice/ice_main.c | 6 +++---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 5350eb832ee5..f1fe1775baed 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -138,7 +138,6 @@ struct ice_txq_stats {
 	u64 restart_q;
 	u64 tx_busy;
 	u64 tx_linearize;
-	int prev_pkt; /* negative if no pending Tx descriptors */
 };
 
 struct ice_rxq_stats {
@@ -354,6 +353,8 @@ struct ice_tx_ring {
 
 	u32 txq_teid;			/* Added Tx queue TEID */
 
+	int prev_pkt; /* negative if no pending Tx descriptors */
+
 #define ICE_TX_FLAGS_RING_XDP		BIT(0)
 #define ICE_TX_FLAGS_RING_VLAN_L2TAG1	BIT(1)
 #define ICE_TX_FLAGS_RING_VLAN_L2TAG2	BIT(2)
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 645a2113e8aa..df5da7b4ec62 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -160,7 +160,7 @@ static void ice_check_for_hang_subtask(struct ice_pf *pf)
 			 * pending work.
 			 */
 			packets = ring_stats->stats.pkts & INT_MAX;
-			if (ring_stats->tx_stats.prev_pkt == packets) {
+			if (tx_ring->prev_pkt == packets) {
 				/* Trigger sw interrupt to revive the queue */
 				ice_trigger_sw_intr(hw, tx_ring->q_vector);
 				continue;
@@ -170,8 +170,8 @@ static void ice_check_for_hang_subtask(struct ice_pf *pf)
 			 * to ice_get_tx_pending()
 			 */
 			smp_rmb();
-			ring_stats->tx_stats.prev_pkt =
-			    ice_get_tx_pending(tx_ring) ? packets : -1;
+			tx_ring->prev_pkt =
+				ice_get_tx_pending(tx_ring) ? packets : -1;
 		}
 	}
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index ad76768a4232..30073ed9ca99 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -499,7 +499,7 @@ int ice_setup_tx_ring(struct ice_tx_ring *tx_ring)
 
 	tx_ring->next_to_use = 0;
 	tx_ring->next_to_clean = 0;
-	tx_ring->ring_stats->tx_stats.prev_pkt = -1;
+	tx_ring->prev_pkt = -1;
 	return 0;
 
 err:

-- 
2.51.0.rc1.197.g6d975e95c9d7


