Return-Path: <netdev+bounces-130808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B11BC98B9D8
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FC7281A5A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B51F1A0B1D;
	Tue,  1 Oct 2024 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PGITPnub"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7116813D281
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779243; cv=none; b=FH26yz4GMsALxblJVvRQM3RNpbmKP1H8aoj6/yrwj3grqcopA7J92wkNIB/wu+eUufDIZkAU4/wsfkDxTPWjP06hFMkBx21ajldeDC1Jg6NY5oRcDnU3XgOAlpEtiI4ALbtnQYG1A1ItXUX1z43V0wzV+HrAgAUFsj4z6HAbn38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779243; c=relaxed/simple;
	bh=favQJ08S3GD3fpRIXfVi+f0h0K8D7FxMKB7j5mwzoWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=td3Wh8ZbcQlTJE4aGjo3OSJH8P8o153oAmXrnbGf7N1ChkB0B2HoJ4RecN+kzjtSTxXMP3EkLR8PCauH2eUUOLTd4LsI2BB/7pRZBJdVhBF9/XlQgR3IdzbjVaSXL69K1koVDJzUALndqDfrAzMHnxOqlmbMaLdigW3Nf+1JQ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PGITPnub; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727779242; x=1759315242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=favQJ08S3GD3fpRIXfVi+f0h0K8D7FxMKB7j5mwzoWM=;
  b=PGITPnubhvd6on//rTZFF1It+0KmFU85zwH817MGPB2DbruoUQoSzcJw
   VbZ5pVXchFJkg17MITFNS+KfD2x8lyjKg87GvzGOFbkvlN3SL/AgoROx2
   DBANoTAwWZge+s8M37hIG0Iz8BDQgoCwGBeI+LnPsiH//z+VK2XTriHd3
   1MscjYUDylWWIZ1TpO2peS5ZCx3+IxkPlUMNMBmTg9khNnSdWjwM7OQYw
   D3NPMe0tE8TOVbOBIYO5A8hNVS6SerqJ9zsw4Vi/yleaFSeDAnFff5+ch
   MXZkylht4zOvvPe7DN+EwSyKl6BTvXeCc0GB5IzN/zDKSNVImdTXTEl/t
   Q==;
X-CSE-ConnectionGUID: qrjkRxoISXmvssSyeDq0kw==
X-CSE-MsgGUID: hJL1jYP5TvSw1pyWvmeNBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="44433909"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="44433909"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 03:40:40 -0700
X-CSE-ConnectionGUID: llciu50lSn+hze5/faYmxg==
X-CSE-MsgGUID: 9zopoR2oSw61amogfslQtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="104447762"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 01 Oct 2024 03:40:38 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 314AE27BC5;
	Tue,  1 Oct 2024 11:40:36 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next 1/2] ice: rework of dump serdes equalizer values feature
Date: Tue,  1 Oct 2024 06:26:04 -0400
Message-Id: <20241001102605.4526-2-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241001102605.4526-1-mateusz.polchlopek@intel.com>
References: <20241001102605.4526-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor function ice_get_tx_rx_equa() to iterate over new table of
params instead of multiple calls to ice_aq_get_phy_equalization().

Subsequent commit will extend that function by add more serdes equalizer
values to dump.

Shorten the fields of struct ice_serdes_equalization_to_ethtool for
readability purposes.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 93 ++++++--------------
 drivers/net/ethernet/intel/ice/ice_ethtool.h | 22 ++---
 2 files changed, 38 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 2924ac61300d..19e7a9d93928 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -693,75 +693,36 @@ static int ice_get_port_topology(struct ice_hw *hw, u8 lport,
 static int ice_get_tx_rx_equa(struct ice_hw *hw, u8 serdes_num,
 			      struct ice_serdes_equalization_to_ethtool *ptr)
 {
+	static const int tx = ICE_AQC_OP_CODE_TX_EQU;
+	static const int rx = ICE_AQC_OP_CODE_RX_EQU;
+	struct {
+		int data_in;
+		int opcode;
+		int *out;
+	} aq_params[] = {
+		{ ICE_AQC_TX_EQU_PRE1, tx, &ptr->tx_equ_pre1 },
+		{ ICE_AQC_TX_EQU_PRE3, tx, &ptr->tx_equ_pre3 },
+		{ ICE_AQC_TX_EQU_ATTEN, tx, &ptr->tx_equ_atten },
+		{ ICE_AQC_TX_EQU_POST1, tx, &ptr->tx_equ_post1 },
+		{ ICE_AQC_TX_EQU_PRE2, tx, &ptr->tx_equ_pre2 },
+		{ ICE_AQC_RX_EQU_PRE2, rx, &ptr->rx_equ_pre2 },
+		{ ICE_AQC_RX_EQU_PRE1, rx, &ptr->rx_equ_pre1 },
+		{ ICE_AQC_RX_EQU_POST1, rx, &ptr->rx_equ_post1 },
+		{ ICE_AQC_RX_EQU_BFLF, rx, &ptr->rx_equ_bflf },
+		{ ICE_AQC_RX_EQU_BFHF, rx, &ptr->rx_equ_bfhf },
+		{ ICE_AQC_RX_EQU_DRATE, rx, &ptr->rx_equ_drate },
+	};
 	int err;
 
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_TX_EQU_PRE1,
-					  ICE_AQC_OP_CODE_TX_EQU, serdes_num,
-					  &ptr->tx_equalization_pre1);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_TX_EQU_PRE3,
-					  ICE_AQC_OP_CODE_TX_EQU, serdes_num,
-					  &ptr->tx_equalization_pre3);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_TX_EQU_ATTEN,
-					  ICE_AQC_OP_CODE_TX_EQU, serdes_num,
-					  &ptr->tx_equalization_atten);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_TX_EQU_POST1,
-					  ICE_AQC_OP_CODE_TX_EQU, serdes_num,
-					  &ptr->tx_equalization_post1);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_TX_EQU_PRE2,
-					  ICE_AQC_OP_CODE_TX_EQU, serdes_num,
-					  &ptr->tx_equalization_pre2);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_RX_EQU_PRE2,
-					  ICE_AQC_OP_CODE_RX_EQU, serdes_num,
-					  &ptr->rx_equalization_pre2);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_RX_EQU_PRE1,
-					  ICE_AQC_OP_CODE_RX_EQU, serdes_num,
-					  &ptr->rx_equalization_pre1);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_RX_EQU_POST1,
-					  ICE_AQC_OP_CODE_RX_EQU, serdes_num,
-					  &ptr->rx_equalization_post1);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_RX_EQU_BFLF,
-					  ICE_AQC_OP_CODE_RX_EQU, serdes_num,
-					  &ptr->rx_equalization_bflf);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_RX_EQU_BFHF,
-					  ICE_AQC_OP_CODE_RX_EQU, serdes_num,
-					  &ptr->rx_equalization_bfhf);
-	if (err)
-		return err;
-
-	err = ice_aq_get_phy_equalization(hw, ICE_AQC_RX_EQU_DRATE,
-					  ICE_AQC_OP_CODE_RX_EQU, serdes_num,
-					  &ptr->rx_equalization_drate);
-	if (err)
-		return err;
+	for (int i = 0; i < ARRAY_SIZE(aq_params); i++) {
+		err = ice_aq_get_phy_equalization(hw, aq_params[i].data_in,
+						  aq_params[i].opcode,
+						  serdes_num, aq_params[i].out);
+		if (err)
+			break;
+	}
 
-	return 0;
+	return err;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.h b/drivers/net/ethernet/intel/ice/ice_ethtool.h
index 9acccae38625..98eb9c51d687 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.h
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.h
@@ -10,17 +10,17 @@ struct ice_phy_type_to_ethtool {
 };
 
 struct ice_serdes_equalization_to_ethtool {
-	int rx_equalization_pre2;
-	int rx_equalization_pre1;
-	int rx_equalization_post1;
-	int rx_equalization_bflf;
-	int rx_equalization_bfhf;
-	int rx_equalization_drate;
-	int tx_equalization_pre1;
-	int tx_equalization_pre3;
-	int tx_equalization_atten;
-	int tx_equalization_post1;
-	int tx_equalization_pre2;
+	int rx_equ_pre2;
+	int rx_equ_pre1;
+	int rx_equ_post1;
+	int rx_equ_bflf;
+	int rx_equ_bfhf;
+	int rx_equ_drate;
+	int tx_equ_pre1;
+	int tx_equ_pre3;
+	int tx_equ_atten;
+	int tx_equ_post1;
+	int tx_equ_pre2;
 };
 
 struct ice_regdump_to_ethtool {
-- 
2.38.1


