Return-Path: <netdev+bounces-196451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 239A2AD4E6F
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601633A4FDC
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1573D2309B6;
	Wed, 11 Jun 2025 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Fhy8LIVi"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FB82367B0
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749630681; cv=none; b=oT9UnAgvvWcUbhCs/VxJsWfQGv67dTWeAHp6lTLfw8nbVdtqygXEu7krksZy4jxO56sWGmippTFgkYC2u2kapPjVASKViiNpmHc/SMwAzU27gbCrq6KnF5bK6A4qC6k2sj5FK+g67B8hFdCmgmDJb9NxhLapN0bX8lPCjEmtb5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749630681; c=relaxed/simple;
	bh=/vwDBjl9yEau2jcTEiQKyUboG2fbIwSob/pGFKRNf1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQp0+S4QaSJpaIoHh5zhArUeBRnAm1ws+DuxwU31tg/5w723sjqLQt7KMQ1MEzhFlS6pr7iPgFWGKs/pLJYGg3eVCWdCNSLeZ43Nm2yQpCgA6c6nXJ2ePul0KjTZaUn2bdzvsOy8TzYz7gTIKbVBsV6hLDbnp8I7AD1bU6fz+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Fhy8LIVi; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TGqx7JiEzOuIGW4c5ERhspoFoZOLiM85mcafwel2dOA=; b=Fhy8LIViRxY2CLPWKzOx50JjEu
	CpNXR4SgpyVasp8QdjIc8rFCvczg04r6tyNS2qx2mBKW8x5LBCzjmcv0OVolKNbjvXOBqwheKa7sX
	MtKUG+K4AJyrJl+ZmvD25OlacljTBPiT8eU8isxMEkA4ednoXgOMnKVSTCvn22nNLEGhlIQcU2OVg
	t5WH760mCjJmA8s7L9oAMCSZHq/VKCcO3PHHjXf6ZlqmrTe0iFeEynuL1CAJsfwSQJ6jVS5llxLj0
	vNwucqn50VpDdK+cepDiQfhbAw2mwuJ+Fdw1dev4U9Gnblg0vSS3rkV3Z0RmRfofll/LYhXpYsa7g
	976Hr+Wg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34298)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uPGrY-0005rR-0A;
	Wed, 11 Jun 2025 09:31:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uPGrV-00085H-10;
	Wed, 11 Jun 2025 09:31:09 +0100
Date: Wed, 11 Jun 2025 09:31:09 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chris Morgan <macroalpha82@gmail.com>,
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH V2] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
Message-ID: <aEk-zY0gfGx-PPa6@shell.armlinux.org.uk>
References: <20250606022203.479864-1-macroalpha82@gmail.com>
 <ab987609-0cc7-4051-bc51-234e254cbec0@lunn.ch>
 <SN6PR1901MB46541BA6488F73EB49EBCDDFA56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
 <eb99e702-5766-4af6-b527-660988ad9b54@lunn.ch>
 <SN6PR1901MB465464D2B7D905F6CD076F3FA56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
 <aENb4YX4mkAUgfi2@shell.armlinux.org.uk>
 <SN6PR1901MB46545250D870E79670E43E06A56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
 <aENv5BI2Amtqui4v@shell.armlinux.org.uk>
 <SN6PR1901MB4654B995FBAFAC7298C7C6A3A575A@SN6PR1901MB4654.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR1901MB4654B995FBAFAC7298C7C6A3A575A@SN6PR1901MB4654.namprd19.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jun 10, 2025 at 10:43:31PM -0500, Chris Morgan wrote:
> On Fri, Jun 06, 2025 at 11:47:00PM +0100, Russell King (Oracle) wrote:
> > On Fri, Jun 06, 2025 at 05:32:43PM -0500, Chris Morgan wrote:
> > > On Fri, Jun 06, 2025 at 10:21:37PM +0100, Russell King (Oracle) wrote:
> > > > On Fri, Jun 06, 2025 at 01:54:27PM -0500, Chris Morgan wrote:
> > > > > 	Option values					: 0x00 0x00
> > > > 
> > > > This suggests that LOS is not supported, nor any of the other hardware
> > > > signals. However, because early revisions of the SFP MSA didn't have
> > > > an option byte, and thus was zero, but did have the hardware signals,
> > > > we can't simply take this to mean the signals aren't implemented,
> > > > except for RX_LOS.
> > > > 
> > > > > I'll send the bin dump in another message (privately). Since the OUI
> > > > > is 00:00:00 and the serial number appears to be a datestamp, I'm not
> > > > > seeing anything on here that's sensitive.
> > > > 
> > > > I have augmented tools which can parse the binary dump, so I get a
> > > > bit more decode:
> > > > 
> > > >         Enhanced Options                          : soft TX_DISABLE
> > > >         Enhanced Options                          : soft TX_FAULT
> > > >         Enhanced Options                          : soft RX_LOS
> > > > 
> > > > So, this tells sfp.c that the status bits in the diagnostics address
> > > > offset 110 (SFP_STATUS) are supported.
> > > > 
> > > > Digging into your binary dump, SFP_STATUS has the value 0x02, which
> > > > indicates RX_LOS is set (signal lost), but TX_FAULT is clear (no
> > > > transmit fault.)
> > > > 
> > > > I'm guessing the SFP didn't have link at the time you took this
> > > > dump given that SFP_STATUS indicates RX_LOS was set?
> > > > 
> > > 
> > > That is correct.
> > 
> > Are you able to confirm that SFP_STATUS RX_LOS clears when the
> > module has link?
> 
> I believe this is the case. I've sent you a dump of my EEPROM when the
> SFP+ is active (it's now powering my internet connection at home) in a
> private message to confirm.

Yes, I can confirm this. The RX_LOS bit on SFP_STATUS appears to work
correctly, so all we need to do is ignore the hardware signal(s).

> > I'd prefer to have an additional couple of functions:
> > 
> > sfp_fixup_ignore_hw_tx_fault()
> > sfp_fixup_ignore_hw_los()
> > 
> > or possibly:
> > 
> > sfp_fixup_ignore_hw(struct sfp *sfp, unsigned int mask)
> > 
> 
> Which of these would you prefer? Do you want a function for each
> scenario or just a generic sfp_fixup_ignore_hw_fault_signal()? I can 
> create functions for each and then apply them to my device (and
> probably update the sfp_fixup_halny_gsfp() too since it's identical to
> what I'm trying to do plus the delay bits).

I think the latter as it's more flexible and less code.

Yes, please update sfp_fixup_halny_gsfp() as well.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

