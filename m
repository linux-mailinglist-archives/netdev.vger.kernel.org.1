Return-Path: <netdev+bounces-217086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AF0B3753B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFCC1B68B73
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 23:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155C22F6588;
	Tue, 26 Aug 2025 23:06:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DB02D8DA9;
	Tue, 26 Aug 2025 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249605; cv=none; b=tWdXtbrTOp3XhJjgCw5LPC7CFUZ5Vum0mtC0o8apawFLqft4EsVq78zj+GpnwVpyGno5fJisXEJ99RU1s0YXBCnqZAAkgVXlq7NlrcXkz2GUg2Zjr62UVab9Ph+hRMW2QjeD0vKEOBlCcYz1WawdJmVdVQ6jT+FNy5lFbX9LZgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249605; c=relaxed/simple;
	bh=/72rdYd6xm4poZPJOLwHCbqWmzFsBPRRRk/gZLulOiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONPg4QZWNt3P0lwIDW0icgV+wg2KdDxgYL0yPUI8ZLhj0O2NpJZ+K1bzQi9DPAHviCm3edR4LQ5z3ZvHQIFSgl8+sYHgLvI4C8VaFXRejq/M8U6co0ZOf5SgVVjTGAIwBms0GrGmklUA+vwn2Seydz8pMx2kKjyjshxwisuSkl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1ur2kQ-000000001u2-1vMX;
	Tue, 26 Aug 2025 23:06:38 +0000
Date: Wed, 27 Aug 2025 00:06:35 +0100
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
Subject: [PATCH net-next v2 6/6] net: dsa: lantiq_gswip: move MDIO bus
 registration to .setup()
Message-ID: <fbe86601753d6c43138133842787a7ece03dd09c.1756228750.git.daniel@makrotopia.org>
References: <cover.1756228750.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756228750.git.daniel@makrotopia.org>

Instead of registering the switch MDIO bus in the probe() function, move
the call to gswip_mdio() into the .setup() DSA switch op, so it can be
reused independently of the probe() function.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v2: no changes

 drivers/net/dsa/lantiq/lantiq_gswip.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 9fd5e5938384..a6a76db7ef52 100644
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

