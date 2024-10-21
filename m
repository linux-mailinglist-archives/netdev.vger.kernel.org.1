Return-Path: <netdev+bounces-137381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 748CE9A5D3B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 09:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46621C21BBA
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 07:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD271E009B;
	Mon, 21 Oct 2024 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nR/GULq/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F31DE4D9;
	Mon, 21 Oct 2024 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496245; cv=none; b=fMTAQuTDWEPTU1lPxLOiPpbXPCtIcRs+VGNJfmV0FjS4YANAokcY7vp82YIBGp5SW0Lj707z86gqi2ObdrG9XWjMFQg1o/UGaEPwx8kHda1uyivL6G0VDyY7fAmjUGmkDI3LB9koa9fAwkptBbJGR93oTSEpIiEpS6mJ41u4NdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496245; c=relaxed/simple;
	bh=2gy3du6vsKAJ+C9iOq3ZQ9oB1KOFdx7EruIwXtjFbKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ph01wnaGQIUxeII6sgr5LBO9ctGEfoCszW7FXHKYs4JATW2ynNB0tZAVq61Tw64eu+TUqp3sdAE9rE/hJQof+5dv3fR2MJoSolXjBG2Phge8zXXxikPar3kpZlSGRqQmaO9jnuSVQ7YsdZLqIACu4ijiiqpMvkspmOq3FIB7pxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nR/GULq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5693BC4CEC3;
	Mon, 21 Oct 2024 07:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729496245;
	bh=2gy3du6vsKAJ+C9iOq3ZQ9oB1KOFdx7EruIwXtjFbKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nR/GULq/+kGrI0Fv7mYTKOVQ46vxfvEI40yJL7e5Y4YTVk114dLmmXRkMfSMvlaCR
	 jm/AZdEUwHMvpq16IG2LtxPx0XPUPadQkx4hs7KFD1dcgtrGAk4KxZNvUtr5G6ATYt
	 IzYlpv6Dx6yHHVfT39ni80lFapHZcVaeqckYZSUjYgudsEzuUAQ0U89Onr3P9z2SY/
	 ZFD2sy/o5pf+DGgj3ZPpqk255+EpxbmExaksbrK0jGq2Zcg4hIrrozf/aO3A0qefT5
	 fuiXwVnEBbZOOOt9kGN9BIFlWjZzP36rs2TeCYlLSgxW18YgdchDgR3AflfX2PcK0q
	 0+y21zYamQkSw==
Date: Mon, 21 Oct 2024 09:37:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Drew Fustini <drew@pdp7.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: Add T-HEAD dwmac
 support
Message-ID: <bv2ao6oxrpbg3hihe6lb66h7bf2d47pg3dcv4c7mrfue26s7br@hsnqynh2ujyj>
References: <20241020-th1520-dwmac-v4-0-c77acd33ccef@tenstorrent.com>
 <20241020-th1520-dwmac-v4-1-c77acd33ccef@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241020-th1520-dwmac-v4-1-c77acd33ccef@tenstorrent.com>

On Sun, Oct 20, 2024 at 07:36:00PM -0700, Drew Fustini wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> Add documentation to describe the DesginWare-based GMAC controllers in
> the T-HEAD TH1520 SoC.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> [drew: rename compatible, add apb registers as second reg of gmac node,
>        add clocks and interrupts poroperties]
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>

...

> +  interrupts:
> +    items:
> +      - description: Combined signal for various interrupt events
> +
> +  interrupt-names:
> +    items:
> +      - const: macirq
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names

I asked to drop these, because referenced schema already requires these.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


