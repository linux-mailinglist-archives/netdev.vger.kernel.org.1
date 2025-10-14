Return-Path: <netdev+bounces-229209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332B3BD95B1
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA34F541E3C
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B5A313E01;
	Tue, 14 Oct 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ASHJO6Qc"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89FE2BF3CF;
	Tue, 14 Oct 2025 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445254; cv=none; b=GAKJWzAdqoQuhMFFlWaKaSQj4G1cqxz/ek24sKKEONFd0uLw+zX6chLEF6PhodtvYhgJSHCYfBTp5RWmCJk4aJiVZe71gntiBI50xKt/Kq9XsVGItAf9oB4SyB0YhhYAl3g1uzhih/kdRVrS2eosDU5I/o6hcAPYLB8vHTQEg90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445254; c=relaxed/simple;
	bh=oQLAeDQyVmjWiiZUx6Tf/I63RDM10DhJXwC5sITM4Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hvHXkaMiAuvHt2K/kCeBeI4lQyE0/ExB3hkD4t3jqRNqUab5ST90wL7N8hb9CzK4WOQViGOIbLgjMPlNzWKoFbnua2E1XphVRu7xThnM5OhqhllvZfl8RtbK1ECmKBzvlL7BGffhCZb2OyytbXhosCqmdcriOwFr504yEKpnP2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ASHJO6Qc; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59ECXwC61067233;
	Tue, 14 Oct 2025 07:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760445238;
	bh=bvs+B4pFlwvao7cFjAjIJQY0fsHlgPIJmdN1Y1I3xzs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ASHJO6QcWEH818cl89M0aSyZFzA5x1GoqKsJ1ZolgA6+ZZhYnZFC8p+VBtU7WGefO
	 fJOCq3+noG99JgDxpy/kn7IJghBCclly58SY5TIYQ+OGNB4DoBDJBcGNsi4thTKKFv
	 bNf48hKSaRfq2MgEaCt1OtGmw6yaQ7o34wwIazy8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59ECXwdZ439585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 14 Oct 2025 07:33:58 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 14
 Oct 2025 07:33:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 07:33:57 -0500
Received: from [172.24.231.225] (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59ECXsED034631;
	Tue, 14 Oct 2025 07:33:55 -0500
Message-ID: <2b3d5d75-22d8-4b5c-8445-a5ca3fe0bc69@ti.com>
Date: Tue, 14 Oct 2025 18:03:54 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpts: fix timestamp loss due
 to race conditions
To: Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <davem@davemloft.net>, <kuba@kernel.org>, <andrew+netdev@lunn.ch>,
        <edumazet@google.com>
CC: <linux-kernel@vger.kernel.org>, <c-vankar@ti.com>, <s-vadapalli@ti.com>,
        <danishanwar@ti.com>
References: <20251010150821.838902-1-a-garg7@ti.com>
 <629ffe15-e4d8-4b0c-a909-55fa4248965a@redhat.com>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <629ffe15-e4d8-4b0c-a909-55fa4248965a@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 14/10/25 15:02, Paolo Abeni wrote:
> On 10/10/25 5:08 PM, Aksh Garg wrote:
>> diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
>> index 59d6ab989c55..2e9719264ba5 100644
>> --- a/drivers/net/ethernet/ti/am65-cpts.c
>> +++ b/drivers/net/ethernet/ti/am65-cpts.c
>> @@ -163,7 +163,9 @@ struct am65_cpts {
>>  	struct device_node *clk_mux_np;
>>  	struct clk *refclk;
>>  	u32 refclk_freq;
>> -	struct list_head events;
>> +	/* separate lists to handle TX and RX timestamp independently */
>> +	struct list_head events_tx;
>> +	struct list_head events_rx;
>>  	struct list_head pool;
>>  	struct am65_cpts_event pool_data[AM65_CPTS_MAX_EVENTS];
>>  	spinlock_t lock; /* protects events lists*/
>> @@ -172,6 +174,7 @@ struct am65_cpts {
>>  	u32 ts_add_val;
>>  	int irq;
>>  	struct mutex ptp_clk_lock; /* PHC access sync */
>> +	struct mutex rx_ts_lock; /* serialize RX timestamp match */
>>  	u64 timestamp;
>>  	u32 genf_enable;
>>  	u32 hw_ts_enable;
>> @@ -245,7 +248,16 @@ static int am65_cpts_cpts_purge_events(struct am65_cpts *cpts)
>>  	struct am65_cpts_event *event;
>>  	int removed = 0;
>>  
>> -	list_for_each_safe(this, next, &cpts->events) {
>> +	list_for_each_safe(this, next, &cpts->events_tx) {
>> +		event = list_entry(this, struct am65_cpts_event, list);
>> +		if (time_after(jiffies, event->tmo)) {
>> +			list_del_init(&event->list);
>> +			list_add(&event->list, &cpts->pool);
>> +			++removed;
>> +		}
>> +	}
> 
> Minor nit: you can move the loop in a separate helper taking the event
> list as an argument and avoid some code duplication with the the rx loop.

I will create a helper function for this.

> 
>> +
>> +	list_for_each_safe(this, next, &cpts->events_rx) {
>>  		event = list_entry(this, struct am65_cpts_event, list);
>>  		if (time_after(jiffies, event->tmo)) {
>>  			list_del_init(&event->list);
>> @@ -306,11 +318,21 @@ static int __am65_cpts_fifo_read(struct am65_cpts *cpts)
>>  				cpts->timestamp);
>>  			break;
>>  		case AM65_CPTS_EV_RX:
>> +			event->tmo = jiffies +
>> +				msecs_to_jiffies(AM65_CPTS_EVENT_RX_TX_TIMEOUT);
>> +
>> +			list_move_tail(&event->list, &cpts->events_rx);
>> +
>> +			dev_dbg(cpts->dev,
>> +				"AM65_CPTS_EV_RX e1:%08x e2:%08x t:%lld\n",
>> +				event->event1, event->event2,
>> +				event->timestamp);
>> +			break;
>>  		case AM65_CPTS_EV_TX:
>>  			event->tmo = jiffies +
>>  				msecs_to_jiffies(AM65_CPTS_EVENT_RX_TX_TIMEOUT);
>>  
>> -			list_move_tail(&event->list, &cpts->events);
>> +			list_move_tail(&event->list, &cpts->events_tx);
> 
> Similar thing here.

The dbg_dev() message have different debug messages. So, do you think a 
helper function here makes much difference?

> 
>>  
>>  			dev_dbg(cpts->dev,
>>  				"AM65_CPTS_EV_TX e1:%08x e2:%08x t:%lld\n",
>> @@ -828,7 +850,7 @@ static bool am65_cpts_match_tx_ts(struct am65_cpts *cpts,
>>  	return found;
>>  }
>>  
>> -static void am65_cpts_find_ts(struct am65_cpts *cpts)
>> +static void am65_cpts_find_tx_ts(struct am65_cpts *cpts)
>>  {
>>  	struct am65_cpts_event *event;
>>  	struct list_head *this, *next;
>> @@ -837,7 +859,7 @@ static void am65_cpts_find_ts(struct am65_cpts *cpts)
>>  	LIST_HEAD(events);
>>  
>>  	spin_lock_irqsave(&cpts->lock, flags);
>> -	list_splice_init(&cpts->events, &events);
>> +	list_splice_init(&cpts->events_tx, &events);
>>  	spin_unlock_irqrestore(&cpts->lock, flags);
>>  
>>  	list_for_each_safe(this, next, &events) {
>> @@ -850,7 +872,7 @@ static void am65_cpts_find_ts(struct am65_cpts *cpts)
>>  	}
>>  
>>  	spin_lock_irqsave(&cpts->lock, flags);
>> -	list_splice_tail(&events, &cpts->events);
>> +	list_splice_tail(&events, &cpts->events_tx);
> 
> I see the behavior is pre-existing, but why splicing on tail? events
> added in between should be older???

I will handle this in future patch.

> 
>>  	list_splice_tail(&events_free, &cpts->pool);
>>  	spin_unlock_irqrestore(&cpts->lock, flags);
>>  }
>> @@ -861,7 +883,7 @@ static long am65_cpts_ts_work(struct ptp_clock_info *ptp)
>>  	unsigned long flags;
>>  	long delay = -1;
>>  
>> -	am65_cpts_find_ts(cpts);
>> +	am65_cpts_find_tx_ts(cpts);
>>  
>>  	spin_lock_irqsave(&cpts->txq.lock, flags);
>>  	if (!skb_queue_empty(&cpts->txq))
>> @@ -899,16 +921,21 @@ static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, u32 skb_mtype_seqid)
>>  {
>>  	struct list_head *this, *next;
>>  	struct am65_cpts_event *event;
>> +	LIST_HEAD(events_free);
>>  	unsigned long flags;
>> +	LIST_HEAD(events);
>>  	u32 mtype_seqid;
>>  	u64 ns = 0;
>>  
>>  	spin_lock_irqsave(&cpts->lock, flags);
>>  	__am65_cpts_fifo_read(cpts);
>> -	list_for_each_safe(this, next, &cpts->events) {
>> +	list_splice_init(&cpts->events_rx, &events);
>> +	spin_unlock_irqrestore(&cpts->lock, flags);
> 
> Why are you changing the behaviour here, releasing and reacquiring the
> cpts->lock? It looks like a separate change, if needed at all.

It was added as an optimization, as acquiring the lock for entire loop 
will delay other events to be handled. I will add this optimization in 
future patch.

> 
>> +	list_for_each_safe(this, next, &events) {
>>  		event = list_entry(this, struct am65_cpts_event, list);
>>  		if (time_after(jiffies, event->tmo)) {
>> -			list_move(&event->list, &cpts->pool);
>> +			list_move(&event->list, &events_free);
>>  			continue;
>>  		}
>>  
>> @@ -919,10 +946,14 @@ static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, u32 skb_mtype_seqid)
>>  
>>  		if (mtype_seqid == skb_mtype_seqid) {
>>  			ns = event->timestamp;
>> -			list_move(&event->list, &cpts->pool);
>> +			list_move(&event->list, &events_free);
>>  			break;
>>  		}
>>  	}
>> +
>> +	spin_lock_irqsave(&cpts->lock, flags);
>> +	list_splice_tail(&events, &cpts->events_rx);
>> +	list_splice_tail(&events_free, &cpts->pool);
>>  	spin_unlock_irqrestore(&cpts->lock, flags);
>>  
>>  	return ns;
>> @@ -948,7 +979,9 @@ void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb)
>>  
>>  	dev_dbg(cpts->dev, "%s mtype seqid %08x\n", __func__, skb_cb->skb_mtype_seqid);
>>  
>> +	mutex_lock(&cpts->rx_ts_lock);
>>  	ns = am65_cpts_find_rx_ts(cpts, skb_cb->skb_mtype_seqid);
>> +	mutex_unlock(&cpts->rx_ts_lock);
> 
> The call chain is:
> 
> am65_cpsw_nuss_rx_poll() -> am65_cpsw_nuss_rx_packets() ->
> am65_cpts_rx_timestamp()
> 
> this runs in BH context, can't acquire a mutex. Also I don't see why any
> additional locking would be needed?
> 

The rationale for adding this lock was to handle concurrent RX threads 
accessing the timestamp event list. If one RX thread moves all events 
from events_rx to a temporary list and releases the spinlock, another 
concurrent RX thread could acquire the lock and find events_rx empty, 
potentially missing its timestamp.

I need clarification on the RX processing behavior: Can 
am65_cpsw_nuss_rx_packets() be called for a new RX packet concurrently 
while a previous RX packet is still being processed, or is RX processing 
serialized? If RX processing is serialized, then the lock is not 
required at all.

Anyways, I will remove the lock from this patch, as it was a part of the 
optimization mentioned above.

> /P
> 


