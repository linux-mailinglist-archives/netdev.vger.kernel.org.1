Return-Path: <netdev+bounces-185603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD4EA9B16B
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE1892417D
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08361A23BD;
	Thu, 24 Apr 2025 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xfZuxBCt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E08C12CDA5;
	Thu, 24 Apr 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745506034; cv=none; b=ele7AY1Jeot8Ay3yMMTYjhtDjp+9Z7RaHMWCDlYtaCA4FAqlYxP5lcUsFrOVkT5ENL1fySXvFvDnLai+inJUarsUk/INzEvrkC5gBVBqEFE0I1JZkkR272p1aeJP4q34pegr5iv1OpbYbd+neAobgKOD79X4nacY++RdauaLW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745506034; c=relaxed/simple;
	bh=B+vaQDz34gASz2r9IySDvBGxFWVbRYQhO0FGeJb7jVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P28DUCLdISiZPpK/F4ZmJubKnY6XHCHzoDAjabWPBbxzmDlag7DFmu3blb533m4Kz64r52aIzfSVO1zvWktcV20DnwxTglszBZg289s19+yXAftsM84uCjxPC7Z05hoBjQP/PvalTlEpfQXnr1o9x/X/srfixkUOPPyucUuhSiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xfZuxBCt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=egGfbK658OSDe69FyW4Tv8G+ziXxzHDqqyx8wDiPEAQ=; b=xfZuxBCt41e8zQmoDtvq/y7N6h
	eiNOk5OhQwqmfZBZXA7zAFlssU1QXNmZGTPi4+UXL+xrQEC0aV/TkHALoRHzVhA1q7uRfyqzfXinD
	JzBHpTLyFd9tzBYFuaxQ6RiCLeeDKA533gXzs1bXQsZXGXyCRIJ5gC9BvcBRXfSdIYXJQjgsWDZHM
	ba5q3dlk9tDSz+CJn1Go4Mpmbz4A+9cBUr/I8B0wh440PewQx11KVL6rndMzu/aoM4klFnXyu9KUd
	kB6BxZfUHig2ZcwRABJ+ou1gs5rzb6onH6/Jni03BjdDDGJTXPTWXG1jBMQTnJaICgiNXy2mvDA74
	8fQTlo4Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52174)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u7xqz-0007Wd-1T;
	Thu, 24 Apr 2025 15:47:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7xqx-0001Bh-2x;
	Thu, 24 Apr 2025 15:47:03 +0100
Date: Thu, 24 Apr 2025 15:47:03 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Woojung Huh <woojung.huh@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v1 4/4] net: phy: Always read EEE LPA in
 genphy_c45_ethtool_get_eee()
Message-ID: <aApO59e6I6uLaw2P@shell.armlinux.org.uk>
References: <20250424130222.3959457-1-o.rempel@pengutronix.de>
 <20250424130222.3959457-5-o.rempel@pengutronix.de>
 <aAo5keWOAVWxj9_o@shell.armlinux.org.uk>
 <8f0d5725-04b7-4e15-897d-1fd5e540dacb@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f0d5725-04b7-4e15-897d-1fd5e540dacb@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 24, 2025 at 04:34:27PM +0200, Andrew Lunn wrote:
> On Thu, Apr 24, 2025 at 02:16:01PM +0100, Russell King (Oracle) wrote:
> > However, I've no objection to reading the LPA EEE state and
> > reporting it.
> 
> What happens with normal link mode LPA when autoneg is disabled? I
> guess they are not reported because the PHY is not even listening for
> the autoneg pulses. We could be inconsistent between normal LPA and
> LPA EEE, but is that a good idea?

With autoneg state, that controls whether the various pages get
exchanged or not - which includes the EEE capabilties. This is the
big hammer for anything that is negotiated.

With EEE, as long as autoneg in the main config is true, the PHY will
exchange the EEE capability pages if it supports them. Our eee_enabled
is purely just a software switch, there's nothing that corresponds to it
in hardware, unlike autoneg which has a bit in BMCR.

We implement eee_enabled by clearing the advertisement in the hardware
but accepting (and remembering) the advertisement from userspace
unmodified.

The two things are entirely different in hardware.

Since:

 ethtool --set-eee eee off

Will use ETHTOOL_GEEE, modify eee_enabled to be false (via
do_generic_set), and then use ETHTOOL_SEEE to write it back, the
old advertisement will be passed back to the kernel in this case.

If we don't preserve the advertisement, then:

 ethtool --set-eee eee off

will clear the advertisement, and then:

 ethtool --set-eee eee on

will set eee_enabled true but we'll have an empty advertisement. Not
ideal.

If we think about forcing it for an empty advertisement to e.g. fully
populated, then:

 ethtool --set-eee eee on advertise 0

will surprisingly not end up with an empty advertisement.

So, I don't think it's realistic to come up with a way that --set-eee
behaves the same way as -s because of the way ethtool has been
implemented.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

