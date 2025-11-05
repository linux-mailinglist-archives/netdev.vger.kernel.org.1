Return-Path: <netdev+bounces-235700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E73DC33D5E
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 04:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D0764E06B7
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 03:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3672472A2;
	Wed,  5 Nov 2025 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="BE2yjzOr"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A939822F76F;
	Wed,  5 Nov 2025 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762312935; cv=none; b=hPrHVTuaJmaWa1j05weBXtPpPxZwgwaNN95ZQqOxeOf6iteZXoMgnzd4Wanb7dI8TdnZiDkNtUHR9ehVb3H+L8G/k85kP8JmnRcsyiQ2Gm4df4l0iHqrjYR2MnxSFtUKMufwnOb3NX0j97Z+FIRkT46KkD4NR9rfPjmhfbNxSdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762312935; c=relaxed/simple;
	bh=NIVLSkVoswp0Q59jrGbjzS751cTeqK3nU6U+yoO998Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nazZh6CvmtxQu2Y+mn9zQAF1Pv2uHJN8tdroRf3r5zRIkR1Ns1EIqDPIyO216lGqjj8zE5lAOhW6uKGgR2Rp6yPQb4VHG8mX3F2apKmbzU57Si93wRbMd3TIyFu5BMtF+7eC1yVEOoZpanjnaxBiEAxLNeJkNWiEF1FPjOmKacU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=BE2yjzOr; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C53B820F60;
	Wed,  5 Nov 2025 04:22:09 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vog58RzXeqHW; Wed,  5 Nov 2025 04:22:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1762312928; bh=NIVLSkVoswp0Q59jrGbjzS751cTeqK3nU6U+yoO998Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BE2yjzOrjrUQZCG3dOAtmTJ/rymCTYqNl6Wpfgu/RtX4wzHLt79VyRQxKlytfC6xb
	 TE5JzuaUzAo7KW6ilhESojA38u19NXUa8NUpqP263jqTR75IWAmjQxBpD77jLF0Xu6
	 hwE0UTm7+hjodLkVUqGfg4YVmBR1kIQnF5a3ekCxID3yXcVI4jcrooS/ZLdDTkJpzv
	 aqQyClLmLi5dIChzdTTpEPYsbcnkx8MWMh5nJ8sEXfAkXdZDeV/1KscwXqyHqrgCJz
	 JPOfp89vpdiJPYZSldkeI+yzcdPrFztLmnQiENvaTLyDcYsPm/6SB5A8kzSv1w6k4+
	 +1Oizz2CpTzKw==
Date: Wed, 5 Nov 2025 03:21:48 +0000
From: Yao Zi <ziyao@disroot.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: loongson: Use generic PCI
 suspend/resume routines
Message-ID: <aQrCzHxAVQW9C1in@pie>
References: <20251104151647.3125-1-ziyao@disroot.org>
 <20251104151647.3125-3-ziyao@disroot.org>
 <aQo2bcdbtVzxXGbR@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQo2bcdbtVzxXGbR@shell.armlinux.org.uk>

On Tue, Nov 04, 2025 at 05:22:53PM +0000, Russell King (Oracle) wrote:
> On Tue, Nov 04, 2025 at 03:16:46PM +0000, Yao Zi wrote:
> > --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > @@ -367,6 +367,8 @@ config DWMAC_INTEL
> >  	  This selects the Intel platform specific bus support for the
> >  	  stmmac driver. This driver is used for Intel Quark/EHL/TGL.
> >  
> > +if STMMAC_LIBPCI
> > +
> >  config DWMAC_LOONGSON
> >  	tristate "Loongson PCI DWMAC support"
> >  	default MACH_LOONGSON64
> 
> As the next line is:
> 
>         depends on (MACH_LOONGSON64 || COMPILE_TEST) && STMMAC_ETH && PCI
> 
> where STMMAC_LIBPCI depends on PCI, and the whole lot is surrounded by
> if STMMAC_ETH ... endif, shouldn't this become:
> 
> 	depends on MACH_LOONGSON64 || COMPILE_TEST
> 
> ?
> 
> Otherwise, looks good, thanks.

I was originally planning to send a separate patch to remove the
redundant depends on STMMAC_ETH, since STMMAC_SELFTESTS,
STMMAC_PLATFORM, DWMAC_INTEL have similar issues. But yes PCI could be
removed from the depends as well with this series applied, so I'm not
sure whether it's better to do the simplication for DWMAC_LOONGSON and
STMMAC_PCI while adding STMMAC_LIBPCI dependency to them, or separate a
patch with a clear topic "removing redundant depends".

I prefer a separate patch to do all the Kconfig clean-up, but am willing
to simplify the depends lines in this series, too if you consider it's
better.

By the way, if I need to send v4 of the series with your proposed
simplification, should I apply your Reviewed-by tag for PATCH 2 and 3?

Thanks,
Yao Zi

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

