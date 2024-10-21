Return-Path: <netdev+bounces-137447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC6F9A66E4
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 13:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4EB3283744
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9BB1E7C2D;
	Mon, 21 Oct 2024 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPFG2UnD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4EF1E7C24;
	Mon, 21 Oct 2024 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511042; cv=none; b=ORMHHT1aDmMNd2/VazwpSk4dPhgvGYspqx+apVEk4j+BIUNNbU00frWlVXIz74Q9hoNX9aPtVvSTUFyIh3KkkqZOtBNCgqYMHWgctoBaW4UGautCytNz3Wtnr+lul0/mIjm96QJzkB4Y7GuFy/ZEdepIP3kpJAsT9aYihgQjT6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511042; c=relaxed/simple;
	bh=AJ/DqPzoLPYjvF0DStKqvbOtkyW/e+moS4T9f9nXyqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D54RrNHvBFwjftNcJlBMa3Ij0xfpTlHO1rUnS82CStun5rffJaMGh1zXKhQ9puxMU+pcR1PODu5htyWYcBeQSerKgwih54WmFFBlkqWlo+HPMDaYlUz/dIEFhmYyAJ9uzaNWh3PzXbDxankHgOXt+7Ri+brvzb29oVpzeBI0Jk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPFG2UnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AA8C4CEC3;
	Mon, 21 Oct 2024 11:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729511042;
	bh=AJ/DqPzoLPYjvF0DStKqvbOtkyW/e+moS4T9f9nXyqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qPFG2UnDVHfwXTPxm6/dIYV2yc8SrdzSZjAUbW5bfUU9txzgGGCDLhEveKdAqHc+0
	 WfC7DIo7X1e7eisVg7uwKVasVx6+hUkKkSuQXaVpEOTy/FvGJzco3VnSNoTv+92scF
	 WWJgX+rwjhW3AOlhM5b7gtA1pCqvF3KEEGbdSl/steiVuxGqvQrdMP9mbvWm19ezzU
	 j+syt2dsRwW6p3fHyFmxQ+isz8rl6180ifHI2cbt49Yck1ecLQXqEra4QJ6ty695Fc
	 WkaoG2t9iBRyZjxmo2sydyVzk6imdEtruIvB/ceaODruCdKixQ3QGkvpsBSImK8qwq
	 gbhSxRwyxfYow==
Date: Mon, 21 Oct 2024 12:43:54 +0100
From: Simon Horman <horms@kernel.org>
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Drew Fustini <drew@pdp7.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v4 0/3] Add the dwmac driver support for T-HEAD
 TH1520 SoC
Message-ID: <20241021114354.GF402847@kernel.org>
References: <20241020-th1520-dwmac-v4-0-c77acd33ccef@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020-th1520-dwmac-v4-0-c77acd33ccef@tenstorrent.com>

On Sun, Oct 20, 2024 at 07:35:59PM -0700, Drew Fustini wrote:
> This series adds support for dwmac gigabit ethernet in the T-Head TH1520
> RISC-V SoC along with dts patches to enable the ethernet ports on the
> BeagleV Ahead and the LicheePi 4A.
> 
> The pinctrl-th1520 driver, pinctrl binding, and related dts patches are
> in linux-next so there are no longer any prerequisite series that need
> to be applied first.
> 
> Changes in v4:
>  - Rebase on next for pinctrl dependency
>  - Add 'net-next' prefix to subject per maintainer-netdev.rst
>  - Add clocks, clock-names, interrupts and interrupt-names to binding
>  - Simplify driver code by switching from regmap to regualar mmio
> 
> Changes in v3:
>  - Rebase on v6.12-rc1
>  - Remove thead,rx-internal-delay and thead,tx-internal-delay properties
>  - Remove unneeded call to thead_dwmac_fix_speed() during probe
>  - Fix filename for the yaml file in MAINTAINERS patch
>  - Link: https://lore.kernel.org/linux-riscv/20240930-th1520-dwmac-v3-0-ae3e03c225ab@tenstorrent.com/
> 
> Changes in v2:
>  - Drop the first patch as it is no longer needed due to upstream commit
>    d01e0e98de31 ("dt-bindings: net: dwmac: Validate PBL for all IP-cores")
>  - Rename compatible from "thead,th1520-dwmac" to "thead,th1520-gmac"
>  - Add thead,rx-internal-delay and thead,tx-internal-delay properties
>    and check that it does not exceed the maximum value
>  - Convert from stmmac_dvr_probe() to devm_stmmac_pltfr_probe() and
>    delete the .remove_new hook as it is no longer needed
>  - Handle return value of regmap_write() in case it fails
>  - Add phy reset delay properties to the BeagleV Ahead device tree
>  - Link: https://lore.kernel.org/linux-riscv/20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com/
> 
> Changes in v1:
>  - remove thead,gmacapb that references syscon for APB registers
>  - add a second memory region to gmac nodes for the APB registers
>  - Link: https://lore.kernel.org/all/20240713-thead-dwmac-v1-0-81f04480cd31@tenstorrent.com/
> 
> ---
> Emil Renner Berthing (1):
>       riscv: dts: thead: Add TH1520 ethernet nodes
> 
> Jisheng Zhang (2):
>       dt-bindings: net: Add T-HEAD dwmac support
>       net: stmmac: Add glue layer for T-HEAD TH1520 SoC
> 
>  .../devicetree/bindings/net/snps,dwmac.yaml        |   1 +
>  .../devicetree/bindings/net/thead,th1520-gmac.yaml | 115 +++++++++
>  MAINTAINERS                                        |   2 +
>  arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |  91 +++++++
>  .../boot/dts/thead/th1520-lichee-module-4a.dtsi    | 119 +++++++++
>  arch/riscv/boot/dts/thead/th1520.dtsi              |  50 ++++
>  drivers/net/ethernet/stmicro/stmmac/Kconfig        |  10 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile       |   1 +
>  drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  | 268 +++++++++++++++++++++
>  9 files changed, 657 insertions(+)
> ---
> base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
> change-id: 20241020-th1520-dwmac-e14cc8f8427b

Hi Drew, all,

This series is targeted at net-next, but it doesn't apply there.
I'm unsure what the way forwards is, but I expect that at a minimum
the patchset will need to be reposted in some form.

-- 
pw-bot: cr


