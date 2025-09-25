Return-Path: <netdev+bounces-226214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F559B9E20A
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8883B8AC1
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDD1277CB8;
	Thu, 25 Sep 2025 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGCoOhvk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426E1277C87;
	Thu, 25 Sep 2025 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790320; cv=none; b=s8yL9yo2qjOKc3dn79y0QRchK/7hHY7HicOoVJLN8ci7l0KtJDrcWNz/yTb0vioDD5WddtsuA/oeHfB/Be9kV98YQ3uoTOjeG0vvcBsvuq5K/V2FROiap9kLQM3L23jeD4XGKfiK8WHvEqasAzBMQ3rDDsVIjkcIhTXFwiZz6hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790320; c=relaxed/simple;
	bh=Sb5siXZd0m8a+/pNxjL8FYTcq7B3D3mf79OVk2WrpZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWv289H0TzgEaMaWUWHKYDm22f2JrqoAZ0bB0xM2DlogjFJoaZtImkIGllq63URepxNOHst8QMlYYsfGpy+rjBwO66SKLw3JqkZ1jbgoEuaWyyS0xO0iqXwntqXRErY85ZN0wzR8d/8YCowWCMgpN7HV5i5PL0obv7sg5vCW4YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGCoOhvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E17C4CEF0;
	Thu, 25 Sep 2025 08:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758790320;
	bh=Sb5siXZd0m8a+/pNxjL8FYTcq7B3D3mf79OVk2WrpZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QGCoOhvk3BACTzTCGGAAJtA1D4V8CWrC0ApGPr8Cckj33xWPRR213Wh/j0z0sG/z9
	 AVafh+Wy2B+MO8t5UUcDd5aoAVoIC5/7nd9dehqkG6x8wvibixzbFw9FFHLEMwrWAj
	 hkOtBBk/K4mrbbuWGwtB6kVY/XvWU8p16GyhuhqT6hkHb8Tadgal0HPr9VZwpZ/05P
	 BUVgvsZCiyu79fKdmfNuZx6jp703121SnBSmbIKjSyA3Cu5boPdTEDN33ZVumyvQ3h
	 vmLbY8Uztb5/RDemzuYYFPsguqENuQg9chX2/UFBTbJ3WX+hWwC2GFiCE+M+3IHrND
	 pFzWvwFSk+1gQ==
Date: Thu, 25 Sep 2025 09:51:54 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Harini Katakam <harini.katakam@xilinx.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: Re: [PATCH net v6 4/5] net: macb: single dma_alloc_coherent() for
 DMA descriptors
Message-ID: <20250925085154.GW836419@horms.kernel.org>
References: <20250923-macb-fixes-v6-0-772d655cdeb6@bootlin.com>
 <20250923-macb-fixes-v6-4-772d655cdeb6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923-macb-fixes-v6-4-772d655cdeb6@bootlin.com>

On Tue, Sep 23, 2025 at 06:00:26PM +0200, Théo Lebrun wrote:
> Move from 2*NUM_QUEUES dma_alloc_coherent() for DMA descriptor rings to
> 2 calls overall.
> 
> Issue is with how all queues share the same register for configuring the
> upper 32-bits of Tx/Rx descriptor rings. Taking Tx, notice how TBQPH
> does *not* depend on the queue index:
> 
> 	#define GEM_TBQP(hw_q)		(0x0440 + ((hw_q) << 2))
> 	#define GEM_TBQPH(hw_q)		(0x04C8)
> 
> 	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
> 	#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> 	if (bp->hw_dma_cap & HW_DMA_CAP_64B)
> 		queue_writel(queue, TBQPH, upper_32_bits(queue->tx_ring_dma));
> 	#endif
> 
> To maximise our chances of getting valid DMA addresses, we do a single
> dma_alloc_coherent() across queues. This improves the odds because
> alloc_pages() guarantees natural alignment. Other codepaths (IOMMU or
> dev/arch dma_map_ops) don't give high enough guarantees
> (even page-aligned isn't enough).
> 
> Two consideration:
> 
>  - dma_alloc_coherent() gives us page alignment. Here we remove this
>    constraint meaning each queue's ring won't be page-aligned anymore.
> 
>  - This can save some tiny amounts of memory. Fewer allocations means
>    (1) less overhead (constant cost per alloc) and (2) less wasted bytes
>    due to alignment constraints.
> 
>    Example for (2): 4 queues, default ring size (512), 64-bit DMA
>    descriptors, 16K pages:
>     - Before: 8 allocs of 8K, each rounded to 16K => 64K wasted.
>     - After:  2 allocs of 32K => 0K wasted.
> 
> Fixes: 02c958dd3446 ("net/macb: add TX multiqueue support for gem")
> Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Tested-by: Nicolas Ferre <nicolas.ferre@microchip.com> # on sam9x75
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Simon Horman <horms@kernel.org>


