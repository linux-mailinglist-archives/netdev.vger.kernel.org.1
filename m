Return-Path: <netdev+bounces-218513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4ABB3CF11
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 21:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9C616A33A
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 19:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C202DE1FC;
	Sat, 30 Aug 2025 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFa3D3Vy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77482255F52;
	Sat, 30 Aug 2025 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756582332; cv=none; b=lWsa/pSpH+Eh2SlyMJBuft+5rpbtICZ6+VCxiVCX28XK/T0RQNz6NI6GYRtMShqnBaxyWR66yzFiXJE4ml1nLg9RataDuVgNGwwfPyguzrjfLUYpDLKtAmgAkuelQrLWEhl2Cuekb0T2i3dw7yr8shkc3/uHarUM4FCLzy9TGDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756582332; c=relaxed/simple;
	bh=DPI+3qXhLHPrHXps9sBC/idDylCwXQMMcO8R1JUhvpA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Sn72hbWFOKhpL4yyhVzQens46UdWVkcxafEnVDFnKqJQp+IWeQWnajk8jDEqmJFPWEliQ75J1ixYNwwHGsK6JeGwH0rkUO6xTNIzMFO4JFod4o7jyiQmg43pusAfi14IVBjBtdhPeNeqy8x1MZ7o9OOJM6wsrcqJnGO8wsZF0Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFa3D3Vy; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b5b113eso4115912a12.0;
        Sat, 30 Aug 2025 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756582329; x=1757187129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zW9iMTsNFJqzaVU+9Umz/LvOS9lH5xEq/8s2G/XEJxE=;
        b=XFa3D3Vyq+EWdIG9swC5SJiHBbdbFzbzcSeMLQARMo9xWghoGjBL6DNcz8g7q9JwEY
         UyTYoxt9BNgHTirO0jiXlbYAZrnDJntkLnzhjrbYMm/3EzYe77mT9p5XdI0GYru1lVvj
         0CZe6mJT9cw0fsJoQ3AOPDVyZAGj+Jfd6R1wmXw6/E/0kgpOt/ZVHG2Wzro25YGEUnP9
         iVrr+hkG38NY87Lcmo0QsO4yep+1q6hev2Wc9mdjomzGZLOFl4rXugnJ26ljsYaMkDiP
         yd2cDE7gsL8uKHrRTO8ywenVaF6MnTTl8qvFD2kZUE2cQG16G9UXylA8Dk4H4yFL3iLL
         cYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756582329; x=1757187129;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zW9iMTsNFJqzaVU+9Umz/LvOS9lH5xEq/8s2G/XEJxE=;
        b=R9eTmYnOdRhwQ4nmEqk8ZEYHpdf8nuikfY62vZk64y+7gbh6/ZaZb45MRBPvcgbUwK
         61k4wAchRpKspyVHy2fb6ZhLan6Pr0A8qsf4Jh75gfL8YUvzaBniCIhreLT9nrjy9aW/
         UaHNI+/xrebp0tKbPYtnAZV0YZx9WczXgZmB2K9lDp0FNdxt6olKxAztq3BUCVsNr9Oo
         FenFSypcOuPWOEdeMuv1CCHv6dz9+CqML3KCrWTt1PRIz1knG6E3JQuEvK5T8TRZCSY4
         PXw8gEbOBdh03L3GwkdZdShFkB/T+8O7dhzPYNKGaKgtnRPSc+1JZ6BUqYbO/nze2NSf
         gXmg==
X-Forwarded-Encrypted: i=1; AJvYcCUzCwFXNqdu1Gqax2spUKO25rwhdq9kn08vZ4L1B42nhsSuTjbN2KOrY/ZE1G0IMkstzRW8o7CVvIqE@vger.kernel.org, AJvYcCXKimPMYP3ewjYiyzJ6oCO8kHCbcBfkQsxrGCwX4rAbFaJ5IEWxZubyHn4AKI3u3KRiFnBkkoYa@vger.kernel.org
X-Gm-Message-State: AOJu0YwPaME0LzWcPzP2ALa5X6fVElpP/1821IjVPLa9iQvX06GyuQYV
	dUNuauV6tJNSbz5sd1qyR2fWRVMbp9kF/yGRUDhVUDOLBEmuSAnrFSoi
X-Gm-Gg: ASbGncufb/Lz5bWEMl6zaYClATmukTe6Qy5ErUgLOVodoa9YMCu2sqbJGRwsHhKfTRg
	rREGN1NxYpxfDxOwQ3hg7YNEykI8fAgyM/KRNqED6xP7rYxc74cU13UiYTipONeaV6KPpmufO0E
	Ub2GkkoFc4YEO1Pc4m40bbq0IkW2dDxuiXSzB1iIqYkU5shScZ0nGcry/XA0pUBxdkg2oeELJAv
	ggC7gEDPYtampYqA8zoJSE98phK6+FHEW2ooNe+scAu/f+LIVk17sbZ27B8VzQ+auk9eknwMmJi
	P9J1b92DD4xDeTtoDkyTgy2b3xtyrAhgkMTV6e+xNbFoLtMxfE77o7wiV1ptgxv/OcF8SX0ryzH
	vcEWIOkLtkNXEuU7rKt1B9McpLQUQesDFE1oFEUPgrsEaq9t3oYQH46wz/13C5K/k9Mf69hLiaP
	BkrGAH573z1ikFMtQSgPhLl2qs7xsyKUjnR5T55Ymxn5LQPYd2/VM0x4u/AF8HMzpOACaYviDp9
	h1LUA==
X-Google-Smtp-Source: AGHT+IFrk1LXoK3vtbVKyySU0eF8+oT1juSPvm5Mwgv8TIAz4C4y5vspb/wDpo57jnVmRrAhuQhiKw==
X-Received: by 2002:a05:6402:3810:b0:61c:fb8e:ab81 with SMTP id 4fb4d7f45d1cf-61d26fe5d4fmr2460830a12.25.1756582328554;
        Sat, 30 Aug 2025 12:32:08 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2f:9b00:d113:449:b8c4:341? (p200300ea8f2f9b00d1130449b8c40341.dip0.t-ipconnect.de. [2003:ea:8f2f:9b00:d113:449:b8c4:341])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc22b594sm4172371a12.21.2025.08.30.12.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 12:32:07 -0700 (PDT)
Message-ID: <227dd76f-4170-47d2-87ab-932f9f38ad1b@gmail.com>
Date: Sat, 30 Aug 2025 21:32:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 net-next 4/5] net: mdio: remove support for old fixed-link
 binding
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <cd55d7fb-6600-49e5-a772-18b39811b0d2@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <cd55d7fb-6600-49e5-a772-18b39811b0d2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The old array-type fixed-link binding has been deprecated
for more than 10 yrs. So remove support for it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/mdio/of_mdio.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index d8ca63ed8..5df01717a 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -379,21 +379,12 @@ struct phy_device *of_phy_get_and_connect(struct net_device *dev,
 }
 EXPORT_SYMBOL(of_phy_get_and_connect);
 
-/*
- * of_phy_is_fixed_link() and of_phy_register_fixed_link() must
- * support two DT bindings:
- * - the old DT binding, where 'fixed-link' was a property with 5
- *   cells encoding various information about the fixed PHY
- * - the new DT binding, where 'fixed-link' is a sub-node of the
- *   Ethernet device.
- */
 bool of_phy_is_fixed_link(struct device_node *np)
 {
 	struct device_node *dn;
 	int err;
 	const char *managed;
 
-	/* New binding */
 	dn = of_get_child_by_name(np, "fixed-link");
 	if (dn) {
 		of_node_put(dn);
@@ -404,10 +395,6 @@ bool of_phy_is_fixed_link(struct device_node *np)
 	if (err == 0 && strcmp(managed, "auto") != 0)
 		return true;
 
-	/* Old binding */
-	if (of_property_count_u32_elems(np, "fixed-link") == 5)
-		return true;
-
 	return false;
 }
 EXPORT_SYMBOL(of_phy_is_fixed_link);
@@ -416,7 +403,6 @@ int of_phy_register_fixed_link(struct device_node *np)
 {
 	struct fixed_phy_status status = {};
 	struct device_node *fixed_link_node;
-	u32 fixed_link_prop[5];
 	const char *managed;
 
 	if (of_property_read_string(np, "managed", &managed) == 0 &&
@@ -425,7 +411,6 @@ int of_phy_register_fixed_link(struct device_node *np)
 		goto register_phy;
 	}
 
-	/* New binding */
 	fixed_link_node = of_get_child_by_name(np, "fixed-link");
 	if (fixed_link_node) {
 		status.link = 1;
@@ -444,17 +429,6 @@ int of_phy_register_fixed_link(struct device_node *np)
 		goto register_phy;
 	}
 
-	/* Old binding */
-	if (of_property_read_u32_array(np, "fixed-link", fixed_link_prop,
-				       ARRAY_SIZE(fixed_link_prop)) == 0) {
-		status.link = 1;
-		status.duplex = fixed_link_prop[1];
-		status.speed  = fixed_link_prop[2];
-		status.pause  = fixed_link_prop[3];
-		status.asym_pause = fixed_link_prop[4];
-		goto register_phy;
-	}
-
 	return -ENODEV;
 
 register_phy:
-- 
2.51.0



