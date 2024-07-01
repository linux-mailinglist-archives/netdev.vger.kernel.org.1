Return-Path: <netdev+bounces-108242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C4791E795
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6DD2855C6
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8710017332C;
	Mon,  1 Jul 2024 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkpqRLAc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB25172BCE;
	Mon,  1 Jul 2024 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858583; cv=none; b=OjQH7I24wvjKheFIL9AKvqrIcI7KuAPsnyapZo5xFoJ5S2MX/RaFus7isGe2YQEo80ZtO++T5ZLDdiLR0HunmL6557/6o6GFcLNJ8wMht2wsZtWnJq1uuS1RbJTcZY812AgYQa8TrpmZ6KJBJGWqvfRj8gUniFc9ZeGDcRnLKA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858583; c=relaxed/simple;
	bh=xBXYNDbeyCBawYjGFxzikJYg2wnfDh4mK79QNUmfyHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unMdekJL7Lj3+92mwoBEJ2sSNGZicuolKfc8FrzX17tAtCwxOwgyeNh19pXzS/BlWjjdiTL//v2frLYSlYFhh2i//VwNjbvuNoXFlj9hv163j/4wa0vzQ3dvG+pnHzEbLQjfyNxSIUcjZ0DkTUjpIb72wz7QXAl60Y7GfIMdJcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkpqRLAc; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52e8037f8a5so2963394e87.1;
        Mon, 01 Jul 2024 11:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719858580; x=1720463380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwdWmsxJGte/AlXrge1uNMnv/5k0a7uNzExpSpmyGFM=;
        b=fkpqRLAc/4GBIE2G3HLJ0c6gUqFU2GhI1WPJxNFT3QCXaew2IdpZltsaIhcRBTlnM2
         Qv3MzyMNc1bjIf5J+qBRDxWjWbW0e2Umr5IU7UfXgXIClXAYg17LgB1IHNQAXK6Jwjm6
         KOjapBz8mi/Qi02hzOxA4iFtOUnp5nVALkYNcty0jPKXp2zxgtDRJSOTh91FO1Y69S3f
         olEpVx3ljlku5p97pxGTGnPfOf7T7EzecXZk/eeRqL7B61Oj9WAZ1FdRH/1v7FyTQiXU
         fH38IfbF2RjEYcCpkBS89dktzUNqXixn4b649NUitAd/YeMiEa97TsAbIPuOZVPVPRil
         enLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719858580; x=1720463380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwdWmsxJGte/AlXrge1uNMnv/5k0a7uNzExpSpmyGFM=;
        b=TlBRGh/iUrt38dFmMDo44V6XcH/BPJ7G7+gsdpDxL0YpWAzFh4tjm96eh7Aew8KYpu
         kwcudvX2EcjJsZ0PRa2ovOJlZLQumTOiNOKrnkhhZ9Cj60nVK2NAKGDv/x5y9TcRQ3eD
         KXEPdm3mrKw6s3I9lIBo+pSfCeXIuTmkaCURPnUPZXchjdUxc/CgzKp1QaiM0tpu35Ep
         0VdxqnZppiZwD9N73pD9XrvO82lud2PJzY8SkVT3SBkJibuVSJRkkjtpc5Ymth+5ddxS
         3uMVQCsc5NEGHLNcoVbxLA4gNN9l10dtwdRBXhjpzjbe4oTT3mUWuKOiTGeZNTZR+9IN
         odiA==
X-Forwarded-Encrypted: i=1; AJvYcCU+jmRHauXcq0JHf4MeXugcyBfGNfr5899UWVEmZrrmki1F8PaRdZ9BRg032W3+NG/c60ZDEJtRekJGpjPa1ToQ0LwV4ml5jDmcQbhdLxDi8bqcejp3OLsdfRbk0z9gbMl28//I6nfmpvt2KtHa5mkE4acZDQ0Fxndlw6Udzu9wnw==
X-Gm-Message-State: AOJu0YxhrbTlaVnBc1XG/8PCtn+FGHDN26z+lmfGTU1Pj3sJCsQuWShV
	Ecyu8EHZUngcCWqwZ/2jxvAP+UNQXaggg/9ptYbP2ZVZLZhxOaBs
X-Google-Smtp-Source: AGHT+IH+usFmi8nGYGVjZyOBQShUQKaabnrIDbcVrIFuwz1DdhjycdrfBHNvunLB3ek66/m3uuGVJQ==
X-Received: by 2002:a05:6512:1382:b0:52c:9942:b008 with SMTP id 2adb3069b0e04-52e8264deabmr5418718e87.2.1719858579638;
        Mon, 01 Jul 2024 11:29:39 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab27b14sm1532619e87.125.2024.07.01.11.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:29:38 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v4 09/10] net: stmmac: Create DW XPCS device with particular address
Date: Mon,  1 Jul 2024 21:28:40 +0300
Message-ID: <20240701182900.13402-10-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701182900.13402-1-fancer.lancer@gmail.com>
References: <20240701182900.13402-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the only STMMAC platform driver using the DW XPCS code is the
Intel mGBE device driver. (It can be determined by finding all the drivers
having the stmmac_mdio_bus_data::has_xpcs flag set.) At the same time the
low-level platform driver masks out the DW XPCS MDIO-address from being
auto-detected as PHY by the MDIO subsystem core. Seeing the PCS MDIO ID is
known the procedure of the DW XPCS device creation can be simplified by
dropping the loop over all the MDIO IDs. From now the DW XPCS device
descriptor will be created for the MDIO-bus address pre-defined by the
platform drivers via the stmmac_mdio_bus_data::pcs_mask field.

Note besides this shall speed up a bit the Intel mGBE probing.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- This is a new patch introduced on v2 stage of the review.

Changelog v3:
- Convert the stmmac_mdio_bus_data::has_xpcs and
  stmmac_mdio_bus_data::xpcs_addr fields to a single
  stmmac_mdio_bus_data::pcs_mask.
---
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 19 ++++++-------------
 include/linux/stmmac.h                        |  2 +-
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 094d34c4193c..2dbfbca606af 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -595,7 +595,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	/* Intel mgbe SGMII interface uses pcs-xcps */
 	if (plat->phy_interface == PHY_INTERFACE_MODE_SGMII ||
 	    plat->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
-		plat->mdio_bus_data->has_xpcs = true;
+		plat->mdio_bus_data->pcs_mask = BIT(INTEL_MGBE_XPCS_ADDR);
 		plat->mdio_bus_data->default_an_inband = true;
 		plat->select_pcs = intel_mgbe_select_pcs;
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index aa43117134d3..74de6ec00bbf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -499,8 +499,7 @@ int stmmac_pcs_setup(struct net_device *ndev)
 {
 	struct dw_xpcs *xpcs = NULL;
 	struct stmmac_priv *priv;
-	int ret = -ENODEV;
-	int mode, addr;
+	int addr, mode, ret;
 
 	priv = netdev_priv(ndev);
 	mode = priv->plat->phy_interface;
@@ -508,16 +507,10 @@ int stmmac_pcs_setup(struct net_device *ndev)
 	if (priv->plat->pcs_init) {
 		ret = priv->plat->pcs_init(priv);
 	} else if (priv->plat->mdio_bus_data &&
-		   priv->plat->mdio_bus_data->has_xpcs) {
-		/* Try to probe the XPCS by scanning all addresses */
-		for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
-			xpcs = xpcs_create_mdiodev(priv->mii, addr, mode);
-			if (IS_ERR(xpcs))
-				continue;
-
-			ret = 0;
-			break;
-		}
+		   priv->plat->mdio_bus_data->pcs_mask) {
+		addr = ffs(priv->plat->mdio_bus_data->pcs_mask) - 1;
+		xpcs = xpcs_create_mdiodev(priv->mii, addr, mode);
+		ret = PTR_ERR_OR_ZERO(xpcs);
 	} else {
 		return 0;
 	}
@@ -610,7 +603,7 @@ int stmmac_mdio_register(struct net_device *ndev)
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "%s-%x",
 		 new_bus->name, priv->plat->bus_id);
 	new_bus->priv = ndev;
-	new_bus->phy_mask = mdio_bus_data->phy_mask;
+	new_bus->phy_mask = mdio_bus_data->phy_mask | mdio_bus_data->pcs_mask;
 	new_bus->parent = priv->device;
 
 	err = of_mdiobus_register(new_bus, mdio_node);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 9c54f82901a1..84e13bd5df28 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -82,7 +82,7 @@ struct stmmac_priv;
 
 struct stmmac_mdio_bus_data {
 	unsigned int phy_mask;
-	unsigned int has_xpcs;
+	unsigned int pcs_mask;
 	unsigned int default_an_inband;
 	int *irqs;
 	int probed_phy_irq;
-- 
2.43.0


