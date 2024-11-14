Return-Path: <netdev+bounces-144726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D179C84B9
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38D42841C1
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853251F754E;
	Thu, 14 Nov 2024 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfgN+nDl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029EC1F709E;
	Thu, 14 Nov 2024 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731572254; cv=none; b=GJg8jKa0g7h6GkkdBA8QYMfNiMm3P9tlptEzLSEheoXx/Qhlb/yfv0APeztrgq/cCoct4DaWXne4k3rO8EjZycVHxsG/PhaWYCVz/Wb/8MCb8uUuoCLn+vN89IUEI4nP7KwV5okboMrOFSD7E2R1mIFqzrlIN4NRu1AxWhPNiM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731572254; c=relaxed/simple;
	bh=ocQgpKPOx0XcLpqISFGSjESyE6sRma++231CI0veC/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jJw+4mSdiVDa3N4PVJuAhgxJljB5SdPqR7R50VoplQdVTTm8RwWSKIdWF4H6cDfhfAQt8T60CaSkxSOgk+CeF5aTGeh1VFftXtADoTT6f0RdjYIrzkY8aaV2ljBuHmxMjtgHHn+J3QggR4rYBy+J21Yt5l72wTmmyQT11VSEhWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfgN+nDl; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731572253; x=1763108253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ocQgpKPOx0XcLpqISFGSjESyE6sRma++231CI0veC/0=;
  b=hfgN+nDl07zccguuw8LjFfd7wxMBH1VexQBS393Vd64slqX9DuVqT+Tk
   WBIjBdnkzhgyf4xaESgGL6rl3c3OsQAg66k3inyZ2uRbp4FrE2+wJcVRN
   EKvIuH9PMu06YmLezl9Uq6UhWF6OX28Cdxk+sIVhXk1jDyyU89yW9u9Ho
   5fbdP1hXpNB/Hso9lMe9pdRaV9efZZYPAWCPzv2XLpil2RLPGlPacgYFy
   TclG/NjXTZ+eoofnR73sf4f51Y0f31XMrX4ECt1TPabj1A7ECo8ke86Pk
   IJxWD+Zf8/6IVR/MUC4C3AikJXqjmiq3plkUXMofxFdEq178lzluwX8x4
   w==;
X-CSE-ConnectionGUID: rM3KLc72T0Kvw1bq3BxO/g==
X-CSE-MsgGUID: sp+wGm2/SzmumRiq0nfE1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="42921269"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="42921269"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:17:33 -0800
X-CSE-ConnectionGUID: jJowESe6TKC+BYh6mIOHXA==
X-CSE-MsgGUID: gp9mz9c4SoifszaSS/wpSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="88553860"
Received: from unknown (HELO YongLiang-Ubuntu20-iLBPG12.png.intel.com) ([10.88.229.33])
  by fmviesa010.fm.intel.com with ESMTP; 14 Nov 2024 00:17:29 -0800
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net v1 1/2] net: phy: set eee_cfg based on PHY configuration
Date: Thu, 14 Nov 2024 16:16:52 +0800
Message-Id: <20241114081653.3939346-2-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114081653.3939346-1-yong.liang.choong@linux.intel.com>
References: <20241114081653.3939346-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all PHYs have EEE enabled by default. For example, Marvell PHYs are
designed to have EEE hardware disabled during the initial state, and it
needs to be configured to turn it on again.

This patch reads the PHY configuration and sets it as the initial value for
eee_cfg.tx_lpi_enabled and eee_cfg.eee_enabled instead of having them set to
true by default.

Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
Cc: <stable@vger.kernel.org>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/phy/phy_device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 499797646580..b4fa40c2371a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3010,9 +3010,12 @@ EXPORT_SYMBOL_GPL(phy_advertise_eee_all);
  */
 void phy_support_eee(struct phy_device *phydev)
 {
+	bool is_enabled = true;
+
+	genphy_c45_eee_is_active(phydev, NULL, NULL, &is_enabled);
 	linkmode_copy(phydev->advertising_eee, phydev->supported_eee);
-	phydev->eee_cfg.tx_lpi_enabled = true;
-	phydev->eee_cfg.eee_enabled = true;
+	phydev->eee_cfg.tx_lpi_enabled = is_enabled;
+	phydev->eee_cfg.eee_enabled = is_enabled;
 }
 EXPORT_SYMBOL(phy_support_eee);
 
-- 
2.34.1


