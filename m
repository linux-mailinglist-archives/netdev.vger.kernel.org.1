Return-Path: <netdev+bounces-69716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 585B884C531
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 07:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D736E1F2719C
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 06:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEA61D552;
	Wed,  7 Feb 2024 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5fcopIt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D491CF8D
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 06:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707288773; cv=none; b=jZ33DBj092pkUk+AbzNemoKCd0whnF2JPUhy+NuLJgvDI9MRMyBd0/jxTzBQQF/xycL7Fk0e36QKK+OXoq5eRANthvd75Zngv+S1RL+2iGfe17MMpLpH2f3fNV9byMKgY58gHdLIuwsevQHebyVN858xB2mUIYJ7i5kIcbUGBVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707288773; c=relaxed/simple;
	bh=ogCPLSECQqjM5RGTuRQ19FIRVUFzT9hZ+LSdjEAWVmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJCInCMPAGtTUK8xlgBgLxbxOMB+10kyEdTGO4JnizyKBckn1mGcyarJXCCeDdJwmHHclOQvP/UsSZ4UkOl/tWhS4gmtmogXvouRm/88ruQaR6teJlA0JjxQJvVCPLJ7eh85sPEimmqaU6Skj021jslLVDuxBVRNtXZNUAM7jqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5fcopIt; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-511234430a4so511164e87.3
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 22:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707288770; x=1707893570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s6gfK1Ju2S/7tcTiAdH1pYwM8GwPnmQUVT73cB/YE68=;
        b=M5fcopItxBXboQ/5DnSyQTft8d5HV9jnHoUbzyKdCsq7yhUysUyj92MgYplWXRwZMi
         +MARB7BZrPTjMMywe3Zyi+h2CeMJTBjQBJ5XoXCJGeBtwtHmhx6wHzuTvEhRvJCGnYQ7
         2JOj5cadD4HF8tLb0Mjkjsa5QTb/K8MdXol0kkzFUEAPumEGvBhVBOWtgffbKcHBmgyQ
         pvQYnc34ZGjRv8d0TFv9KLZKroXFA1Py7nO1miSziY6PDG086Ts7IJlpXyy6Siu1qBqt
         GY6DQ+leEL6w6gSKgArNB//0tS83oUF6SS2RAaIvCtv3CBaUbEiqoyvAn4+nrv2IrisP
         RM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707288770; x=1707893570;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6gfK1Ju2S/7tcTiAdH1pYwM8GwPnmQUVT73cB/YE68=;
        b=LfofSf3QSlVzLPZZnFbxrz+eFDFRatNsMAI+Iv1bsFQ2j8fB3PZ+ZH7nvppAMG1BKb
         6ncZT5QKtavYlNhYm7LUXpg4uNCniCdA1rpVz1OSoO0hcTOw7zeXbfsvM9iRnHJJpkX1
         5Xe/w+WZyVYClj0Sqka2eEBdBCZoc8uCIB9NtTBp7p2ruSux8c/e9EPN8Ln6OBhRj3yu
         6YoiLzoI0oaLEj1gnEFpio9ZHCe1b95NtMaPUwBvSLeXMRtr+BD0Jlpw+CYlTO8Mc8Tn
         nb/FpmPRp+2f2pMQornZ+lhschz7AG7PPYUgXvzjhqkv6AD9u/rBWZ01AYYQYxlc7gse
         lRiw==
X-Gm-Message-State: AOJu0YwJ8RMpPcq+bXUZ6QSsOtOUivI5wfX+G9HhOKx5xbpi0YxUaigR
	zxGMAynE6Y0Apq3cU+qupzeBQpjP/+CzimrgVNlzi2z82RWgMQe0
X-Google-Smtp-Source: AGHT+IFqoPwGwYvW+C6UNuPi+ZNsqEJRFleTLgpktnN87P26O9cXb924Oc4Yr1CuacZEG5S/i0mpiQ==
X-Received: by 2002:ac2:4d84:0:b0:511:5314:1762 with SMTP id g4-20020ac24d84000000b0051153141762mr3128094lfe.44.1707288769715;
        Tue, 06 Feb 2024 22:52:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVH+sOMzNFN7VqghlFPns/C58Mlchs+5dMbpAXiwCYaYpQewQBvwrUhocogy0teClZnq7ur2c+FQFvP5wocAg6DV69E2ZztQNKkS7ZmzM6qIQ5hl/q8JM4rc2bgckv6ZUaMF7caicD6wDkSVoTEHp0g76IkYH7WUAKX8MC2DpL78EGq96pD9MYJg9DaVjnwbB/2A1I+DDkkHnkyEGGqAp/dYisw5l7vjVQ=
Received: from ?IPV6:2a01:c22:76b1:9500:754d:f584:769d:10e? (dynamic-2a01-0c22-76b1-9500-754d-f584-769d-010e.c22.pool.telefonica.de. [2a01:c22:76b1:9500:754d:f584:769d:10e])
        by smtp.googlemail.com with ESMTPSA id y10-20020a056402134a00b0056020849adfsm341667edw.26.2024.02.06.22.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 22:52:49 -0800 (PST)
Message-ID: <2046e53a-6de4-41e0-b816-3e7926ad489b@gmail.com>
Date: Wed, 7 Feb 2024 07:52:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: atlantic: convert EEE handling to use
 linkmode bitmaps
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Igor Russkikh <irusskikh@marvell.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <7d34ec3f-a2b7-41f5-8f4b-46ee78a76267@gmail.com>
 <c7979b55-142b-469b-8da3-2662f0fe826e@lunn.ch>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <c7979b55-142b-469b-8da3-2662f0fe826e@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03.02.2024 22:50, Andrew Lunn wrote:
> On Sat, Feb 03, 2024 at 10:25:44PM +0100, Heiner Kallweit wrote:
>> Convert EEE handling to use linkmode bitmaps. This prepares for
>> removing the legacy bitmaps from struct ethtool_keee.
>> No functional change intended.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
> [...]
> 
> This is again a correct translation. But the underlying implementation
> seems wrong. aq_ethtool_set_eee() does not appear to allow the
> advertisement to be changed, so advertised does equal
> supported. However aq_ethtool_set_eee() does not validate that the
> user is not changing what is advertised and returning an error. Lets
> leave it broken, and see if Aquantia/Marvell care.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 

This patch was by mistake set to "Changes requested". As Andrew mentions
in his review comment, the patch is a mechanical change, and it's fine.
It's a different story that the underlying implementation it's broken.
This should be fixed separately.

Same applies to "bnx2x: convert EEE handling to use linkmode bitmaps"

>     Andrew


