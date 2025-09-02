Return-Path: <netdev+bounces-219266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F13B40D42
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2763A7B2028
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 18:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0872321F46;
	Tue,  2 Sep 2025 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4JzDoys"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB495A95E
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838220; cv=none; b=res20MLk8DUIHQMQDDSCC2w9lPCUpamvZ3+yoqYf400Zwf3DPJdqbIzd8jSe02125AzqjcRESppxfNTgPt+3Sj6peSFC050bqTjkAbkbfFxK7WcZuM6pzFVu0/Gx0XgKJp4UHccnN9lLSd6q4TObcuPN3d+WEW+79nd1/bkcIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838220; c=relaxed/simple;
	bh=Zea+OoX6dNclSIVg2S+Kbl0NRotB+IHzHK0qYBHSSu4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=r45M5vpujI3CcJviJch/hgiUPgBoMjZ2fkbdVuU3c4ejvr2R7KC3CSCVzSjtEWezeGff09SiITqV2Zsz9orx5ZAy/vc5jwy29bfRHVlu0eOTjtwWuA2ZpaRu+9Pc2gyjpPwy6V9SVhxPtH85rfKntutqVUS883i5vblZySf1Eb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4JzDoys; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3cf991e8bb8so2717880f8f.2
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 11:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756838217; x=1757443017; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4z8ZrUxDu+TYO6M1TkQ2iG9OrS3Zff9K7KWQp0LjGY=;
        b=L4JzDoys9bLOJsAgLnKmdClVbcmP9RcOZHiiNZ2dTDEtS8Q47CuyGC1Hx4yjuZaHtt
         k4R09MzkGCzwIp0lFOf/lA6wlPlKgzzLceGDEX60f96GMlpJefAFxtt7PEjkorAPNP3j
         HlDX1DDuqcvJn8RHiqPda1bkidYcdh/Ef1K9Xius8Rq4jiYcnYEnzb+VtK0GJ1Ec9OD5
         5Iot4WF8EjwwAGaXnA/NerB4zhBP8ikcn/tBkAo7LkdEEcf+s5ty4qM7omMe+r9GsJpM
         WLmhYtcFpsBoMoYeLWBC9Zwy83X8CgCcLLYBj/UdJUK8xxALEDZ9bwibrXiUdP7HP0YC
         yGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756838217; x=1757443017;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4z8ZrUxDu+TYO6M1TkQ2iG9OrS3Zff9K7KWQp0LjGY=;
        b=U0qrwAZX1F0BsyTeSSjSKY+kKV/chn17fOjCOj6N/kBJldWqUvzIntOexZdIna35XF
         umDzNft0B6MSEIBHn+Y/YfIr7I66myVDzylRjvcwOEAFU8qT4wagAbzYEVdVVGV/fLuY
         1+XhS7XlQ5PTfY2lCxw61z9AbhduA1T5az7lh5XH672qu8U4p1yfvJx5pTGh9SR0Xt9u
         GfWT/aG3lRNcJwXEBInxfl1pKgdxzqyUgw5lcoWWbe3SXNOyy9IEal4olMxkWHVdjOFq
         esd7Apj/gDMApXKvGU9uxR19BPNAlzl8Y4Hem0L4UloSDxTWgY8kWmml0rWAAjLGtDtw
         JT4A==
X-Gm-Message-State: AOJu0YwJjaYavL2yvs36cBVZtP1LCXlNRPqA7FDBAyhwFody9iI+Ogp6
	/MBSnHXFIxOiNcN6k/oyOV5ouVF2BYbt/Ey9CDAoOjQqxJaVoB2klaC6
X-Gm-Gg: ASbGncsaQOAPaBkMXD2cU/1SbLLcvjAFjk/gpPiaaNLHwOzkMtg2ZRRO2hjpbED8m8a
	8/59I3siO+78oev/uYGwg765f0ePAqk+WAr4QtJaUAg1JE56ly/Dk1nwcQHoGlyM/7z5o0TcmrT
	hf9C1m3Qw+sHwjlyOeq44GZKPo5b3u6Ca1s/MIR7EXfa5k2P175RgI9WN+nJFkIWquXlOSABlwO
	j+xw96o6iXhr8NDTosAxbVUnGNfB5Xhu3AZdmUvIhJj0ceU/PBE/U2luXD8ZZpDk/bHLOalYcTs
	A3N6092RTvi+GXwDRj3p4m1Nvv9P0BLCyDRm9p5uCuAHXi+qpJXNeBRUZopTjiZmjNwvKtBcb6U
	5y9L8XACGtO619EesJcbSoMxy9lpPfmkp4ybGJL6mveWyu+HxiMPlTjNup83uKg/2TT5vxWhB+x
	+Y4AY3ftGPl7jIcPy9lzFptSF3y4xZnhTfi7WqhDVPtrJ/EnNSl5xvt4qVfQlnoQ==
X-Google-Smtp-Source: AGHT+IGSNYhI7E7QwGY0Cru2rV7ct1qKSO877Ho7HiFQ/JxjBknsi13wwCYCylmlKS196DwjCxC4kw==
X-Received: by 2002:a05:6000:2891:b0:3d0:654c:2486 with SMTP id ffacd0b85a97d-3d1dcb764d3mr9229980f8f.21.1756838216845;
        Tue, 02 Sep 2025 11:36:56 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f25:8100:e13f:d8aa:6a68:8455? (p200300ea8f258100e13fd8aa6a688455.dip0.t-ipconnect.de. [2003:ea:8f25:8100:e13f:d8aa:6a68:8455])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3dbead0b247sm1162857f8f.6.2025.09.02.11.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 11:36:56 -0700 (PDT)
Message-ID: <230c1f83-6dac-484a-bc80-e62260e56e74@gmail.com>
Date: Tue, 2 Sep 2025 20:37:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next] net: phy: fixed_phy: remove link gpio support
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The only user of fixed_phy gpio functionality was here:
arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts
Support for the switch on this board was migrated to phylink
(DSA - mv88e6xxx) years ago, so the functionality is unused now.
Therefore remove it.

Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- fix typo in commit message
---
 drivers/net/phy/fixed_phy.c | 68 +++----------------------------------
 1 file changed, 4 insertions(+), 64 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 7f4e1a155..aae7bd4ce 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -17,7 +17,6 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/gpio/consumer.h>
 #include <linux/idr.h>
 #include <linux/netdevice.h>
 #include <linux/linkmode.h>
@@ -36,7 +35,6 @@ struct fixed_phy {
 	bool no_carrier;
 	int (*link_update)(struct net_device *, struct fixed_phy_status *);
 	struct list_head node;
-	struct gpio_desc *link_gpiod;
 };
 
 static struct fixed_mdio_bus platform_fmb = {
@@ -62,12 +60,6 @@ int fixed_phy_change_carrier(struct net_device *dev, bool new_carrier)
 }
 EXPORT_SYMBOL_GPL(fixed_phy_change_carrier);
 
-static void fixed_phy_update(struct fixed_phy *fp)
-{
-	if (!fp->no_carrier && fp->link_gpiod)
-		fp->status.link = !!gpiod_get_value_cansleep(fp->link_gpiod);
-}
-
 static int fixed_mdio_read(struct mii_bus *bus, int phy_addr, int reg_num)
 {
 	struct fixed_mdio_bus *fmb = bus->priv;
@@ -82,9 +74,6 @@ static int fixed_mdio_read(struct mii_bus *bus, int phy_addr, int reg_num)
 				fp->link_update(fp->phydev->attached_dev,
 						&fp->status);
 
-			/* Check the GPIO for change in status */
-			fixed_phy_update(fp);
-
 			return swphy_read_reg(reg_num, &fp->status);
 		}
 	}
@@ -125,9 +114,8 @@ int fixed_phy_set_link_update(struct phy_device *phydev,
 }
 EXPORT_SYMBOL_GPL(fixed_phy_set_link_update);
 
-static int fixed_phy_add_gpiod(unsigned int irq, int phy_addr,
-			       const struct fixed_phy_status *status,
-			       struct gpio_desc *gpiod)
+static int __fixed_phy_add(unsigned int irq, int phy_addr,
+			   const struct fixed_phy_status *status)
 {
 	int ret;
 	struct fixed_mdio_bus *fmb = &platform_fmb;
@@ -146,9 +134,6 @@ static int fixed_phy_add_gpiod(unsigned int irq, int phy_addr,
 
 	fp->addr = phy_addr;
 	fp->status = *status;
-	fp->link_gpiod = gpiod;
-
-	fixed_phy_update(fp);
 
 	list_add_tail(&fp->node, &fmb->phys);
 
@@ -157,7 +142,7 @@ static int fixed_phy_add_gpiod(unsigned int irq, int phy_addr,
 
 void fixed_phy_add(const struct fixed_phy_status *status)
 {
-	fixed_phy_add_gpiod(PHY_POLL, 0, status, NULL);
+	__fixed_phy_add(PHY_POLL, 0, status);
 }
 EXPORT_SYMBOL_GPL(fixed_phy_add);
 
@@ -171,8 +156,6 @@ static void fixed_phy_del(int phy_addr)
 	list_for_each_entry_safe(fp, tmp, &fmb->phys, node) {
 		if (fp->addr == phy_addr) {
 			list_del(&fp->node);
-			if (fp->link_gpiod)
-				gpiod_put(fp->link_gpiod);
 			kfree(fp);
 			ida_free(&phy_fixed_ida, phy_addr);
 			return;
@@ -180,48 +163,10 @@ static void fixed_phy_del(int phy_addr)
 	}
 }
 
-#ifdef CONFIG_OF_GPIO
-static struct gpio_desc *fixed_phy_get_gpiod(struct device_node *np)
-{
-	struct device_node *fixed_link_node;
-	struct gpio_desc *gpiod;
-
-	if (!np)
-		return NULL;
-
-	fixed_link_node = of_get_child_by_name(np, "fixed-link");
-	if (!fixed_link_node)
-		return NULL;
-
-	/*
-	 * As the fixed link is just a device tree node without any
-	 * Linux device associated with it, we simply have obtain
-	 * the GPIO descriptor from the device tree like this.
-	 */
-	gpiod = fwnode_gpiod_get_index(of_fwnode_handle(fixed_link_node),
-				       "link", 0, GPIOD_IN, "mdio");
-	if (IS_ERR(gpiod) && PTR_ERR(gpiod) != -EPROBE_DEFER) {
-		if (PTR_ERR(gpiod) != -ENOENT)
-			pr_err("error getting GPIO for fixed link %pOF, proceed without\n",
-			       fixed_link_node);
-		gpiod = NULL;
-	}
-	of_node_put(fixed_link_node);
-
-	return gpiod;
-}
-#else
-static struct gpio_desc *fixed_phy_get_gpiod(struct device_node *np)
-{
-	return NULL;
-}
-#endif
-
 struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
 				      struct device_node *np)
 {
 	struct fixed_mdio_bus *fmb = &platform_fmb;
-	struct gpio_desc *gpiod;
 	struct phy_device *phy;
 	int phy_addr;
 	int ret;
@@ -229,17 +174,12 @@ struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
 	if (!fmb->mii_bus || fmb->mii_bus->state != MDIOBUS_REGISTERED)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	/* Check if we have a GPIO associated with this fixed phy */
-	gpiod = fixed_phy_get_gpiod(np);
-	if (IS_ERR(gpiod))
-		return ERR_CAST(gpiod);
-
 	/* Get the next available PHY address, up to PHY_MAX_ADDR */
 	phy_addr = ida_alloc_max(&phy_fixed_ida, PHY_MAX_ADDR - 1, GFP_KERNEL);
 	if (phy_addr < 0)
 		return ERR_PTR(phy_addr);
 
-	ret = fixed_phy_add_gpiod(PHY_POLL, phy_addr, status, gpiod);
+	ret = __fixed_phy_add(PHY_POLL, phy_addr, status);
 	if (ret < 0) {
 		ida_free(&phy_fixed_ida, phy_addr);
 		return ERR_PTR(ret);
-- 
2.51.0


