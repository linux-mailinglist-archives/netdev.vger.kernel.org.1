Return-Path: <netdev+bounces-243873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87851CA90DE
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 20:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16AED30B3A0C
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 19:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E966E3502A4;
	Fri,  5 Dec 2025 19:06:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7851E34C98F;
	Fri,  5 Dec 2025 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764961588; cv=none; b=qF6SoNInr1086WCZ3QaGSaNifnCUMrtqqflXrUNwHEN3GBJh0zer5JObbK3kCjxfLm2kH5gnJ0RIQfgJFpkJ7+j8jdv4grP4647oT5O6uzcq/4zK8tIBYH0FsS0bFXVCeXCdFTXSfdFZhsBKQyav4LK3tvQMixjy2pCT7xQWUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764961588; c=relaxed/simple;
	bh=yVcQSmPKA4SVSjHz5hMRB2hKuuB8+uN4+7GTS8/6w4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBPWhEIw3NgmpUgMKPtXRaqq0VfoZ1aiik+J27mb9cQ60F75tN2EJdoxkAq+G+O/Mhlm0cdA6Ihak/7symxVQRw7ff+IdcY4UKsAm4W3aQej5tzn1oCVcnwAHpPrf+hi4j3HXoUF224d+Bn2McKNbl75vtUSotqVaZoHHhqjMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vRb8A-000000006yo-0LyS;
	Fri, 05 Dec 2025 19:06:14 +0000
Date: Fri, 5 Dec 2025 19:06:11 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Hauke Mehrtens <hauke@hauke-m.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: dsa: mxl-gsw1xx: manually clear RANEG bit
Message-ID: <aTMtI5VseldRIUnF@makrotopia.org>
References: <ab836f5d36e3f00cd8e2fb3e647b7204b5b6c990.1764898074.git.daniel@makrotopia.org>
 <97389f24-d900-4ff0-8a80-f75e44163499@lunn.ch>
 <aTLkl0Zey4u4P8x6@makrotopia.org>
 <aTL3kc1spFf3bIzf@shell.armlinux.org.uk>
 <aTL886vReHP74XPn@makrotopia.org>
 <aTL_0ZHa3vggLz6z@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTL_0ZHa3vggLz6z@shell.armlinux.org.uk>

On Fri, Dec 05, 2025 at 03:52:49PM +0000, Russell King (Oracle) wrote:
> On Fri, Dec 05, 2025 at 03:40:35PM +0000, Daniel Golle wrote:
> > On Fri, Dec 05, 2025 at 03:17:37PM +0000, Russell King (Oracle) wrote:
> > > On Fri, Dec 05, 2025 at 01:56:39PM +0000, Daniel Golle wrote:
> > > > On Fri, Dec 05, 2025 at 02:45:35PM +0100, Andrew Lunn wrote:
> > > > > On Fri, Dec 05, 2025 at 01:32:20AM +0000, Daniel Golle wrote:
> > > > > > Despite being documented as self-clearing, the RANEG bit sometimes
> > > > > > remains set, preventing auto-negotiation from happening.
> > > > > > 
> > > > > > Manually clear the RANEG bit after 10ms as advised by MaxLinear, using
> > > > > > delayed_work emulating the asynchronous self-clearing behavior.
> > > > > 
> > > > > Maybe add some text why the complexity of delayed work is used, rather
> > > > > than just a msleep(10)?
> > > > > 
> > > > > Calling regmap_read_poll_timeout() to see if it clears itself could
> > > > > optimise this, and still be simpler.
> > > > 
> > > > Is the restart_an() operation allowed to sleep? Looking at other
> > > > drivers I only ever see that it sets a self-clearing AN RESTART bit,
> > > > never waiting for that bit to clear. Hence I wanted to immitate
> > > > that behavior by clearing the bit asynchronously. If that's not needed
> > > > and msleep(10) or usleep_range(10000, 20000) can be used instead that'd
> > > > be much easier, of course.
> > > 
> > > Sleeping is permitted in this code path, but bear in mind that it
> > > will be called from ethtool ops, and thus the RTNL will be held,
> > > please keep sleep durations to a minimum.
> > 
> > In that sense 10ms (on top of the MDIO operation) is not that little.
> > Maybe it is worth to use delayed_work to clear the bit after all...
> 
> ... in which case I think you need to do a better job.
> 
> The cancel_delayed_work() in the pcs_disable() method means if we
> stopp using this PCS briefly while the AN restart bit is set, there's
> nothing that will clear it.

The reset of the whole PCS unit (which is asserted in .pcs_disable and
deasserted in .pcs_enable) also resets the AN restart bit.

> 
> There are other implementations that have this problem. mvneta has
> the same problem, but there we can write the register to set the
> MVNETA_GMAC_INBAND_RESTART_AN, and then immediately write it again
> without delay to clear this bit. The bit is documented as self
> clearing, but practical observation indicates it never does.
> 
> Are you sure you need to wait 10ms ? What happens if you set the
> bit and then immediately clear it, like we do for mvneta?

MaxLinear engineer Benny Weng has told me (quote):

"I did a check on the REANEG bit, [...] and it needs to clear the bit
manually and please give 10ms delay in between."

In my observation the bit *does* clear itself *most* of the time,
but aparently when being set in the wrong moment it doesn't. This
makes testing rather difficult and I'd just follow their advise.

