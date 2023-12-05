Return-Path: <netdev+bounces-53881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F048805085
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1472817C0
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E85E56B62;
	Tue,  5 Dec 2023 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+D6XCi/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259D319AA;
	Tue,  5 Dec 2023 02:36:34 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c9c18e7990so75009791fa.2;
        Tue, 05 Dec 2023 02:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701772592; x=1702377392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjKEFhPSgLN5vGtDlHZQvN1ZMYBQW2UNIHEU4iW11KA=;
        b=X+D6XCi/tCluZAO8Db+1qgfEZEDEm7Fkgg7MncAGseOvsLFJlCf4CBk6ndemIo8bBy
         JKmQeNfsf3oq/ZADL9kB/Ofgslx3MUkuJLPEQ6x5rV7OOU7i1oUMky2YVewEwN05Ybuu
         Qd0pm6lNtBBjYBQyVO+JbRNu01drP0Xgw4aSidNQsbG/OMbqFKTbPIq7i3r7QsUFq09W
         UeqYbuLgZTGNiLLOy99AmW7FNiFRbwsFWmUPjaulmpERu1h706UMTBTFpij+vVZaWmVT
         b6Qb7JwYCrncxBb74F4DQ7HnL1qgxn4Nfqtv3RH7Ja6CDe0jzrCovMCiLc+LUyGZFufZ
         7waQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701772592; x=1702377392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjKEFhPSgLN5vGtDlHZQvN1ZMYBQW2UNIHEU4iW11KA=;
        b=HAAzjbvVjtDi/aOwVgBCqmI6HIwcn8UOHkB3yXi1NcveIKm87cJLOOz1K1Ub3LEvYT
         HHyyi82WfkXf/mbnjb1Um4Zv4lN27rR4sEOp70O3p5yKw2JsjrJzFU4xN0g9Pq2QgVHg
         qEF+H3ozw6BdkOvC9o/mWSLtBSmlR1epBx6NV6EX4ywdFJ3nEG1+LjTyPL/0yhl5V6C2
         aQrD4zyKhxegIXmfUWozTCe/4ocJ6E3AjmLv6raOU4mfY87Tkmq6O/RwlQAkTCAOUqsH
         UlZGGE//pZaDPQMoV2hSMzwoK6ANEMYpqTvMpyn8yfPM273q9jZHSz0rSUC37pR1zTd2
         yOFw==
X-Gm-Message-State: AOJu0Yysm95JXTklYD7XBQMgFRw9ePh+PDHQuagenOGtoeAB7eElEb0H
	CGpDiBK6//JSOz1UsyQr8KA+oxaYFO6Rjg==
X-Google-Smtp-Source: AGHT+IEV4/NEvKyiG2pISjXXhGEzBDyRRwcjqLkOq0cFAE1HY0eO+MjW4de0kYE72+xi26ZTN01x/w==
X-Received: by 2002:a05:651c:85:b0:2ca:30a:8390 with SMTP id 5-20020a05651c008500b002ca030a8390mr1586235ljq.85.1701772592265;
        Tue, 05 Dec 2023 02:36:32 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id a21-20020a05651c031500b002c9e9c29670sm1153531ljp.47.2023.12.05.02.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:36:31 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 16/16] net: stmmac: Add externally detected DW XPCS support
Date: Tue,  5 Dec 2023 13:35:37 +0300
Message-ID: <20231205103559.9605-17-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231205103559.9605-1-fancer.lancer@gmail.com>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's possible to have the DW XPCS device accessible over an external bus
(external MDIO or DW XPCS management interface). Thus it will be futile to
try to detect the device on the local SMA interface. Besides such platform
setup isn't supported by the STMMAC driver anyway since the
stmmac_mdio_bus_data instance might not be created and even if it is there
is no code path which would set the stmmac_mdio_bus_data.has_xpcs flag
thus activating the XPCS device setup.

So in order to solve the denoted problem a pretty much standard approach
is implemented: DT "pcs-handle" property is used to get the phandle
referencing the DT-node describing the DW XPCS device; device node will be
parsed by the xpcs_create_bynode() method implemented in the DW XPCS
driver in a way as it's done for PHY-node; the node is used to find the
MDIO-device instance, which in its turn will be used to create the XPCS
descriptor.

Note as a nice side effect of the provided change the conditional
stmmac_xpcs_setup() method execution can be converted to the conditional
statements implemented in the function itself. Thus the stmmac_open() will
turn to look a bit simpler meanwhile stmmac_xpcs_setup() will provide the
optional XPCS device semantic.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  8 ++---
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 34 ++++++++++++-------
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 379552240ac9..a33ba00d091d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7604,11 +7604,9 @@ int stmmac_dvr_probe(struct device *device,
 	if (priv->plat->speed_mode_2500)
 		priv->plat->speed_mode_2500(ndev, priv->plat->bsp_priv);
 
-	if (priv->plat->mdio_bus_data && priv->plat->mdio_bus_data->has_xpcs) {
-		ret = stmmac_xpcs_setup(ndev);
-		if (ret)
-			goto error_xpcs_setup;
-	}
+	ret = stmmac_xpcs_setup(ndev);
+	if (ret)
+		goto error_xpcs_setup;
 
 	ret = stmmac_phy_setup(priv);
 	if (ret) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 101fa50c3c96..b906be363b61 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -499,25 +499,33 @@ int stmmac_xpcs_setup(struct net_device *ndev)
 {
 	struct stmmac_priv *priv;
 	struct dw_xpcs *xpcs;
-	int mode, addr;
+	int ret, mode, addr;
 
 	priv = netdev_priv(ndev);
 	mode = priv->plat->phy_interface;
 
-	/* Try to probe the XPCS by scanning all addresses. */
-	for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
-		xpcs = xpcs_create_byaddr(priv->mii, addr, mode);
-		if (IS_ERR(xpcs))
-			continue;
-
-		priv->hw->xpcs = xpcs;
-		break;
+	/* If PCS-node is specified use it to create the XPCS descriptor */
+	if (fwnode_property_present(priv->plat->port_node, "pcs-handle")) {
+		xpcs = xpcs_create_bynode(priv->plat->port_node, mode);
+		ret = PTR_ERR_OR_ZERO(xpcs);
+	} else if (priv->plat->mdio_bus_data && priv->plat->mdio_bus_data->has_xpcs) {
+		/* Try to probe the XPCS by scanning all addresses */
+		for (ret = -ENODEV, addr = 0; addr < PHY_MAX_ADDR; addr++) {
+			xpcs = xpcs_create_byaddr(priv->mii, addr, mode);
+			if (IS_ERR(xpcs))
+				continue;
+
+			ret = 0;
+			break;
+		}
+	} else {
+		return 0;
 	}
 
-	if (!priv->hw->xpcs) {
-		dev_warn(priv->device, "No xPCS found\n");
-		return -ENODEV;
-	}
+	if (ret)
+		return dev_err_probe(priv->device, ret, "No xPCS found\n");
+
+	priv->hw->xpcs = xpcs;
 
 	return 0;
 }
-- 
2.42.1


