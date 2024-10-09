Return-Path: <netdev+bounces-133561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F333996451
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A61DB21D4A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669983BB48;
	Wed,  9 Oct 2024 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KbQPJZj9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED91EADC;
	Wed,  9 Oct 2024 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464493; cv=none; b=PjrPVrOWcVh1npIyAWBQldd82rUyPx0brDcrHW7tbRl7kcY/sOf47AfFbaDj6FT1uziS6ulyw3aCjc6AQXAcTLuO+i+B8AR8IH++9/uxlaTUdkbw3bcGKDy7LNSJFRtiuN/5MNW6qDSEE3GTk9fcj0g570QHw5JVauNBkt3+B/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464493; c=relaxed/simple;
	bh=t4XV67XwT9AqpZE1BMpvVqUY/3bEjFjl116GcFX6tw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YveVOSp/ORZckLJW+p76nUwCWY9ZYib6xpJNWDQyE8LCYXCjCh3/fuvPdQ+byL0xp1193EWVsRGTFFFH1V4U+SO7wdGS/BFrHka0tRxxnjswkPb2iFsIYP9R2dSTfzim+Jnf0aBYxQiTwyYjCfpr4CeJ42XuVnISxhFH/EYDEO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KbQPJZj9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O0/uxb+Q2DMRDFmKQ9galN4+KgTPVjf1vmB8NeLKKX0=; b=KbQPJZj9/Pma3mpqAb+48jv3eK
	b3DYw6yBiR89YmqHiuPDhg+TugDN/BaJ6uHCNAMl3P5W1PQrnQlnW5cgj6z0tI7IQnXm3XEav2foY
	TWh9aD8EruHE2LuVIoYf73lSPIs/YlXN4+OzVNru0DfzeQglcoN6Z9OhPVhDfNkBdUlSXaqy9tLN7
	GItgUq7u2dqS948aPzXl0H0YrdruWLzO+OSWxRJkbL55+1Lp8AFXtipO4yoZAxLWSvdKxE9AjSsyU
	yLz0nfttmLLln9v7TBLdUNS6SbvurKLKuIWkV3Am5amyAfdHBOfNkzMXUAmfzKfFJdQAGLPvZ4Xqg
	7TPe1Gdg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43336)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sySZG-0000EL-1M;
	Wed, 09 Oct 2024 10:01:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sySZB-00069W-2S;
	Wed, 09 Oct 2024 10:01:09 +0100
Date: Wed, 9 Oct 2024 10:01:09 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: populate host_interfaces when
 attaching PHY
Message-ID: <ZwZGVRL_j62tH9Mp@shell.armlinux.org.uk>
References: <ae53177a7b68964b2a988934a09f74a4931b862d.1728438951.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae53177a7b68964b2a988934a09f74a4931b862d.1728438951.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 09, 2024 at 02:57:03AM +0100, Daniel Golle wrote:
> Use bitmask of interfaces supported by the MAC for the PHY to choose
> from if the declared interface mode is among those using a single pair
> of SerDes lanes.
> This will allow 2500Base-T PHYs to switch to SGMII on most hosts, which
> results in half-duplex being supported in case the MAC supports that.
> Without this change, 2500Base-T PHYs will always operate in 2500Base-X
> mode with rate-matching, which is not only wasteful in terms of energy
> consumption, but also limits the supported interface modes to
> full-duplex only.

We've had a similar patch before, and it's been NAK'd. The problem is
that supplying the host_interfaces for built-in PHYs means that the
hardware strapping for the PHY interface mode becomes useless, as does
the DT property specifying it - and thus we may end up selecting a
mode that both the MAC and PHY support, but the hardware design
doesn't (e.g. signals aren't connected, signal speed to fast.)

For example, take a board designed to use RXAUI and the host supports
10GBASE-R. The first problem is, RXAUI is not listed in the SFP
interface list because it's not usable over a SFP cage. So, the
host_interfaces excludes that, and thus the PHY thinks that's not
supported. It looks at the mask and sees only 10GBASE-R, and
decides to use that instead with rate matching. The MAC doesn't have
support for flow control, and thus can't use rate matching.

Not only have the electrical charateristics been violated by selecting
a faster interface than the hardware was designed for, but we now have
rate matching being used when it shouldn't be.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

