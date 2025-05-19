Return-Path: <netdev+bounces-191615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F09ABC79F
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7861C3A3119
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 19:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A2020E719;
	Mon, 19 May 2025 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HzyRAz8G"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BABC19AD70;
	Mon, 19 May 2025 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747682072; cv=none; b=Uc5s1v7rCgjl8oNsNrfNTIG2zyO5nfoa6ILnknV/vJjHJ+y7jdAWbyr8X+bilp6DBEtOvkUaoJiR5aDMWvCbGnTl2CzZb9trn5rZhO5R+qv3dhRJiWgVnvixe8+rT1k9hh4aLAyIrn4dXcy02NExSmaijeqj3ksM8IMzkUMWfeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747682072; c=relaxed/simple;
	bh=UMtW8QINSoWMGXXCFvUIFqv4TXzzTYvRUgjov61s0HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoWwAhV1AaeSziQKRdrY6shYxJeUg7lk8yc1J48tn7TIOBZpy9khVOiOEcySUfKh1u7MG1y82uv1L8KCsU/lw/Rz3uqPFyy9qWy87q9oGd/2WUJRrEbM7I+W1mSoRSRvM1OUjWMnss/TdThjVmxXCiKjuvwLjfaARD5mEgtVwTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HzyRAz8G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lghZXCBMQytnlWQM8HAUV+A8SQOt96nptrBbQcQHuoE=; b=HzyRAz8GhziKHKIuBU8XUqr0oc
	f8wZ4d5G/bCr0SShvs8LyictHBPKK+49LFhHKq/VYG0N+eegOaRkMY/OhSIQ45tv6iijlx1vclaOa
	Kn17AAPxgAFcPHb49ahy8RkNWjcTHHPdnudzbcKL50jt39uK9c5BSV4KJXQ6RVoyuMwg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uH5w8-00D36U-T8; Mon, 19 May 2025 21:14:08 +0200
Date: Mon, 19 May 2025 21:14:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	=?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/3] net: dsa: b53: fix configuring RGMII delay on
 bcm63xx
Message-ID: <ed75677c-c3fb-41d1-a2cd-dd84d224ffe3@lunn.ch>
References: <20250519174550.1486064-1-jonas.gorski@gmail.com>
 <20250519174550.1486064-3-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519174550.1486064-3-jonas.gorski@gmail.com>

On Mon, May 19, 2025 at 07:45:49PM +0200, Jonas Gorski wrote:
> The RGMII delay type of the PHY interface is intended for the PHY, not
> the MAC, so we need to configure the opposite. Else we double the delay
> or don't add one at all if the PHY also supports configuring delays.
> 
> Additionally, we need to enable RGMII_CTRL_TIMING_SEL for the delay
> actually being effective.
> 
> Fixes e.g. BCM54612E connected on RGMII ports that also configures RGMII
> delays in its driver.

We have to be careful here not to cause regressions. It might be
wrong, but are there systems using this which actually work? Does this
change break them?

> 
> Fixes: ce3bf94871f7 ("net: dsa: b53: add support for BCM63xx RGMIIs")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>  drivers/net/dsa/b53/b53_common.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index a316f8c01d0a..b00975189dab 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -1328,19 +1328,19 @@ static void b53_adjust_63xx_rgmii(struct dsa_switch *ds, int port,
>  
>  	switch (interface) {
>  	case PHY_INTERFACE_MODE_RGMII_ID:
> -		rgmii_ctrl |= (RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
> +		rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
>  		break;
>  	case PHY_INTERFACE_MODE_RGMII_RXID:
> -		rgmii_ctrl &= ~(RGMII_CTRL_DLL_TXC);
> -		rgmii_ctrl |= RGMII_CTRL_DLL_RXC;
> +		rgmii_ctrl |= RGMII_CTRL_DLL_TXC;
> +		rgmii_ctrl &= ~RGMII_CTRL_DLL_RXC;
>  		break;
>  	case PHY_INTERFACE_MODE_RGMII_TXID:
> -		rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC);
> -		rgmii_ctrl |= RGMII_CTRL_DLL_TXC;
> +		rgmii_ctrl |= RGMII_CTRL_DLL_RXC;
> +		rgmii_ctrl &= ~RGMII_CTRL_DLL_TXC;
>  		break;
>  	case PHY_INTERFACE_MODE_RGMII:
>  	default:
> -		rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
> +		rgmii_ctrl |= RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC;
>  		break;

These changes look wrong. There is more background here:

https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

	Andrew

