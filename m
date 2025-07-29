Return-Path: <netdev+bounces-210820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2B5B14F76
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 16:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E742318A1E6F
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 14:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCC61DE8AE;
	Tue, 29 Jul 2025 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rOFvNinT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED96E14C588
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800265; cv=none; b=vAb0pSrx9hBR5Ctoyw70A5ci7WNC4OON0w2lQv06bENQI7oADrCquvxJdZFNo0I7GyF8t9PeZuDMs05+Nhydc7UI2VvFYfpVXwwAfoxoG1q9G0crj+k/x3S1vTPGbP+t331TZPa5ty7MvMeBohnKbS62ZuiIkqZr2g0/ND92BPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800265; c=relaxed/simple;
	bh=3ditI+akxsMAF/GpnuVbfbZ9F4jaHP2MfEjO53eVvUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toIP7A4AQ5Ltu5yumWCPPKmlSITuvEw8KXdjfJDWRzJzLka6HysEyQBDbZ+rGc5+AdbuhxR/bSpUYKe0fS1KZMUqH+3/77rjcHXaKnqNNQkSFUVCCo3IMSuIlC4aocBgcClLP15U7rXGnSlgVqAJgZk5P19EzqbQT4NpEHcFKks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rOFvNinT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t8wGSo9XATI3giAKMDKds/aq062osT6tctjbABHT4DA=; b=rOFvNinTRkQwE4gVwqDsOV+G2g
	WQMQIiYCE+SssYAg7ZmPkhr+NqZpwkOw3HtWlU2BEnRn5RJeQsHxrrGp6SfzRT/fBT/2iwJfhbObM
	DocjlT/P0G4Oc1nNbgHI9erZEnHZdsfxXr8lIWupUSzqpWD8nTKs6QvLUiNEk/5XqTO+fxuR9xcMS
	ACzWzfIol4DruUvddnbxZFuxwgim5xkFpuFN7sB2Y5dYMYLBW75N/DI8WdO9yNVQgysyQhxjLvqrG
	P9OswWzkGnZ6wHTK6hRcJQZBCNpyrOm0dczrDBk/L97ZwFMkvlvu0vrmLeTuNs5OctVa6zhpphXOt
	hFC+au7A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60690)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uglYu-00023b-2f;
	Tue, 29 Jul 2025 15:44:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uglYr-0007Ud-0E;
	Tue, 29 Jul 2025 15:44:13 +0100
Date: Tue, 29 Jul 2025 15:44:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Linux-stm32] [PATCH RFC net-next 6/7] net: stmmac: add helpers
 to indicate WoL enable status
Message-ID: <aIjePMWG6pEBvna6@shell.armlinux.org.uk>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
 <E1ugQ33-006KDR-Nj@rmk-PC.armlinux.org.uk>
 <eaef1b1b-5366-430c-97dd-cf3b40399ac7@lunn.ch>
 <aIe5SqLITb2cfFQw@shell.armlinux.org.uk>
 <77229e46-6466-4cd4-9b3b-d76aadbe167c@foss.st.com>
 <aIiOWh7tBjlsdZgs@shell.armlinux.org.uk>
 <aIjCg_sjTOge9vd4@shell.armlinux.org.uk>
 <d300d546-09fa-4b37-b8e0-349daa0cc108@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d300d546-09fa-4b37-b8e0-349daa0cc108@foss.st.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 29, 2025 at 03:10:56PM +0200, Gatien CHEVALLIER wrote:
> 
> 
> On 7/29/25 14:45, Russell King (Oracle) wrote:
> > On Tue, Jul 29, 2025 at 10:03:22AM +0100, Russell King (Oracle) wrote:
> > > With Thierry's .dts patch, PHY interrupts completely stop working, so
> > > we don't get link change notifications anymore - and we still don't
> > > seem to be capable of waking the system up with the PHY interrupt
> > > being asserted.
> > > 
> > > Without Thierry's .dts patch, as I predicted, enabling WoL at the
> > > PHY results in Bad Stuff happening - the code in the realtek driver
> > > for WoL is quite simply broken and wrong.
> > > 
> > > Switching the pin from INTB mode to PMEB mode results in:
> > > - No link change interrupts once WoL is enabled
> > > - The interrupt output being stuck at active level, causing an
> > >    interrupt storm and the interrupt is eventually disabled.
> > >    The PHY can be configured to pulse the PMEB or hold at an active
> > >    level until the WoL is cleared - and by default it's the latter.
> > > 
> > > So, switching the interrupt pin to PMEB mode is simply wrong and
> > > breaks phylib. I guess the original WoL support was only tested on
> > > a system which didn't use the PHY interrupt, only using the interrupt
> > > pin for wake-up purposes.
> > > 
> > > I was working on the realtek driver to fix this, but it's pointless
> > > spending time on this until the rest of the system can wake up -
> > > and thus the changes can be tested. This is where I got to (and
> > > includes work from both Thierry and myself, so please don't pick
> > > this up as-is, because I can guarantee that you'll get the sign-offs
> > > wrong! It's a work-in-progress, and should be a series for submission.)
> > 
> > Okay, with this patch, wake-up now works on the PHY interrupt line, but
> > because normal interrupts aren't processed, the interrupt output from
> > the PHY is stuck at active level, so the system immediately wakes up
> > from suspend.
> > 
> 
> If I'm following correctly, you do not use the PMEB mode and share
> the same pin for WoL and regular interrupts (INTB mode)?

As the driver is currently structured, switching the pin to PMEB mode
in .set_wol() breaks phylib, since as soon as one enables WoL at the
PHY, link state interrupts are no longer delivered.

It may be appropriate to switch the pin to PMEB mode in the suspend
method while waiting for a wakeup but we need code in place to deal
with the resulting interrupt storm (by clearing the wakeup) and that
code is missing.

The other approach would be to leave the pin in INTB mode, and
reconfigure the interrupt enable register (INER) to allow WoL
interrupts, maybe disabling link state interrupts (more on that
below.) This has the advantage that reading the interrupt status
register clears the interrupt - and that code already exists so we
avoid the interrupt storm.

> > Without the normal interrupt problem solved, there's nothing further
> > I can do on this.
> > 
> > Some of the open questions are:
> > - whether we should configure the WoL interrupt in the suspend/resume
> >    function
> 
> For the LAN8742 PHY with which I worked with, the recommendation when
> using the same pin for WoL and regular interrupt management is to mask
> regular interrupt and enable the WoL IIRC.

That's only really appropriate if the MAC isn't involved in WoL. Let's
say that the PHY can support magic-packet WoL, but the MAC can also
support unicast frame WoL, and the user has enabled both.

The system goes to sleep (e.g. overnight) and during the night, there's
a hiccup which causes the link to drop and re-establish at a slower
speed.

Since the MAC has not been reconfigured (because the link state
interrupt is disabled, and thus won't wake the system) the MAC can now
no longer receive unicast frames to check whether they match the
despired system wakeup condition.

So, this poses another question: do we really want to support
simultaneous PHY and MAC level WoL support, or should we only allow
one or other device to support WoL?

If we explicitly deny the WoL at both approach, then we don't have
to care about link state interrupts, because the PHY will be able
to cope with the different link speed without needing to wake the
iystem to reconfigure the network interface for the new link
parameters.

> This prevents the PHY from waking up from undesired events while still
> being able use the WoL capability and should be done in suspend() /
> resume() callbacks. I guess this means also that you share the same
> interrupt handler that must manage both WoL events and regular events.
> 
> On the other hand, on the stm32mp135f-dk, the nPME pin (equivalent to
> PMEB IIUC) is wired and is different from the nINT pin. Therefore, I
> guess it should not be done during suspend()/resume() and it really
> depends on how the PHY is wired. Because if a WoL event is received at
> runtime, then the PHY must clear the flags otherwise the WoL event won't
> trigger a system wakeup afterwards.
> 
> I need to look at how the PHYs can handle two different interrupts.

The RTL8211F only has one pin (pin 31) which can be used in INTB mode
or PMEB mode. You can't have independent interrupt and wakeup signals
with this PHY.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

