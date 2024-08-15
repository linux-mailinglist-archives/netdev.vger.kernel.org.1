Return-Path: <netdev+bounces-118911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE7E9537D5
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD17AB27CDC
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7FB1B3749;
	Thu, 15 Aug 2024 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BA7XIfQq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416921B143F;
	Thu, 15 Aug 2024 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737677; cv=none; b=fc5RrCZkuh1cbhhL5poA0IGNizzqFfxYkprKmYm1umrAkdModfUgmRcvcL/RLnUqzDpKoOR4gK7Yb0dGBuyEHrjH/GJAL3ShW6gN2UsAHr/dY4kFJJGwpDexZDZfcvccCHrw9LkSQrq6gA5Ns30dpG0HeYMdnJS9hVB5F1VGarc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737677; c=relaxed/simple;
	bh=bpLctNnXNGhiRFpnTqnNbNKjW5iZ+9VEc+lKuloqtSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TF+1j1hFiEoqKD/RoOYqKWDsvzgEsb7Osi+cYo4OyrhmhF91BxuvrkHFj8+ZKjSPjmQ1mORgXKVBbUbzgsl0cigCPdJ6Lc7FrC47VeyQ4lTQc7yf/AUQV/MN4mYpCunlzrpf35TX4TD4bYd8LzvgaWHwD2VDViRsZfeX8LWUTcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BA7XIfQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C23AC32786;
	Thu, 15 Aug 2024 16:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723737676;
	bh=bpLctNnXNGhiRFpnTqnNbNKjW5iZ+9VEc+lKuloqtSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BA7XIfQqUp304q0UubGf+Dtll1j0k3G9oGyub1hlDn4xktjCwVzLDCOvouVAk9Wa+
	 r9cYbFcrmT4BaiTcYySS+Clu6UH1gcoln0SBm2WjkalmR+Od0BINGeq2xx17xjfsHa
	 oerCASdcnS77HqSiHJgsq0XlAdFecbGtLIw5Lk5PUX12v9ut26h4MNiHBb8s4ft61M
	 p+U4uqxvZVUE6nFuRpo916Q0rJ2i4qzAGo/lJaP/oRjc9Mbfkpe/nFXPif1Is2Dud1
	 cvYoMnP/tmB6AMmc6BezMmJSaowir88MPTz0lE7MUWbneEO8jHtnkFTp3bI6QkHhJU
	 DasylzQzzV60Q==
Date: Thu, 15 Aug 2024 17:01:09 +0100
From: Simon Horman <horms@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>, Diogo Ivo <diogo.ivo@siemens.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Roger Quadros <rogerq@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v5 2/2] net: ti: icssg-prueth: Add support for
 PA Stats
Message-ID: <20240815160109.GN632411@kernel.org>
References: <20240814092033.2984734-1-danishanwar@ti.com>
 <20240814092033.2984734-3-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814092033.2984734-3-danishanwar@ti.com>

On Wed, Aug 14, 2024 at 02:50:33PM +0530, MD Danish Anwar wrote:

...

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index f678d656a3ed..ac2291d22c42 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -50,8 +50,10 @@
>  
>  #define ICSSG_MAX_RFLOWS	8	/* per slice */
>  
> +#define ICSSG_NUM_PA_STATS 4
> +#define ICSSG_NUM_MII_G_RT_STATS 60
>  /* Number of ICSSG related stats */
> -#define ICSSG_NUM_STATS 60
> +#define ICSSG_NUM_STATS (ICSSG_NUM_MII_G_RT_STATS + ICSSG_NUM_PA_STATS)
>  #define ICSSG_NUM_STANDARD_STATS 31
>  #define ICSSG_NUM_ETHTOOL_STATS (ICSSG_NUM_STATS - ICSSG_NUM_STANDARD_STATS)
>  
> @@ -263,6 +265,7 @@ struct prueth {
>  	struct net_device *registered_netdevs[PRUETH_NUM_MACS];
>  	struct regmap *miig_rt;
>  	struct regmap *mii_rt;
> +	struct regmap *pa_stats;

Please add an entry for pa_stats to the Kernel doc for this structure.

>  
>  	enum pruss_pru_id pru_id[PRUSS_NUM_PRUS];
>  	struct platform_device *pdev;

...

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
> index 999a4a91276c..e834316092c9 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
> @@ -77,6 +77,20 @@ struct miig_stats_regs {
>  	u32 tx_bytes;
>  };
>  
> +/**
> + * struct pa_stats_regs - ICSSG Firmware maintained PA Stats register
> + * @u32 fw_rx_cnt: Number of valid packets sent by Rx PRU to Host on PSI
> + * @u32 fw_tx_cnt: Number of valid packets copied by RTU0 to Tx queues
> + * @u32 fw_tx_pre_overflow: Host Egress Q (Pre-emptible) Overflow Counter
> + * @u32 fw_tx_exp_overflow: Host Egress Q (Express) Overflow Counter
> + */

./scripts/kernel-doc -none doesn't seem to like the syntax above.
Perhaps s/u32 // ?

> +struct pa_stats_regs {
> +	u32 fw_rx_cnt;
> +	u32 fw_tx_cnt;
> +	u32 fw_tx_pre_overflow;
> +	u32 fw_tx_exp_overflow;
> +};
> +
>  #define ICSSG_STATS(field, stats_type)			\
>  {							\
>  	#field,						\

...

