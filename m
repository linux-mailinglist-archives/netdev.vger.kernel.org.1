Return-Path: <netdev+bounces-243921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDCECAAEC2
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 23:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA0E330088E0
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 22:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C40A2264B0;
	Sat,  6 Dec 2025 22:37:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C5421255A;
	Sat,  6 Dec 2025 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765060643; cv=none; b=j+ZziMpuN/foA1Ahd1s9mLQP5uW4TrFsf76zdHmXosdr3RpRNCUZz10Kv9F92Euzvtumj/x2wXxEqbZuLFfj0MDtk8+mEQyEkCNks214HdyG2XKBZiwg8kTkHk3up8Arccs19DVU+f/c+VriEVSaA7rY7eyKPjrfZb90DMox0C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765060643; c=relaxed/simple;
	bh=xtvUGG1pLb4KRwlQsYtTdMvQLZWQdfVYD/O5TYfMvjo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qsQEYOp/peUAOiv1W67FCpxz5OuasxUrJQrbYFtSrw+c0Ll19hXQ5BHDf3DHdu9SPRRWAGU8MV7Pns35gMqS854uzTl5em6KfSrfoaHqPfhkuKg8Bt67ZID/j08WF7zD6iGVbdZSnISqDV+nezh4f72fXp5Y0bIZpogDKKZBLXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vS0th-000000003B5-2e91;
	Sat, 06 Dec 2025 22:37:01 +0000
Date: Sat, 6 Dec 2025 22:36:58 +0000
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
Subject: [PATCH net v2] net: dsa: mxl-gsw1xx: manually clear RANEG bit
Message-ID: <a90b206e9fd8e4248fd639afd5ae296454ac99b9.1765060046.git.daniel@makrotopia.org>
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
v2:
 * cancel pending work before setting RANEG bit
 * cancel pending work on remove and shutdown
 * document that GSW1XX_RST_REQ_SGMII_SHELL also clears RANEG bit
 * improve commit message

 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index cf33a16fd183b..5232737778835 100644
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
-	/* Assert SGMII shell reset */
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
 
+	cancel_delayed_work_sync(&gsw1xx_priv->clear_raneg);
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

