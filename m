Return-Path: <netdev+bounces-128177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD157978635
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 18:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51A6CB234F3
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 16:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5778780C04;
	Fri, 13 Sep 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qPCAZNKK"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86967EF09
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246314; cv=none; b=o3W8pCbPWWQfQKLdFj2DKoW2FSoSLCjRadOX/wLoqpUTFn2+4zAuIrph0u9WMyIu/3dRN1kgue+VRaKzaVZC2A46t6Kouywx8KxaNZfTISOr8DpPe7bHqsLqclf/Oe4FB9KGg3N4g/o/+7fRyud0xzM8QseoJ5FwoYT5HPV2J4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246314; c=relaxed/simple;
	bh=m0KfwnxjycrKvrrK/6Ha/CRVQ4CxJDVEVb0zF9eBJWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOBluP8pulKpiBNIa+aTdDS+8sgQElWrZ14xHuK3+b39FYY1Jsx7i+LyLSSYDFrn9jG4+UY8nesV3yoaN3hcaWvhod5BOM55vuR2e81wDhEZ+9yvZZ/LsitlgPsIKcLctPJE+/CgFFFcwM/q2egtl5SrzLDwb+G2Yt/cdm7Aguo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qPCAZNKK; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dd8369d8-7f3d-467c-afba-abb149bb5942@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726246310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IhlnxT9KTSM/GX5pPXvuEwpGZ4YYYm1EVWV1M5DWdR8=;
	b=qPCAZNKKyEJf5hFHq/R6ahRFlJbfSFJzeVruH5FWzS1QB5jZbPkRrraU0F3/A7YEiuAS0H
	SV6zyasz7b03klKHTxAsW+S692m0ob+ty+uIFObV2XhyACYTLeFvUcmcU6watWwEuaLgjA
	x5ZkoKzn/zOQfjvYxcK/E5YP6vtBGoM=
Date: Fri, 13 Sep 2024 12:51:45 -0400
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
> 
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

Sorry, I missed this on my first read.

This is necessary for...

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

this expression. Since min will complain if the types of its arguments
differ. Since coalesce_count_rx is a u32, and integer constants default
to int, I cast the mask to u32 above. Although a U suffix would have
also worked.

--Sean

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

