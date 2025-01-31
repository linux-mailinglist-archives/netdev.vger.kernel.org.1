Return-Path: <netdev+bounces-161787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4407A23FAD
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 16:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D36B1887AFC
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C5D1CB9E2;
	Fri, 31 Jan 2025 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TY4DQdnn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D718467;
	Fri, 31 Jan 2025 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738337422; cv=none; b=FICJxMqo2GAAIOVifrwaWX3RrNdXfnynZ4RzAR77aHhVxUq456vBuzbdC7N3kfqGiaBz1FoV+p6eQhhWB403bR03s4GiVMNDfuspffOdI8WEq6jow2SHnVWDTc7g0zwjaN6qrNebA/BUbevarfG/F86xUiVbO2Xvrwj9YrK57oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738337422; c=relaxed/simple;
	bh=BJkAqQqySuQeiWwU8uJ1H711SOFSLwM8M/BynHk7CDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDlLiLxC9mv5qPdwkLfSaz+Kh87aSnDKZN41VHpgbvOey8GJ/mOvZXsh8kRYJfCJ0EmefV0gjXS0ArtqoAJ2FoC6dVHYSOnuu3ahBGdf5yTOr8dmY/NDyTVwPJ65Q3YLkmUJ6Swa6rDxAswzWm6Flgb8Ji+voW5Ma5zoY/ofqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TY4DQdnn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N1KV8cAYAeUsEmP5FSI2GVwcvfBNoyMVKI/OP/TsMh8=; b=TY4DQdnn8BJ2u6ngBxO25+KLaf
	4ykBv2v07Rolai551D/VQOGqrl0WPBg22TEkQkLdU2Sq+v2SRcl4lw6gy7GmKkHb6m+zZ38Acm0xr
	MgipqQvRFSlPvkH9ArY3g43N1Tn32o2gIS0mScTeVUg7WTI+8cqUGfJB7Ncq0gN3RReE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tdsxz-009j7y-Au; Fri, 31 Jan 2025 16:29:59 +0100
Date: Fri, 31 Jan 2025 16:29:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Steven Price <steven.price@arm.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yanteng Si <si.yanteng@linux.dev>, Furong Xu <0x1207@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 3/3] net: stmmac: Specify hardware capability
 value when FIFO size isn't specified
Message-ID: <2ed9e7c7-e760-409e-a431-823bc3f21cb7@lunn.ch>
References: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
 <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>
 <07af1102-0fa7-45ad-bcbc-aef0295ceb63@arm.com>
 <fc08926d-b9af-428f-8811-4bfe08acc5b7@lunn.ch>
 <f343c126-fed9-4209-a18d-61a4e604db2f@arm.com>
 <a4e31542-3534-4856-a90f-e47960ed0907@lunn.ch>
 <d6265f8e-51bc-4556-9ecb-bfb73f86260d@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6265f8e-51bc-4556-9ecb-bfb73f86260d@arm.com>

On Fri, Jan 31, 2025 at 03:03:11PM +0000, Steven Price wrote:
> On 31/01/2025 14:47, Andrew Lunn wrote:
> >>> I'm guessing, but in your setup, i assume the value is never written
> >>> to a register, hence 0 is O.K. e.g. dwmac1000_dma_operation_mode_rx(),
> >>> the fifosz value is used to determine if flow control can be used, but
> >>> is otherwise ignored.
> >>
> >> I haven't traced the code, but that fits my assumptions too.
> > 
> > I could probably figure it out using code review, but do you know
> > which set of DMA operations your hardware uses? A quick look at
> > dwmac-rk.c i see:
> > 
> >         /* If the stmmac is not already selected as gmac4,
> >          * then make sure we fallback to gmac.
> >          */
> >         if (!plat_dat->has_gmac4)
> >                 plat_dat->has_gmac = true;
> 
> has_gmac4 is false on this board, so has_gmac will be set to true here.

Thanks. Looking in hwif.c, that means dwmac1000_dma_ops are used.

dwmac1000_dma_operation_mode_rx() just does a check:

	if (rxfifosz < 4096) {
		csr6 &= ~DMA_CONTROL_EFC;

but otherwise does not use the value.

dwmac1000_dma_operation_mode_tx() appears to completely ignore fifosz.

So i would say all zero is valid for has_gmac == true, but you might
gain flow control if a value was passed.

A quick look at dwmac100_dma_operation_mode_tx() suggests fifosz is
also ignored, and dwmac100_dma_operation_mode_rx() does not exist. So
all 0 is also valid for gmac == false, gmac4 == false, and xgmac ==
false.

dwmac4_dma_rx_chan_op_mode() does use the value to determine mtl_rx_op
which gets written to a register. So gmac4 == true looks to need
values. dwxgmac2_dma_rx_mode() is the same, so xgmac = true also need
valid values.

Could you cook up a fix based on this?

	Andrew

