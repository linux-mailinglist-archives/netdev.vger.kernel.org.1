Return-Path: <netdev+bounces-108243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B92291E798
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8040D1F230E3
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F241741D0;
	Mon,  1 Jul 2024 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLScsTGP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452BE173348;
	Mon,  1 Jul 2024 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858585; cv=none; b=LYkw/ECo/r9TsJoP2kMTROWHtm6L2y+dCUBTik1U7m/Ts/UN+GG3Yw3pSh9xiVgKL3jyAdANeTSEGQDX4szg273bnzrj6BfQ8Kg59b5FFt+QYhlMihs7DQM+QxmON9AVaW4Pvhg/X67ooLAW3Tqt3+yGFqY871Sso5UXTl8mEYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858585; c=relaxed/simple;
	bh=xj2Cr4TyHsmmOYefzTQwzoHeqZD22q0utO2EV+/SVb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVdzuBs0UEaa3o/n+Zc1l0ekcguZpfcrASlxYEjiM2UzccLthxFk/uzghEt3CVZ1Vt2mERX7BfhaJAfpYUwjkzC6ndURXJfYb07PgrXW3BBnsiwycBZZe7Dl5gkOmLhbpkkKCYL+6gCdFpHNO62PynXsbh0oyZ4aO7mLKLqSxks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLScsTGP; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so33005881fa.1;
        Mon, 01 Jul 2024 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719858582; x=1720463382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGa0V/+q1PY+8AtdQff4+HTCc2sbpBqj/v0lwdLsGCU=;
        b=fLScsTGPZsRUryyCx45lJehtt4FF7E62oBBO+tX+5yKGQJX2kHuGksO811dE1lN/Hv
         cVKMghKnfuUzqNAPAWE+MVG09h6y1AAH1kx1JJYir6XudTDDdhX195/Rv86+BukI9gPc
         gzjEazenUbN7KamPuYh0pArAWQYQaVRodlJ/re6TJ6jAxLSHD2a0NHgeLds7dPEKQyIK
         r5zPOWfu59Uf4nIzu1jOMl+LS0NttL0mqMm7vajXBT3BchwnQeuYz+x2T1FH8ar/m/hW
         QB8MqT5A4wNidOLAcI3FJUYjN4pqX0q7JIL59OnrMhWsl48MKxeaQytuu8PaFoGo8CNr
         EtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719858582; x=1720463382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGa0V/+q1PY+8AtdQff4+HTCc2sbpBqj/v0lwdLsGCU=;
        b=F4jw0y4w6BWo+4gWYFLBpvM2MVWFyPTDzCmSwjs0uL0N56H83fB/O53jmdI87rDQxy
         UurQQRJjFw7ITBSkJqIi8fdMlVmDXgqEcmzhgQxLybkBZBRitTTEQBhyRGfeM86Htu1X
         Q0/PfaOL/wSCyEE5vw62F5YIqqAfdDEXzOfziXdFHa+Cbr2VjgmB2JIlcwtvSKoDktJw
         SkAb3mtHa8JTM261LWvV1tc3Jiuhv9QI3gVSaTv+Wj5QwaBFtv0Wn/WBqbAZNijvukbB
         3UKKKULt+Rtcvpvj91bWUuy0Ay51zb6GVuxyC2MdaUbPEqFM3zaxhJXPeMJ6a3/xQSsr
         f4pQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5n3bOJIr7XIaw9KoVZJKmxwDGMgMbV66f0yfMYFsv3XXV3f4CkI2VMxEZKKta/FO/tfLYRtrffjvDc5NSfTCiatW3I1WBtZNWqGDuiw7eiv9vJAXvPupE0YIljU3G2XXgr5mPhTYZDLzugKeW91FFvBG+7/wsI3bhqTCmHSfuDQ==
X-Gm-Message-State: AOJu0YzTyo8kY7S2O/R/HQxJVSF7aTyfUCSjAu7v7Lk0sSQ4exGGthAx
	PyBo1kTCKPDxR6UOS+kw8eRTgg7+KAsxOA95lEu/924lyskJ+aXe
X-Google-Smtp-Source: AGHT+IFXnUFdgrXA1uR1LN5UmTAA18az9EpTs+N0Pv9356JIFI06IvJbJFQAahcrWN6Else101zSvA==
X-Received: by 2002:a2e:b535:0:b0:2ec:4eca:748b with SMTP id 38308e7fff4ca-2ee5e39260amr38054481fa.14.1719858582315;
        Mon, 01 Jul 2024 11:29:42 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee5168d0c2sm14452161fa.124.2024.07.01.11.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:29:41 -0700 (PDT)
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
Subject: [PATCH net-next v4 10/10] net: stmmac: Add DW XPCS specified via "pcs-handle" support
Date: Mon,  1 Jul 2024 21:28:41 +0300
Message-ID: <20240701182900.13402-11-fancer.lancer@gmail.com>
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

Recently the DW XPCS DT-bindings have been introduced and the DW XPCS
driver has been altered to support the DW XPCS registered as a platform
device. In order to have the DW XPCS DT-device accessed from the STMMAC
driver let's alter the STMMAC PCS-setup procedure to support the
"pcs-handle" property containing the phandle reference to the DW XPCS
device DT-node. The respective fwnode will be then passed to the
xpcs_create_fwnode() function which in its turn will create the DW XPCS
descriptor utilized in the main driver for the PCS-related setups.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 74de6ec00bbf..03f90676b3ad 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -497,15 +497,22 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 
 int stmmac_pcs_setup(struct net_device *ndev)
 {
+	struct fwnode_handle *devnode, *pcsnode;
 	struct dw_xpcs *xpcs = NULL;
 	struct stmmac_priv *priv;
 	int addr, mode, ret;
 
 	priv = netdev_priv(ndev);
 	mode = priv->plat->phy_interface;
+	devnode = priv->plat->port_node;
 
 	if (priv->plat->pcs_init) {
 		ret = priv->plat->pcs_init(priv);
+	} else if (fwnode_property_present(devnode, "pcs-handle")) {
+		pcsnode = fwnode_find_reference(devnode, "pcs-handle", 0);
+		xpcs = xpcs_create_fwnode(pcsnode, mode);
+		fwnode_handle_put(pcsnode);
+		ret = PTR_ERR_OR_ZERO(xpcs);
 	} else if (priv->plat->mdio_bus_data &&
 		   priv->plat->mdio_bus_data->pcs_mask) {
 		addr = ffs(priv->plat->mdio_bus_data->pcs_mask) - 1;
@@ -515,10 +522,8 @@ int stmmac_pcs_setup(struct net_device *ndev)
 		return 0;
 	}
 
-	if (ret) {
-		dev_warn(priv->device, "No xPCS found\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(priv->device, ret, "No xPCS found\n");
 
 	priv->hw->xpcs = xpcs;
 
-- 
2.43.0


