Return-Path: <netdev+bounces-99003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246FA8D357C
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4DCF286980
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB4B1802C9;
	Wed, 29 May 2024 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WXPm8C32"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCB01802C3
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981829; cv=none; b=QHvuZFq2xJqRK8J7zJ7kA8pJvg0tZSkfKcUisstx8oXh67kxC7UNkkXu38M3GvRuLkMJWCmyCz9V9ViGBaKzjOIZsD4Fxpb5LEiKDUUZmUtaz/L43k4hPNvHi8WSHAUxUtmoTgXuj/XBUPaXFpD6qEQguHVNfYp69dtvyYPhYtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981829; c=relaxed/simple;
	bh=k+t6/dW0a7XTqHTJyIkOeGq6uYftDeoAQY5f4RgHSbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C6G3yt6+NJ8eS8vVbTtsiaKSKJqEOMCWCAxBQfjFaybs+EgWtanvczFKKXJl8Y7crvMs0mvRXh6tCJtchrxWz2dMxFkJxEES4fWbtorHZoUkF1K5HZZxU3YZOU1LAT1ArxQt5u7DlcBdNyLHpqc/nALxhyT1knzZuPsrHHfykPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WXPm8C32; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716981828; x=1748517828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k+t6/dW0a7XTqHTJyIkOeGq6uYftDeoAQY5f4RgHSbU=;
  b=WXPm8C32fw5MRHX2BAbVj3cN9L77eiE2sOpjoKcc2dfDBB6blyeMvJh7
   pHq7ogkwCleGlbBEG+yyv+zjzGxv6uA/hXO14S43fgFjL1P//Q5FlaL+a
   euwYLAK7vKS6HZWsUDRcB+wGCSF5DqUzp2HlANT8qkE+ULCovJmowtlgP
   FpQjql3+uG5SyfIgbnzMTBx3JxzpQHZdHiVClP0LpbZCb89rrZA1G7Jjm
   haZZAkuL0bFn3r0wnwSKz7rvi319FrY9hl8XpfxSZ8D4W3wzkYup2bGQ0
   Kl97l6zUtsSX7aDcKcF4gP4t+zY1vN0bGIncG9QFvp701ztplmXvkfBzM
   Q==;
X-CSE-ConnectionGUID: pykfFF8bRJqh3XCxyaym+A==
X-CSE-MsgGUID: UiwBZhklT52GQkv/mJh5hA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17169242"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="17169242"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 04:23:48 -0700
X-CSE-ConnectionGUID: EUxb2xOGTrmru1djNZ0m1g==
X-CSE-MsgGUID: 0wMy7eFdTOShbSuYwBGt9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="66277177"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 29 May 2024 04:23:46 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 iwl-net 3/8] ice: replace synchronize_rcu with synchronize_net
Date: Wed, 29 May 2024 13:23:32 +0200
Message-Id: <20240529112337.3639084-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240529112337.3639084-1-maciej.fijalkowski@intel.com>
References: <20240529112337.3639084-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Given that ice_qp_dis() is called under rtnl_lock, synchronize_net() can
be called instead of synchronize_rcu() so that XDP rings can finish its
job in a faster way. Also let us do this as earlier in XSK queue disable
flow.

Additionally, turn off regular Tx queue before disabling irqs and NAPI.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 4f606a1055b0..e93cb0ca4106 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -53,7 +53,6 @@ static void ice_qp_clean_rings(struct ice_vsi *vsi, u16 q_idx)
 {
 	ice_clean_tx_ring(vsi->tx_rings[q_idx]);
 	if (ice_is_xdp_ena_vsi(vsi)) {
-		synchronize_rcu();
 		ice_clean_tx_ring(vsi->xdp_rings[q_idx]);
 	}
 	ice_clean_rx_ring(vsi->rx_rings[q_idx]);
@@ -180,11 +179,12 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 		usleep_range(1000, 2000);
 	}
 
+	synchronize_net();
+	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+
 	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
 	ice_qvec_toggle_napi(vsi, q_vector, false);
 
-	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
-
 	ice_fill_txq_meta(vsi, tx_ring, &txq_meta);
 	err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
 	if (err)
-- 
2.34.1


