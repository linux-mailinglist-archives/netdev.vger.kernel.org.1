Return-Path: <netdev+bounces-117650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED9394EAF5
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6421A1C2164E
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD70B17966E;
	Mon, 12 Aug 2024 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="s7PU2M6K"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00C176ADA;
	Mon, 12 Aug 2024 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458502; cv=none; b=WW8Tkb3Tnt6DD5157OXrOVcRUl+dH0iINS7hqTLu33yL5A/LRP3HRfPrmIdfMdRpgNpvs/Rif8Xc6DA/KQGjP6Euau3MG9Cy05iiFySWlI6d2Cw0EqdS5AMFwWbEw5t0ocANw8q2PTagttb7o9sVsaGxfAaLNxBh+rvU0QurHuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458502; c=relaxed/simple;
	bh=6gPhNMCVkjsYb/iNe1vnvKXCmETz6HU3IFpjijceye8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCDkio5H9yyhGEaobUgCDdAKTpfNDnJYAgGQoS08CHyRnmbRqR4GyDptgeZc2nSntODQJMXvMplTplsikKWxff4nnpkG2MiJJzafE179COnVT58rWgjObq9nFEe9itBnXon/F+KAPBm/ilWTjqvmlD7aM4W6+vaNnxozAE5l4Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=s7PU2M6K; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723458501; x=1754994501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6gPhNMCVkjsYb/iNe1vnvKXCmETz6HU3IFpjijceye8=;
  b=s7PU2M6KPq2GxPWxfAqDBL9kO8zfv1pC14nc/zoQI2NKtWTNePEk6CfT
   LvloqP2/YRuFNw6t9t3ya76RgUZJn1ygFAPM3HMF46pkQ7mCa8o5/0y6i
   TpCBc98Fixu/UdQK3cBHKNj4gXVWIF6ZI3alT/6GNwt5FcsETti0pZutA
   DJtd5HIFDC88GTeh8vLWha8l6Yd/mDQCoQ9uhTnRcQymBR/VodcuDsgSX
   mYBbLEAH0vT6PMsPm8NQDhPuyYnS/CRSYNrTrR8cL83hEMPzinkgXKk1W
   QLVvZiPXzC7B7amPmrp+RoZ28eYfR+ObKHxcglYmgPtsY5ZrSgKuP0Hmm
   Q==;
X-CSE-ConnectionGUID: d6qO7odkR3iwUdfPjbw0hA==
X-CSE-MsgGUID: byg+HBjcRSaAJOIOtDsKNA==
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="31041171"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 03:28:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 03:28:08 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 03:27:58 -0700
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
	<linux@bigler.io>, <markku.vorne@kempower.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v6 07/14] net: phy: microchip_t1s: add c45 direct access in LAN865x internal PHY
Date: Mon, 12 Aug 2024 15:56:04 +0530
Message-ID: <20240812102611.489550-8-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812102611.489550-1-Parthiban.Veerasooran@microchip.com>
References: <20240812102611.489550-1-Parthiban.Veerasooran@microchip.com>
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


