Return-Path: <netdev+bounces-99005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F088D357E
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11E3286ACA
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC568181304;
	Wed, 29 May 2024 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4yY4Bmq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331F61802D4
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981833; cv=none; b=YpCeddrNjL827Mp9DCrtpcDLWEoZpLEfC1vQzVBSb162ZYHTqPhHg9WgzMIbI0BD07e+zYB8maIik2Zl3uQwa4E5lpA7wCGmcsm3V/YrPhHxx8M6NGr+sIuS/jkAD3kfbRdOT6qcTxcoEgd4gitVSvIzWKOoZAu1KUvEwfpO5QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981833; c=relaxed/simple;
	bh=Wa3f5Y5+AWIp0vcSDmjjHpoOXBSyhvET5vZlnTzOHrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fCAjH/FW7QLhBFfU++06Zii+Pq9Rvw+o0g1Ka5EtMmhBDcuyXC16SDZZd9wP8TPoXeV9ydvMF02qOHAfA5Ya6WrD7ETwI2vSQV4sCq1ZdSlvguQtHFLZrLtiWyw/KKmm/qWAdtlEp+UmpfXCOHS7kbUbKBd+MFXQ/g4q8kknOIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4yY4Bmq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716981832; x=1748517832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wa3f5Y5+AWIp0vcSDmjjHpoOXBSyhvET5vZlnTzOHrk=;
  b=G4yY4BmqJlFKpMIvC5JILiEySlcqo4Br3Nkc5dXVXIWObt/wbfP+FNGC
   5twntwG4Vc1k7kWYmMI6Kx6nNlcrepkHqZ3za+WvUrba1KmcKFQcKQMmr
   5zmoLdETRaicvhBupeJ/6L6vC7Lnxl5FCXsCh3h3cruYZM7mlJDFVWA9J
   chKot4qRnpEryijiqlRU19YjP1eXObC52k5xAvszKNUL1fdwBoKSaPKk3
   5XdVfvqeF6+2dDaOjTs8aWeP5UH3PDU/ovFFN6M4CvPTZH/HopYJ5cphb
   YXmdGgRIClNM+FPhibsCceO8LnzObaGum+VV98mef0HEh2OJce4FNhH15
   A==;
X-CSE-ConnectionGUID: fhngQHG4T3GToUlp7vK5Tw==
X-CSE-MsgGUID: B8UpBmRJToaJw4fR9yOUWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17169255"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="17169255"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 04:23:52 -0700
X-CSE-ConnectionGUID: +i7+PhsdR6qnDYolI13umQ==
X-CSE-MsgGUID: 1QTru7CTQJ+emebKffbWKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="66277184"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 29 May 2024 04:23:50 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 iwl-net 5/8] ice: toggle netif_carrier when setting up XSK pool
Date: Wed, 29 May 2024 13:23:34 +0200
Message-Id: <20240529112337.3639084-6-maciej.fijalkowski@intel.com>
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

This so we prevent Tx timeout issues. One of conditions checked on
running in the background dev_watchdog() is netif_carrier_ok(), so let
us turn it off when we disable the queues that belong to a q_vector
where XSK pool is being configured.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 3dcab89be256..8c5006f37310 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -181,6 +181,7 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	}
 
 	synchronize_net();
+	netif_carrier_off(vsi->netdev);
 	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 
 	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
@@ -250,6 +251,7 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 	ice_qvec_ena_irq(vsi, q_vector);
 
 	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+	netif_carrier_on(vsi->netdev);
 	clear_bit(ICE_CFG_BUSY, vsi->state);
 
 	return fail;
-- 
2.34.1


