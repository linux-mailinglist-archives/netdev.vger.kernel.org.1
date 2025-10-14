Return-Path: <netdev+bounces-229136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A242BD870F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B5964E6856
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6A62EAB7A;
	Tue, 14 Oct 2025 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWBViclZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3799B2AEF5
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434328; cv=none; b=kEjbVNKmJXg6kK/FGuTI8XxQSuFxgt2XupctgfWOuJWYyHz1OsciyKCEAVmHcP/E4Jcnukw3CuggeXmWSkUsH0ubUswVxaaDhvkqJs37YvNLXB6iSFrd4YEQnaPW9b0s15PzA18I9Pz3daDwuAKVBelKFRjTqpR+6sNQEhfICMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434328; c=relaxed/simple;
	bh=eRzM5C9qWaNHhC1MvvT3VmhBXsn9RAKRCJSHqOQCu68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwlueJWUc8yPRg+dtkPd7f/DYFFvMNkNow3QdMTIB2s95WjcAJL0zARQsC4xOzMq3a6CYEGEBTXSNSJSNQ++H1dhEyQVhwTawGgZ8NGvqnyZlL8TAftO+iJiTUOFP517qfK5r+9edWhUiFtOywxsAWjhZf1hFbDOuf+5tRkLuiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWBViclZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760434325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QZlc0shzy81sMsvIKnfBpa7QTHlQS3qga/okOnQIR4=;
	b=gWBViclZzJGHababD+/C83ejCNlxtgr5tRz5FGGQcV/TwJhVrBBNHofiF/fmpDhHrY09YZ
	jRmEf9Asj5pEXHBHXVoGAsLU6mx/jqTnaGJbdjSxdbJLNTNoPZlkt/8Z6VhgPpLh0eMPff
	eq4wNQYRiCQBQmFG5OmS6cxUoAVon2U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-9dPmOI8UPTqhrgq95IJ4ig-1; Tue, 14 Oct 2025 05:32:04 -0400
X-MC-Unique: 9dPmOI8UPTqhrgq95IJ4ig-1
X-Mimecast-MFC-AGG-ID: 9dPmOI8UPTqhrgq95IJ4ig_1760434323
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso3846855f8f.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 02:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434323; x=1761039123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QZlc0shzy81sMsvIKnfBpa7QTHlQS3qga/okOnQIR4=;
        b=KWLcPOhuPZIDhvqJNx8T5luWqcwd5QXQjDKh8+1EJZmsV/32D9JifqvcBQU0N/UnE+
         7ApExx+broCqMDb7l4GhRJXjlhHG4IbKu6vBXEZQ9uR0s+hDYpmdHDJDCcc2tOJ3Y9UO
         cwPEsOV45rZuJLrP3FosMt+n3r+za3EjqjmuSUD9AsKNojFpbNblxLcCNsxuVXSaJY13
         2LNR3sBXmxyyFlAXhs26BMroYOoQ7I2CW5SvJMsoPsWLqLriM8XbbiTlGsKal411BQo/
         /lmL6C1aBLdmXRi3M/G62VKPnL/5tfMkOuqs9n5nccM0+cJ/KbfzmZawr6lECkpUSIGN
         nf5w==
X-Forwarded-Encrypted: i=1; AJvYcCWJ1g2lCUnhOFwHOkGsBjUPilxkub4YIGLCEKYCswbAmX+gqZIq1uA5r7CKFk2+YT88ciKpZlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoHA6VmKaxXyNFOsCIMc5ms0FFlUrgLkEKgup39k0ctC/odmKb
	DWsVCj7cTyZIg1/ONlHwKFhkccYLFN+C28Bf46P3anZmyCuXB86sreLnUwkmPQweNacx7Jv6ozH
	PJ1xOe5w0rEha1zbP0tV/its8pdCuQaX1+SQBbJkkTaiklzrrgwwHCSyiyA==
X-Gm-Gg: ASbGncvkHvkcLsIi69Fpw7+nPpMsbBujVVn4ZuxRNdUPngQ1CAvmrOHWv8x0ddAtgeP
	d2t08hpj55KsVD3+pQ6OXR2/Rfopx2IUStkX7e6uXqPPenB1p+w2ul0hggqYyNUdlzI2zEFjPd0
	w0jMoTqkajt2eFzkSQHzhE5cmRuO8wqQZ5BlmXMZ42oPBakMGyqmgFktp+qaa+9CRpl2ZptgDmU
	qvob/R6Xu9p078bN6apWhqowyiycRcie8cmeX793EF5W4eKa/nckbmuhfh0u87oZoVz6PrqM+ZC
	PHI/sKyohXCsvnwIRG4qsk7okVCmBA52n0VPWXX2mkkmzsN3JVdVaTvih06Na64Gq1ZmpZjzWM6
	YS+um36Bvq6O4
X-Received: by 2002:a05:6000:3103:b0:426:eebb:9143 with SMTP id ffacd0b85a97d-426eebb9381mr1418615f8f.58.1760434322706;
        Tue, 14 Oct 2025 02:32:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhqHjyC63QplvCGM6Yssbj/O1tdcTt46og/02B7l4yzSA1JA0eySQZ0KLlE2nLKTw4HEoXwQ==
X-Received: by 2002:a05:6000:3103:b0:426:eebb:9143 with SMTP id ffacd0b85a97d-426eebb9381mr1418589f8f.58.1760434322286;
        Tue, 14 Oct 2025 02:32:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57cc0esm22904313f8f.6.2025.10.14.02.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 02:32:01 -0700 (PDT)
Message-ID: <629ffe15-e4d8-4b0c-a909-55fa4248965a@redhat.com>
Date: Tue, 14 Oct 2025 11:32:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpts: fix timestamp loss due
 to race conditions
To: Aksh Garg <a-garg7@ti.com>, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Cc: linux-kernel@vger.kernel.org, c-vankar@ti.com, s-vadapalli@ti.com,
 danishanwar@ti.com
References: <20251010150821.838902-1-a-garg7@ti.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251010150821.838902-1-a-garg7@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/25 5:08 PM, Aksh Garg wrote:
> diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
> index 59d6ab989c55..2e9719264ba5 100644
> --- a/drivers/net/ethernet/ti/am65-cpts.c
> +++ b/drivers/net/ethernet/ti/am65-cpts.c
> @@ -163,7 +163,9 @@ struct am65_cpts {
>  	struct device_node *clk_mux_np;
>  	struct clk *refclk;
>  	u32 refclk_freq;
> -	struct list_head events;
> +	/* separate lists to handle TX and RX timestamp independently */
> +	struct list_head events_tx;
> +	struct list_head events_rx;
>  	struct list_head pool;
>  	struct am65_cpts_event pool_data[AM65_CPTS_MAX_EVENTS];
>  	spinlock_t lock; /* protects events lists*/
> @@ -172,6 +174,7 @@ struct am65_cpts {
>  	u32 ts_add_val;
>  	int irq;
>  	struct mutex ptp_clk_lock; /* PHC access sync */
> +	struct mutex rx_ts_lock; /* serialize RX timestamp match */
>  	u64 timestamp;
>  	u32 genf_enable;
>  	u32 hw_ts_enable;
> @@ -245,7 +248,16 @@ static int am65_cpts_cpts_purge_events(struct am65_cpts *cpts)
>  	struct am65_cpts_event *event;
>  	int removed = 0;
>  
> -	list_for_each_safe(this, next, &cpts->events) {
> +	list_for_each_safe(this, next, &cpts->events_tx) {
> +		event = list_entry(this, struct am65_cpts_event, list);
> +		if (time_after(jiffies, event->tmo)) {
> +			list_del_init(&event->list);
> +			list_add(&event->list, &cpts->pool);
> +			++removed;
> +		}
> +	}

Minor nit: you can move the loop in a separate helper taking the event
list as an argument and avoid some code duplication with the the rx loop.

> +
> +	list_for_each_safe(this, next, &cpts->events_rx) {
>  		event = list_entry(this, struct am65_cpts_event, list);
>  		if (time_after(jiffies, event->tmo)) {
>  			list_del_init(&event->list);
> @@ -306,11 +318,21 @@ static int __am65_cpts_fifo_read(struct am65_cpts *cpts)
>  				cpts->timestamp);
>  			break;
>  		case AM65_CPTS_EV_RX:
> +			event->tmo = jiffies +
> +				msecs_to_jiffies(AM65_CPTS_EVENT_RX_TX_TIMEOUT);
> +
> +			list_move_tail(&event->list, &cpts->events_rx);
> +
> +			dev_dbg(cpts->dev,
> +				"AM65_CPTS_EV_RX e1:%08x e2:%08x t:%lld\n",
> +				event->event1, event->event2,
> +				event->timestamp);
> +			break;
>  		case AM65_CPTS_EV_TX:
>  			event->tmo = jiffies +
>  				msecs_to_jiffies(AM65_CPTS_EVENT_RX_TX_TIMEOUT);
>  
> -			list_move_tail(&event->list, &cpts->events);
> +			list_move_tail(&event->list, &cpts->events_tx);

Similar thing here.

>  
>  			dev_dbg(cpts->dev,
>  				"AM65_CPTS_EV_TX e1:%08x e2:%08x t:%lld\n",
> @@ -828,7 +850,7 @@ static bool am65_cpts_match_tx_ts(struct am65_cpts *cpts,
>  	return found;
>  }
>  
> -static void am65_cpts_find_ts(struct am65_cpts *cpts)
> +static void am65_cpts_find_tx_ts(struct am65_cpts *cpts)
>  {
>  	struct am65_cpts_event *event;
>  	struct list_head *this, *next;
> @@ -837,7 +859,7 @@ static void am65_cpts_find_ts(struct am65_cpts *cpts)
>  	LIST_HEAD(events);
>  
>  	spin_lock_irqsave(&cpts->lock, flags);
> -	list_splice_init(&cpts->events, &events);
> +	list_splice_init(&cpts->events_tx, &events);
>  	spin_unlock_irqrestore(&cpts->lock, flags);
>  
>  	list_for_each_safe(this, next, &events) {
> @@ -850,7 +872,7 @@ static void am65_cpts_find_ts(struct am65_cpts *cpts)
>  	}
>  
>  	spin_lock_irqsave(&cpts->lock, flags);
> -	list_splice_tail(&events, &cpts->events);
> +	list_splice_tail(&events, &cpts->events_tx);

I see the behavior is pre-existing, but why splicing on tail? events
added in between should be older???

>  	list_splice_tail(&events_free, &cpts->pool);
>  	spin_unlock_irqrestore(&cpts->lock, flags);
>  }
> @@ -861,7 +883,7 @@ static long am65_cpts_ts_work(struct ptp_clock_info *ptp)
>  	unsigned long flags;
>  	long delay = -1;
>  
> -	am65_cpts_find_ts(cpts);
> +	am65_cpts_find_tx_ts(cpts);
>  
>  	spin_lock_irqsave(&cpts->txq.lock, flags);
>  	if (!skb_queue_empty(&cpts->txq))
> @@ -899,16 +921,21 @@ static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, u32 skb_mtype_seqid)
>  {
>  	struct list_head *this, *next;
>  	struct am65_cpts_event *event;
> +	LIST_HEAD(events_free);
>  	unsigned long flags;
> +	LIST_HEAD(events);
>  	u32 mtype_seqid;
>  	u64 ns = 0;
>  
>  	spin_lock_irqsave(&cpts->lock, flags);
>  	__am65_cpts_fifo_read(cpts);
> -	list_for_each_safe(this, next, &cpts->events) {
> +	list_splice_init(&cpts->events_rx, &events);
> +	spin_unlock_irqrestore(&cpts->lock, flags);

Why are you changing the behaviour here, releasing and reacquiring the
cpts->lock? It looks like a separate change, if needed at all.

> +	list_for_each_safe(this, next, &events) {
>  		event = list_entry(this, struct am65_cpts_event, list);
>  		if (time_after(jiffies, event->tmo)) {
> -			list_move(&event->list, &cpts->pool);
> +			list_move(&event->list, &events_free);
>  			continue;
>  		}
>  
> @@ -919,10 +946,14 @@ static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, u32 skb_mtype_seqid)
>  
>  		if (mtype_seqid == skb_mtype_seqid) {
>  			ns = event->timestamp;
> -			list_move(&event->list, &cpts->pool);
> +			list_move(&event->list, &events_free);
>  			break;
>  		}
>  	}
> +
> +	spin_lock_irqsave(&cpts->lock, flags);
> +	list_splice_tail(&events, &cpts->events_rx);
> +	list_splice_tail(&events_free, &cpts->pool);
>  	spin_unlock_irqrestore(&cpts->lock, flags);
>  
>  	return ns;
> @@ -948,7 +979,9 @@ void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb)
>  
>  	dev_dbg(cpts->dev, "%s mtype seqid %08x\n", __func__, skb_cb->skb_mtype_seqid);
>  
> +	mutex_lock(&cpts->rx_ts_lock);
>  	ns = am65_cpts_find_rx_ts(cpts, skb_cb->skb_mtype_seqid);
> +	mutex_unlock(&cpts->rx_ts_lock);

The call chain is:

am65_cpsw_nuss_rx_poll() -> am65_cpsw_nuss_rx_packets() ->
am65_cpts_rx_timestamp()

this runs in BH context, can't acquire a mutex. Also I don't see why any
additional locking would be needed?

/P


