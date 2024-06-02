Return-Path: <netdev+bounces-99989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAE28D7646
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 16:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007E22814BD
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 14:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F53B4D5A5;
	Sun,  2 Jun 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncXmT4oD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239D44594C;
	Sun,  2 Jun 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717339008; cv=none; b=V1JUBJOuwnyJhmq5UXabwlpnCguRg+jL4ugTi6Sx4o6EMclx01PNzDUPTYoqwGLRFWEwQSIN3Wb67hG4HaM/YinH0UUVMmp3j+5SonfrubCPReCZIYHyroyswSw1E2bqXIvj6eCjs7E4/mpJjQIjxfsd9F5tRtq72w99ANrjhgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717339008; c=relaxed/simple;
	bh=pkJ7+HFghe8xVV2bDKTNlz9IEgLjoMzukY7F8ROLww4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEhGGXJJqqSJxPQRcdeD/8mwSzjifpW0J5tws5v03DMvJ7vdmkApWFBEWkptqJxA9Zi6EeontjM55RNGZD0Uyc9PnoZTS9wlO9rxgZ52cNo03/IrzeDmQntQdXDCkygdOXRQxGLUYya1FjskAFUuKmAEbjtwu/JsywnCVhbymeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncXmT4oD; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e95a60dfcdso42835291fa.1;
        Sun, 02 Jun 2024 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717339005; x=1717943805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNtSE/Sz58dIQftFvxUpsZScMic73JvgAp5RjxHCtMo=;
        b=ncXmT4oDxBOurRmURuukpFQN6tLMm+8YIQQlUaipa/QUzY5JCXh0b0BggzQ4MlDhPA
         wuqFc5MHqndcvSVOG/SNWkdQ9wt/J66XbMWhuJaB+JtkerSL1ldFrjUlXP5Ilzk6Md1W
         M+CPS48EA94k8VFPGW5R0/1WtYF6CJCojdVvaAnb66EetHwCCuESXpdkonuMOsKdeUZI
         8AP21UQW68uNptajkXHQIiNH9HPeGuJ8eigVKd8hgimqqXEZI91ubUyuTpbX6mkD+2oE
         flqKB/hCNoNMGuX93h86JN2jd07CZCFzIpd0TF7vW4PJUpdOc7SXLNw7lPv3yijHabOA
         WkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717339005; x=1717943805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNtSE/Sz58dIQftFvxUpsZScMic73JvgAp5RjxHCtMo=;
        b=X/tpTUooUwSbezXs8+bVbr3dLDDUJM8wFHRoNCFN7qb8jBNxfEZ54nZRfDbUehwf34
         XhGpnRFgc0UT9KDXtYEUp0/kF8tpCiuZq7aZvi6iCQl29ZnMZwT+IOoO8eWri0P1nMxF
         zy4B2svHiZeXmMidr7KoCL062HM/Xulfo8mEXiniRt+dufMTrkZ/iPs1b5Z2RIkhlnjq
         AyQuo4XFz+1ab/fmM+dCW5SWlaST/KnjWps5VgxXuU4Mn9IskPaEiZ3A9EvFuAHdsLcW
         AAdVSHjNccliV35jQyT/0z9ZQ2FgzyQwTI9WO/qoq/waQ1VlHFARi3LRRahSRVpJ/3AV
         JWWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8FHqrxEfPcPdkEfhHwIuQrIiRgLtev28EAEV+cVS30r3ndDniHsZ5eYltqJGpgZZFUL+/DrLcq5Zv8Ux5vzLuBHyAEu1YS/TfwNc1M0upBTq50eXG8EALwPgefas9o2IZ7oOm05SLZgeNCk6E51FcdkQ93PuIK63yKqiwbVlzFQ==
X-Gm-Message-State: AOJu0Yw9grzPXwYl9tC6f7dxNQ9WUHM2BnM1YoK3gCxMWgKC4Xgc54dO
	O1p0apXHKvNhr2HHEVHt0hnfWDWcij0NKdOoS0x0iwtQYpJU1eoC
X-Google-Smtp-Source: AGHT+IENxA9A975RgQqj4dZWXkCNJxoPKV4V++dmEk34UHUscmDHWyMvHKh7+h7hfi6Novv707U5Sw==
X-Received: by 2002:a2e:2409:0:b0:2e6:cb01:aeef with SMTP id 38308e7fff4ca-2ea951e02a3mr45725411fa.36.1717339005047;
        Sun, 02 Jun 2024 07:36:45 -0700 (PDT)
Received: from localhost ([178.178.142.64])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91bb5411sm8990621fa.53.2024.06.02.07.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 07:36:44 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 02/10] net: pcs: xpcs: Split up xpcs_create() body to sub-functions
Date: Sun,  2 Jun 2024 17:36:16 +0300
Message-ID: <20240602143636.5839-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240602143636.5839-1-fancer.lancer@gmail.com>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As an initial preparation before adding the fwnode-based DW XPCS device
support let's split the xpcs_create() function code up to a set of the
small sub-functions. Thus the xpcs_create() implementation will get to
look simpler and turn to be more coherent. Further updates will just touch
the new sub-functions a bit: add platform-specific device info, add the
reference clock getting and enabling.

The xpcs_create() method will now contain the next static methods calls:

xpcs_create_data() - create the DW XPCS device descriptor, pre-initialize
it' fields and increase the mdio device refcount-er;

xpcs_init_id() - find XPCS ID instance and save it in the device
descriptor;

xpcs_init_iface() - find MAC/PCS interface descriptor and perform
basic initialization specific to it: soft-reset, disable polling.

The update doesn't imply any semantic change but merely makes the code
looking simpler and more ready for adding new features support.

Note the xpcs_destroy() has been moved to being defined below the
xpcs_create_mdiodev() function as the driver now implies having the
protagonist-then-antagonist functions definition order.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- Preserve the strict refcount-ing pattern. (@Russell)
---
 drivers/net/pcs/pcs-xpcs.c | 102 +++++++++++++++++++++++++------------
 1 file changed, 69 insertions(+), 33 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 99adbf15ab36..2dcfd0ff069a 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1365,12 +1365,9 @@ static const struct phylink_pcs_ops xpcs_phylink_ops = {
 	.pcs_link_up = xpcs_link_up,
 };
 
-static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
-				   phy_interface_t interface)
+static struct dw_xpcs *xpcs_create_data(struct mdio_device *mdiodev)
 {
 	struct dw_xpcs *xpcs;
-	u32 xpcs_id;
-	int i, ret;
 
 	xpcs = kzalloc(sizeof(*xpcs), GFP_KERNEL);
 	if (!xpcs)
@@ -1378,59 +1375,89 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
 
 	mdio_device_get(mdiodev);
 	xpcs->mdiodev = mdiodev;
+	xpcs->pcs.ops = &xpcs_phylink_ops;
+	xpcs->pcs.neg_mode = true;
+	xpcs->pcs.poll = true;
+
+	return xpcs;
+}
+
+static void xpcs_free_data(struct dw_xpcs *xpcs)
+{
+	mdio_device_put(xpcs->mdiodev);
+	kfree(xpcs);
+}
+
+static int xpcs_init_id(struct dw_xpcs *xpcs)
+{
+	u32 xpcs_id;
+	int i, ret;
 
 	xpcs_id = xpcs_get_id(xpcs);
 
 	for (i = 0; i < ARRAY_SIZE(xpcs_id_list); i++) {
 		const struct xpcs_id *entry = &xpcs_id_list[i];
-		const struct xpcs_compat *compat;
 
 		if ((xpcs_id & entry->mask) != entry->id)
 			continue;
 
 		xpcs->id = entry;
 
-		compat = xpcs_find_compat(entry, interface);
-		if (!compat) {
-			ret = -ENODEV;
-			goto out;
-		}
+		break;
+	}
 
-		ret = xpcs_dev_flag(xpcs);
-		if (ret)
-			goto out;
+	if (!xpcs->id)
+		return -ENODEV;
 
-		xpcs->pcs.ops = &xpcs_phylink_ops;
-		xpcs->pcs.neg_mode = true;
+	ret = xpcs_dev_flag(xpcs);
+	if (ret < 0)
+		return ret;
 
-		if (xpcs->dev_flag != DW_DEV_TXGBE) {
-			xpcs->pcs.poll = true;
+	return 0;
+}
 
-			ret = xpcs_soft_reset(xpcs, compat);
-			if (ret)
-				goto out;
-		}
+static int xpcs_init_iface(struct dw_xpcs *xpcs, phy_interface_t interface)
+{
+	const struct xpcs_compat *compat;
 
-		return xpcs;
+	compat = xpcs_find_compat(xpcs->id, interface);
+	if (!compat)
+		return -EINVAL;
+
+	if (xpcs->dev_flag == DW_DEV_TXGBE) {
+		xpcs->pcs.poll = false;
+		return 0;
 	}
 
-	ret = -ENODEV;
+	return xpcs_soft_reset(xpcs, compat);
+}
+
+static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
+				   phy_interface_t interface)
+{
+	struct dw_xpcs *xpcs;
+	int ret;
+
+	xpcs = xpcs_create_data(mdiodev);
+	if (IS_ERR(xpcs))
+		return xpcs;
+
+	ret = xpcs_init_id(xpcs);
+	if (ret)
+		goto out;
+
+	ret = xpcs_init_iface(xpcs, interface);
+	if (ret)
+		goto out;
+
+	return xpcs;
 
 out:
-	mdio_device_put(mdiodev);
-	kfree(xpcs);
+	xpcs_free_data(xpcs);
 
 	return ERR_PTR(ret);
 }
 
-void xpcs_destroy(struct dw_xpcs *xpcs)
-{
-	if (xpcs)
-		mdio_device_put(xpcs->mdiodev);
-	kfree(xpcs);
-}
-EXPORT_SYMBOL_GPL(xpcs_destroy);
-
 struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
 				    phy_interface_t interface)
 {
@@ -1455,5 +1482,14 @@ struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
 }
 EXPORT_SYMBOL_GPL(xpcs_create_mdiodev);
 
+void xpcs_destroy(struct dw_xpcs *xpcs)
+{
+	if (!xpcs)
+		return;
+
+	xpcs_free_data(xpcs);
+}
+EXPORT_SYMBOL_GPL(xpcs_destroy);
+
 MODULE_DESCRIPTION("Synopsys DesignWare XPCS library");
 MODULE_LICENSE("GPL v2");
-- 
2.43.0


