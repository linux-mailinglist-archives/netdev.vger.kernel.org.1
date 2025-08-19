Return-Path: <netdev+bounces-214823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31352B2B641
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 03:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3541D527DA0
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 01:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF83B1FFC59;
	Tue, 19 Aug 2025 01:33:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E06C18FC92;
	Tue, 19 Aug 2025 01:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567215; cv=none; b=FPMP71XO209sJdD6qtMMfvKk2y0QOkIsttxPQIBDaMVYC571xRMBT3y61l+prne2Pyx4NSCvgUy+hulQFWJTFy3YCeB1Xxk5m58iavNunf3oUWkTzwQV5NZq8mopZuOhFJ/11mvw5x5ATHVteSCVZMmlslJ3qCYap90oSnE6TsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567215; c=relaxed/simple;
	bh=YG8HnBlCjqbKhkxOuYHevP12joddXbtU30Q6b0KGg7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sao9yFDmUKyU9n9Nsl0+angnK4CmZIFjuuXAwzKdFKb4pmogXYMJGca+dclJLdJcKjwYDKL++PMoGOTDygeUJJE3d5FmNo1GMj06li9g4azX6HZxd7q7sbNADbnmHXDCdieOOFQ9pdnflb7fnjTreYH9jzFxARlnkVUb2kwwr10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uoBE9-000000000Bx-0uIk;
	Tue, 19 Aug 2025 01:33:29 +0000
Date: Tue, 19 Aug 2025 02:33:25 +0100
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
Subject: [PATCH net-next v2 5/8] net: dsa: lantiq_gswip: load model-specific
 microcode
Message-ID: <7f9f0eed8dbe7f40a2984b78c8a5a9a79d478e15.1755564606.git.daniel@makrotopia.org>
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

Load microcode as specified in struct hw_info instead of relying on
a single array of instructions. This is done in preparation to allow
loading different microcode for the MaxLinear GSW1xx family.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.c | 14 +++++++++-----
 drivers/net/dsa/lantiq_gswip.h |  9 +++++++++
 drivers/net/dsa/lantiq_pce.h   |  9 ++-------
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 65e6b77b09db..43f739db997d 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -500,15 +500,15 @@ static int gswip_pce_load_microcode(struct gswip_priv *priv)
 			  GSWIP_PCE_TBL_CTRL_OPMOD_ADWR, GSWIP_PCE_TBL_CTRL);
 	gswip_switch_w(priv, 0, GSWIP_PCE_TBL_MASK);
 
-	for (i = 0; i < ARRAY_SIZE(gswip_pce_microcode); i++) {
+	for (i = 0; i < priv->hw_info->pce_microcode_size; i++) {
 		gswip_switch_w(priv, i, GSWIP_PCE_TBL_ADDR);
-		gswip_switch_w(priv, gswip_pce_microcode[i].val_0,
+		gswip_switch_w(priv, (*priv->hw_info->pce_microcode)[i].val_0,
 			       GSWIP_PCE_TBL_VAL(0));
-		gswip_switch_w(priv, gswip_pce_microcode[i].val_1,
+		gswip_switch_w(priv, (*priv->hw_info->pce_microcode)[i].val_1,
 			       GSWIP_PCE_TBL_VAL(1));
-		gswip_switch_w(priv, gswip_pce_microcode[i].val_2,
+		gswip_switch_w(priv, (*priv->hw_info->pce_microcode)[i].val_2,
 			       GSWIP_PCE_TBL_VAL(2));
-		gswip_switch_w(priv, gswip_pce_microcode[i].val_3,
+		gswip_switch_w(priv, (*priv->hw_info->pce_microcode)[i].val_3,
 			       GSWIP_PCE_TBL_VAL(3));
 
 		/* start the table access: */
@@ -2001,6 +2001,8 @@ static const struct gswip_hw_info gswip_xrx200 = {
 	.allowed_cpu_ports = BIT(6),
 	.mii_ports = BIT(0) | BIT(1) | BIT(5),
 	.phylink_get_caps = gswip_xrx200_phylink_get_caps,
+	.pce_microcode = &gswip_pce_microcode,
+	.pce_microcode_size = ARRAY_SIZE(gswip_pce_microcode),
 };
 
 static const struct gswip_hw_info gswip_xrx300 = {
@@ -2008,6 +2010,8 @@ static const struct gswip_hw_info gswip_xrx300 = {
 	.allowed_cpu_ports = BIT(6),
 	.mii_ports = BIT(0) | BIT(5),
 	.phylink_get_caps = gswip_xrx300_phylink_get_caps,
+	.pce_microcode = &gswip_pce_microcode,
+	.pce_microcode_size = ARRAY_SIZE(gswip_pce_microcode),
 };
 
 static const struct of_device_id gswip_of_match[] = {
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index 7916bcac24cf..46fca97e4d83 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -214,10 +214,19 @@
  */
 #define GSWIP_MAX_PACKET_LENGTH	2400
 
+struct gswip_pce_microcode {
+	u16 val_3;
+	u16 val_2;
+	u16 val_1;
+	u16 val_0;
+};
+
 struct gswip_hw_info {
 	int max_ports;
 	unsigned int allowed_cpu_ports;
 	unsigned int mii_ports;
+	const struct gswip_pce_microcode (*pce_microcode)[];
+	size_t pce_microcode_size;
 	void (*phylink_get_caps)(struct dsa_switch *ds, int port,
 				 struct phylink_config *config);
 };
diff --git a/drivers/net/dsa/lantiq_pce.h b/drivers/net/dsa/lantiq_pce.h
index e2be31f3672a..659f9a0638d9 100644
--- a/drivers/net/dsa/lantiq_pce.h
+++ b/drivers/net/dsa/lantiq_pce.h
@@ -7,6 +7,8 @@
  * Copyright (C) 2017 - 2018 Hauke Mehrtens <hauke@hauke-m.de>
  */
 
+#include "lantiq_gswip.h"
+
 enum {
 	OUT_MAC0 = 0,
 	OUT_MAC1,
@@ -74,13 +76,6 @@ enum {
 	FLAG_NO,	/*13*/
 };
 
-struct gswip_pce_microcode {
-	u16 val_3;
-	u16 val_2;
-	u16 val_1;
-	u16 val_0;
-};
-
 #define MC_ENTRY(val, msk, ns, out, len, type, flags, ipv4_len) \
 	{ val, msk, ((ns) << 10 | (out) << 4 | (len) >> 1),\
 		((len) & 1) << 15 | (type) << 13 | (flags) << 9 | (ipv4_len) << 8 }
-- 
2.50.1

