Return-Path: <netdev+bounces-218446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6064B3C770
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FDF1BA2B83
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FA224DCF6;
	Sat, 30 Aug 2025 02:33:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E39B6A33B;
	Sat, 30 Aug 2025 02:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756521189; cv=none; b=XJtEtaTPqpv9qUozWEAFxQdNs9XoCOwh+2BnytfYQTK2EAwU2Om1+JNtgMYvH4UDwmHb5kukZ6R03QzfR7lq0XQsbOnbceElHBa453l6vxFYXiz8MF4lbzEjB9+Vd97nN1LZVQEwfgE/EZ5DErQkFR4oobX3HP0W26+vgi+hskE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756521189; c=relaxed/simple;
	bh=Aiix0wd3aN1HL1lzKifMGpHRS7aRk9w71FF05DOlACY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEtlLkGFN4FaRw9oALVaJOX1DRr4AQ0cmzkBSxjTl6CXg0Tgu12IhqfzzLYNG13+otNzcWnudhe5iw1/Nbi0PDZM8Lq7KjCcb8UPOI2uOKCmKmFjkIl0+XXGBiq1+MeDxwOTfUPtU/WVp24Gxzl7hd/no2r5n8oa1jqkWHaEF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1usBOp-000000005va-2UPJ;
	Sat, 30 Aug 2025 02:33:03 +0000
Date: Sat, 30 Aug 2025 03:33:00 +0100
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
Subject: [PATCH net-next v4 2/6] net: dsa: lantiq_gswip: support
 model-specific mac_select_pcs()
Message-ID: <7668666aa51e43e7f2a6cbcf36eb5a0a3020998f.1756520811.git.daniel@makrotopia.org>
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

Call mac_select_pcs() function if provided in struct gswip_hwinfo.
The MaxLinear GSW1xx series got one port wired to a SerDes PCS and
PHY which can do 1000Base-X, 2500Base-X and SGMII. Support for the
SerDes port will be provided using phylink_pcs, so provide a
convenient way for mac_select_pcs() to differ based on the hardware
model.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Hauke Mehrtens <hauke@hauke-m.de>
---
v3: no changes
v2: fix accidental change from 'static const struct' to 'const struct'
    reported by the kbuild bot

 drivers/net/dsa/lantiq/lantiq_gswip.c | 19 ++++++++++++++++---
 drivers/net/dsa/lantiq/lantiq_gswip.h |  3 +++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 67919c3935e4..acb6996356e9 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -1592,10 +1592,23 @@ static int gswip_get_sset_count(struct dsa_switch *ds, int port, int sset)
 	return ARRAY_SIZE(gswip_rmon_cnt);
 }
 
+static struct phylink_pcs *gswip_phylink_mac_select_pcs(struct phylink_config *config,
+							phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct gswip_priv *priv = dp->ds->priv;
+
+	if (priv->hw_info->mac_select_pcs)
+		return priv->hw_info->mac_select_pcs(config, interface);
+
+	return NULL;
+}
+
 static const struct phylink_mac_ops gswip_phylink_mac_ops = {
-	.mac_config	= gswip_phylink_mac_config,
-	.mac_link_down	= gswip_phylink_mac_link_down,
-	.mac_link_up	= gswip_phylink_mac_link_up,
+	.mac_config		= gswip_phylink_mac_config,
+	.mac_link_down		= gswip_phylink_mac_link_down,
+	.mac_link_up		= gswip_phylink_mac_link_up,
+	.mac_select_pcs		= gswip_phylink_mac_select_pcs,
 };
 
 static const struct dsa_switch_ops gswip_switch_ops = {
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index 620c2d560cbe..19bbe6fddf04 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
@@ -4,6 +4,7 @@
 
 #include <linux/clk.h>
 #include <linux/mutex.h>
+#include <linux/phylink.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
@@ -237,6 +238,8 @@ struct gswip_hw_info {
 	enum dsa_tag_protocol tag_protocol;
 	void (*phylink_get_caps)(struct dsa_switch *ds, int port,
 				 struct phylink_config *config);
+	struct phylink_pcs *(*mac_select_pcs)(struct phylink_config *config,
+					      phy_interface_t interface);
 };
 
 struct gswip_gphy_fw {
-- 
2.51.0

