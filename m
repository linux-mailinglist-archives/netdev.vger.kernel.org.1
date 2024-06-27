Return-Path: <netdev+bounces-107297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 987B191A7BB
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4ED6B26EF9
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D8119412E;
	Thu, 27 Jun 2024 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbOhJ9ko"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77FC193099
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494343; cv=none; b=XhWWGucAF8QqfyqVnWTwL/w7yFgNL7Xxz+y809dOo4ONxL4MyqWtVd4Da7sSF3kEJwwLCr3hrwcxGUAHZFZCaXYBjTGyr3msnlhEkQqWdxMeG+RGqKjkATRGUDQh+esphK0XvUgOfJVNvj50oUkAQPvqru7AXLEagKG6Re6qCLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494343; c=relaxed/simple;
	bh=ua5dTpw+9qCBRIHWSRrOzgeAU3++bdFfmcyuB6QgoB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IAnht45/MuNkk8hBLGqqprdEhn4dvcXS70PzLzsUXuk6lVoyQRO43lclkkTEmUD09kk3Vz/g+clZfkUGXSUPpo5Nb9Tt5BneprZlFXMRCS8mFHE0cTJ4heH6FuDs/B/sJbk7K45KdP3mXJcoXf8vqSEpgwhbvmIZXnOSMU3KUnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbOhJ9ko; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719494342; x=1751030342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ua5dTpw+9qCBRIHWSRrOzgeAU3++bdFfmcyuB6QgoB4=;
  b=FbOhJ9koMe7UcLoaEeLf7/4A7ltI+OpfuBObTfJQ1lLkvAKerurg/VXi
   C9VmcgSQYq8+u+dUvPxk+ZW9G1R5WLWmpI7P4xzUhrd62X58ai6CwzIDG
   ze24rnvOOlfWDNqCb1581c0V/Vw9x4dB0EunGPcJrK57QTnaLcml1IWNY
   8HrxxSwIV+FCRRFcQ71fC/k1+Uu1/W84OSzQjdEa7ZMwnPdk37xSU8p72
   0Uvdbzczc+6XQLGJXZ+1qVdhykM7oaPMc9M0OjxBlb1Um+jUjOiWaBzem
   bGGBPT2KpAO97DtIibCkBam9hcFO8kjI0rhxIKmHT7ybMsbRM8/LaZPff
   A==;
X-CSE-ConnectionGUID: /P+Q6xbTToKy9saKLfwcaQ==
X-CSE-MsgGUID: 68aJPVSZRSezO7PjPZD9Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16452374"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="16452374"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 06:19:02 -0700
X-CSE-ConnectionGUID: gz9QdukTRpGSHyG58YYJfg==
X-CSE-MsgGUID: Ze7wdeLZR8+H+9p0zT8ZsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="49315432"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 27 Jun 2024 06:18:59 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	larysa.zaremba@intel.com,
	jacob.e.keller@intel.com,
	aleksander.lobakin@intel.com,
	michal.kubiak@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH v4 iwl-net 7/8] ice: add missing WRITE_ONCE when clearing ice_rx_ring::xdp_prog
Date: Thu, 27 Jun 2024 15:17:56 +0200
Message-Id: <20240627131757.144991-8-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240627131757.144991-1-maciej.fijalkowski@intel.com>
References: <20240627131757.144991-1-maciej.fijalkowski@intel.com>
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
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
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


