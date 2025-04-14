Return-Path: <netdev+bounces-182152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C95CAA88088
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A338C7AAD88
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41E32BD5AA;
	Mon, 14 Apr 2025 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Pk0/Nz1m"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B829C333
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634259; cv=none; b=rMZxPLXvba49gHTILLsYoVPtBOApSroAmwglhJ1tCsiT5hMPZOggheDVQwPUxmj6Cjjx0aAuLv/HMPeFqB6pjRHB9R+D0wkDOZet+D3Zkq3mmhCRJRGuY0htjri9vjRDHAzs1sIzvlIWyC7piSJle6v6/9/rZz9MMUDOmxrlgW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634259; c=relaxed/simple;
	bh=fKQzCD1WeXQnWJ/QJcMsD23rOZvCGA94avHU5k7QzOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFvq01qBjb+iI0WlAZmJWUYh9SyV1yxYHxsHNhv8frozuNvFtwRSofyj2Hzk9IlQKQj49vCgSBtrSSs8d8Y+eE4R0HHwNJ18tzKFv7z0iijxZoVdMLKMuWDIYcV7CYbyCOqarBSTPHVbgYGnH+0nEl3TugM+KObynbyS1eS8214=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Pk0/Nz1m; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0j45Q5T+VOH4Mu0SR5OMKMtCcSms917hVgEtw0lqWyc=; b=Pk0/Nz1mFB7+By5wqhNjm6c7z9
	qnX4qBXTMcttTPTZyhOl/xc6AwaS0ZHNhODSDvFxbI5KzUDyr3AVokfiZzRa1BYlbrDOCxofAaJXX
	QOmzAM/zuD8D41+9N5smChzBIOuDawhu7+icH835lzf0fJH6bM94ZF/RmR5h/fCEddh9ZK6hqnGja
	E2tKpgG56kMiL70+m26p5XiuFiUs/DRGw+u72+hFfv7tNz4AKuZNr/vvckyV2xIRHDzQS0nG1WfON
	WicJQ7YOiLMdRQ6Cewc1Z9RLrEw4eL8In+Xp/2i69HJEjzN6aijXaiziL2RPt20NEDtcPhY8dcKD/
	oT9AT+qg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55276)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u4J46-0006Xf-20;
	Mon, 14 Apr 2025 13:37:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u4J43-0007kb-2y;
	Mon, 14 Apr 2025 13:37:27 +0100
Date: Mon, 14 Apr 2025 13:37:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH RFC net-next 3/5] net: phy: add Marvell PHY PTP support
Message-ID: <Z_0Bh9T86I3y--p_@shell.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
 <E1u3Lta-000CP7-7r@rmk-PC.armlinux.org.uk>
 <20250414143306.036c1e2e@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250414143306.036c1e2e@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 14, 2025 at 02:33:06PM +0200, Kory Maincent wrote:
> On Fri, 11 Apr 2025 22:26:42 +0100
> Russell King <rmk+kernel@armlinux.org.uk> wrote:
> 
> > Add PTP basic support for Marvell 88E151x single port PHYs.  These
> > PHYs support timestamping the egress and ingress of packets, but does
> > not support any packet modification, nor do we support any filtering
> > beyond selecting packets that the hardware recognises as PTP/802.1AS.
> > 
> > The PHYs support hardware pins for providing an external clock for the
> > TAI counter, and a separate pin that can be used for event capture or
> > generation of a trigger (either a pulse or periodic). Only event
> > capture is supported.
> > 
> > We currently use a delayed work to poll for the timestamps which is
> > far from ideal, but we also provide a function that can be called from
> > an interrupt handler - which would be good to tie into the main Marvell
> > PHY driver.
> > 
> > The driver takes inspiration from the Marvell 88E6xxx DSA and DP83640
> > drivers. The hardware is very similar to the implementation found in
> > the 88E6xxx DSA driver, but the access methods are very different,
> > although it may be possible to create a library that both can use
> > along with accessor functions.
> 
> I wanted to test it, but this patch does not build.
> 
> drivers/net/phy/marvell_ptp.c:269:33: error: passing argument 4 of ‘marvell_tai_probe’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>   269 |                                 "Marvell PHY", dev);
>       |                                 ^~~~~~~~~~~~~
>       |                                 |
>       |                                 char *
> In file included from drivers/net/phy/marvell_ptp.c:9:
> ./include/linux/marvell_ptp.h:81:44: note: expected ‘struct ptp_pin_desc *’ but argument is of type ‘char *’
>    81 |                       struct ptp_pin_desc *pin_config, int n_pins,
>       |                       ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
> drivers/net/phy/marvell_ptp.c:269:48: warning: passing argument 5 of ‘marvell_tai_probe’ makes integer from pointer without a cast [-Wint-conversion]
>   269 |                                 "Marvell PHY", dev);
>       |                                                ^~~
>       |                                                |
>       |                                                struct device *
> In file included from drivers/net/phy/marvell_ptp.c:9:
> ./include/linux/marvell_ptp.h:81:60: note: expected ‘int’ but argument is of type ‘struct device *’
>    81 |                       struct ptp_pin_desc *pin_config, int n_pins,
>       |                                                        ~~~~^~~~~~
> drivers/net/phy/marvell_ptp.c:267:15: error: too few arguments to function ‘marvell_tai_probe’
>   267 |         err = marvell_tai_probe(&tai, &marvell_phy_ptp_ops,
>       |               ^~~~~~~~~~~~~~~~~
> In file included from drivers/net/phy/marvell_ptp.c:9:
> ./include/linux/marvell_ptp.h:78:5: note: declared here
>    78 | int marvell_tai_probe(struct marvell_tai **taip,
>       |     ^~~~~~~~~~~~~~~~~
> 

Add NULL, 0 before the name.

Sorry, but I have way too many patches to deal with.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

