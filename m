Return-Path: <netdev+bounces-250373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF01D29978
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 147B33014AEB
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 01:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9231F32ABF3;
	Fri, 16 Jan 2026 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wpYtsWoR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F52594BD;
	Fri, 16 Jan 2026 01:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526624; cv=none; b=FP46ljTRbu1KIVbPgxqNGpq/O/arZ/hxJirmTw6tvm50ivXVoep38SW8FrmOE5xHngZeNTYqPOBy6UEnUpdAdfJT1cMfWEvOo2N6Z//bQEYHb28f0N4tRhPhfOPcAKWUUoU+dCNEvbNH8qgbyJB24gJwLbRuwVt2rRaNW4GQ1Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526624; c=relaxed/simple;
	bh=3DwoKQ0WapLzdxrLPSfQCctcbrbNUD4rKjUcIHDL1YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuV3vqZa+AH5PCHv6i8GZpSeSzesv+Ti0XfzHwSf/gEON2MbyD76eeEMNkbOW/IZBKblpizB/eQQpgf9CGSI4GfeBz6fagHzMyHCwQWPB28ag9mqe9uPvEIM8NzFbQ4dgrgZrZ9Fzs7G7U+2i0r48kNq9jZEYawI+SqVR5cqJt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wpYtsWoR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hVBxOsANZK+UyFoJ2ZDGSu3RlMMwgHyL9ikxDVavK90=; b=wpYtsWoRaYAFSLVSKUPyHGNbp+
	5L0xrxgSTJeJHEYOtFaIFt9acTmgIdhJaw4/FpFKJumfqkUkj+v5OZG3EAa9DlBrfLPuuMrvSwP6t
	HzFf68JIpW+9FqnhU5hVB89hdxGI4FrmbLTLxAfCjDacimAyFD469aB4BnTWeonIkG2c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vgYYY-0030i2-KO; Fri, 16 Jan 2026 02:23:18 +0100
Date: Fri, 16 Jan 2026 02:23:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
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
Message-ID: <dd6ddb96-7aa9-4142-b991-5f27a4276a92@lunn.ch>
References: <d70a1fa9b92c7b3e7ea09b5c3216d77a8fd35265.1768432653.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d70a1fa9b92c7b3e7ea09b5c3216d77a8fd35265.1768432653.git.daniel@makrotopia.org>

On Thu, Jan 15, 2026 at 11:40:38PM +0000, Daniel Golle wrote:
> Due to a bug in some PHY internal firmware, manual control as well as
> polarity configuration of the PHY LEDs has no effect until a link has
> been detected at least once after reset. Apparently the LED control
> thread is not started until then.
> 
> As a workaround, clear the BMCR_ANENABLE bit for 100ms to force the
> firmware to start the LED thread, allowing manual LED control and
> respecting LED polarity before the first link comes up.
> 
> In case the legacy default LED configuration is used the bug isn't
> visible, so only apply the workaround in case LED configuration is
> present in the device tree.

You should consider the case of forced links, where autoneg is
disabled. Under such conditions, you should not leave autoneg enabled.

	  Andrew

