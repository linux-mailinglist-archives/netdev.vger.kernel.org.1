Return-Path: <netdev+bounces-175798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F8CA677DC
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537C717E620
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C18E2101AF;
	Tue, 18 Mar 2025 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUoW4tge"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B87320FABC;
	Tue, 18 Mar 2025 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311848; cv=none; b=dKX2nyr8ttPrMyeW7WaMiFG7FJ3PRiBg6ubibQ5bLR0Q7UOUiouqxU5kSnto9gg2M1Pn9y5MVAakRDsHz9W8sYl2tcmp+kfXymWh6HK4bDd9g71BIMBop/AP15z7d6wwTSl2+Qi0EfB/3QFBw6MUWBAhPUSH4NK5S3Dh+nFCU1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311848; c=relaxed/simple;
	bh=HVBz2aT+/RHcd9VZQ6XrEog43pPGxZQceGs8IeJP6oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2lyeSIOmBFI8YJmkufdqXNF2r27xJXut8GcvErvsLfjnSCQQBqEflFHjyzR9cdOO/i8F5K1JpXvO4SjH746Uv0aI6UPs59lHoO2g4FrVa2ZFdwxs4JOMFZJBF7AfgVkRzzlAHV/+wOWZIYga88fbX/LfdHH+gqmvIPGCCdXq34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUoW4tge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0244DC4CEDD;
	Tue, 18 Mar 2025 15:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742311848;
	bh=HVBz2aT+/RHcd9VZQ6XrEog43pPGxZQceGs8IeJP6oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUoW4tgeJI1qkqHA8wzUVgYQSoY+aOz8Q2mvlmnDsT5jlUIWvVvsDrwcAh+mvdJcm
	 FchVJjLo9kTuxGacsk79c7OAUx7NJO7BGusb58YMjDYBAaFqR3a5jariprgb4DkfTH
	 Y4Abf0av5IvwjG3TkwPUayTU/4+zYb3JUSs5x20FqUwAe5P9ifDprpWqiqeJZING8T
	 NT1bfAo3ZBnaTXUfdUFYE/P3Q4koEGvV4PrKANZ4bk+PMB93RQTfbHOAf5evdgKIqy
	 t/cBbkemhscPWWaViv47JUZikUvLqPE6HgfRL4/G5oymAbGbo3Hlvc93ImhCmfDcKF
	 iWkA4ztEDM2fA==
Date: Tue, 18 Mar 2025 15:30:43 +0000
From: Simon Horman <horms@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Wu <david.wu@rock-chips.com>, Yao Zi <ziyao@disroot.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] net: stmmac: dwmac-rk: Add GMAC support for RK3528
Message-ID: <20250318153043.GE688833@kernel.org>
References: <20250309232622.1498084-1-jonas@kwiboo.se>
 <20250317194309.GL688833@kernel.org>
 <db3bf1cb-3385-4676-8ba4-41fea0212bf2@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db3bf1cb-3385-4676-8ba4-41fea0212bf2@kwiboo.se>

On Mon, Mar 17, 2025 at 08:50:34PM +0100, Jonas Karlman wrote:
> Hi Simon,
> 
> On 2025-03-17 20:43, Simon Horman wrote:
> > On Sun, Mar 09, 2025 at 11:26:10PM +0000, Jonas Karlman wrote:
> >> The Rockchip RK3528 has two Ethernet controllers, one 100/10 MAC to be
> >> used with the integrated PHY and a second 1000/100/10 MAC to be used
> >> with an external Ethernet PHY.
> >>
> >> This series add initial support for the Ethernet controllers found in
> >> RK3528 and initial support to power up/down the integrated PHY.
> >>
> >> This series depends on v2 of the "net: stmmac: dwmac-rk: Validate GRF
> >> and peripheral GRF during probe" [1] cleanup series.
> >>
> >>
> >> Changes in v2:
> >> - Restrict the minItems: 4 change to rockchip,rk3528-gmac
> >> - Add initial support to power up/down the integrated PHY in RK3528
> >> - Split device tree changes into a separate series
> >>
> >> [1] https://lore.kernel.org/r/20250308213720.2517944-1-jonas@kwiboo.se/
> > 
> > Hi Jonas,
> > 
> > This patchset looks reasonable to me. However it will need
> > to be reposted once it's dependencies ([1]) are present in net-next.
> 
> The dependent series ([1]) has already been merged into net-next [2].

Thanks, and sorry for not noticing that.

> Do I still need to repost this series?

Yes, I think that would be best so there is a CI run over the series
(the CI doesn't understand dependencies).

> [2] https://lore.kernel.org/r/174186063226.1446759.12026198009173732573.git-patchwork-notify@kernel.org/
> 
> > 
> > And on the topic of process:
> > 
> > * As this is a patch-set for net-next it would be best to
> >   target it accordingly:
> > 
> >   Subject: [PATCH net-next] ...
> > 
> > * Please post patches for net/net-next which have dependencies as RFCs.
> > 
> > For more information on Netdev processes please take a look at
> > https://docs.kernel.org/process/maintainer-netdev.html
> > 
> 
> Thanks, I see, netdev seem to use a slight different process than what
> I am familiar with compared to other Linux subsystems and U-Boot :-)
> 
> Regards,
> Jonas
> 

