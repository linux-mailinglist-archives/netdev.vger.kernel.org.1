Return-Path: <netdev+bounces-210401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FA0B13196
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 21:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E967E175C5E
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 19:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30454226861;
	Sun, 27 Jul 2025 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xg02+3AN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CDD21B9FE;
	Sun, 27 Jul 2025 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753646281; cv=none; b=iFmnQRhidZbFxEQbppFr0mzoVm4Dm+wZYxXRbqdGpz3BMHjfkc+ru+RAj+vinIdb6rQKQ8kLEtb2DRPE23qN4Vsz+1UZV43AbNC8TqQL0N7wxzx9Tq3hUGdEG4NRvfwbETCjT7dZmqvK79W9w413VDYOB+dtkWuDZrWQmm0qXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753646281; c=relaxed/simple;
	bh=bTV1Ce2wHOqMu2kVymsIX8SlLEnb1OxCNKqezUt3EWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jT1ZoY8XBH++TpwZDXfumhvHq/L9FTNhQWYE8joFy3venrWvV5qJz7jNeJsEMDvCL5IH7HT9I0sQ9/yAvwy1eWP4kLX7hFD7cAoRMYayJFGHWJP2kmSbGd4tevqytQzrvmNO66alvehfuIuX1jft58qoAYZZV2vh6tTOW57gY7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xg02+3AN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8hEsloU/e5SnX4wmvFRSNKqlkwL0lNp6OodxTTFUtc0=; b=xg02+3ANIpeQD3xeG/u8lRQDRe
	yuSKoIF78ltBcE7+xWkS+XUGpjsCBTSqeQa78LWnwjZuwk52634YJEra0hQAR/sotpxZtyczV8Krp
	pN08ZsKToAcuyA3R+6qutEz/freUUTJEH53k8Qljib7q+oV+z+21zeya99W4XQU64mewL+z2QuZQ2
	4HoMxaKXa0u5qXZQYmfHcgLzfJ2oJYfz4g5PhkWT6QeEGpCvhuw/INYmdhfSUcx/HZtjKUiVlpkjs
	jdgFhGJQYUD2Xqx+yOIb/H9vC4CvnICBwCoxBPeDmsD7YT9xtvcnrgwkgWoTb5mYvJUvFnRbN21o6
	P40lfMMQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34694)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ug7Uy-0007gA-2a;
	Sun, 27 Jul 2025 20:57:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ug7Us-00042L-1o;
	Sun, 27 Jul 2025 20:57:26 +0100
Date: Sun, 27 Jul 2025 20:57:26 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
	netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add RTL8367RB-VB switch to
 Radxa E24C
Message-ID: <aIaEpkZtPt6wqaiL@shell.armlinux.org.uk>
References: <20250727180305.381483-1-jonas@kwiboo.se>
 <20250727180305.381483-4-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727180305.381483-4-jonas@kwiboo.se>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Jul 27, 2025 at 06:03:00PM +0000, Jonas Karlman wrote:
> The Radxa E24C has a Realtek RTL8367RB-VB switch with four usable ports
> and is connected using a fixed-link to GMAC1 on the RK3528 SoC.
> 
> Add an ethernet-switch node to describe the RTL8367RB-VB switch.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Initial testing with iperf3 showed ~930-940 Mbits/sec in one direction
> and only around ~1-2 Mbits/sec in the other direction.
> 
> The RK3528 hardware design guide recommends that timing between TXCLK
> and data is controlled by MAC, and timing between RXCLK and data is
> controlled by PHY.

Assuming RK3528 is the MAC side, then that makes sense - it's basically
suggesting that the _producer_ of the signals should appropriately skew
them.

> Any mix of MAC (rx/tx delay) and switch (rx/tx internal delay) did not
> seem to resolve this speed issue, however dropping snps,tso seems to fix
> that issue.
> 
> Unsure what is best here, should MAC or switch add the delays? Here I
> just followed DT from vendor downstream tree and added rx/tx internal
> delay to switch.

Okay. Heres'a an in-depth explanation, because I think many people need
this for MAC-to-MAC RGMII links. A MAC to PHY link:

	MAC1 ------- PHY1

The PHY mode in the MAC1 description controls the application of delays
at PHY1. This is relatively well undersood. Now, for a MAC to MAC link:

	MAC1 ------- MAC2 in a PHY

Let's say MAC2 is part of a PHY. Okay, so this is quite simple because
it's a PHY on the other end, and thus the situation above applies.

In both these cases, the MAC driver will pass the PHY interface to
phylib, which will in turn pass it to the PHY driver, which is expected
to configure the PHY appropriately.

There is a side-case, where a MAC driver is allowed to configure the
delays at its end _provided_ it then passes PHY_INTERFACE_MODE_RGMII
to phylib (telling the PHY not to add its own delays.)

Now let's look at something that isn't a PHY:

	MAC1 ------- MAC2 in a switch

In this case, MAC2 isn't in a PHY or part of a PHY that is driven by
phylib, so we don't have a way in the kernel of passing the PHY mode
from MAC1 to MAC2 in order for MAC2 to configure itself. It's tempting
to say that which RGMII mode is used doesn't matter, but consider the
side-case above - if we're talking about a MAC driver that interprets
the PHY mode and adds its own delays, then it *does* very much matter.

It also matters for MAC2. This could be a switch port that can be used
as a CPU facing port, or a switch port that is used as a PHY. In the
latter case, it becomes exactly as the first two cases above.

Let's take a theoretical case of two ethernet MACs on the same system
connected with a RGMII link:

	MAC1 ------- MAC2

They both use the same driver. What RGMII interface mode should be used
for each? Would it be correct to state "rgmii-id" for both MACs?
Or "rgmii" for one and "rgmii-id" for the other.

You may notice I'm not providing a solution - this is a thought
experiment, to provoke some thought into the proper use of the phy-mode
property at each end of a MAC to MAC link, and hopefully gain some
realisation that (probably) using "rgmii-id" for both MACs probably
isn't correct given the model that phy-mode _generally_ states how the
opposite end of the RGMII link to the MAC should be configured.

However, currently it doesn't matter as long as we don't end up with
two MACs that are back to back and the MAC drivers decide to insert
the RGMII delay (the side-case I mention above.)

Personally, I don't like that we have this side-case as a possibility
because it causes problems (if you go through the thought experiment
above, you'll trip over the problem if you consider the combinations
of MAC1 and MAC2 that do/do not use the side-case!)

So, I would expect a MAC to MAC link to have "rgmii" at one end, and
"rgmii-id" at the other end, rather than both having the same RGMII
mode.

> Vendor downstream DT also adds 'pause' to the fixed-link nodes, and this
> may be something that should be added here. However, during testing flow
> control always ended up being disabled so I skipped 'pause' here.

Does it get disabled at the switch, or the stmmac end?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

