Return-Path: <netdev+bounces-186043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371C6A9CE24
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 18:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A4B3A2BC3
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 16:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DAD1A256E;
	Fri, 25 Apr 2025 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEsEkjHM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A371A23A0
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598577; cv=none; b=FjDZx9EFt+bJpnaBtQGERmta1kCqe3iyEWsZSKXaziJHeoueKrB2MI9FokOq3ivW7g927uGQbh00ykkUF1U1wkNEtQBqP9T3p7MCzXoX4FKxBuVK6RkzZh+lvM6+S3n255z+0M7ac/gxnBKMfDYlMhwuTTON7+Zv08Bz7C7n6yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598577; c=relaxed/simple;
	bh=q2XfwEn3OLDKtJBVikTeuZ+DQgydYSzNmBTGvqjqRyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+KQV/5BtTYAZEN5hGDlrwwUo7VzaeZtnqboI6DMxOzzxlKaydxhBYH0yFR4KlCXp0Bdz7jfykZwbaNabmO7CvMuZSe9JZEdRnbJVtFVKDu03blS5+3FOrFINsY9PoL4073P/45bW9Qexg6nMWLMVQ4rtPmyVgVBoZVL05xf5a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEsEkjHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC0FC4CEE4;
	Fri, 25 Apr 2025 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745598577;
	bh=q2XfwEn3OLDKtJBVikTeuZ+DQgydYSzNmBTGvqjqRyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEsEkjHMrBFp1ZW46TwLiYDpKJ1oSn2PAsM6gDg9XtqIZqJogr4ui3PEPceA899i8
	 x9qH8H6vsfGmn34gat0lzM4aML0PcFMOss1v3/Ziw6StRKyZktiZW6aidcfz/aPTRY
	 cPiOatuKiT2UU4gm7VBQwB9rMG7Dh6L/ygtwoU1loY6rDhiUseXYX1ycBC8R/Xs8ic
	 w1SWYcCizofQ25dK68EUpNZVS9w/EtIYQhFJHsSbwD1uUN/vyj+01QaavmiPHiqN7y
	 BOPYtZ7ATfCu9garhfW0QYhkWG1KAzx8W0iLVhga5CeBveJPyl1TzYYuhG1YeJe4jr
	 +MnKU+KbQn1/g==
Date: Fri, 25 Apr 2025 18:29:31 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, netdev@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Wojciech Drewek <wojciech.drewek@intel.com>, Matthias Schiffer <mschiffer@universe-factory.net>, 
	Christian Marangi <ansuelsmth@gmail.com>, Marek =?utf-8?B?TW9qw61r?= <marek.mojik@nic.cz>
Subject: Re: [PATCH net] net: dsa: qca8k: forbid management frames access to
 internal PHYs if another device is on the MDIO bus
Message-ID: <eetsgqoq2ztgeo34kvfi732qkpegujwiy5uavpc4jognzy4mrl@owxpxsrvlwhv>
References: <20250425151309.30493-1-kabel@kernel.org>
 <e4603452-efe9-4a56-b33d-4872a19a05b5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4603452-efe9-4a56-b33d-4872a19a05b5@lunn.ch>

On Fri, Apr 25, 2025 at 06:04:43PM +0200, Andrew Lunn wrote:
> On Fri, Apr 25, 2025 at 05:13:09PM +0200, Marek Behún wrote:
> > Completely forbid access to the internal switch PHYs via management
> > frames if there is another MDIO device on the MDIO bus besides the QCA8K
> > switch.
> > 
> > It seems that when internal PHYs are accessed via management frames,
> > internally the switch core translates these requests to MDIO accesses
> > and communicates with the internal PHYs via the MDIO bus. This
> > communication leaks outside on the MDC and MDIO pins. If there is
> > another PHY device connected on the MDIO bus besides the QCA8K switch,
> > and the kernel tries to communicate with the PHY at the same time, the
> > communication gets corrupted.
> > 
> > This makes the WAN PHY break on the Turris 1.x device.
> 
> Let me see if i understand the architecture correctly...
> 
> You have a host MDIO bus, which has both the QCA8K and a PHY on it.
> 
> Within the QCA8K there are a number of PHYs. Looking at qca8k-8xxx.c,
> there is qca8k_mdio_write() and qca8k_mdio_read() which use a register
> within the switch to access an MDIO bus for the internal PHYs. The
> assumption is that the internal MDIO is isolated from the host MDIO
> bus. That should be easy to prove, just read register 2 and 3 from all
> 32 addresses of the host MDIO bus, and make sure you don't find the
> internal PHYs.

I did not think of doing this test to determine whether the buses are
isolated when I debugged this issue and came up with commit
526c8ee04bdbd4d8.

I assumed that the buses are not isolated because I saw activity on the
bus on an oscilloscope when accessing the PHYs over Ethernet frames.

Please look at the commit message of 526c8ee04bdbd4d8
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/dsa/qca?id=526c8ee04bdbd4d8

> The issue is that when you use MDIO over Ethernet frames, both the
> internal and external bus see the bus transaction. This happens
> asynchronously to whatever the host MDIO bus driver is doing, and you
> sometimes get collisions. This in theory should affect both the PHY
> and the switch on the bus, but maybe because of the address being
> accessed, you don't notice any issue with the switch?

Yes, maybe, but also maybe because after the above mentioned commit,
the access to the MDIO bus was locked when accessing over Ethernet
frames. That was how I tried to fix this in 526c8ee04bdbd4d8.

> The assumption is that the switch hardware interpreting the MDIO over
> Ethernet is driving both the internal and external MDIO bus. Again,
> this should be easy to prove, read ID registers 2 and 3 from the
> address the external PHY is on, and see what you get.

I can try this test, but the result will change the need for this
patch.

> I guess the real question here is, has it been proven that there are
> actually two MDIO busses, not one bus with two masters? I could
> theoretically see an architecture where the switch is not managed over
> MDIO at all. It has an EEPROM to do sufficient configuration that you
> can do all the management using Ethernet frames. The MDIO over
> Ethernet then allow you to manage any external PHYs.

From the ASCII art in commit 526c8ee04bdbd4d8 you can clearly see that
I just assumed there is just one MDIO bus, because I saw activity on
an oscilloscope. I didn't test it the way you now suggested. I also
didn't think of the consequences for the driver design and
device-trees. If we prove that there is just one MDIO bus with two
masters instead of two separate buses that leak some noise in some
situations, the situation will become more complicated...

Marek

