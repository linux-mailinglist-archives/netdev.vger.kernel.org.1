Return-Path: <netdev+bounces-234307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A81BDC1F35F
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB411895B4F
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71962F6938;
	Thu, 30 Oct 2025 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="lR5S88n4"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3B733FE27;
	Thu, 30 Oct 2025 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815494; cv=none; b=EBjKR9Fqm84RBp6vtRwOnwRdW4m1c40CkzHJIvf/FVfcrQkCsjz85f8vIMEYWlZX+CnaeJwGPEi70+LzGwNRyQy6YqEJuLYTDZ4gkFqMousCRpJ/ueIGVkIwS2XTmIVj0EYRHJnynTdbg8fC2ngiO5sckY6JgII/3qQ7Q3fSgHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815494; c=relaxed/simple;
	bh=+p7QX+1Fxivh+GGtkO/iA2WDLefIcx8OcOSH8umZaLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsRKTppqiUH93NK52NCOdOCGTp23lU0y5sCWij4hrWxriCMD+sPremyILpBX1pnvgAwsIg2ZU3UErf3bdXH/HtG4TNZRwZc2r82Mrvcfdxte4VhhMEPaEfcjbkqUBq0+/QMCY2U3T6Gfn6GZiWkg7DVOMOQqsA7p/F6wLETZ4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=lR5S88n4; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E8800207A3;
	Thu, 30 Oct 2025 10:11:28 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WTUjHjMOi7IM; Thu, 30 Oct 2025 10:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1761815488; bh=+p7QX+1Fxivh+GGtkO/iA2WDLefIcx8OcOSH8umZaLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lR5S88n4SVMn9pwP5OJfglP4e35ow5RXutjJtiuhzGELA+x1mzsJch7qCdLr4jMzF
	 DCLiWekb3DnTiv6C51Z4rItjfTXVcgTkpm/wbj7qNzdqF6vi68tY5F+lAARe+o6VGp
	 gasGiUlNG2IHp4LiEvCBkLDYRkXaU2Xz1Xaut4Kq2R3OKVnlOA6DzNj0SG+WX1MiGv
	 d4H8TD2ZeAqLukNERlTzbuwY/vtr2LjRedShHMqE7DjXRQ9mtuZa73JxxwyndnU8iY
	 8j7ayGLbXpeSIy6by4RiDKaERkyBBBkQ9KGQPhF2USFR845Ij8w0oA5zKDdjmDABcY
	 TnBGD4lHNgkVA==
Date: Thu, 30 Oct 2025 09:11:00 +0000
From: Yao Zi <ziyao@disroot.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Philipp Stanner <phasta@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: stmmac: loongson: Use generic PCI
 suspend/resume routines
Message-ID: <aQMrpB2jJhh3iDo3@pie>
References: <20251030041916.19905-1-ziyao@disroot.org>
 <20251030041916.19905-3-ziyao@disroot.org>
 <da8d9585-d464-4611-98c0-a10d84874297@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da8d9585-d464-4611-98c0-a10d84874297@bootlin.com>

On Thu, Oct 30, 2025 at 08:38:12AM +0100, Maxime Chevallier wrote:
> Hi,
> 
> On 30/10/2025 05:19, Yao Zi wrote:
> > Convert glue driver for Loongson DWMAC controller to use the generic
> > platform suspend/resume routines for PCI controllers, instead of
> > implementing its own one.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  1 +
> >  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 36 ++-----------------
> >  2 files changed, 4 insertions(+), 33 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > index 598bc56edd8d..4b6911c62e6f 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > @@ -373,6 +373,7 @@ config DWMAC_LOONGSON
> >  	default MACH_LOONGSON64
> >  	depends on (MACH_LOONGSON64 || COMPILE_TEST) && STMMAC_ETH && PCI
> >  	depends on COMMON_CLK
> > +	depends on STMMAC_LIBPCI
> 
> If we go with a dedicated module for this, "select STMMAC_LIBPCI" would
> make more sense here I think. The same applies for the next patch.

Thanks, it's a reasonable point. I worried about possible unmet
dependencies caused by a select, but STMMAC_LIBPCI only depends on PCI
and STMMAC_ETH, which are necessary for DWMAC_LOONGSON and STMMAC_PCI
to show up.

I will change it to "select STMMAC_LIBPCI" in v3.

> Maxime
> 

Best regards,
Yao Zi

