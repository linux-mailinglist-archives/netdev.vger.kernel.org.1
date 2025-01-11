Return-Path: <netdev+bounces-157439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD61A0A4EC
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 18:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA3D164F0F
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 17:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D58E14EC60;
	Sat, 11 Jan 2025 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n/oxGbpi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EE6EBE;
	Sat, 11 Jan 2025 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736614842; cv=none; b=M1AiOpRXCXgELnGQTyQ4Z3Uh70Ps+W1K/QaTRgwJ978zyL0k3n4xot5lWalqHRJl419/WJ1of+H0aoy/WAO6AavExda6pCcJ3jee7FQ7aAJMy3RqchPaSIuGs2UYdoHXk4AdI2x1K9TxfO28bh81JT57vJSx6p6g/X4Lyv1KH/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736614842; c=relaxed/simple;
	bh=49VSL4D/KPkxJ+eFCXZctSCoxcKqPZ3ZGyi4HsT/uic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7wG5rZnYQIqw2ZxceOrWGXAmqFHTIN1zcUEx4d5ND3RvT6yLSaP/ovjv/eezDFYb3vR7W2tb44S7hs/9fEKOO8w4wAQ9lKY2bPynAy2VUo6LeLy36s3afbFxMIzC8D4D8oJTBcr13MALHg6iwaiXtE8Kn3CzTwrF6yw5SV1iwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n/oxGbpi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vrAAgUcE8bhk3sZUvhP9sUL9+WDsX+SNiNHu7t+28GA=; b=n/oxGbpi0pgxALvqxRg1NyXt8O
	7dNoLxgBnG2XN0jjqnAVYGtgsXfogSmpKWQJnI74hZ1XUxb8naXbm7xu73WR32X/PfA8nTOIEW/ey
	VYSiFtDxxjRbBfaVEWfxmYNsXYuTFhl/kARtKhUI68uitz4WveeEGVME6JJX3ALLWla0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tWeqM-003Zxs-NO; Sat, 11 Jan 2025 18:00:14 +0100
Date: Sat, 11 Jan 2025 18:00:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH net-next 3/3] net: phy: realtek: add hwmon support for
 temp sensor on RTL822x
Message-ID: <0adfb0e4-72b2-48c1-bf65-da75213a5f18@lunn.ch>
References: <3e2784e3-4670-4d54-932f-b25440747b65@gmail.com>
 <dbfeb139-808f-4345-afe8-830b7f4da26a@gmail.com>
 <8d052f8f-d539-45ba-ba21-0a459057f313@lunn.ch>
 <a0ddf522-e4d0-47c9-b4c0-9fc127c74f11@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0ddf522-e4d0-47c9-b4c0-9fc127c74f11@gmail.com>

> According to Guenters feedback the alarm attribute must not be written
> and is expected to be self-clearing on read.
> If we would clear the alarm in the chip on alarm attribute read, then
> we can have the following ugly scenario:
> 
> 1. Temperature threshold is exceeded and chip reduces speed to 1Gbps
> 2. Temperature is falling below alarm threshold
> 3. User uses "sensors" to check the current temperature
> 4. The implicit alarm attribute read causes the chip to clear the
>    alarm and re-enable 2.5Gbps speed, resulting in the temperature
>    alarm threshold being exceeded very soon again.
> 
> What isn't nice here is that it's not transparent to the user that
> a read-only command from his perspective causes the protective measure
> of the chip to be cancelled.
> 
> There's no existing hwmon attribute meant to be used by the user
> to clear a hw alarm once he took measures to protect the chip
> from overheating.

It is generally not the kernels job to implement policy. User space
should be doing that.

I see two different possible policies, and there are maybe others:

1) The user is happy with one second outages every so often as the
chip cycles between too hot and down shifting, and cool enough to
upshift back to the higher speeds.

2) The user prefers to have reliable, slower connectivity and needs to
explicitly do something like down/up the interface to get it back to
the higher speed.

I personally would say, from a user support view, 2) is better. A one
time 1 second break in connectivity and a kernel message is going to
cause less issues.

Maybe the solution is that the hwmon alarm attribute is not directly
the hardware bit, but a software interpretation of the system state.
When the alarm fires, copy it into a software alarm state, but leave
the hardware alarm alone. A hwmon read clears the software state, but
leaves the hardware alone. A down/up of the interface will then clear
both the software and hardware alarm state.

Anybody wanting policy 1) would then need a daemon polling the state
and taking action. 2) would be the default.

How easy is it for you to get into the alarm state? Did you need an
environment chamber/oven, or is it happening for you with just lots of
continuous traffic at typical room temperature? Are we talking about
cheap USB dangles in a sealed plastic case with poor thermal design
are going to be doing this all the time?

	Andrew

