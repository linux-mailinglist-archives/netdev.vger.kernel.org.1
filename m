Return-Path: <netdev+bounces-107081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9CC919B87
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 02:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6C9B23E48
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 00:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AF2139E;
	Thu, 27 Jun 2024 00:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eXHzImEA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072A92557F;
	Thu, 27 Jun 2024 00:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719446454; cv=none; b=bZFCuEJa/bTARdjFWpR/0QUJk62nhhLRBJJDqiQ83pvcBb8H31ldx3f6uLpOSJIRccF2vpbVih8fyw+w5pAG3mxw/8YO52BR+iHV4GyLu+vBDZLbIZAEj9THkjt++DPxYlZXsKo3ucnWCe48nr1IG3kDJuNxZ6a4FKJNukQNgC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719446454; c=relaxed/simple;
	bh=q6GKtBm5nB+F9Yhmsk+e6YP0hmfWLVVuOqv/Om3ItX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ks0vj19qBRHWaktGAB4tSTf5HJ5zDzp5v8EvtN1IQBM94ZbToZIxc3qShxwohATyKBmXcJ39bIKVo8zpJpoMORvf/d1VFjlRS2Ztr1xpATLe9LNuUGPH5oACT6y2/GiB8ZiGeHz3heeZD1TYaRe2AmnM08jaU+yXhGS60pGHZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eXHzImEA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tkNjM+GYatHoM+pI0wFLm6rW7iM1053yhcMnKVeVnKk=; b=eXHzImEALE1B0G0ZN4Uwb3gfX/
	rxkJmvWCFqHkbqeHY3MdneCiPwbmWmWffgOWHEOlT3ftjMtlPxiqkr3ih7Drq9GiSgZWiyd3pyn5a
	jI0UpjwPxuKMMbl5TU58m5Qac887FUc1TbMxVVACQp/YL0J/D/L4dwa/+ks0Y50Je+U0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMcZ1-0015eq-E8; Thu, 27 Jun 2024 02:00:35 +0200
Date: Thu, 27 Jun 2024 02:00:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Jiasheng Jiang <jiasheng@iscas.ac.cn>,
	"justinstitt@google.com" <justinstitt@google.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 2/2] net: dsa: qca: qca8k: convert to guard
 API
Message-ID: <c6a3df74-257f-4e29-a8f4-e26a40213201@lunn.ch>
References: <20240626230241.6765-1-ansuelsmth@gmail.com>
 <20240626230241.6765-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626230241.6765-2-ansuelsmth@gmail.com>

On Thu, Jun 27, 2024 at 01:02:32AM +0200, Christian Marangi wrote:
> Convert every entry of mutex_lock/unlock() to guard API.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/dsa/qca/qca8k-8xxx.c   |  99 +++++++----------------
>  drivers/net/dsa/qca/qca8k-common.c | 122 ++++++++++++-----------------
>  2 files changed, 81 insertions(+), 140 deletions(-)
> 
> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index b3c27cf538e8..2d9526b696f2 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -6,6 +6,7 @@
>   * Copyright (c) 2016 John Crispin <john@phrozen.org>
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/module.h>
>  #include <linux/phy.h>
>  #include <linux/netdevice.h>
> @@ -321,12 +322,11 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
>  	if (!skb)
>  		return -ENOMEM;
>  
> -	mutex_lock(&mgmt_eth_data->mutex);
> +	guard(mutex)(&mgmt_eth_data->mutex);
>  
>  	/* Check if the mgmt_conduit if is operational */
>  	if (!priv->mgmt_conduit) {
>  		kfree_skb(skb);
> -		mutex_unlock(&mgmt_eth_data->mutex);
>  		return -EINVAL;

Sorry, but NACK.

There are two issues here.

1) guard() is very magical, the opposite of C which is explicit.  We
   discussed that, and think scoped_guard is O.K, since it is more C
   like.

2) We don't want scope_guard or guard introduced in existing code, at
   least not for the moment, because it seems like it is going to make
   back porting patches for stable harder/more error prone.

We do however see that these mechanisms are useful, could solve
problems, so its O.K. to use scoped_guard in new code. In a few years
we will see how things have actually worked out, and reevaluate our
position and maybe allow scoped_guard to be added to existing code.

	Andrew

