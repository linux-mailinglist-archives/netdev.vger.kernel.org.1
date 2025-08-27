Return-Path: <netdev+bounces-217438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D56FB38B34
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 23:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD89361472
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F36255F39;
	Wed, 27 Aug 2025 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3SWNnLL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17011A295
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756328575; cv=none; b=buXchQsU0cCKa7wYbc0LHL/R2+jCxQRs2Xv8sSz3BO63kz04Z/DSoZL1hlf9B3WGhyJ9bSf3eJrMmMCBTO0Zp4VWzWuVLYW+LHRHgBLhstToOpF/q0CNkcu1sEILTciMLyAnhIe9kWvQCaoJ628pgohbgbc8LkRwK5cnFn2pKdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756328575; c=relaxed/simple;
	bh=UOj8aCQ17rx2Bo3zQWBverJ9/iQzwPUkbnsGZbluDWA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=I/NNn2V7jXNpCZqL4zA+mm341/ZxlwgzFNsEAtUllkUzZPYAsgTdazfIuYiAGWRV9XD4p1dklyQQGu2l+HYmQw4dzC5it6rUQ77seRWWVtzx6uIcZUGd3lHgz2jJfMPFUZQZM5PMWvnsCXT0elgylXQUTKDvKrW4w3Du46ZUo1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3SWNnLL; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3cdfb1ff7aeso20668f8f.2
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756328572; x=1756933372; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hQfZpkHyZFshh8VMiAFvlK9H1QYapDU4tCdJ/mqdBFA=;
        b=S3SWNnLLUvgSeR0BqTlpvt7X9DRDz4lWpvJUXgCslS9e3V/H/Oth8WPoO4yq2Oes/G
         YQAlNNVNAM1doRXk3n4B/XPvav1gG4mXrMPJr5uNk/zAGl8BWT2vG3pb6Pbec4w23gfH
         SB+x3eUQd/0O2ZXUsujMJxq60v379jG18aoxa0E1NPjGqSYs7tdHCe1LUVMw//p0osuk
         C4Yhej13TWmiw+GsSvl7E4puZmJtgmecBP4faoLPP1V3KSBKwPz5vyiYJHHdjiFkj1xI
         Z9toXB/UR1zt8MDFAEPkKvJjDPSraWOSXmd0MkfQVhlcPLU2rz4TdJSztQB9oWvO3X8n
         eJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756328572; x=1756933372;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQfZpkHyZFshh8VMiAFvlK9H1QYapDU4tCdJ/mqdBFA=;
        b=OwsVY6lGqwEeHxL1xpKw2dpCcnMGK6VoIrB1JSZzZFr2VEhE9rOnZOXtDxe2eu7+kO
         gp/k3fqqqC7nl+3ndmArCor2zyiVOBS39DFkyXCWTXm4O4G/bFonf674nfofYJ1ISDG0
         aAFiViSCEbkI8cp+E9vj1O7mat8VfKJjUHJTzpm2TM0/5dHO14mLlUrhF3P+VrAphUGQ
         hr7yYLTA9vUAcmQbBYVuuUr4M8UfYfRrj4UfKVwXcGlruIzpJb8vJC06ZsdYZkMIY26V
         cJlnFNSud6pGUR7OCv1thXtJV34maoIyV1t9r5WQK+TJzypjPTz+FHCyCcLRWAPpqw8w
         iWSg==
X-Gm-Message-State: AOJu0YzpUC+H/v5GEX4rTiDlLzMuqhnKGWlBJN6P4RNskLuGxGw377wO
	BzNyfAUmy8DVfQucXQx1OtHU9xOIzPLKLvqBhYmrzJxAKfzR3H+jeDA2
X-Gm-Gg: ASbGncvDS1KmpZJWe0jB9Vk6i8/1babb/m/X/GKKlugSSrbaeWUOcJ4RJbhwyWp1n3c
	wk4DA9sgE4paHdmP7qivA69V6Mbuc8tvNaCE2okVKF7X+WokwRFjOdAHU8z6pZ7Aoo/7RxsyuYw
	wPGhWcDuqpaqcr5gG0+ahhu1LB9LxtGXnQbv8LTMCPoq6wV+BC3CFU9jL/QU7paFUOyXJE2Ofms
	1KXFqSnSydV2VNBGu/TKkbSGx/i21QCxev7TxOCMHAyhC3Xj9w5rtmumMqP0D08dGgNQ8y/3ya3
	+Falnq8cO90Mqx6hMC+mYDDN4R5reRXWHsMCyl0oukawfttXIiduawAnLDVGPRKwy0sg6Y1pvQF
	2WxqwdWbvOEY6lV9FGKegYsguTt0WAf2hpPWF9iUnc7DKkUsN9XRtfGiQXTrSYydRUukbV1jjL6
	iTxevWYhCtRv4oM72oG+wy6o1nViAOuJjiGGk9jOiJWYC/nmoo26VmY0nkNQzjpQ==
X-Google-Smtp-Source: AGHT+IH4jfhj7rPWO0xyufUHMW2QtkaK9msObBorzsBOseWRUGRKp7HiCzPep/qLIqPF4CyWBg6xTg==
X-Received: by 2002:a05:6000:238a:b0:3c7:44eb:dd67 with SMTP id ffacd0b85a97d-3c744ebe06dmr12601688f8f.61.1756328571751;
        Wed, 27 Aug 2025 14:02:51 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f31:dd00:bc79:d64a:f2ec:1eae? (p200300ea8f31dd00bc79d64af2ec1eae.dip0.t-ipconnect.de. [2003:ea:8f31:dd00:bc79:d64a:f2ec:1eae])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3cd0acafd09sm3247001f8f.31.2025.08.27.14.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 14:02:51 -0700 (PDT)
Message-ID: <b3fae8d9-a595-4eb8-a90e-de2f9caebca0@gmail.com>
Date: Wed, 27 Aug 2025 23:02:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 net] net: phy: fixed_phy: fix missing calls to gpiod_put in
 fixed_mdio_bus_exit
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Cleanup in fixed_mdio_bus_exit() misses to call gpiod_put().
Easiest fix is to call fixed_phy_del() for each possible phy address.
This may consume a few cpu cycles more, but is much easier to read.

Fixes: a5597008dbc2 ("phy: fixed_phy: Add gpio to determine link up/down.")
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- rebase for net
v3:
- add missing blamed author
---
 drivers/net/phy/fixed_phy.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 033656d57..a1db96944 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -352,17 +352,13 @@ module_init(fixed_mdio_bus_init);
 static void __exit fixed_mdio_bus_exit(void)
 {
 	struct fixed_mdio_bus *fmb = &platform_fmb;
-	struct fixed_phy *fp, *tmp;
 
 	mdiobus_unregister(fmb->mii_bus);
 	mdiobus_free(fmb->mii_bus);
 	faux_device_destroy(fdev);
 
-	list_for_each_entry_safe(fp, tmp, &fmb->phys, node) {
-		list_del(&fp->node);
-		kfree(fp);
-	}
-	ida_destroy(&phy_fixed_ida);
+	for (int i = 0; i < PHY_MAX_ADDR; i++)
+		fixed_phy_del(i);
 }
 module_exit(fixed_mdio_bus_exit);
 
-- 
2.50.1





