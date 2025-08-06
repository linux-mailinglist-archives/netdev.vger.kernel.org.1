Return-Path: <netdev+bounces-211858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 906DEB1BF1D
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 05:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BFC17AE4F
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 03:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29321DE4EF;
	Wed,  6 Aug 2025 03:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="h05wGF6O"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C3038D;
	Wed,  6 Aug 2025 03:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754450178; cv=none; b=cLxu3SlHDGXRVvZAPPcM8xRKfNazY4b+uPlnWnUdmComqmeII9UfwYEsiHhpxIx9W28HyBuXTuqIY17UdptUgDEu6vsjNkQBkGKzjN0i4hd9Uzb8fksfFKTmGDrERBxVq3knuanfzNmk/JaQ0d8LFBl7C4Nb89VGUVo8alW8/Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754450178; c=relaxed/simple;
	bh=/Lt5w42fF9wMCQs6mfW0Xkukw3A4F+bDrwbejlz3VXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVvLjFnDxABIY1VCJyahHyxRbF4kT49albHV25GVjtBwj+RhK/7Muq83QmNidTLEnDXyzgvJPLsxN4PhT2jY0mUQVvNtj5MdfEensUZQhHjHSSzk3swiTaZpDSiO59265trB/2xePflJoUHXd6e2B76O7qdrYGuokEpEWzA69Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=h05wGF6O; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 57A3520D0B;
	Wed,  6 Aug 2025 05:16:15 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y0YvT30L4neM; Wed,  6 Aug 2025 05:16:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754450174; bh=/Lt5w42fF9wMCQs6mfW0Xkukw3A4F+bDrwbejlz3VXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h05wGF6O5cben5j51nJWkcMh77hcqdsagVPkiDV/zJRmu220SzL6F+fdqCuZqqjxQ
	 XtzEKhUSTIy22bA8wuaZl0DaVgZZXMpCoKRNn26VP6RI0gjF5EpYOMS1zuEKGFLA7G
	 jeeI74GZFF1DCEWFzGT0D5AFS2DIEmtEGqaK6qnXiba19UqbFB+uFr0maM5NJrTX+g
	 SCqX/FHgJAa0m5uGyNhQ9qv5fFvIQG0UCtS6jc2O6a3y23nsmVg98qSOgPqLAMafXK
	 Biw1qd+Wd1FnNXGPMwA1OZHaI0HkXghPMo35d6ZtECtfFR76+N3wmoQENd2hwJD5mo
	 tpq9LPfQoP7yg==
Date: Wed, 6 Aug 2025 03:16:05 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>, nux-riscv@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: thead: Enable TX clock before MAC
 initialization
Message-ID: <aJLI9WCK5kPA1qZ3@pie>
References: <20250801094507.54011-1-ziyao@disroot.org>
 <20250805173825.0f70f9cd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805173825.0f70f9cd@kernel.org>

On Tue, Aug 05, 2025 at 05:38:25PM -0700, Jakub Kicinski wrote:
> On Fri,  1 Aug 2025 09:45:07 +0000 Yao Zi wrote:
> > The clk_tx_i clock must be supplied to the MAC for successful
> > initialization. On TH1520 SoC, the clock is provided by an internal
> > divider configured through GMAC_PLLCLK_DIV register when using RGMII
> > interface. However, currently we don't setup the divider before
> > initialization of the MAC, resulting in DMA reset failures if the
> > bootloader/firmware doesn't enable the divider,
> > 
> > [    7.839601] thead-dwmac ffe7060000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> > [    7.938338] thead-dwmac ffe7060000.ethernet eth0: PHY [stmmac-0:02] driver [RTL8211F Gigabit Ethernet] (irq=POLL)
> > [    8.160746] thead-dwmac ffe7060000.ethernet eth0: Failed to reset the dma
> > [    8.170118] thead-dwmac ffe7060000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
> > [    8.179384] thead-dwmac ffe7060000.ethernet eth0: __stmmac_open: Hw setup failed
> > 
> > Let's simply write GMAC_PLLCLK_DIV_EN to GMAC_PLLCLK_DIV to enable the
> > divider before MAC initialization. The rate doesn't matter, which we
> > could reclock properly according to the link speed later after link is
> > up.
> 
> All the possible DIV values are valid?
> I think it's safer to set the DIV to some well known constant, 
> just to be on the safe side.

Oops, this statement seems misleading. I was going to say "the exact
rate isn't critical for MAC initialization". The patch actually sets
the divider to zero, which works according to my test.

And I realized the divider's behavior isn't well-documented when DIV is
set to zero. Will set the clock to RGMII speed in v2, and adjust the
commit message like

	Let's simply write GMAC_PLLCLK_DIV_EN to GMAC_PLLCLK_DIV to
	enable the divider before MAC initialization. The exact rate
	doesn't affect MAC's initialization according to my test. It's
	set to the speed required by RGMII and could be reclocked
	later after link is up if necessary.

Thanks,
Yao Zi

