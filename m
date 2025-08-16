Return-Path: <netdev+bounces-214342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB1EB2906B
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 21:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88AF47BBB15
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 19:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5D72248AE;
	Sat, 16 Aug 2025 19:55:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543AA21FF4C;
	Sat, 16 Aug 2025 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755374157; cv=none; b=a4eHt15/limS4DHELxsICDZNlir+r4aKMDycujEwaxHYP0u7FNhpv8/9CGMD4p5JMvAh/sZj0msp5GcuiH031gvhw4j/NN6n0S/cibDQwb+Cu8BDZVpvzMK2s45dqITeXQA9P8zlLHsmSGxnrjSjq5Wvv/B6pBMaIZHgmx5MMJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755374157; c=relaxed/simple;
	bh=Hws288NWgQkqyR+xP4lhIR4f8nQKFQ0L7LQ5W/Twp8U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CxJAgycqkGhbDddiugilwYW/PLdyU9/E0z14wN4OsQaCERj6WTIwXPaXT38FcJYX1bSLNZKOYDd30XjKLNhWZIzEMfToCnnUk2tiz9ODwUzLnQtqA7uu4voNbeL3PIMayZKagzGWKOEsCHbh9So070K0vQju7+YO/CKzCbfwO4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1unN0H-0000000076R-43ce;
	Sat, 16 Aug 2025 19:55:50 +0000
Date: Sat, 16 Aug 2025 20:55:46 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
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
Subject: [PATCH RFC net-next 17/23] net: dsa: lantiq_gswip: move MDIO bus
 registration to .setup()
Message-ID: <aKDiQhvQHzj56XBX@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Instead of registering the switch MDIO bus in the probe() function, move
the call to gswip_mdio() into the .setup() DSA switch op, so it can be
reused independently of the probe() function.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 4641068d711b..6a263a0387d1 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -677,6 +677,13 @@ static int gswip_setup(struct dsa_switch *ds)
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
@@ -2093,13 +2100,6 @@ static int gswip_probe(struct platform_device *pdev)
 					     "gphy fw probe failed\n");
 	}
 
-	/* bring up the mdio bus */
-	err = gswip_mdio(priv);
-	if (err) {
-		dev_err_probe(dev, err, "mdio probe failed\n");
-		goto gphy_fw_remove;
-	}
-
 	err = gswip_allocate_vlans(priv);
 	if (err)
 		goto gphy_fw_remove;
-- 
2.50.1

