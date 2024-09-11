Return-Path: <netdev+bounces-127491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDAD975909
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14EE1F25BBE
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3866D1AB6EE;
	Wed, 11 Sep 2024 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zOCg9Cum"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD491AC8B7;
	Wed, 11 Sep 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726074415; cv=none; b=BB+XzdT+7ydrjoUVv+FNwLVw8lva693PCO+bx13F3IP0IkDzCIFmHiLiB/VxXi5bkwQSPew9Zgf1smVpICn4GMbiGZwhJBFZYSzdPxLSVUClW4KvvkjF+t1lt7aXYDjofCwB9Ydn0kgUbLZIgKXcJwqRAgxAuoXsVJrvp+clnb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726074415; c=relaxed/simple;
	bh=NdTfXwP6/t/jT5DKnEXixRvkH5TUNSVydD8flaDYVH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQEpu8DqXKqx8SMDJfn4E/m8lbfkScOg+VK8H/r7j/fp218aTvOCyoTeWvJ9vMbFu9Zi9tkewy8cFpV2vtElfYDyLN4XenluonsLvBfwjis/z+coGAQfZ9klJ05hCdif74LjqrL6bx+nIEStD9ZYVejq1UNg+XelNkBjyiJwHsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zOCg9Cum; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dvpvFOzMkQIZvsuca3+YdUWsJtuyjPuUqu6YgoXflL8=; b=zOCg9Cumfz6MO2iaT88dHvamRl
	4M4iCXNL78F7Ki9b+i2E4V7zcMALRoUw7ckOwii8IvaE7T+1SVed97OK7GOFJkVRT9qkdJ0HSoSWA
	jV2jffNcDK9VJBZteZwPf7cDWtvTZRzvoSkF8eC7p0yYEmb+ui0M0KEqvTWfyvxcjrdQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1soQnh-007Efy-1r; Wed, 11 Sep 2024 19:06:41 +0200
Date: Wed, 11 Sep 2024 19:06:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, rdunlap@infradead.org,
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 1/5] net: lan743x: Add SFP support check flag
Message-ID: <a40de4e3-28a9-4628-960c-894b6c912229@lunn.ch>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-2-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911161054.4494-2-Raju.Lakkaraju@microchip.com>

> +	if (adapter->is_pci11x1x && !adapter->is_sgmii_en &&
> +	    adapter->is_sfp_support_en) {
> +		netif_err(adapter, drv, adapter->netdev,
> +			  "Invalid eeprom cfg: sfp enabled with sgmii disabled");
> +		return -EINVAL;

is_sgmii_en actually means PCS? An SFP might need 1000BaseX or SGMII,
phylink will tell you the mode to put the PCS into.

	Andrew

