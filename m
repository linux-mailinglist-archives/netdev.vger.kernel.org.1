Return-Path: <netdev+bounces-209366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A6BB0F65F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6192AA235E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E342FF484;
	Wed, 23 Jul 2025 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GIXssPHq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A202FEE16;
	Wed, 23 Jul 2025 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282456; cv=none; b=r0rh9gxsq98SkRWe62kak4XwIFQBb328EENLBGHb7cP61SA27pi2ympuHokdAeL7kUDyhiUxOcDDAVjeCHx7925x4jzhci7RhY2NWXTfBnRCj6PTdBL7qDaz9XpGqRyHGfLlgSW0gBA4QGOFifA7LZ9NVyJcouwl1a6hnmD4SWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282456; c=relaxed/simple;
	bh=BqzWyT6KzHoSXN+hN2edEC1EldzF1+qRFVYHO2Q1FZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Clduf80lgJWLsK2SKx4KYX48brgcpcgUbgdvIX+cRuDUbbUaFO8pTL51hKY7bsuAldlBiHNlK3ZFvyDAM9nxGyMag72R1NfC6HICg9AZZ3NHOxTGpq4lb0Y+p3pWSjxtzmZxzxKBtRw7lDmMLtIx2052hmAqhUWda5bJ255RE2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GIXssPHq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n+4LkLar103CDs6a5yhfU4dJomb3vdlJJeBcr3Q+3gc=; b=GIXssPHqvOOquOggC0SzCdc73f
	oTD5gPw42GhS/90eBEq/TUG8tR7VsfICR/ODcgDDBOU/4rr/SfBMb/X0daGXwFkQS4+Kp4ijrt0SH
	x7dyAS9m83IScSzkuCuGyBQVJwvKQOi5ejwYbM3emat/Dh9lR0RkNhY9u+uDV7XoJnfY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ueaqK-002bsu-0e; Wed, 23 Jul 2025 16:53:16 +0200
Date: Wed, 23 Jul 2025 16:53:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: stmmac: Return early if invalid in
 loongson_dwmac_fix_reset()
Message-ID: <f65deb0d-29d1-4820-95e9-f1dd94967957@lunn.ch>
References: <20250723100056.6651-1-yangtiezhu@loongson.cn>
 <20250723100056.6651-2-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723100056.6651-2-yangtiezhu@loongson.cn>

On Wed, Jul 23, 2025 at 06:00:55PM +0800, Tiezhu Yang wrote:
> If the MAC controller does not connect to any PHY interface, there is a
> missing clock, then the DMA reset fails.
> 
> For this case, the DMA_BUS_MODE_SFT_RESET bit is 1 before software reset,
> just return -EINVAL immediately to avoid waiting for the timeout when the
> DMA reset fails in loongson_dwmac_fix_reset().
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index e1591e6217d4..6d10077666c7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -513,6 +513,9 @@ static int loongson_dwmac_fix_reset(void *priv, void __iomem *ioaddr)
>  {
>  	u32 value = readl(ioaddr + DMA_BUS_MODE);
>  
> +	if (value & DMA_BUS_MODE_SFT_RESET)
> +		return -EINVAL;

What happens with this return value? Do you get an error message which
gives a hint the PHY clock is missing? Would a netdev_err() make sense
here?

	Andrew

