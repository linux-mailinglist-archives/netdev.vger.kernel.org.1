Return-Path: <netdev+bounces-158574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB23A128BD
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD8016604A
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 16:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A9214A60C;
	Wed, 15 Jan 2025 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LJeQqzuJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF15132105;
	Wed, 15 Jan 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736958851; cv=none; b=PNqE1sS8cWZj8voJl2/HGegrpi+IM5LXeMWs6tLFmIYhr91UzBPptB1fInS1ncpkkfhYnIZlkOZWrVqksZTzzdkxB95+O9I+qhEpneYg0Al86DG9UiW/foXiubLio47XMNWVZfrQpMrC9YZGUGsq83byO9nIZ3foR+9fUJkZwq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736958851; c=relaxed/simple;
	bh=kwx42T/NcQo38aYkPVeBQcAaiNJOyBJ9YlCJjwM8OlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wt9jTlTsPApitCLqC/gsailLkOLRAIqCYEEXhX8WVDDvgFAu9n8XlEag29kgz0YiwwPDbWwaAcxfO2c8QG+h1WYMiGPY6DEandF3NZDN4LQnVLqvh6jDsTDv2lnuNvfjoMsakXflF3BGaoXF81CnCsrYv5L6XjdQQ7A+IyFt3Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LJeQqzuJ; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <171d1123-af12-4ac9-90a1-71eeca5f716d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736958847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icHLKv5VN6jwSr7MhzVN0//BkA8Uxelerc6wDiydU88=;
	b=LJeQqzuJHboM4Y2r+z5jdvuyn7WuMOgq6VU9c+TYcGUmNZrbKchqTiX6jWoFHWuZcD+RqL
	aI4aF0mkc4CgGDxDRZ5KE1pLftSWkG7NDzckMYSoSSfzIlVLX5vFeqtDaXFdOY9nqly8p8
	DROGM/1Hw+2C8GyG+oMmwgi9J9UOgCU=
Date: Thu, 16 Jan 2025 00:33:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 4/4] net: stmmac: Convert prefetch() to
 net_prefetch() for received frames
To: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Joe Damato <jdamato@fastly.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
References: <cover.1736910454.git.0x1207@gmail.com>
 <909631f38edfac07244ea62d94dc76953d52035e.1736910454.git.0x1207@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <909631f38edfac07244ea62d94dc76953d52035e.1736910454.git.0x1207@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 1/15/25 11:27, Furong Xu 写道:
> The size of DMA descriptors is 32 bytes at most.
> net_prefetch() for received frames, and keep prefetch() for descriptors.
> 
> This patch brings ~4.8% driver performance improvement in a TCP RX
> throughput test with iPerf tool on a single isolated Cortex-A65 CPU
> core, 2.92 Gbits/sec increased to 3.06 Gbits/sec.
> 
> Suggested-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>

Thanks,
Yanteng
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index ad928e8e21a9..49b41148d594 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5529,7 +5529,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>   
>   			dma_sync_single_for_cpu(priv->device, buf->addr,
>   						buf1_len, dma_dir);
> -			prefetch(page_address(buf->page) + buf->page_offset);
> +			net_prefetch(page_address(buf->page) +
> +				     buf->page_offset);
>   
>   			xdp_init_buff(&ctx.xdp, buf_sz, &rx_q->xdp_rxq);
>   			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),


