Return-Path: <netdev+bounces-250378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A90DD29E32
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C40E8301460B
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287133358C6;
	Fri, 16 Jan 2026 02:06:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C1930E848;
	Fri, 16 Jan 2026 02:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529217; cv=none; b=Nr+GCxovcJOuGhAJMYqBaQynwvVT/770iSI5v63tI/RImIeLzMNuYrKN6S62QeKlq55zx6lnH6s+vOAIL0aAjnvGAAQaNmf6rNmt7iT1bRMZ7VlLkLn2PTCei6FF4LdY//KW3lOABwXFxCX3YHk/3t2LLErt722n6Ofk4O6sbDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529217; c=relaxed/simple;
	bh=apMdhwJVWWBTz9mFirJg+3uVvP1nm3ZxTL2WJaf0Iws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fD1Dubbqi6YsVipTytxMVqxwAFAgTY4l/ZkQRc6sTWK8tifzqnqq3FrBQJ2T7YyGyyLwj+kzHC7wu9RYkKgcEaGNdfPP83YPVAnF11G6zREFNjdk+NjFqXRB/th4zzkYDrYArtT1sIPH1eCGsL9r/BzWkO+aB+nK5WU2Hu9EjeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vgZEe-000000007yQ-1E8f;
	Fri, 16 Jan 2026 02:06:48 +0000
Date: Fri, 16 Jan 2026 02:06:43 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next] net: phy: intel-xway: workaround stale LEDs
 before link-up
Message-ID: <aWmdMyJbzaoETETA@makrotopia.org>
References: <d70a1fa9b92c7b3e7ea09b5c3216d77a8fd35265.1768432653.git.daniel@makrotopia.org>
 <dd6ddb96-7aa9-4142-b991-5f27a4276a92@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd6ddb96-7aa9-4142-b991-5f27a4276a92@lunn.ch>

On Fri, Jan 16, 2026 at 02:23:18AM +0100, Andrew Lunn wrote:
> On Thu, Jan 15, 2026 at 11:40:38PM +0000, Daniel Golle wrote:
> > Due to a bug in some PHY internal firmware, manual control as well as
> > polarity configuration of the PHY LEDs has no effect until a link has
> > been detected at least once after reset. Apparently the LED control
> > thread is not started until then.
> > 
> > As a workaround, clear the BMCR_ANENABLE bit for 100ms to force the
> > firmware to start the LED thread, allowing manual LED control and
> > respecting LED polarity before the first link comes up.
> > 
> > In case the legacy default LED configuration is used the bug isn't
> > visible, so only apply the workaround in case LED configuration is
> > present in the device tree.
> 
> You should consider the case of forced links, where autoneg is
> disabled. Under such conditions, you should not leave autoneg enabled.

If BMCR_ANENABLE has already been disabled after a reset we can skip
this workaround entirely, as doing that once for more than 100ms is all
needed for the LEDs to work properly.

However, I'm not aware of .config_init ever being run again after the
intial attachment of the PHY and call to phy_init_hw().

All user-defined configuration happens after that, and would then remove
the BMCR_ANENABLE bit just like it would do it if it was set by the
hardware after reset.
(note that BMCR_ANENABLE is set as part of the reset value of BMCR on
this PHY)

But maybe I'm getting something wrong here?

