Return-Path: <netdev+bounces-50587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EE17F63B4
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21B11B20E54
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721BF3E490;
	Thu, 23 Nov 2023 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5UBcdMKG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE3FD64;
	Thu, 23 Nov 2023 08:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dBjA4zTKyiFFHKGNIIV3o3WzlHqH9tPy3OMPPVwLuyA=; b=5UBcdMKG8/sm7BB+rID1GoAq/v
	PdbwNGBEJZ8P2rz/ThE5OTIgzsp1/1tKnk8W8x1X6kX+/uyI41fXQZ4tS0Wvfks+mXgkSQ+lk/8EJ
	aTyLG4AfP7Cqkdxi4AvuQVWFkhqnWAbCkD+6Oc0/ec3aBP5n8wNn8gzLfM6Jlep4g1a0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r6CKs-0010hr-Qn; Thu, 23 Nov 2023 17:13:50 +0100
Date: Thu, 23 Nov 2023 17:13:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Tim Harvey <tharvey@gateworks.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC] net: dsa: mv88e6xxx: Support LED control
Message-ID: <c8c821f8-e170-44b3-a3f9-207cf7cb70e2@lunn.ch>
References: <20231123-mv88e6xxx-leds-v1-1-3c379b3d23fb@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123-mv88e6xxx-leds-v1-1-3c379b3d23fb@linaro.org>

> This DT config is not yet configuring everything: the netdev
> default trigger is assigned by the hw acceleration callbacks are
> not called, and there is no way to set the netdev sub-trigger
> type from the device tree, such as if you want a gigabit link
> indicator. This has to be done from userspace at this point.

Yes, part of this is a known problem, and somewhere i have some code i
was working on to fix some of these issues.

What i would really like to see happen is that the DSA core handles
the registration of the LEDs, similar to how phylib does. The DT
binding should be identical for all DSA devices, so there is no need
for each driver to do its own parsing.

There are some WIP patches at

https://github.com/lunn/linux.git leds-offload-support-reduced-auto-netdev

which implement this. Feel free to make use of them.

> +/* The following is a lookup table to check what rules we can support on a
> + * certain LED given restrictions such as that some rules only work with fiber
> + * (SFP) connections and some blink on activity by default.
> + */
> +#define MV88E6XXX_PORTS_0_3 (BIT(0)|BIT(1)|BIT(2)|BIT(3))
> +#define MV88E6XXX_PORTS_4_5 (BIT(4)|BIT(5))
> +#define MV88E6XXX_PORT_4 BIT(4)
> +#define MV88E6XXX_PORT_5 BIT(5)
> +
> +/* Entries are listed in selector order */
> +static const struct mv88e6xxx_led_hwconfig mv88e6xxx_led_hwconfigs[] = {

You need to be careful with naming. These are probably specific to the
6352. Different switches probably have different capabilities. So it
would be good to have the names reflect the switch family they are
valid for.

When we come to add support for other switch families, i wounder how
tables like this scale. Is there some things which can be shared, if
we break the table up? I need to check the data sheets.

	Andrew

