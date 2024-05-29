Return-Path: <netdev+bounces-98835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F2B8D2988
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 02:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02783B23498
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE6415A49C;
	Wed, 29 May 2024 00:42:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6690A17E8E4;
	Wed, 29 May 2024 00:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716943371; cv=none; b=Nu5j690vFv/UySKHSvFi1PeL0bpBRg7CIP8D2oclrhl3tg8zbkvuREs9slN+CJmMbfNramUtBRCiI4rBLmfyY0dWmZCIz8wJrnQ/ipiUWbiz5D2ZYWVB2xIAVcqM2nlx8iFRnA5QNTaPYy8/P3Sdz0ohUf/KPNI2YwutQFGpZlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716943371; c=relaxed/simple;
	bh=ZucRrcqp4AB/Cp4ujq9cnHGw0SFHWRa7X600q2cNIQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWZl1+UQjcX8qfsV58CW2SF9KtZRNCzs3kR2KrPF7P18QjAypIjPbDiWsjcrmQlD6k9Ae+J5FsbQPRJeuW+o2RFpuXb8TW7ZBtHax0LzJ3tXlxTOFrgU4Go7kymhC/ZEtm0QBizyzaE4+c4+dz0P57nHuDrl2HP6FvtY0/BOkvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sC7Of-000000006rU-2SV6;
	Wed, 29 May 2024 00:42:29 +0000
Date: Wed, 29 May 2024 01:42:21 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Elad Yifee <eladwf@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v4] net: ethernet: mtk_eth_soc: ppe: add support
 for multiple PPEs
Message-ID: <ccfm3zhrhr767qjfaw4c7mvqw7bjbb4k4lgmvcogicak5sabsq@q547dfajx5au>
References: <20240511122659.13838-1-eladwf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511122659.13838-1-eladwf@gmail.com>

Hi Elad,

now that net-next is opened again I finally also had some time to take
a deeper look at your patch ;)

On Sat, May 11, 2024 at 03:26:53PM GMT, Elad Yifee wrote:
> Add the missing pieces to allow multiple PPEs units, one for each GMAC.
> [...]
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 179c0230655a..67e19bd25f7a 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> [...]
> @@ -1311,6 +1311,7 @@ struct mtk_eth {
>  struct mtk_mac {
>  	int				id;
>  	phy_interface_t			interface;
> +	u8						ppe_idx;

I think it would be smarter to just use
ifindex % mtk_get_ppe_num(eth)

Reasons:
 - no need for an additional field in mtk_mac
 - works for all net_device, not just mtk_eth type

>  	int				speed;
>  	struct device_node		*of_node;
>  	struct phylink			*phylink;
> @@ -1421,6 +1422,14 @@ static inline u32 mtk_get_ib2_multicast_mask(struct mtk_eth *eth)
>  	return MTK_FOE_IB2_MULTICAST;
>  }
>  
> +static inline u8 mtk_get_ppe_num(struct mtk_eth *eth)
> +{
> +	if (!eth->soc->offload_version)
> +		return 0;
> +
> +	return eth->soc->version;

Overloading the coincidentally identical hw version and number of PPEs
doesn't feel quite right. Better extend struct mtk_reg_map and turn the
gdma_to_ppe field into an array. Then the number of PPEs for a specific
SoC is the size of that array.

Reasons:
 - we already got that mtk_reg_map structure for hw abstraction, no
   need to introduce more SoC-specific macros like MTK_GDMA_TO_PPEx.
 - no need for mtk_get_ppe_num inline function, or at least no
   overloading of offload_version meaning.


Cheers


Daniel

