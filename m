Return-Path: <netdev+bounces-214220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00502B288AD
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 01:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E501A5C03B8
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 23:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56491C9DE5;
	Fri, 15 Aug 2025 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3xrDIuwt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BCE22083
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 23:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755299758; cv=none; b=oN3bRWdcUHorN28dWReJj0mZLscaJS3ZHyZdRwnETU0iOq5gFlZ0aknrNYl+mzQBJqVlW3GT2lEDC9EoQyrYixky3k0+xtg9JKTnYtt0ABLxkoItZXiZe1mh4yDQceu7m5k0relxblPxNteEFnMjcAJ7yCkB5pLPlU6hl7WUYek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755299758; c=relaxed/simple;
	bh=J82seaamUFIjrpt4WO8EutDuJV8BmF6tdVfMX/2R1Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3WolinOa2Ex/uiM/QlUyOltvDob7tc56Cbihmks2J5UZAroej/hO7N6BXi+wVJKfDTFwIFzjHRoN3wtNUV/2i/d6upDo6w765e5yJXenaiNtG0fysutBAt1N2ceGSgMOc0eG8GUbVcr0ItdDs15CE9l33koGHJVFXXLIHCx0rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3xrDIuwt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gUls81A5zQ5MJ0asTTzVEpaf3D13ra2CYLDAzrxnr3U=; b=3xrDIuwtkuGRelrLLq6V4V6VgL
	FshQEV8xop+L9kTxL9LoL4WcctKYOUBPmtqFhhnAfxRMCs2UD0VZqeIJC+iTS383jmTfQizePjKDG
	pDLDFM2Ey+M/sXpSVmoXshSrddwXBm3Ab5cn2KhnQYvROr+0wxfXLHpEkAQNG8UWrL20=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1un3eH-004s3e-1h; Sat, 16 Aug 2025 01:15:49 +0200
Date: Sat, 16 Aug 2025 01:15:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: dsa: ks8995: Add basic switch set-up
Message-ID: <dbd9c3c4-2a8f-4743-ba8b-94424d13cfac@lunn.ch>
References: <20250813-ks8995-to-dsa-v1-0-75c359ede3a5@linaro.org>
 <20250813-ks8995-to-dsa-v1-4-75c359ede3a5@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-ks8995-to-dsa-v1-4-75c359ede3a5@linaro.org>

On Wed, Aug 13, 2025 at 11:43:06PM +0200, Linus Walleij wrote:
> We start to extend the KS8995 driver by simply registering it
> as a DSA device and implementing a few switch callbacks for
> STP set-up and such to begin with.
> 
> No special tags or other advanced stuff: we use DSA_TAG_NONE
> and rely on the default set-up in the switch with the special
> DSA tags turned off. This makes the switch wire up properly
> to all its PHY's and simple bridge traffic works properly.
> 
> After this the bridge DT bindings are respected, ports and their
> PHYs get connected to the switch and react appropriately through
> the phylib when cables are plugged in etc.
> 
> Tested like this in a hacky OpenWrt image:
> 
> Bring up conduit interface manually:
> ixp4xx_eth c8009000.ethernet eth0: eth0: link up,
>   speed 100 Mb/s, full duplex
> 
> spi-ks8995 spi0.0: enable port 0
> spi-ks8995 spi0.0: set KS8995_REG_PC2 for port 0 to 06
> spi-ks8995 spi0.0 lan1: configuring for phy/mii link mode
> spi-ks8995 spi0.0 lan1: Link is Up - 100Mbps/Full - flow control rx/tx
> 
> PING 169.254.1.1 (169.254.1.1): 56 data bytes
> 64 bytes from 169.254.1.1: seq=0 ttl=64 time=1.629 ms
> 64 bytes from 169.254.1.1: seq=1 ttl=64 time=0.951 ms
> 
> I also tested SSH from the device to the host and it works fine.
> 
> It also works fine to ping the device from the host and to SSH
> into the device from the host.
> 
> This brings the ks8995 driver to a reasonable state where it can
> be used from the current device tree bindings and the existing
> device trees in the kernel.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I only question scanned the code, but

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

