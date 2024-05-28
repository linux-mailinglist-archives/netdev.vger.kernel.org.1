Return-Path: <netdev+bounces-98569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10E18D1CAB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CADA284F23
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E0717555C;
	Tue, 28 May 2024 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNlmWysk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1140016F289
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902145; cv=none; b=gT4/iyn4hbjykzfvqvhozckpzuqwC0z8WHHsLtSJ5Mbz4Vlgto0pEv4XtcFKAsgF7hiR+viAA392eZpk7C4AazaQ4HYRMnaFCqTSdTvKwBRCAi6uXLds1QqaAyF9pGT7kF1fwgck9V2h511mtClpfrVEj5EWBSXXjHUcNaEep1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902145; c=relaxed/simple;
	bh=4Tu1vWmHZq1dZhCwiajusm9P0b3jYlUYGR9h4gmDQJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YCzJx46JWegK0SRXixcde0a5ukBjArTnqBgz6EM6qGIiVh/Ja5TFjUVSWqoPPqpqhg6Y4CNNlt4BIfTde2hl2liGu9VzhpGHl9yAP+QGGixABEGiuTeJ9+6PVxVZp+sHsvmwidXTJF29bHpGdP6zctU2XbRXSAuVGuS/h72l5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNlmWysk; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716902145; x=1748438145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Tu1vWmHZq1dZhCwiajusm9P0b3jYlUYGR9h4gmDQJg=;
  b=JNlmWyskgXH4Q2iiyWHWbSVaca4B9WR7UoqdPyBIZcxNbLO/AWs5wVQ+
   GRnOTf6/L17ldsR1C8iQjjf8X3jnybjlKI7F59yO4qyFZ2Mc87NbDqxW7
   A/UihK4DGLG7GAMhnyyfE/tFFdMBQ5L2EZ/bhVoEZadCvq/33u0BOIb9U
   oidnMULmKUxksesUnn4cjxLqkWNid3G1DRJxJ2jSjnOs2Elm8U619/vnz
   P36iFESxAfsTJm6W1eNtvlOudnjRcqXoyEiyM8winQHAfkZ8N0d4sX+Nf
   r+MoQEaKf1aIWbER4IElx+6SpHGTX9cjt3Tc4fth93Y8EfpysWix2ilSW
   A==;
X-CSE-ConnectionGUID: ut/3Id7tSLmuUD5kE1UsgQ==
X-CSE-MsgGUID: OW5ViS/BSXOu3bFdMZ/f8w==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13193552"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13193552"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:15:44 -0700
X-CSE-ConnectionGUID: J6Ag7psJQYS+bugeluUNug==
X-CSE-MsgGUID: yR1PiVKwQki+JoWWuV67yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39891155"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 28 May 2024 06:15:42 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-net 07/11] ice: add missing WRITE_ONCE when clearing ice_rx_ring::xdp_prog
Date: Tue, 28 May 2024 15:14:25 +0200
Message-Id: <20240528131429.3012910-8-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240528131429.3012910-1-maciej.fijalkowski@intel.com>
References: <20240528131429.3012910-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is read by data path and modified from process context on remote cpu
so it is needed to use WRITE_ONCE to clear the pointer.

Fixes: efc2214b6047 ("ice: Add support for XDP")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index f4b2b1bca234..4c115531beba 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -456,7 +456,7 @@ void ice_free_rx_ring(struct ice_rx_ring *rx_ring)
 	if (rx_ring->vsi->type == ICE_VSI_PF)
 		if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
 			xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
-	rx_ring->xdp_prog = NULL;
+	WRITE_ONCE(rx_ring->xdp_prog, NULL);
 	if (rx_ring->xsk_pool) {
 		kfree(rx_ring->xdp_buf);
 		rx_ring->xdp_buf = NULL;
-- 
2.34.1


