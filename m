Return-Path: <netdev+bounces-148013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88B89DFCBA
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C989161DF0
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 09:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADCD1F9F6E;
	Mon,  2 Dec 2024 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QSnATu84"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17DB1F8AEE;
	Mon,  2 Dec 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130228; cv=none; b=h43POt/da3GzqEOiZAx4OhPZUbf8LSdCfIZfdlwxzRkv/20jcpmM89qHmMguU+Ta9teU+TuqNT6uK3GUjRDf6Thv5cUUfqDfk11T6gyi/pb+0YJIFw4rUH+148edVmgdXaWnao8qD2ChUyz2vvshXP0iiail4JuCcoMf3QY1qcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130228; c=relaxed/simple;
	bh=Pa+pXm8E5c3e/oB7EbaRyjZ+VIIhUUt2y7g++RbV/Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbDJ4SN1vcgVHwvP0lTk/0Y9YpySw1PhgbE/aX+aRqfGwv20qpngEFjnHTxVGz1SOZ47Dhd9c2CcXR0kVXv+Lo+TF4TEMKoV3Q/R+6v/BhUaD1aUKJmYFPo333TBLwNS5FMz0RAS3JSCkdpmknvoiBsxLs8QWJNY8t+avV+4OqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QSnATu84; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 35A571C0003;
	Mon,  2 Dec 2024 09:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733130216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FIwPyjDUMGSM8xBxisUX0CfzZjx6Y78zGOEeMXOBnS4=;
	b=QSnATu84Nb7kfWVICUD7U//UKQ3W4/xFhJbNia4y/SCGrQoJaKVdWGy3d5o7MJaz5o68r8
	9WQwXneCRrlQADPA5wf1X42ouf+mMX9ogRcS60zp74niZflpakupiI8/VPYoDSPpkZAz33
	/aMJmZxPAgsW5eU4YVI7NW8pOIy8DI9A4gNa1J0LNzO8+KG1ziXPEE66t6i4sNJbbquDP3
	MLbxxHcG5s8+P6CQJ74EpYQEOkUMhgcoGMN+5Xk2DD12AulVhDz3Bb/Fad/Cdd/dbK+PVM
	KssZvZTRNj/E4YTeVUi5XFfwEWxPZuajNf0XgAV9F4ihZdAs11VlruAeFPLgjg==
Date: Mon, 2 Dec 2024 10:03:34 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>, Dennis Ostermann
 <dennis.ostermann@renesas.com>
Subject: Re: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any
 supported speed
Message-ID: <20241202100334.454599a7@fedora.home>
In-Reply-To: <20241202083352.3865373-1-nikita.yoush@cogentembedded.com>
References: <20241202083352.3865373-1-nikita.yoush@cogentembedded.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Nikita,

On Mon,  2 Dec 2024 13:33:52 +0500
Nikita Yushchenko <nikita.yoush@cogentembedded.com> wrote:

> When auto-negotiation is not used, allow any speed/duplex pair
> supported by the PHY, not only 10/100/1000 half/full.
> 
> This enables drivers to use phy_ethtool_set_link_ksettings() in their
> ethtool_ops and still support configuring PHYs for speeds above 1 GBps.
> 
> Also this will cause an error return on attempt to manually set
> speed/duplex pair that is not supported by the PHY.

There have been attempts to do the same thing before :

https://lore.kernel.org/netdev/1c55b353-ddaf-48f2-985c-5cb67bd5cb0c@lunn.ch/

It seems that 1G and above require autoneg to properly work. The 802.3
spec for 2.5G/5G (126.6.1 Support for Auto-Negotiation) does say :

  All 2.5GBASE-T and 5GBASE-T PHYs shall provide support for
  Auto-Negotiation (Clause 28) and shall be capable of operating as
  MASTER or SLAVE.

[...]

  Auto-Negotiation is performed as part of the initial set-up of the
  link, and allows the PHYs at each end to advertise their capabilities
  (speed, PHY type, half or full duplex) and to automatically
  select the operating   mode for communication on the link.
  Auto-Negotiation signaling is used for the following primary purposes
  for 2.5GBASE-T and 5GBASE-T:

    a) To negotiate that the PHY is capable of supporting
       2.5GBASE-T or 5GBASE-T transmission.

    b) To determine the MASTER-SLAVE relationship between
       the PHYs at each end of the link.

Looking at this it does seem that autoneg should stay enabled when
operating at other speeds than 10/100/1000, at least in BaseT.

What's your use-case to need >1G fixed-settings link ?

Thanks,

Maxime

