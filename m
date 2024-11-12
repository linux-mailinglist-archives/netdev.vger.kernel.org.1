Return-Path: <netdev+bounces-143977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 975619C4F62
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 08:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3A11F21269
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 07:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B6420B20A;
	Tue, 12 Nov 2024 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ig7hFxX+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A8020B1F0;
	Tue, 12 Nov 2024 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396325; cv=none; b=JihZs0K9TWP++odKMEN2MJuOXqoxC+9xf7fnJ6QweUdEIsg7BHC7kq+TuwmZqtmoU2g/ZszuD1z0/cLatpbHrbqdIJ+wXc2svbECRNZ8vUdJXTnERU9qAADhB5Ih95kzvTj4AS6grYUsFlLfno4MLzgzKJlh3c/IcOTlbge4EYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396325; c=relaxed/simple;
	bh=56zf3pdeCoar/wx2RuHyLAS0nUbRU/jxT75R9EzS8qE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LHaHGvi7Qc6vfE+jeEhZ/029sd2w24aKAC1HNn5HvLwCdmfxm7kxz7WU1n4k0j/Fs4tWGmq2av1Q5utpyeTQi8EY1vtKNhdErtwdvmwTg8K/sGzC0dm1LasdAMCQOWZ3bKSJiAStyGkvEfZIQ0P2fR90NHd2XLiVs2nL02a+vc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ig7hFxX+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731396323; x=1762932323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=56zf3pdeCoar/wx2RuHyLAS0nUbRU/jxT75R9EzS8qE=;
  b=Ig7hFxX+7+rfYI9ZWPp1ywTyjDL1G/sAK0L/8Ogi3xTlsyc1PRnwkrSd
   hDOSfpTu8mXtkOgVxmDrGlL06Qs9tSFN44W1MPJmJnnKM1hmQ06dsv/3J
   L4WWE9YN1gzEIq2YzRSgoySkZzuM+2r/5xb8mADVBguXUntDF9I+9Nxaa
   52YKs8uM3LQN0S74MUJQ9Fv5I7aRP416jhW/2suxPFEQj6R3s/qrbEvAX
   GFidPRRw0x1WfX1srk61KVpffWMw4gcliASZx/wHp1YR5gEllcRohUyW8
   XLsESXM39ZNmzagzqoitunvu/LdhuVA9nrdo0nPnmD5kFZVeVG2hn+ilZ
   w==;
X-CSE-ConnectionGUID: +rcFOWwzTkeB2q1K0mHj2g==
X-CSE-MsgGUID: VPZgMajCSLC/G06KAXTuqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31387803"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31387803"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 23:25:23 -0800
X-CSE-ConnectionGUID: 91fhFG1uRTKNRrYsEhwh5Q==
X-CSE-MsgGUID: ig6CV1xeS4qYl8WbXmtpAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="87074232"
Received: from unknown (HELO YongLiang-Ubuntu20-iLBPG12.png.intel.com) ([10.88.229.33])
  by fmviesa007.fm.intel.com with ESMTP; 11 Nov 2024 23:25:20 -0800
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
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net v1 1/2] net: phy: Introduce phy_update_eee() to update eee_cfg values
Date: Tue, 12 Nov 2024 15:24:46 +0800
Message-Id: <20241112072447.3238892-2-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112072447.3238892-1-yong.liang.choong@linux.intel.com>
References: <20241112072447.3238892-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit fe0d4fd9285e ("net: phy: Keep track of EEE configuration")
introduced eee_cfg, which is used to check the existing settings against
the requested changes. When the 'ethtool --show-eee' command is issued,
it reads the values from eee_cfg. However, the 'show-eee' command does
not show the correct result after system boot-up, link up, and link down.

For system boot-up, the commit 49168d1980e2
("net: phy: Add phy_support_eee() indicating MAC support EEE") introduced
phy_support_eee to set eee_cfg as the default value. However, the values
set were not always correct, as after autonegotiation or speed changes,
the selected speed might not be supported by EEE.

phy_update_eee() was introduced to update the correct values for eee_cfg
during link up and down, ensuring that 'ethtool --show-eee' shows
the correct status.

Fixes: fe0d4fd9285e ("net: phy: Keep track of EEE configuration")
Cc: <stable@vger.kernel.org>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/phy/phy_device.c | 24 ++++++++++++++++++++++++
 include/linux/phy.h          |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 499797646580..94dadf011ca6 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3016,6 +3016,30 @@ void phy_support_eee(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_support_eee);
 
+/**
+ * phy_update_eee - Update the Energy Efficient Ethernet (EEE) settings
+ * @phydev: target phy_device struct
+ * @tx_lpi_enabled: boolean indicating if Low Power Idle (LPI) for
+ * transmission is enabled.
+ * @eee_enabled: boolean indicating if Energy Efficient Ethernet (EEE) is
+ * enabled.
+ * @tx_lpi_timer: the Low Power Idle (LPI) timer value (in microseconds) for
+ * transmission.
+ *
+ * Description:
+ * This function updates the Energy Efficient Ethernet (EEE) settings for the
+ * specified PHY device. It is typically called during link up and down events
+ * to configure the EEE parameters according to the current link state.
+ */
+void phy_update_eee(struct phy_device *phydev, bool tx_lpi_enabled,
+		    bool eee_enabled, u32 tx_lpi_timer)
+{
+	phydev->eee_cfg.tx_lpi_enabled = tx_lpi_enabled;
+	phydev->eee_cfg.eee_enabled = eee_enabled;
+	phydev->eee_cfg.tx_lpi_timer = tx_lpi_timer;
+}
+EXPORT_SYMBOL(phy_update_eee);
+
 /**
  * phy_support_sym_pause - Enable support of symmetrical pause
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a98bc91a0cde..6c300ba47a2d 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2004,6 +2004,8 @@ void phy_advertise_eee_all(struct phy_device *phydev);
 void phy_support_sym_pause(struct phy_device *phydev);
 void phy_support_asym_pause(struct phy_device *phydev);
 void phy_support_eee(struct phy_device *phydev);
+void phy_update_eee(struct phy_device *phydev, bool tx_lpi_enabled,
+		    bool eee_enabled, u32 tx_lpi_timer);
 void phy_set_sym_pause(struct phy_device *phydev, bool rx, bool tx,
 		       bool autoneg);
 void phy_set_asym_pause(struct phy_device *phydev, bool rx, bool tx);
-- 
2.34.1


