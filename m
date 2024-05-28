Return-Path: <netdev+bounces-98567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236FF8D1C95
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30C8284B7E
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38CF172796;
	Tue, 28 May 2024 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="isKN1ueT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5CA171E64
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902140; cv=none; b=j82AM5hB8i/oIM+RI2RkLWDLCn1cMu2MpyB7CMEIcS6XEJRFCq73jkS/fQ7KwAhnI3LxQE7nKXIsyBMvq/tlazwtivge2WROu/8UG1HNj4jJTIFk03xI8tiX2cuZDFvTnH4jxWEg1Cps09zTPrwRVl9daIX3YY8Em0gKCF8jBkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902140; c=relaxed/simple;
	bh=kIt/ZTFBn9CaI96lLJdikL/BzSIZijxoQUVVgIOAlUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e1K1Xa1m8fcH1iVSKRxLEyaK8arvCZTmxyVnHmbqfrGqOuTp8RcwCXcknW5qnTdNwZzAgbAwWoVYQvu/PgywNRzZybVLqTrAWlBTlPaMkJtFTOuVioxM4cvj6Pq7/lrcP1vfwwdR/RobmHA7sMY1ZyRkppZa84v70FGQyhJNR3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=isKN1ueT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716902140; x=1748438140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kIt/ZTFBn9CaI96lLJdikL/BzSIZijxoQUVVgIOAlUE=;
  b=isKN1ueTlOY6mBe8J8Uzo/W+q0g2jFlMuBxBAVwSl1KiXlaU9bTIoTs1
   CHBiBEZzJ9AUH6pg0BxQqtizBfzpZL2+4tYT4c2oEJGyH34gcqkYPRac9
   RywGz6lPg1FhA1paYonsIEdDtPTQmSouXcKeC4+n06wltp/b9cbyLXhD7
   86nNRcFQZJ6i4WWWS8xPhvRdVDk3Wqwpn/Q/nnc7FvvA+eLRJ3dIySAMQ
   ibjKd81RYE7NtwDF0p1yKqxdTQeXCIhB5MuXGtF2CDbtxbbHjdSoCV1GN
   A5ROeLVaiwS0KZwogaiXqHEUAbKSvXWrDO+uZ3E2lRggTf7M/456K3BAf
   g==;
X-CSE-ConnectionGUID: Fp+8rCBTSmS9at7xyAZVRg==
X-CSE-MsgGUID: /UWPohz7Sre5ymBoAT6b7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13193539"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13193539"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:15:40 -0700
X-CSE-ConnectionGUID: oOTIR56jR+C4jLxYQEJyqg==
X-CSE-MsgGUID: sf69Gwt4RLKQXloVN8OBpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39891136"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 28 May 2024 06:15:37 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-net 05/11] ice: toggle netif_carrier when setting up XSK pool
Date: Tue, 28 May 2024 15:14:23 +0200
Message-Id: <20240528131429.3012910-6-maciej.fijalkowski@intel.com>
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

In order to prevent Tx timeout issues, toggle the netif_carrier when
disabling and enabling queue pair during XSK pool setup. One of
conditions checked on running in the background dev_watchdog() is
netif_carrier_ok(), so let us turn it off when we disable the queues
that belong to a q_vector where XSK pool is being configured.

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


