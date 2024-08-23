Return-Path: <netdev+bounces-121323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E08C95CB8D
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05801281BB9
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 11:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCA518754E;
	Fri, 23 Aug 2024 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnQIgjdc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6857F3F9F9;
	Fri, 23 Aug 2024 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724413166; cv=none; b=dDORFwuQUmS9gyRjwhBUT5VnO0iWdm4u+AJp8miE5yWouwzcyL0Raewo4V270bh8vcKHsH3sv3JqDip4K+JJy1Sr3BmpAn1vjVG5lVvHwmVmsnmS+dC1ZCnrU0ULNB9RdMERs0B1mxMVncX6NoCO9ESMC0LQF9UnVqxltWOmRbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724413166; c=relaxed/simple;
	bh=sb+hpl867oAfblXBX+bXv7OUlpJXYOebFkKUk5Pr/B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5cO2Y2JMK13itIpqZ8UWZMiN//Hjt9BsrMAf5rTuDKU/fww8CYHB0CT248ogL+FZ0WaYo2Oreh6FzvfjsYap3XAR2PxlOCVvTu1JGF01JY9hZtnAtuRZFXUOaCNJ4mttBxjRuTDJ3q1c94xmSvdu6LAgE7ru9hWZAeN9w6uKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnQIgjdc; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso17588251fa.2;
        Fri, 23 Aug 2024 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724413162; x=1725017962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jlruKgWSyuzMsIHMo/qBZLFbjRmtSnM9kjyIrTE/wvg=;
        b=mnQIgjdcD++PfVAl8S5zDVwiig0hXUVT6yeLLK3BsMuYMfTuUCnkmHCmweWVy29zcf
         ifvkl0QR+4oOwab369/Obr+cSD8PxSayBicCEaduDw5Cd7aeJMpvvx3py6pePgUI5QZE
         yfpvvQpy7v3V6SivqZGBtTuRt7K/tOtqmpYUwt8lPF8r2sg66BhFAKCyTjK0LS0n/scL
         ROH048wgIr72Ijcr48GqSiaF5BQwSv8OSL1HrH2oHEMZMSGwZE6oSJ10FKz1whDiFdRS
         +9PV+2uvHKXRZ1ynTj6MHH4KAAvmE3p/ZjJPvK2qFA7ryizIbNNHwGVAA5ctbM6uh9Dj
         JeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724413162; x=1725017962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlruKgWSyuzMsIHMo/qBZLFbjRmtSnM9kjyIrTE/wvg=;
        b=Dk3sGNvn819QHAVOd2ovhKgmoAwn3laEriOO2u0s/AXEnEujr/PPq1xAn0z1nLMBuC
         HCZftKMyfY/MQ5dil7RY+fvjx7GUoeF+++IjEzz6Vjej1EflurNzO5ubtZ6CtZfzv+ps
         pRcsk1i/DdL/LbCdRKwyLmcfI8voDwcLT5Hk1q6g31pMIIxOK5hf07nM9mJKbL8VQJ3N
         sQdsOmKgsokk+Xo5s+b+p0gGBH1HAziIsH2DQxqdQDhfyz4RHF//6BT9R3q/iV2lbtfB
         0lRp9F2lK+9LkHkH5Ci4WutS5n/qYpc9z3R3sjxuw4a+SGlM0ocXqiHwiRpChHR28bc+
         NebQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8GuH4yxxULsjBw9MDsXEWD1Cos3lEZ0sTvoNcC4Hen7u0AAvTOFwgPpoIjfQXDELZonedBt64rA6Ot3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Lr6uzhZQb7SObUBvkDZPMuClzszbj20mYu60+Ew75kajyT5+
	y4042YRS6GUCIa4bxfJVur/Po+t7iUkK1uggFDUAxnR9Dd+G+dat
X-Google-Smtp-Source: AGHT+IGFZsbaVFFRPu1XfQgRoVIGdIfcvZRHBov5lLf0J3VMkYh9shDO4B98AiQLhmcrPhVqhMokVg==
X-Received: by 2002:a2e:bea8:0:b0:2ef:296d:1dd5 with SMTP id 38308e7fff4ca-2f4f4745a34mr18409651fa.0.1724413161623;
        Fri, 23 Aug 2024 04:39:21 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f4047a4ed4sm4527191fa.10.2024.08.23.04.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 04:39:21 -0700 (PDT)
Date: Fri, 23 Aug 2024 14:39:18 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: ende.tan@starfivetech.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	leyfoon.tan@starfivetech.com, minda.chen@starfivetech.com, endeneer@gmail.com
Subject: Re: [net-next,v2,1/1] net: stmmac: Add dma_wmb() barrier before
 setting OWN bit in set_rx_owner()
Message-ID: <hq3rdtfobswczm5aecjezmm5isitquedryhjiw64n4bp2rhqyj@mvhhyanfbmuz>
References: <20240821060307.46350-1-ende.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821060307.46350-1-ende.tan@starfivetech.com>

Hi Tan

On Wed, Aug 21, 2024 at 02:03:07PM +0800, ende.tan@starfivetech.com wrote:
> From: Tan En De <ende.tan@starfivetech.com>
> 
> Currently, some set_rx_owner() callbacks set interrupt-on-completion bit
> in addition to OWN bit, without inserting a dma_wmb() barrier in
> between. This might cause missed interrupt if the DMA sees the OWN bit
> before the interrupt-on-completion bit is set.
> 
> Thus, this patch adds dma_wmb() barrier right before setting OWN bit in
> each of the callbacks. Now that the responsibility of calling dma_wmb()
> is delegated to the callbacks, let's simplify main driver code by
> removing dma_wmb() before stmmac_set_rx_owner().
> 
> Signed-off-by: Tan En De <ende.tan@starfivetech.com>
> ---
> v2:
> - Avoid introducing a new function just to set the interrupt-on-completion
>   bit, as it is wasteful to do so.
> - Delegate the responsibility of calling dma_wmb() from main driver code
>   to set_rx_owner() callbacks (i.e. let callbacks to manage the low-level
>   ordering/barrier rather than cluttering up the main driver code).
> v1:
> - https://patchwork.kernel.org/project/netdevbpf/patch/20240814092438.3129-1-ende.tan@starfivetech.com/
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c   | 5 ++++-
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c | 5 +++--
>  drivers/net/ethernet/stmicro/stmmac/enh_desc.c       | 1 +
>  drivers/net/ethernet/stmicro/stmmac/norm_desc.c      | 1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 2 --
>  5 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> index 1c5802e0d7f4..95aea6ad485b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> @@ -186,10 +186,13 @@ static void dwmac4_set_tx_owner(struct dma_desc *p)
>  
>  static void dwmac4_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
>  {

> -	p->des3 |= cpu_to_le32(RDES3_OWN | RDES3_BUFFER1_VALID_ADDR);
> +	p->des3 |= cpu_to_le32(RDES3_BUFFER1_VALID_ADDR);
>  
>  	if (!disable_rx_ic)
>  		p->des3 |= cpu_to_le32(RDES3_INT_ON_COMPLETION_EN);
> +
> +	dma_wmb();
> +	p->des3 |= cpu_to_le32(RDES3_OWN);
>  }
>  
>  static int dwmac4_get_tx_ls(struct dma_desc *p)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> index fc82862a612c..d76ae833c840 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> @@ -56,10 +56,11 @@ static void dwxgmac2_set_tx_owner(struct dma_desc *p)
>  
>  static void dwxgmac2_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
>  {
> -	p->des3 |= cpu_to_le32(XGMAC_RDES3_OWN);
> -
>  	if (!disable_rx_ic)
>  		p->des3 |= cpu_to_le32(XGMAC_RDES3_IOC);
> +
> +	dma_wmb();
> +	p->des3 |= cpu_to_le32(XGMAC_RDES3_OWN);

I am not against moving the barrier here but really I don't see a firm
reason of why you can't collect the flags in a local variable and
then flush it out to the DES3 field.

Getting back to your discussion with Andrew:
https://lore.kernel.org/netdev/06297829-0bf7-4a06-baaf-e32c39888947@lunn.ch/
you said:

> I didn't use local variable because I worry about CPU out-of-order execution. 
> For example,
> ```
> local_var = (INT_ON_COMPLETION | OWN)
> des3 |= local_var
> ```
> CPU optimization might result in this
> ```
> des3 |= INT_ON_COMPLETION
> des3 |= OWN
> ```
> or worst, out of order like this
> ```
> des3 |= OWN
> des3 |= INT_ON_COMPLETION
> ```

Why do you think the CPU would split up the pre-initialized local
variable write into the two-staged write?

Anyway Andrew is right about the descriptors memory nature. It's a
coherent memory to which the access is expensive and should be
minimized as much as possible.

-Serge(y)

>  }
>  
>  static int dwxgmac2_get_tx_ls(struct dma_desc *p)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
> index 937b7a0466fc..9219fe69ea44 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
> @@ -289,6 +289,7 @@ static void enh_desc_set_tx_owner(struct dma_desc *p)
>  
>  static void enh_desc_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
>  {
> +	dma_wmb();
>  	p->des0 |= cpu_to_le32(RDES0_OWN);
>  }
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
> index 68a7cfcb1d8f..d0b703a3346f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
> @@ -155,6 +155,7 @@ static void ndesc_set_tx_owner(struct dma_desc *p)
>  
>  static void ndesc_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
>  {
> +	dma_wmb();
>  	p->des0 |= cpu_to_le32(RDES0_OWN);
>  }
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index d9fca8d1227c..859a2c4c9e5c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4848,7 +4848,6 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
>  		if (!priv->use_riwt)
>  			use_rx_wd = false;
>  
> -		dma_wmb();
>  		stmmac_set_rx_owner(priv, p, use_rx_wd);
>  
>  		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_rx_size);
> @@ -5205,7 +5204,6 @@ static bool stmmac_rx_refill_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>  		if (!priv->use_riwt)
>  			use_rx_wd = false;
>  
> -		dma_wmb();
>  		stmmac_set_rx_owner(priv, rx_desc, use_rx_wd);
>  
>  		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_rx_size);
> -- 
> 2.34.1
> 
> 

