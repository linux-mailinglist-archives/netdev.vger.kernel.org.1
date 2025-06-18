Return-Path: <netdev+bounces-198933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAEAADE5B0
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 10:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29101884A0F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 08:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5D327E7C0;
	Wed, 18 Jun 2025 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAACJ5VG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C26191F66;
	Wed, 18 Jun 2025 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750235765; cv=none; b=P+dVCr+5P4e+aE5ZxH0rQJ6nqcziXJP257O+xSB3sy8pCoJbnaIqO6NURjpr1e8H8epxkjl6nIo9VvQ31fvojulWEMGm47KBSDiGqmF9wLmrVwU8WKwtONHp1L8v4vwiS7SzJauQeN5GX3ie5BkhjomsEoK0o+9plRlqSxnzAlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750235765; c=relaxed/simple;
	bh=d+shUg6FUAacuvyB+a/E5gAXYy54EFgD47YG339obCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mos09EuM9Se0YfEbDLqdt4o4bvM7siRoFQ5UbLoZz6sJM5xlauwJ8nuC2556ymI96dYcVbILRlRx9iGZAoC3AOaqmdZkZi5EyM7lMBE83jgRAtZrIzlf12z3E7DgimKB/zehTYcu5KgDLdbNfBOXi+GXeCc92xX7EFhJiHN0h0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAACJ5VG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB5BC4CEE7;
	Wed, 18 Jun 2025 08:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750235764;
	bh=d+shUg6FUAacuvyB+a/E5gAXYy54EFgD47YG339obCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DAACJ5VGbewT2iH4WiWM4CRpfDLwZ//JkoBE2fWzj9QNwPi4H0FoxlbaXLXMxhJLb
	 0SGsCz05+82z4FmUhdHw2lhX8HPOaQqTkm0IHKQbz7IVf0/quFlfCdtHex0S+iG7XR
	 yVDrxC3RsKmU1+AwqWgGRZGxfV1ja1vKRzChyHtCWYgdVIVxon4yPxf0+eSEuhMXqs
	 KV4aK3gWWVSW9MZEazq4MzOUTwLxdCebp4qxw982dLi9aA8zYjbw/JH5ppN/qnC0H1
	 VaGZBjHgEaHYaWR6jTrUDbb8uVocrWfukYLOOxZwMW1YR2aXDfGklRp0M+j0HcrPe4
	 b+qO3zIIMy3hA==
Date: Wed, 18 Jun 2025 09:35:56 +0100
From: Simon Horman <horms@kernel.org>
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
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>, arinc.unal@arinc9.com
Subject: Re: [net-next v4 3/3] net: ethernet: mtk_eth_soc: change code to
 skip first IRQ completely
Message-ID: <20250618083556.GE2545@horms.kernel.org>
References: <20250616080738.117993-1-linux@fw-web.de>
 <20250616080738.117993-4-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616080738.117993-4-linux@fw-web.de>

On Mon, Jun 16, 2025 at 10:07:36AM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> On SoCs without MTK_SHARED_INT capability (mt7621 + mt7628) the first
> IRQ (eth->irq[0]) was read but never used. Do not read it and reduce
> the IRQ-count to 2 because of skipped index 0.

Describing the first IRQ as read seems a bit confusing to me - do we read
it? And saying get or got seems hard to parse. So perhaps something like
this would be clearer?

... platform_get_irq() is called for the first IRQ (eth->irq[0]) but
it is never used.

> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v4:
> - drop >2 condition as max is already 2 and drop the else continue
> - update comment to explain which IRQs are taken in legacy way
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 20 ++++++++++++++++----
>  drivers/net/ethernet/mediatek/mtk_eth_soc.h |  4 ++--
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 3ecb399dcf81..f3fcbb00822c 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -3341,16 +3341,28 @@ static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
>  {
>  	int i;
>  
> +	/* future SoCs beginning with MT7988 should use named IRQs in dts */

Perhaps this comment belongs in the patch that adds support for named IRQs.

>  	eth->irq[MTK_ETH_IRQ_TX] = platform_get_irq_byname(pdev, "tx");
>  	eth->irq[MTK_ETH_IRQ_RX] = platform_get_irq_byname(pdev, "rx");
>  	if (eth->irq[MTK_ETH_IRQ_TX] >= 0 && eth->irq[MTK_ETH_IRQ_RX] >= 0)
>  		return 0;
>  
> +	/* legacy way:
> +	 * On MTK_SHARED_INT SoCs (MT7621 + MT7628) the first IRQ is taken from
> +	 * devicetree and used for rx+tx.
> +	 * On SoCs with non-shared IRQ the first was not used, second entry is
> +	 * TX and third is RX.

Maybe I am slow. But I had a bit of trouble parsing this.
Perhaps this is clearer?

        * devicetree and used for both RX and TX - it is shared.
	* On SoCs with non-shared IRQs the first entry is not used,
        * the second is for TX, and the third is for RX.

> +	 */
> +
>  	for (i = 0; i < MTK_ETH_IRQ_MAX; i++) {
> -		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
> -			eth->irq[i] = eth->irq[MTK_ETH_IRQ_SHARED];
> -		else
> -			eth->irq[i] = platform_get_irq(pdev, i);
> +		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT)) {
> +			if (i == 0)
> +				eth->irq[MTK_ETH_IRQ_SHARED] = platform_get_irq(pdev, i);
> +			else
> +				eth->irq[i] = eth->irq[MTK_ETH_IRQ_SHARED];
> +		} else {
> +			eth->irq[i] = platform_get_irq(pdev, i + 1);
> +		}
>  
>  		if (eth->irq[i] < 0) {
>  			dev_err(&pdev->dev, "no IRQ%d resource found\n", i);

...

