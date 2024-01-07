Return-Path: <netdev+bounces-62243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC76826547
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 18:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D181C20A10
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869FE13AD5;
	Sun,  7 Jan 2024 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SKyb5H5r"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD75F13AC8
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P+A0szuTh7HFjFpvHB5nQ8BkE/P1vL4KcW7S/dKnMVk=; b=SKyb5H5rJuBsu0WX6NDSStVA0T
	nZ7xbkNnwrz81cVc7NzkUoi9HkxCSC7YRM/Gs+QKh2RBcdOgcXlpxKj385BGLfEfE3roPRV4qc1bZ
	XART04892yCTYbZgU5sshy53tYU9gfTDUaQw0GfdGJHK/omvM/RmNW8+qBG3Y9j6vDNM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rMWj1-004ZyP-4s; Sun, 07 Jan 2024 18:14:15 +0100
Date: Sun, 7 Jan 2024 18:14:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 RFC 4/5] ethtool: add linkmode bitmap support to
 struct ethtool_keee
Message-ID: <802f71b2-8707-4799-8258-89c4315a00c2@lunn.ch>
References: <8d8700c8-75b2-49ba-b303-b8d619008e45@gmail.com>
 <87a063ed-1b06-40b4-9c12-37658f36ea06@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a063ed-1b06-40b4-9c12-37658f36ea06@gmail.com>

On Sat, Jan 06, 2024 at 11:21:31PM +0100, Heiner Kallweit wrote:
> Add linkmode bitmap members to struct ethtool_keee, but keep the legacy
> u32 bitmaps for compatibility with existing drivers.
> Use link_modes.supported not being empty as indicator that a user wants
> to use the linkmode bitmap members instead of the legacy bitmaps.

So my fear is, the legacy code will never get cleaned up.

How many MAC drivers are there which don't use phylib/phylink?

Maybe i can help out converting them.

> +++ b/include/linux/ethtool.h
> @@ -223,6 +223,11 @@ __ethtool_get_link_ksettings(struct net_device *dev,
>  			     struct ethtool_link_ksettings *link_ksettings);
>  
>  struct ethtool_keee {
> +	struct {
> +		__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
> +		__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
> +		__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising);
> +	} link_modes;
>  	u32	supported;
>  	u32	advertised;
>  	u32	lp_advertised;

I don't particularly like having the link_modes struct here. The end
goal should be that supported, advertised and lp_advertised become
link modes, and all the drivers are changed to use them.

Maybe we have one patch which does another global replace,
supported->supported_u32, advertised->advertised_32, etc, making space
for link mode symbols. phylib can directly use the new link modes so
there is no real change in that code. We can then convert the MAC
drivers not using phylib one by one, and then remove the _u32 members
at the end.

      Andrew

