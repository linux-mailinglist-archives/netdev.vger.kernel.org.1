Return-Path: <netdev+bounces-54491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D31E7807481
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA10F1C20AE6
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676E546450;
	Wed,  6 Dec 2023 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ceVNIdGl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B04FD6E;
	Wed,  6 Dec 2023 08:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jWu5AuL7yKoNx7WS0OkakDQa71S04QtMUM2UIOzUW6s=; b=ceVNIdGl0TNS5phcFLE3/WITrs
	+6VC9FcJpVAcEXcWHMX1NPQ5JYv+Z671QrQkD3aDpj4QT7n5H3xb4/Ee0aQ9NdHDIIN9uaIS2/hMl
	q7URm2LkRa8SeWybTtkrDWUStgQhShA+GtuxLFOEvw+AvC+vT0xD1ugYI0oy1S9SyRbM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rAuO1-002Dzb-6k; Wed, 06 Dec 2023 17:04:33 +0100
Date: Wed, 6 Dec 2023 17:04:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Heiko Stuebner <heiko@sntech.de>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH] net: mdio: enable optional clock when registering a phy
 from devicetree
Message-ID: <853c30b2-afb9-4f86-87bb-ce79cbca1960@lunn.ch>
References: <20231201142453.324697-1-heiko@sntech.de>
 <84c102fa-e3f4-4454-82c9-95eea7eeb941@lunn.ch>
 <b36e07f0-a8d6-4623-8531-4c3eef5dece6@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b36e07f0-a8d6-4623-8531-4c3eef5dece6@theobroma-systems.com>

> I was just wondering about this as well. Right now, we put the reset on the
> MAC controller device tree node for our board (c.f. https://lore.kernel.org/linux-arm-kernel/20231201191103.343097-1-heiko@sntech.de/)
> because otherwise it doesn't work.
> 
> I assume this is because the phy net subsystem is not handling the reset at
> the proper time (it does so before probing the PHY driver, which is too late
> because the auto-detection mechanism has already run before and the MAC
> couldn't find the PHY ID since the PHY wasn't reset properly at that time).
> 
> I think essentially we would need to have both the reset assert/deassert and
> clock enabling/disabling in the same location as this patch is suggesting to
> make all of this work.
> 
> I'll not investigate this, because Florian NACK'ed the whole thing. I do not
> personally have an interest in fixing only the reset, because we need the
> clock to be enabled for the auto-detection mechanism to work.

There was a couple of discussions at LPC this year about resources
needed to be enabled before bus discovered would work. I missed the
first talk, but was in the second. That concentrated more on PCI,
despite it being a generic problem.

Ideally we want some way to list all the resources and ordering and
delays etc, so that a generic block of code could get the device into
an enumerable state. But there was a general push back on this idea
from GregKH and the PM Maintainer, but i think the MMC Maintainer was
for it, since the MMC subsystem has something which could be made
generic. The outcome of the session was a PCI only solution.

I still don't think we should be solving this in phylib, so for the
moment, we need to keep with ID values in DT, so the driver gets
probed. Anything we add to phylib is just going to make it harder to
adopt a generic solution, if it ever gets agreed on.

      Andrew

