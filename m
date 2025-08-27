Return-Path: <netdev+bounces-217441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442E9B38B42
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 23:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EECDA362DB4
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6588130C62A;
	Wed, 27 Aug 2025 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmNpAkwU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BC92DBF51
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756329302; cv=none; b=pocD9iHYv9l1FfI7ykwzfQfze+zZH5XpF4vaO29KsK4qPYdc8fDCesP43rvPVQgoC3f5PxeW6ZAnPxBu+vOUkGXTRbOY8HrW1wciTi3F7kEhFLRdkWpCICUf4TgTZHVwgCfd0owge2xvDX5tjwQY7/aIM1U7lb2CrcUFExd0OHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756329302; c=relaxed/simple;
	bh=jsLzs4lzPss9t9zx5K467G4blO9Luowh7mUVJzo0HyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvYdmDM/zMPNG0blQzarMON/bMMO30nbceE0YVQb0PS1TIFD5O7SXFVrTk1vmklCy8UWhvmLs+wkjf8VA5/6PPN8+OHOSqxJd+byuU4KeW7iBdynIUIrLnaiHfDDLKnYMWkImew9lVv7Epoj1Htt9b17gncERhxtSMl/Lgioec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmNpAkwU; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b109a95f09so2340021cf.1
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 14:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756329299; x=1756934099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n9ABox5zOemlHPyUgf+QrPeMwuOYbBHW8XM2x5EcKhc=;
        b=bmNpAkwUJczbLYSjH2OCRIlpTLzI9OcmZMNO3JZMq4+Ge0mkbzK61W/KTon8fns9WM
         AnbAQNRimooH5DRJwlaVaXpL2MxT99GTwcYJQYW6M4lfa2INj9ey5h1Yebb3oozUFb7H
         llS953ShGB+i0NwmTyhafaOrQ8iHAj2k1G2nl4247wBwa6fTMg+bHvY+k/Rxhumn6AYL
         sf5ta29xG131pbPcEAIzfEio9zhxbqSxxCy2DJHRHDUYzpShX5vzHl6GEvxBXa5nk+QS
         xekv2s7QRE19jXh2uIIpTkcyWAy2ChuZkqdovoY2j+42MjQ/xC0TD+vbxaDFXEcAScso
         puQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756329299; x=1756934099;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9ABox5zOemlHPyUgf+QrPeMwuOYbBHW8XM2x5EcKhc=;
        b=DjBYqAUmrqDjAd0g+XuOuoPL6KjZNc8q307TdUuUTr+5FDRi4h9uAx1WaM8+oeMXbV
         TNm3bmY6o50+2QXUUljtimiPNjwL/lxSlFOH4q7w4462OyV7714Hb/Y0mKbpDlT+hkP9
         I68oI9v27Ma97ElPt+YCZjgvN+nckAQ/72VLVuqDMcbD/rGZ2S7YaR037FI6/fjio2NS
         yxOL4ixia2BLq2pLnDmDNctmAObAh1AG7Ahvf7AH0M3YpemYDTTA6twDjMeRUslWpnXT
         LooEubrYIp/YtQ8R68KatPC+V8xxiNx6SfqlgYRD0IFpMsH2nxxSxC+KQ/DAVBsHzGdg
         fMaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1BGlO3rAMbQMD2Zj/gZ/YIDsdasBj4WG4wmAuWm8Ju71kd6YDvelS3t+FT49R4MmCcg4pNiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo/JqyVS42zz4lCaZ4cXL+SoRsY4QhG7BcRu/+zsJK9FXh6PKt
	fHvBd0OO+J/HssU+CfUbo+xzLGG3b6nObuVvPLv5ng0xSyQ+dO67i5Iu
X-Gm-Gg: ASbGncsO3ide5lmLNR2CTEgl/qwfptntEPP8pRSXYtnVHoTYVJvC6qfNEh7AQrZOPoN
	DdgYGUY9Trz5ke6HfgDpyq0SOSXAe1rW880qlWR1AlcZ3mm6ESV805111S3Hb9CPyM3k9ejL9n4
	2KW2SCu+LnpmMY8CS25FcO8wAIIUr0XrZIW0mcmYdOGkdfgpcUeAIL5IgHkIInxX24OxTFYLzEC
	pTOMBon9BFzewmtbjjwR8IEKmeoITRZYRj1eigC06wL0SIAtwyf0uFuAns0bjACR5BflcUCm649
	ArvqsMzdBAmaewyYoSFNDWf1YPQXfFnHB7qVAw6wb99KkReOerb4GiDJi71YwNyOXtRv00q+Uoq
	6HHy3lp3mkuAOpam+DSpBdRrDv1ZtJDRavvVLU2vi2SIUNFDf+ZbFo0a9dIXN
X-Google-Smtp-Source: AGHT+IFmWvYk/gjNmy2QmdoD3q5ra1OdpSSgyF0dRxnbPyOj2+r9XEX3x9pggf7JW27DgwE1wWl7Yw==
X-Received: by 2002:ac8:5754:0:b0:4b2:9ac2:6858 with SMTP id d75a77b69052e-4b2aab66b53mr228735461cf.75.1756329299350;
        Wed, 27 Aug 2025 14:14:59 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8c67929sm101568311cf.6.2025.08.27.14.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 14:14:58 -0700 (PDT)
Message-ID: <7f390adf-5ee2-44cd-8793-36b04f1fe73f@gmail.com>
Date: Wed, 27 Aug 2025 14:14:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net] net: phy: fixed_phy: fix missing calls to
 gpiod_put in fixed_mdio_bus_exit
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <b3fae8d9-a595-4eb8-a90e-de2f9caebca0@gmail.com>
 <aK90BbEGJAVFiPAC@shell.armlinux.org.uk>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <aK90BbEGJAVFiPAC@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/25 14:09, Russell King (Oracle) wrote:
> On Wed, Aug 27, 2025 at 11:02:55PM +0200, Heiner Kallweit wrote:
>> Cleanup in fixed_mdio_bus_exit() misses to call gpiod_put().
>> Easiest fix is to call fixed_phy_del() for each possible phy address.
>> This may consume a few cpu cycles more, but is much easier to read.
>>
>> Fixes: a5597008dbc2 ("phy: fixed_phy: Add gpio to determine link up/down.")
> 
> Here's a question that should be considered as well. Do we still need
> to keep the link-gpios for fixed-phy?
> 
> $ grep -r link-gpios arch/*/boot/dts/
> arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts:                              link-gpios = <&gpio6 2
> arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts:                              link-gpios = <&gpio6 3
> 
> These are used with the mv88e6xxx DSA switch, and DSA being fully
> converted to phylink, means that fixed-phy isn't used for these
> link-gpios properties, and hasn't been for some time.
> 
> So, is this now redundant code that can be removed, or should we
> consider updating it for another kernel cycle but print a deprecation
> notice should someone use it (e.g. openwrt.)
> 
> Should we also describe the SFF modules on Zii rev B properly?
> 

Do we need to maintain the ZII Device Tree sources given that there has 
not been any work done on those, and it's unclear if they are still even 
as useful as they once were?
-- 
Florian

