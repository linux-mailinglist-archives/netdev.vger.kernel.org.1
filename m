Return-Path: <netdev+bounces-127830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298B6976C2C
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1621C23EE8
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 14:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AE71B1D56;
	Thu, 12 Sep 2024 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uOJ2ES/i"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD5A1AAE0A
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151468; cv=none; b=WnrwA/HxkPvTVPDCRy2otqo9QcrZ1Dl5V24LCiUGaqEoZCX3wlG5uliOaSFTtiTfm44QVOqAXDhPcEPtzv5X6qI/lx2IG85PtW/rD3dSaiFFTCnM26xBO7VYVgUpXnqn6VLXQM0Jh0w5ha4YXazfl3XKuj/b03zQ8GQcD1mDx/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151468; c=relaxed/simple;
	bh=CUk8LeFaw7nwK89uItUU8m4VSzxPAj6laAOWqpgdAdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNMRev1NOrITXPM6S18PQF08yiJjtJw0Xoq9lJrtGCEMRB6D9tXKg6C5tRlpPkjHE1Oaa8/35bsCUFUf8YhdrckyEQgkh1/AIjtoq4Rfz7MeW89k5cthOkVkdwOMchmZU1Jx1M8meCKLj5OdVVkKrYZxSaJtyy6SrQvncMX1eGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uOJ2ES/i; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b26be717-a67e-4ee1-9393-3de6147b9c2e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726151461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTWJHgLcn4spfm5GWguWcfzJyLphgl0AC6/fahz7z7s=;
	b=uOJ2ES/ilsYa2yEI8S6LOlrkwIJQRzu8stg2al7F72G1f34CLeR4F4Rus9F2R+FJm7+I3z
	noe7cDxmJwwWVLTBkvYVDk8Yh4dqfmLIl6F2NZKJ08tejvHA7gc8q2TUCn2/uexXbVqQvv
	9xuMwfzRaSdsf+DRUBI7OfkCC4Ha0Po=
Date: Thu, 12 Sep 2024 10:30:56 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net: xilinx: axienet: Fix IRQ coalescing packet
 count overflow
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Gupta, Suraj" <Suraj.Gupta2@amd.com>,
 "Katakam, Harini" <harini.katakam@amd.com>
Cc: Andy Chiu <andy.chiu@sifive.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Simon Horman <horms@kernel.org>, Ariane Keller
 <ariane.keller@tik.ee.ethz.ch>, Daniel Borkmann <daniel@iogearbox.net>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "Simek, Michal"
 <michal.simek@amd.com>
References: <20240909230908.1319982-1-sean.anderson@linux.dev>
 <MN0PR12MB5953E38D1EEBF3F83172E2EEB79B2@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <MN0PR12MB5953E38D1EEBF3F83172E2EEB79B2@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/11/24 03:01, Pandey, Radhey Shyam wrote:
>> -----Original Message-----
>> From: Sean Anderson <sean.anderson@linux.dev>
>> Sent: Tuesday, September 10, 2024 4:39 AM
>> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; David S .
>> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
>> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
>> netdev@vger.kernel.org
>> Cc: Andy Chiu <andy.chiu@sifive.com>; linux-kernel@vger.kernel.org; Simon
>> Horman <horms@kernel.org>; Ariane Keller <ariane.keller@tik.ee.ethz.ch>;
>> Daniel Borkmann <daniel@iogearbox.net>; linux-arm-
>> kernel@lists.infradead.org; Simek, Michal <michal.simek@amd.com>; Sean
>> Anderson <sean.anderson@linux.dev>
>> Subject: [PATCH net v2] net: xilinx: axienet: Fix IRQ coalescing packet count
>> overflow
>> 
>> If coalece_count is greater than 255 it will not fit in the register and
>> will overflow. This can be reproduced by running
>> 
>>     # ethtool -C ethX rx-frames 256
>> 
>> which will result in a timeout of 0us instead. Fix this by clamping the
>> counts to the maximum value.
> After this fix - what is o/p we get on rx-frames read? I think silent clamping is not a great 
> idea and user won't know about it.  One alternative is to add check in set_coalesc 
> count for valid range? (Similar to axienet_ethtools_set_ringparam so that user is notified 
> for incorrect range)

The value reported will be unclamped. In [1] I improve the driver to
return the actual (clamped) value.

Remember that without this commit, we have silent wraparound instead. I
think clamping is much friendlier, since you at least get something
close to the rx-frames value, instead of zero!

This commit is just a fix for the overflow issue. To ensure it is
appropriate for backporting I have omitted any other
changes/improvements.

--Sean

[1] https://lore.kernel.org/netdev/20240909235208.1331065-6-sean.anderson@linux.dev/

>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet
>> driver")
>> ---
>> 
>> Changes in v2:
>> - Use FIELD_MAX to extract the max value from the mask
>> - Expand the commit message with an example on how to reproduce this
>>   issue
>> 
>>  drivers/net/ethernet/xilinx/xilinx_axienet.h      | 5 ++---
>>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 8 ++++++--
>>  2 files changed, 8 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> b/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> index 1223fcc1a8da..54db69893565 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> @@ -109,11 +109,10 @@
>>  #define XAXIDMA_BD_CTRL_TXEOF_MASK	0x04000000 /* Last tx packet
>> */
>>  #define XAXIDMA_BD_CTRL_ALL_MASK	0x0C000000 /* All control bits
>> */
>> 
>> -#define XAXIDMA_DELAY_MASK		0xFF000000 /* Delay timeout
>> counter */
>> -#define XAXIDMA_COALESCE_MASK		0x00FF0000 /* Coalesce
>> counter */
>> +#define XAXIDMA_DELAY_MASK		((u32)0xFF000000) /* Delay
>> timeout counter */
> 
> Adding typecast here looks odd. Any reason for it? 
> If needed we do it in specific case where it is required.
> 
>> +#define XAXIDMA_COALESCE_MASK		((u32)0x00FF0000) /*
>> Coalesce counter */
>> 
>>  #define XAXIDMA_DELAY_SHIFT		24
>> -#define XAXIDMA_COALESCE_SHIFT		16
>> 
>>  #define XAXIDMA_IRQ_IOC_MASK		0x00001000 /* Completion
>> intr */
>>  #define XAXIDMA_IRQ_DELAY_MASK		0x00002000 /* Delay
>> interrupt */
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> index 9eb300fc3590..89b63695293d 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> @@ -252,7 +252,9 @@ static u32 axienet_usec_to_timer(struct axienet_local
>> *lp, u32 coalesce_usec)
>>  static void axienet_dma_start(struct axienet_local *lp)
>>  {
>>  	/* Start updating the Rx channel control register */
>> -	lp->rx_dma_cr = (lp->coalesce_count_rx <<
>> XAXIDMA_COALESCE_SHIFT) |
>> +	lp->rx_dma_cr = FIELD_PREP(XAXIDMA_COALESCE_MASK,
>> +				   min(lp->coalesce_count_rx,
>> +
>> FIELD_MAX(XAXIDMA_COALESCE_MASK))) |
>>  			XAXIDMA_IRQ_IOC_MASK |
>> XAXIDMA_IRQ_ERROR_MASK;
>>  	/* Only set interrupt delay timer if not generating an interrupt on
>>  	 * the first RX packet. Otherwise leave at 0 to disable delay interrupt.
>> @@ -264,7 +266,9 @@ static void axienet_dma_start(struct axienet_local
>> *lp)
>>  	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
>> 
>>  	/* Start updating the Tx channel control register */
>> -	lp->tx_dma_cr = (lp->coalesce_count_tx <<
>> XAXIDMA_COALESCE_SHIFT) |
>> +	lp->tx_dma_cr = FIELD_PREP(XAXIDMA_COALESCE_MASK,
>> +				   min(lp->coalesce_count_tx,
>> +
>> FIELD_MAX(XAXIDMA_COALESCE_MASK))) |
>>  			XAXIDMA_IRQ_IOC_MASK |
>> XAXIDMA_IRQ_ERROR_MASK;
>>  	/* Only set interrupt delay timer if not generating an interrupt on
>>  	 * the first TX packet. Otherwise leave at 0 to disable delay interrupt.
>> --
>> 2.35.1.1320.gc452695387.dirty
> 

