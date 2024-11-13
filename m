Return-Path: <netdev+bounces-144541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8539C7BAA
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E341F21927
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150DF2040B1;
	Wed, 13 Nov 2024 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WIj7KtMj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6123E2038DD
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524081; cv=none; b=lt1cuQazYOREEqZ6Ox2HAYdhHa6G3OeRBz26FNaFFWXoJWg6Y4kqzXM877kPhB7Ga5B8SdScweznayYLsnZ6SIaUjY1vUW1nG87hW67FO62V7WbapbI+S5zkjhTBYsinotyDbTpkC7g/ZTqdYDbvYVL1M4ZRuFVCT7+yM8NEkvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524081; c=relaxed/simple;
	bh=TIC2QdQx5U34H3HB0pxT4WJopJ2DGZhTuzBYTpfa7Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5r5eOr/E8DMejxCiZjHy59PuppU6ljUlYufV2olrC3lu0W5QrPI/5edSUW5xT5f72iOFGVuouaSZjYFvtOUOIwktA7RYIcyfqs0cOK/YkGMnoD1WXkpIl2aiNQG6cGXxbfcyz9sqaPdVNBHG+KvHaCMAeMgHiudVjhnW+2RlIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WIj7KtMj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731524080; x=1763060080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TIC2QdQx5U34H3HB0pxT4WJopJ2DGZhTuzBYTpfa7Kk=;
  b=WIj7KtMjrtZ10hdv0x/LvRAcXwBETIdJigLyKpaxHDmY0bcbM8Tw33zd
   qWrlyos6D1huePF8OqrHazMYaFdzbC7VEhlhn7WYDufvd1sUUX8WO4o1G
   2TwznXoUhoLpKyCCap9v0kPjM0mOYDQVwnYtUbIyFiQhiYmX2ejd/jc0L
   v2Fl7EpymU+4cDgIfoqdEgtnXxr2I/6QgngV9zX3ge1QDbDjjCT+OLEUY
   47SY5Ro2usPZdJvIXsKoodqyQd/3NL6KHlygWjdDimpWrIOwVLqHDdIY4
   /rPzjq7bWEry4yfmr+H7EdDf/F0rgAhQwdMIwVVew471asPRd8s4S/cCE
   g==;
X-CSE-ConnectionGUID: 3hzdz/0gRAuhyoY5HwXdTQ==
X-CSE-MsgGUID: O0Y2X7iCQ/ah38X/9Eu3SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31589469"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31589469"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 10:54:38 -0800
X-CSE-ConnectionGUID: r+lOWVTRRtC3JnPzGgoI5g==
X-CSE-MsgGUID: /EEN2UGvTCanGiKIAC4I9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="87520721"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Nov 2024 10:54:37 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 01/14] ice: rework of dump serdes equalizer values feature
Date: Wed, 13 Nov 2024 10:54:16 -0800
Message-ID: <20241113185431.1289708-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241113185431.1289708-1-anthony.l.nguyen@intel.com>
References: <20241113185431.1289708-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Refactor function ice_get_tx_rx_equa() to iterate over new table of
params instead of multiple calls to ice_aq_get_phy_equalization().

Subsequent commit will extend that function by add more serdes equalizer
values to dump.

Shorten the fields of struct ice_serdes_equalization_to_ethtool for
readability purposes.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.42.0


