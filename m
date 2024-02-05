Return-Path: <netdev+bounces-69258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B35C84A8B1
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A6929A98F
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE38B5731F;
	Mon,  5 Feb 2024 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciF9wfsi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2DF57315
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 21:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707168502; cv=none; b=Nx5OH0Ns5lKsaIA3TzeVuDt9i59fBSz44sbLRaGscYX4iMgeNa78OFGvwtGCKf2goFFhkz3HmwNCVrmUPsRFivsnYNjq6avJ1iic042No/GX5QEEfEGZwDkMNXglRnAiKdmgJ4ppWkPeh9zD2Hfeevh9eottw9t1evIUA0mHEmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707168502; c=relaxed/simple;
	bh=nAvWpLsX2JQ4+oD/a2nkl1+MSrJedxvYJZt1g9bL1l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFzmhOqrFxVSG33RKt0urAH0FfFyF3Dl0V4psRwqqt+pQXEjYHi42ylPQiJx46OEXDRj5IxywSJ8vn8N3avWpEaqKJU52HdQd3BzzfgaZfcSiSLqccXUga5AohhhJWx3zp3t2pil5DeLBj5bS568TtjJYHqjdgZPQxP3SU0jVdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciF9wfsi; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5114cd44fdbso3084849e87.2
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 13:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707168499; x=1707773299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4eBqka1RXaZt2hbIbGSGtpl8/fMfvSSsmNULRU3d24M=;
        b=ciF9wfsiKjXsAVkCv6merbsMUZQgCTteKHRc9I9ScOe4IunVe02XT9GQCz1PO6m/hU
         rtIonhuNUfarh7sGFg0bf4jvqe9RL6+vVtXNoBDCoFN3AqhPc14aA/aDGi5CKuHK2pjE
         esXVgUN/ZgJmrjOXvqMqGEtKetU2R/+g/S0WA7Bq0e10Xx3J1DjRbS/4pGvVJhbfc/0k
         5qc+kFXKsYmbhrj1LK2LJEQhB+W7M7Vg8YFQ6EmFaa5JYOJRG4enC+qyNkNj1C6+f46m
         iz+zLTvT2mt0CvWM8NzSs8FkFfhQjb7GWVQT7Hk3Z8im/b6CHv1IPhYv/PfHo2+AjIzd
         tKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707168499; x=1707773299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eBqka1RXaZt2hbIbGSGtpl8/fMfvSSsmNULRU3d24M=;
        b=pBiiJoNW8RTfVC6U4zsSASZ6Upd1ZBsbnio8oOuvz6GumMWbWtFqPrfMOKJgZpn2r+
         E08uquVOFa4HEwbl/UPG/G/sKXLNFj2oV4XZ71zKdSC1vJEBEEwRkpj0TXPNMqhMkbpI
         2T4mVB8S/FBsXRU5zIX3I31mxsQuO5rTwzGPOe287X/JWPh5PgY+iId88HvfrhqfE97e
         R8EUOlYMWuX7LlwvS2xbPPUCYwvZajaimHY6jWgUMgAvoOBBaY1meLeqjubBQeNHiwG4
         JJd+qOGQgK7NXl8cIv/gxDOFxPeXp2N5IiGYUb5GWqGKXPp3kk0wVUypdtvre/q6wkgd
         REsA==
X-Gm-Message-State: AOJu0Yxnu1hDZNNDCww8sB3k4zpjcc66Om1lNDAi30C9mfUD31bK030c
	NE+svUeC0PZ6IkwyICLvaeCvNzITSSazXLruihUv4OWKLVXhP686oEG+1Gsyow0=
X-Google-Smtp-Source: AGHT+IHWNB5dlns7Ri8aKpYi7H9+IQx/VQo8ycheS8rZuXYulfpF+wayHLyyLq/4aiz53IEVXSIMVg==
X-Received: by 2002:a19:4f11:0:b0:510:1b65:dd97 with SMTP id d17-20020a194f11000000b005101b65dd97mr515948lfb.17.1707168498405;
        Mon, 05 Feb 2024 13:28:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVkagmrAsLWqyUQIF0tNPLnQ6Ugz/jNgq2L8bccHHKyjlnx9ZzE2710KnCwa7xmQg4qL5zGv0/WJOjuW5kSJCj7kCnFsRLYR7eWmIDNuTR20qEPlAzu7EtXiMzXowl5ZP2OeUe1zVdiOgpYZrtqqupBzSjvKYik44N9yLMBTc2hPgWTtBkOl+Ljrx7cRNaHXGRurKiF1aOZpH8gkQreRCeRp+YO9q1ZvKCiqM/KnZbcO+5OCtxnyEVf1wqhFRy1e/Qigm1BW6MHNEK4DIYm+KsXRdWtLBX/GpQj8k7/NX8/pNy8rchA6SPWUUHGV5NT6FxTk7/Rsu+1M8fCSYAF+ChLLhLLZWBi0cXmL9jeL4tKU9AuLpdVLPU+9NxwlwQKkmlxccoNdA==
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id u5-20020ac243c5000000b005114ee99515sm56829lfl.220.2024.02.05.13.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:28:17 -0800 (PST)
Date: Tue, 6 Feb 2024 00:28:16 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 07/11] net: stmmac: dwmac-loongson: Add
 multi-channel supports for loongson
Message-ID: <eqecwmi3guwda3wloxcttkx2xlteupvrsetb5ro5abupwhxqyu@ypliwpyswy23>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <bec0d6bf78c0dcf4797a148e3509058e46ccdb13.1706601050.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bec0d6bf78c0dcf4797a148e3509058e46ccdb13.1706601050.git.siyanteng@loongson.cn>

On Tue, Jan 30, 2024 at 04:48:19PM +0800, Yanteng Si wrote:
> Request allocation for MSI for specific versions.
>

Please elaborate what is actually done in the patch. What device
version it is dedicated for (Loongson GNET?), what IRQs the patch
adds, etc.

BTW will GNET device work without this patch? If no you need to either
merge it into the patch introducing the GNET-device support or place
it before that patch (6/11).
 
> Some features of Loongson platforms are bound to the GMAC_VERSION
> register. We have to read its value in order to get the correct channel
> number.

This message seems misleading. I don't see you doing that in the patch below...

> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 57 +++++++++++++++----
>  1 file changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 584f7322bd3e..60d0a122d7c9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -98,10 +98,10 @@ static void dwlgmac_dma_init_channel(struct stmmac_priv *priv,
>  	if (dma_cfg->aal)
>  		value |= DMA_BUS_MODE_AAL;
> 
 
> -	writel(value, ioaddr + DMA_BUS_MODE);
> +	writel(value, ioaddr + DMA_CHAN_BUS_MODE(chan));
>  
>  	/* Mask interrupts by writing to CSR7 */
> -	writel(DMA_INTR_DEFAULT_MASK_LOONGSON, ioaddr + DMA_INTR_ENA);
> +	writel(DMA_INTR_DEFAULT_MASK_LOONGSON, ioaddr + DMA_CHAN_INTR_ENA(chan));

Em, why is this here? There is a patch
[PATCH net-next v8 05/11] net: stmmac: dwmac-loongson: Add Loongson-specific register definitions
in this series which was supposed to introduce the fully functional
GNET-specific callbacks. Move this change in there.

>  }
>  
>  static int dwlgmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
> @@ -238,6 +238,45 @@ static int loongson_dwmac_config_legacy(struct pci_dev *pdev,
>  	return 0;
>  }
>  

> +static int loongson_dwmac_config_multi_msi(struct pci_dev *pdev,

This method seems like the GNET-specific one. What about using the
appropriate prefix then?

> +					   struct plat_stmmacenet_data *plat,
> +					   struct stmmac_resources *res,
> +					   struct device_node *np,

> +					   int channel_num)

Why do you need this parametrization? Since this method is
GNET-specific what about defining a macro with the channels amount and
using it here?

> +{
> +	int i, ret, vecs;
> +
> +	vecs = roundup_pow_of_two(channel_num * 2 + 1);
> +	ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);

> +	if (ret < 0) {
> +		dev_info(&pdev->dev,
> +			 "MSI enable failed, Fallback to legacy interrupt\n");
> +		return loongson_dwmac_config_legacy(pdev, plat, res, np);

In what conditions is this possible? Will the
loongson_dwmac_config_legacy() method work in that case? Did you test
it out?

> +	}
> +

> +	plat->rx_queues_to_use = channel_num;
> +	plat->tx_queues_to_use = channel_num;

This is supposed to be initialized in the setup() methods. Please move
it to the dedicated patch.

> +
> +	res->irq = pci_irq_vector(pdev, 0);

> +	res->wol_irq = res->irq;

Once again. wol_irq is optional. If there is no dedicated WoL IRQ
leave the field as zero.

> +
> +	/* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> +	 * --------- ----- -------- --------  ...  -------- --------
> +	 * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> +	 */
> +	for (i = 0; i < channel_num; i++) {
> +		res->rx_irq[channel_num - 1 - i] =
> +			pci_irq_vector(pdev, 1 + i * 2);
> +		res->tx_irq[channel_num - 1 - i] =
> +			pci_irq_vector(pdev, 2 + i * 2);
> +	}
> +
> +	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;

> +	dev_info(&pdev->dev, "%s: multi MSI enablement successful\n", __func__);

What's the point in printing this message especially with the __func__
prefix?  You'll always be able to figure out the allocated IRQs by
means of procfs. I suggest to drop it.

> +
> +	return 0;
> +}
> +

>  static void loongson_default_data(struct pci_dev *pdev,
>  				  struct plat_stmmacenet_data *plat)
>  {
> @@ -296,11 +335,8 @@ static int loongson_gmac_config(struct pci_dev *pdev,
>  				struct stmmac_resources *res,
>  				struct device_node *np)
>  {
> -	int ret;
> -
> -	ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static struct stmmac_pci_info loongson_gmac_pci_info = {
> @@ -380,11 +416,7 @@ static int loongson_gnet_config(struct pci_dev *pdev,
>  				struct stmmac_resources *res,
>  				struct device_node *np)
>  {
> -	int ret;
> -
> -	ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
> -
> -	return ret;
> +	return 0;
>  }

Here you are dropping the changes you just introduced leaving the
config() methods empty... Why not to place the
loongson_dwmac_config_legacy() invocation in the probe() method right
at the patches introducing the config() functions and not to add the
config() callback in the first place?

-Serge(y)

>  
>  static struct stmmac_pci_info loongson_gnet_pci_info = {
> @@ -483,6 +515,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>  		ld->dwlgmac_dma_ops.dma_interrupt = dwlgmac_dma_interrupt;
>  
>  		plat->setup = loongson_setup;
> +		ret = loongson_dwmac_config_multi_msi(pdev, plat, &res, np, 8);
> +	} else {
> +		ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
>  	}
>  
>  	plat->bsp_priv = ld;
> -- 
> 2.31.4
> 

