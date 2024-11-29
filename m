Return-Path: <netdev+bounces-147810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BBE9DBF6C
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 07:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E00C9B21C3A
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 06:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8F1156872;
	Fri, 29 Nov 2024 06:18:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7513C33C5;
	Fri, 29 Nov 2024 06:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732861091; cv=none; b=YYrs8WGKRQupXYd6M8q7G7Sctc0wj6qomO5vYFdC0i3OYNJhoOMowf6WtCO9xGojtav9JVENNWcJFh/KXHdBgK20bWxLQ4utdpUWYQjp1frfOHf1ABdlCoNGqFdmIwV2BJAoxC5DcRALfs+5+j1UKBIPmRc6JdcOja8K7GdQ8pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732861091; c=relaxed/simple;
	bh=ZdDgU8v0Fg3qEcMdCAaZoTVLCTC1/5gtAQT2ve5pWeY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ut4YouUTfBf1NBjSgGdJl7YgCs6peEfKVU1+ocikeUDoBdeoVEJGN/MN9C//nShSAfTTeG36no1Vdo7dczjeSyplISKwz0++XywY1F5WBaJs5NrUhGDfG3KGEm9o8vfZiP2mqd/BN6EBFy9NwU3zPIzbTcVER/rXghwB+2uyQuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id 63D1BC408280;
	Fri, 29 Nov 2024 07:17:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 63D1BC408280
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>,  Oliver Neukum <oneukum@suse.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-usb@vger.kernel.org,  linux-kernel@vger.kernel.org,  Jose Ignacio
 Tornos Martinez <jtornosm@redhat.com>,  Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] PHY: Fix no autoneg corner case
In-Reply-To: <2428ec56-f2db-4769-aaca-ca09e57b8162@lunn.ch> (Andrew Lunn's
	message of "Thu, 28 Nov 2024 15:54:52 +0100")
References: <m3plmhhx6d.fsf@t19.piap.pl>
	<c57a8f12-744c-4855-bd18-2197a8caf2a2@lunn.ch>
	<m3wmgnhnsb.fsf@t19.piap.pl>
	<2428ec56-f2db-4769-aaca-ca09e57b8162@lunn.ch>
Sender: khalasa@piap.pl
Date: Fri, 29 Nov 2024 07:17:34 +0100
Message-ID: <m3serah8ch.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrew,

thanks for your response.

Andrew Lunn <andrew@lunn.ch> writes:

>> It seems the phy/phylink code assumes the PHY starts with autoneg
>> enabled (if supported). This is simply an incorrect assumption.
>
> This is sounding like a driver bug. When phy_start() is called it
> kicks off the PHY state machine. That should result in
> phy_config_aneg() being called. That function is badly named, since it
> is used both for autoneg and forced setting. The purpose of that call
> is to configure the PHY to the configuration stored in
> phydev->advertise, etc. So if the PHY by hardware defaults has autoneg
> disabled, but the configuration in phydev says it should be enabled,
> calling phy_config_aneg() should actually enabled autoneg.

But... how would the driver know if autoneg is to be enabled or not?

In the USB ASIX case, the Ethernet driver could dig this info up from
the chip EEPROM. Not sure if I like this way, though. Complicated, and
it's not needed in this case I think.

> I would say there are two different issues here.
>
> 1) It seems like we are not configuring the hardware to match phydev.
> 2) We are overwriting how the bootloader etc configured the hardware.
>
> 2) is always hard, because how do we know the PHY is not messed up
> from a previous boot/crash cycle etc. In general, a driver should try
> to put the hardware into a well known state. If we have a clear use
> case for this, we can consider how to implement it.

Well, I think if someone set the PHY previously, and then the machine
rebooted (without actually changing PHY config), then perhaps the
settings are better than any defaults anyway. Though I guess it will be
configured in the init scripts again soon.

It's not something easily messed up by a crash. But yes, there is a risk
the config was wrong, set by mistake or something.

BTW USB adapters will almost always reconfig PHY on boot, because they
are powered from USB bus.

In this case, with ASIX USB adapter (internal PHY ax88796b /
ax88796b_rust), the MAC + PHY will be configured by hardware on USB
power up. So we _know_ the settings are better than any hardcoded
defaults.

Maybe the specific ASIX PHY code should handle this.

Nevertheless, the inconsistency between phy/phylink/etc. and the actual
hardware PHY is there.
I guess I will have a look at this again shortly.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa

