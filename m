Return-Path: <netdev+bounces-123915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4847B966D1D
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 01:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F6E284ADE
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB65E18FC61;
	Fri, 30 Aug 2024 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzqFxfOc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F8A17C7B3;
	Fri, 30 Aug 2024 23:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725062379; cv=none; b=EDhq6tt3gRFx+aaZ6+aWRmYtDv96cjHUXOP0Em3va4dFOigfzD94mhVU0Q+XW0Pq66LCZHIbrEgqjHg71D5lEHZlnYDjw2Ak/7SxeOnsKCcROlDxJG9ux7OJHzKOKNeNQerLc6lwklvSD5dO5taYC17izBiVvPAqyO2B1vw6vJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725062379; c=relaxed/simple;
	bh=WL+mPsmtKe4NMOEeuBOmY6UqNzIVj6D1MStQM/ZpovQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oO8NQNV/A1KF7k8Ws85PH7SZ78F9VtAWDocW0VT/cRNiDy0nCAfQ7iJNHB79ChXPW0yJA/1DdFnMkB+MejFjLyt15HjuCZhkBKPIYWCSrGjKxkhcp6HDIgVvVP8sbCqpdt2yUrXb7FuDbC8WnCwdcKRem5rffesQM+b8Y7YSpvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzqFxfOc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-204f52fe74dso21800285ad.1;
        Fri, 30 Aug 2024 16:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725062377; x=1725667177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sr+m/MCpvguQ1PEITzYf3gtI8iZ+jxmN3Qz312mDJ+Y=;
        b=IzqFxfOcCPeD18j2W4AzZS4uCmPV9NotUrQQPdRUVREpKfYJmFOYjVT9tAeA27bqkt
         GXyXqJ5SUTepvHwbNQnyFjrQPrwcRp0RtOegjANilXmP0jIzM2eIRbWmiAyvYjca0aq8
         WB76aUQo/FVteFQWBugzIdQDN9eLo723me2zeh/g16NxQp5+zBHPseKbUulISNsxliYQ
         nohT/7F+0Zu2s4WvN4vr392S96+VO4riqgR4JhOow7s1o8pi/MniUV5sAmCl691k8kLR
         DM6gAQfA8iv1N30lGIJXbHsd+hzlsbGejyIctk+vqcXaVDKIQZUrBQSZv/Q72A5Tlgnv
         YynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725062377; x=1725667177;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sr+m/MCpvguQ1PEITzYf3gtI8iZ+jxmN3Qz312mDJ+Y=;
        b=CRb9Dj31Tjp15tv923jDNmSZp/LBiPyqKgR0mn8BgWVomxUr8cj1jT0bqw4xzhNVsQ
         CfLezHc9hRDYZc64QrRKbgJSAtkgc2UIMh3cpXDWIW9QNP75xiRPKsQYQILul1xkmiR/
         y4BUx4VYB0lQVJ/SuwgvhnKCRja6rQ9jlygAi7G5WqCUbB2xrWFNV7+ItbfFIqjVBiX2
         isZXMF8mfjQ0l+VPpLqR8JdEx6ggP5SRoJB0Ewf977E0vx/kwApmrdrMETp4cDKdQ7Hd
         oHwNPmEA7M4teJdZMhXQ0LDsvhxNpgrIT11izgU32/+UqMyHqqIzlmYcfYpgiiuiuJ24
         iJ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdQCKBtecdtDJFs0O2SJsZhFTzbbJtT7SoPk7FfhlzkfOMlXZLD5BwM6S48lGGoz/BAUFmAO0F@vger.kernel.org, AJvYcCXR7QtmeKSMxmbYGWjhRKK2ZzrDoQ3g8BGXDjv8cALNWsn9JdFtp8dTlg7d+FYKuS5JryPDWSiFZow9pIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/xhp1yAHQOf8FqFFm8SNdRj0BmrhpDEudsNU7kBu8GILuIxIb
	PzHuY4/xdZLHq0SNPT+1IGROAp3epi1H+Szxm1/kIw8EYSUJpnq/
X-Google-Smtp-Source: AGHT+IHAQjId6GpdvBN5Oyuv2ZrrV71Pt4bk2AIiEuJwheyfWAw667JccSxOY37LyeSAoczElPRHIw==
X-Received: by 2002:a17:902:da86:b0:1fc:5ed5:ff56 with SMTP id d9443c01a7336-20546b55c5dmr8024345ad.61.1725062377258;
        Fri, 30 Aug 2024 16:59:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2052a6843f3sm15745525ad.43.2024.08.30.16.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 16:59:36 -0700 (PDT)
Message-ID: <95ce8d16-17bf-490e-a084-ac16fe8ba813@gmail.com>
Date: Fri, 30 Aug 2024 16:59:35 -0700
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

