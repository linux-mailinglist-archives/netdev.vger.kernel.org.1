Return-Path: <netdev+bounces-239586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B738BC6A0CC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD6324F86A1
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBFE3546E9;
	Tue, 18 Nov 2025 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boQvNFuB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qSVV7qkg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3066F3271F7
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476222; cv=none; b=WyWItCAcNsZV+e8pRLIXc9pIJ/XbPCqgWHoGGPzJwXZlx5gU79HVYRVE/1EpaC0OIuaVhX3SPj4pZMQGqVsKxeN1+HLTsTNu9YCDDSBd98eXOnL1toXVPKD11dR1uOVOEZvtgPDG+5Q5GXZcP9Et+8Da3JTsAI4g2SlxKjHa9jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476222; c=relaxed/simple;
	bh=AcnGX8ANmx00qdNl11G0N+EdinX9DGDDhNDUIL1OQV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YktuO/63qYj3uJlQKu51BuBPp9tRwyCsEppXiMXmcuqsSD6fNca+wnT4tiwjIOYx48KpC8alORZyqaef/AI82mB30I5eVZdEbwI8cyov8n8z2gDOqbJIGPsMqWYKNiOXE494yM5/rf55VRzIjIMeR2sjF+byZrWVFPomVSDbyX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=boQvNFuB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qSVV7qkg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763476219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3eRIY/NbZeEoJzxpOIjcuTXUY4zJKOGkqyWddqMp990=;
	b=boQvNFuBd2YPI+jDJ4YZnzXbhiKWfgTVJJKboWVUdT16hEvZYdUADAW0J2aRiYlQZd5eo5
	/hSdZ9LCY5OW2boAzEM8Kp1UW7uGLDC+SjzC+YVMR9MjcqrvWlVhm0hWOM0DnCZqzSu5sT
	qX4Qbi6+d30IVBD3gVB6a+aKSYjOCco=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-iLBB1dopPqG6qTNijStxaw-1; Tue, 18 Nov 2025 09:30:14 -0500
X-MC-Unique: iLBB1dopPqG6qTNijStxaw-1
X-Mimecast-MFC-AGG-ID: iLBB1dopPqG6qTNijStxaw_1763476213
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b3086a055so3716250f8f.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 06:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763476212; x=1764081012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3eRIY/NbZeEoJzxpOIjcuTXUY4zJKOGkqyWddqMp990=;
        b=qSVV7qkgUPrzSYaoDNJgjyE06xO30IslcuRudgblcx+eJpIoz8G+ZNLkGpUNn+uzDX
         Qr+AWA+b3FqsIO5QtYJCHAeySOdwGd1CyvC2r97PbSfyI4NKzLm5LDMd9/6Mep1Hp/WC
         1GQTsY4AHK3MvWLAdHvO8Ra7/1x7jwZIfdhO+scQ2ApwNqSVJ0M018kAlbyymgGEQ6em
         8yQAe08MTpX+SPPbtrKeXMm2rU1Pj5ZS7/7FQL5ameHRoiq6xwvhous4bRUhSHslhkvw
         Sfxjy5uzD44v7kZ6A36BVmWfN/o4VVrEm9nIkMV+pvA7EAuEGvHoeO5ptN5Me5OUF/80
         hGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763476213; x=1764081013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3eRIY/NbZeEoJzxpOIjcuTXUY4zJKOGkqyWddqMp990=;
        b=Y8jXtfy58HGm91Vf0U8McbuoDpXJLErLr0bqN/8kllsqtZ0X3DWQGYRsjiqFUTJEzA
         a2M+upYmgB2yMo1Wc6N0EmDg3IiQ7QDp4gPcigfIy3Je9cuJP7FWmvCLfn16QPzXwmue
         pKAdJAy5Uo8r3FVTtqOm2IbieXuJT4YEmMsQr5G/DVFIf3y4B8od9bVKmmqT/3ztqqL+
         onAlDT6WXqT3VGRm6s+qsQaQv6i57WvRCgRR8cxiuEEIeNiEJT1zd0HXl1q/C94ix99l
         qkAVAufUYpW4EsyNYPe7i+zQ9NcleJ8awerPRdlFmHO+XC2QHS1CyKib6pmDkasCmgbi
         W/vg==
X-Forwarded-Encrypted: i=1; AJvYcCWEG4tIU6MClaQ7snpsMV1xN+Zw39gjutcSJbOza3zRPwzPN1hOvaV1D5NRWdW8Huw+3lJRbao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb9xxoOu5byMbeq+6oUMX37aYzKMlb8OMQYjVEMZclbd819/l/
	bsTzscvjZ3OYqrVI+eqP2SvWg4yZCHGmvY+W4qpIbDUdqYltE7jAuzm5sp465twqkeeQJ24sx/E
	xzmbzlm1uIStN+S+/OYyQ7TDC0Hr3u7eMCmTAsmcc0yKY/FdQSLx0gw5Q+Q==
X-Gm-Gg: ASbGncu/uy/b5CFa2jEyyJDfk+4kjel0lzGxusno7AeIcEvUiVAYa59IJPbLtC3SUub
	74j2rSnZbElWxVQp69t1JKxECXzyrICceWtBun7q8QyUcCO2H212eWVGrtQJayiLpbAd4IF7R27
	UJM2OgnuBPchEaoS4Gfq8IOvzduEm0zME6+hCN7JLnRrnR0UTigCEVcZ0tHEoFqImtspP7GHspu
	ftHlLtIPz1Ht9HiucL/PZSceemZ13gj9GhUojGT1gsh9shxYQv1phYRerghAYHEzlSRDDqn2Oyo
	LuWAiEihBWqQ72w+BJ2ENVbkaCtYbnc1johjNbkJZQp6KDTjMrDgGPUNlpuZs4nyd815nRVz602
	Han7yOEfQ9WZK
X-Received: by 2002:a05:6000:4186:b0:429:92d8:3371 with SMTP id ffacd0b85a97d-42b59342b99mr14525632f8f.11.1763476212632;
        Tue, 18 Nov 2025 06:30:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwm2ThNaD3qGGBsOApPqujAYKRByi04FEJdieN5aJJjweY+ug15q24nDRRxPxeQEH6CYkCcw==
X-Received: by 2002:a05:6000:4186:b0:429:92d8:3371 with SMTP id ffacd0b85a97d-42b59342b99mr14525592f8f.11.1763476212191;
        Tue, 18 Nov 2025 06:30:12 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85e6fsm32541019f8f.18.2025.11.18.06.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 06:30:11 -0800 (PST)
Message-ID: <4a3a8ba2-2535-461d-a0a5-e29873f538a4@redhat.com>
Date: Tue, 18 Nov 2025 15:30:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: add clk_prepare_enable() error
 handling
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251114142351.2189106-1-Pavel.Zhigulin@kaspersky.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/25 3:23 PM, Pavel Zhigulin wrote:
> The driver previously ignored the return value of 'clk_prepare_enable()'
> for both the CSR clock and the PCLK in 'stmmac_probe_config_dt()' function.
> 
> Add 'clk_prepare_enable()' return value checks.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: bfab27a146ed ("stmmac: add the experimental PCI support")
> Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
> ---
> v2: Fix 'ret' value initialization after build bot notification.
> v1: https://lore.kernel.org/all/20251113134009.79440-1-Pavel.Zhigulin@kaspersky.com/
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 27bcaae07a7f..8f9eb9683d2b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -632,7 +632,9 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>  			dev_warn(&pdev->dev, "Cannot get CSR clock\n");
>  			plat->stmmac_clk = NULL;
>  		}
> -		clk_prepare_enable(plat->stmmac_clk);
> +		rc = clk_prepare_enable(plat->stmmac_clk);
> +		if (rc < 0)
> +			dev_warn(&pdev->dev, "Cannot enable CSR clock: %d\n", rc);
>  	}
> 
>  	plat->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
> @@ -640,7 +642,12 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>  		ret = plat->pclk;
>  		goto error_pclk_get;
>  	}
> -	clk_prepare_enable(plat->pclk);
> +	rc = clk_prepare_enable(plat->pclk);
> +	if (rc < 0) {
> +		ret = ERR_PTR(rc);
> +		dev_err(&pdev->dev, "Cannot enable pclk: %d\n", rc);
> +		goto error_pclk_get;
> +	}

It looks like the driver is supposed to handle the
IS_ERR_OR_NULL(plat->pclk) condition. This check could cause regression
on existing setup currently failing to initialize the (optional) clock
and still being functional.

I *think* we are better off without the added checks.

/P


