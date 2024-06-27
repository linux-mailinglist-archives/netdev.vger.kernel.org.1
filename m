Return-Path: <netdev+bounces-107096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FEB919BFA
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 02:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FF21F21730
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 00:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967D52C87C;
	Thu, 27 Jun 2024 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nc5SmfDY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B084C28DCC;
	Thu, 27 Jun 2024 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719448942; cv=none; b=sXSVYZvu9WS2GyPqziFzjTC9HCROqcZppw8rYTa+oAXuTsvtphbfh7E9+T7n70j6kHG4x59QEhVQqNQDJIK+fZ33tJrdXCI9bp4zjjvKC8+nXjCCjMEzPM5EGfZfA4MT5wb2/C36V9/e2jPSgrUvk7aaXiQi6BbJdvpojuqLhAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719448942; c=relaxed/simple;
	bh=RbRBEfyx5GSlWaDW+6Ec4J6UngrdoauVCyIPqe1BDos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndnWsQ7QLn9dJIqHOVGTAVhfEVNHvRFNvjyy4RrKon3y/Iq5peBg0dP0H5YNHlNIVkvS+8VaSvVxNbsTy0xc0fF4Hnstax5VZta+45nx8dlijJFnop+yazGPldikUyoXZ8Z0YHKpwCWmFi3oNHwNxkM3pER9zPjMV3rjJfcCeco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nc5SmfDY; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cd6784aa4so6797858e87.3;
        Wed, 26 Jun 2024 17:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719448939; x=1720053739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/DzP68lfgVfGdnzI91xR3ftLlGlC3/UD2QyQGN9bLk=;
        b=Nc5SmfDYCIdij/OJO54XoD03sClYQFdhglyz4D6vM04iko0Tf/XUWEt+cWSO6WL52i
         fLHSKHGBmxhl3+q41LNLnBnsS+CC16G2VQoscFIqdqrthBAPdIxmzA5J8ho0otxxKEfu
         YpMlk9gj1yoYgQL/xvUxvCzGJk6GkJJanSbVycfeCa/MQtaIE20pOr3e+qhY5E/apq3A
         mQ1jGXmPwLqmvScC7KDNmfjxzcUdWQ5WHO5E6CcfVGrQCrFBYNsOxqJ3tFqUyAMwTlrV
         SYYN+SuYDj7Kmjnu5Yd2t5qqL9ksGNo5KLClgJQpLznqian+50bqd+UNA/3UjecZ55G+
         aXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719448939; x=1720053739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/DzP68lfgVfGdnzI91xR3ftLlGlC3/UD2QyQGN9bLk=;
        b=AnoZMTvbbdIs36pVKiPyjQMHt3zQDElPMurkQHsqQpDnacPHsaJ6p6UxDOAaaWcdor
         XHCwVDzbGmEdVHHS3U7OYpcNVVe4CkefLCgW+wshgl7qJQKPZ0o8DfArX5ANQx/vitrN
         t6PzYBlOB0+j9f2MUUMoPIWl6WB+Fy7RRxKr4y1jwh+OQgbOwpNShgKjoC4nx4F21MM2
         unDiqOsUgnGXLx38YXTvKcJZpby+0W2Nst7M8dwhqBLhdsTu1wP2xEswsmfOw+QIuaPg
         oKaSasWNrWmsV5vfnog+lAOqkha0+y2LdZr2WRKGQuxFBpIW2ElBxXpt00bc6/dwhjAL
         iNHA==
X-Forwarded-Encrypted: i=1; AJvYcCVSswzJpuNlQWqM68UiaqiYvQSdMf1I/JdZ6/DQK//9Ze12ytQVpUDkh12hccgyL9lI2i0MTujG7/Of9rHsXkhmKi7Z78vYAV61R8a2WGa76M2nNPejbCGrniRlENIfi9FgjVg3Qg06ASkK++mWMZu94KN+UJuhsIgbvQL6wyIkJw==
X-Gm-Message-State: AOJu0YxncWyqR0D+n5Ur2BkOdcGLkiQ7nR6Z0q189LxcpR6I18UANMLv
	l0lBR6AeeTCLxOMT0/6aWLumMLrl2qygq1aCRh4Feq9HRxUP2TAL
X-Google-Smtp-Source: AGHT+IGAA2BO5YOL7taM3d9DMMHzx/LRxPmbgipRcJNYHxa+dWLbnw4m2lzAlZ/2X5OQLvSi1Es+Aw==
X-Received: by 2002:a05:6512:3130:b0:52b:8ef7:bf1f with SMTP id 2adb3069b0e04-52ce183427cmr7043084e87.17.1719448938737;
        Wed, 26 Jun 2024 17:42:18 -0700 (PDT)
Received: from localhost ([89.113.147.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e712b2f5esm20801e87.86.2024.06.26.17.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 17:42:18 -0700 (PDT)
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
Subject: [PATCH net-next v3 09/10] net: stmmac: Create DW XPCS device with particular address
Date: Thu, 27 Jun 2024 03:41:29 +0300
Message-ID: <20240627004142.8106-10-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627004142.8106-1-fancer.lancer@gmail.com>
References: <20240627004142.8106-1-fancer.lancer@gmail.com>
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
index 56649edb18cd..ebca8e61087f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -585,7 +585,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	/* Intel mgbe SGMII interface uses pcs-xcps */
 	if (plat->phy_interface == PHY_INTERFACE_MODE_SGMII ||
 	    plat->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
-		plat->mdio_bus_data->has_xpcs = true;
+		plat->mdio_bus_data->pcs_mask = BIT(INTEL_MGBE_XPCS_ADDR);
 		plat->mdio_bus_data->default_an_inband = true;
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
index 8f0f156d50d3..ec05c881b1f4 100644
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


