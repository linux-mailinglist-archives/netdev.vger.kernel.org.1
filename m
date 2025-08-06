Return-Path: <netdev+bounces-211949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0747EB1C968
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 17:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7BB3A6606
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E1F291C39;
	Wed,  6 Aug 2025 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xoo/8ruy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DB43AC1C;
	Wed,  6 Aug 2025 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495912; cv=none; b=Suq0TKMTE3FhDEX6wZ/kFQwxSBYyrrJzj5XjUG1DKZkYxXv4AgoA6SI5pGRIDMyTVv34nB16k7fOzYWzc01j5FwhlyLKDyfHheWHbuVeYmix+fSrTk5kZpj01Mtg3n0lnkd2i0t0zrd0easCflTidj5aSVnoOk1QUZ7wPzKICZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495912; c=relaxed/simple;
	bh=sSO/pt/U1+E8OY7Yuo/f4yv1RBvYu7aY/b9o6H2x12A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/6NSs3xVH9GWdfR/4eVM0hjRhs0YI89HSD7bQUKQo21dBDJSsDdmLG2I9RVeqyVXW515wOWYWZDqH9YS1UAqjWOFC+dEojygVHLCctkHzeR+fc3vcHu1YPb+D52XueU31ba/jqLRROK/Abl9JyLKqgdaQLmsaJkoVO1L11XuUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xoo/8ruy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qIUqhvFZG7Tf90KosIP1Pp2fKw9yMJdI0DLHExSEzSU=; b=Xoo/8ruy02QrcBv6xfNFqClU7E
	VvEvYIeigEhL4G6r839FL1VZQz2j7odw1TKsKN3xjUdlCq2eiP7Ze+xVjE9HVp4pEoq80XH1moCuu
	bHe7zrkgKJ6l5eZRTirIuA8jt08UeiFRTiFZyGtKryltz1v/QmSUpcF7o9f712AdE1vc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ujgWw-003tgX-Px; Wed, 06 Aug 2025 17:58:18 +0200
Date: Wed, 6 Aug 2025 17:58:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, max.schulze@online.de,
	khalasa@piap.pl, o.rempel@pengutronix.de, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, jun.li@nxp.com
Subject: Re: [PATCH] net: usb: asix: avoid to call phylink_stop() a second
 time
Message-ID: <a28f38d5-215b-49fb-aad7-66e0a30247b9@lunn.ch>
References: <20250806083017.3289300-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806083017.3289300-1-xu.yang_2@nxp.com>

On Wed, Aug 06, 2025 at 04:30:17PM +0800, Xu Yang wrote:
> The kernel will have below dump when system resume if the USB net device
> was already disconnected during system suspend.

By disconnected, you mean pulled out?

> It's because usb_resume_interface() will be skipped if the USB core found
> the USB device was already disconnected. In this case, asix_resume() will
> not be called anymore. So asix_suspend/resume() can't be balanced. When
> ax88772_stop() is called, the phy device was already stopped. To avoid
> calling phylink_stop() a second time, check whether usb net device is
> already in suspend state.
> 
> Fixes: e0bffe3e6894 ("net: asix: ax88772: migrate to phylink")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  drivers/net/usb/asix_devices.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
> index 9b0318fb50b5..ac28f5fe7ac2 100644
> --- a/drivers/net/usb/asix_devices.c
> +++ b/drivers/net/usb/asix_devices.c
> @@ -932,7 +932,8 @@ static int ax88772_stop(struct usbnet *dev)
>  {
>  	struct asix_common_private *priv = dev->driver_priv;
>  
> -	phylink_stop(priv->phylink);
> +	if (!dev->suspend_count)
> +		phylink_stop(priv->phylink);

Looking at ax88172a.c, lan78xx.c and smsc95xx.c, they don't have
anything like this. Is asix special, or are all the others broken as
well?

	Andrew

