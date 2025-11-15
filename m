Return-Path: <netdev+bounces-238848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A37CC6027C
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 10:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38363B9826
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 09:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA7726CE32;
	Sat, 15 Nov 2025 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="byJCoycN"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AE7212564;
	Sat, 15 Nov 2025 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763199502; cv=none; b=PojH+deHtzpD59VJP0YaKgXTydRxHo0z3HH+RHzpygi2uzQLA3RxilZDv7covUDYn/YqtFKzNBHYlZOATKIroeBWFngnalBpPEjtr9gHqHfz3YLQpYXr4nF97aGac6qOdNarm602SEfEeF7KsqRiY2Ks5qDByNI8p7HuTGyx8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763199502; c=relaxed/simple;
	bh=yEJMJKtiQqo0wkwIUG4JLJb3vydmzv9dUD6HE4/ZMU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9yoIcrOSJQwAbJz1FL67R0U0o5AYGloSU5JCmVzU3182swXFbLB9FauvAgu9VZi6T6+Ds3lp9iNKrxM7z9ZQSwRRchnMhKBs0q+0mUZ5riwgsWZGrhGFQ6nHs1gHI7ha04tEEq3ceCTZeIAzvHEU85RzTWX4WkeWkAEPRIndsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=byJCoycN; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E991520B50;
	Sat, 15 Nov 2025 10:38:10 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GsyPnb3sdRiq; Sat, 15 Nov 2025 10:38:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1763199490; bh=yEJMJKtiQqo0wkwIUG4JLJb3vydmzv9dUD6HE4/ZMU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=byJCoycNsg38JFLeCZFoL3XLgbWRd07fTmfSA7R6CR5Ivjo6rM2epZe5JLxR5kPoB
	 mJHyWNAFu87F8mEYXErxAT/0bc8hFulh30bkTcDssWQvKp4IljtIwb6g0lUP8k0Gng
	 CoWKkb0Y0m7c/Kx1817HJ2DgmAh/hoKRz/7/xC34OfFWq5eUKY6y0uHcAT9IowCF+m
	 X0PUXLCrZvHqvHaNGMib3SDDraTGPCav9c4auLEgojOLMzx6f9edNo+4WRmhJX4nKb
	 U3HhM9B6ZheFa/rR6EvO/DRmG6RXFkFO2ugML9STUzj+oxS1OGcAENvB2/V44VNNkn
	 8JLjxLSWVP9Pg==
Date: Sat, 15 Nov 2025 09:37:50 +0000
From: Yao Zi <ziyao@disroot.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
Subject: Re: [PATCH net-next v4 1/3] net: stmmac: Add generic suspend/resume
 helper for PCI-based controllers
Message-ID: <aRhJ7kmYqDsb8iYW@pie>
References: <20251111100727.15560-2-ziyao@disroot.org>
 <20251111100727.15560-3-ziyao@disroot.org>
 <20251112065720.017c4d07@kernel.org>
 <aRSkoTJjVlUC6ZLQ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRSkoTJjVlUC6ZLQ@shell.armlinux.org.uk>

On Wed, Nov 12, 2025 at 03:15:45PM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 12, 2025 at 06:57:20AM -0800, Jakub Kicinski wrote:
> > On Tue, 11 Nov 2025 10:07:26 +0000 Yao Zi wrote:
> > > +config STMMAC_LIBPCI
> > > +	tristate "STMMAC PCI helper library"
> > > +	depends on PCI
> > > +	default y
> > > +	help
> > > +	  This selects the PCI bus helpers for the stmmac driver. If you
> > > +	  have a controller with PCI interface, say Y or M here.
> > 
> > I didn't pay enough attention to the discussion on v2, sorry.
> > I understand that there's precedent for a library symbol hiding
> > real symbols in this driver but it really makes for a poor user
> > experience.
> > 
> > The symbol should be hidden, and select'ed by what needs it.
> > With the PCI dependency on the real symbol, not here.
> > 
> > The "default y" may draw the attention of the Superior Penguin.
> > He may have quite a lot to criticize in this area, so let's
> > not risk it..
> 
> Okay, should we also convert STMMAC_PLATFORM to behave the same way,
> because it's odd to have one bus type acting one way and the other
> differently.

I don't have a strong opinion about the Kconfig style, so should I go
back to make drivers select STMMAC_LIBPCI as suggested by Maxime in
v2[1], and drop the "default y" statement from STMMAC_LIBPCI?

Best regards,
Yao Zi

[1]: https://lore.kernel.org/netdev/da8d9585-d464-4611-98c0-a10d84874297@bootlin.com/

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

