Return-Path: <netdev+bounces-150269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEBC9E9B70
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6164816688D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 16:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D8D13D518;
	Mon,  9 Dec 2024 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="utzEcJwO"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE2139D1E;
	Mon,  9 Dec 2024 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761233; cv=none; b=oZszlFpHSMyUspqHKYOlIlBR7HRJ6I25UJvKm53NMsG/xnfYxgJ2XAO4si+uYOC9rlLxm/4mk0uOk0AWA/VJaQ4ccltB8TGhvILChC6m98QkJcQ6pEsVaAw+oW1kex/gfcezY5mZAmnUX5fjsfknP+Vkbq6m9fOL8qgomGZlwQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761233; c=relaxed/simple;
	bh=7JDHmM2iHo64SWED4IWrIDJsip4EkJ+oHnJJMF+n2to=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xl+Yq8BaD2rJkp9wa63dFqKUnJ7qIpWzo4a0oR5b3U4ebp1qacbQIO7+v4XxX+BEfa2NaoCfuC7380O1W2PxS2vFhz/7IlEMwqwtTBaEupPFhLe9TIhWCNx2re9gqZ87Dm3rsPqrNZGS71h/DRoTbk4ym5kh4N0HqncHMgHHj/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=utzEcJwO; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733761232; x=1765297232;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=7JDHmM2iHo64SWED4IWrIDJsip4EkJ+oHnJJMF+n2to=;
  b=utzEcJwOq5975O48xR+/JzjMq7ulvnx6zAJSUZTNTNHcV5KnbFJVrkkt
   ZIlByOGZsFh1aog7/F+/NmX4apNTYRQs2MJGhdgysYFfiqd8OeXDJ/hkc
   kjXMHDnr2zO2LhWNQ4RlyjUGiZFCM6IKNJJi9sp2zcwlciZ3MpYE0mAG7
   d8bmB43Ai4VxYG3ICmUxeIv/tWhwLaqV6UPiA9XjxtzGVm2zMLmNUnKpx
   Kbw6kbgWFlqCtH4QyzaXWYx3XYLUXQlIz2pFeJSZhGTZDY6vq/j6Y/lBT
   LUEQ59DF7lZTc2YLCptQymZuYY+d5O5XBAEJoJplG2fVSFpkwrjLUlZnm
   w==;
X-CSE-ConnectionGUID: JLL7S6y7ROGYO+q1cU6U3w==
X-CSE-MsgGUID: rxfh/GnkTX+ZaSxX2IE+0g==
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="35311726"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2024 09:20:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Dec 2024 09:20:17 -0700
Received: from HYD-DK-UNGSW20.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Dec 2024 09:20:13 -0700
From: Tarun Alle <Tarun.Alle@microchip.com>
To: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 1/2] net: phy: phy-c45: Auto-negotiaion changes for T1 phy in phy library
Date: Mon, 9 Dec 2024 21:44:26 +0530
Message-ID: <20241209161427.3580256-2-Tarun.Alle@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209161427.3580256-1-Tarun.Alle@microchip.com>
References: <20241209161427.3580256-1-Tarun.Alle@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Below auto-negotiation library changes required for T1 phys:
- Lower byte advertisement register need to read after higher byte as
  per 802.3-2022 : Section 45.2.7.22.
- Link status need to be get from control T1 registers for T1 phys.

Signed-off-by: Tarun Alle <Tarun.Alle@microchip.com>
---
 drivers/net/phy/phy-c45.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 0dac08e85304..85d8a9b9c3f6 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -234,15 +234,11 @@ static int genphy_c45_baset1_an_config_aneg(struct phy_device *phydev)
 		return -EOPNOTSUPP;
 	}
 
-	adv_l |= linkmode_adv_to_mii_t1_adv_l_t(phydev->advertising);
-
-	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_T1_ADV_L,
-				     adv_l_mask, adv_l);
-	if (ret < 0)
-		return ret;
-	if (ret > 0)
-		changed = 1;
-
+	/* Ref. 802.3-2022 : Section 45.2.7.22
+	 * The Base Page value is transferred to mr_adv_ability when register
+	 * 7.514 is written.
+	 * Therefore, registers 7.515 and 7.516 should be written before 7.514.
+	 */
 	adv_m |= linkmode_adv_to_mii_t1_adv_m_t(phydev->advertising);
 
 	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_T1_ADV_M,
@@ -252,6 +248,23 @@ static int genphy_c45_baset1_an_config_aneg(struct phy_device *phydev)
 	if (ret > 0)
 		changed = 1;
 
+	adv_l |= linkmode_adv_to_mii_t1_adv_l_t(phydev->advertising);
+
+	if (changed) {
+		ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_T1_ADV_L,
+				    adv_l);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN,
+					     MDIO_AN_T1_ADV_L,
+					     adv_l_mask, adv_l);
+		if (ret < 0)
+			return ret;
+		if (ret > 0)
+			changed = 1;
+	}
+
 	return changed;
 }
 
@@ -418,11 +431,14 @@ EXPORT_SYMBOL_GPL(genphy_c45_aneg_done);
 int genphy_c45_read_link(struct phy_device *phydev)
 {
 	u32 mmd_mask = MDIO_DEVS_PMAPMD;
+	u16 reg = MDIO_CTRL1;
 	int val, devad;
 	bool link = true;
 
 	if (phydev->c45_ids.mmds_present & MDIO_DEVS_AN) {
-		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_CTRL1);
+		if (genphy_c45_baset1_able(phydev))
+			reg = MDIO_AN_T1_CTRL;
+		val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
 		if (val < 0)
 			return val;
 
-- 
2.34.1


