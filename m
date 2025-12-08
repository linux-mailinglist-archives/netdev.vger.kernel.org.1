Return-Path: <netdev+bounces-243968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9E5CABB85
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 02:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52A10300797A
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 01:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3339D1F12F8;
	Mon,  8 Dec 2025 01:27:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990372634;
	Mon,  8 Dec 2025 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765157250; cv=none; b=sysLQ0raGY8bugwPYAdhv/6be8W20k33+eAm2beC6JdLDDRiH/ZWltutfQ3+8wekLygqF2unlL5PQvRuMCcsCm+Sp28N66FC4ag/lFr8V1qDRjyT6pu44UBl2EfrxRvyNFMu+GSEtcUpRv7z3ape3qgeVu2EBwuF0/0ROD0929g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765157250; c=relaxed/simple;
	bh=Evn0j5l8D0gbamoLWseYGaDF2z2vwDBi66LJUJJZfIk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tsJRsBl0axmnOkNZy4ozYhrEmVcQAvMXWkV/3UhD443uhZvaUeeA0egIBoLqRme9JI7BiRuDlL+rzZqlZtm+wP3cYsR06CXqXKFratH4X+VD7tCfAHZvb3Omip0xUb1odwRPgbBcZSXCLbdeCElH8Pg9S56rhBKdi/WEfuvs6po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vSQ1t-0000000089H-3TqY;
	Mon, 08 Dec 2025 01:27:09 +0000
Date: Mon, 8 Dec 2025 01:27:04 +0000
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
Subject: [PATCH net v3] net: dsa: mxl-gsw1xx: manually clear RANEG bit
Message-ID: <c28947688b5fc90abe1a5ead6cfd78e128027447.1765156305.git.daniel@makrotopia.org>
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

Manually clear the RANEG bit after 10ms as advised by MaxLinear.
In order to not hold RTNL during the 10ms of waiting schedule
delayed work to take care of clearing the bit asynchronously, which
is similar to the self-clearing behavior.

Fixes: 22335939ec90 ("net: dsa: add driver for MaxLinear GSW1xx switch family")
Reported-by: Rasmus Villemoes <ravi@prevas.dk>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3:
 * fix wrong parameter name in call of cancel_delayed_work_sync

v2:
 * cancel pending work before setting RANEG bit
 * cancel pending work on remove and shutdown
 * document that GSW1XX_RST_REQ_SGMII_SHELL also clears RANEG bit
 * improve commit message

 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 34 ++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index cf33a16fd183b..7d332affe9ec8 100644
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
@@ -145,7 +148,9 @@ static void gsw1xx_pcs_disable(struct phylink_pcs *pcs)
 {
 	struct gsw1xx_priv *priv = pcs_to_gsw1xx(pcs);
 
-	/* Assert SGMII shell reset */
+	cancel_delayed_work_sync(&priv->clear_raneg);
+
+	/* Assert SGMII shell reset (will also clear RANEG bit) */
 	regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
 			GSW1XX_RST_REQ_SGMII_SHELL);
 
@@ -428,12 +433,29 @@ static int gsw1xx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
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
 
+	cancel_delayed_work_sync(&priv->clear_raneg);
+
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
@@ -636,6 +658,8 @@ static int gsw1xx_probe(struct mdio_device *mdiodev)
 	if (ret)
 		return ret;
 
+	INIT_DELAYED_WORK(&priv->clear_raneg, gsw1xx_pcs_clear_raneg);
+
 	ret = gswip_probe_common(&priv->gswip, version);
 	if (ret)
 		return ret;
@@ -648,10 +672,14 @@ static int gsw1xx_probe(struct mdio_device *mdiodev)
 static void gsw1xx_remove(struct mdio_device *mdiodev)
 {
 	struct gswip_priv *priv = dev_get_drvdata(&mdiodev->dev);
+	struct gsw1xx_priv *gsw1xx_priv;
 
 	if (!priv)
 		return;
 
+	gsw1xx_priv = container_of(priv, struct gsw1xx_priv, gswip);
+	cancel_delayed_work_sync(&gsw1xx_priv->clear_raneg);
+
 	gswip_disable_switch(priv);
 
 	dsa_unregister_switch(priv->ds);
@@ -660,10 +688,14 @@ static void gsw1xx_remove(struct mdio_device *mdiodev)
 static void gsw1xx_shutdown(struct mdio_device *mdiodev)
 {
 	struct gswip_priv *priv = dev_get_drvdata(&mdiodev->dev);
+	struct gsw1xx_priv *gsw1xx_priv;
 
 	if (!priv)
 		return;
 
+	gsw1xx_priv = container_of(priv, struct gsw1xx_priv, gswip);
+	cancel_delayed_work_sync(&gsw1xx_priv->clear_raneg);
+
 	dev_set_drvdata(&mdiodev->dev, NULL);
 
 	gswip_disable_switch(priv);
-- 
2.52.0

