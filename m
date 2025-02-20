Return-Path: <netdev+bounces-168190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B873AA3DFA5
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 284A77A957D
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E45200132;
	Thu, 20 Feb 2025 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="thybdZfO"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BF52040B5
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066974; cv=none; b=i0GhkEnuMgQmv1gnrnChAOdFx8DrWt+7k5SIdh/nvz7hKCId6E2XzcPBxC4CjFDDPc5FO0YmyGO7MxYrecGAee2QxlhVLQeBL2D0jApBBj5iyWTEyEB5cAU7d1ygYaxkiVGYSr12GPbeifRNuhjxO/hDA1RsqlUTtRMM3maVDCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066974; c=relaxed/simple;
	bh=nhYN2GbUzsXa4cjLPXbV4eUQPu/IKKaTnKG8XoaoATY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5HTdPx3Krx2vTCOAyu5G+C+rT8Nt7EGK/Nrn6b2HQkR0UAOiaItHQX9Hh7nmNEfMlB1RaUFFBnPmrFF+ZC1HPgfHVadxMeOOdySBFepW0kbzBTGnBSSOVmO8WjUR0LmLjwN0H4hXzbM1ZDer+f7HhFvFiQ1ZHNUNTycI45jDCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=thybdZfO; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <10a50a6c-a6be-4723-80b3-62119f667977@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740066960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Up76eQNOfacddlQs6IG6ddJKmIeZ0tEzsFl4x96svGY=;
	b=thybdZfO1kWLW7dneUHxK3W2lJuskGvpikEy0T7i1mCJVlui2m7i/emTde1TfrM5woF6Nn
	e9agtZ9W5YY941OvQTRP/7VFbwclmcLpMA8eLehw253qrTKxGEb1yz2c7g8QbgqgYhjkyj
	Cs5Pj6HLKRHHyipCxzgd+B2AT1pxqHo=
Date: Thu, 20 Feb 2025 10:55:45 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: cadence: macb: Implement BQL
To: Jakub Kicinski <kuba@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
References: <20250214211643.2617340-1-sean.anderson@linux.dev>
 <20250218175700.4493dc49@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250218175700.4493dc49@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/18/25 20:57, Jakub Kicinski wrote:
> On Fri, 14 Feb 2025 16:16:43 -0500 Sean Anderson wrote:
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index 48496209fb16..63c65b4bb348 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -1081,6 +1081,9 @@ static void macb_tx_error_task(struct work_struct *work)
>>  						      tx_error_task);
>>  	bool			halt_timeout = false;
>>  	struct macb		*bp = queue->bp;
>> +	u32			queue_index = queue - bp->queues;
> 
> nit: breaking reverse xmas tree here

It has to happen here since bp isn't available earlier.

>> +	u32			packets = 0;
>> +	u32			bytes = 0;
>>  	struct macb_tx_skb	*tx_skb;
>>  	struct macb_dma_desc	*desc;
>>  	struct sk_buff		*skb;
> 
> 
>> @@ -3019,6 +3033,7 @@ static int macb_close(struct net_device *dev)
>>  	netif_tx_stop_all_queues(dev);
>>  
>>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
>> +		netdev_tx_reset_queue(netdev_get_tx_queue(dev, q));
>>  		napi_disable(&queue->napi_rx);
>>  		napi_disable(&queue->napi_tx);
> 
> I think you should reset after napi_disable()? 
> Lest NAPI runs after the reset and tries to complete on an empty queue..

OK.

--Sean

