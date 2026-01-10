Return-Path: <netdev+bounces-248734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFDCD0DD42
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 21:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6C87300C2A1
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 20:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BB029AAFA;
	Sat, 10 Jan 2026 20:08:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00FB28688D
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768075718; cv=none; b=I95gwjjnsBFB9aWUL/v3qtXsR8/QcVg+xjXa1msx0Ytjw4VfwJPNX/FgnbTtSIpLCO07B8Kx2k5bv7gT00mQiTk98iB5GHknbQc/Xv007NqMOrRJcoqCo2JWhHLWCxMy1xbLQRvoWREYj+wOOAnyLhyh8Ydat985V92BDVxCea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768075718; c=relaxed/simple;
	bh=q2eKViv57JjL52XiwmQ/pah0/sGTPKfLqUBRMpU2UNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNQG463DcC8ot356o81e4CM1ZRumZRJ2aseF9q+w6li3plbFCXK90KJKB1ZOtRy9YdrgbmzF92CliuaM+Zr7FNh+2cEoDWLEaSZxCuRE/L46EMeTBUHELxYK16yMJbPFCFWlcCRG0Wsle+7iveSe8z2V+VUOVn/xY1gaZ/hyZdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vefFv-000000006Qq-3P1q;
	Sat, 10 Jan 2026 20:08:15 +0000
Date: Sat, 10 Jan 2026 20:08:12 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/2] r8169: add support for RTL8127ATF (10G
 Fiber SFP)
Message-ID: <aWKxrOfWncySwz69@makrotopia.org>
References: <c2ad7819-85f5-4df8-8ecf-571dbee8931b@gmail.com>
 <20260110104859.1264adf3@kernel.org>
 <6df422fa-5d65-435f-896b-6495c63eaacf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6df422fa-5d65-435f-896b-6495c63eaacf@gmail.com>

On Sat, Jan 10, 2026 at 09:03:05PM +0100, Heiner Kallweit wrote:
> On 1/10/2026 7:48 PM, Jakub Kicinski wrote:
> > On Sat, 10 Jan 2026 16:12:30 +0100 Heiner Kallweit wrote:
> >> RTL8127ATF supports a SFP+ port for fiber modules (10GBASE-SR/LR/ER/ZR and
> >> DAC). The list of supported modes was provided by Realtek. According to the
> >> r8127 vendor driver also 1G modules are supported, but this needs some more
> >> complexity in the driver, and only 10G mode has been tested so far.
> >> Therefore mainline support will be limited to 10G for now.
> >> The SFP port signals are hidden in the chip IP and driven by firmware.
> >> Therefore mainline SFP support can't be used here.
> >> The PHY driver is used by the RTL8127ATF support in r8169.
> >> RTL8127ATF reports the same PHY ID as the TP version. Therefore use a dummy
> >> PHY ID.
> > 
> > Hi Heiner!
> > 
> > This series silently conflicts with Daniel's changes. I wasn't clear
> > whether the conclusion here:
> > https://lore.kernel.org/all/1261b3d5-3e09-4dd6-8645-fd546cbdce62@gmail.com/
> > is that we shouldn't remove the define or Daniel's changes are good 
> > to go in.. Could y'all spell out for me what you expect?
> 
> I'm fine with replacing RTL_VND2_PHYSR with RTL_PHYSR, as proposed by Daniel.
> However, as this isn't a fully trivial change, I'd like to avoid this change
> in my series, and leave it to Daniel's series. Means he would have to add
> the conversion of the call I just add.
> Which series to apply first depends on whether Daniel has to send a new version,
> or whether it's fine as-is. There was a number of comments, therefore I'm not
> 100% sure.

Imho it makes sense to merge RTL8127ATF first and I'll resend my current
series. There was a typo in one of the commit messages, but more than that
I think it does make sense to merge the non-controveral hardware addition
before applying any potentially disruptive stuff which affects practically
all PHYs supported by the driver (doesn't mean that I expect any disruption
what-so-ever, but as a matter of principle it just seems right to do it
that way around).


