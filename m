Return-Path: <netdev+bounces-226211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B86B9E1E0
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D421B22FD0
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD212777E4;
	Thu, 25 Sep 2025 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGca+M+z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3285D27602F;
	Thu, 25 Sep 2025 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790149; cv=none; b=cvNyKBddncg6EulcN5BLcukHKxBPZQGqlHSIovFYatZ6g4MUT+EReRnGqFY70zCTFnBre3NH46vo5U7qPC9A27FwVka8CK/sgs+lZ+BENc6aw3fIoVhSb94aRKGwIkcDpKsVRAa87NmtCReSw8vuiQjpDmPAnW3KO8EOtIyPHLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790149; c=relaxed/simple;
	bh=0XH/pbAoB1UZ8lXsLizsKNsDE/zUUc1t111qHGiFtEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/Qxhhl4ui5LC6Y2D6vtbwXoiiiD2+IY38oKauWTCVxuZw27U13dX3BIGaxfpR67MUv37sLR2y1a0HFhi/QxR5HBOaaw2UOsHNSPF5i5Ozdxr3ln76h+8lmEN1draNaAN61+tGPqx962X3iRbvvH34s97pndbIIvqZnTepsVcjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGca+M+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB52C4CEF7;
	Thu, 25 Sep 2025 08:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758790148;
	bh=0XH/pbAoB1UZ8lXsLizsKNsDE/zUUc1t111qHGiFtEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fGca+M+zLI3Rj1FCEQEf9+xig+b9wSiYTb9kblIFviEQsbu9PacUl/lRtI+BFugfx
	 HRralzrel7s7hT0vUbGe+0+bjCi25oI3PPD5246xGevCG80urf74T093GP+FcZ4xTQ
	 LwOmS7GqqTEYkL67hK+v6p3a0COt6GJU7IsKglZGCq+s4dF+wB9FpsWQ3wnmexjU7K
	 Rlse/A/ZBkzJCxk/XWRhvKzQQ/Ot416iSir41NKR/e9M5AfU25JcSC9YgdmPAQrLGh
	 fwpDUukHPDM3dxuHDn+q2Jr9dfZf1iL9vmihHvCYZ0tpGRifwQfU06ofnqx2yGeQUA
	 j0DEPmTprmJmA==
Date: Thu, 25 Sep 2025 09:49:02 +0100
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
Subject: Re: [PATCH net v6 2/5] net: macb: remove illusion about TBQPH/RBQPH
 being per-queue
Message-ID: <20250925084902.GU836419@horms.kernel.org>
References: <20250923-macb-fixes-v6-0-772d655cdeb6@bootlin.com>
 <20250923-macb-fixes-v6-2-772d655cdeb6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923-macb-fixes-v6-2-772d655cdeb6@bootlin.com>

On Tue, Sep 23, 2025 at 06:00:24PM +0200, Théo Lebrun wrote:
> The MACB driver acts as if TBQPH/RBQPH are configurable on a per queue
> basis; this is a lie. A single register configures the upper 32 bits of
> each DMA descriptor buffers for all queues.
> 
> Concrete actions:
> 
>  - Drop GEM_TBQPH/GEM_RBQPH macros which have a queue index argument.
>    Only use MACB_TBQPH/MACB_RBQPH constants.
> 
>  - Drop struct macb_queue->TBQPH/RBQPH fields.
> 
>  - In macb_init_buffers(): do a single write to TBQPH and RBQPH for all
>    queues instead of a write per queue.
> 
>  - In macb_tx_error_task(): drop the write to TBQPH.
> 
>  - In macb_alloc_consistent(): if allocations give different upper
>    32-bits, fail. Previously, it would have lead to silent memory
>    corruption as queues would have used the upper 32 bits of the alloc
>    from queue 0 and their own low 32 bits.
> 
>  - In macb_suspend(): if we use the tie off descriptor for suspend, do
>    the write once for all queues instead of once per queue.
> 
> Fixes: fff8019a08b6 ("net: macb: Add 64 bit addressing support for GEM")
> Fixes: ae1f2a56d273 ("net: macb: Added support for many RX queues")
> Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Simon Horman <horms@kernel.org>


