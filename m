Return-Path: <netdev+bounces-125569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD1C96DBE9
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E22A1C236D0
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABD1175A1;
	Thu,  5 Sep 2024 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PXEuWw9S"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C6E14A8B
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546871; cv=none; b=UmIOpyrlVNQc1GWLnEiQwAWnkBTbhMIg9vMVDcuHr8JDM2XrijK9ZgHuy84064H6xRxojMy85GOfZoi1vnjok3wDvDFOnvdQGqfrb9zS5pnk7QOmD2jk7fHUcbjDz2Peqbq6558DPVoEDWilgD+cfSCzDSTNKHUoBlTvzcn/fxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546871; c=relaxed/simple;
	bh=djmzTAjDrP0ZKXTynCjeBjflurfkA/511OhGIIyIVDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QioeI+f13yLRoNcKovn+F5HAIilJmL0Y+LdZDyUJh9PgsLhoMW/ChOsXnEmcxA5djpfLIATaIKC6RrIagSWJD5q7HkIVIFT0X0PsGuRuhjyxprFxIZQXnv44UBt7PMsc5UGEN09rEZISBUzbGXqOEtsM6z802uAMg30k+ry7F7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PXEuWw9S; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a9ad456d-eeff-4fac-a18d-0219fcc9f5ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725546867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7rbhxgQHH8FMAXCYEogfAFPlvDv513nAGuaFUXrBNY=;
	b=PXEuWw9S0BYumid1/jVD3PdysZxv8u1KLegtebjFDKS2p1CXX7ZSeSyO/adNElmfF+I5MK
	LM6/5OXhNKdvGLltyWfUaXHAQUs6A4CO1ybibDyAgFUejesYumh90dqmMTwbbdKOwIDDfX
	ZwgfrB3XaJXhkT2gSd4Eie+qSb/l1NY=
Date: Thu, 5 Sep 2024 10:34:15 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: xilinx: axienet: Fix IRQ coalescing packet count
 overflow
To: Simon Horman <horms@kernel.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
 linux-arm-kernel@lists.infradead.org,
 Ariane Keller <ariane.keller@tik.ee.ethz.ch>, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>, Andy Chiu <andy.chiu@sifive.com>
References: <20240903180059.4134461-1-sean.anderson@linux.dev>
 <20240904160013.GX4792@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240904160013.GX4792@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/4/24 12:00, Simon Horman wrote:
> On Tue, Sep 03, 2024 at 02:00:59PM -0400, Sean Anderson wrote:
>> If coalesce_count is greater than 255 it will not fit in the register and
>> will overflow. Clamp it to 255 for more-predictable results.
> 
> Hi Sean,
> 
> Can this occur in practice?

Yes. Simply do `ethtool -C ethX rx-frames 300` or something similar and
you will end up with a limit of 44 instead. I ran into this with DIM and
was wondering why the highest-throughput setting (256) was behaving so
poorly...

>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> 
> nit: I think it is usual for the order of these tags to be reversed.

OK

>> ---
>> 
>>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> index 9aeb7b9f3ae4..5f27fc1c4375 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> @@ -252,7 +252,8 @@ static u32 axienet_usec_to_timer(struct axienet_local *lp, u32 coalesce_usec)
>>  static void axienet_dma_start(struct axienet_local *lp)
>>  {
>>  	/* Start updating the Rx channel control register */
>> -	lp->rx_dma_cr = (lp->coalesce_count_rx << XAXIDMA_COALESCE_SHIFT) |
>> +	lp->rx_dma_cr = (min(lp->coalesce_count_rx, 255) <<
>> +			 XAXIDMA_COALESCE_SHIFT) |
>>  			XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
> 
> nit: it would be nice to avoid using a naked 255 here.
>      Perhaps: #define XAXIDMA_COALESCE_MAX 0xff

OK, but this is the same as the limit used in axienet_usec_to_timer.

--Sean

>>  	/* Only set interrupt delay timer if not generating an interrupt on
>>  	 * the first RX packet. Otherwise leave at 0 to disable delay interrupt.
>> @@ -264,7 +265,8 @@ static void axienet_dma_start(struct axienet_local *lp)
>>  	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
>>  
>>  	/* Start updating the Tx channel control register */
>> -	lp->tx_dma_cr = (lp->coalesce_count_tx << XAXIDMA_COALESCE_SHIFT) |
>> +	lp->tx_dma_cr = (min(lp->coalesce_count_tx, 255) <<
>> +			 XAXIDMA_COALESCE_SHIFT) |
>>  			XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
>>  	/* Only set interrupt delay timer if not generating an interrupt on
>>  	 * the first TX packet. Otherwise leave at 0 to disable delay interrupt.
>> -- 
>> 2.35.1.1320.gc452695387.dirty
>> 
>> 

