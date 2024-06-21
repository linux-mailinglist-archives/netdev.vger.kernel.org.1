Return-Path: <netdev+bounces-105708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAA491254F
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2BF1F21C00
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2CC14F135;
	Fri, 21 Jun 2024 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FOChEhXl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555E219F9;
	Fri, 21 Jun 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973055; cv=none; b=oSj1yDzacpFQakqQPEDbjrLraJqU2sLtS7A0GCY2KAydPZNJ7ROwxK3wCoj6gbry0buGqaD0On/HqjMi705r3H2CRN+TL0SGZvhRuEZNU4gBEM33uGBwASdZeZr2BJ7oDRzPfrT+cPjGx9gju3WKlUgdD0JCTg6vPBi3c265sE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973055; c=relaxed/simple;
	bh=MDf/S7p9nxc7jxIb4VHeMj74saNKIvIpDEbm4gVOuPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsgG5MxOwdM0BeLQIuGbS8QbHO/YIroTrhj08K8rGdKxPjyj4f+M91jWnpaUa60hbVSZnmRbECp5p42OkhJH2nJsu1FZEpQqBnPAWs+uIQI8zZ4/GMuh1OocJBWyD8RhFkahT+HpF5ofpWTRw1QVGMAqqDpvUkL6fGthFvKQXAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FOChEhXl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2qIXFrmiML0W+NIuVWwtNy9ypBaWgCdJ6JhYw4WxT+c=; b=FOChEhXl/kUHw8ezMzLSyhvkAq
	00m2SlvQC3yodPkRjKTawrWAEJVxet5KG81Du9E4Ih553hkJlXUn0b7xTbJTxapZtro8roqsj/rvJ
	qjvdboYA8veyR2G21DGJ2l/omqXcgBubbVkTzutB24E72VKV7tuZXt7kTAcSrRy2njCzTFOk+u+Z6
	paam7ODO5+Bac4vCjYf0c6fN38MxstxK4wmYWq02EXaeRHf+B0EHCocW2dgD9TD0MrISrlnl9MOdl
	Of7Emrocfnwk1ZWbXyEf2ykJVRqcet+tIXDh/mSNqr/6l7a64tn59vFhGqAdISh2V2hGZOp84WVGD
	icz/H05g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47448)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sKdPb-0003us-0J;
	Fri, 21 Jun 2024 13:30:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sKdPd-00007R-JP; Fri, 21 Jun 2024 13:30:41 +0100
Date: Fri, 21 Jun 2024 13:30:41 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	trivial@kernel.org, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v2 resub 1/2] net: include: mii: Refactor: Define LPA_*
 in terms of ADVERTISE_*
Message-ID: <ZnVycQASAhN2Shfu@shell.armlinux.org.uk>
References: <20240619124622.2798613-1-csokas.bence@prolan.hu>
 <c82256a5-6385-4205-ba74-ab102396abb6@lunn.ch>
 <f216c0b9-3d0d-4d4c-aa33-ba02b0722052@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f216c0b9-3d0d-4d4c-aa33-ba02b0722052@prolan.hu>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jun 21, 2024 at 09:48:23AM +0200, Csókás Bence wrote:
> Hi
> 
> On 6/20/24 21:07, Andrew Lunn wrote:
> > On Wed, Jun 19, 2024 at 02:46:22PM +0200, Csókás, Bence wrote:
> > > Ethernet specification mandates that these bits will be equal.
> > > To reduce the amount of magix hex'es in the code, just define
> > > them in terms of each other.
> > 
> > I have a quick email exchange with other PHY maintainers, and we
> > agree. We will reject these changes, they are just churn and bring no
> > real benefit.
> > 
> > NACK
> > 
> >      Andrew
> > 
> 
> The benefit is that I don't have to constantly convert between "n-th bit
> set" (which is how virtually all datasheets, specifications, documentation
> etc. represent MII bits) and these hex values. In most places in the kernel,
> register bits are already represented with BIT() et al., so why not here?

These are user API files, you can't use BIT() here (BIT() isn't defined
for userspace header files.) Next, these are 'int's not 'longs' so
using BIT() or _BITUL() could cause warnings - plus it changes the
type of these definitions not only for kernel space but also user space.
Thus, it's an API change.

So no, we're not making changes to make this "more readable" at the
expense of breaking the kernel's UAPI.

Just get used to working with hex numbers like most of us had to do
before BIT() was added to the kernel... it's not difficult, each hex
digit is after all four binary bits. It's not like it's decimal.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

