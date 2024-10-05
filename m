Return-Path: <netdev+bounces-132390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6E99917F4
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 17:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1BB91F2276A
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4524A155732;
	Sat,  5 Oct 2024 15:51:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3DED2FA;
	Sat,  5 Oct 2024 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728143513; cv=none; b=ua7BDF2Z23R+9TTBWjYdBTru5C2QhDnFILWmx8t5qkJacORrNgWqoA5GXgbie2OfjRIb2kTxc3jI1Yhe9gw4Zac9g+ndtueTq5lz9D7b4NFhBMNWB2q5NwPHtyGkfeE+cRoGtXnY6T3TF2g9cHmxd3JgJ+J4LjQ5AmpPt/vp1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728143513; c=relaxed/simple;
	bh=4pUIQXeeHVXu6q2/fEA3SjZjq6uP/PFkQfcTqylbTEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7DX81QavAtEBELwDDqvGNslPcgo+BzmSO4Nj6z2XEyzHiaNY6Xz1ZhJGJ5eDRebtqFh0G/OcvY14RpWepvbbe/4XCJ2mHgBGFJdzJOW+bghgga+UyH5nDkJSneOLKI1uBGsT9aOt8uVq4IU9K7u2ImqBuU1wg6/IYWNUgpfGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sx74C-000000003yl-3bOT;
	Sat, 05 Oct 2024 15:51:36 +0000
Date: Sat, 5 Oct 2024 16:51:30 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next] net: phy: always set polarity_modes if op
 is supported
Message-ID: <ZwFggnUO-vAXr2v_@makrotopia.org>
References: <473d62f268f2a317fd81d0f38f15d2f2f98e2451.1728056697.git.daniel@makrotopia.org>
 <5c821b2d-17eb-4078-942f-3c1317b025ff@lunn.ch>
 <ZwBn-GJq3BovSJd4@makrotopia.org>
 <e288f85c-2e5e-457f-b0d7-665c6410ccb4@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e288f85c-2e5e-457f-b0d7-665c6410ccb4@lunn.ch>

On Sat, Oct 05, 2024 at 04:17:56PM +0200, Andrew Lunn wrote:
> > I'll add "active-high" as an additional property then, as I found out
> > that both, Aquantia and Intel/MaxLinear are technically speaking
> > active-low by default (ie. after reset) and what we need to set is a
> > property setting the LED to be driven active-high (ie. driving VDD
> > rather than GND) instead. I hope it's not too late to make this change
> > also for the Aquantia driver.
> 
> Adding a new property should not affect backwards compatibility, so it
> should be safe to merge at any time.

Ok, I will proceed in that direction then and post a patch shortly.
My intial assumption that absence of 'active-low' would always imply
the LED being driven active-high was due to the commit description of
the introduction of the active-low property:

commit c94d1783136eb66f2a464a6891a32eeb55eaeacc
Author: Christian Marangi <ansuelsmth@gmail.com>
Date:   Thu Jan 25 21:36:57 2024 +0100

    dt-bindings: net: phy: Make LED active-low property common

    Move LED active-low property to common.yaml. This property is currently
    defined multiple times by bcm LEDs. This property will now be supported
    in a generic way for PHY LEDs with the use of a generic function.

    With active-low bool property not defined, active-high is always
    assumed.

    Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
    Reviewed-by: Andrew Lunn <andrew@lunn.ch>
    Acked-by: Lee Jones <lee@kernel.org>
    Reviewed-by: Rob Herring <robh@kernel.org>
    Link: https://lore.kernel.org/r/20240125203702.4552-2-ansuelsmth@gmail.com
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>


However, that's not what the code did in the end, it would be either
"set active-low" or "don't touch".

