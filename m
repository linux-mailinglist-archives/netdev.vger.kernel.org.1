Return-Path: <netdev+bounces-216726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9349B3500D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755763BC652
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA5F78F20;
	Tue, 26 Aug 2025 00:13:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9924113957E;
	Tue, 26 Aug 2025 00:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167181; cv=none; b=Sq8WrVkZJzayrv7E0tnMdHzgevuZhblkol43rs7DnHOZgAZpJWGExop7ZYVLiSkCcCwUjIgjF4FUykqbXcQiCT5Mj4OIto5vQmqC7RdfY0c+LXPgcIrmev7ccuaVIK4I1PWBmfKn1MWJNwkej++F0It5TQvFwcVDlTd80PWKVR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167181; c=relaxed/simple;
	bh=GWpRGVfRYZ0o9ai6+LSW4CJ8TZy/KweJErFZ2YA+nvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPT7+7zDHYLA8S14BPs7hvOMBRUR6Ie/BbR0/BQ9j4kNRw26k2hr1aEcxg+4DLkEeZ/lGMqhTosCUjzjpTDOLRjcVylpbEkKiVvPILLBYvh6IRNA42a6m4DWcicPcm+oIZcrF+hPWRgxhAWM6pVFKkwKIWJEOCFqHYKwiYOqWpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uqhJ0-000000005kX-12IJ;
	Tue, 26 Aug 2025 00:12:54 +0000
Date: Tue, 26 Aug 2025 01:12:51 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Subject: [PATCH net-next 2/6] net: dsa: lantiq_gswip: support model-specific
 mac_select_pcs()
Message-ID: <7576c237814016ee5e18572b2788f955071a922c.1756163848.git.daniel@makrotopia.org>
References: <cover.1756163848.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756163848.git.daniel@makrotopia.org>

Call mac_select_pcs() function if provided in struct gswip_hwinfo.
The MaxLinear GSW1xx series got one port wired to a SerDes PCS and
PHY which can do 1000Base-X, 2500Base-X and SGMII. Support for the
SerDes port will be provided using phylink_pcs, so provide a
convenient way for mac_select_pcs() to differ based on the hardware
model.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.c | 21 +++++++++++++++++----
 drivers/net/dsa/lantiq_gswip.h |  3 +++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 67919c3935e4..4822812bba27 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1592,10 +1592,23 @@ static int gswip_get_sset_count(struct dsa_switch *ds, int port, int sset)
 	return ARRAY_SIZE(gswip_rmon_cnt);
 }
 
-static const struct phylink_mac_ops gswip_phylink_mac_ops = {
-	.mac_config	= gswip_phylink_mac_config,
-	.mac_link_down	= gswip_phylink_mac_link_down,
-	.mac_link_up	= gswip_phylink_mac_link_up,
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
+const struct phylink_mac_ops gswip_phylink_mac_ops = {
+	.mac_config		= gswip_phylink_mac_config,
+	.mac_link_down		= gswip_phylink_mac_link_down,
+	.mac_link_up		= gswip_phylink_mac_link_up,
+	.mac_select_pcs		= gswip_phylink_mac_select_pcs,
 };
 
 static const struct dsa_switch_ops gswip_switch_ops = {
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index 620c2d560cbe..19bbe6fddf04 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
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
2.50.1

