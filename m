Return-Path: <netdev+bounces-245251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA3BCC9B08
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 23:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02D19300A20E
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 22:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D1330F532;
	Wed, 17 Dec 2025 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gehIvb8v"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7255422FDEC;
	Wed, 17 Dec 2025 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010106; cv=none; b=lM2s0BSp6EBZUUGtZiWpQ7sf4fPqwqz5ditz5+uJ2JksfFOCSU4mWOWE+Cq4ADSF8vJAyC0ptqaDftWfQDy+SOhfrDyXP0Tp2jLLn/LImGEozIwcvAx8iHAd+qk9K72vP+2mgMUXoe6trEq1kx9qmt5/M8n5u5upRMjkiDnM91E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010106; c=relaxed/simple;
	bh=8TVQULurGcGRotUrDk4zQTVLEFon/CSyK+2OIoPapxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZV1s+Ge+Mqpq8/NPu2sbq7EzkJP2/NiyZ3zeuRe+7GV67zNEKGcv/mG6ye4jvSE4bJzBsADhEsXl8fsiQFbmnO/GTp1aL3A8hbH71kzqq3bDyLknRHx/il+nntV1N9S+Sbm2SXNJsgeZnCtqVFctb2TiLEtxYrpzoWzkfMi6NzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gehIvb8v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rx4a/Tij62thpCcp6gcHLKgQ2+6op4+X9dBMhuA0NbM=; b=gehIvb8vh+VFwQGU+TlRKzXVME
	g3jp0Qb984HJBHPLgnoXIehEK9X2VLiMj7eZaR0RNTJER85l77Uc81UUVZuYgl++qA1wW52iVaWP6
	4JoR5o8jy03D6dVIS7x4qjYNeILyJEZdkTYosJFsgLlbsIhSJ0xaBSNA+nUD/GjLxtC4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vVztl-00HGQp-UY; Wed, 17 Dec 2025 23:21:33 +0100
Date: Wed, 17 Dec 2025 23:21:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, khalasa@piap.pl,
	o.rempel@pengutronix.de, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+3d43c9066a5b54902232@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: usb: asix: validate PHY address before use
Message-ID: <f2d9f69c-ab08-4e65-8078-0404a474af80@lunn.ch>
References: <20251217085057.270704-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217085057.270704-1-kartikey406@gmail.com>

On Wed, Dec 17, 2025 at 02:20:57PM +0530, Deepanshu Kartikey wrote:
> The ASIX driver reads the PHY address from the USB device via
> asix_read_phy_addr(). A malicious or faulty device can return an
> invalid address (>= PHY_MAX_ADDR), which causes a warning in
> mdiobus_get_phy():
> 
>   addr 207 out of range
>   WARNING: drivers/net/phy/mdio_bus.c:76
> 
> Validate the PHY address before returning it from asix_read_phy_addr().
> 
> Reported-by: syzbot+3d43c9066a5b54902232@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3d43c9066a5b54902232
> Tested-by: syzbot+3d43c9066a5b54902232@syzkaller.appspotmail.com
> Fixes: 7e88b11a862a ("net: usb: asix: refactor asix_read_phy_addr() and handle errors on return")
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/net/usb/asix_common.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
> index 7fd763917ae2..6ab3486072cb 100644
> --- a/drivers/net/usb/asix_common.c
> +++ b/drivers/net/usb/asix_common.c
> @@ -335,6 +335,11 @@ int asix_read_phy_addr(struct usbnet *dev, bool internal)
>  	offset = (internal ? 1 : 0);
>  	ret = buf[offset];
>  
> +	if (ret >= PHY_MAX_ADDR) {
> +		netdev_err(dev->net, "invalid PHY address: %d\n", ret);
> +		return -ENODEV;
> +	}
> +

https://elixir.bootlin.com/linux/v6.18.1/source/drivers/net/usb/ax88172a.c#L213

	ret = asix_read_phy_addr(dev, priv->use_embdphy);
	if (ret < 0)
		goto free;
	if (ret >= PHY_MAX_ADDR) {
		netdev_err(dev->net, "Invalid PHY address %#x\n", ret);
		ret = -ENODEV;
		goto free;
	}

Your change makes this a repeated netdev_err(). Please can you extend
your patch by removing this second error message.

    Andrew

---
pw-bot: cr

