Return-Path: <netdev+bounces-233694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C08C176F8
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96641A246C7
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F333064A2;
	Tue, 28 Oct 2025 23:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DtBgppHx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C022206BB
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 23:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695871; cv=none; b=nYo/1w9ba0Ve3Yq9mtpoRBnkyfhLb/HqwH8Dhhx8lxWV+ABmSGFR8X1HOShASpZOmBvlxk941tloQsaxt2b8wqrpAUKFJgqi1YscqkCxy2tVIAueozoi+Y3Ujq1svp1D1bCb/M/sE6lPfNX3LW4+x1nSXSHw0GpjZRsHOSFV8RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695871; c=relaxed/simple;
	bh=4kMhXIfA7aPxZm8cEf7NrodCPPDBCJKsDOsaoKin8Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPCTqbOKMQhViqjMHMaxGIbFtekX7n5CZvpYo5SbbQWvKAX5qmHu24h8jSUVCC5cYWOVDqo2kh/cf6rJElK7kdmbrAz7Ctl62R8jKehiUsmo4RqpeihvS+XKLsThAPKFBJwiIbbQWXz/BcswWm61n9n4dTBJqHhmBIygx3r2zW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DtBgppHx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+ScJmt+/0Os57nukiGynVFNomd71ekgTNx8UM6wvsiM=; b=DtBgppHxDmU/Kd/3Ruec8pBeu9
	6L3U554pxuSnq3NejqoXqHrRGkn4CGgFOyXlGnlK2d3m8IhamY8ccmOa/Weu3O3yKOFJHEUx+1Y/4
	LmIEwOegwyaAUS7t2ONwQ8gbkOo4Ol4aZP4uDJtf31ZGScnCN104FG6jGbZIRqX9wvCqtkXNQB0Dh
	t1SBNH/GoA5fPpPFsDtqTHqtyMZyEMZ/vZ39fryyZhzCP0a78gVpIMzPiDGBO+oMyndDGoWGg7V/d
	Om1WFXacBpBrjt0/M+XKNHB0TWaxBLR6z7exMpMC/BriAozJJzMvxfpNrI3fPxfRtYBLekG4RtUxP
	hqt671pg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56542)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vDtZP-000000003fK-1CVt;
	Tue, 28 Oct 2025 23:57:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vDtZN-000000006xv-1h3p;
	Tue, 28 Oct 2025 23:57:41 +0000
Date: Tue, 28 Oct 2025 23:57:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 0/8] net: stmmac: hwif.c cleanups
Message-ID: <aQFYdRZV9CQVuqFu@shell.armlinux.org.uk>
References: <aPt1l6ocBCg4YlyS@shell.armlinux.org.uk>
 <20251028164257.067bdbcd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028164257.067bdbcd@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 28, 2025 at 04:42:57PM -0700, Jakub Kicinski wrote:
> On Fri, 24 Oct 2025 13:48:23 +0100 Russell King (Oracle) wrote:
> > This series cleans up hwif.c:
> > 
> > - move the reading of the version information out of stmmac_hwif_init()
> >   into its own function, stmmac_get_version(), storing the result in a
> >   new struct.
> > 
> > - simplify stmmac_get_version().
> > 
> > - read the version register once, passing it to stmmac_get_id() and
> >   stmmac_get_dev_id().
> > 
> > - move stmmac_get_id() and stmmac_get_dev_id() into
> >   stmmac_get_version()
> > 
> > - define version register fields and use FIELD_GET() to decode
> > 
> > - start tackling the big loop in stmmac_hwif_init() - provide a
> >   function, stmmac_hwif_find(), which looks up the hwif entry, thus
> >   making a much smaller loop, which improves readability of this code.
> > 
> > - change the use of '^' to '!=' when comparing the dev_id, which is
> >   what is really meant here.
> > 
> > - reorganise the test after calling stmmac_hwif_init() so that we
> >   handle the error case in the indented code, and the success case
> >   with no indent, which is the classical arrangement.
> 
> This one needs a respin (patch 6 vs your IRQ masking changes?).

Ah, I see it, rebase can cope with that, but not application. Bah.
Another week of waiting for it to be applied. :(

I'm going to start sending larger patch series...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

