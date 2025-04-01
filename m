Return-Path: <netdev+bounces-178512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60991A77687
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D38162E20
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 08:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AC31EA7CF;
	Tue,  1 Apr 2025 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DqUdA8PP"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111C84207F;
	Tue,  1 Apr 2025 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743496442; cv=none; b=I5PHFOASR/TH0w62YZjKxBye9YdEBMIi8GOnI/QpGDd54SuQOxsiqntJriMZSgcvihTen525mGAIGxqwyIjIqd1lnUEHWD6BdBBDHt1SoUPcbcmESGIVQRD138GEr5G5FP2mpCgZ7ceKDCfrwWIK6p6r2+ULS4FeK/pWWANNrck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743496442; c=relaxed/simple;
	bh=jjd/qwJcogchkUMT5P5qmHXx0dw8nM7O1+vT2mc2ZVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llpfm2/AHTnZ92lC3/Zv5CJYQHBkjQzC7iacQ4Yk1jUsHN0te8v2ngqfoKBB0o51gLIJBBl7ifS0HIM68fe1AWuRICZfi/eFKYui3CkBc7JFvbyUmUQ5fvUlxdvyNM2g002YAEVLMx42bjmp+HN6QXhWQDShFgQc43FMKTlhIb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DqUdA8PP; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C25EE432F5;
	Tue,  1 Apr 2025 08:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743496431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJDvWRqiKkcgB0kMKWyCUi7DBbqUbwOCXbFkkoxLk7o=;
	b=DqUdA8PPlAAoXI7Ct3xzJfyqwDeHWWZWjnOwFLV0h6nm8ViInZdwRl49YcfzDQfO0HH71B
	dnJTv+k3itmzkaRutuLUr5Jv2rN9gAkwRihA3C9fNGe553Vw5jwh2FwTwdB0xjF/5whbwP
	+7gpo8w7rq6rOjp4Ge/+c5rwI3tqWgUzT8HJ6Gjcf+VK7UtzRsyeh2Efgi1ms2tZp0omxo
	9tXfYZEwQuQM86qUawV2a9bqq0Iwlh7iN6ESsQoqwSWaHOz9pfndVFMtTVZztvSEZD/5rc
	qjGX6dZjT+fsUTttEadLoexIqjkb04kpnRMa9sI/AXNrdp1Xovaht2IbKyFuqA==
Date: Tue, 1 Apr 2025 10:33:49 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexander H Duyck <alexander.duyck@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v5 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
Message-ID: <20250401103349.102e8092@fedora.home>
In-Reply-To: <44f5c55e5fac60c118cb4d4e99b49e6bf6561295.camel@gmail.com>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
	<20250307173611.129125-10-maxime.chevallier@bootlin.com>
	<8d3a9c9bb76b1c6bc27d2bd01f4831b2cac83f7f.camel@gmail.com>
	<20250328090621.2d0b3665@fedora-2.home>
	<CAKgT0Ue_JzmJAPKBhe6XaMkDCy+YNNg5_5VvzOR6CCbqcaQg3Q@mail.gmail.com>
	<12e3b86d-27aa-420b-8676-97b603abb760@lunn.ch>
	<CAKgT0UcZRi1Eg2PbBnx0pDG_pCSV8tfELinNoJ-WH4g3CJOh2A@mail.gmail.com>
	<02c401a4-d255-4f1b-beaf-51a43cc087c5@lunn.ch>
	<Z-qsnN4umaz0QrG0@shell.armlinux.org.uk>
	<20250331182000.0d94902a@fedora.home>
	<44f5c55e5fac60c118cb4d4e99b49e6bf6561295.camel@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedvfeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtoheprghlvgigrghnuggvrhdrughuhigtkhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrt
 ghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Alexander,

On Mon, 31 Mar 2025 15:31:23 -0700
Alexander H Duyck <alexander.duyck@gmail.com> wrote:

> On Mon, 2025-03-31 at 18:20 +0200, Maxime Chevallier wrote:
> > On Mon, 31 Mar 2025 15:54:20 +0100
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:  
> 
> ...
> 
> > I was hoping Alexander could give option 1 a try, but let me know if
> > you think we should instead adopt option 2, which is probably the safer
> > on.
> > 
> > Maxime  
> 
> So I gave it a try, but the results weren't promising. I ended up
> getting the lp_advertised spammed with all the modes:
> 
>     Link partner advertised link modes:  100000baseKR4/Full
>                                          100000baseSR4/Full
>                                          100000baseCR4/Full
>                                          100000baseLR4_ER4/Full
>                                          100000baseKR2/Full
>                                          100000baseSR2/Full
>                                          100000baseCR2/Full
>                                          100000baseLR2_ER2_FR2/Full
>                                          100000baseDR2/Full
>                                          100000baseKR/Full
>                                          100000baseSR/Full
>                                          100000baseLR_ER_FR/Full
>                                          100000baseCR/Full
>                                          100000baseDR/Full

Thanks for testing, that's the expected outcome for the patch though. Is
that really an issue ? For fixed links, what report is bogus
anyways :/ I guess here as you mentioned, the problem is that you don't
actually have a real fixed link :)

> 
> In order to resolve it I just made the following change:
> @@ -713,9 +700,7 @@ static int phylink_parse_fixedlink(struct phylink
> *pl,
>                 phylink_warn(pl, "fixed link specifies half duplex for
> %dMbps link?\n",
>                              pl->link_config.speed);
>  
> -       linkmode_zero(pl->supported);
> -       phylink_fill_fixedlink_supported(pl->supported);
> -
> +       linkmode_fill(pl->supported);
>         linkmode_copy(pl->link_config.advertising, pl->supported);
>         phylink_validate(pl, pl->supported, &pl->link_config);
> 

So this goes back to the <10G modes reporting multiple modes then ?

> 
> Basically the issue is that I am using the pcs_validate to cleanup my
> link modes. So the code below this point worked correctly for me. The
> only issue was the dropping of the other bits.
> 
> That is why I mentioned the possibility of maybe adding some sort of
> follow-on filter function that would go through the upper bits and or
> them into the filter being run after the original one.
> 
> For example there is mask which is used to filter out everything but
> the pause and autoneg bits. Perhaps we should assemble bits there
> depending on the TP, FIBER, and BACKPLANE bits to clean out everything
> but CR, KR, and TP types if those bits are set.

Yeah but where do we get these TP / Fiber / Backplane bits from ? We
build that list of linkmodes from scratch in that function, only based
on speed/duplex, we don't know anything about the physical medium at
that point.

What you are suggesting is something I'm adding in the phy_port work
actually. You'll be able to say : "This port is a BaseK port" or
"BaseT" or "it may be baseC or baseL or baseS" and there'll be some
filtering based on that, although only in what we report to userspace,
at least for now :)

Maxime

