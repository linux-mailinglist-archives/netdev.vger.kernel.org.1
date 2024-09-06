Return-Path: <netdev+bounces-126073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C599F96FD8B
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34601C22656
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 21:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0727E158875;
	Fri,  6 Sep 2024 21:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaZLHNeR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7608158A00
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 21:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725659347; cv=none; b=nGYgzBAvjIyrEFSOa5eJMAYBLnlwkgxUjy39YMAFMNU4Wv3tgarS5on2j4rhMyvnDBGh4YNVjn2ZOdFXp/lqTWQd8Ge2S0M+ZIsqjoIPKclxJ0ARlEQKqhFZnqWjP9UX5j0Ic7zC3UJXYllsCLdNJey8HNYWFP/s9mz6gWRVMIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725659347; c=relaxed/simple;
	bh=qq1ffs+/7JUjBSLgcnLZwjyMPtUiuz08uyr/sMy8CMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4ji8Rx8VIJx7/fV/yTXopdD3xTQfLoyKZqIITK/pFWqKQn5+oma4ukBVDd1//EH5IeAvZK6ZOO8g+tZfxAkhPsi7GEpY+q2i+cDYiNjT1BtfRFeZRckFdiHjbphO9uuA0T75GMKYp1cJFV6Dfg44rI7v9AY2T80CkFmW0rQRms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LaZLHNeR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725659344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J3S1ye9K4wT6nEVtEXBj1KVlsV65nHxPTfNQ0beqpus=;
	b=LaZLHNeRcmDNgJICYmF+whQ0j/runpOGgSOj40Nzc5KNTiUWcR17zhjMzJzer5DyewTXF6
	gG3gFS14B4dguIL3CaLQm1eENaCd9rcp10Ii5x4QHw3kalnGG6YCL8eus2k/1f8UjqAYFA
	LlJ7gaHktD3jQ+JQwr6MovSEgNcD2JY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-wMH0cCZjPhmdMX5xCFk2gw-1; Fri, 06 Sep 2024 17:49:03 -0400
X-MC-Unique: wMH0cCZjPhmdMX5xCFk2gw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3dfc0631c56so2486340b6e.1
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 14:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725659343; x=1726264143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3S1ye9K4wT6nEVtEXBj1KVlsV65nHxPTfNQ0beqpus=;
        b=wy4fdF4Ht4cIhwFTfGr5Y7dUw3nPOWY+AUHDgbje+LSh6QlTwxjg5ISzgoE3h67ZDq
         Xt4El0iknAdi33+FDKbs7RdQNi8BU1Qw+5k+o4rd93g4YxuHMKoViggQJawOAebHxzSn
         dqhwGPbdZVqr9ciRejc+MxIncYWADwODtSwFquGeVRYeDljitGLuzViKmqwHwSV4SeUe
         TrcZf9g2SDclbHwsvnIiRZQxdzSS8/swdUIno9dvmDTuzJitxuK7y+xjkIDNpG3JPkGs
         l/gOv+B+/3xK6KR9mU6kWRvlF3V7fjx7VqxFdYJHFSirNKh3PoYrOs2g4G5VVt3Alv3j
         ILEg==
X-Forwarded-Encrypted: i=1; AJvYcCV0SpuAYnB9inaB1zlFP5uZfBT0t28xyFQu24/smRl0wUcOKVcbRecaIDskxM+xyaaWpoe7xrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY8XQb32eFp4hthBdiMOz5raG7Jp268W1RDfBiup7x/isM1vhx
	Z8Yq1cd5R1EteyA4VcoLu7VBT2WDFHTTSSmEdz5RWurXgRcp8WCmhFrjLBDyWM+tBBOzPqANRMa
	UgW1IacMXR6jqfsS/wOHCN85u5XZfqMh4dbapztLtDhhr0+3ZIyOWlg==
X-Received: by 2002:a05:6808:2e87:b0:3da:aae9:7182 with SMTP id 5614622812f47-3e029cd2afamr6368584b6e.2.1725659342845;
        Fri, 06 Sep 2024 14:49:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5efmeD2tGwhppF0F5BJUioUdGUqHxc6RT9wSI/W7CD4lhjJKWUhSBBA5JuPCwsydP2SlphQ==
X-Received: by 2002:a05:6808:2e87:b0:3da:aae9:7182 with SMTP id 5614622812f47-3e029cd2afamr6368559b6e.2.1725659342554;
        Fri, 06 Sep 2024 14:49:02 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801dc378csm19559821cf.96.2024.09.06.14.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 14:49:02 -0700 (PDT)
Date: Fri, 6 Sep 2024 16:49:00 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com
Subject: Re: [PATCH net-next v1] net: stmmac: Programming sequence for VLAN
 packets with split header
Message-ID: <jfibug2d5ch6isoop3gbjkbt2kbk2bvhvschnwclyr42p2aqmn@2iigwb3jk5ew>
References: <20240904235456.2663335-1-quic_abchauha@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904235456.2663335-1-quic_abchauha@quicinc.com>

On Wed, Sep 04, 2024 at 04:54:56PM GMT, Abhishek Chauhan wrote:
> Currently reset state configuration of split header works fine for
> non-tagged packets and we see no corruption in payload of any size
> 
> We need additional programming sequence with reset configuration to
> handle VLAN tagged packets to avoid corruption in payload for packets
> of size greater than 256 bytes.
> 
> Without this change ping application complains about corruption
> in payload when the size of the VLAN packet exceeds 256 bytes.
> 
> With this change tagged and non-tagged packets of any size works fine
> and there is no corruption seen.

My real limited understanding from offline convos with you is that:

    1. This changes splitting from L3 mode to L2? This maybe a "dumb"
       wording, but the L2 comment you have below reinforces that.
       Sorry, I don't have a very good mental model of what SPH is doing
    2. This addresses the root issue of a few of the commits in
       stmmac that disable split header? Patches like
       47f753c1108e net: stmmac: disable Split Header (SPH) for Intel platforms
       029c1c2059e9 net: stmmac: dwc-qos: Disable split header for Tegra194
       ?

If 1 is true I suggest making trying to paint a higher level intro picture to
reviewers of what the prior programming enabled vs what you've enabled.
It would help me at least!

If 2 is true I suggest calling that out and Cc'ing the authors of those
patches in hopes that they may try and re-enable SPH. If its not true
(maybe there's an errata?) I'd be interested in knowing if there's a more
generic way to disable SPH for those platforms instead of playing
whack-a-mole per platform. That's a bit outside of the series here though,
but I imagine you may have enough information to help answer those sort of
questions and clean up the house here :)

Thanks,
Andrew


> 
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
> Changes since v0
> - The reason for posting it on net-next is to enable this new feature.
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac4.h     |  9 +++++++++
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 11 +++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
> index 93a78fd0737b..4e340937dc78 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
> @@ -44,6 +44,7 @@
>  #define GMAC_MDIO_DATA			0x00000204
>  #define GMAC_GPIO_STATUS		0x0000020C
>  #define GMAC_ARP_ADDR			0x00000210
> +#define GMAC_EXT_CFG1			0x00000238
>  #define GMAC_ADDR_HIGH(reg)		(0x300 + reg * 8)
>  #define GMAC_ADDR_LOW(reg)		(0x304 + reg * 8)
>  #define GMAC_L3L4_CTRL(reg)		(0x900 + (reg) * 0x30)
> @@ -235,6 +236,14 @@ enum power_event {
>  #define GMAC_CONFIG_HDSMS_SHIFT		20
>  #define GMAC_CONFIG_HDSMS_256		(0x2 << GMAC_CONFIG_HDSMS_SHIFT)
>  
> +/* MAC extended config1 */
> +#define GMAC_CONFIG1_SAVE_EN		BIT(24)
> +#define GMAC_CONFIG1_SPLM		GENMASK(9, 8)
> +#define GMAC_CONFIG1_SPLM_L2OFST_EN	BIT(0)
> +#define GMAC_CONFIG1_SPLM_SHIFT		8
> +#define GMAC_CONFIG1_SAVO		GENMASK(22, 16)
> +#define GMAC_CONFIG1_SAVO_SHIFT		16
> +
>  /* MAC HW features0 bitmap */
>  #define GMAC_HW_FEAT_SAVLANINS		BIT(27)
>  #define GMAC_HW_FEAT_ADDMAC		BIT(18)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> index e0165358c4ac..dbd1be4e4a92 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> @@ -526,6 +526,17 @@ static void dwmac4_enable_sph(struct stmmac_priv *priv, void __iomem *ioaddr,
>  	value |= GMAC_CONFIG_HDSMS_256; /* Segment max 256 bytes */
>  	writel(value, ioaddr + GMAC_EXT_CONFIG);
>  
> +	/* Additional configuration to handle VLAN tagged packets */
> +	value = readl(ioaddr + GMAC_EXT_CFG1);
> +	value &= ~GMAC_CONFIG1_SPLM;
> +	/* Enable Split mode for header and payload at L2  */
> +	value |= GMAC_CONFIG1_SPLM_L2OFST_EN << GMAC_CONFIG1_SPLM_SHIFT;
> +	value &= ~GMAC_CONFIG1_SAVO;
> +	/* Enables the MAC to distinguish between tagged vs untagged pkts */
> +	value |= 4 << GMAC_CONFIG1_SAVO_SHIFT;
> +	value |= GMAC_CONFIG1_SAVE_EN;
> +	writel(value, ioaddr + GMAC_EXT_CFG1);
> +
>  	value = readl(ioaddr + DMA_CHAN_CONTROL(dwmac4_addrs, chan));
>  	if (en)
>  		value |= DMA_CONTROL_SPH;
> -- 
> 2.25.1
> 


