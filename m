Return-Path: <netdev+bounces-203494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5E4AF6283
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 21:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 927867AA318
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36422F7CFD;
	Wed,  2 Jul 2025 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="U27uauSu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401F62F7D1F
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751483890; cv=none; b=Bmno2edVe8rbESZFr3UC4IEbcglsFBApFTT7xlhaHumgpKJQhVDMrG5vDh+HkESsqA50H38ZsqeOIoW0edYiz0UJPjo92XQbzI8LMP+f6D868LKzSqcGGThFGLNSGZQBXEbkDQHeqES3uxQTun9aWUs/f8e8+kmScZH1iRNvMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751483890; c=relaxed/simple;
	bh=I6ujcxcF/NbT6fX1yq4Bb5wFObPVExVItAn9msWNl/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txM3ItDGhUiyAhiuWB6Ei0U3veYgWOvGEQSz0N7lrhtpzJ3/NMxIHgL/a15HoFXMmmjAXbKn/YpZ8WgNPPLtDxXT1PaNzTfP/ZHDgYw34+9BR4Cr5hKK6wmoO1Es5xosf/1haXTy5lDdZz+F3PtK/a3rwnTuGORH1R97qvdVnLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=U27uauSu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cROEizyYEhT1ZzF4lcKLDdkzX7FxmK9SvKDTB3Kex44=; b=U27uauSusKqT9GBDL2QT3mM+Dn
	CWnNRJMtoNEY3zAT7rWw1xCROd2IAj3Tx4lG3kjhKhjbN8nWGwXTd4jLzBkvCffNExZGeq6V7tk3D
	rOL+sjZo5Qvja7S7C/8fzXqt16i4LQ1cXTF7vrPgPE5RjprtwXud5x5WmKkOQKBMc/AUIShuHcyVG
	Dxy08XZm0LW1hlkWB8uhfxTJb/QgSgqT9/U1eww1tEfAL67qX2O+FA3+C4UfUblLFc7dBjR29fDsg
	/HLTjZjHOWrL7aGlBnKhgxBj0C9EkQ8dg6OJPCpVP+zVZdWE8WrBz5toRVs7F1UQR3JecykRqC+Jl
	JK/xbQSw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47714)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uX2y1-000888-0o;
	Wed, 02 Jul 2025 20:18:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uX2xx-0004Jx-26;
	Wed, 02 Jul 2025 20:17:57 +0100
Date: Wed, 2 Jul 2025 20:17:57 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: phylink: add
 phylink_sfp_select_interface_speed()
Message-ID: <aGWF5Wee3vfoFtMj@shell.armlinux.org.uk>
References: <aGT_hoBELDysGbrp@shell.armlinux.org.uk>
 <E1uWu14-005KXo-IO@rmk-PC.armlinux.org.uk>
 <20250702151426.0d25a4ac@fedora.home>
 <aGU2C3ipj8UmKHq_@shell.armlinux.org.uk>
 <CAKgT0UcWGH14B0zZnpHeJKw+5VU96LHFR1vR4CXVjqM10iBJSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UcWGH14B0zZnpHeJKw+5VU96LHFR1vR4CXVjqM10iBJSg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 02, 2025 at 11:07:52AM -0700, Alexander Duyck wrote:
> On Wed, Jul 2, 2025 at 6:37 AM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Jul 02, 2025 at 03:14:26PM +0200, Maxime Chevallier wrote:
> > > On Wed, 02 Jul 2025 10:44:34 +0100
> > > "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:
> > >
> > > > Add phylink_sfp_select_interface_speed() which attempts to select the
> > > > SFP interface based on the ethtool speed when autoneg is turned off.
> > > > This allows users to turn off autoneg for SFPs that support multiple
> > > > interface modes, and have an appropriate interface mode selected.
> > > >
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > >
> > > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > >
> > > I don't have any hardware to perform relevant tests on this :(
> >
> > Me neither, I should've said. I'd like to see a t-b from
> > Alexander Duyck who originally had the problem before this is
> > merged.
> 
> It will probably be several days before I can get around to testing it
> since I am slammed with meetings most of the next two days, then have
> a holiday weekend coming up.

I, too, have a vacation - from tomorrow for three weeks. I may dip in
and out of kernel emails during that period, but it depends what
happens each day.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

