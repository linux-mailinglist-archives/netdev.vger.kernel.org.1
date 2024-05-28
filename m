Return-Path: <netdev+bounces-98782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5D68D271B
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 23:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0B01F24952
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 21:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944A617B4EC;
	Tue, 28 May 2024 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SroBXdpL"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313BF17E8EB;
	Tue, 28 May 2024 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716932065; cv=none; b=kIOUszLm2CsnrV4NTHfm+/P3IEdM6L/K3nITqS/SSo9tsL0SePIZjlwhMCTcvIp+8JNiTYabX75zoG6gE43ue8v7SG0Omi2ZGGGnhtgPn7edCiNYZNAK7oGdfu8m76knYbAtEqKGQXdXPgMNiuD8uHh2B0oQ2xGGGzOMwPSQLqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716932065; c=relaxed/simple;
	bh=66jCgIAfVLYODIuS69ZJMzNLkJBlcRvktHQeAOpY69I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iTWvjptikYnTVa4KNVZPGOKxxC6e4up3uM+WQWFKAdChaXTTQ5uwOYwW/8omqAJhZwyoMGl/ZolBcI3cgStNgd9wMY9e6FHy+DQUmFcTzgGTIfQKVd8w3YBH+wjLA1VxwhnshxTeiJtsyUWWb8p9s3y/sjIpdJIG5UMMElOBzcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SroBXdpL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716932064; x=1748468064;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=66jCgIAfVLYODIuS69ZJMzNLkJBlcRvktHQeAOpY69I=;
  b=SroBXdpLIpi11zC9ZpxyjgfwKFea/lX1mpyepsj6qi45H2kOfji0FKze
   +QChXWp3h7IXLXGrp6AtOBPk04wy0gGlKxVjPdQLzpZp21Q1u9rkXDZ62
   uEQcwf+Pd5cRnCKgpAlIdRpQCWSx5+l8/HUzCwoygzlQyexPYeJzr7426
   LfTimYA3Xos8WawSR/sgYpBeM9qAXeUWsz1CPsAfeK9LPXSQRqjisKMAV
   zE0D6sclxXk5fhTYLCradv2mGB4t0L/T8S+LhXorVOnhlWVDmKoAjI4uj
   QndOqDPVO77T19AnFXrVthmctnTYjVtM7SA+O0ugR74j3r0qSt8G3SA+V
   w==;
X-CSE-ConnectionGUID: 7btE8S4STMGx7zw2VOaPVA==
X-CSE-MsgGUID: RsSuqp3LTHakwHagEdfHUw==
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="28964721"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2024 14:34:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 May 2024 14:34:12 -0700
Received: from hat-linux.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 28 May 2024 14:34:12 -0700
From: <Tristram.Ha@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net] net: phy: Micrel KSZ8061: fix errata solution not taking effect problem
Date: Tue, 28 May 2024 14:37:34 -0700
Message-ID: <1716932254-3703-1-git-send-email-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

KSZ8061 needs to write to a MMD register at driver initialization to fix
an errata.  This worked in 4.14 kernel but not in newer kernels.  The
issue is the main phylib code no longer resets PHY at the very beginning.
Calling phy resuming code later will reset the chip if it is already
powered down at the beginning.  This wipes out the MMD register write.
Solution is to implement a phy resume function for KSZ8061 to take care
of this problem.

Fixes: 232ba3a51cc2 ("net: phy: Micrel KSZ8061: link failure after cable connect")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/phy/micrel.c | 42 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 2b8f8b7f1517..618e532ee5d7 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -866,6 +866,17 @@ static int ksz8061_config_init(struct phy_device *phydev)
 {
 	int ret;
 
+	/* Chip can be powered down by the bootstrap code. */
+	ret = phy_read(phydev, MII_BMCR);
+	if (ret < 0)
+		return ret;
+	if (ret & BMCR_PDOWN) {
+		ret = phy_write(phydev, MII_BMCR, ret & ~BMCR_PDOWN);
+		if (ret < 0)
+			return ret;
+		usleep_range(1000, 2000);
+	}
+
 	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_DEVID1, 0xB61A);
 	if (ret)
 		return ret;
@@ -2085,6 +2096,35 @@ static int kszphy_resume(struct phy_device *phydev)
 	return 0;
 }
 
+static int ksz8061_resume(struct phy_device *phydev)
+{
+	int ret;
+
+	/* This function can be called twice when the Ethernet device is on. */
+	ret = phy_read(phydev, MII_BMCR);
+	if (ret < 0)
+		return ret;
+	if (!(ret & BMCR_PDOWN))
+		return 0;
+
+	genphy_resume(phydev);
+	usleep_range(1000, 2000);
+
+	/* Re-program the value after chip is reset. */
+	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_DEVID1, 0xB61A);
+	if (ret)
+		return ret;
+
+	/* Enable PHY Interrupts */
+	if (phy_interrupt_is_valid(phydev)) {
+		phydev->interrupts = PHY_INTERRUPT_ENABLED;
+		if (phydev->drv->config_intr)
+			phydev->drv->config_intr(phydev);
+	}
+
+	return 0;
+}
+
 static int kszphy_probe(struct phy_device *phydev)
 {
 	const struct kszphy_type *type = phydev->drv->driver_data;
@@ -5339,7 +5379,7 @@ static struct phy_driver ksphy_driver[] = {
 	.config_intr	= kszphy_config_intr,
 	.handle_interrupt = kszphy_handle_interrupt,
 	.suspend	= kszphy_suspend,
-	.resume		= kszphy_resume,
+	.resume		= ksz8061_resume,
 }, {
 	.phy_id		= PHY_ID_KSZ9021,
 	.phy_id_mask	= 0x000ffffe,
-- 
2.34.1


