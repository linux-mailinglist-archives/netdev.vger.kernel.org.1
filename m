Return-Path: <netdev+bounces-219815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12154B431FF
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 08:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6DE917826C
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 06:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A0324395C;
	Thu,  4 Sep 2025 06:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkc4P09i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8431F61C
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 06:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966095; cv=none; b=ifAbFPcxoF7/3Fg3XgTt12OJYiz50Wi3W3DPr5RYwvZoskpMVwdNOtjU542e5/3wq4gdtPm72Z68lXxZjpHXWMJlWHFPTC3mvx3twbJPoacd6N+Ia9LUhCmh3mMMkCgh6Q47OB4Z6mPq1sUn00gz5E/rZlMZzknH9XtLxISseNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966095; c=relaxed/simple;
	bh=j54N4guOnorqmt61t99r6iJeOE4fivtg/SyBNyVAn34=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hH7hQ7aBlOrkGpNDGh4P/VUPpm3+wjpzJdFczpMWoHBGhtSfAbmRfxCuXBuUDCSZvwQtoz7AqnsJCKKy/b4HRuy8CIv08ZA6JS38P1E6epvzYHmXg4oz/kcBsd4S+sZaglRXr1JvYT8se9byVd4LdkIa8tFi0zASkIhMvRG6MvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkc4P09i; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61cf0901a72so1093759a12.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 23:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756966091; x=1757570891; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkdPA9alUIn2ARxr+8KdTUqM7mh0pBgvC4GhH9vU33A=;
        b=kkc4P09iSIM4Gff7ZFa8QwTsxeW58HqvSDuBL88UiNU591LnPcYMPQ49AbYzTQqQsq
         f8+x0TCCOa0kktB0d5OHlH9FHcxq1EFTLpdAjv1/FVEIoA7bNDwfH2a+s6/H43EQO/RM
         1HrFW5OFe3IOKn2sr1t0p0w1kzyOvIPRLadBPUWTfTrRhA5Bg3KeJNjqsRyPzcKlW0ux
         2gHYoaiK3ricNtmUI+TCV43U3GWgyxdh8TJTH8TmnEXXAmdbsM6ucT3t/1C2n0VcsAx3
         jNOxq8tHiOw16PVPIXH6Cx/mcQxFbqa3fKpzi6Fo+/X+mBlpgBnc2WESw+rltVWMMSQ3
         kkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756966091; x=1757570891;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkdPA9alUIn2ARxr+8KdTUqM7mh0pBgvC4GhH9vU33A=;
        b=NLmZAP7y9ZdSFYNkeuC3tm5nWBLhK6TI1artu6Srb8TpbiLKdlLeuidAvy1hUJyDBw
         ZKS/Yf7rXoRlMaln/F5hsgS3y8CgA1jh+AZ/IQygbrMomO09+2j467zcmuZEabLKMgsg
         GNrBOPZn8/ZgwN4iPhV/i8lEvHsBp48WwuQ6fnLFZbw2TL/ljLMYG1CKVTkO0H+rPm78
         k4cBbXe7O92eHU+PeXxnE1JUS+1AAZj8eVvNNr87e4N5IJFJ+mnqS8dFHNPA/oy/yMOQ
         XrbAOmYzKAPPwkjdgPFNVzcHtCYaCB7CWF48HwUCTPLusaCwnz5OmiD+m15K8Pkr88oO
         croA==
X-Gm-Message-State: AOJu0YxPhATZjZGpjLgLaMel9wMNC48nZmMhfcQOeFwYCtVJ4EIc3KlD
	4DgWH7LVEeFoBTeizCezZNmEGnJ7PPA0hlo0hI43jpezh8gLIL9vF1Ev
X-Gm-Gg: ASbGncuprKDmqqHV6k6Kv/EBdMGcvPpkQem8tmkLZ6i9YQ9LR+ix1CFaxWXekTw3P03
	7Mkw7JHpdBXJfdXzjtEMySH12x6tQhCxcLuU64OsG7TD8JNoSB4iY2vDvxHynW2FyOSEuc3jDe7
	bLe6bXYuoeb4qsndHvVj8jFel3K2sMfZ1Bkn0DIZbMv5aZz2GNCHAzPi5Y0RZHFdSRivY8p3UOw
	I8D2SuTgYdLn0DlzcaRbH18MWh0ySnGlUrZUr3Ha8+4A4g6EUE4oMm1Qo3RbA5aDocxB/KUgppi
	YPwsbN14bSlRxOCv/Hw4FhIb2z5MhZORawt37uimqhfRThKMXN2W8hNmUH05dIZRT3dcJ1/mb7H
	0OW+qW1GmJAwMGoEXc1RmwMw4ssQ0+6E838vDFVx/E3ihz/OGA+oQwCY/sXcE2/3zYs79I/Hf94
	ptIyLLYNfNeIhOy9aHv517hpimq52S8eJWLznBqA/Ce20MyuAGO4JHjBoK04/abXNFpQv1Sg==
X-Google-Smtp-Source: AGHT+IFC5wb2I3+MqdGo1n/BI1VUNxoZZODms+o97D0oPXhvoLGXOQGWjLKroqYTWVuOwjklPdlfVg==
X-Received: by 2002:a05:6402:90c:b0:61c:61bb:e836 with SMTP id 4fb4d7f45d1cf-61d26988ecdmr14227299a12.11.1756966091287;
        Wed, 03 Sep 2025 23:08:11 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1f:b00:1062:8af8:2f20:2501? (p200300ea8f1f0b0010628af82f202501.dip0.t-ipconnect.de. [2003:ea:8f1f:b00:1062:8af8:2f20:2501])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc4ea764sm13585153a12.40.2025.09.03.23.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 23:08:10 -0700 (PDT)
Message-ID: <75295a9a-e162-432c-ba9f-5d3125078788@gmail.com>
Date: Thu, 4 Sep 2025 08:08:18 +0200
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
Subject: [PATCH v3 net-next] net: phy: fixed_phy: remove link gpio support
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The only user of fixed_phy gpio functionality was here:
arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts
Support for the switch on this board was migrated to phylink
(DSA - mv88e6xxx) years ago, so the functionality is unused now.
Therefore remove it.

Note: There is a very small risk that there's out-of-tree users
who use link gpio with a switch chip not handled by DSA.
However we care about in-tree device trees only.

Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- fix typo in commit message
v3:
- extend commit message
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


