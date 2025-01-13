Return-Path: <netdev+bounces-157831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0409A0BF20
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5DA3A9DFD
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86721BFE05;
	Mon, 13 Jan 2025 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dfz1Mfh+"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E87189906
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736790342; cv=none; b=FdwKfr6H3nMC1BB+Ac2JLspV4Nm1J95vORYqDAg8Vw5RaniX09eth6WKwOLs1IRAhUODj/ACzVbN0r91UvxzlGHsJ+hFQQrsb9irnySHxx2DB58/RRxTG+JG81axvXnSzIRsIgNLRjvfDpW0/xz+bupzsle9gNdMhefj6DhxkpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736790342; c=relaxed/simple;
	bh=ZgNonFxRSeIPx4QjI8Huu2hRtg8ill3OoJhI7qEKj2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2ik+VcbLMnOIb3gKu4/fTmEGIlK53gyEmrn1KhqmniLMhDNhtzpa9j/3wtCwc+eybCFhsWuF1NgNJR/GeKZWBQDJYp58dWn5dV0ugQAHfBsVy3/6OB1bOAT/KfBsNtVF5xJdQYvXUknYBDSiU5sa9tspGP7TBqjDxzt4EfPCq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dfz1Mfh+; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <14d13d7e-ef1d-4dcc-bd18-7a6709616678@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736790328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ooWFsB+eKdu1sbtdXlptO9kQd/DQBS8X4SFDPHoCJ30=;
	b=Dfz1Mfh+rNwiXUS4YRtkTYvcug+evu4trTHmj+o6EdBUgPRjKeAEFc656O4id0vm7uj7/K
	FT2voXbBSL3XnH5twbA+RQk0Z+QmHpXenrblPXhFB0T+aPz/zjThZM01I4d13jDKovDCay
	dkP2hxzJmOGR9ICN8TTYHast6gyYqck=
Date: Mon, 13 Jan 2025 12:45:24 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 5/6] net: xilinx: axienet: Get coalesce
 parameters from driver state
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Shannon Nelson
 <shannon.nelson@amd.com>, Michal Simek <michal.simek@amd.com>,
 linux-kernel@vger.kernel.org
References: <20250110192616.2075055-1-sean.anderson@linux.dev>
 <20250110192616.2075055-6-sean.anderson@linux.dev>
 <20250113173910.GF5497@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250113173910.GF5497@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Simon,

On 1/13/25 12:39, Simon Horman wrote:
> On Fri, Jan 10, 2025 at 02:26:15PM -0500, Sean Anderson wrote:
>> The cr variables now contain the same values as the control registers
>> themselves. Extract/calculate the values from the variables instead of
>> saving the user-specified values. This allows us to remove some
>> bookeeping, and also lets the user know what the actual coalesce
>> settings are.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> Reviewed by: Shannon Nelson <shannon.nelson@amd.com>
> 
> Hi Sean,
> 
> Unfortunately this series does not appear to apply cleanly to net-next.
> Which is our CI is currently unable to cope with :(
> 
> Please consider rebasing and reposting.

As noted in the cover letter, this series depends on [1] (now [2]). It
will apply cleanly without rebasing once that patch is applied. So maybe
you can re-run the CI at that time.

--Sean

[1] https://lore.kernel.org/netdev/20250110190726.2057790-1-sean.anderson@linux.dev/
[2] https://lore.kernel.org/netdev/20250113163001.2335235-1-sean.anderson@linux.dev

>> ---
>> 
>> (no changes since v2)
>> 
>> Changes in v2:
>> - New
>> 
>>  drivers/net/ethernet/xilinx/xilinx_axienet.h  |  8 ---
>>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 70 +++++++++++++------
>>  2 files changed, 47 insertions(+), 31 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> index 6b8e550c2155..45d8d80dbb1a 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> @@ -533,10 +533,6 @@ struct skbuf_dma_descriptor {
>>   *		  supported, the maximum frame size would be 9k. Else it is
>>   *		  1522 bytes (assuming support for basic VLAN)
>>   * @rxmem:	Stores rx memory size for jumbo frame handling.
>> - * @coalesce_count_rx:	Store the irq coalesce on RX side.
>> - * @coalesce_usec_rx:	IRQ coalesce delay for RX
>> - * @coalesce_count_tx:	Store the irq coalesce on TX side.
>> - * @coalesce_usec_tx:	IRQ coalesce delay for TX
>>   * @use_dmaengine: flag to check dmaengine framework usage.
>>   * @tx_chan:	TX DMA channel.
>>   * @rx_chan:	RX DMA channel.
>> @@ -615,10 +611,6 @@ struct axienet_local {
>>  	u32 max_frm_size;
>>  	u32 rxmem;
>>  
>> -	u32 coalesce_count_rx;
>> -	u32 coalesce_usec_rx;
>> -	u32 coalesce_count_tx;
>> -	u32 coalesce_usec_tx;
>>  	u8  use_dmaengine;
>>  	struct dma_chan *tx_chan;
>>  	struct dma_chan *rx_chan;
> 
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> 
> ...
> 
>> @@ -260,6 +264,23 @@ static u32 axienet_calc_cr(struct axienet_local *lp, u32 count, u32 usec)
>>  	return cr;
>>  }
>>  
>> +/**
>> + * axienet_cr_params() - Extract coalesce parameters from the CR
> 
> nit: axienet_coalesce_params
> 
>> + * @lp: Device private data
>> + * @cr: The control register to parse
>> + * @count: Number of packets before an interrupt
>> + * @usec: Idle time (in usec) before an interrupt
>> + */
>> +static void axienet_coalesce_params(struct axienet_local *lp, u32 cr,
>> +				    u32 *count, u32 *usec)
>> +{
>> +	u64 clk_rate = axienet_dma_rate(lp);
>> +	u64 timer = FIELD_GET(XAXIDMA_DELAY_MASK, cr);
>> +
>> +	*count = FIELD_GET(XAXIDMA_COALESCE_MASK, cr);
>> +	*usec = DIV64_U64_ROUND_CLOSEST(timer * XAXIDMA_DELAY_SCALE, clk_rate);
>> +}
>> +
>>  /**
>>   * axienet_dma_start - Set up DMA registers and start DMA operation
>>   * @lp:		Pointer to the axienet_local structure

