Return-Path: <netdev+bounces-126029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D218696FA1A
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 19:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35281C21D23
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 17:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C31E1C9ED4;
	Fri,  6 Sep 2024 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tpwF1uSX"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220F75A7B8
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725644998; cv=none; b=sRZICt7iCnWcrDg3aKEY+nvMydk1fW/7jq79glJ70SBdDsSQp4O+rGSpnMf6Kjwv2aqHrhht2garTwpf9Gt2vLb/h2i1rFDzN5k6vrfFB0+nntCWo+cFM9OCoHbMzgdm2ohfO/kkosstxhir0X1ryVH2NdxLoUpafCQ6xsmWAMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725644998; c=relaxed/simple;
	bh=k9gfrzilHO+fuDKUWe2NTN3OgjB5Qo5hlit58VIKLrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hd/MFTTXwT/0XpMHh4/w9Ff7OpvMJEV+bHeYqOuUscSt39xDnZ51pq4izz/Ki6e5AfUaIztEm2DTyBoSZ/OFScFYgH2vOQqZEABaepT/aTrpAn1ighHGSdy7tCSCk4EuDP6c4s5gmBzNc5/kB4quy+0ogKQcm49rGUsT72DbWNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tpwF1uSX; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5bef23da-0e49-4820-9a9b-75299a2c5cfd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725644994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYBGW6SyGvXYU+nmItva9VAMQDYqHsRq2KQ0T2N3NE4=;
	b=tpwF1uSXBg5FfFuKPGP3lQkBLBS2lrfofGKcInXrGHIs7+N8xl5iMWl7/ICOISaF9S6X+w
	wKLKbzWksH1E0x1UDyKttEjOv5UGQ5i/Pd3B2P8fkWwSBueCcUvRF8LSp5WzSA8+F4vEOD
	ajgMHr46OZq3tj9HECqRc9ttyN9Gpdk=
Date: Fri, 6 Sep 2024 13:49:49 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net: xilinx: axienet: Fix packet counting
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Chiu <andy.chiu@sifive.com>, Daniel Borkmann <daniel@iogearbox.net>,
 "Gupta, Suraj" <Suraj.Gupta2@amd.com>,
 "Katakam, Harini" <harini.katakam@amd.com>
References: <20240906164227.505984-1-sean.anderson@linux.dev>
 <MN0PR12MB595376E110FB44EEBCF9C7C3B79E2@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <MN0PR12MB595376E110FB44EEBCF9C7C3B79E2@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/6/24 13:44, Pandey, Radhey Shyam wrote:
>> -----Original Message-----
>> From: Sean Anderson <sean.anderson@linux.dev>
>> Sent: Friday, September 6, 2024 10:12 PM
>> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; David S .
>> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
>> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
>> netdev@vger.kernel.org
>> Cc: Simek, Michal <michal.simek@amd.com>; linux-arm-
>> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Andy Chiu
>> <andy.chiu@sifive.com>; Daniel Borkmann <daniel@iogearbox.net>; Sean
>> Anderson <sean.anderson@linux.dev>
>> Subject: [PATCH net v2] net: xilinx: axienet: Fix packet counting
>> 
>> axienet_free_tx_chain returns the number of DMA descriptors it's
>> handled. However, axienet_tx_poll treats the return as the number of
>> packets. When scatter-gather SKBs are enabled, a single packet may use
>> multiple DMA descriptors, which causes incorrect packet counts. Fix this
>> by explicitly keepting track of the number of packets processed as
>> separate from the DMA descriptors.
>> 
>> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet
> 
> Isn't it Fixes: 9e2bc267e780 ("net: axienet: Use NAPI for TX completion path")?

No. The packet count is also used for statistics, and this confusion has
been present since the original commit.

>> driver")
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> 
> + Harini, Suraj to review and run this patch to ensure data path sanity.
> 
>> ---
>> 
>> Changes in v2:
>> - Only call napi_consume_skb with non-zero budget when force is false
>> 
>>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 31 +++++++++++--------
>>  1 file changed, 18 insertions(+), 13 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> index 9aeb7b9f3ae4..556033849d55 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> @@ -670,21 +670,21 @@ static int axienet_device_reset(struct net_device
>> *ndev)
>>   * @force:	Whether to clean descriptors even if not complete
>>   * @sizep:	Pointer to a u32 filled with the total sum of all bytes
>>   *		in all cleaned-up descriptors. Ignored if NULL.
>> - * @budget:	NAPI budget (use 0 when not called from NAPI poll)
>> + * @budget:	NAPI budget (use INT_MAX when not called from NAPI poll)
>>   *
>>   * Would either be called after a successful transmit operation, or after
>>   * there was an error when setting up the chain.
>> - * Returns the number of descriptors handled.
>> + * Returns the number of packets handled.
>>   */
>>  static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
>>  				 int nr_bds, bool force, u32 *sizep, int
>> budget)
>>  {
>>  	struct axidma_bd *cur_p;
>>  	unsigned int status;
>> +	int i, packets = 0;
>>  	dma_addr_t phys;
>> -	int i;
>> 
>> -	for (i = 0; i < nr_bds; i++) {
>> +	for (i = 0; i < nr_bds && packets < budget; i++) {
>>  		cur_p = &lp->tx_bd_v[(first_bd + i) % lp->tx_bd_num];
>>  		status = cur_p->status;
>> 
>> @@ -701,8 +701,10 @@ static int axienet_free_tx_chain(struct axienet_local
>> *lp, u32 first_bd,
>>  				 (cur_p->cntrl &
>> XAXIDMA_BD_CTRL_LENGTH_MASK),
>>  				 DMA_TO_DEVICE);
>> 
>> -		if (cur_p->skb && (status &
>> XAXIDMA_BD_STS_COMPLETE_MASK))
>> -			napi_consume_skb(cur_p->skb, budget);
>> +		if (cur_p->skb && (status &
>> XAXIDMA_BD_STS_COMPLETE_MASK)) {
>> +			napi_consume_skb(cur_p->skb, force ? 0 : budget);
>> +			packets++;
>> +		}
>> 
>>  		cur_p->app0 = 0;
>>  		cur_p->app1 = 0;
>> @@ -718,7 +720,13 @@ static int axienet_free_tx_chain(struct axienet_local
>> *lp, u32 first_bd,
>>  			*sizep += status &
>> XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
>>  	}
>> 
>> -	return i;
>> +	if (!force) {
> 
> Is tx_bd_ci increment dependent on force state and not done if force == true ?

No. "force" is used in the error path of axienet_start_xmit to free
unsent descriptors. So in that case, once everything is done, tx_bd_ci
will be the same as before axienet_start_xmit is called.

>> +		lp->tx_bd_ci += i;
>> +		if (lp->tx_bd_ci >= lp->tx_bd_num)
>> +			lp->tx_bd_ci %= lp->tx_bd_num;
>> +	}
>> +
>> +	return packets;
>>  }
>> 
>>  /**
>> @@ -891,13 +899,10 @@ static int axienet_tx_poll(struct napi_struct *napi,
>> int budget)
>>  	u32 size = 0;
>>  	int packets;
>> 
>> -	packets = axienet_free_tx_chain(lp, lp->tx_bd_ci, budget, false,
>> &size, budget);
>> +	packets = axienet_free_tx_chain(lp, lp->tx_bd_ci, lp->tx_bd_num,
> 
> Why do we need to pass tx_bd_num here? Is budget not sufficient?

Imagine if the user sets the TX ring to 1 packet. On completion, we will
consume the SKB. Then we will enter an infinite loop as we will still
have budget for more packets but we will keep checking the same
descriptor for more packets. By setting a maximum descriptor count we
ensure that we only go through the TX ring once.

--Sean

>> false,
>> +					&size, budget);
>> 
>>  	if (packets) {
>> -		lp->tx_bd_ci += packets;
>> -		if (lp->tx_bd_ci >= lp->tx_bd_num)
>> -			lp->tx_bd_ci %= lp->tx_bd_num;
>> -
>>  		u64_stats_update_begin(&lp->tx_stat_sync);
>>  		u64_stats_add(&lp->tx_packets, packets);
>>  		u64_stats_add(&lp->tx_bytes, size);
>> @@ -1003,7 +1008,7 @@ axienet_start_xmit(struct sk_buff *skb, struct
>> net_device *ndev)
>>  				netdev_err(ndev, "TX DMA mapping
>> error\n");
>>  			ndev->stats.tx_dropped++;
>>  			axienet_free_tx_chain(lp, orig_tail_ptr, ii + 1,
>> -					      true, NULL, 0);
>> +					      true, NULL, INT_MAX);
>>  			return NETDEV_TX_OK;
>>  		}
>>  		desc_set_phys_addr(lp, phys, cur_p);
>> --
>> 2.35.1.1320.gc452695387.dirty
> 

