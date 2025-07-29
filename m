Return-Path: <netdev+bounces-210857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E516CB15221
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 19:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2458A3BA659
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DC322ACEF;
	Tue, 29 Jul 2025 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eabzNBFb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B6B23DE;
	Tue, 29 Jul 2025 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753810449; cv=none; b=JIETLE5QhfwsyABMsREfJec/l8hFALBbEM4TCbU/1CH66JszEklWT56fxSrdevT3ArftEYdjUQURzlBFCVuXVm4fJCOCLKgFL4M0w1q9Fx81eSHicw0sojQ27hVANZDgHr20eR75i8C/0qVA2zG99WXnK2q8uSr23aS3Oo6wLmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753810449; c=relaxed/simple;
	bh=gqjJxvrbJzU+Y1NaVhsDYvQYmRoqY8d4rd0tdxvq+Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eakSyGE9z6MkG0gQ6NLc1peEB9jxmkIXZ0WSSxeupP/3QvmFcw0JfIisCzSOGBuQY0/Wk0U0BmrJ/lSsq/NJio0f93kABNiEU0mNxtn+32x97Z8Z6s4o1mtGLgDCRUVUg7hV+XGWo3u2wahHXY0pb7gzworRt4Fe2ka6z6d5KfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eabzNBFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAE0C4CEEF;
	Tue, 29 Jul 2025 17:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753810449;
	bh=gqjJxvrbJzU+Y1NaVhsDYvQYmRoqY8d4rd0tdxvq+Yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eabzNBFbEPWmcOna09473itgkl4JYClURyCLK83NCanQbjgmk90/+qQJY4Atgytqj
	 rYUAH1qzzNHxQd1yjgU2/kCgl6TPIO0Wi6V37MaKbNVUOxy/qtS4t1CB9eIOH0oS4+
	 th0zFV34hG1n34QcTIOpj8/6/RppgfpxA9iciNRgDIeuFbjPW3LDT8Owui3zZXUiGi
	 OuCfrzJ5zARMJfLQaie8aapd8hyBFJwp0TwOqaXm8sPlGpioGvKPZ6kOfwOJxDEW+Q
	 agWpZZCjjMuS6hAMoOB2K03GV5vtXoQaE6RvdFwuB7KakvFjH9jFdBp8R7hMj5DJIz
	 0fdzZucjTtp4w==
Date: Tue, 29 Jul 2025 10:34:07 -0700
From: Drew Fustini <fustini@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/3] Fix broken link with TH1520 GMAC when linkspeed
 changes
Message-ID: <aIkGDxstQ9Eimw4p@x1>
References: <20250729093734.40132-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729093734.40132-1-ziyao@disroot.org>

On Tue, Jul 29, 2025 at 09:37:31AM +0000, Yao Zi wrote:
> It's noted that on TH1520 SoC, the GMAC's link becomes broken after
> the link speed is changed (for example, running ethtool -s eth0 speed
> 100 on the peer when negotiated to 1Gbps), but the GMAC could function
> normally if the speed is brought back to the initial.
> 
> Just like many other SoCs utilizing STMMAC IP, we need to adjust the TX
> clock supplying TH1520's GMAC through some SoC-specific glue registers
> when linkspeed changes. But it's found that after the full kernel
> startup, reading from them results in garbage and writing to them makes
> no effect, which is the cause of broken link.
> 
> Further testing shows perisys-apb4-hclk must be ungated for normal
> access to Th1520 GMAC APB glue registers, which is neither described in
> dt-binding nor acquired by the driver.
> 
> This series expands the dt-binding of TH1520's GMAC to allow an extra
> "APB glue registers interface clock", instructs the driver to acquire
> and enable the clock, and finally supplies CLK_PERISYS_APB4_HCLK for
> TH1520's GMACs in SoC devicetree.
> 
> Yao Zi (3):
>   dt-bindings: net: thead,th1520-gmac: Describe APB interface clock
>   net: stmmac: thead: Get and enable APB clock on initialization
>   riscv: dts: thead: Add APB clocks for TH1520 GMACs
> 
>  .../devicetree/bindings/net/thead,th1520-gmac.yaml     |  8 ++++++--
>  arch/riscv/boot/dts/thead/th1520.dtsi                  | 10 ++++++----
>  drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c      |  6 ++++++
>  3 files changed, 18 insertions(+), 6 deletions(-)
> 
> -- 
> 2.50.1
> 

Thanks for fixing this issue. I've tested this series on next-20250729
with my LPi4a. I'm able to change the speed from 1000 to 100 and back to
1000. The network continues to work without any problems through those
transistions.

Tested-by: Drew Fustini <fustini@kernel.org>

