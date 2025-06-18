Return-Path: <netdev+bounces-199169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C41ADF4D5
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04246189453A
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1441B2FA62C;
	Wed, 18 Jun 2025 17:42:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DA12FA62F;
	Wed, 18 Jun 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268532; cv=none; b=kbSf0JM/fTwwCgKHbOMcCzilGbQZeMBdywf84KuUAdNmpSo0LSKk7JZ2+/yb5PJIZWP/PKhGT+FlGZ7Y+ud6p6PdC6urvHBMKGDjBnjj4TSNN2D6oIqWeUw/8EBdYuO6IWPOMjOZddMM+hKoj0rktB0dpVWi6DRJAHYsOq8kY6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268532; c=relaxed/simple;
	bh=PFOvRPg2CJBPcJUPWyP7JdVspRXn33CIKGD2PUZrvUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iaik5aBcpnFOKmvpFZZzBEBnsRlRFa0lFigdZUboV/W3igliFxVVrHwrIOtTfP8vo2GfCPP+JtBsjGtywqsLA1e9C3KT3f9PSz5dqoCcUrJhkdbhsdbuOyByQNZpDz9ozcqZgOgWoWILyfho2uchWW5spfwS36/AvTOAJOZV6C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uRwez-000000004uy-0gef;
	Wed, 18 Jun 2025 17:41:59 +0000
Date: Wed, 18 Jun 2025 19:41:50 +0200
From: Daniel Golle <daniel@makrotopia.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, Simon Horman <horms@kernel.org>,
	arinc.unal@arinc9.com
Subject: Re: [net-next v5 3/3] net: ethernet: mtk_eth_soc: skip first IRQ if
 not used
Message-ID: <aFL6XhghHobju0th@pidgin.makrotopia.org>
References: <20250618130717.75839-1-linux@fw-web.de>
 <20250618130717.75839-4-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618130717.75839-4-linux@fw-web.de>

On Wed, Jun 18, 2025 at 03:07:14PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> On SoCs without MTK_SHARED_INT capability (all except mt7621 and
> mt7628) platform_get_irq() is called for the first IRQ (eth->irq[0])
> but it is never used.

I know that technically MTK_SHARED_INT is a capability flag, but it's
rather a non-capability. Hardware having dedicated interrupts for RX and
TX is "more capable" than (older, legacy) hardware with just one shared
interrupt for both...

So maybe better:
"On SoCs with dedicated RX and TX interrupts (all except MT7621 and
MT7628) ..."

Reading the datasheet of some recent MediaTek SoC it is worth
noting that there are 4 interrupts assigned to the frame engine and
the FE_INT_GRP register can be used to assign functions to them.

So technically, calling them RX and TX in DT is wrong, becaues they
are fe_int0, fe_int1, fe_int2 and fe_int3, which are then assigned
one or more functions by the driver using that FE_INT_GRP register.

However, it's the driver then assigns QDMA TX to fe_int1 and RX to
fe_int2 while leaving fe_int0 and fe_int3 unsued.

That's what the magic value 0x21021000 which is written to FE_INT_GRP
register does.

On MT7988 and newer, in addition to those 4 frame engine interrupts
there are **another 4** interrupts for PDMA, typically used to
service 4 RX rings while one of the fe_int* is used to indicate
TX done.

> Skip the first IRQ and reduce the IRQ-count to 2.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v5:
> - change commit title and description
> v4:
> - drop >2 condition as max is already 2 and drop the else continue
> - update comment to explain which IRQs are taken in legacy way
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 12 ++++++++----
>  drivers/net/ethernet/mediatek/mtk_eth_soc.h |  4 ++--
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 875e477a987b..7990c84b2b56 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -3354,10 +3354,14 @@ static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
>  	 * the second is for TX, and the third is for RX.
>  	 */
>  	for (i = 0; i < MTK_FE_IRQ_NUM; i++) {
> -		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
> -			eth->irq[i] = eth->irq[MTK_FE_IRQ_SHARED];
> -		else
> -			eth->irq[i] = platform_get_irq(pdev, i);
> +		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT)) {
> +			if (i == 0)

This would make it even more readable:
			if (i == MTK_FE_IRQ_SHARED)


Other than that looks good to me:

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> +				eth->irq[MTK_FE_IRQ_SHARED] = platform_get_irq(pdev, i);
> +			else
> +				eth->irq[i] = eth->irq[MTK_FE_IRQ_SHARED];
> +		} else {
> +			eth->irq[i] = platform_get_irq(pdev, i + 1);
> +		}
>  
>  		if (eth->irq[i] < 0) {
>  			dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> index 8cdf1317dff5..9261c0e13b59 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> @@ -643,8 +643,8 @@
>  #define MTK_MAC_FSM(x)		(0x1010C + ((x) * 0x100))
>  
>  #define MTK_FE_IRQ_SHARED	0
> -#define MTK_FE_IRQ_TX		1
> -#define MTK_FE_IRQ_RX		2
> +#define MTK_FE_IRQ_TX		0
> +#define MTK_FE_IRQ_RX		1
>  #define MTK_FE_IRQ_NUM		(MTK_FE_IRQ_RX + 1)
>  
>  struct mtk_rx_dma {
> -- 
> 2.43.0
> 
> 

