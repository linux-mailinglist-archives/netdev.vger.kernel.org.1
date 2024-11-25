Return-Path: <netdev+bounces-147246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06CB9D8A75
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 17:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D80285FF5
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 16:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485951B4F14;
	Mon, 25 Nov 2024 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZyQ4GA2p"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D431ADFFE
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732552469; cv=none; b=MQzJaALRlrxAoTD94Q/zoJNL8/2YBV1ELF++V7G+WsldK0bbJEwEn4KA5Ddet9WPz7wmLbEp7F2RVmPnAF6PRoxCvbH93Gx6z2ta9UzyQuotBG5LNxZqirCtpnrcl+OoiDs5iTlRnPY900CIKvtZ2aP6eYgA89mRrMRSRod7tkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732552469; c=relaxed/simple;
	bh=ZHmCgfg++r55a4SQ/VaFBEl7sVlsjjkgBdelBnA+9O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKC3uIHj6bOvMzgCKsOyRN51z3S0OdidNL8rx7sl0Dppu/h7F7r7dKBr4F7i/UxtDZbn8DlSdKG7PfCBQ5OpISX0fbCN+t6YaPA1i56p5OrZ1e1bT9fCqZzLKSl48fFgjcUkC1ESBqaFG+TIRl1AOG67ql7otQIPVc67DKErBQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZyQ4GA2p; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3qQ4evFuvQLIwOYQPLLoWVobf5IVO4M2mgqfCtW7AH4=; b=ZyQ4GA2p0QEeBS4lhuio6vo8Aa
	zAmgLG0Y5jfe7ye+5+jZcCs224hlhNcYStkT7uVNPoRP3MZENJHscEd5Ufgne2mXwi8P7E4MXPj+R
	+trXKyqz5NRBlCd23Wpphrf/bAlDlQuHF7cvOvc4L4ezVQjuYVXhSF7qsC2PYcoiotqs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tFc2Z-00EPKP-6L; Mon, 25 Nov 2024 17:34:23 +0100
Date: Mon, 25 Nov 2024 17:34:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, Russell King <linux@armlinux.org.uk>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Moving forward with stacked PHYs
Message-ID: <320e6ab6-3299-4b6c-af66-191dc9c5052d@lunn.ch>
References: <20241119115136.74297db7@fedora.home>
 <Zz7zqzlDG40IYxC-@pengutronix.de>
 <1646a5bd-24c7-43fb-9d52-25966aafb80f@lunn.ch>
 <20241125094622.65f0bb97@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125094622.65f0bb97@fedora.home>

> The way I see this is based on the phy_link_topology. What is done
> currently is that the SFP PHY is added to the topology when :
> 
>  - The .connect_phy() SFP upstream op is called, but ONLY if the
> upstream PHY is attached to its netdev (otherwise, the upstream PHY
> isn't in the topology)
> 
>  - Alternatively if the SFP phy is already attached to its upstream,
> both the upstream PHY and the SFP PHY will be added to the tpopology
> when the upstream PHY gets attached to its netdev.
> 
> The notification would be sent at that time. We can't really send it
> before the PHYs are part of the topology because at that point we don't
> know to which netdev it belongs.

I agree we cannot notify until we know where it goes in the chain. But
i was wondering if this is too early? Is it guaranteed that
phy_init_hw() is complete? We don't want userspace trying to
reconfigure the PHY of it then to be overwritten.

It would be good if the commit message adding the notification
explains what has already happened when the notification is sent, what
state the PHY is in.

> The way I see that, based on the appereance of PHYs, userspace may want
> to re-ajust configuration, especially if :
>  - The PHY is attached in .ndo_open() and
>  - The PHY provides some kind of offloading capability (Timestamping,
> maybe more such as macsec)
> 
> In that case, it's possible that userspace is interested in knowing
> that a new PHY is here to re-adjust the offloads to the PHY.

So do we need to be at the point that we know its EEE capabilities? It
has registers its MACSec capabilities and timestamper? Again, this
should be part of the commit message. What can a user of the
notification expect to have happened, and what has not yet happened,
or is ongoing and might race with.

	Andrew

