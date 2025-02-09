Return-Path: <netdev+bounces-164464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D814A2DD88
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 13:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FB016132C
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 12:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD0E1D934C;
	Sun,  9 Feb 2025 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoHLlxMv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EA71D90DD
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739103142; cv=none; b=cMmRkKExGid51VSxSlGBWkxLbIUZo0nEvy5F4xhQnBx497lixmn7G7vFkjlN3dBGCjBxd4yJNl9JezMmzhvJ1jS1PQKVk4BxSgKkOi6lLt8R/dfQ0W6kW0LDHTgutQRtLQYPbwlRkRShjNQ6JBwTfvhZd58hRPOLZYar0YzqadE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739103142; c=relaxed/simple;
	bh=VgBacbJBOm8NdbGi5F1saMG5IONKIe65KydEpkXU72E=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uWlhlb/hgHyvAcuvggiBonafhplDNVmTBwaR5QXFTv9XraEslBzbvDxCxEDMNLUj2rP2JeC4siF3QQmAIM8EhmCKsmRbv8USEoDIGBvMp7y7Q/pMBhx2uYKzDvJtps0Kw4DR/dl8Fdtoh7nFngGckRapYysfAcHZlcR9e07VtdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoHLlxMv; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dcef33eeceso6538279a12.2
        for <netdev@vger.kernel.org>; Sun, 09 Feb 2025 04:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739103138; x=1739707938; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oX5DMuzX5DVPwIQtGMs5kpdpSLvAD3DOntPnxjTmbwg=;
        b=YoHLlxMvP+A+F/4odCLZ/YE8yODViFvJo6pKH6LnnXl8rtljUeez3Np6ak4us3y559
         IdYvbFEBcPa/dDM8slous2JiVFFSCv+QT1cWpxINF5Ft/+XrEJlv/lb1gyHCDVKLHtmT
         PGbYYEd+UCPRY+HJLxkbptJ2EkaQ9EOEz/RBLI4ISGF/KIt2WiQUtD9YJoMbMqu2t/rn
         I5EczTK+sOhgTa15u72+NUnK5eltg0S2KQ7L/PqVP3hyIcs3Yyd1Q+L/f3iuK7I3lqTc
         +remhisSuE7g1NvG7GsUc/VAlH9+kdfYWlZjfq7oVLxNNI6QNzFgDBF7MhdwKRkIDOR1
         mHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739103138; x=1739707938;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oX5DMuzX5DVPwIQtGMs5kpdpSLvAD3DOntPnxjTmbwg=;
        b=YE1MpA2VG2yqN6f41ZpwhwJjEghFabM7wvrZzhC4GlBeN625OaFr9wfujf3HGnI40v
         PjHo+0M/IcpO/zAhd78g0sdKWoHeE2alpTjJAJAebI1dc6tMnmoPehv9EfjuPp4InyDO
         oDQszaudThgoJQ/4tXEF/LUNrrRpKcoxbQwbxmRtYe8TFFKu4/xlRE4ruZy0VkJmidfs
         PWiKJZH9olCwt6HoPxZyYdl9G9msp7z+/2bOrRh3Qozyv8JjdilA8muVUE0QSV0IFb4N
         LxEZFdVomIdx6kHI5mDbeBSltc126SwpXxZBW4cpxkGnI3b3PjH+GzawAvTTNu35mmm0
         Vj9A==
X-Gm-Message-State: AOJu0YxA0ExAKLCZUaffwKOOFQ3LYMSS8pyZw7lYrc3pmXMlXPgLEW+j
	PQwup703RgUa+G/OFgJ4A6KskrGLpWaNahlMx7Wt3BguP3F5rvYj
X-Gm-Gg: ASbGncvLR/YrAxHQgUCvOH2m9raH+So489B98Ii6Lqek/6mgDkleP0tIQp2b0bOtzQc
	93dTBxRY46NZNsqmNqi1LADvd6AN0gJz/C5YMnlQC93MR2Ty5fHZ8svOpyq01LydHsEbxgGvolI
	zs/nO1WoGEpieWkDGlEVdZChUOp64iSlOqkbnCcYZSw58h1qhDfN7J7OEyPRux6C7T2HvLVtboW
	fwusm6sgPE/YOAIaYt67vxgyWODT0QAui4ibCsx77rjyfwjOpOXNfuzmiFPDOBARLK/mwtB3t6/
	HmQ0gBq0/ar8kM3z4k7/7SP24nOJ1eDJ6iwXrEZNnK+Hv1nkUk2wksMMgbAPreuQrMaoMmjZnAN
	rQiXSKoUwY+ubvyMlMvb8hVJP7kkPJ4tJ6C/QFo8NpyrwOslIYs+co3ouGbRLJgMkuqymuEIQ/x
	/bhect1us=
X-Google-Smtp-Source: AGHT+IEzvcMDqQmXS+KzAC9YrSZzOlIJQ5AvwDhFiNEPuQh9+HkTdujLFJ5Mlf2duYI+jW4GyZzo8w==
X-Received: by 2002:a05:6402:2187:b0:5dc:9002:3164 with SMTP id 4fb4d7f45d1cf-5de4504005bmr10613185a12.5.1739103138337;
        Sun, 09 Feb 2025 04:12:18 -0800 (PST)
Received: from ?IPV6:2a02:3100:acf0:cb00:e533:c1d0:f45f:da1c? (dynamic-2a02-3100-acf0-cb00-e533-c1d0-f45f-da1c.310.pool.telefonica.de. [2a02:3100:acf0:cb00:e533:c1d0:f45f:da1c])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5de61830117sm2479889a12.6.2025.02.09.04.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 04:12:17 -0800 (PST)
Message-ID: <f8e7b8ed-a665-41ad-b0ce-cbfdb65262ef@gmail.com>
Date: Sun, 9 Feb 2025 13:12:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: remove unused PHY_INIT_TIMEOUT and
 PHY_FORCE_TIMEOUT
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Both definitions are unused. Last users have been removed with:

f3ba9d490d6e ("net: s6gmac: remove driver")
2bd229df5e2e ("net: phy: remove state PHY_FORCING")

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/phy.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 19f076a71..e1237bc51 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -303,9 +303,6 @@ static inline long rgmii_clock(int speed)
 	}
 }
 
-#define PHY_INIT_TIMEOUT	100000
-#define PHY_FORCE_TIMEOUT	10
-
 #define PHY_MAX_ADDR	32
 
 /* Used when trying to connect to a specific phy (mii bus id:phy device id) */
-- 
2.48.1


