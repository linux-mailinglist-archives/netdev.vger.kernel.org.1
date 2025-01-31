Return-Path: <netdev+bounces-161777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4008EA23F03
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 15:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B24227A2121
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 14:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BC71C5485;
	Fri, 31 Jan 2025 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cs/OOv4t"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DCC25761;
	Fri, 31 Jan 2025 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738332969; cv=none; b=O4Fh3i6sbzB5UD/bZzBkBjrsA6gwQM4Uv0lL7rtzr9m3KZIIiusXnBD87nlEn/A/0YqxfSl5TtMXlzhXvuURNAP49Sqs+KjihwT3SW5rUL4T/faTHh9i+yZARgcIe+xyNgClKI6SbJ7Yn0PPYsEMlfzbV7qHRumbv+DNPNr+0bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738332969; c=relaxed/simple;
	bh=MguGDaREPUyfjHAQR3E13sI9sAH/3W0uJMw+qIQdsso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsW6mFJqvuPwjfN2zvHR6OtAWcRysQKyoO05VS4oxqkSugPcLA/1f41nVRrh9kmLZ7tOxm2AqAbsxfxPSq1vHuiiOH++4nJdYdYBkx1UKJHUKL7Mtjay5Ko9Sb41OfZWBlVOEL14cBiSVxfUjeWVmGrbIb8qFMZDMEFrPaifR/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cs/OOv4t; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6KGuy4EAuLHG4r0AND1uGQsHYqV6ULruAexpzmPJXj0=; b=cs/OOv4teDCakZI2PNJHMNZY5F
	CSThPpDFV0qXz+D/8t74/eKu7sLH3JHb0lWt9GptCZKYkRblomsN3tBxQ2ezCc7QZ8ITuLvBv2ELB
	Rl39HYkp2SOoBPdTfUr2haWDYhJDyPZfL0rzyIh88Kt3Jxl4qc24UOTI6XJ+lkFB5moQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tdrnz-009iDb-1e; Fri, 31 Jan 2025 15:15:35 +0100
Date: Fri, 31 Jan 2025 15:15:35 +0100
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
Message-ID: <fc08926d-b9af-428f-8811-4bfe08acc5b7@lunn.ch>
References: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
 <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>
 <07af1102-0fa7-45ad-bcbc-aef0295ceb63@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07af1102-0fa7-45ad-bcbc-aef0295ceb63@arm.com>

On Fri, Jan 31, 2025 at 09:46:41AM +0000, Steven Price wrote:
> On 27/01/2025 01:38, Kunihiko Hayashi wrote:
> > When Tx/Rx FIFO size is not specified in advance, the driver checks if
> > the value is zero and sets the hardware capability value in functions
> > where that value is used.
> > 
> > Consolidate the check and settings into function stmmac_hw_init() and
> > remove redundant other statements.
> > 
> > If FIFO size is zero and the hardware capability also doesn't have upper
> > limit values, return with an error message.
> 
> This patch breaks my Firefly RK3288 board. It appears that all of the 
> following are true:
> 
>  * priv->plat->rx_fifo_size == 0
>  * priv->dma_cap.rx_fifo_size == 0
>  * priv->plat->tx_fifo_size == 0
>  * priv->dma_cap.tx_fifo_size == 0
> 
> Simply removing the "return -ENODEV" lines gets this platform working 
> again (and AFAICT matches the behaviour before this patch was applied).
> I'm not sure whether this points to another bug causing these to 
> all be zero or if this is just an oversight. The below patch gets my 
> board working:

Thanks for the quick report of the problem.

Your 'fix' basically just reverts the patch. Let first try to
understand what is going on, and fix the patch. We can do a revert
later if we cannot find a better solution.

I'm guessing, but in your setup, i assume the value is never written
to a register, hence 0 is O.K. e.g. dwmac1000_dma_operation_mode_rx(),
the fifosz value is used to determine if flow control can be used, but
is otherwise ignored.

We should determine which versions of stmmac actually need values, and
limit the test to those versions.

	Andrew

