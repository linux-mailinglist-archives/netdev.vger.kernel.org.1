Return-Path: <netdev+bounces-184766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61073A971D2
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5055E189FB6F
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D664318D63A;
	Tue, 22 Apr 2025 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WZ/9W/Vw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B602D179BD
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337622; cv=none; b=DUlbLC9oiEnWvGUDNcpPQwVx8jJmLTW0y+5sMG7WOKd+1fyR2N+a5TucGY+5XeiNlbqPgLaW6OcNcgPXyyFd+lJzNuGDrpRy5qMYR+02hOTK8Ae0ft/LWO+kZ37y4LhUsV48SeCNMQIlDMt2i6BuNyIR5AUyvRzEzsVj1i6RNqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337622; c=relaxed/simple;
	bh=cihEAzrhQy74cbYbiQXNP4K5ybnIOndoAzao8J/JF+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVQSnx19a5LjPyqe6yWXs80MjY3xjUp/t4E5bSFFG8he7aMacrCSdhEti+I/cbHR+o3ZlAM6OTVVCmlD0mPqlQ/EbvqzglN+9VhTkWTaWbLHrqlDG4mUQ2G8EMXSFKghLTsbfJIg2J26dKMf+I8Wi6ySX7MExrT+r3hl8nFKfmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WZ/9W/Vw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PZmCJqCHx8RPvrgcInv+cbQiftHXQ6sOW2pD0FbecrE=; b=WZ/9W/VwIklI3/NfX46Zne78Du
	bmdjoTVCOiXJRz5DTdc4cFYwPmqWODry8uByzTzPLiuk+HI3U8TqC/6ZrJGVAAOQF3zRCbogMRhcQ
	3f53jBywez8ovi3O/Fg7YIojioNARwXY8Va3Lx5Ew3T3eAdQW8L0MQwOiTzAAm3YJVaw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u7G2f-00AE3h-MJ; Tue, 22 Apr 2025 18:00:13 +0200
Date: Tue, 22 Apr 2025 18:00:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Joakim Zhang <qiangqing.zhang@nxp.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: phylink: fix suspend/resume with WoL enabled
 and link down
Message-ID: <156d5309-dc73-4ce0-9c26-48a3a28621dd@lunn.ch>
References: <Z__URcfITnra19xy@shell.armlinux.org.uk>
 <E1u55Qf-0016RN-PA@rmk-PC.armlinux.org.uk>
 <9910f0885c4ee48878569d3e286072228088137a.camel@gmail.com>
 <aAERy1qnTyTGT-_w@shell.armlinux.org.uk>
 <aAEc3HZbSZTiWB8s@shell.armlinux.org.uk>
 <CAKgT0Uf2a48D7O_OSFV8W7j3DJjn_patFbjRbvktazt9UTKoLQ@mail.gmail.com>
 <aAE59VOdtyOwv0Rv@shell.armlinux.org.uk>
 <CAKgT0Uc_O_5wMQOG66PS2Dc2Bn3WZ_vtw2tZV8He=EU9m5LsjQ@mail.gmail.com>
 <aAdmhIcBDDIskr3J@shell.armlinux.org.uk>
 <CAKgT0Uei=6GABwke2vv0D-dY=03uSnkVN4KnKuDR_DNfem2tWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Uei=6GABwke2vv0D-dY=03uSnkVN4KnKuDR_DNfem2tWg@mail.gmail.com>

> For us to fit we are going to have to expand things quite a bit as we
> need to add support for higher speeds, QSFP, QSFP-DD, FEC, BMC, and
> multi-host type behavior at a minimum. I had more-or-less assumed
> there was a desire to push the interface support up to 100G or more
> and that was one motivation for pushing us into phylink. By pushing us
> in it was a way to get there with us as the lead test/development
> vehicle since we are one of the first high speed NICs to actually
> expose most of the hardware and not hide it behind firmware.
> 
> That said,  I have come to see some of the advantages for us as well.
> Things like the QSFP support seems like it should be a light lift as I
> just have to add support for basic SFF-8636, which isn't too
> dissimilar to SFF-8472, and the rest seems to mostly fall in place
> with the device picking up the interface mode from the QSFP module as
> there isn't much needed for a DA cable.

You should also get hwmon for the SFP for free. ethtool
--dump-module-eeprom will need a little work in sfp.c, but less work
than a whole MAC driver implementation. With that in place firmware
upgrade of the SFP should be easy. And we have a good quirk
infrastructure in place for dealing with SFPs, which all seem broken
in some way. No need to reinvent that.

	Andrew

