Return-Path: <netdev+bounces-152125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E27F9F2C72
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D0918895D5
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3DF20011E;
	Mon, 16 Dec 2024 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mc4kDPp7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C1F201034
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734339399; cv=none; b=pgb6sS3YgNA8uti86/4y2CxS7OuA92kcBTs/b0hvKbphZucjzp4V4Sy1Cak0f26A38y+ZW/8S+XHkyLbrFMHo/Wo69KelqhvhyoUAy/9BbQGAEdli4xgLm5eDw1nYhot+r5mXDC2lJ9eFmKv1OI3LHMDL766MZA72oGJ8UjM630=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734339399; c=relaxed/simple;
	bh=wW04zKWG6V/TS0MxKlNCR/JaRvA5BUZD2MRR6W8uDic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPPGgT+l8NGIERpqKrYHpgiw6/M5B3/s3xpCOFBWou72BAdRscEuBxZR4WpsV8oAXbuBjOPeqLIM05xL2Fn2ZBTYU/56v38X31GjNndxib9YsgHAhezSsHDuDLjlqlPMU/CmVi62xZ0miQk+3rfaZi315IX+7xdKv3tMUAwRW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mc4kDPp7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734339398; x=1765875398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wW04zKWG6V/TS0MxKlNCR/JaRvA5BUZD2MRR6W8uDic=;
  b=Mc4kDPp7x/BfuUkbD8Kf45lAsrM/m8ew/ubqwlnh5JbCTaxjSqZOB6nN
   omJshKGwH639o93VRUSeLFn5lWotzN5/eweX/+ajbK74LZFUbKaWblFRc
   0XLm8fPn6WHqhvESerYVHygYQDlmwmuTZ4Q0k1yzPeQtk1DIkdC9FqvD+
   UEt0niQaEGOaVnGHNpAfnpGO4gFgGFFKmjy9xEAdPlzfjJO66glwtZ5nk
   JkzDlBr4uYrIJUeuBS2Npk+g61RPBuWoqE2jkREbM1lBXoQnXJ0aNM4Qu
   D8PN4gLeS39RWD7MbMjFrWU7wfC0adKNUtgAEmCmGjqwEXz+SI52/qsuv
   g==;
X-CSE-ConnectionGUID: odCYwd94SNGfny2Rxq6FGA==
X-CSE-MsgGUID: IbxWLOWER36zG/7K93tw0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34942407"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="34942407"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 00:56:36 -0800
X-CSE-ConnectionGUID: pRm7sM6XR8CKKTk+fVbE4A==
X-CSE-MsgGUID: 9bMnidh6Sze03PSaZnMJmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102117193"
Received: from host61.igk.intel.com ([10.123.220.61])
  by orviesa005.jf.intel.com with ESMTP; 16 Dec 2024 00:56:33 -0800
From: Anton Nadezhdin <anton.nadezhdin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Anton Nadezhdin <anton.nadezhdin@intel.com>
Subject: [PATCH iwl-next v2 4/5] ice: check low latency PHY timer update firmware capability
Date: Mon, 16 Dec 2024 09:53:31 -0500
Message-ID: <20241216145453.333745-5-anton.nadezhdin@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241216145453.333745-1-anton.nadezhdin@intel.com>
References: <20241216145453.333745-1-anton.nadezhdin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Newer versions of firmware support programming the PHY timer via the low
latency interface exposed over REG_LL_PROXY_L and REG_LL_PROXY_H. Add
support for checking the device capabilities for this feature.

Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 3 +++
 drivers/net/ethernet/intel/ice/ice_type.h   | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 7b5cab253ce1..856e7417bb18 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2527,6 +2527,7 @@ ice_parse_1588_dev_caps(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
 
 	info->ts_ll_read = ((number & ICE_TS_LL_TX_TS_READ_M) != 0);
 	info->ts_ll_int_read = ((number & ICE_TS_LL_TX_TS_INT_READ_M) != 0);
+	info->ll_phy_tmr_update = ((number & ICE_TS_LL_PHY_TMR_UPDATE_M) != 0);
 
 	info->ena_ports = logical_id;
 	info->tmr_own_map = phys_id;
@@ -2549,6 +2550,8 @@ ice_parse_1588_dev_caps(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
 		  info->ts_ll_read);
 	ice_debug(hw, ICE_DBG_INIT, "dev caps: ts_ll_int_read = %u\n",
 		  info->ts_ll_int_read);
+	ice_debug(hw, ICE_DBG_INIT, "dev caps: ll_phy_tmr_update = %u\n",
+		  info->ll_phy_tmr_update);
 	ice_debug(hw, ICE_DBG_INIT, "dev caps: ieee_1588 ena_ports = %u\n",
 		  info->ena_ports);
 	ice_debug(hw, ICE_DBG_INIT, "dev caps: tmr_own_map = %u\n",
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 819dfff8370d..727ac9a9c571 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -369,6 +369,7 @@ struct ice_ts_func_info {
 #define ICE_TS_TMR1_ENA_M		BIT(26)
 #define ICE_TS_LL_TX_TS_READ_M		BIT(28)
 #define ICE_TS_LL_TX_TS_INT_READ_M	BIT(29)
+#define ICE_TS_LL_PHY_TMR_UPDATE_M	BIT(30)
 
 struct ice_ts_dev_info {
 	/* Device specific info */
@@ -383,6 +384,7 @@ struct ice_ts_dev_info {
 	u8 tmr1_ena;
 	u8 ts_ll_read;
 	u8 ts_ll_int_read;
+	u8 ll_phy_tmr_update;
 };
 
 #define ICE_NAC_TOPO_PRIMARY_M	BIT(0)
-- 
2.42.0


