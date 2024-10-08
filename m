Return-Path: <netdev+bounces-133109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD1A994E59
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CBEBB2C39A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D091DEFE6;
	Tue,  8 Oct 2024 13:13:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA711DE88F;
	Tue,  8 Oct 2024 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393187; cv=none; b=RscnbGFEhKpKqVqW+w4SnhaNjNIb1fwgBF0fNjt6Santtr2XBEk6lK487lqJU7Chq7hF0OHliOswxD0NQ2HHHaX5SZZ3UV+uWZia4ahNzruUOCircTECdv8tYcVPAoO4OJ7go0h0WPbk1R3XXcWJiNkkIhHfGy9c2VBf+5AQNzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393187; c=relaxed/simple;
	bh=kWolaxy9BFb65skdKEyMGtyjqIelsjI/f70XBk08Rcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wz6oBAns9Lc8zIMOJxN9UAd+umvIu2fH2Q9b83V9WqgkOdCCkR2jX689o0vsbssHl7lNvmklgDleXDyAWntCS5cYDL6SRpI3SWyR214zrUDZv09U7OL2OBFFpgRnZlIomSgeXHs0eGBjZablCzxwdNfjUstbDbhZGW/gZJGVXr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1syA1L-000000000AX-1fe6;
	Tue, 08 Oct 2024 13:12:59 +0000
Date: Tue, 8 Oct 2024 14:12:55 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2] net: phy: Validate PHY LED OPs presence
 before registering
Message-ID: <ZwUv15SUVhRukqVr@makrotopia.org>
References: <20241004183312.14829-1-ansuelsmth@gmail.com>
 <851ebd20-0f7a-438d-8035-366964d2c4d8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <851ebd20-0f7a-438d-8035-366964d2c4d8@lunn.ch>

On Tue, Oct 08, 2024 at 03:08:32PM +0200, Andrew Lunn wrote:
> > +	/* Check if the PHY driver have at least an OP to
> > +	 * set the LEDs.
> > +	 */
> > +	if (!phydev->drv->led_brightness_set &&
> > +	    !phydev->drv->led_blink_set &&
> > +	    !phydev->drv->led_hw_control_set) {
> 
> I think this condition is too strong. All that should be required is
> led_brightness_set(). The rest can be done in software.

Some drivers do not offer led_brightness_set().
See for example
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/phy/realtek.c#n1303

Afaik there aren't any drivers which only offer led_blink_set(), that
would indeed be a bit weird. But only offering led_hw_control_set() is a
(rather sad) reality.

