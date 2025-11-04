Return-Path: <netdev+bounces-235325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4869CC2EB30
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 02:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712773B2A4A
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 01:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CA421C167;
	Tue,  4 Nov 2025 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKCIKCAC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B582135D7
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 01:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762218444; cv=none; b=ULoH8MICrczsn0f/izSqD/i3PetJ3hTV7c8G/2mO51kUjouDE8cHg0QEoqe7rd7gSqc4sEXuwaRHVJsDPnA8VfBcUBfnY1NTIC/OZkFfqA86aEkrkXrZ1sS3P94CERN36byDJfT4F2UE+W46HrDnLSXjarIY9YRlWN3WFB/R2ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762218444; c=relaxed/simple;
	bh=iqxIG0ZzVgcJVaH4z2Ckbzsoowt78usB4UinxMgSWn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=auWDnlmxa3y4Klm5qU3Rmrz5+vWUbeF4oBLIieDvshkaMc6aERiurYQjwO1nF/Wy5jpVrk/z6OuWdZEmhso5/b/h03kXeKFMuwIwto3yivL5HUTepXbNCWBNVUHCSHdqo4gWB83r90VHtsivD2AVYPyTW33lLVpIOgf2T9fmKPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKCIKCAC; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762218444; x=1793754444;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=iqxIG0ZzVgcJVaH4z2Ckbzsoowt78usB4UinxMgSWn0=;
  b=oKCIKCACBa8UnzO8XZpG4fgixguW1FvanoJs8/sT6w19JXFWG3VqtwH7
   1RSDCHnbXhKCiv3UoPrTJFXOPt13OCB7rB04/HIreOUNhzW97HGoqZiCD
   khny42qDEX/E2Y1Fll2GFk/0z16PvpqYMyvolEfVFppmNFqTTF/vhKQp4
   nAftNhD4mzHKtlZa/8xRJ6YHdfQsQ+fy4MtkNinDuGYjm2ixAuaJFI9kz
   XkTJkSVH9/iZMHzj/gjmb37uUitEuL3C4uLMvi4EVZCobYXc8pTOCeJcc
   PlDY7kA5q5DXeNm+NhgiDWYxqkYF10atTY/rGWrlxzWM5XFYw15OtKlOw
   Q==;
X-CSE-ConnectionGUID: QA4sa8zIQsObnS1Wfv1AIQ==
X-CSE-MsgGUID: +GhlaLsuS8KXh1K9Yao1zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75656562"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="75656562"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 17:07:18 -0800
X-CSE-ConnectionGUID: 1qn23d05Q5eRLMcO1Eui5g==
X-CSE-MsgGUID: Ilh4N4/KS8KGrX3tWgXupQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="217828762"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 17:07:16 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 03 Nov 2025 17:06:49 -0800
Subject: [PATCH iwl-next 4/9] ice: move prev_pkt from ice_txq_stats to
 ice_tx_ring
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-jk-refactor-queue-stats-v1-4-164d2ed859b6@intel.com>
References: <20251103-jk-refactor-queue-stats-v1-0-164d2ed859b6@intel.com>
In-Reply-To: <20251103-jk-refactor-queue-stats-v1-0-164d2ed859b6@intel.com>
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
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkzOwIPZ9n/0ROUjDHlZZ0xvj/EULkxdoSwj5cD7dcYvi
 5QkG9mOUhYGMS4GWTFFFgWHkJXXjSeEab1xloOZw8oEMoSBi1MAJqJ6h5Fh4tZUm4b4DY+iSnkM
 7m7lsOrp7Fx6VWz99kZ3yzer1Vx6GP6Hz5cqNLn6ZG1I7APmhcm5k091C//m+iD272ejo2rW1Yf
 8AA==
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


