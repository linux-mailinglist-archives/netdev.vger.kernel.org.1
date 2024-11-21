Return-Path: <netdev+bounces-146641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0AD9D4D1E
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 13:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946FF284251
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 12:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC6F1D3656;
	Thu, 21 Nov 2024 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Is4bGFhw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C791CB9F9;
	Thu, 21 Nov 2024 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732193394; cv=none; b=SD42WzuvGEE3j1L5QzHMsk4dN6Q7Y+JiXvV/t0YxsXJoWrPNv0W/VJtOkaDlXeaROUAKa185nQFV8VD/aML8WHWtbg6pXkQikOvVin4NLsjy2MDiM9y1P6orQmk4WO7gadPf4XIB0efMaYFQLoBL8fFhbZ1/EVXFgpuIWdvDDYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732193394; c=relaxed/simple;
	bh=89BAQ/YroiD9FSqwYRj0v6+SNU51MwwGl3k7/5m8NLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+bV12soPAptyTU+4nhYnV98CRqrdN9HCiZBqehAgAwQDV609MRng4B3SrpTK6nIn8WnwBodyDFUK8ADfnikXLDn/K/b6BSN2guTMl5fpqj2ehgVyjqXkMAWLsUsJzmZQd203mNBfq4qHCNLql028XbJIaN8KRlUJuveoK0ebG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Is4bGFhw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lpivMAocVTDsHkAg+ZfnFbdHTIbdTIsRzzLgrJZSVyk=; b=Is4bGFhwfoaUGw+nmiaCeOM9/M
	J+y4fTHTJ/CuH+CYFwsckevyzzK/GNnlRvbkDxrywQ/msJxXQStzjyxmARA8HxUhCg9yeFcSU5Q6m
	4h00V4AqmqIwDVp6Vm/WCrz9GPJ8iAGckiQI2b96kx/4PAz+0MyWw6rxMRcKK6SVDGokCqQiDeF4L
	AAb2o2hms9VmiRyhZ9dgcUq56B227R7JfQFD+SdQTjMVmjKLHwH7dEdH8ZTzM7XO1BONhc37QKFKE
	1D9PMLpERKpjXlQofILuLPH/Jiub6og9AoIWyqP5Nycs6Yi5BxzqbahAhQx21fnKx+0P2yvBZSHsf
	2rso2/1Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45288)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tE6d0-0007DI-26;
	Thu, 21 Nov 2024 12:49:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tE6cy-000842-0F;
	Thu, 21 Nov 2024 12:49:44 +0000
Date: Thu, 21 Nov 2024 12:49:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Cong Yi <yicong.srfy@foxmail.com>, andrew@lunn.ch, hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH] net: phylink: Separating two unrelated definitions for
 improving code readability
Message-ID: <Zz8sZ8WTocbX1x3r@shell.armlinux.org.uk>
References: <Zz2id5-T-2-_jj4Q@shell.armlinux.org.uk>
 <tencent_0F68091620B122436D14BEA497181B17C007@qq.com>
 <20241121105044.rbjp2deo5orce3me@skbuf>
 <Zz8Xve4kmHgPx-od@shell.armlinux.org.uk>
 <20241121115230.u6s3frtwg25afdbg@skbuf>
 <Zz8jVmO82CHQe5jR@shell.armlinux.org.uk>
 <20241121121548.gcbkhw2aead5hae3@skbuf>
 <Zz8nBN6Z8s7OZ7Fe@shell.armlinux.org.uk>
 <20241121124718.7behooc2khmgyfvm@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121124718.7behooc2khmgyfvm@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 21, 2024 at 02:47:18PM +0200, Vladimir Oltean wrote:
> On Thu, Nov 21, 2024 at 12:26:44PM +0000, Russell King (Oracle) wrote:
> > On Thu, Nov 21, 2024 at 02:15:48PM +0200, Vladimir Oltean wrote:
> > > On Thu, Nov 21, 2024 at 12:11:02PM +0000, Russell King (Oracle) wrote:
> > > > On Thu, Nov 21, 2024 at 01:52:30PM +0200, Vladimir Oltean wrote:
> > > > > I don't understand what's to defend about this, really.
> > > > 
> > > > It's not something I want to entertain right now. I have enough on my
> > > > plate without having patches like this to deal with. Maybe next year
> > > > I'll look at it, but not right now.
> > > 
> > > I can definitely understand the lack of time to deal with trivial
> > > matters, but I mean, it isn't as if ./scripts/get_maintainer.pl
> > > drivers/net/phy/phylink.c lists a single person...
> > 
> > Trivial patches have an impact beyond just reviewing the patch. They
> > can cause conflicts, causing work that's in progress to need extra
> > re-work.
> > 
> > I have the problems of in-band that I've been trying to address since
> > April. I have phylink EEE support that I've also been trying to move
> > forward. However, with everything that has happened this year (first,
> > a high priority work item, followed by holiday, followed by my eye
> > operations) I've only _just_ been able to get back to looking at these
> > issues... meanwhile I see that I'm now being asked for stuff about
> > stacked PHYs which is also going to impact phylink. Oh, and to top it
> > off, I've discovered that mainline is broken on my test platform
> > (IRQ crap) which I'm currently trying to debug what has been broken.
> > Meaning I'm not working on any phylink stuff right now because of
> > other people's breakage.
> > 
> > It's just been bit of crap after another after another.
> > 
> > Give me a sodding break.
> 
> I just believe that any patch submitter has the right for their proposal
> to be evaluated based solely on its own merits (even if time has to be
> stretched in order for that to happen), not based on unrelated context.

Right, and my coding preference is as I've written the code. If my
coding preference, as author and maintainer of this file, were
different then I would've written it differently.

Am I not entitled to make my own choices for code I maintain?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

