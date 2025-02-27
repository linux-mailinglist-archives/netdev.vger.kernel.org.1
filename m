Return-Path: <netdev+bounces-170215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B915A47D6F
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347C1167867
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2586322FF4E;
	Thu, 27 Feb 2025 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvFp5WlK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912C22FF20;
	Thu, 27 Feb 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658621; cv=none; b=LdCDqJIak1LgRoZnMBfns9VYp/E3QBr0SC9wkSxrTfvPCW2IwaEqu1uqzghhlc6DbVbpqyGFC5xSPLujnC03/hIh493VC8Ec4tnrniPswF33oiPRVQ3Z0ydUKo5KTb0S6AKhGFLxotRYn6Y+JaKpssDjBN3Ib6oViDI9+1BrhM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658621; c=relaxed/simple;
	bh=Exo83tyIGsx8vIazCzq/svZKyosoCsshSHaLf3vfos4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PeecaRLNvkbwmTz07eU8UkZbMfPzyrRpLG6qe/l1wcMclXDJdnKX73lvpDmhaCi0ONjCY7BvCJ6+tLY81XtiGytXNEDa0dhLZKduywghbugt52Xk4kJ5v9yzOeGyC2F4udT1dqeBECQgiA51WO+/sptJPV6yTpzGjEJDE8cUVnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvFp5WlK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740658619; x=1772194619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Exo83tyIGsx8vIazCzq/svZKyosoCsshSHaLf3vfos4=;
  b=FvFp5WlKRsgr68jjUXv34XejZZ4BXUYGSc09InqC6wqrIJbop88qBsif
   IPCQ3ezAk5Pe3wM9N3oVZ5PBtpqhfK6UTEmTW9wSHoC26DLWiWsawoQ0v
   6ldsb6U1icZlckPlcYFx/iVJaKEeD5hBSxqgy5uliUDzaSwN+j9v+LDmK
   xOU8ztV0q4sTuoOw2e1OBQ/wAyR4G3s0ys5SUTIV1XDKIVUyJBIopgWz5
   5fclno/ZWcJ0c7tjP37YTtDf0dtqukLgyrDK3Xf3NXfVixeWNJ9aegWlQ
   q4u5vu/hWaz3uJZvAtTmae56j4RMljDpnBptPu3pbbKsD/6mgPfLPRtSs
   Q==;
X-CSE-ConnectionGUID: E/MJQIDBSjKkSA9/dwPiWw==
X-CSE-MsgGUID: vxDpBF5JQG+VvqnzC0B86w==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41464315"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41464315"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 04:16:58 -0800
X-CSE-ConnectionGUID: cxWTGBpoS1Gdm8QvUjv+8A==
X-CSE-MsgGUID: 2wswAz/qSBSc1y4YX2hdrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117519141"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.227.39])
  by orviesa007.jf.intel.com with ESMTP; 27 Feb 2025 04:16:52 -0800
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
Subject: [PATCH net-next v9 2/6] net: pcs: xpcs: re-initiate clause 37 Auto-negotiation
Date: Thu, 27 Feb 2025 20:15:18 +0800
Message-Id: <20250227121522.1802832-3-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227121522.1802832-1-yong.liang.choong@linux.intel.com>
References: <20250227121522.1802832-1-yong.liang.choong@linux.intel.com>
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
 drivers/net/pcs/pcs-xpcs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index e32dec4b812e..3d1bd5aac093 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -602,12 +602,33 @@ static void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 		__set_bit(compat->interface, interfaces);
 }
 
+static int xpcs_switch_interface_mode(struct dw_xpcs *xpcs,
+				      phy_interface_t interface)
+{
+	int ret = 0;
+
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
+		ret = txgbe_xpcs_switch_mode(xpcs, interface);
+	} else if (xpcs->interface != interface) {
+		if (interface == PHY_INTERFACE_MODE_SGMII)
+			xpcs->need_reset = true;
+		xpcs->interface = interface;
+	}
+
+	return ret;
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
 
@@ -799,10 +820,6 @@ static int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
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


