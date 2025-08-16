Return-Path: <netdev+bounces-214352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6940B290E6
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 01:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C26617AD7DD
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 23:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6C423ABBD;
	Sat, 16 Aug 2025 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcuVuj8i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42583176E2;
	Sat, 16 Aug 2025 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755385588; cv=none; b=auDSBdytVUtzVim1+Ics43tY5MpYuIN0a/kW1i2iIX4ZeMYvMIv7wVy3JB/DdcjBhJZqSdGQKImjWV+UMd3Me3U/88QhHmziogX5qvnRUMi51SYjYxAkAux64+X/idL2BDBQ0Gc5d/BHdfU3YJrDlbhss2MkOLZeS0iioEch1JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755385588; c=relaxed/simple;
	bh=iSKnB2zZ894IV2ruSrlFuVSXiPxFFjRzOOZWUxvj+Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Irt9mSMeGd8jE2ixQuRvKdri3yFWSCGXJCCjsn1N/7MnNRb2cOT2cjAQ0GbZNul2I5mJSDjgetrMetcA+J3zolbtTjT3AeGy41/r6+MhpPhddYsRb4eaOB4IeY91UoRTFD4+idkx1DFTV6eO6uhSH8Imry6c+rLyMoCSHHzzecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcuVuj8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10163C4CEEF;
	Sat, 16 Aug 2025 23:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755385588;
	bh=iSKnB2zZ894IV2ruSrlFuVSXiPxFFjRzOOZWUxvj+Qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RcuVuj8iWC1LOVXruzh1iTw7J1+fVWyGVSFT1uUB+DSeSQ6JtyOLcaot6P/ntJkDS
	 /J3a7ja+Ak4l8PFb3vWIr9UvjcZWLFJjXiIakqp0pXoK9Qx/VuC73hFS7mMHzz+rrX
	 O+rzlI/6N5f8Kf1MgKUAdmSPOI/Mfe1ARUdbpHUmb0FCo9Qfij/LTfST0v2knlSgJy
	 KH8IAYi51toR3PCMqW3lJEkejPvcVNqcbJjXiBumiruuTC/ZQpRubDfP7WKnBO2XuW
	 Q6tWgIt3BrN2ebi/O4FHgZxfTlB92sa7y9vIwgCjGwMiohke7q3vWjVCOs856iGI3p
	 EC0IEhEpvRabg==
Date: Sat, 16 Aug 2025 16:06:26 -0700
From: Drew Fustini <fustini@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>, nux-riscv@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH net v3] net: stmmac: thead: Enable TX clock before MAC
 initialization
Message-ID: <aKEO8gFxUhid/QOX@x1>
References: <20250815104803.55294-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815104803.55294-1-ziyao@disroot.org>

On Fri, Aug 15, 2025 at 10:48:03AM +0000, Yao Zi wrote:
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
> divider before MAC initialization. Note that for reconfiguring the
> divisor, the divider must be disabled first and re-enabled later to make
> sure the new divisor take effect.
> 
> The exact clock rate doesn't affect MAC's initialization according to my
> test. It's set to the speed required by RGMII when the linkspeed is
> 1Gbps and could be reclocked later after link is up if necessary.
> 
> Fixes: 33a1a01e3afa ("net: stmmac: Add glue layer for T-HEAD TH1520 SoC")
> Signed-off-by: Yao Zi <ziyao@disroot.org>

Reviewed-by: Drew Fustini <fustini@kernel.org>

