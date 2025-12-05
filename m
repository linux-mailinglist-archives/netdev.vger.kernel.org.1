Return-Path: <netdev+bounces-243836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B578CCA85F2
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 17:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE44D3016B97
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 16:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECAB284886;
	Fri,  5 Dec 2025 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KtOypcuG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC2331200;
	Fri,  5 Dec 2025 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764952058; cv=none; b=bKKVxlKa0c+Puv3xUfNXFRadfJvC6eh61JjGUMnyFutZNIaSlQxtBef2twkYszN/48CCd6BKv3FQcFUmpheCRFvFV/zgW4YQKF22CWXTsREEgkE/yuFdcf9LQsYNI1I6QlU0+KDX321JWdkAAaI2EWuXqlTJSP+YZxW463D0D6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764952058; c=relaxed/simple;
	bh=ekV++zjS2wgscKuYs4PC/5i/NulJOQwEE4OgQq1jlic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXG/BhMEP23Q6xy0H8Z6J3qa5mB3cziEusQ4nH/10Xedvrrl4V3TNc/gcu95TLl0/GR2ewctdBIW0mgxsBtfgcDnDKQuSglpBc6JKvWcArJ7KCuI4gpf0mcay1KkopQH9DWE2BCiUDLj0xhQJLv48uIXdMtRbRoZzgq/mu88kqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KtOypcuG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PXx7xvBqJGTNz7ExhOiA0jOZDvhF2wSa5G1m+1yth2Q=; b=KtOypcuGP5Qgpo5D34xYJhc0ED
	4+p+lPBkpuGBW5fF2qsNU7aPIzb7t0flsKW44Rs8c8Dx7F1HjB7rT8gJAOQnYckv0bAQsOR+nOhHA
	SWwGi9MrVyUiQUAk+vq9en2MQhk/o27v1njHmm5YmYxTNh3qGv5F/L+vgt4LhoTuy6w0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vRYCD-00G6n6-Ig; Fri, 05 Dec 2025 16:58:13 +0100
Date: Fri, 5 Dec 2025 16:58:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: dsa: mxl-gsw1xx: manually clear RANEG bit
Message-ID: <60a61eea-0737-4137-b2de-8898117c9b56@lunn.ch>
References: <ab836f5d36e3f00cd8e2fb3e647b7204b5b6c990.1764898074.git.daniel@makrotopia.org>
 <97389f24-d900-4ff0-8a80-f75e44163499@lunn.ch>
 <aTLkl0Zey4u4P8x6@makrotopia.org>
 <aTL3kc1spFf3bIzf@shell.armlinux.org.uk>
 <aTL886vReHP74XPn@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTL886vReHP74XPn@makrotopia.org>

On Fri, Dec 05, 2025 at 03:40:35PM +0000, Daniel Golle wrote:
> On Fri, Dec 05, 2025 at 03:17:37PM +0000, Russell King (Oracle) wrote:
> > On Fri, Dec 05, 2025 at 01:56:39PM +0000, Daniel Golle wrote:
> > > On Fri, Dec 05, 2025 at 02:45:35PM +0100, Andrew Lunn wrote:
> > > > On Fri, Dec 05, 2025 at 01:32:20AM +0000, Daniel Golle wrote:
> > > > > Despite being documented as self-clearing, the RANEG bit sometimes
> > > > > remains set, preventing auto-negotiation from happening.
> > > > > 
> > > > > Manually clear the RANEG bit after 10ms as advised by MaxLinear, using
> > > > > delayed_work emulating the asynchronous self-clearing behavior.
> > > > 
> > > > Maybe add some text why the complexity of delayed work is used, rather
> > > > than just a msleep(10)?
> > > > 
> > > > Calling regmap_read_poll_timeout() to see if it clears itself could
> > > > optimise this, and still be simpler.
> > > 
> > > Is the restart_an() operation allowed to sleep? Looking at other
> > > drivers I only ever see that it sets a self-clearing AN RESTART bit,
> > > never waiting for that bit to clear. Hence I wanted to immitate
> > > that behavior by clearing the bit asynchronously. If that's not needed
> > > and msleep(10) or usleep_range(10000, 20000) can be used instead that'd
> > > be much easier, of course.
> > 
> > Sleeping is permitted in this code path, but bear in mind that it
> > will be called from ethtool ops, and thus the RTNL will be held,
> > please keep sleep durations to a minimum.
> 
> In that sense 10ms (on top of the MDIO operation) is not that little.
> Maybe it is worth to use delayed_work to clear the bit after all...

Do you have any idea how often it does not self clear? And if it does
self clear, how fast does it clear?

If it self clears after 1ms with 99% probability,
regmap_read_poll_timeout() with a 1ms poll interval will mostly just
cost 1ms, which is not too bad. Its just the 1% when you need the full
10ms.

	Andrew

