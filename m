Return-Path: <netdev+bounces-239605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C39C6A0E4
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id DB4692A472
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB383546EC;
	Tue, 18 Nov 2025 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXJ1bdUq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wtfvm222"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F67316194
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476963; cv=none; b=hNOE8T4jRVfzzzwIQKzhap9i5WN2OoqdDunFfr/ASExtAbBT1NfTOZFHW5/qy85Jp5zpEhFm/MpfbrWWzQp7oRXKwQRiBqKxCQciWL9JW+fX2+wuW7rwj8G5koiVMM+nMrlJ/wvr0xq04a/e4n7tKV+NafT6JnGzrfH8Yf0EmDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476963; c=relaxed/simple;
	bh=Pu9ixYZsFQItNRYJLylft6nHxSMZveZVAFQIAqMTqLg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZCUl1FddHyNZlG/dt0QkwQIvECVNha/XvZpyTrA6R+pXYpVgWVdf13+yf4TM0bXp3NZ3bp1tdhpy91yHI9dFD1cABV4Xcg6NXHI/KNnAhHoSzExbMfpQeKc4i5AiIx7kZH98SMpS3lPTZZRtgDMCRH/g1N2Wbo07N7lBpJgbde4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eXJ1bdUq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wtfvm222; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763476960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcIjluc6CF4ch514Lk0ctcAIz2wl4W9d5ngSIs1tzo4=;
	b=eXJ1bdUqf49FF6ndjyOR9UwJVTF3oT23GWkFZRWSPXdAbbY3xCjTEgc8TlHYumSigpOvxq
	6MpUiMG4kOPVHO0kZOQicTyG6ZKcunYAQoprfIKoidhNmq/0gQYS7zzg+Dk3vpPxcAhY5j
	f2vWQRmaQWnAfkBTuUh//am+hAEItjY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-tIHoLFSLMvaCnYiSpXsrHQ-1; Tue, 18 Nov 2025 09:42:39 -0500
X-MC-Unique: tIHoLFSLMvaCnYiSpXsrHQ-1
X-Mimecast-MFC-AGG-ID: tIHoLFSLMvaCnYiSpXsrHQ_1763476958
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47799717212so26932485e9.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 06:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763476958; x=1764081758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KcIjluc6CF4ch514Lk0ctcAIz2wl4W9d5ngSIs1tzo4=;
        b=Wtfvm222xsbY46cxLBDmisKxUJ+vS1Dsnb6JHq/NjxfN36hDT6vdJ/iNmfUtDuO1ih
         vAoS4FyclYHJdi2l3Dl1rTT2jQnbn+8a+KI7hgzkg3tHYRJu8RP9i5YTAd7xtFcjSzlJ
         DZ/rICeAguRJfv8OQORo3TZHMVmVinKzkprDg9EIxsMXbmKNZXtqtEpdOFYrCMM/SozH
         zPK9BseTQTuKv9MoOuBBu9coa4qvIvXOwOZuvgM4xfWF+OvBvTiaHdFqIyPFaxPnCemF
         9ppBA+Ha1eP46VFG76gfYWnqaidFfPrmBhftfaa62BsFSXI7UpZBcobo3+AdTnfhtllU
         u1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763476958; x=1764081758;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcIjluc6CF4ch514Lk0ctcAIz2wl4W9d5ngSIs1tzo4=;
        b=uZF6xyX7AF8upD5FGFFE0gy7TLiwaqmbFC5QeivetW6aV3ERv/RNOvTSw1tAEcXCuW
         94X6CTlG+JuDsUFqpFkdFCCXydWZ4UlyFHN3843Qe5WcjSP+TGnIWSDKVUvr08BM025D
         qcjegQpv740NHsI8tD/YfFfO1XynZZ4i9YPeqrWAEcK6G5MuHU/hxbCbmUMKeL+ddyL6
         D+VFKUJFdxIuMvQapjRuTm9HvuxmB4Bt8dWqzKAaBzZa0ZGVIL2o+dIDBtCVvRBjfdT/
         4VtJ3PkJE7t7uR6tmoFVf5Nww0PtABstpgOy/rjym2pSq2D6uHybAdZ9K2WEu1tBqjw+
         hX4w==
X-Forwarded-Encrypted: i=1; AJvYcCWw0WFv+g+PUOpaF9vVRz70hwSYweTstcENweQ0D98S5M1fR52LwqjYpLopsFHDSOnnvT8AOS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtB3aLkpmnPsnG72sGHwIB/gkvjzmpq1Ch99fweJLxaEv/nq+k
	7f4o/87wynI7aSdRZbUeyEIuhXyLovgpF+szDlBNLrSjAEDSV4gAKChv5TRUIuAIsbPoWAw2x3/
	cxsNPZ4R37b0IzYet3Qgsv6mdpZSryGNeCu1X+kDBxL1YENcZ85IOFC5OoA==
X-Gm-Gg: ASbGncvDovgfXVfQKunHP0zl6y83zS7fpk4SntZ/Q5o1UoRVYuc1Cr6fa/MYhg88UpX
	lZu2KiEHwknwzkpcMyW50BliNmYOvPCc/rALji3pkXhmfR+6C09dHLwG0w2VOKk8UatDZ+VZsfE
	AEh4uBdR/xyRSYzMdAq+vOkU7A7EdLRYMJkff604Xgyhwa8zlPBuwev1vL6dW5b3itKUAvLZy+u
	rVUdWuVecpiEbI/6nSIQlZyA/UqXhmG4KPQxAwBkgldifS5tpbOQxbC50j9LIiRlQ9UcvDOp3Gm
	00YtkJb3MvFDXr66DIfqHZ4sWaO47P5DhhyCxVxwFNEJygHTHs0aq61OIRNXIzKZdUFKZ/QlG/7
	ESicVQTYCUD+g
X-Received: by 2002:a05:600c:c177:b0:471:13dd:baef with SMTP id 5b1f17b1804b1-4778fea3048mr167899285e9.26.1763476958168;
        Tue, 18 Nov 2025 06:42:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0CCY6x+8bA07W4MfE2Q3iuNu7PIm0BhBaWtRwjXdbvpokwwW2evCf1FYfJCFjxSD0LjK6Ug==
X-Received: by 2002:a05:600c:c177:b0:471:13dd:baef with SMTP id 5b1f17b1804b1-4778fea3048mr167899055e9.26.1763476957729;
        Tue, 18 Nov 2025 06:42:37 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9741cbfsm19503645e9.6.2025.11.18.06.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 06:42:37 -0800 (PST)
Message-ID: <53b3ac97-830a-47fc-a83c-3d12dac2e21a@redhat.com>
Date: Tue, 18 Nov 2025 15:42:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: add clk_prepare_enable() error
 handling
From: Paolo Abeni <pabeni@redhat.com>
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Inochi Amaoto <inochiama@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
 Rayagond Kokatanur <rayagond@vayavyalabs.com>,
 Giuseppe CAVALLARO <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20251114142351.2189106-1-Pavel.Zhigulin@kaspersky.com>
 <4a3a8ba2-2535-461d-a0a5-e29873f538a4@redhat.com>
Content-Language: en-US
In-Reply-To: <4a3a8ba2-2535-461d-a0a5-e29873f538a4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/25 3:30 PM, Paolo Abeni wrote:
> On 11/14/25 3:23 PM, Pavel Zhigulin wrote:
>> The driver previously ignored the return value of 'clk_prepare_enable()'
>> for both the CSR clock and the PCLK in 'stmmac_probe_config_dt()' function.
>>
>> Add 'clk_prepare_enable()' return value checks.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: bfab27a146ed ("stmmac: add the experimental PCI support")
>> Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
>> ---
>> v2: Fix 'ret' value initialization after build bot notification.
>> v1: https://lore.kernel.org/all/20251113134009.79440-1-Pavel.Zhigulin@kaspersky.com/
>>
>>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> index 27bcaae07a7f..8f9eb9683d2b 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> @@ -632,7 +632,9 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>>  			dev_warn(&pdev->dev, "Cannot get CSR clock\n");
>>  			plat->stmmac_clk = NULL;
>>  		}
>> -		clk_prepare_enable(plat->stmmac_clk);
>> +		rc = clk_prepare_enable(plat->stmmac_clk);
>> +		if (rc < 0)
>> +			dev_warn(&pdev->dev, "Cannot enable CSR clock: %d\n", rc);
>>  	}
>>
>>  	plat->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
>> @@ -640,7 +642,12 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>>  		ret = plat->pclk;
>>  		goto error_pclk_get;
>>  	}
>> -	clk_prepare_enable(plat->pclk);
>> +	rc = clk_prepare_enable(plat->pclk);
>> +	if (rc < 0) {
>> +		ret = ERR_PTR(rc);
>> +		dev_err(&pdev->dev, "Cannot enable pclk: %d\n", rc);
>> +		goto error_pclk_get;
>> +	}
> 
> It looks like the driver is supposed to handle the
> IS_ERR_OR_NULL(plat->pclk) condition. This check could cause regression
> on existing setup currently failing to initialize the (optional) clock
> and still being functional.

I'm sorry, ENOCOFFEE above, ->pclk is not NULL nor ERR when
clk_prepare_enable() fails. Still I don't stmmac  code depending pclk
being successfully initialized, and the eventual regression looks like a
real possibility.

/P


