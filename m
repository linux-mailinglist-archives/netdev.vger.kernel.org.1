Return-Path: <netdev+bounces-193749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E97AC5B27
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 22:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A36C16B684
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 20:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB8D202C49;
	Tue, 27 May 2025 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qIpw6vAw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6BA14A4C7;
	Tue, 27 May 2025 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748376115; cv=none; b=CudwZhsCmxu8M/zf661a0dBiMox8XWm/iq0NCqjNAdHjwPztoE51eJfxdQ7zPhUW/4S8sTzJCNjgAkzE/dxG58WcF8TpWoZ9bveFP1aLKkXrjMEQz1Dtv1nJZ9T/fmuQQ/V6bTpig+U/pdUSWRN+Xq8vyxi+jKcgmOr/XATGlBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748376115; c=relaxed/simple;
	bh=6adduam8eeRGiOQH0BqLl8J4q9WZUyz7ANkZDXOrmOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLs7XGiUSy9NjBIlMt3FoMMD7KUTvSZ1gpX0v5NDNFLr2eNQka+Bg31VCWxhuB8sxuAZa+egdJPYCPvPr6ZvZam51ccc45saoKrb1S5bk9HX22BSVCyQRVfFNyw8nysELc8YT9fsrsS9CQF9GPOHUdCktQUu5fh34yU0B7gw9Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qIpw6vAw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=G67EhjQhCo6cu8Kcg5RL64M1kKXW79lnaj18VFl/IXk=; b=qI
	pw6vAwpdkVXq5357XLKpGLZl9skBIztPQAM/kmaCnqh49jHwfLSizkZyZ1lEy4q4Mogd5x9oubtOt
	DN0haeRWyI0l3POGdVls78aniiNBgadsB7gE4RpxO8LfKmE9C9yvpkudf4amM5l8OmDcjRnyOynNT
	ETwUMYgF6UBShq8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uK0Ue-00E6bZ-Kq; Tue, 27 May 2025 22:01:48 +0200
Date: Tue, 27 May 2025 22:01:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
Message-ID: <fe8fb314-de99-45c2-b71e-5cedffe590b0@lunn.ch>
References: <20250527175558.2738342-1-james.hilliard1@gmail.com>
 <631ed4fe-f28a-443b-922b-7f41c20f31f3@lunn.ch>
 <CADvTj4rGdb_kHV_gjKTJNkzYEPMzqLcHY_1xw7wy5r-ryqDfNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4rGdb_kHV_gjKTJNkzYEPMzqLcHY_1xw7wy5r-ryqDfNQ@mail.gmail.com>

On Tue, May 27, 2025 at 01:21:21PM -0600, James Hilliard wrote:
> On Tue, May 27, 2025 at 1:14 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Tue, May 27, 2025 at 11:55:54AM -0600, James Hilliard wrote:
> > > Some devices like the Allwinner H616 need the ability to select a phy
> > > in cases where multiple PHY's may be present in a device tree due to
> > > needing the ability to support multiple SoC variants with runtime
> > > PHY selection.
> >
> > I'm not convinced about this yet. As far as i see, it is different
> > variants of the H616. They should have different compatibles, since
> > they are not actually compatible, and you should have different DT
> > descriptions. So you don't need runtime PHY selection.
> 
> Different compatibles for what specifically? I mean the PHY compatibles
> are just the generic "ethernet-phy-ieee802.3-c22" compatibles.

You at least have a different MTD devices, exporting different
clocks/PWM/Reset controllers. That should have different compatibles,
since they are not compatible. You then need phandles to these
different clocks/PWM/Reset controllers, and for one of the PHYs you
need a phandle to the I2C bus, so the PHY driver can do the
initialisation. So i think in the end you know what PHY you have on
the board, so there is no need to do runtime detection.

What you might want however is to validate the MTD device compatible
against the fuse and return -ENODEV if the compatible is wrong for the
fuse.

	Andrew

