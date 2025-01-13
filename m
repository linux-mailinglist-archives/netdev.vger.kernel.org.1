Return-Path: <netdev+bounces-157788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFE8A0BB9A
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E191882ACE
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A1F1C5D4A;
	Mon, 13 Jan 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rD84PlDU"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0924025E;
	Mon, 13 Jan 2025 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781453; cv=none; b=evmo1H+OrAhZdI81eOcBHdoJJdaSTmXgEbvto2UsG8el1DBLHp4qE/3hVKyZ1K3HCoWjhM6J8aIvk5ztChZUcxKsMDXLrymPdnspTpeqI/yRaLwaomGacHanh9O1x3bqEb8t6UWNE76wtrp5RLK1O8lrxD0Q19NQow3bBBCVmv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781453; c=relaxed/simple;
	bh=mv1aFzCM6p1GcIXtSyVgeJbq6qiLQQKQdKw5UyFxxNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkV+BzUyFD7rHJWe22sRL8a/tD+Cgar2NAHcUGQmEiz9dzoFJE0bTQn/shVcPtYAII0LebeRG7r0+Y87ie/MgqhIpn7V625x99BBIvBqKXgo+4mBHhr3nfDfspQJTxoYyP2h6WwJ4ik8+S9XELrImUumT73NWPsnkUyWNIEI3ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rD84PlDU; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8d6303f1-37f1-4298-b377-d2bd55ac01de@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736781445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LKOrjtOEkYBN2Y2LO0sJXjsSTOuS88NhX+jEyFyuLf4=;
	b=rD84PlDUF7tV0r+jkJkCgDrEoNeOaEMHi608IRg8N81+ci74WGf0OKgNh24HHbN4Sph+1N
	hTfzeEEUvRJ2ZB9UaseGrbhcdEB3h93gQu/S18Ld/hslY7OehFIPg/wryHw4BsEigAc9qe
	ZeqMUjaMTnzYv4+6LVyWmvq2bvDky64=
Date: Mon, 13 Jan 2025 23:16:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v1 1/3] net: stmmac: Switch to zero-copy in
 non-XDP RX path
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
References: <cover.1736500685.git.0x1207@gmail.com>
 <600c76e88b6510f6a4635401ec1e224b3bbb76ec.1736500685.git.0x1207@gmail.com>
 <f1062d1c-f39d-4c9e-9b50-f6ae0bcf27d5@linux.dev>
 <054ae4bf-37a8-4e4e-8631-dedded8f30f1@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <054ae4bf-37a8-4e4e-8631-dedded8f30f1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 1/13/25 20:03, Alexander Lobakin 写道:
> From: Yanteng Si <si.yanteng@linux.dev>
> Date: Mon, 13 Jan 2025 17:41:41 +0800
>
>> 在 2025/1/10 17:53, Furong Xu 写道:
>>> Avoid memcpy in non-XDP RX path by marking all allocated SKBs to
>>> be recycled in the upper network stack.
>>>
>>> This patch brings ~11.5% driver performance improvement in a TCP RX
>>> throughput test with iPerf tool on a single isolated Cortex-A65 CPU
>>> core, from 2.18 Gbits/sec increased to 2.43 Gbits/sec.
>>>
>>> Signed-off-by: Furong Xu <0x1207@gmail.com>
>>> ---
>>>    drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
>>>    .../net/ethernet/stmicro/stmmac/stmmac_main.c | 23 +++++++++++--------
>>>    2 files changed, 15 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/
>>> net/ethernet/stmicro/stmmac/stmmac.h
>>> index 548b28fed9b6..5c39292313de 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>>> @@ -126,6 +126,7 @@ struct stmmac_rx_queue {
>>>        unsigned int cur_rx;
>>>        unsigned int dirty_rx;
>>>        unsigned int buf_alloc_num;
>>> +    unsigned int napi_skb_frag_size;
>>>        dma_addr_t dma_rx_phy;
>>>        u32 rx_tail_addr;
>>>        unsigned int state_saved;
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/
>>> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> index 038df1b2bb58..43125a6f8f6b 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> @@ -1320,7 +1320,7 @@ static unsigned int stmmac_rx_offset(struct
>>> stmmac_priv *priv)
>>>        if (stmmac_xdp_is_enabled(priv))
>>>            return XDP_PACKET_HEADROOM;
>>>    -    return 0;
>>> +    return NET_SKB_PAD;
>>>    }
>>>      static int stmmac_set_bfsize(int mtu, int bufsize)
>>> @@ -2019,17 +2019,21 @@ static int
>>> __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
>>>        struct stmmac_channel *ch = &priv->channel[queue];
>>>        bool xdp_prog = stmmac_xdp_is_enabled(priv);
>>>        struct page_pool_params pp_params = { 0 };
>>> -    unsigned int num_pages;
>>> +    unsigned int dma_buf_sz_pad, num_pages;
>>>        unsigned int napi_id;
>>>        int ret;
>>>    +    dma_buf_sz_pad = stmmac_rx_offset(priv) + dma_conf->dma_buf_sz +
>>> +             SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>> +    num_pages = DIV_ROUND_UP(dma_buf_sz_pad, PAGE_SIZE);
>>> +
>>>        rx_q->queue_index = queue;
>>>        rx_q->priv_data = priv;
>>> +    rx_q->napi_skb_frag_size = num_pages * PAGE_SIZE;
>>>          pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
>>>        pp_params.pool_size = dma_conf->dma_rx_size;
>>> -    num_pages = DIV_ROUND_UP(dma_conf->dma_buf_sz, PAGE_SIZE);
>>> -    pp_params.order = ilog2(num_pages);
>>> +    pp_params.order = order_base_2(num_pages);
>>>        pp_params.nid = dev_to_node(priv->device);
>>>        pp_params.dev = priv->device;
>>>        pp_params.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
>>> @@ -5574,19 +5578,20 @@ static int stmmac_rx(struct stmmac_priv *priv,
>>> int limit, u32 queue)
>>>                /* XDP program may expand or reduce tail */
>>>                buf1_len = ctx.xdp.data_end - ctx.xdp.data;
>>>    -            skb = napi_alloc_skb(&ch->rx_napi, buf1_len);
>>> +            skb = napi_build_skb(page_address(buf->page),
>>> +                         rx_q->napi_skb_frag_size);
>>>                if (!skb) {
>>> +                page_pool_recycle_direct(rx_q->page_pool,
>>> +                             buf->page);
>>>                    rx_dropped++;
>>>                    count++;
>>>                    goto drain_data;
>>>                }
>>>                  /* XDP program may adjust header */
>>> -            skb_copy_to_linear_data(skb, ctx.xdp.data, buf1_len);
>>> +            skb_reserve(skb, ctx.xdp.data - ctx.xdp.data_hard_start);
>> The network subsystem still requires that the length
>> of each line of code should not exceed 80 characters.
>> So let's silence the warning:
>>
>> WARNING: line length of 81 exceeds 80 columns
>> #87: FILE: drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:5592:
>> +            skb_reserve(skb, ctx.xdp.data - ctx.xdp.data_hard_start);
> I agree that &ctx.xdp could be made an onstack pointer to shorten these
> lines, but please don't spam with the checkpatch output.
>
> 1. It's author's responsibility to read netdev CI output on Patchwork,
>     reviewers shouldn't copy its logs.
Sorry, I shouldn't have made noise on the mailing list.
> 2. The only alternative without making a shortcut for &ctx.xdp is
>
> 			skb_reserve(skb,
> 				    ctx.xdp.data - ctx.xdp.data_hard_start);
>
> This looks really ugly and does more harm than good.
Agree!
>
> If you really want to help, pls come with good propositions how to avoid
> such warnings in an elegant way.

Simple. Just do as with buf1_len.

Thanks,

Yanteng

>
>> Thanks,
>> Yanteng
> Thanks,
> Olek

