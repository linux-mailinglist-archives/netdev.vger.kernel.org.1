Return-Path: <netdev+bounces-25013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027047728E7
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 17:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931A028121D
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9F810970;
	Mon,  7 Aug 2023 15:19:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7721078E
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 15:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275B4C433C7;
	Mon,  7 Aug 2023 15:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691421538;
	bh=Ol5bMly7ZqSw89nfp8mGDx2BhxDc6aLMJTh/iG345hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YRp/HqOwWwHkISGl6UlLg2lhuOJ3o0X4pe3nR6DzFJ6au08VpBT9ZQPWXQ2jgpCEz
	 8IZLlaeQVQNCQrn9p49EF7NkJQ3aZ0m0DG+RdLt5rKwOAfWinT8Q24WbwuqofDvtpR
	 itQgofis4FrIyi0nxdIEdKehqg9yJATp6vdSotCLcjsjbu9cMXulryywabJ2OgQYr5
	 gRBBPX6y9ROcoTv5J2E3HSKQcQyCSK7f7qoF7Brg5Mv81gdJL8OKWyXnRVMJ4/omNJ
	 sPbQQzirY9MYcN1gFDpaZVQPqQ4XsPapJ1kycY9apdtExhLO4rQ7Rpbhpe6bqHSZHI
	 RYwJTvM+Grrlw==
Date: Mon, 7 Aug 2023 17:18:53 +0200
From: Simon Horman <horms@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH] net: stmmac: xgmac: RX queue routing configuration
Message-ID: <ZNELXd4I8r+YlWXP@vergenet.net>
References: <20230807065609.1096076-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807065609.1096076-1-0x1207@gmail.com>

On Mon, Aug 07, 2023 at 02:56:09PM +0800, Furong Xu wrote:
> Commit abe80fdc6ee6 ("net: stmmac: RX queue routing configuration")
> introduced RX queue routing to DWMAC4 core.
> This patch extend the support to XGMAC2 core.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Hi Furong Xu,

as this is a feature for a Networking it (probably) should
be targeted at net-next - as opposed to net, which is for bug fixes.
The target tree should be included in the subject.

  Subject: [PATCH net-next] ...

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index a0c2ef8bb0ac..24918d95f612 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -127,6 +127,39 @@ static void dwxgmac2_tx_queue_prio(struct mac_device_info *hw, u32 prio,
>  	writel(value, ioaddr + reg);
>  }
>  
> +static void dwxgmac2_rx_queue_routing(struct mac_device_info *hw,
> +				      u8 packet, u32 queue)
> +{
> +	void __iomem *ioaddr = hw->pcsr;
> +	u32 value;
> +
> +	static const struct stmmac_rx_routing dwxgmac2_route_possibilities[] = {
> +		{ XGMAC_AVCPQ, XGMAC_AVCPQ_SHIFT },
> +		{ XGMAC_PTPQ, XGMAC_PTPQ_SHIFT },
> +		{ XGMAC_DCBCPQ, XGMAC_DCBCPQ_SHIFT },
> +		{ XGMAC_UPQ, XGMAC_UPQ_SHIFT },
> +		{ XGMAC_MCBCQ, XGMAC_MCBCQ_SHIFT },
> +	};
> +
> +	value = readl(ioaddr + XGMAC_RXQ_CTRL1);
> +
> +	/* routing configuration */
> +	value &= ~dwxgmac2_route_possibilities[packet - 1].reg_mask;
> +	value |= (queue << dwxgmac2_route_possibilities[packet-1].reg_shift) &
> +		dwxgmac2_route_possibilities[packet - 1].reg_mask;
> +
> +	/* some packets require extra ops */
> +	if (packet == PACKET_AVCPQ) {
> +		value &= ~XGMAC_TACPQE;
> +		value |= 0x1 << XGMAC_TACPQE_SHIFT;

FIELD_PREP seems appropriate here.

> +	} else if (packet == PACKET_MCBCQ) {
> +		value &= ~XGMAC_MCBCQEN;
> +		value |= 0x1 << XGMAC_MCBCQEN_SHIFT;

And here.

> +	}
> +
> +	writel(value, ioaddr + XGMAC_RXQ_CTRL1);
> +}
> +
>  static void dwxgmac2_prog_mtl_rx_algorithms(struct mac_device_info *hw,
>  					    u32 rx_alg)
>  {

...

