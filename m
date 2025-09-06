Return-Path: <netdev+bounces-220633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB19B477EC
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 00:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28AE3A4394
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 22:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CEE2D46D8;
	Sat,  6 Sep 2025 22:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aj37+Djp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5157B26C3BF
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757196155; cv=none; b=a1lU/h0lnMF6X50dbloK/5Amj7R2JQzEhSHqYhyqwK0Y2cMfKHCl24riFMHQWOtgruNgEo8EZ68q2Og5nGO4IxWjGJKWeCNBgKu8YLKvfM5k/9kxYwsJHjMOMvu7Gl4ner5mk8FyCDZRKo16cn+8YLAJ3JZ39eHPQiFGswUN3R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757196155; c=relaxed/simple;
	bh=hZd8HvCuAwzi0pBfZgvhpNcIfW4nKWA0rmOSZxqtwLk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GyxbAKfOpJFjPgws+AAqZMElhDztMC42/xpv2XIswEwlVLSGmYoxkzmtiKgL6Z7yY613FpuauQnQPIAEgS5S/4rlE327+FS114Tr7fJl6cy4Ax9ocCr1iseZs/sVZ+xV3HeuKDSOK+F8WgsLstjKvNp4QqkRkB6cNkFivjDj0a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aj37+Djp; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso2756663f8f.3
        for <netdev@vger.kernel.org>; Sat, 06 Sep 2025 15:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757196152; x=1757800952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xbJJV3aAuTAvKTafHMaHQsqRWhlfXItSJNwL2JcXl9k=;
        b=Aj37+Djp3dx2VLWm3tG73uYZbT/w5HIfzH+GbUoTuRrL8KK9TUEta+cYX38WLxAn62
         EHbO/o8/MSYLPyXp7cNezwp+IoSPo3cCz8xMLAL47diewFN+xZkWrlwDgLQX2rnzjRZr
         bCwd6EQV206VdcvsHMwgdRzYvvNeFD37EE3DuTGP1IIe73WJ3UQ/AoSIXGLkcg/Zfq6g
         26+d/Splk3blD0gWW6u9ONgdv612nEV1Dc5EHG1AT+c8AFBrFF4lArS8w2nRA4ZYuCYn
         SFFQGg12GstUFOthSZrifQtY0yMy81dr/KwyfjZXE8jFnaIb4NvcBHoOGsNv/tIGStQh
         fPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757196152; x=1757800952;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbJJV3aAuTAvKTafHMaHQsqRWhlfXItSJNwL2JcXl9k=;
        b=SEtZql8+LymxbcSBDgroZz5K8atEMgj5xZ7aMoDTz3ldOAueidMbTDLqdv3hFJOk8P
         lUfIUcmyti5fabJXEQ47Bky3p1xBI1+bL9nTorv4JUkf1epD0VMpJ4HUmeFs8W73UT89
         UPVAtjMXLw1XbCkLdQIipyiF4M3TSDtWj43ELz03c2mxE5SQP5KxD4iJJbpM2QI7dWvy
         k5aDEWphLTfoXR2wXJ95ge3ZbcctcKZQB4YboV1BwO3TpPhN3mNGzDKBKWQQvOz9CA3X
         as6h+jG7Gb0atzLyi6ngb5gXqDL/Ag3Ckhna2U106w3oI+dmTeYCJhVpYoJeaOMZnfVX
         VHcw==
X-Gm-Message-State: AOJu0Yy8jmAOHB9Q6/Qxkoi77MqHe/T1tA8/uaZpCPidrS0Sv+GWWg5c
	X8Hw0Tp2PDfpWmU7KeQOCvGL2m6abmdyitJeVbpwJOKcLBufT8JpPjJU
X-Gm-Gg: ASbGnctsAKeNR4JFjWIr4xk3gk1il55R3+RAqRMeNFoGiKNOd/j8/tF/t1/ysOk7qYa
	t9AE7tKH1sB8qIUt/0ov9407cNklhyUneWlvY7rz7+VYJ6/oxzZy0gEafc97+ccosaRiIAnGpC6
	8bp3S3IS5clzRB3gLdleEPi4haUTxl90WQljKsHz0zm8BBAu+X+i+EsfGK9tYQbbWEOvj1zNH47
	7J8/kbBSsotoV9Sl1hDIj6zrmMDzd/PapN1GW5khNptb0F+AZTDPBb6COjrXo9VVCQLnXbIfwap
	kBLs+C4ZLC094y2YGfznkrXH6zssTlnh6OhzbVhCv8Ch1VdwWdKXKcCl4PzhHTEOYfdMML20YS5
	iq9gkGY3ierG4oUVK+CUFDAWnGRC3ukDnQXXd6bYIRc9IOfERuhATfBQG1yC6eb2TnIwQa8dWJu
	F7TY8hDQAeSU70VX4W5NPd7A+DGKtOdOmthxpxPr9te2euTUWIr1vLsNqntDIbeLHRtWq1r4xtu
	wLOtaPy
X-Google-Smtp-Source: AGHT+IEPVZ+MuoGHcxq5CjR8rZYNjPJi8aDmdnTrY906EeyCBIsPh1EjDcW40dcat6FL3wObGsYk/A==
X-Received: by 2002:a5d:5d05:0:b0:3e1:da2f:af23 with SMTP id ffacd0b85a97d-3e636d8fb4fmr1623566f8f.9.1757196151420;
        Sat, 06 Sep 2025 15:02:31 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2b:f400:f9ef:5bb:5d77:26c7? (p200300ea8f2bf400f9ef05bb5d7726c7.dip0.t-ipconnect.de. [2003:ea:8f2b:f400:f9ef:5bb:5d77:26c7])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e740369f1esm2235129f8f.11.2025.09.06.15.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 15:02:31 -0700 (PDT)
Message-ID: <664782b2-0ace-4bba-b28a-5ced2e35e5c0@gmail.com>
Date: Sun, 7 Sep 2025 00:02:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 4/4] net: phy: fixed_phy: remove struct
 fixed_mdio_bus
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <e81be066-cc23-4055-aed7-2fbc86da1ff7@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <e81be066-cc23-4055-aed7-2fbc86da1ff7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use two separate static variables instead of the struct, this allows
to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 50 ++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index eae513b70..0e1b28f06 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -23,11 +23,6 @@
 
 #include "swphy.h"
 
-struct fixed_mdio_bus {
-	struct mii_bus *mii_bus;
-	struct list_head phys;
-};
-
 struct fixed_phy {
 	int addr;
 	struct phy_device *phydev;
@@ -36,16 +31,14 @@ struct fixed_phy {
 	struct list_head node;
 };
 
-static struct fixed_mdio_bus platform_fmb = {
-	.phys = LIST_HEAD_INIT(platform_fmb.phys),
-};
+static struct mii_bus *fmb_mii_bus;
+static LIST_HEAD(fmb_phys);
 
 static struct fixed_phy *fixed_phy_find(int addr)
 {
-	struct fixed_mdio_bus *fmb = &platform_fmb;
 	struct fixed_phy *fp;
 
-	list_for_each_entry(fp, &fmb->phys, node) {
+	list_for_each_entry(fp, &fmb_phys, node) {
 		if (fp->addr == addr)
 			return fp;
 	}
@@ -119,9 +112,8 @@ EXPORT_SYMBOL_GPL(fixed_phy_set_link_update);
 static int __fixed_phy_add(int phy_addr,
 			   const struct fixed_phy_status *status)
 {
-	int ret;
-	struct fixed_mdio_bus *fmb = &platform_fmb;
 	struct fixed_phy *fp;
+	int ret;
 
 	ret = swphy_validate_state(status);
 	if (ret < 0)
@@ -134,7 +126,7 @@ static int __fixed_phy_add(int phy_addr,
 	fp->addr = phy_addr;
 	fp->status = *status;
 
-	list_add_tail(&fp->node, &fmb->phys);
+	list_add_tail(&fp->node, &fmb_phys);
 
 	return 0;
 }
@@ -163,12 +155,11 @@ static void fixed_phy_del(int phy_addr)
 struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
 				      struct device_node *np)
 {
-	struct fixed_mdio_bus *fmb = &platform_fmb;
 	struct phy_device *phy;
 	int phy_addr;
 	int ret;
 
-	if (!fmb->mii_bus || fmb->mii_bus->state != MDIOBUS_REGISTERED)
+	if (!fmb_mii_bus || fmb_mii_bus->state != MDIOBUS_REGISTERED)
 		return ERR_PTR(-EPROBE_DEFER);
 
 	/* Get the next available PHY address, up to PHY_MAX_ADDR */
@@ -182,7 +173,7 @@ struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
 		return ERR_PTR(ret);
 	}
 
-	phy = get_phy_device(fmb->mii_bus, phy_addr, false);
+	phy = get_phy_device(fmb_mii_bus, phy_addr, false);
 	if (IS_ERR(phy)) {
 		fixed_phy_del(phy_addr);
 		return ERR_PTR(-EINVAL);
@@ -247,41 +238,38 @@ EXPORT_SYMBOL_GPL(fixed_phy_unregister);
 
 static int __init fixed_mdio_bus_init(void)
 {
-	struct fixed_mdio_bus *fmb = &platform_fmb;
 	int ret;
 
-	fmb->mii_bus = mdiobus_alloc();
-	if (!fmb->mii_bus)
+	fmb_mii_bus = mdiobus_alloc();
+	if (!fmb_mii_bus)
 		return -ENOMEM;
 
-	snprintf(fmb->mii_bus->id, MII_BUS_ID_SIZE, "fixed-0");
-	fmb->mii_bus->name = "Fixed MDIO Bus";
-	fmb->mii_bus->priv = fmb;
-	fmb->mii_bus->read = &fixed_mdio_read;
-	fmb->mii_bus->write = &fixed_mdio_write;
-	fmb->mii_bus->phy_mask = ~0;
+	snprintf(fmb_mii_bus->id, MII_BUS_ID_SIZE, "fixed-0");
+	fmb_mii_bus->name = "Fixed MDIO Bus";
+	fmb_mii_bus->read = &fixed_mdio_read;
+	fmb_mii_bus->write = &fixed_mdio_write;
+	fmb_mii_bus->phy_mask = ~0;
 
-	ret = mdiobus_register(fmb->mii_bus);
+	ret = mdiobus_register(fmb_mii_bus);
 	if (ret)
 		goto err_mdiobus_alloc;
 
 	return 0;
 
 err_mdiobus_alloc:
-	mdiobus_free(fmb->mii_bus);
+	mdiobus_free(fmb_mii_bus);
 	return ret;
 }
 module_init(fixed_mdio_bus_init);
 
 static void __exit fixed_mdio_bus_exit(void)
 {
-	struct fixed_mdio_bus *fmb = &platform_fmb;
 	struct fixed_phy *fp, *tmp;
 
-	mdiobus_unregister(fmb->mii_bus);
-	mdiobus_free(fmb->mii_bus);
+	mdiobus_unregister(fmb_mii_bus);
+	mdiobus_free(fmb_mii_bus);
 
-	list_for_each_entry_safe(fp, tmp, &fmb->phys, node) {
+	list_for_each_entry_safe(fp, tmp, &fmb_phys, node) {
 		list_del(&fp->node);
 		kfree(fp);
 	}
-- 
2.51.0



