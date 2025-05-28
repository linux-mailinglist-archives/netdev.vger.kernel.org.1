Return-Path: <netdev+bounces-194061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAA0AC72C1
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 23:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7CD87A3DDE
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 21:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEED22127B;
	Wed, 28 May 2025 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vhDUvgUG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115F8FC0E;
	Wed, 28 May 2025 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748467774; cv=none; b=SWxKsr8Q3LVGAU8E7RXahbB8cjk6vIGdGhM8lw4r0hYwIwQFw0HnHzIenKcb2UuLF3bs5KSKN4ra/QCdTU69fsUdGQO+E//ou+N+nwmoUi3at2tOC6PLTBGwRxm86qnVzVGlCEo1GZRdspUJ65k8JD+NvMf5g4Nnh8x6EYwYTFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748467774; c=relaxed/simple;
	bh=+csyfRfLKfVDp779T8twfY6MfWfPiMBG57yrDSeNapo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hI/vRmKKVFFFXUeSg7qncJITsl5CH8FjJIp1faJqjelvdbgJ6hyDjsEkLD4WXvT0K+HxuuvVlVTZ70KeYjClOuu1HXa8MquQkmU19Lx+jZFuCD6yAOe/wlOSP7AHYUbvm3xFcgn696uGAsaQ1t+CNTsIJ+pgNLPrJHbrjcfzSe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vhDUvgUG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=smRHoEj0Twx20AA+nj0Da054TRsu20UDIY5yl86Aq4A=; b=vhDUvgUGKpHJX8MckMn6K1pZFi
	0eYhyiinOgak6BcAx1TuEKdJQwOLiPTnCiQ4g4tOS+ZFMlJUSlnTNG2yFMIWzcr6mYVE+gVUKqf7w
	cJgzrSGB8ykanu5921ZUAnmygqK2uZwN8GdwhGo3gq0nH1nP8NGuKD2upm36Hwyw17+0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uKOKx-00ED7B-69; Wed, 28 May 2025 23:29:23 +0200
Date: Wed, 28 May 2025 23:29:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, wens@csie.org,
	netdev@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
Message-ID: <0bf48878-a3d0-455c-9110-5c67d29073c9@lunn.ch>
References: <CADvTj4qP_enKCG-xpNG44ddMOJj42c+yiuMjV_N9LPJPMJqyOg@mail.gmail.com>
 <f915a0ca-35c9-4a95-8274-8215a9a3e8f5@lunn.ch>
 <CAGb2v66PEA4OJxs2rHrYFAxx8bw4zab7TUXQr+DM-+ERBO-UyQ@mail.gmail.com>
 <CADvTj4qyRRCSnvvYHLvTq73P0YOjqZ=Z7kyjPMm206ezMePTpQ@mail.gmail.com>
 <aDdXRPD2NpiZMsfZ@shell.armlinux.org.uk>
 <CADvTj4pKsAYsm6pm0sgZgQ+AxriXH5_DLmF30g8rFd0FewGG6w@mail.gmail.com>
 <8306dac8-3a0e-4e79-938a-10e9ee38e325@lunn.ch>
 <CADvTj4rWvEaFyOm2HdNonASE4y1qoPoNgP_9n_ZbLCqAo1gGYw@mail.gmail.com>
 <1e6e4a44-9d2b-4af4-8635-150ccc410c22@lunn.ch>
 <CADvTj4r1VvjiK4tj3tiHYVJtLDWtMSJ3GFQgYyteTnLGsQQ2Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvTj4r1VvjiK4tj3tiHYVJtLDWtMSJ3GFQgYyteTnLGsQQ2Eg@mail.gmail.com>

> > Describe the one PHY which actually exists in device tree for the
> > board, and point to it using phy-handle. No runtime detection, just
> > correctly describe the hardware.
> 
> But the boards randomly contain SoC's with different PHY's so we
> have to support both variants.

You have two .dts files, resulting in two .dtb files, which are 95%
identical, but import a different .dtsi file for the PHY.

You can test if the correct .dtb blob is used by checking the fuse. If
it is wrong, you can give a hint what .dtb should be used.

Or, as Russell suggested, you give the bootloader both .dtb blobs, and
it can pick the correct one to pass to the kernel. Or the bootloader
can patch the .dtb blob to make it fit the hardware.

> > Do you have examples of boards where the SoC variant changed during
> > the boards production life?
> 
> Yes, the boards I'm working for example, but this is likely an issue for
> other boards as well(vendor BSP auto detects PHY variants):
> https://www.zeusbtc.com/ASIC-Miner-Repair/Parts-Tools-Details.asp?ID=1139

Mainline generally does not care what vendors do, because they often
do horrible things. Which is O.K, it is open source, they can do what
they want in their fork of the kernel.

But for Mainline, we expect a high level of quality, and a uniform way
of doing things.

This can also act as push back on SoC vendors, for doing silly things
like changing the PHY within a SoC without changing its name/number.

	Andrew

