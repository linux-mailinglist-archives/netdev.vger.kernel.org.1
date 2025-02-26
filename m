Return-Path: <netdev+bounces-169732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFC3A4573B
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 08:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DEA23A8EC4
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 07:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CB9238158;
	Wed, 26 Feb 2025 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MBzJJ62l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13D8226D1A;
	Wed, 26 Feb 2025 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556213; cv=none; b=uZzUMgYM13JASl311HfUZvTjnNTYb2GnMbhqBCvfWKwfih8v6JjKPhoBqt3q/ogC1BjExm2U9aLHnevs2XTG9DqhHcfzZ7MPe3PLC4/JSPm0iU0D0EIXgr1X9rlZDAKP/w6FWSKmuOJxSDmdKemHRyeKjoFo+DJzO/SOthA3/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556213; c=relaxed/simple;
	bh=u/mi+LCXMe4ShYx5Tg1OkjWGnid4ORB7ALNFCdTPXsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ecdt6BMWav8KPS40wyqZDTYd6g/izz9G+t6KnsBWqZj6ou/JhkMNSWy6RNJWXpjbm44pnmlgiyj0h7flxxsiAnNEzTZnNbY3cNugMaCa7brmg4I110Pq3q6VIic7kvQfbzFbahhwS53n7caKMpIvYkxlarb5i8DMlTXyI4euNIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MBzJJ62l; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740556212; x=1772092212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u/mi+LCXMe4ShYx5Tg1OkjWGnid4ORB7ALNFCdTPXsg=;
  b=MBzJJ62ltMt75hn6vYzSW6vbuPjXaTWV6Mmu2cA5geE2uUxNYijlollR
   0x9kysYq5m/yBtx/4yXzfUZv3Dhw/26p7RG0Hjvm5PQctIANvWNShvXMF
   1unt7vOfV250HMMExzLVm50fDa6uwvKyhZd1FRNPMXUdrJ1/ZwEnNIPJ4
   NcOUDIV+N2WdPPEI8Qb82ePXM86IMaomrAlR6ktmAXFzZkIjOkr4pm1hX
   AGOja3zzxkuL2A4VjJrf7MWSbxbTaIH//XM5jfC1BECQIWBL9KaxxTZqL
   5oumPghvmGPZX+nPrOolonv83UJqpn5o6jKTVzapcl/8hVCsT7KqisJ/6
   A==;
X-CSE-ConnectionGUID: 8fFHHn1tR0uXtmpa6H4UNA==
X-CSE-MsgGUID: CjySG2OLTOCxkKn8mPgSvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="45305065"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="45305065"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 23:50:11 -0800
X-CSE-ConnectionGUID: i/OO3VdcRvuKu0+EnZjkoQ==
X-CSE-MsgGUID: UDgjKog5QnuTjCxpgoys2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120743002"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.227.39])
  by fmviesa003.fm.intel.com with ESMTP; 25 Feb 2025 23:50:04 -0800
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Simon Horman <horms@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	David E Box <david.e.box@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v8 2/6] net: pcs: xpcs: re-initiate clause 37 Auto-negotiation
Date: Wed, 26 Feb 2025 15:48:33 +0800
Message-Id: <20250226074837.1679988-3-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226074837.1679988-1-yong.liang.choong@linux.intel.com>
References: <20250226074837.1679988-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xpcs_switch_interface_mode function was introduced to handle
interface switching.

According to the XPCS datasheet, a soft reset is required to initiate
Clause 37 auto-negotiation when the XPCS switches interface modes.

When the interface mode switches from 2500BASE-X to SGMII,
re-initiating Clause 37 auto-negotiation is required for the SGMII
interface mode to function properly.

Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/pcs/pcs-xpcs-wx.c |  4 +---
 drivers/net/pcs/pcs-xpcs.c    | 29 +++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs-wx.c b/drivers/net/pcs/pcs-xpcs-wx.c
index fc52f7aa5f59..f73ab04d09f0 100644
--- a/drivers/net/pcs/pcs-xpcs-wx.c
+++ b/drivers/net/pcs/pcs-xpcs-wx.c
@@ -172,11 +172,9 @@ int txgbe_xpcs_switch_mode(struct dw_xpcs *xpcs, phy_interface_t interface)
 		return 0;
 	}
 
-	if (xpcs->interface == interface && !txgbe_xpcs_mode_quirk(xpcs))
+	if (!txgbe_xpcs_mode_quirk(xpcs))
 		return 0;
 
-	xpcs->interface = interface;
-
 	ret = txgbe_pcs_poll_power_up(xpcs);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index e32dec4b812e..c506797f9b63 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -602,12 +602,37 @@ static void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 		__set_bit(compat->interface, interfaces);
 }
 
+static int xpcs_switch_interface_mode(struct dw_xpcs *xpcs,
+				      phy_interface_t interface)
+{
+	int ret = 0;
+
+	if (xpcs->interface != interface) {
+		if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
+			ret = txgbe_xpcs_switch_mode(xpcs, interface);
+			if (ret)
+				return ret;
+		} else if (interface == PHY_INTERFACE_MODE_SGMII) {
+			xpcs->need_reset = true;
+		}
+
+		xpcs->interface = interface;
+	}
+
+	return 0;
+}
+
 static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
 	const struct dw_xpcs_compat *compat;
 	int ret;
 
+	ret = xpcs_switch_interface_mode(xpcs, interface);
+	if (ret)
+		dev_err(&xpcs->mdiodev->dev, "switch interface failed: %pe\n",
+			ERR_PTR(ret));
+
 	if (!xpcs->need_reset)
 		return;
 
@@ -799,10 +824,6 @@ static int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 		return -ENODEV;
 
 	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
-		ret = txgbe_xpcs_switch_mode(xpcs, interface);
-		if (ret)
-			return ret;
-
 		/* Wangxun devices need backplane CL37 AN enabled for
 		 * SGMII and 1000base-X
 		 */
-- 
2.34.1


