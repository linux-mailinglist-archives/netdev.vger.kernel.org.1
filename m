Return-Path: <netdev+bounces-12872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB017393B6
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 02:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1647528166C
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 00:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEC615D1;
	Thu, 22 Jun 2023 00:23:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167E15A5;
	Thu, 22 Jun 2023 00:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0F5C433C8;
	Thu, 22 Jun 2023 00:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687393416;
	bh=Qv487yLictNg6YITz+WCFTi0FKLmRQ7tmU2yb4AYrYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CvdcRMGQKyE8ZfCNSYZDtQmOp7qGeyRIh0DYHTw6aXSQQhF7Hw8s+u+5xkV8Oh5dL
	 Vmw4KEjf/v+OYwwX0+hvhr21h65XG3sUu1yAUWwt98L0TOBIb9YvKDQ5sXokKt1zEB
	 fUrlwzVDWHoBDVNbb8tUt/Nia+enRVXUIdHIiWijVswwXpjjeWc0SLZ2tGGeXJo3CM
	 njXbr25iufGPDFPyFjlm7xmbC7ml/G5wDAu1AFEJTsWuwI2LZMOMh9RZHqWTDzzm6m
	 TR577nO8gMG+ZkwxmpNCKCsigB9KEXrhdncMyMq3oVw41pJWuWuJ9Ccj8vWokh0919
	 3j9ynEWAziAJA==
Date: Wed, 21 Jun 2023 17:23:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 2/2] net: stmmac: use pcpu 64 bit statistics
 where necessary
Message-ID: <20230621172335.33cf0dbb@kernel.org>
In-Reply-To: <20230619165220.2501-3-jszhang@kernel.org>
References: <20230619165220.2501-1-jszhang@kernel.org>
	<20230619165220.2501-3-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jun 2023 00:52:20 +0800 Jisheng Zhang wrote:
> +struct stmmac_pcpu_stats {
> +	struct u64_stats_sync syncp;
> +	/* per queue statistics */
> +	struct stmmac_txq_stats txq_stats[MTL_MAX_TX_QUEUES];
> +	struct stmmac_rxq_stats rxq_stats[MTL_MAX_RX_QUEUES];
> +	/* device stats */
> +	u64 rx_packets;
> +	u64 rx_bytes;
> +	u64 tx_packets;
> +	u64 tx_bytes;
> +	/* Tx/Rx IRQ Events */
> +	u64 tx_pkt_n;
> +	u64 rx_pkt_n;
> +	u64 normal_irq_n;
> +	u64 rx_normal_irq_n;
> +	u64 napi_poll;
> +	u64 tx_normal_irq_n;
> +	u64 tx_clean;
> +	u64 tx_set_ic_bit;
> +	/* TSO */
> +	u64 tx_tso_frames;
> +	u64 tx_tso_nfrags;

AFAICT you're using the same structure and syncp for the stats updated
from within IRQ and from xmit and NAPI. That's not safe. The
documentation of u64_stats_sync suggests using _irqsave() variant for
that case but really, I think you should split these stats up.

The statistics which are counting packets / bytes should all go into
respective queue structs, like struct stmmac_tx_queue, and have their
own syncp per context (i.e. separate for xmit and completions if they
can run in parallel).

Having the counters in queue structs is much more common in drivers, 
it usually saves memory and allows reporting stats per queue.

You can keep the per-cpu stats for IRQs if there's no IRQ struct, 
if you prefer. 
-- 
pw-bot: cr

