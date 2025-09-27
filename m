Return-Path: <netdev+bounces-226923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5E0BA6317
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 22:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA56E1746B4
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 20:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695E521171B;
	Sat, 27 Sep 2025 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwQnZdMg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C3218DB01
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 20:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759003406; cv=none; b=aS30WwamBGzpOq8kjFLWsFlJnRGFHI64UyiLLUm8EbLIjShCHDQ2oBvyQEaYUq9bi6tIqo1RNSbbnwEwcYsATYQtBeu/8RU/45wC/ypnDHhtGC+qcH6S8Uhjau+jpRO//xTkKm6S8NNy/BOPNTybgujifmItqFAwHU8SwZEg3LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759003406; c=relaxed/simple;
	bh=BpnDph6utG22oq3lMfev8RJejCYtuAvOKMhr3bv7ubA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=WkTTTI5bTLbpwZkhO8KnjVfiGZgL9VdUzRNdIPGg4h7GhplJdFc5BCcazOEYe+uVWSU5cJq0J9SZxLyhCKAMRvtk7e5mIRD22SEyWZeey330b4zJ21rDfSDOqqZ4614DZutuBaSUxKaDEgmNCpOy0fhlY/i/u7nnylvlBXOHTA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwQnZdMg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4060b4b1200so3016580f8f.3
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 13:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759003403; x=1759608203; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6j1maidLvPjAgRbP+s8GJEcIB7fxbWxm8NHKAgXkHFE=;
        b=KwQnZdMg695VtQ/ClGO090sP87WPwhman3Q6lBM931bSOM6kgiBJl69w7uVg8WsCJa
         5MQtEN4b4Nw0BZP/gsNtylhbFfg9aMLmI63+RGt/CVHNruqoI14lkl+qHtNDCSNkpO65
         zwN6t/OYx4Q2uhDUXTdtFfXI9rjg8mmBrMeM/yWt3l3Wn3fqYBbWI/1thyJSc9hLl9Xt
         wfKnIksnMMPVhgnmgkiyyDaag9vH9q8NObmaAmwYWmI2qccw2lYTgjjDGU//UjmZqIbw
         Z/VBf/CA2NkEHpIPv7a9Fso7TLKdedIDnuaw0PAOnHr3WuYjzPRdE1Uxw9IG+7YD4VPf
         0G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759003403; x=1759608203;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6j1maidLvPjAgRbP+s8GJEcIB7fxbWxm8NHKAgXkHFE=;
        b=pCAok1/nUh5OcBXFqUggVCctmQ7wgF3mMRS7Q2KiQdZNYxXOHjvcr/xfJglEs53S7I
         HJmSZPE+tb9CMEBN+FG7inT6mYLUHCjr0vlums18T+i0kE9FslH290qFoncdVtHmVJlu
         n121EXVGDXAq0CBWevJLieRZx7m/Np51wBU6P5E/FXpGG0WXE5O7z9LkWeKciNgE7BTy
         xmYUsDUmyaiCA/w0W6vm5epc1DWCPjUPw3lRJwzFebKgIC6Ru7beZCE2rmXKcOpIYT2j
         2h6n/2iKs1ltS2+Mhb1XVS8G6pzy9zAZZ7T+zpwXrLMPFbD8DdqqsQZgYmzWMRUNhC6j
         nXXQ==
X-Gm-Message-State: AOJu0YwC8EVSfBBXo8Ix/zlw1tt7JGytb9KBhTkuGpPoEqF79oiXaxKV
	BaQI9B3WTZg0mCHun6l3YxEoLXA92vXWJHrxsUZGnNDbAmXdWyeGVnzK
X-Gm-Gg: ASbGnctQpLwD3HAS4t8HamFCFMz7WtnDa7zFBxnwM6Pf8TC9VPWH6tsn1LHw0Q2NSfg
	QRGtBCsp9bS44FwtBqYJsvQxiy9me5sdNBVp3dB6CI4wL+GiokDm1zRnbie9UgxVgksUPDfP8/2
	ksAVGsf20zAfIVapqBCMIHImsQ008CCI47H2ZyACRdoQKjN5pxfLdIsM55Q5c/HjmYpLZg+BADZ
	T1BzoIcLhvKsDIPPl5D2vCMgwfn1Ca1Q9xYT67Bwb2pB/1JB591K1AKiAueT43zcrg0kOz7+OVz
	5kOYwzdS2ziWWsLmnmGYGnK1PGJed+Z3+qU47qcCcNjTSEAUPA/NTfW2hYqGFH90CJeMd3Ip57+
	3wvLnbjX7s+o8Y3+dLfsXM+VjrsEh1DWnnuVgfAcuuabPLxI/lsxrM1LaUMz+vWqb4yi9a8omZj
	CczoN+u+L67WkTX2RlDEFQ8sJuaL57sJgh/B9kWBWVEfmPoTiTUi7kYsyC36KUnDXfhcW1Xo4j
X-Google-Smtp-Source: AGHT+IE/mTG31dbT0mWBirCswOxevjJ4oOO3o78Ie+MM/ZOQL+C0phVd3gCwpg+BMRsP3H5JOXE6Vw==
X-Received: by 2002:a5d:588c:0:b0:3e9:a1cb:ea8f with SMTP id ffacd0b85a97d-40e4d40aa40mr11137732f8f.52.1759003402765;
        Sat, 27 Sep 2025 13:03:22 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f38:7d00:d0c6:28bf:dc2c:1c4f? (p200300ea8f387d00d0c628bfdc2c1c4f.dip0.t-ipconnect.de. [2003:ea:8f38:7d00:d0c6:28bf:dc2c:1c4f])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-40fc7d3780asm11835085f8f.52.2025.09.27.13.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 13:03:22 -0700 (PDT)
Message-ID: <19921899-f0a8-4752-a897-1b6d62ade6eb@gmail.com>
Date: Sat, 27 Sep 2025 22:03:35 +0200
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
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: sfp: don't include swphy.h
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Nothing from swphy.h is used here, so don't include it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/sfp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index dfea67528..92b906bb6 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -17,7 +17,6 @@
 #include <linux/workqueue.h>
 
 #include "sfp.h"
-#include "swphy.h"
 
 enum {
 	GPIO_MODDEF0,
-- 
2.51.0


