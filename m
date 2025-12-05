Return-Path: <netdev+bounces-243682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EC9CA5D69
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 02:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 642B13179BD8
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 01:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5698A224AEF;
	Fri,  5 Dec 2025 01:32:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180E7398FBA;
	Fri,  5 Dec 2025 01:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764898364; cv=none; b=OvNuGmxGiX9xRJOKd0F6TSZfKqGXeqCb8ctFBUS9c3FCRhBgApdRMzhYHDQI5szBua5XdJeXWrMCniqIHqg4eMsHcBtQRfvdzZR1mcagecwzSyyROrtjUAh73u9yuxSU2voRAL54SJJS5yF28j8SyoaysLTBlRSirI9/65AjLGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764898364; c=relaxed/simple;
	bh=b4qQS5AcTfKL3/lKe6YUcIL5CvPrU7U5Es1YgOBf3XU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uCWsPhaw/PJhH7EB1jS44rAIAsRV29Fb7wIuBBR4bQ1BlmUGqWjgD6EjNrsFntjnjkL+4fa8nLeVUy1XbaTbJ+3UjH4+6S0Hfz4Fg+29JKzsQvlF5zIatlldcUET07U9CBxZ54VyIjmvftKN1oky3clR18tAw05NpPmRWg7khms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vRKgK-000000002S2-0swd;
	Fri, 05 Dec 2025 01:32:24 +0000
Date: Fri, 5 Dec 2025 01:32:20 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net] net: dsa: mxl-gsw1xx: manually clear RANEG bit
Message-ID: <ab836f5d36e3f00cd8e2fb3e647b7204b5b6c990.1764898074.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Despite being documented as self-clearing, the RANEG bit sometimes
remains set, preventing auto-negotiation from happening.

Manually clear the RANEG bit after 10ms as advised by MaxLinear, using
delayed_work emulating the asynchronous self-clearing behavior.

Fixes: 22335939ec90 ("net: dsa: add driver for MaxLinear GSW1xx switch family")
Reported-by: Rasmus Villemoes <ravi@prevas.dk>
Suggested-by: "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index cf33a16fd183b..91304d3c1ca9b 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -11,10 +11,12 @@
 
 #include <linux/bits.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_mdio.h>
 #include <linux/regmap.h>
+#include <linux/workqueue.h>
 #include <net/dsa.h>
 
 #include "lantiq_gswip.h"
@@ -29,6 +31,7 @@ struct gsw1xx_priv {
 	struct			regmap *clk;
 	struct			regmap *shell;
 	struct			phylink_pcs pcs;
+	struct delayed_work	clear_raneg;
 	phy_interface_t		tbi_interface;
 	struct gswip_priv	gswip;
 };
@@ -145,6 +148,8 @@ static void gsw1xx_pcs_disable(struct phylink_pcs *pcs)
 {
 	struct gsw1xx_priv *priv = pcs_to_gsw1xx(pcs);
 
+	cancel_delayed_work_sync(&priv->clear_raneg);
+
 	/* Assert SGMII shell reset */
 	regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
 			GSW1XX_RST_REQ_SGMII_SHELL);
@@ -428,12 +433,27 @@ static int gsw1xx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	return 0;
 }
 
+static void gsw1xx_pcs_clear_raneg(struct work_struct *work)
+{
+	struct gsw1xx_priv *priv =
+		container_of(work, struct gsw1xx_priv, clear_raneg.work);
+
+	regmap_clear_bits(priv->sgmii, GSW1XX_SGMII_TBI_ANEGCTL,
+			  GSW1XX_SGMII_TBI_ANEGCTL_RANEG);
+}
+
 static void gsw1xx_pcs_an_restart(struct phylink_pcs *pcs)
 {
 	struct gsw1xx_priv *priv = pcs_to_gsw1xx(pcs);
 
 	regmap_set_bits(priv->sgmii, GSW1XX_SGMII_TBI_ANEGCTL,
 			GSW1XX_SGMII_TBI_ANEGCTL_RANEG);
+
+	/* despite being documented as self-clearing, the RANEG bit
+	 * sometimes remains set, preventing auto-negotiation from happening.
+	 * MaxLinear advises to manually clear the bit after 10ms.
+	 */
+	schedule_delayed_work(&priv->clear_raneg, msecs_to_jiffies(10));
 }
 
 static void gsw1xx_pcs_link_up(struct phylink_pcs *pcs,
@@ -636,6 +656,8 @@ static int gsw1xx_probe(struct mdio_device *mdiodev)
 	if (ret)
 		return ret;
 
+	INIT_DELAYED_WORK(&priv->clear_raneg, gsw1xx_pcs_clear_raneg);
+
 	ret = gswip_probe_common(&priv->gswip, version);
 	if (ret)
 		return ret;
-- 
2.52.0

