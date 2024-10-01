Return-Path: <netdev+bounces-131073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D745298C7F7
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 00:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3A01F23FDF
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207FA1CC178;
	Tue,  1 Oct 2024 22:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HESE6Zyk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F851BDAB9
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 22:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727820588; cv=none; b=HIAURyAJ7e8PcK/gqQDgsGXeZVv2fsZllr+tf8ZvLK3BEjAvN7EmCnh/QLfnxYdC84GqzPwJarK4cAmkTkw2B3yNQPaKv6KuJquLrOa+cqMgTAz7ZgW6DXPVjKX2v2QMl9Ta4+m+yrZLCPRQymrJ3WK0lqe73Cz4wn0IH+saJWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727820588; c=relaxed/simple;
	bh=MAL8tfmDDF77qsU7okOwW+AytLv410Zg8jYMeeeA/Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZleKWa6fnJ3UOjlc5TkAHXg/XJm74yr9P34S72DWWVPGroTlcLiiKQsvPeu45kXZf3XHSPwNVbzaQ3L3LxpU8Y84a9ZGYxCMfF9+G8+HLmsuq5xXP7IziIMx3T6p56YDRqljO+RIywAeQraN3baATKGP76IjfuIT61r/4pl6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HESE6Zyk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=udSbcyfEMfJgdgpqH6I5MbyBPW4Wm04lU8PD76G0N2g=; b=HESE6ZykHS7rrlzReeyyn+ptSJ
	aDPHtUstobL4w/72soEp5moL7PoA3lKfFpIvdp6LcjZVJQlGtd9lvSrKaAJwH4+aiHWe0CBswtaN+
	VsWoYdR2hqgMolDbGYZ1atEO/f/cazF5cO7Sb/sUTrt+moAbrowd2t/kGo6fXNy9qGic=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svl3a-008mQr-1n; Wed, 02 Oct 2024 00:09:22 +0200
Date: Wed, 2 Oct 2024 00:09:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next 01/10] net: pcs: xpcs: move PCS reset to
 .pcs_pre_config()
Message-ID: <68bc05c2-6904-4d33-866f-c828dde43dff@lunn.ch>
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
 <E1svfMA-005ZI3-Va@rmk-PC.armlinux.org.uk>
 <fp2h6mc2346egjtcshek4jvykzklu55cbzly3sj3zxhy6sfblj@waakp6lr6u5t>
 <ZvxxJWCTD4PgoMwb@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvxxJWCTD4PgoMwb@shell.armlinux.org.uk>

> I'm wondering why we seem to be having a communication issue here.
> 
> I'm not sure which part of "keeping the functional changes to a
> minimum for a cleanup series" you're not understanding. This is
> one of the basics for kernel development... and given that you're
> effectively maintaining stmmac, it's something you _should_ know.
> 
> So no, I'm going to outright refuse to merge your patch in to this
> series, because as I see it, it would be wrong to do so. This is
> a _cleanup_ series, not a functional change series, and what you're
> proposing _changes_ the _way_ reset happens in this driver beyond
> the minimum that is required for this cleanup. It's introducing a
> completely _new_ way of writing to the devices registers to do
> the reset that's different.

I have to agree with Russell. Cleanups should be as simple as
possible, and hopefully obviously correct. They should be low risk.

Lets do all the simple cleanups first. Later we can consider more
invasive and risky changes.

	Andrew

