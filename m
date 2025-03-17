Return-Path: <netdev+bounces-175471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21ACA660A1
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 22:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C553B6025
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9364E204698;
	Mon, 17 Mar 2025 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NML06ER1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEDB20409E;
	Mon, 17 Mar 2025 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247258; cv=none; b=M/k3iFsHrJkCx2c1nCxW/6CvmZv+ISOhaQaZBqm6xCDDDHhI8QLGRu9p/dHpZ8YIpShCexxW0fFWvKOHSJzpTpY0LcIfaJUW9RDzyPxaLI4tPWod1e6n4WwgLM/0oFRO9UdLK7WznsfexFYPrggycFNE+Mq3zJ15nZFVyliPl+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247258; c=relaxed/simple;
	bh=J/ay4WLZh1Osi3udGOCS4LqE3mOSgzMRouTrGftz1Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUd/mpGe6cNLExMgFs2EHhSquoPB6YA9tTDrL1UgR7dT1+i7NVo4P20YeAHXWUDsG/vbyEYae5VEiHhkZ/N0P19zBtXzd/KVKHP6jKNNdrQUx4Xbt8hBBFZMBLvIKI0ehRy6fWBl7dQpSKaubEKx5vwuNrfqa/6Ag0YeEGM9SnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NML06ER1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wsfDU0ViDgt57BigMQNcliLd9QJIMtp0HWwsa3/6Ncw=; b=NML06ER1quJzdHz+LJVevADd42
	PFOmyTBiCxRdtkLNzcqP9K2iO3st3q8xokeGIKX9Kg/a5O1iGkgnz+uBhItidEfdZoI9foYkd/6Fu
	dtldt26Q4fht/Rn1lZ9U1ihtMy1QRTtjRwcu1K9wtbJq+gK1H8xuiIsjaK/m8xZv4Yz0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuI65-006BQF-6u; Mon, 17 Mar 2025 22:34:09 +0100
Date: Mon, 17 Mar 2025 22:34:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v3 0/2] net: phy: sfp: Add single-byte SMBus SFP
 access
Message-ID: <1653ddbd-af37-4ed1-8419-06d17424b894@lunn.ch>
References: <20250314162319.516163-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314162319.516163-1-maxime.chevallier@bootlin.com>

On Fri, Mar 14, 2025 at 05:23:16PM +0100, Maxime Chevallier wrote:
> Hello everyone,
> 
> This is V3 for the single-byte SMBus support for SFP cages as well as
> embedded PHYs accessed over mdio-i2c.

Just curious, what hardware is this? And does it support bit-banging
the I2C pins? If it does, you get a choice, slow but correct vs fast
but broken and limited?

	Andrew

