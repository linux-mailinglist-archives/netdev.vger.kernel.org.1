Return-Path: <netdev+bounces-164516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBB0A2E176
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 00:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942FE164724
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 23:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E960187FE4;
	Sun,  9 Feb 2025 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="weeF/Af7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9371042AA1;
	Sun,  9 Feb 2025 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739143862; cv=none; b=mQY3a0G2ylPWr4PiMKKkfufCPJrxayOj6eHx1DGCgwX2xJMTdkbU1HoNuLCP6sdmDC6QMR8LDiA1kA92EWn2dlki+6cubehvdVcplgQfr7RlbXO+lBGDgtG8efs8mGHHKcQSFvgqn4l/3xUk3qBMc3dpR8fPhNno/1/nnd+dr8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739143862; c=relaxed/simple;
	bh=+5Cqo7lnNc2rLd7ecg2GnbUUnFQ2QdIIBXa2V/FUrCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHv5zGwh+bycs+i/74J9kN/Hqs6/YXZ0aO3xucpJmpXFCoiCGcGV1CCrj7lLx9RZUvE55bkwqM+BRv4n6lsRkfM3TvvDrkAYLSWQ/YXnplYR1d4Ej2QOPrPo7oKe/FkAAqtNBVQhvmPw4I0SuBerDBUzvwewCenlnzR+z/iRMMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=weeF/Af7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=7Dmvcyx1wY91qXhfuUhWU5jxIFJMcS+m0tbz0LZ4xC8=; b=we
	eF/Af7V3BXX8DXf+L5uMv9PMYseia16NdDbNIGpupr11bKIfDhaybqeGLDc21NwDEGEl2pqXhpW1r
	lTrbzBsRZtnRCH9mzBGh/tgYmbjisejYovP25Qol4V1PIYA7qqxy+KDLywH/eJc4vO3tPKY+nNWGW
	O1nVq2HDOQ4HT5Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1thGl2-00CXRj-CO; Mon, 10 Feb 2025 00:30:36 +0100
Date: Mon, 10 Feb 2025 00:30:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] net: dsa: b53: Enable internal GPHY on BCM63268
Message-ID: <aa8fefa0-c5ba-4bb0-9e45-6b0ac4cfbacc@lunn.ch>
References: <20250206043055.177004-1-kylehendrydev@gmail.com>
 <1317d50b-8302-4936-b56c-7a9f5b3970b9@broadcom.com>
 <9bd9c1e4-2401-46bd-937f-996e97d750c5@lunn.ch>
 <a804e0a4-2275-41c3-be3b-7dd79c2418cd@gmail.com>
 <318e8b95-4ef8-43ca-a19d-129372a9dc48@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <318e8b95-4ef8-43ca-a19d-129372a9dc48@gmail.com>

On Fri, Feb 07, 2025 at 08:44:31AM -0800, Florian Fainelli wrote:
> On 2/6/25 17:41, Kyle Hendry wrote:
> > 
> > On 2025-02-06 12:17, Andrew Lunn wrote:
> > > On Thu, Feb 06, 2025 at 10:15:50AM -0800, Florian Fainelli wrote:
> > > > Hi Kyle,
> > > > 
> > > > On 2/5/25 20:30, Kyle Hendry wrote:
> > > > > Some BCM63268 bootloaders do not enable the internal PHYs by default.
> > > > > This patch series adds functionality for the switch driver to
> > > > > configure the gigabit ethernet PHY.
> > > > > 
> > > > > Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
> > > > So the register address you are manipulating logically belongs
> > > > in the GPIO
> > > > block (GPIO_GPHY_CTRL) which has become quite a bit of a sundry here. I
> > > > don't have a strong objection about the approach picked up here
> > > > but we will
> > > > need a Device Tree binding update describing the second (and optional)
> > > > register range.
> > > Despite this being internal, is this actually a GPIO? Should it be
> > > modelled as a GPIO line connected to a reset input on the PHY? It
> > > would then nicely fit in the existing phylib handling of a PHY with a
> > > GPIO reset line?
> > > 
> > >     Andrew
> > The main reason I took this approach is because a SF2 register has
> > similar bits and I wanted to be consistent with that driver. If it
> > makes more sense to treat these bits as GPIOs/clocks/resets then it
> > would make the implementation simpler.
> 
> I don't think there is a need to go that far, and I don't think any of those
> abstractions work really well in the sense that they are neither clocks, nor
> resets, nor GPIOs, they are just enable bits for the power gating logic of
> the PHY, power domains would be the closest to what this is, but this is a
> very heavy handed approach with little benefit IMHO.

O.K. The naming is not particularly helpful. It is in the GPIO block,
and named GPIO_GPHY_CTRL so it kind of sounds like a GPIO. If the
existing GPIO driver could expose it as a GPIO it would of been a lot
simpler.

If the SF2 has similar bits, could the SF2 code be shared?

	Andrew

