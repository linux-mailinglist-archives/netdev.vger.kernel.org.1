Return-Path: <netdev+bounces-218450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB903B3C778
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52AFE7ACDAE
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652C3257AF3;
	Sat, 30 Aug 2025 02:34:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB77D257829;
	Sat, 30 Aug 2025 02:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756521297; cv=none; b=H77c2qQu737GVbrJkgZZ+9agkBSNS0Y/0+InRT+MUQXPeM2IBcjn6GaXoRY1VwTXF53xce6Ax2VYBROZk2Zk3X/zMbPrn6JUixWOQMe4uN7iP4q6P6+hBHRE7BDu+3KAn7xl4MuaJM2+Ao1sYUYlZbyL7kxGj9AeHwkYx/AvI3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756521297; c=relaxed/simple;
	bh=/lgXHRubUP/8cxoFx2QUkE7QqbJ/z4M/g68O76DkIVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfhS3FiIb8P70jzP27IDG3VWPFz6RURAbmcrVIwppGl0pwIonPb3vW8fDGrYoszAVAP6KKitJukl0b0afrtLG9Ms8IQHiLkxXz5oEY8SdFFxDLtm8dLT57bGZlByw6rOcq6qP3rmOSMOvo0AzMEeaKguMlyoPpbn5pFhlQXAn9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1usBQZ-000000005xi-1Pyf;
	Sat, 30 Aug 2025 02:34:51 +0000
Date: Sat, 30 Aug 2025 03:34:48 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v4 6/6] net: dsa: lantiq_gswip: move MDIO bus
 registration to .setup()
Message-ID: <2650602042c0bfdc5664b88d59071ed4dca96c26.1756520811.git.daniel@makrotopia.org>
References: <cover.1756520811.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756520811.git.daniel@makrotopia.org>

Instead of registering the switch MDIO bus in the probe() function, move
the call to gswip_mdio() into the .setup() DSA switch op, so it can be
reused independently of the probe() function.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Hauke Mehrtens <hauke@hauke-m.de>
---
v4: no changes
v3: no changes
v2: no changes

 drivers/net/dsa/lantiq/lantiq_gswip.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 43f83c0736d1..1e991d7bca0b 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -627,6 +627,13 @@ static int gswip_setup(struct dsa_switch *ds)
 	/* Configure the MDIO Clock 2.5 MHz */
 	gswip_mdio_mask(priv, 0xff, 0x09, GSWIP_MDIO_MDC_CFG1);
 
+	/* bring up the mdio bus */
+	err = gswip_mdio(priv);
+	if (err) {
+		dev_err(priv->dev, "mdio bus setup failed\n");
+		return err;
+	}
+
 	/* Disable the xMII interface and clear it's isolation bit */
 	for (i = 0; i < priv->hw_info->max_ports; i++)
 		gswip_mii_mask_cfg(priv,
@@ -1973,13 +1980,6 @@ static int gswip_probe(struct platform_device *pdev)
 					     "gphy fw probe failed\n");
 	}
 
-	/* bring up the mdio bus */
-	err = gswip_mdio(priv);
-	if (err) {
-		dev_err_probe(dev, err, "mdio probe failed\n");
-		goto gphy_fw_remove;
-	}
-
 	err = dsa_register_switch(priv->ds);
 	if (err) {
 		dev_err_probe(dev, err, "dsa switch registration failed\n");
-- 
2.51.0

