Return-Path: <netdev+bounces-82645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6ED88EEA7
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 19:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3401C2914BC
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 18:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57D614F9D4;
	Wed, 27 Mar 2024 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ae9v2Z+b"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B3614E2D5
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565730; cv=none; b=Z+0UmGqnVCyBZsNJmbS2wnUX11Qex7qiNWapT9EIyPFbsrIugcaDwtSUDTDGg/cNOqxwprpKfLE8YVyi9ipgU1r0K9u8k7dEwamCqRj3z9IvyE24YwFyLFk/OOZhQPOZfHs8fErTZUMOQhFqJu/pBUFZiB7Qp3pDN2DTMG3wmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565730; c=relaxed/simple;
	bh=CelC2R3SRNDS71DG13kKx8tsMgNEIqTPUpU7RqqY2rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqxTimQN4wk2LHdeY5HCZr457nAUSia15OmJnjJRhmsf5XJPYf3vzcUPW+pctA3KWJ2iEyLVZQUnqXjsWmbf4OVQWmmmzGEJaBozY9cisebvr4PJJ35fEmxnPhbUntTS8ueF6rwrlfUvG/YP0ubxO77blIb5+yV0ePOBMybtjc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ae9v2Z+b; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711565730; x=1743101730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CelC2R3SRNDS71DG13kKx8tsMgNEIqTPUpU7RqqY2rk=;
  b=ae9v2Z+bZHald5Qya0rv43N7NiieSdPTr3KQTQ/wmeZhsjxtlTqz01yv
   g2S5cKsDSaSMlUMW7oON3Z9gSE7NcZt9J3JIhysleoO1ivHScfzgGpK4D
   kj6De2VffIwNp5xmGmg5Jm1HHYktgXvMllGm/VoJzFPn0Y6E66k05mDY8
   9kJoh8xY1ABxD56ZIxPk6SnO7za9+/samvipmdWQnn+VavAPihRx4uyfO
   mzZaNZ47Q4wf1MrT1Hk7lm6hvY9obUAGI+fc7iC3o+yhi6pC4kOr9KW89
   NEemdZYrasxMzEFYd+BGz8I6ppTlAn6ynkJGbzUrE5pkW6m2KmBBbQx1z
   Q==;
X-CSE-ConnectionGUID: Y9oMgAgvTNCC54S2Rawa/A==
X-CSE-MsgGUID: q6bB03iSQaOBbpIE+0qhWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="18122791"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="18122791"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 11:55:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16470602"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 11:55:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	Nikolay Mushayev <nikolay.mushayev@intel.com>,
	Nir Efrati <nir.efrati@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net 1/2] e1000e: Workaround for sporadic MDI error on Meteor Lake systems
Date: Wed, 27 Mar 2024 11:55:12 -0700
Message-ID: <20240327185517.2587564-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240327185517.2587564-1-anthony.l.nguyen@intel.com>
References: <20240327185517.2587564-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

On some Meteor Lake systems accessing the PHY via the MDIO interface may
result in an MDI error. This issue happens sporadically and in most cases
a second access to the PHY via the MDIO interface results in success.

As a workaround, introduce a retry counter which is set to 3 on Meteor
Lake systems. The driver will only return an error if 3 consecutive PHY
access attempts fail. The retry mechanism is disabled in specific flows,
where MDI errors are expected.

Fixes: cc23f4f0b6b9 ("e1000e: Add support for Meteor Lake")
Suggested-by: Nikolay Mushayev <nikolay.mushayev@intel.com>
Co-developed-by: Nir Efrati <nir.efrati@intel.com>
Signed-off-by: Nir Efrati <nir.efrati@intel.com>
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/hw.h      |   2 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c |  33 ++++
 drivers/net/ethernet/intel/e1000e/phy.c     | 182 ++++++++++++--------
 drivers/net/ethernet/intel/e1000e/phy.h     |   2 +
 4 files changed, 150 insertions(+), 69 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index 1fef6bb5a5fb..4b6e7536170a 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -628,6 +628,7 @@ struct e1000_phy_info {
 	u32 id;
 	u32 reset_delay_us;	/* in usec */
 	u32 revision;
+	u32 retry_count;
 
 	enum e1000_media_type media_type;
 
@@ -644,6 +645,7 @@ struct e1000_phy_info {
 	bool polarity_correction;
 	bool speed_downgraded;
 	bool autoneg_wait_to_complete;
+	bool retry_enabled;
 };
 
 struct e1000_nvm_info {
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 19e450a5bd31..d8e97669f31b 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -222,11 +222,18 @@ static bool e1000_phy_is_accessible_pchlan(struct e1000_hw *hw)
 	if (hw->mac.type >= e1000_pch_lpt) {
 		/* Only unforce SMBus if ME is not active */
 		if (!(er32(FWSM) & E1000_ICH_FWSM_FW_VALID)) {
+			/* Switching PHY interface always returns MDI error
+			 * so disable retry mechanism to avoid wasting time
+			 */
+			e1000e_disable_phy_retry(hw);
+
 			/* Unforce SMBus mode in PHY */
 			e1e_rphy_locked(hw, CV_SMB_CTRL, &phy_reg);
 			phy_reg &= ~CV_SMB_CTRL_FORCE_SMBUS;
 			e1e_wphy_locked(hw, CV_SMB_CTRL, phy_reg);
 
+			e1000e_enable_phy_retry(hw);
+
 			/* Unforce SMBus mode in MAC */
 			mac_reg = er32(CTRL_EXT);
 			mac_reg &= ~E1000_CTRL_EXT_FORCE_SMBUS;
@@ -310,6 +317,11 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 		goto out;
 	}
 
+	/* There is no guarantee that the PHY is accessible at this time
+	 * so disable retry mechanism to avoid wasting time
+	 */
+	e1000e_disable_phy_retry(hw);
+
 	/* The MAC-PHY interconnect may be in SMBus mode.  If the PHY is
 	 * inaccessible and resetting the PHY is not blocked, toggle the
 	 * LANPHYPC Value bit to force the interconnect to PCIe mode.
@@ -380,6 +392,8 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 		break;
 	}
 
+	e1000e_enable_phy_retry(hw);
+
 	hw->phy.ops.release(hw);
 	if (!ret_val) {
 
@@ -449,6 +463,11 @@ static s32 e1000_init_phy_params_pchlan(struct e1000_hw *hw)
 
 	phy->id = e1000_phy_unknown;
 
+	if (hw->mac.type == e1000_pch_mtp) {
+		phy->retry_count = 2;
+		e1000e_enable_phy_retry(hw);
+	}
+
 	ret_val = e1000_init_phy_workarounds_pchlan(hw);
 	if (ret_val)
 		return ret_val;
@@ -1146,6 +1165,11 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	if (ret_val)
 		goto out;
 
+	/* Switching PHY interface always returns MDI error
+	 * so disable retry mechanism to avoid wasting time
+	 */
+	e1000e_disable_phy_retry(hw);
+
 	/* Force SMBus mode in PHY */
 	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &phy_reg);
 	if (ret_val)
@@ -1153,6 +1177,8 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	phy_reg |= CV_SMB_CTRL_FORCE_SMBUS;
 	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
 
+	e1000e_enable_phy_retry(hw);
+
 	/* Force SMBus mode in MAC */
 	mac_reg = er32(CTRL_EXT);
 	mac_reg |= E1000_CTRL_EXT_FORCE_SMBUS;
@@ -1313,6 +1339,11 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
 		/* Toggle LANPHYPC Value bit */
 		e1000_toggle_lanphypc_pch_lpt(hw);
 
+	/* Switching PHY interface always returns MDI error
+	 * so disable retry mechanism to avoid wasting time
+	 */
+	e1000e_disable_phy_retry(hw);
+
 	/* Unforce SMBus mode in PHY */
 	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &phy_reg);
 	if (ret_val) {
@@ -1333,6 +1364,8 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
 	phy_reg &= ~CV_SMB_CTRL_FORCE_SMBUS;
 	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
 
+	e1000e_enable_phy_retry(hw);
+
 	/* Unforce SMBus mode in MAC */
 	mac_reg = er32(CTRL_EXT);
 	mac_reg &= ~E1000_CTRL_EXT_FORCE_SMBUS;
diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
index 5e329156d1ba..93544f1cc2a5 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.c
+++ b/drivers/net/ethernet/intel/e1000e/phy.c
@@ -107,6 +107,16 @@ s32 e1000e_phy_reset_dsp(struct e1000_hw *hw)
 	return e1e_wphy(hw, M88E1000_PHY_GEN_CONTROL, 0);
 }
 
+void e1000e_disable_phy_retry(struct e1000_hw *hw)
+{
+	hw->phy.retry_enabled = false;
+}
+
+void e1000e_enable_phy_retry(struct e1000_hw *hw)
+{
+	hw->phy.retry_enabled = true;
+}
+
 /**
  *  e1000e_read_phy_reg_mdic - Read MDI control register
  *  @hw: pointer to the HW structure
@@ -118,55 +128,73 @@ s32 e1000e_phy_reset_dsp(struct e1000_hw *hw)
  **/
 s32 e1000e_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
 {
+	u32 i, mdic = 0, retry_counter, retry_max;
 	struct e1000_phy_info *phy = &hw->phy;
-	u32 i, mdic = 0;
+	bool success;
 
 	if (offset > MAX_PHY_REG_ADDRESS) {
 		e_dbg("PHY Address %d is out of range\n", offset);
 		return -E1000_ERR_PARAM;
 	}
 
+	retry_max = phy->retry_enabled ? phy->retry_count : 0;
+
 	/* Set up Op-code, Phy Address, and register offset in the MDI
 	 * Control register.  The MAC will take care of interfacing with the
 	 * PHY to retrieve the desired data.
 	 */
-	mdic = ((offset << E1000_MDIC_REG_SHIFT) |
-		(phy->addr << E1000_MDIC_PHY_SHIFT) |
-		(E1000_MDIC_OP_READ));
+	for (retry_counter = 0; retry_counter <= retry_max; retry_counter++) {
+		success = true;
 
-	ew32(MDIC, mdic);
+		mdic = ((offset << E1000_MDIC_REG_SHIFT) |
+			(phy->addr << E1000_MDIC_PHY_SHIFT) |
+			(E1000_MDIC_OP_READ));
 
-	/* Poll the ready bit to see if the MDI read completed
-	 * Increasing the time out as testing showed failures with
-	 * the lower time out
-	 */
-	for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
-		udelay(50);
-		mdic = er32(MDIC);
-		if (mdic & E1000_MDIC_READY)
-			break;
-	}
-	if (!(mdic & E1000_MDIC_READY)) {
-		e_dbg("MDI Read PHY Reg Address %d did not complete\n", offset);
-		return -E1000_ERR_PHY;
-	}
-	if (mdic & E1000_MDIC_ERROR) {
-		e_dbg("MDI Read PHY Reg Address %d Error\n", offset);
-		return -E1000_ERR_PHY;
-	}
-	if (FIELD_GET(E1000_MDIC_REG_MASK, mdic) != offset) {
-		e_dbg("MDI Read offset error - requested %d, returned %d\n",
-		      offset, FIELD_GET(E1000_MDIC_REG_MASK, mdic));
-		return -E1000_ERR_PHY;
+		ew32(MDIC, mdic);
+
+		/* Poll the ready bit to see if the MDI read completed
+		 * Increasing the time out as testing showed failures with
+		 * the lower time out
+		 */
+		for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
+			usleep_range(50, 60);
+			mdic = er32(MDIC);
+			if (mdic & E1000_MDIC_READY)
+				break;
+		}
+		if (!(mdic & E1000_MDIC_READY)) {
+			e_dbg("MDI Read PHY Reg Address %d did not complete\n",
+			      offset);
+			success = false;
+		}
+		if (mdic & E1000_MDIC_ERROR) {
+			e_dbg("MDI Read PHY Reg Address %d Error\n", offset);
+			success = false;
+		}
+		if (FIELD_GET(E1000_MDIC_REG_MASK, mdic) != offset) {
+			e_dbg("MDI Read offset error - requested %d, returned %d\n",
+			      offset, FIELD_GET(E1000_MDIC_REG_MASK, mdic));
+			success = false;
+		}
+
+		/* Allow some time after each MDIC transaction to avoid
+		 * reading duplicate data in the next MDIC transaction.
+		 */
+		if (hw->mac.type == e1000_pch2lan)
+			usleep_range(100, 150);
+
+		if (success) {
+			*data = (u16)mdic;
+			return 0;
+		}
+
+		if (retry_counter != retry_max) {
+			e_dbg("Perform retry on PHY transaction...\n");
+			mdelay(10);
+		}
 	}
-	*data = (u16)mdic;
 
-	/* Allow some time after each MDIC transaction to avoid
-	 * reading duplicate data in the next MDIC transaction.
-	 */
-	if (hw->mac.type == e1000_pch2lan)
-		udelay(100);
-	return 0;
+	return -E1000_ERR_PHY;
 }
 
 /**
@@ -179,56 +207,72 @@ s32 e1000e_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
  **/
 s32 e1000e_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
 {
+	u32 i, mdic = 0, retry_counter, retry_max;
 	struct e1000_phy_info *phy = &hw->phy;
-	u32 i, mdic = 0;
+	bool success;
 
 	if (offset > MAX_PHY_REG_ADDRESS) {
 		e_dbg("PHY Address %d is out of range\n", offset);
 		return -E1000_ERR_PARAM;
 	}
 
+	retry_max = phy->retry_enabled ? phy->retry_count : 0;
+
 	/* Set up Op-code, Phy Address, and register offset in the MDI
 	 * Control register.  The MAC will take care of interfacing with the
 	 * PHY to retrieve the desired data.
 	 */
-	mdic = (((u32)data) |
-		(offset << E1000_MDIC_REG_SHIFT) |
-		(phy->addr << E1000_MDIC_PHY_SHIFT) |
-		(E1000_MDIC_OP_WRITE));
+	for (retry_counter = 0; retry_counter <= retry_max; retry_counter++) {
+		success = true;
 
-	ew32(MDIC, mdic);
+		mdic = (((u32)data) |
+			(offset << E1000_MDIC_REG_SHIFT) |
+			(phy->addr << E1000_MDIC_PHY_SHIFT) |
+			(E1000_MDIC_OP_WRITE));
 
-	/* Poll the ready bit to see if the MDI read completed
-	 * Increasing the time out as testing showed failures with
-	 * the lower time out
-	 */
-	for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
-		udelay(50);
-		mdic = er32(MDIC);
-		if (mdic & E1000_MDIC_READY)
-			break;
-	}
-	if (!(mdic & E1000_MDIC_READY)) {
-		e_dbg("MDI Write PHY Reg Address %d did not complete\n", offset);
-		return -E1000_ERR_PHY;
-	}
-	if (mdic & E1000_MDIC_ERROR) {
-		e_dbg("MDI Write PHY Red Address %d Error\n", offset);
-		return -E1000_ERR_PHY;
-	}
-	if (FIELD_GET(E1000_MDIC_REG_MASK, mdic) != offset) {
-		e_dbg("MDI Write offset error - requested %d, returned %d\n",
-		      offset, FIELD_GET(E1000_MDIC_REG_MASK, mdic));
-		return -E1000_ERR_PHY;
-	}
+		ew32(MDIC, mdic);
 
-	/* Allow some time after each MDIC transaction to avoid
-	 * reading duplicate data in the next MDIC transaction.
-	 */
-	if (hw->mac.type == e1000_pch2lan)
-		udelay(100);
+		/* Poll the ready bit to see if the MDI read completed
+		 * Increasing the time out as testing showed failures with
+		 * the lower time out
+		 */
+		for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
+			usleep_range(50, 60);
+			mdic = er32(MDIC);
+			if (mdic & E1000_MDIC_READY)
+				break;
+		}
+		if (!(mdic & E1000_MDIC_READY)) {
+			e_dbg("MDI Write PHY Reg Address %d did not complete\n",
+			      offset);
+			success = false;
+		}
+		if (mdic & E1000_MDIC_ERROR) {
+			e_dbg("MDI Write PHY Reg Address %d Error\n", offset);
+			success = false;
+		}
+		if (FIELD_GET(E1000_MDIC_REG_MASK, mdic) != offset) {
+			e_dbg("MDI Write offset error - requested %d, returned %d\n",
+			      offset, FIELD_GET(E1000_MDIC_REG_MASK, mdic));
+			success = false;
+		}
 
-	return 0;
+		/* Allow some time after each MDIC transaction to avoid
+		 * reading duplicate data in the next MDIC transaction.
+		 */
+		if (hw->mac.type == e1000_pch2lan)
+			usleep_range(100, 150);
+
+		if (success)
+			return 0;
+
+		if (retry_counter != retry_max) {
+			e_dbg("Perform retry on PHY transaction...\n");
+			mdelay(10);
+		}
+	}
+
+	return -E1000_ERR_PHY;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/e1000e/phy.h b/drivers/net/ethernet/intel/e1000e/phy.h
index c48777d09523..049bb325b4b1 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.h
+++ b/drivers/net/ethernet/intel/e1000e/phy.h
@@ -51,6 +51,8 @@ s32 e1000e_read_phy_reg_bm2(struct e1000_hw *hw, u32 offset, u16 *data);
 s32 e1000e_write_phy_reg_bm2(struct e1000_hw *hw, u32 offset, u16 data);
 void e1000_power_up_phy_copper(struct e1000_hw *hw);
 void e1000_power_down_phy_copper(struct e1000_hw *hw);
+void e1000e_disable_phy_retry(struct e1000_hw *hw);
+void e1000e_enable_phy_retry(struct e1000_hw *hw);
 s32 e1000e_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data);
 s32 e1000e_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data);
 s32 e1000_read_phy_reg_hv(struct e1000_hw *hw, u32 offset, u16 *data);
-- 
2.41.0


