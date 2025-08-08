Return-Path: <netdev+bounces-212177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1185B1E955
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD64B7AEA93
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C62F27A900;
	Fri,  8 Aug 2025 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bH6qDtJ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B36219311;
	Fri,  8 Aug 2025 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754660135; cv=none; b=GUN8wlsaE406Luqfauxd2LRW0UFUZXbBs3iITkBu7mo5UlK7IrAsYSKvySZywVRL+tUqzIIMARa0ee+IogT/S8TpPfQq5iVh5/wsHxVRz+8JFHpVgRDX12VrRA4y1j70XwTZpq/USI7E7dQMvh0kJ6wcKfBiaJC8arfvLPtftII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754660135; c=relaxed/simple;
	bh=ZfWjQKHdAa0KMog/nzTcuq2ZRkevpLsG3pLMM/FaYro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUeJe1SdWf79Ygonrfy/fhYW6WhS7AQtQ4X7ZLx1WlywGDkD5sPkNT1LzAB7Mkm7ZhcAEt0k72ZB2r5z37TYsU1cox+tR0mu2bU6efX8SxqiP1K/RBU1dcxqed3bcfb2444ooubNdUvPKJrdmq8IhYomFHQXUNz4O7+E5L/BG6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bH6qDtJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3817C4CEED;
	Fri,  8 Aug 2025 13:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754660133;
	bh=ZfWjQKHdAa0KMog/nzTcuq2ZRkevpLsG3pLMM/FaYro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bH6qDtJ5qCQNvds3hb5UsMuRiaEqE8lJgSUi9qdzymKVup/ZNYjbbhJJZrbKvzRrQ
	 jLQGE3j2UUb9p8SgRKzsindEJvj4QJFXkqxADk/err2cSWsHPZCSSuHXSM1lzbUY71
	 pDQMm2JAVC7n6XNf+YEuOjys2/eTbwD147yXcSgD3SQ51/4yrsjVHEU52mBJleWICL
	 89P3lTIUz4rh628Ys0rYY6hDV1CatrE2OCUv+ZZKypP1cOPShEfSd7gLQ5bTly1Bdz
	 Or5eaKONvidpbueHsoHRk86RD+nq3DkRiWiD/hwGVBgnKG9opPmF4YBQDMfCm2BVQZ
	 ibc2cgKu7lnDw==
Date: Fri, 8 Aug 2025 14:35:28 +0100
From: Simon Horman <horms@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>, nux-riscv@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: thead: Enable TX clock before MAC
 initialization
Message-ID: <20250808133528.GC1705@horms.kernel.org>
References: <20250808103447.63146-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808103447.63146-2-ziyao@disroot.org>

On Fri, Aug 08, 2025 at 10:34:48AM +0000, Yao Zi wrote:
> The clk_tx_i clock must be supplied to the MAC for successful
> initialization. On TH1520 SoC, the clock is provided by an internal
> divider configured through GMAC_PLLCLK_DIV register when using RGMII
> interface. However, currently we don't setup the divider before
> initialization of the MAC, resulting in DMA reset failures if the
> bootloader/firmware doesn't enable the divider,
> 
> [    7.839601] thead-dwmac ffe7060000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> [    7.938338] thead-dwmac ffe7060000.ethernet eth0: PHY [stmmac-0:02] driver [RTL8211F Gigabit Ethernet] (irq=POLL)
> [    8.160746] thead-dwmac ffe7060000.ethernet eth0: Failed to reset the dma
> [    8.170118] thead-dwmac ffe7060000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
> [    8.179384] thead-dwmac ffe7060000.ethernet eth0: __stmmac_open: Hw setup failed
> 
> Let's simply write GMAC_PLLCLK_DIV_EN to GMAC_PLLCLK_DIV to enable the
> divider before MAC initialization. The exact rate doesn't affect MAC's
> initialization according to my test. It's set to the speed required by
> RGMII when the linkspeed is 1Gbps and could be reclocked later after
> link is up if necessary.
> 
> Fixes: 33a1a01e3afa ("net: stmmac: Add glue layer for T-HEAD TH1520 SoC")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
> 
> Note that the DMA reset failures cannot be reproduced with the vendor
> U-Boot, which always enables the divider, regardless whether the port is
> used[1].
> 
> As this scheme (enables the divider first and reclock it later) requires
> access to the APB glue registers, the patch depends on v3 of series
> "Fix broken link with TH1520 GMAC when linkspeed changes"[2] to ensure
> the APB bus clock is ungated.
> 
> [1]: https://github.com/revyos/thead-u-boot/blob/93ff49d9f5bbe7942f727ab93311346173506d27/board/thead/light-c910/light.c#L581-L582
> [2]: https://lore.kernel.org/netdev/20250808093655.48074-2-ziyao@disroot.org/
> 
> Changed from v1
> - Initialize the divisor to a well-known value (producing the clock rate
>   required by RGMII link at 1Gbps)
> - Write zero to GMAC_PLLCLK_DIV before writing the configuration, as
>   required by the TRM

FWIIW, I think it would be worth adding something about writing zero
to the commit message.

> - Link to v1: https://lore.kernel.org/netdev/20250801094507.54011-1-ziyao@disroot.org/
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

...

