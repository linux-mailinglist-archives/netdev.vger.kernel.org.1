Return-Path: <netdev+bounces-179435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8979A7C9FE
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 17:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD9D7A653D
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 15:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978053C463;
	Sat,  5 Apr 2025 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ePaLDCq1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2EC8BE8
	for <netdev@vger.kernel.org>; Sat,  5 Apr 2025 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743867844; cv=none; b=HP/ucyr+siuhN5MRtSQqWGVnFucFkPoJjXrdxC6gHa5emr9YtAEO7LcHWxK93RW2oKiqOP2+JtqOlh5ZtKRMIZ1IWmoqgiOPEFhmeR9g0DvkyuXjb3NUf/b4eEp9myC9XmrEadynO/zUM1Ol4W7L86SgH7PA/QaNc3yKC8xAZNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743867844; c=relaxed/simple;
	bh=S3wPxbL7DKzQPoCWL/brqsDZKAJPCx6LyVL12pH7Ea0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIjGGNCOBuPUs95SEQV7b3q/YY0BA9Js5WTTaj9aM/Oib+hFURo+650T7ugPWCjOTdNa63ln4pjfXf8p1UcxKvwMNT+iJILIh0Uuzj5EBQZYRinJyCYJg1mOPZvG0tirOMMNHks9KTNgfxeTKVe1p6WMlbkU6McTpsW7f+rbyV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ePaLDCq1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hBaWLT+l1XxN+RCessXT8j3Y4GprOYXNqNKolZHNA3E=; b=ePaLDCq1Js7YoeZjmoks54Ku85
	V9SRGoQYyimXfnAB+JRdeqRMkm776ImsMR/zGb/hxGm0t2SIpGe0rXXfFQfqIhJ8U4BiXeFcuhlmz
	MM8670B2mJhk+zlaYFawumjeiVhRxZfWeHDyn73fGcedCig/UjCtYpbU75bOHNwuANnU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u15ga-0087VX-S1; Sat, 05 Apr 2025 17:43:56 +0200
Date: Sat, 5 Apr 2025 17:43:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
Message-ID: <70b17728-cdd9-48ba-8cc5-f741bce445a5@lunn.ch>
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
 <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk>
 <20250403172953.5da50762@fedora.home>
 <de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch>
 <CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
 <Z-8XZiNHDoEawqww@shell.armlinux.org.uk>
 <CAKgT0UepS3X-+yiXcMhAC-F87Zcd74W2-2RDzLEBZpL3ceGNUw@mail.gmail.com>
 <Z_DzhKiMkjFVNMMY@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_DzhKiMkjFVNMMY@shell.armlinux.org.uk>

> This is what happened with 2500BASE-X. Vendors went off and did their
> own thing to create that higher speed interface. Many just up-clocked
> their 1000BASE-X implementation to provide the faster data rate.
> 
> > That is what we do have. Our hardware supports a 50GMII with
> > open loop rate matching to 25G, and CGMII, but they refer to the
> > 50GMII as XLGMII throughout the documentation which led to my initial
> > confusion when I implemented the limited support we have upstream now.
> > On the PMA end of things like I mentioned we support NRZ (25.78125) or
> > PAM4 (26.5625*2) and 1 or 2 lanes.
> 
> Great. This reminds me of the confusion caused by vendors overloading
> the "SGMII" term, which means we're now endlessly trying to
> disambiguate between SGMII being used for "we have a single lane
> serial gigabit media independent interface" and "we have an interface
> that supports the Cisco SGMII modifications of the IEEE 802.3
> 1000BASE-X specification."
> 
> I don't think vendors just don't have any clue of the impacts of their
> stupid naming abuse. It causes *major* problems, so to hear that it
> continues with other interface modes (a) is not surprising, (b) is
> very disappointing.

Hi Alex

This should be a major takeaway from this email. Please try to
strictly use 802.3 terms and meanings.  You can make references to
clauses in 802.3, it is an open document which we all should have some
version of.

And clearly call out where the hardware does not follow 802.3. Given
that you are going to be pushing phylink forward, we should have a
good idea what is 802.3, and what is a vendor extension/bug
workaround.

	Andrew

