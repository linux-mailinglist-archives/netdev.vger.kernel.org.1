Return-Path: <netdev+bounces-74008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B9785F9D6
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A301F27536
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEE9134CFA;
	Thu, 22 Feb 2024 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBkYPdke"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7F1350EA
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608670; cv=none; b=M9vuMxPdR1AwMAjwsP1DblrPJwuQeUhXDY/u3O3+S7i3GBLiWMJhlRrhA+jfw2Bk7VsStkOlM4W/5tob0NFBIYkGWODyDDypwjM3OsAtzVn/8apMc+lqiGaNI6LR67UqGAKKTo3XiQC1ilh1NGub3KTh+F74QRAGSuTFgAPwZcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608670; c=relaxed/simple;
	bh=aOcJtCmwKp2GuBFt7gwIwEmbmxIllUoOP4HuHQpHAjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8W6IkYLRZeKfOPKmizETDd7uAv3ue6ab9pqxTRXUevk5jUymk7bo6myAp0SsNssqjOCKFsGJ0a6yx+70umZzbFk/S9oADDXS9kN7D01jRFZyeid8HN0kJWGEa7yhRtNV+3D9fg0/ta9zmETgCfeVwTx+cmlQJIRK+9x8A7lrOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBkYPdke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09CDC433C7;
	Thu, 22 Feb 2024 13:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708608668;
	bh=aOcJtCmwKp2GuBFt7gwIwEmbmxIllUoOP4HuHQpHAjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBkYPdke3iI1N//HBlZqUDekP6PITPEZ1gqufxPPOx7I8aVsg4jhGe1Sd+1V/6LrT
	 h9ZyexhnlHPBqSGdvmiSB1K7iRJguanPbo7cqsW4+rgnYkYWDe3yIf2RkgqVO59XAP
	 WXgTE2MeeJji0OvaVlR8vRm4+OgrhwKljD8qWt6BzNsDvCFaHGwwxbwozXh/b7gXLw
	 56Bp2rDECET0TlUV+ARswXxjARFLlMfWJ9LusIfVc12yiZBsasuyllikTXYlUa/suJ
	 UNi2sYf4VaJIbdRDmN+lo7MheIXMXWM/Dcf54XPiEwgirBvn+3de9Tx3JqU+yEs0rV
	 tiPGxxdBn2hwg==
Date: Thu, 22 Feb 2024 13:31:03 +0000
From: Simon Horman <horms@kernel.org>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org,
	vigneshr@ti.com, arnd@arndb.de, wsa+renesas@sang-engineering.com,
	vladimir.oltean@nxp.com, andrew@lunn.ch, dan.carpenter@linaro.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	jan.kiszka@siemens.com
Subject: Re: [PATCH net-next v3 10/10] net: ti: icssg-prueth: Add ICSSG
 Ethernet driver for AM65x SR1.0 platforms
Message-ID: <20240222133103.GB960874@kernel.org>
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
 <20240221152421.112324-11-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221152421.112324-11-diogo.ivo@siemens.com>

On Wed, Feb 21, 2024 at 03:24:16PM +0000, Diogo Ivo wrote:
> Add the PRUeth driver for the ICSSG subsystem found in AM65x SR1.0 devices.
> The main differences that set SR1.0 and SR2.0 apart are the missing TXPRU
> core in SR1.0, two extra DMA channels for management purposes and different
> firmware that needs to be configured accordingly.
> 
> Based on the work of Roger Quadros, Vignesh Raghavendra and
> Grygorii Strashko in TI's 5.10 SDK [1].
> 
> [1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y
> 
> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>

...

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c

...

> +static void icssg_config_sr1(struct prueth *prueth, struct prueth_emac *emac,
> +			     int slice)
> +{
> +	struct icssg_sr1_config config;
> +	void __iomem *va;
> +	int i, index;
> +
> +	memset(&config, 0, sizeof(config));
> +	config.addr_lo = cpu_to_le32(lower_32_bits(prueth->msmcram.pa));
> +	config.addr_hi = cpu_to_le32(upper_32_bits(prueth->msmcram.pa));
> +	config.num_tx_threads = 0;
> +	config.rx_flow_id = emac->rx_flow_id_base; /* flow id for host port */
> +	config.rx_mgr_flow_id = emac->rx_mgm_flow_id_base; /* for mgm ch */
> +	config.rand_seed = get_random_u32();

Hi Diogo and Jan,

The fields of config above are all __le32.
However the last three lines above assign host byte-order values to these
fields. This does not seem correct.

This is flagged by Sparse along with some problems.
Please ensure that new Sparse warnings are not introduced.


> +
> +	for (i = PRUETH_EMAC_BUF_POOL_START_SR1; i < PRUETH_NUM_BUF_POOLS_SR1; i++) {
> +		index =  i - PRUETH_EMAC_BUF_POOL_START_SR1;
> +		config.tx_buf_sz[i] = cpu_to_le32(emac_egress_buf_pool_size[index]);
> +	}
> +
> +	va = prueth->shram.va + slice * ICSSG_CONFIG_OFFSET_SLICE1;
> +	memcpy_toio(va, &config, sizeof(config));
> +
> +	emac->speed = SPEED_1000;
> +	emac->duplex = DUPLEX_FULL;
> +}
> +
> +static int emac_send_command_sr1(struct prueth_emac *emac, u32 cmd)
> +{
> +	dma_addr_t desc_dma, buf_dma;
> +	struct prueth_tx_chn *tx_chn;
> +	struct cppi5_host_desc_t *first_desc;
> +	u32 *data = emac->cmd_data;
> +	u32 pkt_len = sizeof(emac->cmd_data);
> +	void **swdata;
> +	int ret = 0;
> +	u32 *epib;

In new Networking code please express local variables in reverse xmas tree
order - longest line to shortest.

Something like this (completely untested!):

	struct cppi5_host_desc_t *first_desc;
	u32 pkt_len = sizeof(emac->cmd_data);
	dma_addr_t desc_dma, buf_dma;
	struct prueth_tx_chn *tx_chn;
	u32 *data = emac->cmd_data;
	void **swdata;
	int ret = 0;
	u32 *epib;

There is also one such problem in Patch 06/10.
These problems can be detected using:

	https://github.com/ecree-solarflare/xmastree

...

