Return-Path: <netdev+bounces-247409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D634CF97A1
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 17:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 540D9301B110
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E485326943;
	Tue,  6 Jan 2026 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBUMEGty"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA8F283FE2
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718592; cv=none; b=akUoTuPR6Nb1Mjqe3/U0AZ5UG8jxMMHX5OfL5QxgxiWW8E/XTQudrI1bpF1b1n6ZUpcOHzq6ylv6oTBo7G+vNaYRnBaANlsSoPrdjeqDq5+tbnWQTiC5WoNUTH6x9GppKyJvgwQriWnG9xYuOPr4gFsCHt8uPUQW9yVIq1oZI3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718592; c=relaxed/simple;
	bh=yfORz574U/QdIY8zj986fSTrqwSzgTLkdI+7BLEd3Tw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=XfbkySacvE+6wGNEZEyeEVReFeRLAj7OJrL+oET940wy5Gua8I4K5PLlY1BVilU0xuAygkCzGqSODtCR2JulPuIm2THsgI5CykPEQPcr/tniWnYCg4D0xh9bx6oRzjP5sJjW7rAAoMRJxRbupeKZ1xFMRUzWOf7OCKdIf3oYITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBUMEGty; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47d3ffa5f33so6022185e9.2
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 08:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767718589; x=1768323389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmzAhmHenjrYT+JoOzv/QCUdsbgbHQ35PpsPjgj4X/E=;
        b=IBUMEGtyAhw6XskGOd/7O8I55AUTtmrMn54F7mPWCm5LzhQf/8hoJZfik3YzmHH8Li
         bipUFEANrQhuEHJzluO+nOGeVna1EL5oX+lJg9Munfwd8QmovZTLTi0/eM562L9UljIb
         3hxlnZmey02NT6XoyUwPBYRRUjIeGv3LSdWj2F+wIV+JlI0InrfV+N/2wIkoTZoVAN0a
         nMesNzNLT1KzuWwx7p5lSZTal1X23CLUfkJYsfDNscP/tyxzf0TrE0ogR+SEIBK24ne9
         4MK4ENxrOH8oAkKo+rpEdUR6xedJ37J4agavnP4HK/ax9J87LTlNmb2xIcVtEZ0WNuxs
         W7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767718589; x=1768323389;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmzAhmHenjrYT+JoOzv/QCUdsbgbHQ35PpsPjgj4X/E=;
        b=b/BI62dBlu9vT5EGqvV1mBNMHb9jwtef929xM3aAaaUrIVTJ4geuwqq0e6va7uQk6Q
         NoZ9fEoh7UkuQQzj8naoNJm/ADRbhlOhYh7QD+HxevLWVPyQG4j94ciav8+dk3fTLXYz
         lxFAUdT4HJvas80rNFNpriehQY3bcDeMXOJGpHMvXivfEEBF0gqE9asgqPO5AxBjolyY
         YPF4rh6ETovt05hFgJxHU1MauNnBiWkbE2jZs2DvRfeb252dCIJypGU4Q/U4AhFbFVPH
         yo1rgs5Qjuk9VYZgmm9TaWPS9o7BBa4sKkFmXHQJMlAdIM5zTGWlfbAc0JsWcM/evMZN
         YucA==
X-Gm-Message-State: AOJu0YzDphRzYUWdYqRx5HGtgyjt5nXb6eUdRd0ccnWpGNF8GGSB3pZb
	UVCzzc1DQ6OaaXeDBYkOZeWg7Vhh4vlBc+izaisc6RDfwMc7uH8RaGSz
X-Gm-Gg: AY/fxX5cUJGb3HHfd35Veuwl39nloCdDHsVvAY/FBuYYGnE8T8a+l7dW1xGSObgm350
	lKIe4R5I9YoD1FNWj3qpwYKhkIsZa7Nc5MapVCeGJT7WM67hEZZG/Csfs/SrySJ8H4SdPm96jEA
	7IGksQ/fQ3WXRtmpR8OkD7uRRE7BKNfsmmFCqTo+Y/dqevuVpeAAdw7aHNafCVRGiMf1ymvpUq1
	x41IiSLM6XCsz1Zs0rsJcyF/zFWPHO3gW8IygrWuXTUNj83VH9tXBDm/6R465RuILyROuZ4iV0E
	5L5uL+H03jMgg7d7GQC2YeIgsj+MQJM5O2nF+JI8krg5j/GqJ5OGAjKoD3pgqtK+YzuiCcNDtZ5
	e6NzXCeJlySHxWqNWEMsPVrj9RA9vJDXZAN+X7sjPtfytpdjHnuLfdviX2d9bUwAiLcDZCvJuZt
	0jOXfpwiqrW5L4xwqdBZPQ4QFZfVZ9/Wh8BMk4uC9YuO5pPLOIcSw5hNeAgwmmELyNZ2UVfpEb8
	6fFMMFx0Kr/5ZW/LYYpp04j6WrCngLhV6kfCNBQ4XhCyd2w8MhAxA==
X-Google-Smtp-Source: AGHT+IGcxb61OBHFp2B9IEUikBehdR4j/joRopipzdhVYDIADVLVJYeU7qjYEbfsHTXGU3SwvJ9GEg==
X-Received: by 2002:a05:600c:1f83:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-47d7f071e0bmr40407435e9.13.1767718588962;
        Tue, 06 Jan 2026 08:56:28 -0800 (PST)
Received: from ?IPV6:2003:ea:8f35:e900:51c5:daf3:bde4:546e? (p200300ea8f35e90051c5daf3bde4546e.dip0.t-ipconnect.de. [2003:ea:8f35:e900:51c5:daf3:bde4:546e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f7035f2sm49770435e9.12.2026.01.06.08.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 08:56:28 -0800 (PST)
Message-ID: <e14f6119-9bf9-4e9d-8e14-a8cb884cbd5c@gmail.com>
Date: Tue, 6 Jan 2026 17:56:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: fixed_phy: replace list of fixed PHYs with
 static array
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Due to max 32 PHY addresses being available per mii bus, using a list
can't support more fixed PHY's. And there's no known use case for as
much as 32 fixed PHY's on a system. 8 should be plenty of fixed PHY's,
so use an array of that size instead of a list. This allows to
significantly reduce the code size and complexity.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 69 +++++++++----------------------------
 1 file changed, 17 insertions(+), 52 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 50684271f81..7d6078d1570 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -10,7 +10,6 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/list.h>
 #include <linux/mii.h>
 #include <linux/phy.h>
 #include <linux/phy_fixed.h>
@@ -22,27 +21,24 @@
 
 #include "swphy.h"
 
+/* The DSA loop driver may allocate 4 fixed PHY's, and 4 additional
+ * fixed PHY's for a system should be sufficient.
+ */
+#define NUM_FP	8
+
 struct fixed_phy {
-	int addr;
 	struct phy_device *phydev;
 	struct fixed_phy_status status;
 	int (*link_update)(struct net_device *, struct fixed_phy_status *);
-	struct list_head node;
 };
 
+static struct fixed_phy fmb_fixed_phys[NUM_FP];
 static struct mii_bus *fmb_mii_bus;
-static LIST_HEAD(fmb_phys);
+static DEFINE_IDA(phy_fixed_ida);
 
 static struct fixed_phy *fixed_phy_find(int addr)
 {
-	struct fixed_phy *fp;
-
-	list_for_each_entry(fp, &fmb_phys, node) {
-		if (fp->addr == addr)
-			return fp;
-	}
-
-	return NULL;
+	return ida_exists(&phy_fixed_ida, addr) ? fmb_fixed_phys + addr : NULL;
 }
 
 int fixed_phy_change_carrier(struct net_device *dev, bool new_carrier)
@@ -108,31 +104,6 @@ int fixed_phy_set_link_update(struct phy_device *phydev,
 }
 EXPORT_SYMBOL_GPL(fixed_phy_set_link_update);
 
-static int __fixed_phy_add(int phy_addr,
-			   const struct fixed_phy_status *status)
-{
-	struct fixed_phy *fp;
-	int ret;
-
-	ret = swphy_validate_state(status);
-	if (ret < 0)
-		return ret;
-
-	fp = kzalloc(sizeof(*fp), GFP_KERNEL);
-	if (!fp)
-		return -ENOMEM;
-
-	fp->addr = phy_addr;
-	fp->status = *status;
-	fp->status.link = true;
-
-	list_add_tail(&fp->node, &fmb_phys);
-
-	return 0;
-}
-
-static DEFINE_IDA(phy_fixed_ida);
-
 static void fixed_phy_del(int phy_addr)
 {
 	struct fixed_phy *fp;
@@ -141,8 +112,7 @@ static void fixed_phy_del(int phy_addr)
 	if (!fp)
 		return;
 
-	list_del(&fp->node);
-	kfree(fp);
+	memset(fp, 0, sizeof(*fp));
 	ida_free(&phy_fixed_ida, phy_addr);
 }
 
@@ -153,19 +123,20 @@ struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
 	int phy_addr;
 	int ret;
 
+	ret = swphy_validate_state(status);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
 	if (!fmb_mii_bus || fmb_mii_bus->state != MDIOBUS_REGISTERED)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	/* Get the next available PHY address, up to PHY_MAX_ADDR */
-	phy_addr = ida_alloc_max(&phy_fixed_ida, PHY_MAX_ADDR - 1, GFP_KERNEL);
+	/* Get the next available PHY address, up to NUM_FP */
+	phy_addr = ida_alloc_max(&phy_fixed_ida, NUM_FP - 1, GFP_KERNEL);
 	if (phy_addr < 0)
 		return ERR_PTR(phy_addr);
 
-	ret = __fixed_phy_add(phy_addr, status);
-	if (ret < 0) {
-		ida_free(&phy_fixed_ida, phy_addr);
-		return ERR_PTR(ret);
-	}
+	fmb_fixed_phys[phy_addr].status = *status;
+	fmb_fixed_phys[phy_addr].status.link = true;
 
 	phy = get_phy_device(fmb_mii_bus, phy_addr, false);
 	if (IS_ERR(phy)) {
@@ -237,15 +208,9 @@ module_init(fixed_mdio_bus_init);
 
 static void __exit fixed_mdio_bus_exit(void)
 {
-	struct fixed_phy *fp, *tmp;
-
 	mdiobus_unregister(fmb_mii_bus);
 	mdiobus_free(fmb_mii_bus);
 
-	list_for_each_entry_safe(fp, tmp, &fmb_phys, node) {
-		list_del(&fp->node);
-		kfree(fp);
-	}
 	ida_destroy(&phy_fixed_ida);
 }
 module_exit(fixed_mdio_bus_exit);
-- 
2.52.0


