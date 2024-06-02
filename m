Return-Path: <netdev+bounces-99996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD68A8D765F
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 16:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFF01F21685
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 14:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F8578C90;
	Sun,  2 Jun 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKz61syp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31619763E7;
	Sun,  2 Jun 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717339024; cv=none; b=u4zE5VW+gOpytlBqQD5/hob30ZX5U1aiK6QlH20oigBYgBd6BG1tKn9wsESlFl3ujvX42lVVebaWwNHysysPz8jff54j4p47SL67kvC2zKMnK6EXbQKa/LEmLy+1KPHXl6dZzH3lzfOc9++aplbYfA54RxXkUv3DKUqt5sNyCi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717339024; c=relaxed/simple;
	bh=6YA0qQck5rrALyZPnAu3fKQKni/OD78aR0XOtu0VSYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOetzJ56gx3i9fXfj4rZp3T5IhRCXswyDzZHlqvVXU3TJBV9M4oA/vWsRFhwgpMzP0pUxaFDyNc4MONANKdTweI/o3Fx3yWk5EVxvTwtVEAEqQBN3+JypjpM+HdxzEAq8lNoaIW3M5n1B78Z37gKckh2TFVA9QBuQpvU2QxxQdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKz61syp; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b88740a93so2439286e87.3;
        Sun, 02 Jun 2024 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717339021; x=1717943821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vjMvBNpGJ2YRY1Cb9nA1dqsGS8aAwxtGRodJv9KKVo=;
        b=WKz61sypK1a5CHvSBRPhbokg09bD1eIE/kMEQB8JuWlhfmyyODvd4fPwai7Djbk2Yh
         oztA33sbHOrFUdJSCMo4AP1giBAjQ/86/a5KVkS7YpqXTMYNHv7/1d+9n0n/d3z61+ej
         W+lyp4m/mocHsMTwom06gzflofTa7B+RgeJ5vwYIHMW70Vnx0Wqm2rx9QQ0QOUyUNGIc
         2HjMdEqUV/Ipfa5JEwU+npn/cOjOac0lUo+D3jWFTTccM4aPCSL657Ds88aMu8OgkJ6y
         fsNUR3P2UKsOEJtnT5OJG2HQJa2UShnMsK9BiyTLjAAWYjyOf2j3wGPGgWPtN/r5gD6m
         R0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717339021; x=1717943821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vjMvBNpGJ2YRY1Cb9nA1dqsGS8aAwxtGRodJv9KKVo=;
        b=DshgClFil3bctltjx9hKIQEP5Kqu/wjKBUQbwTrIlEazXEKFELUuG0B5PweV5PcpXS
         2nVt1V7F481OmiCZ3ZnNFFnncvZV3nUMtuBdYoUZq5wKFjm/f6Kb6a0VPxEgrG0uWBKQ
         n5ebybaayx15Oj+36Mak2MzklwPNvC0k38Pstxv0iTaNtlTPLeLTXCloW/5k2xlGFe46
         KZNh54ZK5fFejcqdOo9NGUXa515dUHLilDwAvUWYLAEgioC9f4dTDJSMOHqh11Y4Y0DN
         n9+13qV4jj1ZsACC5j60GUJdqNr/1+vuN4zf2fkrhRPvbsbqHl7mdFYCqA0gmA9WKLhU
         x4vA==
X-Forwarded-Encrypted: i=1; AJvYcCW7JQUUUri186lsxi4/wvUuEzwV26aQNmc7a4xOy0/as5h7L23KyW43LO24Qdbt1PkmzDS9eZxOUEXl7scYI+scs+A5K/jM23+t4Nz2bAS+Azx+cZVwflO24L71ZgNWXD0nfZnJGCrj+x3xJaFGSb+ecgRBEKbwjFVP+phAWtqpUw==
X-Gm-Message-State: AOJu0YzyND2IlsZ0woFzDBTRQIJV9pn/BNB83YTAUecj98SBKLo7UT3M
	QpdrsV5GLEVLgOtAcvqYlnJm4pOE0quAj2P/quR0iAw8xKxUml4v
X-Google-Smtp-Source: AGHT+IF+Hex+g3j4f6h2pCksD9/xzuP9uZz4YvqyQTtFSMyXUw0x6Mqvz4SNvUNBrOtKz3gPvsNgXg==
X-Received: by 2002:a05:6512:4c6:b0:52b:5f39:9221 with SMTP id 2adb3069b0e04-52b896f183fmr4063497e87.64.1717339021163;
        Sun, 02 Jun 2024 07:37:01 -0700 (PDT)
Received: from localhost ([178.178.142.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b98fb5c5asm152445e87.16.2024.06.02.07.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 07:37:00 -0700 (PDT)
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
Subject: [PATCH net-next v2 09/10] net: stmmac: Create DW XPCS device with particular address
Date: Sun,  2 Jun 2024 17:36:23 +0300
Message-ID: <20240602143636.5839-10-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240602143636.5839-1-fancer.lancer@gmail.com>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
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
descriptor will be created for the pre-defined MDIO-bus address.

Note besides this shall speed up a bit the Intel mGBE probing.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- This is a new patch introduced on v2 stage of the review.
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 15 ++++-----------
 include/linux/stmmac.h                            |  1 +
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 56649edb18cd..e60b7e955c35 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -586,6 +586,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	if (plat->phy_interface == PHY_INTERFACE_MODE_SGMII ||
 	    plat->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
 		plat->mdio_bus_data->has_xpcs = true;
+		plat->mdio_bus_data->xpcs_addr = INTEL_MGBE_XPCS_ADDR;
 		plat->mdio_bus_data->default_an_inband = true;
 	}
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index aa43117134d3..807789d7309a 100644
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
@@ -509,15 +508,9 @@ int stmmac_pcs_setup(struct net_device *ndev)
 		ret = priv->plat->pcs_init(priv);
 	} else if (priv->plat->mdio_bus_data &&
 		   priv->plat->mdio_bus_data->has_xpcs) {
-		/* Try to probe the XPCS by scanning all addresses */
-		for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
-			xpcs = xpcs_create_mdiodev(priv->mii, addr, mode);
-			if (IS_ERR(xpcs))
-				continue;
-
-			ret = 0;
-			break;
-		}
+		addr = priv->plat->mdio_bus_data->xpcs_addr;
+		xpcs = xpcs_create_mdiodev(priv->mii, addr, mode);
+		ret = PTR_ERR_OR_ZERO(xpcs);
 	} else {
 		return 0;
 	}
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index f337286623bb..a11b850d3672 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -83,6 +83,7 @@ struct stmmac_priv;
 struct stmmac_mdio_bus_data {
 	unsigned int phy_mask;
 	unsigned int has_xpcs;
+	unsigned int xpcs_addr;
 	unsigned int default_an_inband;
 	int *irqs;
 	int probed_phy_irq;
-- 
2.43.0


