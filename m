Return-Path: <netdev+bounces-150460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CDB9EA4B1
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6298E167023
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6C1143871;
	Tue, 10 Dec 2024 02:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gkJ6Sceq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF96A233129;
	Tue, 10 Dec 2024 02:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796509; cv=none; b=Ey6z3dFEwfL5uzow/aMcv8K7rcPBvq7Kkh90VzpNLYkhD1KMLTjBFrsy9yN3bAFqEoFswTvKmdW1t4i8BMyFErV0NN63nzIw4epovywekLtHvDzWD8pk+tDfQz9Bs2naKL93Xvf6oJoLe1Xa2A9URmCN/uuhMAmafrEYOoA1V8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796509; c=relaxed/simple;
	bh=U6khB6Gsunn+6wOKdDyM06kWI5AsmwLzY7FDRS//6Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oylr91e+S16jqtXO9Wl8hnLbFS3CPC9LjETbrt1rRj44vWf8EciCHyq4FTBFmauGxsFNigGIFW6MO5xwKcPsx2AhAQUVHOyUSwSbeoyYMDnrPmD9wa8vxR8NYDyCvRo29RkiloGA08ikqqJerBiXVhb/VfTpbONuiSfpGh0Va0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gkJ6Sceq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2b4SfBMusoVeDDD72aFfOq1h684lYU0ExF+9S7AZrYo=; b=gkJ6SceqbE8fT5g0G07fAotN0c
	OilqCxaXQj3+M0r0bdt5YCexfcrPLGAafmMJYkeAyCQ7kyvtjot6++L+kkv4FB3T2zb0AWJiqS0K0
	0YhavQiEbwlaz1aqcgyO+nxi2MPi8Vp+L6/SoFKU9oxYaJfAI/y9S+3Wi4RWq6FWA1w4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKpfe-00Fk7E-5V; Tue, 10 Dec 2024 03:08:18 +0100
Date: Tue, 10 Dec 2024 03:08:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 07/11] net: usb: lan78xx: Use ETIMEDOUT
 instead of ETIME in lan78xx_stop_hw
Message-ID: <b7fa7a73-a1f1-4eeb-a97d-2ad25af0f0f5@lunn.ch>
References: <20241209130751.703182-1-o.rempel@pengutronix.de>
 <20241209130751.703182-8-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209130751.703182-8-o.rempel@pengutronix.de>

On Mon, Dec 09, 2024 at 02:07:47PM +0100, Oleksij Rempel wrote:
> Update `lan78xx_stop_hw` to return `-ETIMEDOUT` instead of `-ETIME` when
> a timeout occurs. While `-ETIME` indicates a general timer expiration,
> `-ETIMEDOUT` is more commonly used for signaling operation timeouts and
> provides better consistency with standard error handling in the driver.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/usb/lan78xx.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 2966f7e63617..c66e404f51ac 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -844,9 +844,7 @@ static int lan78xx_stop_hw(struct lan78xx_net *dev, u32 reg, u32 hw_enabled,
>  		} while (!stopped && !time_after(jiffies, timeout));
>  	}
>  
> -	ret = stopped ? 0 : -ETIME;
> -
> -	return ret;
> +	return stopped ? 0 : -ETIMEDOUT;

I've not looked at the call stack, but tx_complete() and rx_complete()
specifically looks for ETIME. Do they need to change as well?

	Andrew

