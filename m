Return-Path: <netdev+bounces-127007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4329739C7
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3091C2424F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2E7194082;
	Tue, 10 Sep 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hsKYluYQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AE8142659
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978284; cv=none; b=r4F+PY9vhtqiDW2KGbhKg2B7WQoMXbu/d1P5MSxlv9g4ttKgpv63AaF046wOzlyBBsBENJqxhc8aZHiNyrISZgtFhPUEjV6oSkl40CpROtbVme0872UTnAytY320nidix4nOngqIb+5tRwoZx/2vYv+0M98l1O6oZcq8IUcDYEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978284; c=relaxed/simple;
	bh=CRMu0B4kkJ6/dmoWosy7BxE/PMA6DVz7EyRP5fynT28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rx1qnsP9lQlOvj64HYWvmo9ZQ1Dr6pC2Ve7w+nIJjHNBus6xvvw5GUYmxjtMVDZk4wpLrBjffgCjA8jihhaJO3wb1tuM460IK6EVFA85vXZqKLAG29BVeGpwRpCjDoEMFcCSXRCLpf8Z47/dTF3qIXe5gh2RYzBq8N2E9kmvP3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hsKYluYQ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <318a13f6-da2d-4ba4-a51c-2f8444444bbf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725978280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZLpOStkN6/rHZsIMHD5J5wm23tF3B9XqkgPQ/y3a6A=;
	b=hsKYluYQ41lW262/NEUOxUkIZv8C/BJUKjLT4hSdJXOIc9sy08L0A+IaXrVyAiuSMtQXVK
	sPsird/kvx4IJaB66mtnBV92n6k504YIo7JwLQld5JYXXAxV7q0UNFBBhUNi2ANk4xDTeg
	4C3VuLY+4XFDUWvYWEP12Xy22Oi6it8=
Date: Tue, 10 Sep 2024 10:24:36 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net: xilinx: axienet: Fix packet counting
To: Jakub Kicinski <kuba@kernel.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Andy Chiu <andy.chiu@sifive.com>, Daniel Borkmann <daniel@iogearbox.net>
References: <20240906164227.505984-1-sean.anderson@linux.dev>
 <20240909180013.4e064fd5@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240909180013.4e064fd5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/9/24 21:00, Jakub Kicinski wrote:
> On Fri,  6 Sep 2024 12:42:27 -0400 Sean Anderson wrote:
>> axienet_free_tx_chain returns the number of DMA descriptors it's
>> handled. However, axienet_tx_poll treats the return as the number of
>> packets. When scatter-gather SKBs are enabled, a single packet may use
>> multiple DMA descriptors, which causes incorrect packet counts. Fix this
>> by explicitly keepting track of the number of packets processed as
>> separate from the DMA descriptors.
>> 
>> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> 
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> index 9aeb7b9f3ae4..556033849d55 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> @@ -670,21 +670,21 @@ static int axienet_device_reset(struct net_device *ndev)
>>   * @force:	Whether to clean descriptors even if not complete
>>   * @sizep:	Pointer to a u32 filled with the total sum of all bytes
>>   *		in all cleaned-up descriptors. Ignored if NULL.
>> - * @budget:	NAPI budget (use 0 when not called from NAPI poll)
>> + * @budget:	NAPI budget (use INT_MAX when not called from NAPI poll)
> 
> use INT_MAX and force=true when ... ?
> To make sure the dependency is clear.
> But actually...
> 
>>   *
>>   * Would either be called after a successful transmit operation, or after
>>   * there was an error when setting up the chain.
>> - * Returns the number of descriptors handled.
>> + * Returns the number of packets handled.
>>   */
>>  static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
>>  				 int nr_bds, bool force, u32 *sizep, int budget)
>>  {
>>  	struct axidma_bd *cur_p;
>>  	unsigned int status;
>> +	int i, packets = 0;
>>  	dma_addr_t phys;
>> -	int i;
>>  
>> -	for (i = 0; i < nr_bds; i++) {
>> +	for (i = 0; i < nr_bds && packets < budget; i++) {
> 
> why are you doing this? To make sure drivers doesn't complete more 
> than "budget" Tx skbs? The budget is really for Rx, for Tx you can
> use a reasonable fixed value, independent of what budget core
> passes in, e.g. 128. See:
> https://www.kernel.org/doc/html/next/networking/napi.html#datapath-api

I read this but it was unclear to me because it seems oriented towards
"combined" NAPI instances, while we have separate instances for RX and
TX. So even for TX-only instances, we can ignore budget?

>>  		cur_p = &lp->tx_bd_v[(first_bd + i) % lp->tx_bd_num];
>>  		status = cur_p->status;
>>  
>> @@ -701,8 +701,10 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
>>  				 (cur_p->cntrl & XAXIDMA_BD_CTRL_LENGTH_MASK),
>>  				 DMA_TO_DEVICE);
>>  
>> -		if (cur_p->skb && (status & XAXIDMA_BD_STS_COMPLETE_MASK))
>> -			napi_consume_skb(cur_p->skb, budget);
>> +		if (cur_p->skb && (status & XAXIDMA_BD_STS_COMPLETE_MASK)) {
>> +			napi_consume_skb(cur_p->skb, force ? 0 : budget);
>> +			packets++;
>> +		}
>>  
>>  		cur_p->app0 = 0;
>>  		cur_p->app1 = 0;
>> @@ -718,7 +720,13 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
>>  			*sizep += status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
>>  	}
>>  
>> -	return i;
>> +	if (!force) {
>> +		lp->tx_bd_ci += i;
>> +		if (lp->tx_bd_ci >= lp->tx_bd_num)
>> +			lp->tx_bd_ci %= lp->tx_bd_num;
>> +	}
> 
> Moving this chunk into axienet_free_tx_chain() is a noop, right?
> Please avoid code cleanups in fixes.

The relevant variable (number of descriptors handled) is no longer
returned to axienet_tx_poll, so it can't update the current descriptor
properly.

--Sean

>> +	return packets;
>>  }
>>  
>>  /**

