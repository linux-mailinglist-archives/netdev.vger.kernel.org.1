Return-Path: <netdev+bounces-132063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C5E9904AC
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B681C20FB2
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5A02101AA;
	Fri,  4 Oct 2024 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pvQQkBaL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A2F210199;
	Fri,  4 Oct 2024 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049357; cv=none; b=Fxp2J5d2X3ScRpYr9rWVSIyiPFkNd1/xtKAcSc0cuh12t0qJgO3/CsyuL/vHlKnxkX7LpXFoZqleTakiXx1+/D5zfM6mBSC/q8ol3+RrBE/SBhGGCIOpVtrLi8K7gz/pmH3f1j8aleO7ipZ96lTtcPzAHrre8KAOd9pas6bfn0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049357; c=relaxed/simple;
	bh=ccBU33sHPnb4JeeVDSYQAYn63MPtYlDxAbGq1Jf0w0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWPrjU5zJevO18B64REwOBfNtYPbANwwqjXZ/Nv3003Sw2UHb9q0yoqX0xP0lxPArmED7yDcF1s9BdHsSloahvfXPLHVlOpW+h1SSKO54kYk4Nj+67YCXwGxcIcPWl111yUnrHP/bScQkqwKz/hzx4ndQ7Jc1WiydALm9M2G8q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pvQQkBaL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h4ZU7oedXEjsJ9UJ2oFvfz5XShfONeTd6y1jhVMzQis=; b=pvQQkBaLUGIT/ongx6MBFtMwRM
	N7LuSA9V3oqaC1IRj3imazjro51DFe1b5pKj0f4jbB0X5lk90qiwhE7/ZjzomTQ4mDHY+WfS4FhZy
	d/qxelTLUbXCXYMULJDKUrFi/T5D8dPHk7q4HlgDezyoFTKbGH1rru1QFnJBFO8ZipO5qN3IntZtb
	F1lruX2yxiH9jcUHUlADtABL0cMIMdBYZBTIdjH/LWh94aNr/BWC0w+CiKIzgg1UUxnKW4sWB4hqS
	J8yCgYsjA1pkPpWdL3V6ktgR+pDUUrZ1FHJlddTQyc8GBpd7eNjanaJtjJ23DjaVkVsCJesY2q2iN
	varE6Dog==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33976)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1swiZe-00021X-2r;
	Fri, 04 Oct 2024 14:42:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1swiZb-0001E9-2v;
	Fri, 04 Oct 2024 14:42:23 +0100
Date: Fri, 4 Oct 2024 14:42:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Qingtao Cao <qingtao.cao.au@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net: phy: marvell: avoid bringing down fibre link
 when autoneg is bypassed
Message-ID: <Zv_wv67TGIUz5IZy@shell.armlinux.org.uk>
References: <20241003022512.370600-1-qingtao.cao@digi.com>
 <30f9c0d0-499c-47d6-bdf2-a86b6d300dbf@lunn.ch>
 <CAPcThSHa82QDT6sSrqcGMf7Zx4J15P7KpgfnD-LjJQi0DFh7FA@mail.gmail.com>
 <927d5266-503c-499f-877c-5350108334dc@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <927d5266-503c-499f-877c-5350108334dc@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 04, 2024 at 03:26:33PM +0200, Andrew Lunn wrote:
> On Fri, Oct 04, 2024 at 11:35:30AM +1000, Qingtao Cao wrote:
> > Hi Andrew,
> > 
> > Please see my inline replies.
> > 
> > On Fri, Oct 4, 2024 at 12:30 AM Andrew Lunn <andrew@lunn.ch> wrote:
> > 
> >     On Thu, Oct 03, 2024 at 12:25:12PM +1000, Qingtao Cao wrote:
> >     > On 88E151x the SGMII autoneg bypass mode defaults to be enabled. When it
> >     is
> >     > activated, the device assumes a link-up status with existing
> >     configuration
> >     > in BMCR, avoid bringing down the fibre link in this case
> >     >
> >     > Test case:
> >     > 1. Two 88E151x connected with SFP, both enable autoneg, link is up with
> >     speed
> >     >    1000M
> >     > 2. Disable autoneg on one device and explicitly set its speed to 1000M
> >     > 3. The fibre link can still up with this change, otherwise not.
> > 
> >     What is actually wrong here?
> > 
> >     If both ends are performing auto-neg, i would expect a link at the
> >     highest speeds both link peers support.
> > 
> >     If one peer is doing autoneg, the other not, i expect link down, this
> >     is not a valid configuration, since one peer is going to fail to
> >     auto-neg.
> > 
> > 
> > Well, technically speaking, thanks to the 88E151X's bypass mode, in such case
> > with one end using autoneg but the other is using 1000M explicitly, the link
> > could still be up, but not with the current code.
> 
> So we can make an invalid configuration work. Question is, should we?
> 
> Are we teaching users they can wrongly configure their system and
> expect it to work? They then think it is actually a valid
> configuration and try the same on some other board with other PHYs,
> and find it does not work?
> 
> Does Marvell document why this bypass mode exists? When it should be
> used? What do they see as its use cases?

The paragraph about it is couched in terms of "if the MAC or the PHY
implements the auto-negotiation function and the other end does not".

That seems to point towards a MAC <-> PHY link rather than across a
media. So I tend to agree with you that we should not be enabling
bypass mode on a media side link.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

