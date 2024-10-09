Return-Path: <netdev+bounces-133671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F89A996A32
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD001F246F9
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A32194082;
	Wed,  9 Oct 2024 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eJU+aU6O"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE0A1E4AE;
	Wed,  9 Oct 2024 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477511; cv=none; b=t1hgBN3ENoZ1Bjgl/4MGcpwVCdCHm2Vjik4zCrQ+QSrzyaK6C8ivaP3QtHd1dk1C2kN+lhTvVsLlIXfGq2ZSbcx72i3H1MHHv5QZ8I+h4txn2tfoA6GKoSq2G1TVzghionsLUAMqkzF6v75jJzbyFHgkBwNctUbqXwIO6BD1m5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477511; c=relaxed/simple;
	bh=IyKBDvF6I6JGdED6OzStBRo5XIC0mAddoe6pT1xoTKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9nSWVRGc5ewlUT+hsPwJ4Tdv/l3rgeAdEDRVvrtpLOYU+i9K+uh9T3mmn9yvyf+V59X4N461y6CYMudJhV80gTP9EI3/AY9NUtctgh8NsQv9pKvMK1raZSAGZ+XdwXoyA6BvrHxL2aszAabComeQ5a+CZxmedYFO2uj846Vz80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eJU+aU6O; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EWN1dSxAvoGOW1lk8m8SXgj5ggbhXAJ3scgcWCJEdeM=; b=eJU+aU6OWA7mPsz2IMYuqkKEoF
	OCmEziADQj0RnCsf6AcjVsSWPztdqI+50SbQJhTjQ4UeRwVa5SGnwEiMXOGlbIJ4i5/CUIzF9KFK0
	5RK3VkfuQSD97hx6+cB/x32SGKsMu7jA2dbVzVGG57hOJK20tIr4LUpPSIQDbIlFPzd4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syVxJ-009Unn-0T; Wed, 09 Oct 2024 14:38:17 +0200
Date: Wed, 9 Oct 2024 14:38:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: intel-xway: add support for PHY LEDs
Message-ID: <6f2cf2f0-08db-4b83-bfc9-0efab8324ac9@lunn.ch>
References: <c1358e27e3fea346600369bb5d9195e6ccfbcf50.1728440758.git.daniel@makrotopia.org>
 <bc9e4e95-8896-4087-8649-0d8ec6e2cb69@lunn.ch>
 <ZwZ31IkwY-bum7T0@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwZ31IkwY-bum7T0@makrotopia.org>

On Wed, Oct 09, 2024 at 01:32:20PM +0100, Daniel Golle wrote:
> On Wed, Oct 09, 2024 at 02:16:29PM +0200, Andrew Lunn wrote:
> > > +static int xway_gphy_led_polarity_set(struct phy_device *phydev, int index,
> > > +				      unsigned long modes)
> > > +{
> > > +	bool active_low = false;
> > > +	u32 mode;
> > > +
> > > +	if (index >= XWAY_GPHY_MAX_LEDS)
> > > +		return -EINVAL;
> > > +
> > > +	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
> > > +		switch (mode) {
> > > +		case PHY_LED_ACTIVE_LOW:
> > > +			active_low = true;
> > > +			break;
> > > +		case PHY_LED_ACTIVE_HIGH:
> > > +			break;
> > > +		default:
> > > +			return -EINVAL;
> > > +		}
> > > +	}
> > > +
> > > +	return phy_modify(phydev, XWAY_MDIO_LED, XWAY_GPHY_LED_INV(index),
> > > +			  active_low ? XWAY_GPHY_LED_INV(index) : 0);
> > 
> > This does not appear to implement the 'leave it alone' option.
> 
> The framework already implements that. The function is never called with
> modes == 0.

I was wondering about that.

But if this ever gets extended to support other properties, like HI-Z,
it is a bit of a trap waiting for somebody to fall into.

It is correct, so: Reviewed-by: Andrew Lunn <andrew@lunn.ch> but it
would be nice if it was a bit more robust.

    Andrew

