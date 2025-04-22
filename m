Return-Path: <netdev+bounces-184594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B483A96508
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B6D3A292B
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 09:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8752F1F12FC;
	Tue, 22 Apr 2025 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AcNF/BzP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73046F50F
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315472; cv=none; b=GbBcDcMbbLv5Jp5AamdCrHRSKONg2KzQowSk+8Q29wfUPxzSdlDSgkvibBsAgcwMzdQT37IyfGyK7f2ACBysisIog0PgI4DkccZl9kxFW8xTRlPa/rPifEqx/Adu1kWqPYm/JQ8IDXCgPwYQepLwg7QhIT8n7BA9PrJ5KhgJ1CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315472; c=relaxed/simple;
	bh=gmni3RIntqoKE+lOK1tbNMFqIipTn3oqXbLanFJL1xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpHIvDsHUD06wTsWgk31SBmoPQ41x7HoW/4LxtD9DH3OToUnlo93bO0Yz6Xc8Au0PYwRrhDcfuKG8etr/0uWioo8lPdtBkbXGin5im+f6zPSIX95oJJv5fqG6upByV3Q1Ze7SrS/vvAxpWWn6R9adLkH5of/oLWaS2zqwr3oBdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AcNF/BzP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5DmO8FoHqEdikoi6rgbBajhkJBA7ZVRXfgskXmlB27I=; b=AcNF/BzPufmQcPjhNp/VEb6aiq
	DzlboJH11N7wKgZGimEwF/9mceKi0dMoLNlM0MFFAjyXp46amKXcdWKCqxC0fTYKcARa/RzjSDlQc
	s1+2yATNZHB3S5Z5GMQnhgRCtyrhQQ3v4ZINrFpVH16ldQ/cH3SUGs9cHStWMNDweN8gqXQ9unZnY
	yXVInc5OgQJIIoZNC+o9WsORGfYXij6zqFnwtYR+UyvAQsMhOtKi6BTNVSIJhPt2xyEfpBD8d2SJk
	Di4oV5NNdhcrtt2mXAyEnwkyAPatN2NmILwA+PSOpkJhWYjOPJ1jF1WGEjj80X7UaB842ZG0zQuEg
	5NL1fZ6w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53758)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u7AHP-00049D-1e;
	Tue, 22 Apr 2025 10:51:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7AHM-0007O1-2J;
	Tue, 22 Apr 2025 10:51:00 +0100
Date: Tue, 22 Apr 2025 10:51:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Joakim Zhang <qiangqing.zhang@nxp.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: phylink: fix suspend/resume with WoL enabled
 and link down
Message-ID: <aAdmhIcBDDIskr3J@shell.armlinux.org.uk>
References: <Z__URcfITnra19xy@shell.armlinux.org.uk>
 <E1u55Qf-0016RN-PA@rmk-PC.armlinux.org.uk>
 <9910f0885c4ee48878569d3e286072228088137a.camel@gmail.com>
 <aAERy1qnTyTGT-_w@shell.armlinux.org.uk>
 <aAEc3HZbSZTiWB8s@shell.armlinux.org.uk>
 <CAKgT0Uf2a48D7O_OSFV8W7j3DJjn_patFbjRbvktazt9UTKoLQ@mail.gmail.com>
 <aAE59VOdtyOwv0Rv@shell.armlinux.org.uk>
 <CAKgT0Uc_O_5wMQOG66PS2Dc2Bn3WZ_vtw2tZV8He=EU9m5LsjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Uc_O_5wMQOG66PS2Dc2Bn3WZ_vtw2tZV8He=EU9m5LsjQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 17, 2025 at 12:49:07PM -0700, Alexander Duyck wrote:
> What I was saying is that we could add an additional state flag that
> we set before you write to the phylink_disable_state. You would
> essentially set the state to true if you want to preserve the current
> state, and if it is true you would set cur_link_statte to false in
> phylink_resolve ignoring the actual current link state.
> 
> So in phylink_stop you would set it to false, and in phylink_suspend
> you would set it to true. With that change phylink_stop could force
> the link down, whereas phylink_suspend would keep it up,
> phylink_suspend could deal with netif_carrier_off, and phylink_resume
> could deal with old_link_state.

I really don't like the idea that the netif carrier state differs from
old_link_state. These need to be the same to ensure that drivers which
use phylink in PHYLINK_NETDEV mode (which uses netif carrier for link
state tracking) vs PHYLINK_DEV mode (which uses old_link_state) see the
same behaviour, becomes much harder to guarantee if we start treating
these differently in the code depending on something other than which
PHYLINK*DEV is in use. It's really not something I want to entertain.

> > So, if the link was up, and we don't call mac_link_down() then we must
> > also *not* call phylink_mac_initial_config(). I've no idea what will
> > break with that change.
> 
> Sorry, mentioning it didn't occur to me as I have been dealing with
> the "rolling start" since the beginning. In mac_prepare I deal with
> this. Specifically the code in mac_prepare will check to see if the
> link state is currently up with the desired configuration already or
> not. If it is, it sets a flag that will keep us from doing any changes
> that would be destructive to the link. If the link is down it
> basically clears the way for a full reinitialization.

I would much rather avoid any of the "setup" calls (that means
mac_prepare(), mac_config(), mac_finish(), pcs_config() etc) and
mac_link_up() if we're going to add support for "rolling start" to
phylink.

That basically means that the MAC needs to be fully configured to
process packets before phylink_start() or phylink_resume() is called.

This, however, makes me wonder why you'd even want to use phylink in
this situation, as phylink will be doing virtually nothing for fbnic.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

