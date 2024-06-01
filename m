Return-Path: <netdev+bounces-99911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 616168D6FA6
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 14:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11BD1F22375
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 12:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B9514F9DD;
	Sat,  1 Jun 2024 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUCEfpMz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF80D14F11D;
	Sat,  1 Jun 2024 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717243551; cv=none; b=tePdjFkQ1+stiCDJEWIsHnmnDGkyvJxKcx5TO+kyp1RIQhQRCe0OlwOiYX/4EWBhm8AWnOG+/hqX77akC7Af+bZm4RPo12VfdYoZlXbjcM1W3n0g/5N4QrkLu/AdUu01597DWtT6k+u+G4EEnZ7BTDORZa6YzCQePYQqaIaS0GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717243551; c=relaxed/simple;
	bh=gpmoHDNdcBUdXCxDIsEosMQ7ZR2VEkQU+Y3h+1Gc2Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdwE/do03ylMVkOz8h9wCQsYn+aZH9Sl9UlYMcn8osY2GLGn/769tyeyLerRkGxyqPv36jU7tRmxkF6LqwjdeBuT2xRKf/ZvsdsRkvPaOrZhYoKZCkTVMB6L0XCgEJqUx71r659H1Dr+tUXH0moqRwYptWTVqmT7FUMZHkjt034=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUCEfpMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD5AC116B1;
	Sat,  1 Jun 2024 12:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717243550;
	bh=gpmoHDNdcBUdXCxDIsEosMQ7ZR2VEkQU+Y3h+1Gc2Wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qUCEfpMzmRd6IJpzlNuwa8H3GBtfPJUFkylGL2QCA67KbPBUlFjqiomnHe0WlioMp
	 Axljd74C/sSzzRsXlSAQr9PHkoc0Hue/yseoOf3ZT0JoOO1JWoUl4W4Dh166tQDFyj
	 pEdC7be4YM7Vo1mv+vup7A9vIQOcKL7hLVd9goAarKk7gIHC9AgUnbGs7nj5pe+jUd
	 rEWEjjFLpQG2uOMDb72aaC28MgK3IMJQDkWlITxzcNXIJLiqKyTUERQ4HEVT4FB6Xb
	 S2smLA/TplgTyz1Phw1VIkjXRVCXoFBHMkKL/vtjqa3iN3FF3NQcpO/YcQfDJ/Jr6E
	 txaL0yaQsNM2Q==
Date: Sat, 1 Jun 2024 13:05:45 +0100
From: Simon Horman <horms@kernel.org>
To: Tristram.Ha@microchip.com
Cc: Woojung.Huh@microchip.com, andrew@lunn.ch, vivien.didelot@gmail.com,
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: fix initial port flush problem
Message-ID: <20240601120545.GG491852@kernel.org>
References: <1716932145-3486-1-git-send-email-Tristram.Ha@microchip.com>
 <20240531190234.GT491852@kernel.org>
 <BYAPR11MB35583B3BA16BFB2F78615DBBECFC2@BYAPR11MB3558.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB35583B3BA16BFB2F78615DBBECFC2@BYAPR11MB3558.namprd11.prod.outlook.com>

On Fri, May 31, 2024 at 07:19:54PM +0000, Tristram.Ha@microchip.com wrote:
> > Subject: Re: [PATCH net] net: dsa: microchip: fix initial port flush problem
> > 
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content
> > is safe
> > 
> > On Tue, May 28, 2024 at 02:35:45PM -0700, Tristram.Ha@microchip.com wrote:
> > > From: Tristram Ha <tristram.ha@microchip.com>
> > >
> > > The very first flush in any port will flush all learned addresses in all
> > > ports.  This can be observed by unplugging a cable from one port while
> > > additional ports are connected and dumping the fdb entries.
> > >
> > > This problem is caused by the initially wrong value programmed to the
> > > register.  After the first flush the value is reset back to the normal so
> > > the next port flush will not cause such problem again.
> > 
> > Hi Tristram,
> > 
> > I think it would be worth spelling out why it is correct to:
> > 1. Not set SW_FLUSH_STP_TABLE or SW_FLUSH_MSTP_TABLE; and
> > 2. Preserve the value of the other bits of REG_SW_LUE_CTRL_1
> 
> Setting SW_FLUSH_STP_TABLE and SW_FLUSH_MSTP_TABLE bits are wrong as they
> are action bits.  The bit should be set only when doing an action like
> flushing.

Understood, thanks. And I guess that only bits that are being configured
should be changed, thus the values other bits are preserved with this
change.

FWIIW, I do think it would be worth adding something about this to the
patch description.

> 
> > >
> > > Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
> > > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> > > ---
> > >  drivers/net/dsa/microchip/ksz9477.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/dsa/microchip/ksz9477.c
> > b/drivers/net/dsa/microchip/ksz9477.c
> > > index f8ad7833f5d9..7cc92b90ffea 100644
> > > --- a/drivers/net/dsa/microchip/ksz9477.c
> > > +++ b/drivers/net/dsa/microchip/ksz9477.c
> > > @@ -356,8 +356,7 @@ int ksz9477_reset_switch(struct ksz_device *dev)
> > >
> > >       /* default configuration */
> > >       ksz_read8(dev, REG_SW_LUE_CTRL_1, &data8);
> > > -     data8 = SW_AGING_ENABLE | SW_LINK_AUTO_AGING |
> > > -           SW_SRC_ADDR_FILTER | SW_FLUSH_STP_TABLE | SW_FLUSH_MSTP_TABLE;
> > > +     data8 |= SW_AGING_ENABLE | SW_LINK_AUTO_AGING |
> > SW_SRC_ADDR_FILTER;
> > >       ksz_write8(dev, REG_SW_LUE_CTRL_1, data8);
> > >
> > >       /* disable interrupts */
> > > --
> > > 2.34.1
> > >
> > >
> 

