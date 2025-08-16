Return-Path: <netdev+bounces-214338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995AAB29068
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 21:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C85AE1846
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 19:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2DA21D3C9;
	Sat, 16 Aug 2025 19:54:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776CE220F25;
	Sat, 16 Aug 2025 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755374091; cv=none; b=XU61j6Sbqt5rlxXD0chnZDqLsQE5UeeqylTf62xYBmfEE6O7hBJHxAXw7c11rJ+ncfVcQvIZwsUtW+SziH8uJNwWQWH/IEVOERNYs8Jvzw6N/JlQzRTwpuUW/IvamuwNXz1ZPg00ZlWqMiX19yd5HFQyZMS8bychUk9IbbR7rDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755374091; c=relaxed/simple;
	bh=XAaAuXO1REe/ZY9t32DM/xHXAcbL/SJxE3f13oRbrho=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VV6DOYLzj4/Es+aF8QZx+bExU5X1mwnhukhGTviTTQSowkrlho5yMLHqiaaX6edI311FZOJBYqyZBPSAZrVWFhkWVNTMNkkRwMnfhI4PaUzB363kN/YTyaaksCKfllOHx2hQyb8uzOePVq+v+m2IkUR2a7xgu34Eqgu40hxnJq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1unMzF-0000000073s-066y;
	Sat, 16 Aug 2025 19:54:45 +0000
Date: Sat, 16 Aug 2025 20:54:41 +0100
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
Subject: [PATCH RFC net-next 13/23] net: dsa: lantiq_gswip: support
 model-specific mac_select_pcs()
Message-ID: <aKDiAb0tCBJw7N7K@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Implement calling mac_select_pcs() function if provided in
struct gswip_hwinfo.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.c | 13 +++++++++++++
 drivers/net/dsa/lantiq_gswip.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 5a5e85b1b32f..671f7b92b4aa 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1675,12 +1675,25 @@ static bool gswip_support_eee(struct dsa_switch *ds, int port)
 	return false;
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
 const struct phylink_mac_ops gswip_phylink_mac_ops = {
 	.mac_config		= gswip_phylink_mac_config,
 	.mac_link_down		= gswip_phylink_mac_link_down,
 	.mac_link_up		= gswip_phylink_mac_link_up,
 	.mac_disable_tx_lpi	= gswip_phylink_mac_disable_tx_lpi,
 	.mac_enable_tx_lpi	= gswip_phylink_mac_enable_tx_lpi,
+	.mac_select_pcs		= gswip_phylink_mac_select_pcs,
 };
 
 static const struct dsa_switch_ops gswip_switch_ops = {
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index 00a786d374b1..24f6a94dd971 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -5,6 +5,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/mutex.h>
+#include <linux/phylink.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
@@ -246,6 +247,8 @@ struct gswip_hw_info {
 	enum dsa_tag_protocol tag_protocol;
 	void (*phylink_get_caps)(struct dsa_switch *ds, int port,
 				 struct phylink_config *config);
+	struct phylink_pcs *(*mac_select_pcs)(struct phylink_config *config,
+					      phy_interface_t interface);
 };
 
 struct gswip_gphy_fw {
-- 
2.50.1

