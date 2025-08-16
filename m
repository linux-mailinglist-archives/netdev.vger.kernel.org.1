Return-Path: <netdev+bounces-214339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB64DB29063
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 21:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 682574E2C3E
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 19:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001CF21B9CF;
	Sat, 16 Aug 2025 19:55:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AAD221554;
	Sat, 16 Aug 2025 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755374101; cv=none; b=cl9aI9zeEAp7yTJpLpVB9lkD/YJPZ9rmquBIu4U1kT+kIZnHyt5FCw7S7lBAkJoB4mXoSEdwZ2h917XFaXd1hWjPS6ijRZ+fDbvFGz22WrHmkMQZ+hatSI2RpNk5zDpH2cEQAyZaTWbM/A5xIODIRZkT1aQkJmvf+8B1x06zCSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755374101; c=relaxed/simple;
	bh=PTQVBxAp/KLwUAwj0bPtu2F8o9oXGcJTGTEKp9TrWT0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=spO1mTMlwOluJgI0yau8wH1QehWrVVSkWJQK9Qhj7ufv4S2A541UoyRji6sxuJ3Yzmm0bJA4wVf85CjwRxI6z1DV5U2WIL6eygZzZtBsnjVjxzwWTj6JyWOdguFxlvQpGjQnkltbmGHB3KOfsSLoxW66rouIT+9AQyS07v9IvTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1unMzP-0000000074A-0Nvu;
	Sat, 16 Aug 2025 19:54:55 +0000
Date: Sat, 16 Aug 2025 20:54:51 +0100
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
Subject: [PATCH RFC net-next 14/23] net: dsa: lantiq_gswip: support GSW1xx
 offset of MII register
Message-ID: <aKDiC4W9krOyA9b_@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The MaxLinear GSW1xx family got a single (R)(G)MII port which is port
number 5, but the MII_PCDU and MII_CFG are those of port 0.
Allow applying an offset for the port index to access those registers.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.c | 15 ++++++++++++---
 drivers/net/dsa/lantiq_gswip.h |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 671f7b92b4aa..e67950c69978 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -185,20 +185,29 @@ static void gswip_mii_mask(struct gswip_priv *priv, u32 clear, u32 set,
 static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
 			       int port)
 {
+	int reg_port;
+
+	/* MII_CFG register only exists for MII ports */
 	if (!(priv->hw_info->mii_ports & BIT(port)))
 		return;
 
-	/* MII_CFG register only exists for MII ports */
-	gswip_mii_mask(priv, clear, set, GSWIP_MII_CFGp(port));
+	reg_port = port + priv->hw_info->mii_port_reg_offset;
+
+	gswip_mii_mask(priv, clear, set, GSWIP_MII_CFGp(reg_port));
 }
 
 static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 clear, u32 set,
 				int port)
 {
+	int reg_port;
+
+	/* MII_PCDU register only exists for MII ports */
 	if (!(priv->hw_info->mii_ports & BIT(port)))
 		return;
 
-	switch (port) {
+	reg_port = port + priv->hw_info->mii_port_reg_offset;
+
+	switch (reg_port) {
 	case 0:
 		gswip_mii_mask(priv, clear, set, GSWIP_MII_PCDU0);
 		break;
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index 24f6a94dd971..5bc47c329620 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -242,6 +242,7 @@ struct gswip_hw_info {
 	unsigned int phy_ports;
 	unsigned int mii_ports;
 	unsigned int sgmii_ports;
+	int mii_port_reg_offset;
 	const struct gswip_pce_microcode (*pce_microcode)[];
 	size_t pce_microcode_size;
 	enum dsa_tag_protocol tag_protocol;
-- 
2.50.1

