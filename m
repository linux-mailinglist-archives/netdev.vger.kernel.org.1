Return-Path: <netdev+bounces-113924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DABC940651
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 06:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C461F22FE4
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 04:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3D318F2EB;
	Tue, 30 Jul 2024 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="P4nQovAf"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F61718F2DC;
	Tue, 30 Jul 2024 04:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722312629; cv=none; b=FpvsgOB8hsVpC6GX+EZYPIwcCobGrn4d3xr87w1yQanKdzlHXYvA9OlxIDf37GAWk2UM7u1r0cJu9Hpjhy6CFxSpe/ewpM4cSkI1ChVHymQX8KZfybKLQwVjCnhhLW0Kg0ReD0YQgPuiejXL/vFBImgUps53w0MPuWfj7GiT6/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722312629; c=relaxed/simple;
	bh=jvYmE+tnyPlUCgCyhjI+/EZE9ItdD0OGY+p0y6rbJhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3ZyN7LBw+aI42LVIHs7VzEwrpy2cVxfgOKG6OFkO2lZvikahJZh9mVxbhdvNa0gQCTdkdO41kt0ienNrFCZ4HFWAK1IlkKCdNJLFmHOpHbMFAJq/SX+Asph3crVeDmMDGoB7V3Qy8+3VGIA9p5Nod7C3VHYEq8SIxDaCm+zZpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=P4nQovAf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722312627; x=1753848627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jvYmE+tnyPlUCgCyhjI+/EZE9ItdD0OGY+p0y6rbJhQ=;
  b=P4nQovAfQ+P643g6WscUt0dLfutrwOBVfoSGmoT+7hEQ58GJfareU1aV
   pmawzJbkhjQY0VXV8v43u0X5WVSJffSTVoXU2zA+TRA3hqZX65FKDXbPu
   DRd1azDNvW4oa0z49HZypaQ6nEWKxUSU4DzKKTq1Ga//iVr+VuXxASlyT
   l1BQwgccwVNt9bGb5lo0+n0eNyHoNl6q5rfrpJBJkeSzdqCw46Aa36Teq
   VRU98D5gvBT8PC4EZjGACZxTAeSpxnVD6zNFc//HzDHrvP+R/PNNt3qj8
   hsvMumiYcmr1Xkg0sxJ62Cuqsfgcd0Vh3NVzZOAUEx0P98iH3ypZmEKkB
   Q==;
X-CSE-ConnectionGUID: WJ+vg2u7QzaTB4lakkgXmA==
X-CSE-MsgGUID: 8POIP5nkRUuh/2eI9o6+Kg==
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="197261871"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 21:10:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 21:09:50 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 21:09:40 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>,
	<alexanderduyck@fb.com>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<rdunlap@infradead.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v5 07/14] net: phy: microchip_t1s: add c45 direct access in LAN865x internal PHY
Date: Tue, 30 Jul 2024 09:38:59 +0530
Message-ID: <20240730040906.53779-8-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch adds c45 registers direct access support in Microchip's
LAN865x internal PHY.

OPEN Alliance 10BASE-T1x compliance MAC-PHYs will have both C22 and C45
registers space. If the PHY is discovered via C22 bus protocol it assumes
it uses C22 protocol and always uses C22 registers indirect access to
access C45 registers. This is because, we don't have a clean separation
between C22/C45 register space and C22/C45 MDIO bus protocols. Resulting,
PHY C45 registers direct access can't be used which can save multiple SPI
bus access. To support this feature, set .read_mmd/.write_mmd in the PHY
driver to call .read_c45/.write_c45 in the OPEN Alliance framework
drivers/net/ethernet/oa_tc6.c

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 534ca7d1b061..3614839a8e51 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -268,6 +268,34 @@ static int lan86xx_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+/* OPEN Alliance 10BASE-T1x compliance MAC-PHYs will have both C22 and
+ * C45 registers space. If the PHY is discovered via C22 bus protocol it assumes
+ * it uses C22 protocol and always uses C22 registers indirect access to access
+ * C45 registers. This is because, we don't have a clean separation between
+ * C22/C45 register space and C22/C45 MDIO bus protocols. Resulting, PHY C45
+ * registers direct access can't be used which can save multiple SPI bus access.
+ * To support this feature, set .read_mmd/.write_mmd in the PHY driver to call
+ * .read_c45/.write_c45 in the OPEN Alliance framework
+ * drivers/net/ethernet/oa_tc6.c
+ */
+static int lan865x_phy_read_mmd(struct phy_device *phydev, int devnum,
+				u16 regnum)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+
+	return __mdiobus_c45_read(bus, addr, devnum, regnum);
+}
+
+static int lan865x_phy_write_mmd(struct phy_device *phydev, int devnum,
+				 u16 regnum, u16 val)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+
+	return __mdiobus_c45_write(bus, addr, devnum, regnum, val);
+}
+
 static struct phy_driver microchip_t1s_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1),
@@ -285,6 +313,8 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
 		.config_init        = lan865x_revb0_config_init,
 		.read_status        = lan86xx_read_status,
+		.read_mmd           = lan865x_phy_read_mmd,
+		.write_mmd          = lan865x_phy_write_mmd,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
-- 
2.34.1


