Return-Path: <netdev+bounces-128709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469B297B21C
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 17:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49891F294A2
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 15:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E0B17DE35;
	Tue, 17 Sep 2024 15:23:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E250617C990;
	Tue, 17 Sep 2024 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726586602; cv=none; b=gnDI3H3HLQxc8KtP/+gWD0OsNVq19EpHbzfTg+1b1VPytSEfIcBJpp55un6qA11aDzipIPqwMsb2uugd4PXWxw2djjAhCzSsJGC2KZuGGJM8Za6o7cUuHjH+XeW2K6kWcBaQQjQvuiRmUM7BxEBl5BD7gJNyTClwxfITrMtwOYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726586602; c=relaxed/simple;
	bh=rXUhohz9DvPpOeTfO/78QGoZYH7TaW+ywURJatmc9Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P92cpWnOwQx+h7BcjEpzMquCqC/YWlcwWsJAzB17xVtmFDStalqYUquVRPBcaVjkBuHcZ1jsAgarWi/uCq3xHjgLwNsMMNsjENcqS46msbElIfXhkGGJ8btIvXkv+bK0tEuqF89pGfpM7fw5i5IrcI/k0KzCKrgUgVuji9hEVSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sqa2q-000000003Uh-0YDN;
	Tue, 17 Sep 2024 15:23:12 +0000
Date: Tue, 17 Sep 2024 16:23:06 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: phy: aquantia: fix applying active_low bit
 after reset
Message-ID: <Zume2obQ6b28QMDj@makrotopia.org>
References: <ab963584b0a7e3b4dac39472a4b82ca264d79630.1726580902.git.daniel@makrotopia.org>
 <9b1f0cd91f4cda54c8be56b4fe780480baf4aa0f.1726580902.git.daniel@makrotopia.org>
 <ZumVB5yQJCrzrvM5@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZumVB5yQJCrzrvM5@shell.armlinux.org.uk>

Hi Russell,

On Tue, Sep 17, 2024 at 03:41:11PM +0100, Russell King (Oracle) wrote:
> On Tue, Sep 17, 2024 at 02:49:55PM +0100, Daniel Golle wrote:
> > for_each_set_bit was used wrongly in aqr107_config_init() when iterating
> > over LEDs. Drop misleading 'index' variable and call
> > aqr_phy_led_active_low_set() for each set bit representing an LED which
> > is driven by VDD instead of GND pin.
> 
> Assuming that the intention is only to set LEDs active-low that were
> previously configured to be active-low, then:

Exactly. That was supposedly also the original intention.

> 
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> It's good that we don't call aqr_phy_led_active_low_set() for every LED
> in the .config_init method because we don't know whether the LED
> outputs for this PHY are used on SFPs to drive e.g. the SFP LOS pin,
> and changing LED settings in such a case could cause incorrect
> signalling. If this ever changes, then this code needs to be
> conditional on !phy_on_sfp(phydev).

Ack. The post-reset default is active-high and the only case we need to
cover here are LEDs for which VDD is driven instead of GND, so
supposedly if any of those signals are used as LOS in a SFP module it
would be wired in a way which uses the post-reset default of the PHY
anyway which were aren't changing in this case.

Thank you for the quick review!


Daniel

