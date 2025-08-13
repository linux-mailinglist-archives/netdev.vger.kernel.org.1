Return-Path: <netdev+bounces-213482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C67B253CC
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 21:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DE057B9E7F
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 19:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BAA2C1598;
	Wed, 13 Aug 2025 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fo1/0UHa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938C41DF725
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755112669; cv=none; b=KvUwMB7813P959PLV9jtL3U+Tysan0a42T2A861Z54kPfMXnWHCnQC6/Ra5L/HMz+Oe3ywoS9G9xH+rhQQxHmbp6scKwg/zTWni2sYE+1aAToFG4Qnu8jpJ3W1OXjTVCj/heuCzmqkX8+bPY0PRktjOY8Btcs6fOTA80+nnC4dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755112669; c=relaxed/simple;
	bh=Jv4R/1ojs+erZo4nguIC1hZEe0m0M0dhMVM5EWleJP4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UcGkyFcDHfTwjrXDZPnO+9lx5DtU0W6B/kH0h7u2/2IdjyoLTb1vis+jsIU6jBvfDtoI+obNqWWqxxCViS+pO7rBIb/ra3sMiL6FMSG0GeoxsZEbS0ahZ57+pjX+LQgiEOWqdTbyINZBeU7cTao2FTZQEedK0gLVMyTNIwzTAI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fo1/0UHa; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9d41cd38dso119749f8f.0
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 12:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755112665; x=1755717465; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnaszafwEdn8EJGS47qRsR/kQPTjU2M3f5Q9ParkCgM=;
        b=fo1/0UHajy6ecE2XCac4zIqtUHOdYqMafEQNau5HHLxEjs8d1FLcaoJK7x1uXcbm7u
         MC6/YNvMplO44f9SV3e96ichyo7ifYj4MS4S9OHJxJ4DQ2KMzUEtpNo0kuT4BGQZkNYS
         8W2QCpdb+m7ZVoTTgAZLxBfShhhU5QHAkFXYFvvihMni7E5FOHDIlfGio2L1fABe6KjU
         oPumyvlcQjlc+i7tayqurH+j9xzFM6DjJmqzloYvpw9czbUp2x0bqCWvj/D1ElUDt1ec
         ZJEyFgN7QyJZDbgkY2PO+wflgEewDsaHnywjpm+4dmf33mANl3/qh2gQqn1BRdnZUq48
         ITUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755112665; x=1755717465;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnaszafwEdn8EJGS47qRsR/kQPTjU2M3f5Q9ParkCgM=;
        b=V8P5YSiV0TUVRPTD0+D3Ft8KswuityGyL0enK+iCrKAoUlC6zlYL/e44+4nqFYtQE3
         FVql6K8MJ9XehFTIaJoAn7Y7skWAMqkXvrRwjLhdCIPqO1hQQpMOlq7hfwUaunXI23LV
         x0uIStqNwlpUao4PO3Cz/Cm325uelFtlDAks5bOnZbIM5xTxytcvVQo5zt3MMriQHQu/
         bgtn3Nh+Idzzwdwfj0KSzu+I5zSL1NcSvpcApL19PW6aPPrDh3DoH+X18iGghrX+0Juy
         jgeUMuqioL6G2EXruQ2FofR4xu1FNNdPT1G+F/jKgIy71EMQmOF2M3NZcjwwvk0U1hie
         ArVA==
X-Gm-Message-State: AOJu0Yx2JbC8B/3jWqN8TljgfmLtl9CY++EgOvUIBK5ninoAOg/brczx
	jZIcAq+9b1Rsx6QX7kKkggVXNvc6DmUWZdvTWEgHKD2Q4x/phnBsAVB0GPc0vw==
X-Gm-Gg: ASbGncvbaNoQIQRn2IP0NzAidNRvp/Z8GJBJR/jcte1RqKBa4BU9/ODo6qtYk/lvFej
	8qm75aHlmDefcBV5oxHzgY3ZI81i0m26uY2Pji7ZDpCALqQ312RINPfi1piwpVeOdfn+tfXguM5
	uIML2uObDVfAGACJrVgsZoQrENcSsnj0n4joUEY0tjlI875lnrBFd6tKoML56tYX1b5ODV+D3uI
	HPzjVYkeyeKVUuPNjVJZNXgmoXiqnmtNNOa5k3JWTEOZk/OBakKOI8xTPHd0/qEpa6mMePZAfA7
	Bjfu/NFjA+GXhLkz34A+EJm3ok1UDm2O0xERupj63NeNH+prxSf/yLI9ijZO7LTEbJPvUdyt7b5
	+06KYDeU7VLhEEzhHaUDusqdsQU5NxUGhyxwnYo4UEJWk2+tZdQNgSbE640zeKu2bvZKqRnlDvD
	uPMJLX/2Vb98YuJi+O/D1uXmv/sex+8VLqjmVLDGEMSFveuiHMpZTmkRjLF2EsEw==
X-Google-Smtp-Source: AGHT+IGb6s1IJk/llzIEgo6VGTp0a5ZvZsuNwQuT8J9+V/9Dj8wQPNHEqTpPt9Sei9vqCn6d7M6WjA==
X-Received: by 2002:a05:6000:420b:b0:3b8:fa8c:f1b3 with SMTP id ffacd0b85a97d-3b9edf7dba4mr294308f8f.53.1755112664533;
        Wed, 13 Aug 2025 12:17:44 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2b:3400:f085:464c:19c7:a707? (p200300ea8f2b3400f085464c19c7a707.dip0.t-ipconnect.de. [2003:ea:8f2b:3400:f085:464c:19c7:a707])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm47424886f8f.55.2025.08.13.12.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 12:17:44 -0700 (PDT)
Message-ID: <e9426bb9-f228-4b99-bc09-a80a958b5a93@gmail.com>
Date: Wed, 13 Aug 2025 21:18:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next] net: phy: fixed: remove usage of a faux device
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A struct mii_bus doesn't need a parent, so we can simplify the code and
remove using a faux device. Only difference is the following in sysfs
under /sys/class/mdio_bus:

old: fixed-0 -> '../../devices/faux/Fixed MDIO bus/mdio_bus/fixed-0'
new: fixed-0 -> ../../devices/virtual/mdio_bus/fixed-0

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- don't remove label err_mdiobus_alloc
---
 drivers/net/phy/fixed_phy.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 033656d57..8ad49dc11 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -10,7 +10,6 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/device/faux.h>
 #include <linux/list.h>
 #include <linux/mii.h>
 #include <linux/phy.h>
@@ -40,7 +39,6 @@ struct fixed_phy {
 	struct gpio_desc *link_gpiod;
 };
 
-static struct faux_device *fdev;
 static struct fixed_mdio_bus platform_fmb = {
 	.phys = LIST_HEAD_INIT(platform_fmb.phys),
 };
@@ -317,20 +315,13 @@ static int __init fixed_mdio_bus_init(void)
 	struct fixed_mdio_bus *fmb = &platform_fmb;
 	int ret;
 
-	fdev = faux_device_create("Fixed MDIO bus", NULL, NULL);
-	if (!fdev)
-		return -ENODEV;
-
 	fmb->mii_bus = mdiobus_alloc();
-	if (fmb->mii_bus == NULL) {
-		ret = -ENOMEM;
-		goto err_mdiobus_reg;
-	}
+	if (!fmb->mii_bus)
+		return -ENOMEM;
 
 	snprintf(fmb->mii_bus->id, MII_BUS_ID_SIZE, "fixed-0");
 	fmb->mii_bus->name = "Fixed MDIO Bus";
 	fmb->mii_bus->priv = fmb;
-	fmb->mii_bus->parent = &fdev->dev;
 	fmb->mii_bus->read = &fixed_mdio_read;
 	fmb->mii_bus->write = &fixed_mdio_write;
 	fmb->mii_bus->phy_mask = ~0;
@@ -343,8 +334,6 @@ static int __init fixed_mdio_bus_init(void)
 
 err_mdiobus_alloc:
 	mdiobus_free(fmb->mii_bus);
-err_mdiobus_reg:
-	faux_device_destroy(fdev);
 	return ret;
 }
 module_init(fixed_mdio_bus_init);
@@ -356,7 +345,6 @@ static void __exit fixed_mdio_bus_exit(void)
 
 	mdiobus_unregister(fmb->mii_bus);
 	mdiobus_free(fmb->mii_bus);
-	faux_device_destroy(fdev);
 
 	list_for_each_entry_safe(fp, tmp, &fmb->phys, node) {
 		list_del(&fp->node);
-- 
2.50.1



