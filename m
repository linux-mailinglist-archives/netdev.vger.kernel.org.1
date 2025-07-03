Return-Path: <netdev+bounces-203665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6731DAF6B66
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEE63AE99B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 07:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B252129826C;
	Thu,  3 Jul 2025 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU9bRVZV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA7128DB6C;
	Thu,  3 Jul 2025 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751527404; cv=none; b=UMdJVzYDD/FgJdZwkMN/rOgg3MuDZQCWPLJkRHGuSUdhRrpwbuye19vyPWPnAllGxHelrbuKRspzj6ID5Nz0gctygYwKBpwAkr6rUm0ke5glivvUT3ESiqU4hpeQvgWOhvgJDVprFxaDTL6Aa5yTt0UCGB0naayOXjbCSwfB7j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751527404; c=relaxed/simple;
	bh=s5RWJAg4D/dfrnb7YGisPOZh4Cfa5pW76OvfehJpRrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZigGWZ7aVyRxMlmY5JyTY51AvmAmiKUQc35PrkCzPgjp2RRSA2IU58VSTpPR4q3NxygmebHVoJ1yhQ5obH5I8SqWP3a56WQncDfjDMYLB5QbBTQmmEphq6tCdl+Gp8klu6J03BvT8mUc+vADDFWA1REk94c4KzucQ6f8UMCIYxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU9bRVZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B18C4CEE3;
	Thu,  3 Jul 2025 07:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751527404;
	bh=s5RWJAg4D/dfrnb7YGisPOZh4Cfa5pW76OvfehJpRrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LU9bRVZVARclMxuotJzPyZUdWvMWimJM0bCBdp9xQTehCbGFBKnrrZt1NPOIg0FB2
	 l/lkw9utKHcUCu7bzIEtGdTcsnGkUcMcs8fmfbcc0T7v7f2OC1FjsxAxKjQM/lppTS
	 //pVlbiCk+tNBqApDCJVUuo2207S6zsGPYvV5pbv30tOsgYfGgaRs9atP9Is4g07MR
	 bIMHWiHIirevd1HB42xTYFqI3sa9qVp6euIfeVNVD30BWxjrm9Y5Ks7buOYjweVrh5
	 AwKSWS0bHRY9gkfN0Wksk3+fXS7OvZtaEGlMrgT4qj4mGoPXQqupLh63Kc1NS1n/6o
	 MHuMzePyC26Vg==
Date: Thu, 3 Jul 2025 08:23:17 +0100
From: Simon Horman <horms@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <uwu@dram.page>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH net-next v3 0/5] Add Ethernet MAC support for SpacemiT K1
Message-ID: <20250703072317.GK41770@horms.kernel.org>
References: <20250702-net-k1-emac-v3-0-882dc55404f3@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-net-k1-emac-v3-0-882dc55404f3@iscas.ac.cn>

On Wed, Jul 02, 2025 at 02:01:39PM +0800, Vivian Wang wrote:
> SpacemiT K1 has two gigabit Ethernet MACs with RGMII and RMII support.
> Add a driver for them, as well as the supporting devicetree and bindings
> updates.
> 
> Tested on BananaPi BPI-F3 and Milk-V Jupiter.
> 
> I would like to note that even though some bit field names superficially
> resemble that of DesignWare MAC, all other differences point to it in
> fact being a custom design.
> 
> Based on SpacemiT drivers [1].
> 
> This series depends on reset controller support [2] and DMA buses [3]
> for K1. There are some minor conflicts resulting from both touching
> k1.dtsi, but it should just both be adding nodes.
> 
> These patches can also be pulled from:
> 
> https://github.com/dramforever/linux/tree/k1/ethernet/v3
> 
> [1]: https://github.com/spacemit-com/linux-k1x
> [2]: https://lore.kernel.org/all/20250613011139.1201702-1-elder@riscstar.com
> [3]: https://lore.kernel.org/all/20250623-k1-dma-buses-rfc-wip-v1-0-c0144082061f@iscas.ac.cn
> 
> ---
> Changes in v3:
> - Refactored and simplified emac_tx_mem_map
> - Addressed other minor v2 review comments
> - Removed what was patch 3 in v2, depend on DMA buses instead
> - DT nodes in alphabetical order where appropriate
> - Link to v2: https://lore.kernel.org/r/20250618-net-k1-emac-v2-0-94f5f07227a8@iscas.ac.cn
> 
> Changes in v2:
> - dts: Put eth0 and eth1 nodes under a bus with dma-ranges
> - dts: Added Milk-V Jupiter
> - Fix typo in emac_init_hw() that broke the driver (Oops!)
> - Reformatted line lengths to under 80
> - Addressed other v1 review comments
> - Link to v1: https://lore.kernel.org/r/20250613-net-k1-emac-v1-0-cc6f9e510667@iscas.ac.cn
> 
> ---
> Vivian Wang (5):
>       dt-bindings: net: Add support for SpacemiT K1
>       net: spacemit: Add K1 Ethernet MAC
>       riscv: dts: spacemit: Add Ethernet support for K1
>       riscv: dts: spacemit: Add Ethernet support for BPI-F3
>       riscv: dts: spacemit: Add Ethernet support for Jupiter

I'm unsure on the plan for merging this.  But it seems to me that the first
two patches ought to go though net-next. But in order for patches to
proceed through net-next the entire series ought to apply on that tree - so
CI can run.

I'm not sure on the way forward.  But perhaps splitting the series in two:
the first two patches for net-next; and, the riscv patches targeted elsewhere
makes sense?

</2c>

