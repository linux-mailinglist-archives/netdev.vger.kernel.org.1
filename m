Return-Path: <netdev+bounces-167392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC77A3A1F5
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4AB2189580D
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E6D190068;
	Tue, 18 Feb 2025 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wRuFLFmj"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D56018C03F;
	Tue, 18 Feb 2025 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894459; cv=none; b=t3iCjaQOYGyybwR0ZSE8hnlCD9P3wWXAxpI8uwGLd150E2zGgRIpfz+qOI1GVJGE5pONUGlxTN3IuTucFzOrIYTKrAlCpJij9lxWywD3fTWlQQo2K5QnpnC0afa5hFVdTGpP7aAArM3OtvbylsFAxDCBRodRtliWoFbCcVWfM1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894459; c=relaxed/simple;
	bh=ouVMX0/PwKrasiXoomH+htFkCDXb3oahfZ8JAjFWEZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqOw6bq0p5hrxETkdgIk4qchnba9AAVCNu4UgfGpHaanx1L4Fbawfzpnz+gnvqEEnruS29c+tFulLuVcKCyMO2WFT996QifgOtK0hj/M/CaYbsnggYxuiI0tVTKaRfEne1HwLk1oHMhDTzn9H0h2SggzISy/WMbz7EYG+1PsyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wRuFLFmj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GQHJM38ipOuGWXD47ZECWD/3qc1mSsYf7y1d1Bo7Dls=; b=wRuFLFmj87ibhuj7nGhI2kqIUF
	kxFUlxO/ngJ73wCPloaoFrnoCAZD3FnSY1trn+TeJQ0GhvejPskN7ajPbW/X63fRm4pZ5+SHgXG+w
	WRowwSecYGJNafGt49RYMR4jPzGR1fJSYrxj70ND9dagX3GdN2g4VuI4aEWe6EI9C5E3dE2BZurFc
	oz2IYwMx8s/Pg/JsNAOSPMuhFPN02cMnFGusP9hM8xVcLiIU4Ln2mVKLbBIjxvJbnI2nAgP7+4SEY
	LWOlMbTsqgQGkvYQ0t78VYzYSyfe3JtkMRNWtn2BLXv5Q/t0H6K3ixR5FM1HgD6BHMGUGBYNpqve7
	oxErya3Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35168)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tkQ1e-0002Y5-1K;
	Tue, 18 Feb 2025 16:00:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tkQ1a-0007Nc-1t;
	Tue, 18 Feb 2025 16:00:42 +0000
Date: Tue, 18 Feb 2025 16:00:42 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: phy: marvell-88q2xxx: align defines
Message-ID: <Z7SuqnfPJD-qQG-c@shell.armlinux.org.uk>
References: <20250214-marvell-88q2xxx-cleanup-v1-0-71d67c20f308@gmail.com>
 <20250214-marvell-88q2xxx-cleanup-v1-1-71d67c20f308@gmail.com>
 <rfcr7sva7vs5vzfncbtrxcaa7ddosnabxu5xhuqsdspbdxwfrg@scl4wgu3m32n>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rfcr7sva7vs5vzfncbtrxcaa7ddosnabxu5xhuqsdspbdxwfrg@scl4wgu3m32n>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 18, 2025 at 12:54:29PM +0100, Marek Behún wrote:
> > +#define MDIO_MMD_AN_MV_STAT				32769
> 
> Why the hell are register addresses in this driver in decimal?

Shocker - some documentation gives driver addresses for PHYs in
decimal.

It then becomes a pain to have to manually translate back and
forth between hex and decimal if one is reading the driver code and
referring back to the documentation.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

