Return-Path: <netdev+bounces-68915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E3D848D2D
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 12:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF533B21E12
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 11:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DB28BFD;
	Sun,  4 Feb 2024 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LLbgfSE0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5170E2208B
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707046917; cv=none; b=i5Vd67nA+JMPsMHJoqq+kEdkkV0GMe4i4hyZpIE4dEnyIuB/agElmXfX/wmgbPa8VtbCy0/GQHgScsXnf3M+4cdALR/JvpBfjnGbvlHsJjtldK9kryyCV3VxrbuXIqsISboCuqRSipFNfuEsEueFrnp9WD8uS5mXc2c1fHxSl9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707046917; c=relaxed/simple;
	bh=6GZ1fEAFmpK6ZUNO7JGzNHW7qPj/AgfTR1FTzQgFe54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMSyvRauitMOxDonc4ARL4JnwgMhrFOw4AaV8Edq0xGacPPf10QqBHDt1FS0bL7xR6OE8aU0fxtyYf141yG8bT/Wv2pKruirum8EUkUxR8ZuulZXzUS0qdPg440VDeSVBP30bXDFcJ7I6YtLLdGO6HRPu+VBrey08OkfqDvhcgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LLbgfSE0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/6S0XOei2alGmsuTX/azQLspn1VbC6KI49hkXNWTry4=; b=LLbgfSE00sRJuEbK2VVknksIhv
	kcHkJf/m2uUqM5T15x/mcGGjTJg/8YJY00RXYxQQDgeeQ87kdqW35/3a7VbDUxboMA71in0Yawd7u
	4/4iKfHcf6I9BQ6ecNNSAfRTquPQdtjr0kugVEjGSlSsqQ3rjoqLbTZ2YPxg4hN5bOO8YPACGuYs3
	FEGlTf4zCx8IgyywA1aVZrDdJeaNTetxAV9oTu9UJMtd8q2r9dksWtd2jhBvoB+Vsy7CwQEsiljbS
	HHRgls2jHBLR+6s6R9QHTiDKkd3kUz8THhfbw9sDnmOqTgBqZjkNffyRWCjsyTvF2J3TeuaVhJ1YK
	l70jOLZQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50732)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rWasb-0007tn-2J;
	Sun, 04 Feb 2024 11:41:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rWasY-0001iu-Gp; Sun, 04 Feb 2024 11:41:42 +0000
Date: Sun, 4 Feb 2024 11:41:42 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] bnxt: convert EEE handling to use linkmode
 bitmaps
Message-ID: <Zb939rzMQchueX2r@shell.armlinux.org.uk>
References: <10510abd-ac26-42d0-8222-8b01fe9b8059@gmail.com>
 <e65b8525-eae0-4143-aa57-009b47f09005@lunn.ch>
 <CACKFLinhkS8-=QtZu9Es9ATiSMAyosuCfuPVFUOxzqJk4Tr2rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLinhkS8-=QtZu9Es9ATiSMAyosuCfuPVFUOxzqJk4Tr2rA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Feb 03, 2024 at 04:16:51PM -0800, Michael Chan wrote:
> On Sat, Feb 3, 2024 at 1:59 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > -     if (!edata->advertised_u32) {
> > > -             edata->advertised_u32 = advertising & eee->supported_u32;
> > > -     } else if (edata->advertised_u32 & ~advertising) {
> > > -             netdev_warn(dev, "EEE advertised %x must be a subset of autoneg advertised speeds %x\n",
> > > -                         edata->advertised_u32, advertising);
> >
> > That warning text looks wrong. I think it should be
> >
> > EEE advertised %x must be a subset of autoneg supported speeds %x
> >
> > and it should print eee->supported, not advertising.
> >
> I think it is correct.  EEE advertised must be a subset of the
> advertised speed.

Where is that a requirement?

If a PHY supports e.g. 1G, 100M, and supports EEE at those two speeds,
but is only advertising 1G, then the only speed that could be
negotiated is 1G.

The EEE negotiation will also occur, and if the link partner also
advertises EEE at 1G and 100M, the result of that negotiation is that
EEE _can_ _be_ _used_ at 1G and 100M speeds.

However, the PHY has negotiated 1G speed, so it now checks to see
whether the EEE negotiation included 1G speed. The fact that the EEE
negotiation also includes 100M is irrelevant - the negotiated speed
is 1G, and that's all that determines whether EEE will be used for
the negotiated link speed.

The exception is if the PHY is buggy and doesn't follow this, e.g.
assuming that if any EEE speed was negotiated that EEE is supported,
but that would be a recipe for disaster given that a link partner
may only advertise EEE at 100M, we may be advertising 100M and 1G
(both for EEE and link) so we end up using 1G with EEE despite the
link partner not supporting it.

So, whatever way I look at it, the statement "the EEE advertisement
must be a subset of the link advertisement" makes absolutely no sense
to me, and is probably wrong.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

