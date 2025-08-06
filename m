Return-Path: <netdev+bounces-211845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1A9B1BDF6
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 02:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B3F627396
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 00:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A0C49620;
	Wed,  6 Aug 2025 00:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kryFOcZB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7DD2E36EC;
	Wed,  6 Aug 2025 00:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754440707; cv=none; b=BrqMIsmGv1yDuSMYZ4mt9DJzr6/sxijFKktuiOTSyNglzDyIkxo7eICUtqpt1cb24iVkqFszd0klbHURBNTSFN5A8G5/dfmiGYrkLPJWPTJJdejRSzfW2Up0/8c9kw9JDzMclPT/KpYumD+SSy2Fhuih3qxuDQkhd6mcjzzDVNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754440707; c=relaxed/simple;
	bh=/aqs0KZ6FiA9Mr/s2FXxWnOaC6qhLwugjGygGdUcBv8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDHTTxZsnM8a8HzEmDz+zvvbSAxMTKdK5hERgMOw28YUp6SnH9ThEth4SgppclI/HV8JtxqXvT2JHag0NjwrXjTDG+vt38GeUtPQ7gE8cBSvGnM5xAIYenI1CJQqZcjqhKTyLumSpt4milNoZJMqqwiG3dILLXMVNDJgO5CJFNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kryFOcZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49706C4CEF0;
	Wed,  6 Aug 2025 00:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754440706;
	bh=/aqs0KZ6FiA9Mr/s2FXxWnOaC6qhLwugjGygGdUcBv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kryFOcZBJqKy5OHKpD0Q05jdr6QruFO2/6YJ39WPTJhPwpXbzqxwIA7jOVqNsw1Tx
	 gKvrb5hqQZazWMuiYZvXq6Qs3ZNLnLj4uxnCto/p/9eTtwrg0g9qmhuTQPJAa9IR6j
	 DQJv7AXoqnflJ628pydCc3izyfEc0EhsO3YWedeJZpkNRcHeYuYWuUY9gNOreUidPC
	 SHbJsLwKKM4NxX3IuzHLrVphdOggwlSVCgxUkAbYWu3deFDnJD1YLUuCcHD4/HKp03
	 dEqG8e+GJTAYaoPckV8Yw4fl0UV1sovOfBV2piWgmzdM08eIYuM7kwNb714BDucqWx
	 WzK9kFNFUGTKw==
Date: Tue, 5 Aug 2025 17:38:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei
 <wefu@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Jisheng Zhang <jszhang@kernel.org>,
 nux-riscv@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: thead: Enable TX clock before MAC
 initialization
Message-ID: <20250805173825.0f70f9cd@kernel.org>
In-Reply-To: <20250801094507.54011-1-ziyao@disroot.org>
References: <20250801094507.54011-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Aug 2025 09:45:07 +0000 Yao Zi wrote:
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
> divider before MAC initialization. The rate doesn't matter, which we
> could reclock properly according to the link speed later after link is
> up.

All the possible DIV values are valid?
I think it's safer to set the DIV to some well known constant, 
just to be on the safe side.

