Return-Path: <netdev+bounces-195506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D060AD0A0B
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 00:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8FCF189A093
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 22:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18075234964;
	Fri,  6 Jun 2025 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1W8a78cY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670C2217F55
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 22:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749250031; cv=none; b=m5EZGTWVsXStzM1k9IO76ruLh6S3/jqQryS5lGjHLYZkve1+2m0AY9NiAxw9TOfplD68v8lPG466dplAq26fCArT6cjmO13sYTtMFlHS2OQfFBTHSxM0Zd+UpKUE0FDzR5vMtVhifYVJp6oOVvSn7cJd5Dz5+fM+2/yNynU+z4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749250031; c=relaxed/simple;
	bh=q8OL3v13UMCcghM3Q+xjHkM1GNleZQ1Og4t2VuQMaC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0R80iApqTv4hyrsvha1rp26apn8fVtmGqSlV0wZzu9cNYJ7vXO1BIO7xmZjDcRHIyN4YRHeWx/mNlNzesXZ+KtgqrVIaC4KbMI2bSGdpCjYeuSs2NZqdNyoPy0lAORM0X+FSIPsSQIRclU4Ga+8dKhV1r0ChpyRVd7m7WlSnxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1W8a78cY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xyRLYFkae5reBvNtrcUvWWTQgak3G2SXuQFa6XVeLmI=; b=1W8a78cYaZwXRMQKRNWTpG9+hK
	FhcDIw5nYvXiwAaex9LToGdrOFjbrb37BIcVMQomfapQeMBxFoKhB7gKIs+t9H0M9irshwklF5JRO
	foUKk7Ik8fobImLFgQ7ZJbx8knGuIS7eJXfCDB5WQURPiGxOGk2XD/DpuhH8qOjzRIFrLmPIThnNM
	EhcJU32wcAsJ0dIgy8artjE7wyAk2cPseg8Gztx0Mya+TEwr/RLK4ICf/TKd6TmbAVjkax3zB/DQJ
	V4M6w+eQZ7ZEVwJ8vmswNGib7xd7QXHw5zRYEA1GJrRu3eqa35WV6LZIDfgFJ/xo67CQFuiyF/KT+
	RPA8OXwA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54216)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uNfq3-0001Ev-1m;
	Fri, 06 Jun 2025 23:47:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uNfq0-0003bn-22;
	Fri, 06 Jun 2025 23:47:00 +0100
Date: Fri, 6 Jun 2025 23:47:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chris Morgan <macroalpha82@gmail.com>,
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH V2] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
Message-ID: <aENv5BI2Amtqui4v@shell.armlinux.org.uk>
References: <20250606022203.479864-1-macroalpha82@gmail.com>
 <ab987609-0cc7-4051-bc51-234e254cbec0@lunn.ch>
 <SN6PR1901MB46541BA6488F73EB49EBCDDFA56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
 <eb99e702-5766-4af6-b527-660988ad9b54@lunn.ch>
 <SN6PR1901MB465464D2B7D905F6CD076F3FA56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
 <aENb4YX4mkAUgfi2@shell.armlinux.org.uk>
 <SN6PR1901MB46545250D870E79670E43E06A56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR1901MB46545250D870E79670E43E06A56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jun 06, 2025 at 05:32:43PM -0500, Chris Morgan wrote:
> On Fri, Jun 06, 2025 at 10:21:37PM +0100, Russell King (Oracle) wrote:
> > On Fri, Jun 06, 2025 at 01:54:27PM -0500, Chris Morgan wrote:
> > > 	Option values					: 0x00 0x00
> > 
> > This suggests that LOS is not supported, nor any of the other hardware
> > signals. However, because early revisions of the SFP MSA didn't have
> > an option byte, and thus was zero, but did have the hardware signals,
> > we can't simply take this to mean the signals aren't implemented,
> > except for RX_LOS.
> > 
> > > I'll send the bin dump in another message (privately). Since the OUI
> > > is 00:00:00 and the serial number appears to be a datestamp, I'm not
> > > seeing anything on here that's sensitive.
> > 
> > I have augmented tools which can parse the binary dump, so I get a
> > bit more decode:
> > 
> >         Enhanced Options                          : soft TX_DISABLE
> >         Enhanced Options                          : soft TX_FAULT
> >         Enhanced Options                          : soft RX_LOS
> > 
> > So, this tells sfp.c that the status bits in the diagnostics address
> > offset 110 (SFP_STATUS) are supported.
> > 
> > Digging into your binary dump, SFP_STATUS has the value 0x02, which
> > indicates RX_LOS is set (signal lost), but TX_FAULT is clear (no
> > transmit fault.)
> > 
> > I'm guessing the SFP didn't have link at the time you took this
> > dump given that SFP_STATUS indicates RX_LOS was set?
> > 
> 
> That is correct.

Are you able to confirm that SFP_STATUS RX_LOS clears when the
module has link?

> > Now, the problem with clearing bits in ->state_hw_mask is that
> > leads the SFP code to think "this hardware signal isn't implemented,
> > so I'll use the software specified signal instead where the module
> > indicates support via the enhanced options."
> > 
> > Setting bits in ->state_ignore_mask means that *both* the hardware
> > and software signals will be ignored, and if RX_LOS is ignored,
> > then the "Options" word needs to be updated to ensure that neither
> > inverted or normal LOS is reported there to avoid the state machines
> > waiting indefinitely for LOS to change. That is handled by
> > sfp_fixup_ignore_los().
> > 
> > If the soft bits in SFP_STATUS is reliable, then clearing the
> > appropriate flags in ->state_hw_mask for the hardware signals is
> > fine.
> 
> I'll test this out more and resubmit once I confirm that simply setting
> state_hw_mask (which means we don't do it in hardware) works just the
> same on my device as state_ignore_mask. So if I understand correctly
> that means we're doing the following:
> 
> sfp_fixup_long_startup(sfp);
> sfp->state_hw_mask &= ~(SFP_F_TX_FAULT | SFP_F_LOS);
> 
> The long startup solves for the problem that the SFP+ device has to
> boot up; and the state_hw_mask solves for the TX and LOS hardware
> pins being used for UART but software TX fault and LOS still working.

I'd prefer to have an additional couple of functions:

sfp_fixup_ignore_hw_tx_fault()
sfp_fixup_ignore_hw_los()

or possibly:

sfp_fixup_ignore_hw(struct sfp *sfp, unsigned int mask)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

