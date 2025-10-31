Return-Path: <netdev+bounces-234569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 723F2C233ED
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 05:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A6534E2FCE
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 04:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0BF2BE7AB;
	Fri, 31 Oct 2025 04:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Qx12ZKKA"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85425533D6;
	Fri, 31 Oct 2025 04:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761884667; cv=none; b=mMCk9ZxijiwLNlS+KmMHxSJjw0ID2YzXyWNnFS6pRdNLTtyqqfzbePrVXAETJl6fERMGX5keZ2oDu9VVkB9x/7MrhFY5y9trMI8N7bxNGKSiphNrkLTdJsO0pGbrSRlxLYgx8yAP6nHUTWB+gN8dGUfrnkW7lh7h1WEYVZohVw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761884667; c=relaxed/simple;
	bh=phhFfHeIQ9LSPzEuJb9oDpH8YwXedf0P/DwxhUa9Y0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQP2eIZDBPKHdPr51gK0iTI57qlWf/qkkTMceYFf5CdJsKACiaCiyLj377WaJoQvt6Ixmt/9W7d0Ir6w5z9+mKQxgJKC1XgeBotAF7aY9Vp/a7uUniLmAAYyJm2hSrvQLolZ8s1tHNSYHAC6jWWFO6fXmQ3T9l8kiDzWG7j6riY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Qx12ZKKA; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 00DCA20EAC;
	Fri, 31 Oct 2025 05:24:23 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X_OKwGv9ww-b; Fri, 31 Oct 2025 05:24:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1761884662; bh=phhFfHeIQ9LSPzEuJb9oDpH8YwXedf0P/DwxhUa9Y0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qx12ZKKAwdul2BlFr+hAGuL0eG4qr9h1Vu7KipSd4n0kSw8Pnd+8YMNgVHS5797OY
	 RCiyDx/B7Hz67nZquEk/FlZTiGbiCQ1hvMEJLem8hoIdNBCCPuUGEC+8Hog05GOD6m
	 uy5eKNGt3TzsggF/w9gufhK1yiGQh/hpo2/0GDy6qaWVz9Ew/ZcdutM/OTx51jRyB4
	 Qb9Ac6yAhq5OgJHfETXi/uNN8Wr2hT6tzPQqGjwa6FvjYJNwbZ0wk7VsYxO0TJd53w
	 fDeebxUWOdjipfZjC7O6JbDBIRqRhcsJ5uKqwK6ibneAubfZsuhUAGa9w1TgLc9XlL
	 7fRiOi3VEqR/w==
Date: Fri, 31 Oct 2025 04:24:05 +0000
From: Yao Zi <ziyao@disroot.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: stmmac: loongson: Use generic PCI
 suspend/resume routines
Message-ID: <aQQ55WIdz8USxeug@pie>
References: <20251030041916.19905-1-ziyao@disroot.org>
 <20251030041916.19905-3-ziyao@disroot.org>
 <da8d9585-d464-4611-98c0-a10d84874297@bootlin.com>
 <aQMwO9rJnA6THW3M@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQMwO9rJnA6THW3M@shell.armlinux.org.uk>

On Thu, Oct 30, 2025 at 09:30:35AM +0000, Russell King (Oracle) wrote:
> On Thu, Oct 30, 2025 at 08:38:12AM +0100, Maxime Chevallier wrote:
> > Hi,
> > 
> > On 30/10/2025 05:19, Yao Zi wrote:
> > > Convert glue driver for Loongson DWMAC controller to use the generic
> > > platform suspend/resume routines for PCI controllers, instead of
> > > implementing its own one.
> > > 
> > > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  1 +
> > >  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 36 ++-----------------
> > >  2 files changed, 4 insertions(+), 33 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > > index 598bc56edd8d..4b6911c62e6f 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > > @@ -373,6 +373,7 @@ config DWMAC_LOONGSON
> > >  	default MACH_LOONGSON64
> > >  	depends on (MACH_LOONGSON64 || COMPILE_TEST) && STMMAC_ETH && PCI
> > >  	depends on COMMON_CLK
> > > +	depends on STMMAC_LIBPCI
> > 
> > If we go with a dedicated module for this, "select STMMAC_LIBPCI" would
> > make more sense here I think. The same applies for the next patch.
> 
> Yes, we need it to be this way around at least initially so that
> STMMAC_LIBPCI gets merged into people's configs.
> 
> I'd eventually suggest going the other way.
> 
> We already have:
> 
> config STMMAC_PLATFORM
>         tristate "STMMAC Platform bus support"
> 
> if STMMAC_PLATFORM
> 
> ... platform based drivers ...
> 
> endif
> 
> ... three PCI based drivers ...
> 
> I'd suggest we do:
> 
> config STMMAC_LIBPCI
> 	tristate "STMMAC PCI bus support"
> 	depends on PCI
> 	...
> 
> if STMMAC_LIBPCI
> 
> ... PCI based drivers ...
> 
> endif

Okay, will take this scheme instead.

> There's no need to make everything depend on STMMAC_ETH, there's an
> outer "if STMMAC_ETH" around all the platforms already.

Okay. Yes, this dependency is redundant. Should we remove the
unnecessary depends from other Kconfig options, too? STMMAC_SELFTESTS,
STMMAC_PLATFORM, DWMAC_INTEL_PLAT, DWMAC_INTEL, DWMAC_LOONGSON and
STMMAC_PCI are all enclosed by "if STMMAC_ETH" but carry this redundant
dependency, too.

Regards,
Yao Zi

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

