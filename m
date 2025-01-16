Return-Path: <netdev+bounces-158894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4027A13AD5
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6321884B7C
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AAE22A4F1;
	Thu, 16 Jan 2025 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z0+Y91q2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012DE1DE2AD;
	Thu, 16 Jan 2025 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737033831; cv=none; b=ab+A7hMsmgmuTL8NSQcLHgas+V5SfLJROB3GFIblVbsxKKD2kQ5qdB5jkwnulwLQXEawjNSEAzj591EiDWIUuHbT76SuRd0MXHHnL/7bqqBle5GUsXDXKrAYKbhgS5jhl4hBqIPdsDdxKTIIGLmaUzWQSNx1QUrRLhzRZMKwf9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737033831; c=relaxed/simple;
	bh=YE2loUyZi7WDt/AH1FxSlaolfBtCo2nsAINwHScBVPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRFaAXV21plWlWuoRDcFwPXcVnanqTTbrcoxdVQ0TvKT8lx/DcC14xOZAy7+BX279Agk3LvBjUFJF141HCy8vS9dcr4XqKA2SiVikvHcS+ilDVsZ4byx0StcgEki8MvsGWElqOhdIOfdYgwUgwHUZ8C0p9cx3vqVMyx17O63Ok8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z0+Y91q2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gcBvryTujIP9NtHf7WQVK6/xFT4BPuvy0b3XiwmmD+M=; b=Z0+Y91q2RkA+xLXhjMXiUYLNva
	BWO1rztzp/LlNhvLnZtUXfUyhlaqWUpX0ZFAH0euqAe06xS0UoikVimVOyLb++DAGrTUuAh1RzEsr
	AAzw40UdUfFRkUBA8DyQSz2XLkkJbYqfaZJRXX3LTX3eh14cZrmKwNwNk5rMcV0mZjLs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tYPqV-0058II-WA; Thu, 16 Jan 2025 14:23:40 +0100
Date: Thu, 16 Jan 2025 14:23:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Marek Vasut <marex@denx.de>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Tristram Ha <tristram.ha@microchip.com>,
	UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,PATCH 2/2] net: phy: micrel: Add KSZ87XX Switch LED
 control
Message-ID: <ef933bd4-b9ae-4f78-8f05-abd1d2832bf8@lunn.ch>
References: <20250113001543.296510-1-marex@denx.de>
 <20250113001543.296510-2-marex@denx.de>
 <4d02f786-e87e-4588-87ed-b5fa414a4b5a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d02f786-e87e-4588-87ed-b5fa414a4b5a@redhat.com>

On Thu, Jan 16, 2025 at 10:58:38AM +0100, Paolo Abeni wrote:
> On 1/13/25 1:15 AM, Marek Vasut wrote:
> > The KSZ87xx switch contains LED control registers. There is one shared
> > global control register bitfield which affects behavior of all LEDs on
> > all ports, the Register 11 (0x0B): Global Control 9 bitfield [5:4].
> > There is also one per-port Register 29/45/61 (0x1D/0x2D/0x3D): Port 1/2/3
> > Control 10 bit 7 which controls enablement of both LEDs on each port
> > separately.
> > 
> > Expose LED brightness control and HW offload support for both of the two
> > programmable LEDs on this KSZ87XX Switch. Note that on KSZ87xx there are
> > three or more instances of simple KSZ87XX Switch PHY, one for each port,
> > however, the registers which control the LED behavior are mostly shared.
> > 
> > Introduce LED brightness control using Register 29/45/61 (0x1D/0x2D/0x3D):
> > Port 1/2/3 Control 10 bit 7. This bit selects between LEDs disabled and
> > LEDs set to Function mode. In case LED brightness is set to 0, both LEDs
> > are turned off, otherwise both LEDs are configured to Function mode which
> > follows the global Register 11 (0x0B): Global Control 9 bitfield [5:4]
> > setting.
> 
> @Andrew, @Russel: can the above problem be address with the current phy
> API? or does phy device need to expose a new brightness_get op?

Coupled LEDs cause issues. Because vendors do all sorts of weird
things with LEDs, i don't want to fully support everything every
vendor has, or the code is just going to be unmaintanable. So we have
the core support a subset, and some features of the hardware go
unused.

In this case, i would say software control of the LEDs is
impossible. You cannot individually turn an LED on/off. The core
supports this, Heiner added support for a PHY with similar issues. I
think it is as simple as not implementing led_brightness_set().


    Andrew

---
pw-bot: cr

