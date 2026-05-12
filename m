Return-Path: <netdev+bounces-287195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKEvNSs9A2oq2AEAu9opvQ
	(envelope-from <netdev+bounces-287195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:46:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4C4522D8D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4D8130FD875
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543EF3ADB94;
	Tue, 12 May 2026 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f0/IOMUC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FDB3ACF07
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594959; cv=none; b=Z7Y0litXKoxa1kCjoxktef+C2k7jyXepi3f4iWubTgQavicijOFwpnvId5OlGjXnOVTPnn171JvCnfG/Ao8OGLB6ggtuTw/PxkXjkKVe063F/8onclacWRDh1rS8QVM2zabLwVAjWMVPfCpdZ8+Gb7SNJhl2l/a1Q9D6U6UZZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594959; c=relaxed/simple;
	bh=E1r8P5ey63ZjKki1ZUQSqtI+ewNnIapJvUrpRcchVL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaI7umOovJKwSouGjTRByAyJYz3qicjyOABpCKMk2Vf8EEA3AvEgDhiFwG2YXD7RmMJ/7wPbnudAXUb1MW/QKUuEYCbYmSI8ygaeiCEQQWvgYMgvoqI04WhPJlgQm1ws0P8cPR62ogFmufewuxCpfku7RHjHamApoXbTIhZ9No0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f0/IOMUC; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778594958; x=1810130958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E1r8P5ey63ZjKki1ZUQSqtI+ewNnIapJvUrpRcchVL8=;
  b=f0/IOMUCqbsO2VmhZ1USaBc4eV3uUA1VNgMlaJeSj+1ovwwovTyLtOwT
   n87HZy3TmSyuCaSV5LaNgwrObpz+w/7l1LnGgQr4tpo4B17ux0V8Jzh3/
   APT8qFXbq5c5UV07KWRamJWBCsfQvvuP1lJl/J1sXwLy1DFFo1qs8Lved
   rmlIyN0KyrRwkW1ORaC92YDziK88+hiXfLkods+iXFWM6/lwdnsRWLek6
   GffnR/8hi6Tj5zhrJSGV86tpw4+DWCXkaNXx4k3Gqz/gbh2zyZaxcO6I6
   oH7nsAg5ZQa8eIsuTB82tRUx2xbKKrOBOaVTlqbZoU9Fsi0I/+LYgNJ3R
   A==;
X-CSE-ConnectionGUID: xzWpjQj5TZCMQKErOEdIwA==
X-CSE-MsgGUID: eoDNOrueRyKwgK+1Fydhvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="96929675"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="96929675"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:09:17 -0700
X-CSE-ConnectionGUID: h4UFlnXOQVyWH6DXkPGbCQ==
X-CSE-MsgGUID: Oq0Ng7a0SC+RBMo3bTQp7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="275892496"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 12 May 2026 07:09:16 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2 6/8] ixgbe: extract ixgbe_restart_auto_neg() to avoid code duplication
Date: Tue, 12 May 2026 16:09:02 +0200
Message-ID: <20260512140904.4105236-7-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260512140904.4105236-1-aleksandr.loktionov@intel.com>
References: <20260512140904.4105236-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BF4C4522D8D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287195-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

From: Jakub Chylkowski <jakubx.chylkowski@intel.com>

Both ixgbe_setup_phy_link_generic() and ixgbe_setup_phy_link_tnx()
end with the same three-line sequence that reads MDIO_CTRL1, sets
the MDIO_AN_CTRL1_RESTART bit, and writes MDIO_CTRL1 back.

Factor it out into a static helper ixgbe_restart_auto_neg() and call
it from both sites.

While at it, also check the return value of phy.ops.read_reg() in the
helper and skip the write on failure.  The original inlined code
ignored the read result and would OR MDIO_AN_CTRL1_RESTART into a
stale autoneg_reg value (left over from the prior MDIO_AN_ADVERTISE
write) and unconditionally write it back to MDIO_CTRL1 if the read
failed.  This is a small behavioral change: on read_reg() failure the
restart write is now skipped instead of being issued with a
potentially garbage value.

Signed-off-by: Jakub Chylkowski <jakubx.chylkowski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c | 36 ++++++++++++--------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index de8f6c6..c7387a4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -1089,6 +1089,26 @@ int ixgbe_mii_bus_init(struct ixgbe_hw *hw)
 	return mdiobus_register(bus);
 }
 
+/**
+ * ixgbe_restart_auto_neg - restart PHY autonegotiation
+ * @hw: pointer to hardware structure
+ *
+ * Sets the restart autoneg bit in MDIO_CTRL1 to trigger a new
+ * autonegotiation cycle.
+ **/
+static void ixgbe_restart_auto_neg(struct ixgbe_hw *hw)
+{
+	u16 autoneg_reg;
+	int status;
+
+	status = hw->phy.ops.read_reg(hw, MDIO_CTRL1, MDIO_MMD_AN,
+				      &autoneg_reg);
+	if (status)
+		return;
+	autoneg_reg |= MDIO_AN_CTRL1_RESTART;
+	hw->phy.ops.write_reg(hw, MDIO_CTRL1, MDIO_MMD_AN, autoneg_reg);
+}
+
 /**
  *  ixgbe_setup_phy_link_generic - Set and restart autoneg
  *  @hw: pointer to hardware structure
@@ -1156,13 +1176,7 @@ int ixgbe_setup_phy_link_generic(struct ixgbe_hw *hw)
 		return 0;
 
 	/* Restart PHY autonegotiation and wait for completion */
-	hw->phy.ops.read_reg(hw, MDIO_CTRL1,
-			     MDIO_MMD_AN, &autoneg_reg);
-
-	autoneg_reg |= MDIO_AN_CTRL1_RESTART;
-
-	hw->phy.ops.write_reg(hw, MDIO_CTRL1,
-			      MDIO_MMD_AN, autoneg_reg);
+	ixgbe_restart_auto_neg(hw);
 
 	return status;
 }
@@ -1386,13 +1400,7 @@ int ixgbe_setup_phy_link_tnx(struct ixgbe_hw *hw)
 		return 0;
 
 	/* Restart PHY autonegotiation and wait for completion */
-	hw->phy.ops.read_reg(hw, MDIO_CTRL1,
-			     MDIO_MMD_AN, &autoneg_reg);
-
-	autoneg_reg |= MDIO_AN_CTRL1_RESTART;
-
-	hw->phy.ops.write_reg(hw, MDIO_CTRL1,
-			      MDIO_MMD_AN, autoneg_reg);
+	ixgbe_restart_auto_neg(hw);
 	return 0;
 }
 
-- 
2.52.0


