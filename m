Return-Path: <netdev+bounces-68833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EBB84875C
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 17:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9847A1F236AE
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 16:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4B95F574;
	Sat,  3 Feb 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="57yLo97s"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF025F55C
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706977030; cv=none; b=AqkF/0nvfs8e1gPgw6bzrXMl4Bes+z9dqwLuCd3ZApRi6wNC+UPsVFsnngJNHD7x892xjKKg89iILY8ykQFFC3+vFzGOva8e8eVfvb8dzn4ipKM5dQ56fiq3CmhJlidc+KmPzhIRcWiKJi8+QeQ9M7RNSMsoN4ZU3ZGPI+XOdKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706977030; c=relaxed/simple;
	bh=yK+vFKgBcDnnhAl+LPEsqX1LSWBXguZ9XqZj+TIHdCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HljCTJE/FH9vs0RRqoSpwUKIM1SzHH3U2JJDEYyVXNaOfJFkpFEA6Rex1iYsDu4D+znlryh/h4B46PuNtJiKiSw6L+YgO/oAp7628ei+wcWf3s0nujYtNSudqVk6alyLtQVIn4iGFATMrALjp3bnttW1t6dH8LRHniQFauxwY8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=57yLo97s; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fEmdYHsvP4tHfacOlifMCW3OgJU3LHmLOd1ogAJ8EYA=; b=57yLo97sj7ziiNNKVRm+K1l2iL
	9Kt+a2kBxu5XOh17sFafm+aAKQlppyFD4xwi7biDh0aOahDxGSSNpAjek0H1ihWj31zT08Aas1xMm
	FTtWrkc2qMHSbfyuJesevpUjUs40yBj43WqNnIajApmYXsLEohblYiQuhptwB7Qh4rcI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWIhN-006uah-Vz; Sat, 03 Feb 2024 17:16:57 +0100
Date: Sat, 3 Feb 2024 17:16:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: phy: add helper phy_advertise_eee_all
Message-ID: <8a1cf78a-0516-4696-b08d-c149a195457f@lunn.ch>
References: <14ee6c37-3b4f-454e-9760-ca41848fffc2@gmail.com>
 <45b0be04-2886-4eaa-a5a4-9e3a2e29b667@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b0be04-2886-4eaa-a5a4-9e3a2e29b667@gmail.com>

On Sat, Feb 03, 2024 at 12:20:12PM +0100, Heiner Kallweit wrote:
> Per default phylib preserves the EEE advertising at the time of
> phy probing. The EEE advertising can be changed from user space,
> in addition this helper allows to set the EEE advertising to all
> supported modes from drivers in kernel space.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/phy_device.c | 12 ++++++++++++
>  include/linux/phy.h          |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index dd778c7fd..df56c3ebf 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -2769,6 +2769,18 @@ void phy_advertise_supported(struct phy_device *phydev)
>  }
>  EXPORT_SYMBOL(phy_advertise_supported);
>  
> +/**
> + * phy_advertise_eee_all - Advertise all supported EEE modes
> + * @phydev: target phy_device struct
> + *
> + * Description: Called to advertise all supported EEE modes
> + */

I would expand this description. Include the

Per default phylib preserves the EEE advertising at the time of
phy probing

And extend with something like,

which might be a subset of the supported EEE modes. Use this function
when all supported EEE modes should be advertised. This does not
trigger auto-negotiation, so must be called before
phy_start()/phylink_start() which will start auto-negotiation.

	Andrew

