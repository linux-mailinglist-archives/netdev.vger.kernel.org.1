Return-Path: <netdev+bounces-218276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A37EB3BBE4
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54D1587585
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 13:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13ED31A553;
	Fri, 29 Aug 2025 13:02:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F6519FA93;
	Fri, 29 Aug 2025 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756472545; cv=none; b=JP/iayB3/8QIrp663FXlWYjQMS0ZNHEEXutw7sorZKumuyAd2K6A0BNd/XdrJW69I3Z1fwmTqyFpRLMVrnUAZIsAmM6aaCvVQIv4KdJLoaN+dmGihqo892TYDnD16/u4LV0v70J0AIDYJK5feNJYi0rvlcitEXJbur26ApCqRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756472545; c=relaxed/simple;
	bh=vGf4U4fwROKh8gE/BS6tMtfVSyLKjzorpct0PJCnf58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/ahd9njGIB05I1DVXWDyupeM5Ixt1Evb90IQuuAXlQB176+fGD8BCuRBjCuk9toGJApU64HDlFaUOzwl3l2QG1U2wph7+JV6n6vo2u+6gTtFgItwJpugY069HwhnsUw2GxQT5JCvbveDB4ht34hLwSdvHXJcn4r8341xasuTiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1urykF-000000002AS-25eb;
	Fri, 29 Aug 2025 13:02:19 +0000
Date: Fri, 29 Aug 2025 14:02:16 +0100
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
Subject: [PATCH v3 4/6] net: dsa: lantiq_gswip: support offset of MII
 registers
Message-ID: <ece46fdecbfb75ade8400f96f8649d04b4f1a2f7.1756472076.git.daniel@makrotopia.org>
References: <cover.1756472076.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756472076.git.daniel@makrotopia.org>

The MaxLinear GSW1xx family got a single (R)(G)MII port at index 5 but
the registers MII_PCDU and MII_CFG are those of port 0.
Allow applying an offset for the port index to access those registers.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Hauke Mehrtens <hauke@hauke-m.de>
---
v3: no changes
v2: no changes

 drivers/net/dsa/lantiq/lantiq_gswip.c | 14 ++++++++++++--
 drivers/net/dsa/lantiq/lantiq_gswip.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 3e2a54569828..57441afa12e4 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -183,21 +183,29 @@ static void gswip_mii_mask(struct gswip_priv *priv, u32 clear, u32 set,
 static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
 			       int port)
 {
+	int reg_port;
+
 	/* MII_CFG register only exists for MII ports */
 	if (!(priv->hw_info->mii_ports & BIT(port)))
 		return;
 
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
 	/* MII_PCDU register only exists for MII ports */
 	if (!(priv->hw_info->mii_ports & BIT(port)))
 		return;
 
-	switch (port) {
+	reg_port = port + priv->hw_info->mii_port_reg_offset;
+
+	switch (reg_port) {
 	case 0:
 		gswip_mii_mask(priv, clear, set, GSWIP_MII_PCDU0);
 		break;
@@ -2027,6 +2035,7 @@ static const struct gswip_hw_info gswip_xrx200 = {
 	.max_ports = 7,
 	.allowed_cpu_ports = BIT(6),
 	.mii_ports = BIT(0) | BIT(1) | BIT(5),
+	.mii_port_reg_offset = 0;
 	.phylink_get_caps = gswip_xrx200_phylink_get_caps,
 	.pce_microcode = &gswip_pce_microcode,
 	.pce_microcode_size = ARRAY_SIZE(gswip_pce_microcode),
@@ -2037,6 +2046,7 @@ static const struct gswip_hw_info gswip_xrx300 = {
 	.max_ports = 7,
 	.allowed_cpu_ports = BIT(6),
 	.mii_ports = BIT(0) | BIT(5),
+	.mii_port_reg_offset = 0;
 	.phylink_get_caps = gswip_xrx300_phylink_get_caps,
 	.pce_microcode = &gswip_pce_microcode,
 	.pce_microcode_size = ARRAY_SIZE(gswip_pce_microcode),
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index 19bbe6fddf04..2df9c8e8cfd0 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
@@ -233,6 +233,7 @@ struct gswip_hw_info {
 	int max_ports;
 	unsigned int allowed_cpu_ports;
 	unsigned int mii_ports;
+	int mii_port_reg_offset;
 	const struct gswip_pce_microcode (*pce_microcode)[];
 	size_t pce_microcode_size;
 	enum dsa_tag_protocol tag_protocol;
-- 
2.51.0

