Return-Path: <netdev+bounces-90397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA498AE037
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BED1C214E0
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 08:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5DC5578A;
	Tue, 23 Apr 2024 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VIII61E+"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8899654FAE;
	Tue, 23 Apr 2024 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862133; cv=none; b=exmu+O0G0LqlSZRPRT2aYHBBUA4o/bgSu7+l1VAMLW+hxiiXBPfP8glhmqBmUhYOBCvwUkcrZEh3+8eTkT3ZLbZjFY8mCgFvjyb/1x/tQrOKVZREJYGMDLIwNa8E+uau3ZFs1nb7VZzAk9Vt6L93ZREANqDrft04VS9jZKxSxT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862133; c=relaxed/simple;
	bh=Cq8DsZzwx0gUO/0lV/NY2e6qQt/0n/otAXdUhqCixM0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U8g5otnYUpIQo9lFewQVMdXzVAd1M3cyTZdt3bJUrg91DGRxzljFPFaIbQ6EudCD1VxbbiTdXvRiM9yDFMjT8l63J7lfkS5YZnreFI+3vLKsZ1K1PhqO9LHaKd02ndKLqi7QddjQ0UeEFqLEM5/+q2t/bAST8f1Rv+hW7DAMZrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VIII61E+; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43N8mYv0102865;
	Tue, 23 Apr 2024 03:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713862114;
	bh=izBQf8prT76mBbNRBNj+F/z8bHoPWICC5dVB8vaXVtM=;
	h=From:To:CC:Subject:Date;
	b=VIII61E+5vcBkTOEEyscEbswwz/uuKZ8jjezilBEc4an9hcmjqrcU/oo/kr5EfHAV
	 4QENQD6fgfQDsPzgcDapSCLbuBSNf2NrrwKwYPrVQ+nW0UFEXAe65GyhIoJZse1/SM
	 vSf5Gi+IWmqhEeFFjJ3OwJvjXGOncK+xtB67ECNc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43N8mYCH049178
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Apr 2024 03:48:34 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Apr 2024 03:48:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Apr 2024 03:48:33 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43N8mXWC071849;
	Tue, 23 Apr 2024 03:48:33 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 43N8mW3t021108;
	Tue, 23 Apr 2024 03:48:33 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David
 S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH net] net: phy: dp83869: Fix MII mode failure
Date: Tue, 23 Apr 2024 14:18:28 +0530
Message-ID: <20240423084828.1309294-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The DP83869 driver sets the MII bit (needed for PHY to work in MII mode)
only if the op-mode is either DP83869_100M_MEDIA_CONVERT or
DP83869_RGMII_100_BASE.

Some drivers i.e. ICSSG support MII mode with op-mode as
DP83869_RGMII_COPPER_ETHERNET for which the MII bit is not set in dp83869
driver. As a result MII mode on ICSSG doesn't work and below log is seen.

TI DP83869 300b2400.mdio:0f: selected op-mode is not valid with MII mode
icssg-prueth icssg1-eth: couldn't connect to phy ethernet-phy@0
icssg-prueth icssg1-eth: can't phy connect port MII0

Fix this by setting MII bit for DP83869_RGMII_COPPER_ETHERNET op-mode as
well.

Fixes: 94e86ef1b801 ("net: phy: dp83869: support mii mode when rgmii strap cfg is used")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
NOTE: This patch is needed for MII mode to work for ICSSG Ethernet driver.
I will post the device tree patch for MII mode and mark that as dependent
on this patch.

 drivers/net/phy/dp83869.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index fa8c6fdcf301..d7aaefb5226b 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -695,7 +695,8 @@ static int dp83869_configure_mode(struct phy_device *phydev,
 	phy_ctrl_val = dp83869->mode;
 	if (phydev->interface == PHY_INTERFACE_MODE_MII) {
 		if (dp83869->mode == DP83869_100M_MEDIA_CONVERT ||
-		    dp83869->mode == DP83869_RGMII_100_BASE) {
+		    dp83869->mode == DP83869_RGMII_100_BASE ||
+		    dp83869->mode == DP83869_RGMII_COPPER_ETHERNET) {
 			phy_ctrl_val |= DP83869_OP_MODE_MII;
 		} else {
 			phydev_err(phydev, "selected op-mode is not valid with MII mode\n");

base-commit: 6bea4f03c6a4e973ef369e15aac88f37981db49e
-- 
2.34.1


