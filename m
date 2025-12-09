Return-Path: <netdev+bounces-244056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F18AFCAEA04
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 02:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5CDC3012BD8
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 01:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58382765C5;
	Tue,  9 Dec 2025 01:29:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581B61DD889;
	Tue,  9 Dec 2025 01:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765243755; cv=none; b=V0ITcjXQ0LgbCeb66nyMEL30AQIHjiFuicf9o8q3miOlmpyYheUTvxMH77P2kUjfhqrIpEH19kRGBmlJxSqk1Ql03j45L3jq6doU06y675SenWgl/07Mqp2emToBtdDOXpmBq6h4hlnqdUgmuO8gIh93wHG7XKj9lsEKiugVf0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765243755; c=relaxed/simple;
	bh=y/QFIXrd5+g2zMWNbODXhF5HFEVeSPwQKtKVAz6QoGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fix/B3TENj8isZTVEBrRKzaJRKdD2wxHftUKlnKA/ni9i5Dkw1GShTVMiRQbWzG+YTveOj8hLnER3ixRaFvlEP8YN3Tj1ZfCGL3ZRYdX9p6/Wo+VW1c7Tl8QFnN1vWvFWana3cglN0XD8gie9Dar7okP4Xs/zaNmyEwzpdUi+84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vSmXL-000000005BI-3cRz;
	Tue, 09 Dec 2025 01:29:07 +0000
Date: Tue, 9 Dec 2025 01:29:05 +0000
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
Subject: [PATCH net v4 3/4] net: dsa: mxl-gsw1xx: fix .shutdown driver
 operation
Message-ID: <77ed91a5206e5dbf5d3e83d7e364ebfda90d31fd.1765241054.git.daniel@makrotopia.org>
References: <cover.1765241054.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765241054.git.daniel@makrotopia.org>

The .shutdown operation should call dsa_switch_shutdown() just like
it is done also by the sibling lantiq_gswip driver. Not doing that
results in shutdown or reboot hanging and waiting for the CPU port
becoming free, which introduces a longer delay and a WARNING before
shutdown or reboot in case the driver is built-into the kernel.
Fix this by calling dsa_switch_shutdown() in the driver's shutdown
operation, harmonizing it with what is done in the lantiq_gswip
driver. As a side-effect this now allows to remove the previously
exported gswip_disable_switch() function which no longer got any
users.

Fixes: 22335939ec907 ("net: dsa: add driver for MaxLinear GSW1xx switch family")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v4: initial submission, not present in previous versions

 drivers/net/dsa/lantiq/lantiq_gswip.h        | 2 --
 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 6 ------
 drivers/net/dsa/lantiq/mxl-gsw1xx.c          | 4 ++--
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index 9c38e51a75e80..2e0f2afbadbbc 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
@@ -294,8 +294,6 @@ struct gswip_priv {
 	u16 version;
 };
 
-void gswip_disable_switch(struct gswip_priv *priv);
-
 int gswip_probe_common(struct gswip_priv *priv, u32 version);
 
 #endif /* __LANTIQ_GSWIP_H */
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
index 6b171d58e1862..e790f2ef75884 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
@@ -1664,12 +1664,6 @@ static const struct dsa_switch_ops gswip_switch_ops = {
 	.port_hsr_leave		= dsa_port_simple_hsr_leave,
 };
 
-void gswip_disable_switch(struct gswip_priv *priv)
-{
-	regmap_clear_bits(priv->mdio, GSWIP_MDIO_GLOB, GSWIP_MDIO_GLOB_ENABLE);
-}
-EXPORT_SYMBOL_GPL(gswip_disable_switch);
-
 static int gswip_validate_cpu_port(struct dsa_switch *ds)
 {
 	struct gswip_priv *priv = ds->priv;
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index cda966d71e889..4dc287ad141e1 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -662,9 +662,9 @@ static void gsw1xx_shutdown(struct mdio_device *mdiodev)
 	if (!priv)
 		return;
 
-	dev_set_drvdata(&mdiodev->dev, NULL);
+	dsa_switch_shutdown(priv->ds);
 
-	gswip_disable_switch(priv);
+	dev_set_drvdata(&mdiodev->dev, NULL);
 }
 
 static const struct gswip_hw_info gsw12x_data = {
-- 
2.52.0

