Return-Path: <netdev+bounces-214822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC625B2B63E
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 03:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514525E6345
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 01:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EADF1FFC46;
	Tue, 19 Aug 2025 01:33:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D7487BE;
	Tue, 19 Aug 2025 01:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567205; cv=none; b=uFB1Jz1CLe76MviQB1F41Oyrb2yF25Ge5zO9an2HruRgqz23DflhW50GB2YhPDnNTlxqUs6BeegORovFaVjVDvnB5AQQTVjTEvv43OEeDd9GoWW8cfleNRlRc92LV2cWO036jWaS2xsE5Wjr7agtubZ3Ua1j+9qUOMEH9BLqVyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567205; c=relaxed/simple;
	bh=GCgVyesU5QUOMAja2djWXvtw6Nq4Uh461wVmzD2dTJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnWdO9xbfl5ctMOasksWhFwYRLCnCVpIUiq+itIxMBuQ2sitSLdGuTSv9NUkZ6cFnyQ2GRATveL7xpQdUyGLSs3ZNpgphcUl1Tx1mRMmVqDjIV2XeGJvKqN9zFRONvmWawxddoznYYkrYGbSSJACYOwhKrMppomCUzkosPvpCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uoBDz-000000000Bj-1Owd;
	Tue, 19 Aug 2025 01:33:19 +0000
Date: Tue, 19 Aug 2025 02:33:15 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
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
Subject: [PATCH net-next v2 4/8] net: dsa: lantiq_gswip: introduce bitmap for
 MII ports
Message-ID: <c278b21957e9ff55e3c2f0726902eb77601e99d8.1755564606.git.daniel@makrotopia.org>
References: <cover.1755564606.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755564606.git.daniel@makrotopia.org>

Instead of relying on hard-coded numbers for MII ports, introduce
a bitmap for MII ports.
This is done in order to prepare for supporting MaxLinear GSW1xx ICs
which got a different layout of ports.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2:
 - move comment before 'if' statement
 - don't add unused sgmii_ports and phy_ports
 - correct bitmask for XRX200 and XRX300 (they were swapped in v1/RFC)

 drivers/net/dsa/lantiq_gswip.c | 14 +++++++++++---
 drivers/net/dsa/lantiq_gswip.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index b1b250fc4f61..65e6b77b09db 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -183,14 +183,20 @@ static void gswip_mii_mask(struct gswip_priv *priv, u32 clear, u32 set,
 static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
 			       int port)
 {
-	/* There's no MII_CFG register for the CPU port */
-	if (!dsa_is_cpu_port(priv->ds, port))
-		gswip_mii_mask(priv, clear, set, GSWIP_MII_CFGp(port));
+	/* MII_CFG register only exists for MII ports */
+	if (!(priv->hw_info->mii_ports & BIT(port)))
+		return;
+
+	gswip_mii_mask(priv, clear, set, GSWIP_MII_CFGp(port));
 }
 
 static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 clear, u32 set,
 				int port)
 {
+	/* MII_PCDU register only exists for MII ports */
+	if (!(priv->hw_info->mii_ports & BIT(port)))
+		return;
+
 	switch (port) {
 	case 0:
 		gswip_mii_mask(priv, clear, set, GSWIP_MII_PCDU0);
@@ -1993,12 +1999,14 @@ static void gswip_shutdown(struct platform_device *pdev)
 static const struct gswip_hw_info gswip_xrx200 = {
 	.max_ports = 7,
 	.allowed_cpu_ports = BIT(6),
+	.mii_ports = BIT(0) | BIT(1) | BIT(5),
 	.phylink_get_caps = gswip_xrx200_phylink_get_caps,
 };
 
 static const struct gswip_hw_info gswip_xrx300 = {
 	.max_ports = 7,
 	.allowed_cpu_ports = BIT(6),
+	.mii_ports = BIT(0) | BIT(5),
 	.phylink_get_caps = gswip_xrx300_phylink_get_caps,
 };
 
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index c90ddf89d0d7..7916bcac24cf 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -217,6 +217,7 @@
 struct gswip_hw_info {
 	int max_ports;
 	unsigned int allowed_cpu_ports;
+	unsigned int mii_ports;
 	void (*phylink_get_caps)(struct dsa_switch *ds, int port,
 				 struct phylink_config *config);
 };
-- 
2.50.1

