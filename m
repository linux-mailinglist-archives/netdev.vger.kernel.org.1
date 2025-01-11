Return-Path: <netdev+bounces-157456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BC3A0A5E4
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C081E7A17BA
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 20:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A68A1B78F3;
	Sat, 11 Jan 2025 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAwH8nVn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984961799F
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736627318; cv=none; b=DvUHBPMkjcAU+SWkRSQlEqhLgNn7LyK6vLP5d42VW3DiuEWotWXALmtiL5jLibrldPpLisHGK+Y1c2sZ7H46F1erfURsIChadedei9LLX6M4TTlTJvSCPjL2Sm/49BANsM7dCAo7msomCsCe2AbJeeb5Mb/JbKqNTC86LIS6nsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736627318; c=relaxed/simple;
	bh=1XlbVDi+vnVa5o8t6P7uBcBXhUBSSEMmPD5wYfBEAmQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jC5TcmibfRHNeKlG5MuYAKeG7uiC2RpUPTDl0f9YA2anyros5KdK/1GEt8CCGHSxQl0kCYklvc2eLAupF6/DmbGD4mALwrcGwwi62blptR/5CRtdwBfU5AHkOiuhokeNu43ZzI9N1AtVujDPW0+iN3DA3uh3kApglQg24VeIIr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAwH8nVn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaec111762bso573042466b.2
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 12:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736627315; x=1737232115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tp+I878Sd1xyWvAiGbomw4orw61Xs7egccmDYSvMAI0=;
        b=ZAwH8nVnYvIHobP61rlTHOYN2LQ664MmxcW5s8Udk5Ox19DCAy0pkVA1F7hS5mlIQA
         WNzyhmZBWi2QGvVijocn1WPn4N1r51yfMMA+FbbBRNZuQrzWEEO9FeYtExWHDRDpIr9x
         tZ0GkCDbLi7wqP/pySrVLLiRdz83OGgccd596j5HMTKBT87l+QJx4Tx7I79d+dSLdjK2
         +sUMcKauT3GzG72Di59FZBD7fz2mNZdhHHTdn/17pxx9zmQS7UDLcSEpkmW61WeBIIGV
         0hDTqN0nUfgkydHegnDpfKZzzilpKzoAiXoaQFpPLI5p59A0aaW6GLawBK+KP/qacTaQ
         HCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736627315; x=1737232115;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tp+I878Sd1xyWvAiGbomw4orw61Xs7egccmDYSvMAI0=;
        b=djtjQzTYxI2zv+TWJKr/vsd8MIhh7MWKN9eRHs88gi1zsrNSUJA5N2K71zdNRWO5jD
         u9C8s4Ei55kQ60z781BILvp0sXyYgf+Pi0PFpbO1xgDYdYyBVbi9QeR/5hqm+Azx4S1N
         FpG0lK0mfotZRkDtKiMhEzMQvXUagS6POAkueF62UL+56FjnP2SudeZX3z6UOJLRzkjH
         mOIYnemPvi+iVtZ39Y0CDCSg8YzPqW8sqReivMFSyhU235LUeJMRTr2NuIPK42FP9oyj
         WJBttce5O9+eoSY02KiAj2lMhWAAPqX7WczxXWnHZEsI0hWCBKBIoEcBYuG9CTiiyTQU
         5B2g==
X-Gm-Message-State: AOJu0YyTzUTYwjncZsVMFM9ouO3bw7yMWlhKFjnTshQRqQn3QrdXQNOo
	A19pXjgoUX+Zwt5DWaLipinr6NJey3Ste7TCO0rVKHy+Rg6LwOzI
X-Gm-Gg: ASbGncvzwR9oavL45Y1vsvNF6C3fICTHS17Mlsp+G2VzS+SeZaR5ZAU5vkqWoL+ID9Q
	UGWcVna3PeCUAvQvAAp5PvKj0YS6qJz13DidpMPVX6iJv1m3dalMXEX3PKkLHukPHOMxQ4gH3M8
	FmZ6NHg+HFt4PrLuvJyLxzbwSvdyVXzx5uJtw3QPMjdGyDpm/ziWtqC5rCPMuh1RPzevtO7Hg2M
	c8/Pccs1GGyuFlYunrkGP+GAE2R2hzHGdJPmOitHPaDAski34vJe/REwN1P3ltZsTu9zPZEvImk
	Jyu7AJ4ru/khoYzyuwccbA51qYbFlp8tUFiZQNwWGlo2FynCxs7nQQkn3V0qeLNYhPpKhd9cvBj
	6ypGmdgtPJ4rkgA+WWUHLVF4ZHAm+jUWnWonfqQSgwQdmxzu1
X-Google-Smtp-Source: AGHT+IHLkoI2UN8Kh6Bl/D8hePenZi6vpmrzGnATmGCb60H9NBAKtoGadN5cksUYRRQPwqz65FbR6A==
X-Received: by 2002:a17:906:f58a:b0:aa6:5e35:d72d with SMTP id a640c23a62f3a-ab2ab703f0dmr1377598466b.24.1736627314639;
        Sat, 11 Jan 2025 12:28:34 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c90d4f92sm307876366b.57.2025.01.11.12.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 12:28:33 -0800 (PST)
Message-ID: <d8d0b779-4127-4b36-80ee-6256ba425244@gmail.com>
Date: Sat, 11 Jan 2025 21:28:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 04/10] net: phy: c45: improve handling of disabled
 EEE modes in ethtool functions
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <90b3fbda-1cb7-4072-912c-b03bf542dcdb@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <90b3fbda-1cb7-4072-912c-b03bf542dcdb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Currently disabled EEE modes are shown as supported in ethtool.
Change this by filtering them out when populating data->supported
in genphy_c45_ethtool_get_eee.
Disabled EEE modes are filtered out by genphy_c45_write_eee_adv.
This is planned to be removed, therefore ensure in
genphy_c45_ethtool_set_eee that disabled EEE modes are silently
removed from the user spaces provided EEE advertisement. Add a
hint to the user so that it is done not that silently any longer.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- silently filter out disabled EEE modes
- add extack user hint if requested EEE advertisement includes
  disabled modes
---
 drivers/net/phy/phy-c45.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 468d24611..d5b5531cd 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1525,8 +1525,8 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 		return ret;
 
 	data->eee_active = phydev->eee_active;
-	linkmode_copy(data->supported, phydev->supported_eee);
-
+	linkmode_andnot(data->supported, phydev->supported_eee,
+			phydev->eee_disabled_modes);
 	return 0;
 }
 EXPORT_SYMBOL(genphy_c45_ethtool_get_eee);
@@ -1559,7 +1559,12 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 				phydev_warn(phydev, "At least some EEE link modes are not supported.\n");
 				return -EINVAL;
 			}
-			linkmode_copy(phydev->advertising_eee, adv);
+
+			linkmode_andnot(phydev->advertising_eee, adv,
+					phydev->eee_disabled_modes);
+			if (!linkmode_equal(phydev->advertising_eee, adv))
+				NL_SET_ERR_MSG(data->extack,
+					       "Requested EEE advertisement includes disabled modes\n");
 		} else if (linkmode_empty(phydev->advertising_eee)) {
 			phy_advertise_eee_all(phydev);
 		}
-- 
2.47.1



