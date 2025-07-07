Return-Path: <netdev+bounces-204543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C30AAAFB17C
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 12:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685A01AA1D97
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7766F293C72;
	Mon,  7 Jul 2025 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiDoMvaM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475FA288C8D;
	Mon,  7 Jul 2025 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751885015; cv=none; b=foYk78YXBAi1jMq8tBxS0bFkdKT+UqHKAnkXFzZ8250Q93abDhAPDzVEhibXQvFlQYH1LKUXZwzIqy3mW7eem9qMtQYonzPZAMr06IWmCG/wApFlQC3p8avjqKS6cF12mYAvJsHVGNZMPt5UgDl6A74g8bS97TO5TbREx6/gqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751885015; c=relaxed/simple;
	bh=ZAHncvRq/os3HYtn8J7X9/8sN0J5JEZiybhSWcC8h+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vol3DIqJTVxYG9CIJoPSmm6dy9s3iA4vgBO1yGjDDa0WQX/OYSk/qUSBYlP25UsfECHR/xqQp1HInq0G2TKFIDJBrKzRF1U1all5iRqOxxYY0omF9UubLNsie2EjNusmGOlYvB9bTk3Abfe5lDSwHXjzDbkoVTqp+JiQGlxMIbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiDoMvaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED05DC4CEF5;
	Mon,  7 Jul 2025 10:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751885014;
	bh=ZAHncvRq/os3HYtn8J7X9/8sN0J5JEZiybhSWcC8h+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QiDoMvaMaEtgtwLkbm7fWeJkr74MnR9ckIpH80fi864JSTlJW8GAN+l4MQWNo/QIr
	 KDoX+f13espcJXebVoABhzBqq8HV+GR1+B27AMR1DUe7cOvaBti79jKPsDVm40IQKv
	 6wd5DeUd8v6lV9xth8qOBezBUrCPRfODIbomdLpfUmgkeIUKIx5/GUpwxVRLgVDpXt
	 0lJGqztvJw9fvqFYY1wZ018EOUwfoslkiwCMdpHT2lP4Mg0dAo5FsnvO/9VLI1hDBl
	 zamXhcQZEOLlZVd7alhNqDcn8BuEzs4w1CZe3YRmg0cROX90bT4zliB2UFS/1+9nOL
	 WLgwzoxlObrCA==
Date: Mon, 7 Jul 2025 11:43:29 +0100
From: Simon Horman <horms@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alex Elder <elder@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Use of_reserved_mem_region_to_resource{_byname}()
 for "memory-region"
Message-ID: <20250707104329.GF89747@horms.kernel.org>
References: <20250703183459.2074381-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703183459.2074381-1-robh@kernel.org>

On Thu, Jul 03, 2025 at 01:34:57PM -0500, Rob Herring (Arm) wrote:
> Use the newly added of_reserved_mem_region_to_resource{_byname}()
> functions to handle "memory-region" properties.
> 
> The error handling is a bit different for mtk_wed_mcu_load_firmware().
> A failed match of the "memory-region-names" would skip the entry, but
> then other errors in the lookup and retrieval of the address would not
> skip the entry. However, that distinction is not really important.
> Either the region is available and usable or it is not. So now, errors
> from of_reserved_mem_region_to_resource() are ignored so the region is
> simply skipped.

Thanks for explaining this, it's much appreciated.

> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_npu.c    | 25 ++++++----------
>  drivers/net/ethernet/mediatek/mtk_wed.c     | 24 ++++------------
>  drivers/net/ethernet/mediatek/mtk_wed_mcu.c | 32 +++++++--------------
>  drivers/net/ipa/ipa_main.c                  | 12 ++------

FWIIW, I would slightly prefer one patch per driver.

...

> diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
> index 351dd152f4f3..73c26fcfd85e 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> @@ -1318,26 +1318,14 @@ mtk_wed_rro_ring_alloc(struct mtk_wed_device *dev, struct mtk_wed_ring *ring,
>  static int
>  mtk_wed_rro_alloc(struct mtk_wed_device *dev)
>  {
> -	struct reserved_mem *rmem;
> -	struct device_node *np;
> -	int index;
> +	struct resource res;
> +	int ret;
>  
> -	index = of_property_match_string(dev->hw->node, "memory-region-names",
> -					 "wo-dlm");
> -	if (index < 0)
> -		return index;
> -
> -	np = of_parse_phandle(dev->hw->node, "memory-region", index);
> -	if (!np)
> -		return -ENODEV;
> -
> -	rmem = of_reserved_mem_lookup(np);
> -	of_node_put(np);
> -
> -	if (!rmem)
> -		return -ENODEV;
> +	ret = of_reserved_mem_region_to_resource_byname(dev->hw->node, "wo-dlm", &res);

Please consider line-wrapping the line above so it is 80 columns wide or
less, as is still preferred for Networking code.

> +	if (ret)
> +		return ret;
>  
> -	dev->rro.miod_phys = rmem->base;
> +	dev->rro.miod_phys = res.start;
>  	dev->rro.fdbk_phys = MTK_WED_MIOD_COUNT + dev->rro.miod_phys;
>  
>  	return mtk_wed_rro_ring_alloc(dev, &dev->rro.ring,

> diff --git a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c

...

> @@ -319,13 +313,7 @@ mtk_wed_mcu_load_firmware(struct mtk_wed_wo *wo)
>  
>  	/* load firmware region metadata */
>  	for (i = 0; i < ARRAY_SIZE(mem_region); i++) {
> -		int index = of_property_match_string(wo->hw->node,
> -						     "memory-region-names",
> -						     mem_region[i].name);
> -		if (index < 0)
> -			continue;
> -
> -		ret = mtk_wed_get_memory_region(wo->hw, index, &mem_region[i]);
> +		ret = mtk_wed_get_memory_region(wo->hw, mem_region[i].name, &mem_region[i]);

Ditto.

>  		if (ret)
>  			return ret;
>  	}

...

