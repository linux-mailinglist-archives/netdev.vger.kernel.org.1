Return-Path: <netdev+bounces-174739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A57A6017A
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 20:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD4C3A71E1
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 19:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13DD1F30BB;
	Thu, 13 Mar 2025 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwKMzrJ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90C11B87F3;
	Thu, 13 Mar 2025 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741895061; cv=none; b=a4pcZmu9WU7J5yQO9+sPn8XrpcuZkriGl8Kl07wS2QOrMawrDiHw9NtVfmhc93dX6IHdV7yzeteakZQPoU7Mub+iJbM4KLgapN/ugwIWNIyV/X7ztvwgH+b29ccgcuZqB9N3CYY9QH5+Iy773PzlI+E5uA2lxgPmCbjRWgpp9Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741895061; c=relaxed/simple;
	bh=fcUs4J6HnyEQCz3pNZr/xrPsSdjRkmB7msrVYJIg15o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UwYgXromKijNn6179LO5VKmaLL7yUcXXhsKkSQbgO0CNeI10E+q9yukbl9L8zFI6RAwnnKKQhQ/hHB4LhUJLl7n86RuQuJ1FGZBUjqtBxtO4c8xUuhUgrlfD0UadgyW09h7xcJcAvunGbLhrAUYDe7D7LLCn0TK2BO9nWarbexI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwKMzrJ5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf848528aso12718185e9.2;
        Thu, 13 Mar 2025 12:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741895058; x=1742499858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cPISoPsQNoKlH4kVSY2gW6oUddXOC3HherLwg6HNHo0=;
        b=PwKMzrJ50t7BIzwramCoAImwANc4383rVztut4SjpuOQXBLgcRkr3j0+hrjhKoanTp
         Njpw0VQmkIBSMX03lOROTVAKfINvjry+ba5QKe/1BDpGAuKjnt8/LqHUU2NdcTmJRDZn
         tKX/VbgZzcykUHNVrWS/VALW7OhX2KRVvC6ShbtOOp/D4HGASChdt60YWO1vR1LAnFdS
         lrLKWYMbc0Kc4cGKrBcFeg/CNbCktZJbc/5MisY80kSqlynUKH18kofnSQSCRr8LJsVE
         C1zPMBC5UHQZh61pQ71QDr3by4k8ZzIkIXVZhc6HUwLNwdhSzfgiF0F7CKMbCHot8AVW
         Izbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741895058; x=1742499858;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPISoPsQNoKlH4kVSY2gW6oUddXOC3HherLwg6HNHo0=;
        b=ls8+7yUw7i0lFxMkLbGqau9TG23UsRIpskNCTE5jif3us6P9+rlj5kTEfKiG8eiKx7
         YWLPO+Pt8mrqNjg3Drt1/SONYwK3Y+2lqmEKPejxfQBU35fHP6iQ6xSno6u2ryfY4y1P
         ee/L5jilREiTjVUMMBTRXsJzbf0yDUfmSYgODO+Uv2rJ2sIEzqFvqohf3M06M/inw7FE
         NoLmL/tDzc0l6M7Uz0QCF26NUANB7cqRRIEdxZIL+5FskvmBo04N6pYcarhaHhAIEhmY
         UvwzuGuc6oG28zsC5grHb50ASdrGVt6PTwMfH854Yc6Rl1BImOYF3DWjV63YALVL/n8A
         V0nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnDiPs7mnrx3+e8k3nzm1xOdcEG5xHNo79L8dhPMp2bmzZFhwYqQ1qZK+bsrTumd58Lxj5j8sCzA6mwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YySK82DhgPRwvXEGrPsVK1r+V6AX9iQhT8FUWFIOGa9/alwvZt4
	VmXVfagEL4Ra7EqGGhqTPB4dntTrPKRCG3QOgG7FyjIKoaMRIBfI
X-Gm-Gg: ASbGncsVqPp8o0gsLhWgtgwL6Rkg0zoQHBB5ByLZ/u9uEAQb3a9BD8OvttFB+5Bk3bC
	bR+lo5GVPjMy82H6BRPthqwadWH6UFjuPAAdEIQpvRRbqtxnsXofsU4oqb0LXppMsN9FgVlL9J6
	lQgveHwYfPOUy2GNh1pLleyDh2h0auWroCRMyUN+M/SFbBcCVz+zqm9kR0lx7zoGQyL1UzKT8ml
	daK6h+NXuOWEnIImeUYjDimBAFWsBQoIhVgffJbtd1GnJQqr72lO6zx/cS9pFspwca30JCfqqyf
	VMSMlaCZdaarSp72l9Dtb2NPF83mmAaIvixO4pr1pkRGTZcohIy7ZB7/IA4cOMkyd5aRXkNIupR
	iqmfaMGMpONsfkRX96TmrN7qSM8Y7SzwZ5uYPmz3lRlRH6b6G0gq9+q1h+9LGWrj8PMGYVluelv
	24H4hEFvXIxw6iZOolb+IuN220z3tXi9Ju+oxy
X-Google-Smtp-Source: AGHT+IHJlroWGyDz5iqUSMUEAdP42obCSu7Xwd8gD+XAU/rLEejrJMenpJJFXiIwUb0oxVbEUDrMnw==
X-Received: by 2002:a05:600c:3b1e:b0:43c:f969:13c2 with SMTP id 5b1f17b1804b1-43d01c22a0amr116625765e9.28.1741895057796;
        Thu, 13 Mar 2025 12:44:17 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9d92:6200:9d62:fd9a:43ed:7e78? (dynamic-2a02-3100-9d92-6200-9d62-fd9a-43ed-7e78.310.pool.telefonica.de. [2a02:3100:9d92:6200:9d62:fd9a:43ed:7e78])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d0a8c5ccasm62791535e9.26.2025.03.13.12.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 12:44:17 -0700 (PDT)
Message-ID: <6e8d26f4-8d0a-4c83-aec3-378847a377eb@gmail.com>
Date: Thu, 13 Mar 2025 20:44:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/4] net: phy: realtek: remove call to
 devm_hwmon_sanitize_name
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Xu Liang <lxu@maxlinear.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
References: <198f3cd0-6c39-4783-afe7-95576a4b8539@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <198f3cd0-6c39-4783-afe7-95576a4b8539@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Since c909e68f8127 ("hwmon: (core) Use device name as a fallback in
devm_hwmon_device_register_with_info") we can simply provide NULL
as name argument.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/realtek/realtek_hwmon.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_hwmon.c b/drivers/net/phy/realtek/realtek_hwmon.c
index 1ecb410bb..ac96e2d1e 100644
--- a/drivers/net/phy/realtek/realtek_hwmon.c
+++ b/drivers/net/phy/realtek/realtek_hwmon.c
@@ -63,16 +63,11 @@ static const struct hwmon_chip_info rtl822x_hwmon_chip_info = {
 int rtl822x_hwmon_init(struct phy_device *phydev)
 {
 	struct device *hwdev, *dev = &phydev->mdio.dev;
-	const char *name;
 
 	/* Ensure over-temp alarm is reset. */
 	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSALRM, 3);
 
-	name = devm_hwmon_sanitize_name(dev, dev_name(dev));
-	if (IS_ERR(name))
-		return PTR_ERR(name);
-
-	hwdev = devm_hwmon_device_register_with_info(dev, name, phydev,
+	hwdev = devm_hwmon_device_register_with_info(dev, NULL, phydev,
 						     &rtl822x_hwmon_chip_info,
 						     NULL);
 	return PTR_ERR_OR_ZERO(hwdev);
-- 
2.48.1



