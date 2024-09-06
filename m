Return-Path: <netdev+bounces-125807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CDE96EB7E
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450381C210EF
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 07:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79B714A4DE;
	Fri,  6 Sep 2024 07:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/S2BrqN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF7B1474CE;
	Fri,  6 Sep 2024 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725606331; cv=none; b=So0hUb6rhDObciuKilsycvVbG2i8of4YzFcN77XDA2YQ4gkPgqFK21CDWMqj8aL5QpDB+DAhnluf1EeU92or16u+DJTaCG6q5Jkmis2lnY5aTD5Ed9rA5dcrD3BJXqNxcTfenTlhXhCRiyNkpRh6aIjNV2CuFdcRNWREwJ46qOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725606331; c=relaxed/simple;
	bh=AScAThAOffqVw8yqskuDOmgtRyO85CMJfzUFPTeIZc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mly/0Y3/RfBrqJr2M4kbkMD/QIEcPGX2veIyxaTre6TKPls99coStTB9g0XyDCNVC0/QBpKvih1XFEyVuOuEX+JLARnmor4rWbNCkpdSr+mGfcqggqV10f7AMdT9aWpjNYVdGjTeljFQs9f/xr0N7igAmmVOvGaYsBckZrO4tKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/S2BrqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993E6C4CEC4;
	Fri,  6 Sep 2024 07:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725606330;
	bh=AScAThAOffqVw8yqskuDOmgtRyO85CMJfzUFPTeIZc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o/S2BrqNKAOZZ41HBke9mXKrYpk4+EX1pO5GWja2c/32z5j5NuZrVelOa40bhXAZc
	 vsHHY351Es7I2WOhhmMJUjyeWOjZHwDUhriGvdSmcvmGzHmDNt5SdCcs/tzJ2F3DMI
	 i2ADYfiz6g0+IZvgcFEq7wyifo+n+zPMyiA9m4xO1z6tmdtXzihaNNpL3SwXJDYaJW
	 qMvdcX0zn8FL8cMtaJByPW9GhZyFj4gAVisJb91ACBqZAkBKOZoOMGkeW7sEo48FkL
	 vn+mFI3M5LBhVyvIXzwJ7f2IIC2wCK/cP3GchcDtZdcJMEShW/ccswvKoea1GswAPr
	 EggZLUQoOJxGA==
Date: Fri, 6 Sep 2024 08:05:25 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Ariane Keller <ariane.keller@tik.ee.ethz.ch>,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH net] net: xilinx: axienet: Fix IRQ coalescing packet
 count overflow
Message-ID: <20240906070525.GK1722938@kernel.org>
References: <20240903180059.4134461-1-sean.anderson@linux.dev>
 <20240904160013.GX4792@kernel.org>
 <a9ad456d-eeff-4fac-a18d-0219fcc9f5ed@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9ad456d-eeff-4fac-a18d-0219fcc9f5ed@linux.dev>

On Thu, Sep 05, 2024 at 10:34:15AM -0400, Sean Anderson wrote:
> On 9/4/24 12:00, Simon Horman wrote:
> > On Tue, Sep 03, 2024 at 02:00:59PM -0400, Sean Anderson wrote:
> >> If coalesce_count is greater than 255 it will not fit in the register and
> >> will overflow. Clamp it to 255 for more-predictable results.
> > 
> > Hi Sean,
> > 
> > Can this occur in practice?
> 
> Yes. Simply do `ethtool -C ethX rx-frames 300` or something similar and
> you will end up with a limit of 44 instead. I ran into this with DIM and
> was wondering why the highest-throughput setting (256) was behaving so
> poorly...

I think it would be nice to include an explanation along those
lines in the patch description.

> 
> >> 
> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> >> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> > 
> > nit: I think it is usual for the order of these tags to be reversed.
> 
> OK
> 
> >> ---
> >> 
> >>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> >> index 9aeb7b9f3ae4..5f27fc1c4375 100644
> >> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> >> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> >> @@ -252,7 +252,8 @@ static u32 axienet_usec_to_timer(struct axienet_local *lp, u32 coalesce_usec)
> >>  static void axienet_dma_start(struct axienet_local *lp)
> >>  {
> >>  	/* Start updating the Rx channel control register */
> >> -	lp->rx_dma_cr = (lp->coalesce_count_rx << XAXIDMA_COALESCE_SHIFT) |
> >> +	lp->rx_dma_cr = (min(lp->coalesce_count_rx, 255) <<
> >> +			 XAXIDMA_COALESCE_SHIFT) |
> >>  			XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
> > 
> > nit: it would be nice to avoid using a naked 255 here.
> >      Perhaps: #define XAXIDMA_COALESCE_MAX 0xff
> 
> OK, but this is the same as the limit used in axienet_usec_to_timer.

Ok, that does muddy the waters a bit.

