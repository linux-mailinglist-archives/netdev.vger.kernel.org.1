Return-Path: <netdev+bounces-123914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 009A3966D18
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 01:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C5D2849D0
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972C118C348;
	Fri, 30 Aug 2024 23:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUQ6pxU9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D286517C7B3;
	Fri, 30 Aug 2024 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725062355; cv=none; b=RAo7vCjVz1uW5EsgHWj1jGZ9n4CoD6Rq/EyQdju7hjGc7f5rsdd1UxOeuIQPdJhwfUlCzbGcyPvT0+tDhfhogF+kGsujRTsNIq3uLWMTj5E/kvWuJDGB9pNYMLFJLbkh/NQ4CLEvhaLMcbrEA/IUboDJ1bb+juSiOOOHqKLF8pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725062355; c=relaxed/simple;
	bh=WL+mPsmtKe4NMOEeuBOmY6UqNzIVj6D1MStQM/ZpovQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MXQR+vg0V0uTrXVM9OmSpWrMwGv3VpZCACB+/zsUD6lB0HhMmzPmVjOaTesYTPJQarwmObbZ98hvvfjGxmifW/j8jHwfyAr8GEf4L0aIainRHhuLvMY00UJRQG7XvB4cxAqDoflAw1an+9gQcWI6i3KjqVW1o280Vi/2D+8nLLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUQ6pxU9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fee6435a34so18039615ad.0;
        Fri, 30 Aug 2024 16:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725062353; x=1725667153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sr+m/MCpvguQ1PEITzYf3gtI8iZ+jxmN3Qz312mDJ+Y=;
        b=TUQ6pxU9mxpm6TREgTxsxfiMClRyR94ZhB1i5+RBc2mkkS79ghjFNz8dGxTUdgjRfh
         CaBCdyTZmXJPwniwRYgCaUEu+Q/JQahsofJKno6b9NOfXG8T6yyorGAtzuNJr3CJ5ZqC
         Z98AB9q3G3I/HYycoxZbsjoGguc9gUDvlEvLbQjT76sv9oO7i1oYgMHS9B9LwFHNoanq
         NPilbiTRKDBQlTGYo0/aIDi5i3E1hRiksYaCQ0eunTSigyWjaUBqy3f7Em/x/+MBhtgu
         n+VBJmWxOMop/49bx+te2c9eBPSEZFiWNPlenkz2GXchHj9D2MPFD2RdHKqj6h3bsoZr
         RSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725062353; x=1725667153;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sr+m/MCpvguQ1PEITzYf3gtI8iZ+jxmN3Qz312mDJ+Y=;
        b=dMwzR4Lxl2VkVP43D/GoujlQyu6VmeFy5/Ge7IEkxDMOg/fEyegXdB+x+yFLI9eqjd
         gaFrTNQ4DvP29T/TQWlTwFibrQxfOvXMfdOXPyuQsGzK7vA2kxETETkm2AU+fynJUnBH
         aWdwfc/zinDt52dMMpo12WJBoHhxEtf731dqAMW2eqNj9F8v7TbwRWNNRpLqtt7OkJad
         KPhlahmRztCwCvK3sroe8cPClBsrYIrn3NRjTEwijBqbvzH9WDVWMoXNzEWEVQdWirde
         sG0vzztY9UXGaDj4yrIp+BbXDc4KSu0T5n4AVmB3P38xui7cXBW2OdZCmtKwjGsQhV+5
         pYSg==
X-Forwarded-Encrypted: i=1; AJvYcCU13DhAoxuTjC9p/HdmYJvm5KTADzHfHSlB0Yur5iRPlNF72B2T9enND6WmfT4Cpbgwmj2ZMKvj69t8znI=@vger.kernel.org, AJvYcCUmuMbx3wHrOjGquihBEQHlmRBZG4kgYpUxoGzrXqj8oM4oCiyQCNgHY3QsGa2J8wGzSOGNDGZu@vger.kernel.org
X-Gm-Message-State: AOJu0YyYWXEA5NGpi7DERpS6yhIbu3/DyTSp9PN5tjHOd6nh/9/MIlTV
	9XM/4kiPutH+zXdUI/EQYUjE96578h0rAqAIrYEMrZof8i2XIwP6
X-Google-Smtp-Source: AGHT+IEgofVC034M7KNRqW6gP1mCFO060gmQo6PGys6HKORyv1JMDN4S7cvVuPl5BWLZMdBvTzCsLQ==
X-Received: by 2002:a17:903:22c5:b0:201:f065:2b2c with SMTP id d9443c01a7336-2050c4666b0mr94473895ad.55.1725062352960;
        Fri, 30 Aug 2024 16:59:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2051553720esm32038555ad.178.2024.08.30.16.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 16:59:11 -0700 (PDT)
Message-ID: <82473d11-ff14-494a-bac5-4a5b1fb8ce4d@gmail.com>
Date: Fri, 30 Aug 2024 16:59:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [net-next,v3,1/1] net: stmmac: Batch set RX OWN flag and other
 flags
To: ende.tan@starfivetech.com, netdev@vger.kernel.org
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, leyfoon.tan@starfivetech.com,
 minda.chen@starfivetech.com, endeneer@gmail.com
References: <20240829134043.323855-1-ende.tan@starfivetech.com>
Content-Language: en-US
In-Reply-To: <20240829134043.323855-1-ende.tan@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 06:40, ende.tan@starfivetech.com wrote:
> From: Tan En De <ende.tan@starfivetech.com>
> 
> Minimize access to the RX descriptor by collecting all the flags in a
> local variable and then updating the descriptor at once.
> 
> Signed-off-by: Tan En De <ende.tan@starfivetech.com>
> ---
> v3:
> - Use local variable to batch set the descriptor flags.
> - This reduces the number of accesses to the descriptor.
> v2: https://patchwork.kernel.org/project/netdevbpf/patch/20240821060307.46350-1-ende.tan@starfivetech.com/
> - Avoid introducing a new function just to set the interrupt-on-completion
>    bit, as it is wasteful to do so.
> - Delegate the responsibility of calling dma_wmb() from main driver code
>    to set_rx_owner() callbacks (i.e. let callbacks to manage the low-level
>    ordering/barrier rather than cluttering up the main driver code).
> v1: https://patchwork.kernel.org/project/netdevbpf/patch/20240814092438.3129-1-ende.tan@starfivetech.com/
> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c   | 6 ++++--
>   drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c | 6 ++++--
>   2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> index 1c5802e0d7f4..dfcbe7036988 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> @@ -186,10 +186,12 @@ static void dwmac4_set_tx_owner(struct dma_desc *p)
>   
>   static void dwmac4_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
>   {
> -	p->des3 |= cpu_to_le32(RDES3_OWN | RDES3_BUFFER1_VALID_ADDR);
> +	u32 flags = cpu_to_le32(RDES3_OWN | RDES3_BUFFER1_VALID_ADDR);
>   
>   	if (!disable_rx_ic)
> -		p->des3 |= cpu_to_le32(RDES3_INT_ON_COMPLETION_EN);
> +		flags |= cpu_to_le32(RDES3_INT_ON_COMPLETION_EN);
> +
> +	p->des3 |= flags;

You could just batch the endian conversion too:

	u32 flags = DES3_OWN | RDES3_BUFFER1_VALID_ADDR;

	if (!disable_rx_ic)
		flags |= RDES3_INT_ON_COMPLETION_EN;

	p->desc3 |= cpu_to_le32(flags);

>   }
>   
>   static int dwmac4_get_tx_ls(struct dma_desc *p)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> index fc82862a612c..0c7ea939f787 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> @@ -56,10 +56,12 @@ static void dwxgmac2_set_tx_owner(struct dma_desc *p)
>   
>   static void dwxgmac2_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
>   {
> -	p->des3 |= cpu_to_le32(XGMAC_RDES3_OWN);
> +	u32 flags = cpu_to_le32(XGMAC_RDES3_OWN);
>   
>   	if (!disable_rx_ic)
> -		p->des3 |= cpu_to_le32(XGMAC_RDES3_IOC);
> +		 flags |= cpu_to_le32(XGMAC_RDES3_IOC);
> +
> +	p->des3 |= flags;

And likewise here, and that would likely squash the sparse warning, 
since you would not be assigning an 'u32' field to a __le32 field anymore.
-- 
Florian

