Return-Path: <netdev+bounces-183410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6990A909AD
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2003A712A
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5663120DD4D;
	Wed, 16 Apr 2025 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="m2CQSBML"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1B92153EF
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823535; cv=none; b=kfq0tNNyNlk/bJqUlukxf6hg/c89YskKzsX0kqBkXWzaNmju+kKPvn3hbrN4byhMokxacVCDBRoM7wJLTqGXKQUftP7lAtpQ4oWYwbZAUaz5Xgdq57BpdctMzBuD6kfb8LpiPmy3yQI5cv3+Ryzx+HQm2URZkn79XWoxUIUslIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823535; c=relaxed/simple;
	bh=LnQyD9HTayIJOgilaa+LKDHInj0rkIYpNtOigaPMGl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M18FEA6c4zmHvgEUqSxgy8+GMIMRxi0L38/MiHe7hKae9uLtxHovefByr1J42a5xhKjfYGqzT+UJZ3UcLvLi9VwmCFpESvoANDK4tuoJ5PPknVNt7WzeZh8fotBR6PWrrw4k3p/SlkF+HPYGyhIMrDSgMe98Mo4BGSjjuyRD9QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=m2CQSBML; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=foWBq1/OXyHVLIvge7zfATW17FUJ1mGcnzhenOmL5Sc=; b=m2CQSBMLU4UUtBFBo913PapkDI
	l273CoyRB610NZppmeQnZIjtqpzoLdxtVkzB/32oCSOd8Vy3UnB8wgXamaZNoy1PjL2xrHOWnrtrr
	aa8WhOns9LYetRdMz4PpZDRxzocbqlJAOOb3nZFgT56zlO5X0fAVb0F522kiAZ/HJZynt0LOIVIJM
	FYXlxg3XzFgrO3gl5js3yEdSFufzFCmHMktWJMdAYvjORPGeQ97OjG67vM53tJkOH/Rft8cN4MTP1
	0rfUVfQs5LEiy3AmbHGN5J7LinJ9gn6mYX0Yib6CJwFQPsxrMFcDZtNgj6Q4yhMjv6W23SAo6+ctY
	nNE5vKvQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50646)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u56It-0001hu-0i;
	Wed, 16 Apr 2025 18:12:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u56Iq-0001ZY-2L;
	Wed, 16 Apr 2025 18:12:00 +0100
Date: Wed, 16 Apr 2025 18:12:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [net-next PATCH 2/2] net: phylink: Fix issues with link
 balancing w/ BMC present
Message-ID: <Z//k4PUTWXo3+IBh@shell.armlinux.org.uk>
References: <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
 <174481734008.986682.1350602067856870465.stgit@ahduyck-xeon-server.home.arpa>
 <Z__URcfITnra19xy@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z__URcfITnra19xy@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 16, 2025 at 05:01:09PM +0100, Russell King (Oracle) wrote:
> On Wed, Apr 16, 2025 at 08:29:00AM -0700, Alexander Duyck wrote:
> > From: Alexander Duyck <alexanderduyck@fb.com>
> > 
> > This change is meant to address the fact that there are link imbalances
> > introduced when using phylink on a system with a BMC. Specifically there
> > are two issues.
> > 
> > The first issue is that if we lose link after the first call to
> > phylink_start but before it gets to the phylink_resolve we will end up with
> > the phylink interface assuming the link was always down and not calling
> > phylink_link_down resulting in a stuck interface.
> 
> That is intentional.
> 
> phylink strictly orders .mac_link_down and .mac_link_up, and starts from
> an initial position that the link _will_ be considered to be down. So,
> it is intentional that .mac_link_down will _never_ be called after
> phylink_start().
> 
> > The second issue is that when a BMC is present we are currently forcing the
> > link down. This results in us bouncing the link for a fraction of a second
> > and that will result in dropped packets for the BMC.
> 
> ... but you don't explain how that happens.
> 
> > The third issue is just an extra "Link Down" message that is seen when
> > calling phylink_resume. This is addressed by identifying that the link
> > isn't balanced and just not displaying the down message in such a case.
> 
> Hmm, this one is an error, but is not as simple as "don't print the
> message" as it results in a violation of the rule I mentioned above.
> We need phylink_suspend() to record the state of the link at that
> point, and avoid calling phylink_link_down() if the link was down
> prior to suspend.

Okay, confirmed on nvidia Jetson Xavier NX:

[   11.838132] dwc-eth-dwmac 2490000.ethernet eth0: Adding VLAN ID 0 is not supported
[   15.299757] dwc-eth-dwmac 2490000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx

LAN cable was unplugged:
[   50.436587] dwc-eth-dwmac 2490000.ethernet eth0: Link is Down

Then the system was suspended using rtcwake for 3 seconds:

[   54.736849] dwc-eth-dwmac 2490000.ethernet eth0: No Safety Features support found
[   54.736898] dwc-eth-dwmac 2490000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
[   54.741078] dwc-eth-dwmac 2490000.ethernet eth0: Link is Down

This shouldn't happen. With the patch I posted, this second "Link is Down"
message is not printed, and .mac_link_down() will not be called.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

