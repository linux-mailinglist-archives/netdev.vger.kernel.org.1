Return-Path: <netdev+bounces-123864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D27C2966B1E
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1D41C21E8A
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B125D1BFDEA;
	Fri, 30 Aug 2024 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dlIjxBd3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018A71BB6A4;
	Fri, 30 Aug 2024 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051978; cv=none; b=FeZPdpwHkZtqjy0iu33Xrz5H6M17hf0YUfa4fQwljIm7/Gm+3xnYWVP1w1ualQU1XnklBQQDRIR0BavMb2va0eGGAS3htQtr3FZF2A/zuB6HQkWQj+oAKTGks/HVmt/l3G/pvtay7RNqbbL4TGmo8pGpEUhyshT3mo1ZmK2fC3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051978; c=relaxed/simple;
	bh=SDSdN89eVg4xsG2uI/s4vf+tGFgyQTYx92YjA8C1bIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hn2KFZv1HrlvOywUHtAtPQpnbNF19ZVIMbQnpf/aDL5mhSwcyjbRVxaiwnYjxFUoATBdEsulPRy8q/Bny+X0QHfG5jf3fa7MbyfmmwQ3U5Pc8wtpSW2TfUSgh/B6X8PmzSYjDgs8btTlY1PxeQcHgGM/whycFR3bTYX2W7GNW4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dlIjxBd3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w2SQawhjbomku3lmIoVoBV+XKTXKkwuxi3ZQVvH++ZU=; b=dlIjxBd32qTraVy3xmg938Cg9c
	grNyoQrFquaA1H2p6znqwBqEc0zLN67c6qR4GwLmzH2o9DQmpjtUcicXtZOZh0U6j2KlrOInojaXV
	iulFx2QzzyecBpRSXQw0u3RGnOOw4rllzftTefta4Btkpuic6FdUMQ/ZnjABsiDgV+WY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sk8oq-006AHF-ON; Fri, 30 Aug 2024 23:06:08 +0200
Date: Fri, 30 Aug 2024 23:06:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	Simon Horman <horms@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2 3/7] net: ethernet: fs_enet: drop the
 .adjust_link custom fs_ops
Message-ID: <480a16fd-a1eb-4ea0-b859-5d874ecc3b15@lunn.ch>
References: <20240829161531.610874-1-maxime.chevallier@bootlin.com>
 <20240829161531.610874-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829161531.610874-4-maxime.chevallier@bootlin.com>

> --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> @@ -649,12 +649,7 @@ static void fs_adjust_link(struct net_device *dev)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&fep->lock, flags);
> -
> -	if (fep->ops->adjust_link)
> -		fep->ops->adjust_link(dev);
> -	else
> -		generic_adjust_link(dev);
> -
> +	generic_adjust_link(dev);
>  	spin_unlock_irqrestore(&fep->lock, flags);

Holding a spinlock is pretty unusual. We are in thread context, and
the phydev mutex is held. Looking at generic_adjust_link, do any of
the fep->foo variables actually need protecting, particularly from
changes in interrupts context?

	Andrew

