Return-Path: <netdev+bounces-165956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F6CA33CAF
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D37B3AC138
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4A2213E99;
	Thu, 13 Feb 2025 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CTWWnjQi"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB3212B35;
	Thu, 13 Feb 2025 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442141; cv=none; b=a6e/wi0X233YjQMGttVm3rJWQGwAu9mCpUbmyga3Bov1ZimGa1xqcNO4LX4+PcHR7xjQWXL6DOLskBV8ehNEhWC7rIKHvBSdxeCuV0EyseDpIea1MI3s6Tb678yyAW1yfcBMyYExt3AgwjxEapT2pGe1NfbI4+Ue+BIu4Ybynm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442141; c=relaxed/simple;
	bh=E8K7OdmM5TDtx1MdCwoTg1FK1STUogCMX2UO9Gzh+1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UZlnIxVVzSwpkaVnB+54Z7/J3OTAEBfM9DeDmooqpzl0KXkDuVTLWEcamUoj2ZZd78qYgIzRb8N0ICk8zX/5DlNUbcx0TveNreVvFqnbW/navBGgxhxK9x+5uZDYQuIyNPNRsrRlLxxaY6/jba59MCmi58L7nhiB9k8OifxWXRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CTWWnjQi; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51DALqDA3988680
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 04:21:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739442112;
	bh=gq7ND6kmYg+T1S0KrCZyvliNRe+2JR8aZgE6LYBivnI=;
	h=From:To:CC:Subject:Date;
	b=CTWWnjQigDlXoqighn2ZaQgQOLwJUB+Og4DOsg93qv1gboYxQx/dFzW14jTZkx8vC
	 /48qtGiEH/ByGsKuCmcYdcob4cE/0lZaac7zgf7wgeeljNouvWz7gGDOxvBA8PsA9C
	 ch9VUk4AQEe53QQIYhJYYT2RDY1IcRiDGEOM13LQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51DALqVX011050
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Feb 2025 04:21:52 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Feb 2025 04:21:52 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Feb 2025 04:21:52 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51DALpnC077706;
	Thu, 13 Feb 2025 04:21:51 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Rosen Penev <rosenp@gmail.com>,
        Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>,
        Chintan Vankar <c-vankar@ti.com>, Paolo
 Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King
	<linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn
	<andrew@lunn.ch>
CC: <s-vadapalli@ti.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: [PATCH] net: phy: mscc: Add auto-negotiation feature to VSC8514
Date: Thu, 13 Feb 2025 15:51:50 +0530
Message-ID: <20250213102150.2400429-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add function vsc85xx_config_inband_aneg() in mscc_main.c to enable
auto-negotiation. The function enables auto-negotiation by configuring
the MAC SerDes PCS Control register of VSC8514.

Invoke the vsc85xx_config_inband_aneg() function from the
vsc8514_config_init() function present in mscc_main.c to start the
auto-negotiation process. This is required to get Ethernet working with
the Quad port Ethernet Add-On card connected to J7 common processor board.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is based on commit '7b7a883c7f4d' of linux-next branch of
Mainline Linux.

Regards,
Chintan.

 drivers/net/phy/mscc/mscc.h      |  2 ++
 drivers/net/phy/mscc/mscc_main.c | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index 6a3d8a754eb8..3baa0a418bae 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -196,6 +196,8 @@ enum rgmii_clock_delay {
 #define MSCC_PHY_EXTENDED_INT_MS_EGR	  BIT(9)
 
 /* Extended Page 3 Registers */
+#define MSCC_PHY_SERDES_PCS_CTRL          16
+#define MSCC_PHY_SERDES_ANEG              BIT(7)
 #define MSCC_PHY_SERDES_TX_VALID_CNT	  21
 #define MSCC_PHY_SERDES_TX_CRC_ERR_CNT	  22
 #define MSCC_PHY_SERDES_RX_VALID_CNT	  28
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 19cf12ee8990..f1f36ee1cc59 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -1699,6 +1699,21 @@ static int vsc8574_config_host_serdes(struct phy_device *phydev)
 			   PROC_CMD_RST_CONF_PORT | PROC_CMD_FIBER_1000BASE_X);
 }
 
+static int vsc85xx_config_inband_aneg(struct phy_device *phydev, bool enabled)
+{
+	u16 reg_val = 0;
+	int rc;
+
+	if (enabled)
+		reg_val = MSCC_PHY_SERDES_ANEG;
+
+	rc = phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_3,
+			      MSCC_PHY_SERDES_PCS_CTRL, MSCC_PHY_SERDES_ANEG,
+			      reg_val);
+
+	return rc;
+}
+
 static int vsc8584_config_init(struct phy_device *phydev)
 {
 	struct vsc8531_private *vsc8531 = phydev->priv;
@@ -2107,6 +2122,11 @@ static int vsc8514_config_init(struct phy_device *phydev)
 
 	ret = genphy_soft_reset(phydev);
 
+	if (ret)
+		return ret;
+
+	ret = vsc85xx_config_inband_aneg(phydev, true);
+
 	if (ret)
 		return ret;
 
-- 
2.34.1


