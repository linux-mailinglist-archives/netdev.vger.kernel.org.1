Return-Path: <netdev+bounces-71042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE69851CA8
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 19:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0533F284738
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 18:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383103FB1E;
	Mon, 12 Feb 2024 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="IfUGXh1M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF2040BED
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762352; cv=none; b=Qik4W/BnthimCNylAThVgLE9dzyK29CqW/zOd6I0NUPZheIj/lrTmp1Uacp5ksTNdjqWa66Q7/92SiZp7brgcYfay0f+KWSTNsTwIRVh5/Op5ByamWFPc9Bx3flyi+XfTdLcrGIOj6FtBdz7eRw8t6Oi4DGH2VQ4bwMf9/E0A94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762352; c=relaxed/simple;
	bh=TWU2WT0Uv+ryVthTCkZsmyyVcrOjDkFEWLTVf0jCo2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptaOvKO9Ws93D1tZdSTOY9OHIpOXzAXgCQQBTj4h2NyCV6v0VSI94yn1rH708YPvotOt7AN/AIphALCcEQ8yhuVcOAjA4HEGfYK4MFKyGI9cUh29yg1m+owaINClaZGX50/ww2XQLoWKuQrT83PygnkktQpVvqrMJeZQwKFFkTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=IfUGXh1M; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e0a5472e7cso1128272b3a.2
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 10:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1707762350; x=1708367150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B0PsfaveBfPRTNQGHEYFEJanY04pWoHmm2+jVLXNiRg=;
        b=IfUGXh1MIF5k5eu4PoADHokK0FqYCPKw1cX6wtSSk+VXMeFCHuLsc+39bfrJ+Loan/
         E06ls7k1710dsiDST5mzcuetXnq6NM0TCV6ylBeCk3e1bkBlSVXpqHF0NTGxeE583ONa
         ynDTL5mGm6R0Zk7z5d9yyQAurtuCRqNnE6QXkqWYkhu82C0YYX+pVKx9lJF4rsTwQRKN
         3eVuIhPqvgTI55/QsF4t2bEzcEZG/u1H6yHlqcqPZF+xBQfSyAgwXzGx7xtHxl69OBEX
         r5kJjDQu5XF95rmdt41NQxYCsJ+wjSACVabURXQA0IjtnKGAUGLSV2Z+XikCekShkZTX
         pirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707762350; x=1708367150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0PsfaveBfPRTNQGHEYFEJanY04pWoHmm2+jVLXNiRg=;
        b=TIN+F2dJDSPyuyAmd6mEJUX8Njbd4I0pcJ/KSrX74G12BdjUSSxe3EVqEHMz6qBKmH
         L56r+Y8z+892ZpUTQ/U2m98/jTT7vccjFMey2KGeLAQVA1nECmJDp0N7beOL2Yb92dFY
         cMnfJD/iMZF7XMOJYnCAyEfiX2vObAGE46aAdbMCvZE8OgKv3/XpFK9hjX3S4idM3DN0
         svNtwtQyeZ4KkuHJ7J8cCaeOzM5lS+fR6sJXQS6+ILKbSvFe8hWQ07C4rVTxfZ7Lnba8
         mqxb2Le015BMr3Op6opeSEP2ZXUE4ZW07I4Ffl/KGn7RXUdzYDULegricoDCcbBfzX6W
         /AhA==
X-Forwarded-Encrypted: i=1; AJvYcCUsMtAlYN3WDLiV2G/j7xO2q4q0LKnF7/PxjzIm0p2sdOsigP7HLLs+8h8re8Eh4SpK+zJ/2YgrPaYJeeVm0ajpdaW7SMFs
X-Gm-Message-State: AOJu0YxiyHFmwZYaztPzSPwGrfSTCRDqEIw8OI2tTNwyOjt8F60YUnde
	0lA4/4SBwQY4vOs/m+CH5AJMjGTc9yp9GWpQXUux/y0HgWo5C5VU1BJIRhE6wfY=
X-Google-Smtp-Source: AGHT+IH4+DIrnfUBv+fIDcgcWInx/NIkuAG17lrTNOoO/7KaJwI7cbnMdCh0qIp2PRcUab9SZFOcPg==
X-Received: by 2002:a05:6a20:d819:b0:19c:7e49:495a with SMTP id iv25-20020a056a20d81900b0019c7e49495amr6089850pzb.57.1707762349802;
        Mon, 12 Feb 2024 10:25:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0kww0go8DJjn3UKjRy+eE6HH8TnncvmgBGgRk0sS8mErwQ/xn1xuZ5vkMv+ZfVCs5OWJl85yvcQSH1TFeqQfBwY2UiF8T20/+3X9sO3f6jw9mTrBpAegDR8HgBVws0CpwsNKsTu6oTPv5vOrdzPxzbh3NRBggfDSjNIr2xRkBAZaPk3ov/GM5w4rumDqZLzL9vxJv1xwItxvcbNXvmrX3Kri9JyI=
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::6:ad38])
        by smtp.gmail.com with ESMTPSA id z5-20020a62d105000000b006e08437d2c6sm6321693pfg.12.2024.02.12.10.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 10:25:49 -0800 (PST)
Message-ID: <4f9a912b-db9a-4e66-8dd1-b0a719e2cb9f@davidwei.uk>
Date: Mon, 12 Feb 2024 10:25:47 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/3] netdevsim: forward skbs from one
 connected port to another
Content-Language: en-GB
To: Maciek Machnikowski <maciek@machnikowski.net>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240210003240.847392-1-dw@davidwei.uk>
 <20240210003240.847392-3-dw@davidwei.uk>
 <420b3c0a-6321-494b-9181-ff7dd4e1849c@machnikowski.net>
 <5d23bdfe-df0f-4048-b2d1-c0e025fd3efd@davidwei.uk>
 <49aece93-d9a8-4cd8-be79-2160f375e5af@machnikowski.net>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <49aece93-d9a8-4cd8-be79-2160f375e5af@machnikowski.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-12 10:10, Maciek Machnikowski wrote:
> 
> 
> On 12/02/2024 18:32, David Wei wrote:
>> On 2024-02-10 13:43, Maciek Machnikowski wrote:
>>>
>>>
>>> On 10/02/2024 01:32, David Wei wrote:
>>>> Forward skbs sent from one netdevsim port to its connected netdevsim
>>>> port using dev_forward_skb, in a spirit similar to veth.
>>>>
>>>> Add a tx_dropped variable to struct netdevsim, tracking the number of
>>>> skbs that could not be forwarded using dev_forward_skb().
>>>>
>>>> The xmit() function accessing the peer ptr is protected by an RCU read
>>>> critical section. The rcu_read_lock() is functionally redundant as since
>>>> v5.0 all softirqs are implicitly RCU read critical sections; but it is
>>>> useful for human readers.
>>>>
>>>> If another CPU is concurrently in nsim_destroy(), then it will first set
>>>> the peer ptr to NULL. This does not affect any existing readers that
>>>> dereferenced a non-NULL peer. Then, in unregister_netdevice(), there is
>>>> a synchronize_rcu() before the netdev is actually unregistered and
>>>> freed. This ensures that any readers i.e. xmit() that got a non-NULL
>>>> peer will complete before the netdev is freed.
>>>>
>>>> Any readers after the RCU_INIT_POINTER() but before synchronize_rcu()
>>>> will dereference NULL, making it safe.
>>>>
>>>> The codepath to nsim_destroy() and nsim_create() takes both the newly
>>>> added nsim_dev_list_lock and rtnl_lock. This makes it safe with
>>>> concurrent calls to linking two netdevsims together.
>>>>
>>>> Signed-off-by: David Wei <dw@davidwei.uk>
>>>> ---
>>>>  drivers/net/netdevsim/netdev.c    | 28 +++++++++++++++++++++++-----
>>>>  drivers/net/netdevsim/netdevsim.h |  1 +
>>>>  2 files changed, 24 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>>>> index 9063f4f2971b..13d3e1536451 100644
>>>> --- a/drivers/net/netdevsim/netdev.c
>>>> +++ b/drivers/net/netdevsim/netdev.c
>>>> @@ -29,19 +29,37 @@
>>>>  static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>>>  {
>>>>  	struct netdevsim *ns = netdev_priv(dev);
>>>> +	unsigned int len = skb->len;
>>>> +	struct netdevsim *peer_ns;
>>>> +	int ret = NETDEV_TX_OK;
>>>>  
>>>>  	if (!nsim_ipsec_tx(ns, skb))
>>>>  		goto out;
>>>>  
>>>> +	rcu_read_lock();
>>>> +	peer_ns = rcu_dereference(ns->peer);
>>>> +	if (!peer_ns)
>>>> +		goto out_stats;
>>> Change ret to NET_XMIT_DROP to correctly count packets as dropped
>>
>> Linking and forwarding between two netdevsims is optional, so I don't
>> want to always return NET_XMIT_DROP.
>> OK - now I see that previously we calculated all packets as TX_OK and
> transmitted, so this is OK.
> 
>>>
>>>> +
>>>> +	skb_tx_timestamp(skb);
>>>> +	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
>>>> +		ret = NET_XMIT_DROP;
>>>> +
>>>> +out_stats:
>>>> +	rcu_read_unlock();
>>>>  	u64_stats_update_begin(&ns->syncp);
>>>> -	ns->tx_packets++;
>>>> -	ns->tx_bytes += skb->len;
>>>> +	if (ret == NET_XMIT_DROP) {
>>>> +		ns->tx_dropped++;
>>> add dev_kfree_skb(skb);
>>
>> dev_forward_skb() frees the skb if dropped already.
> But the dev_forward_skb() won't be called if there is no peer_ns. In
> this case we still need to call dev_kfree_skb().

Oh, I see now, thank you.

> 
>>
>>>
>>> Thanks,
>>> Maciek
>>>
>>>> +	} else {
>>>> +		ns->tx_packets++;
>>>> +		ns->tx_bytes += len;
>>>> +	}
>>>>  	u64_stats_update_end(&ns->syncp);
>>>> +	return ret;
>>>>  
>>>>  out:
>>>>  	dev_kfree_skb(skb);
>>>> -
>>>> -	return NETDEV_TX_OK;
>>>> +	return ret;
>>>>  }
>>>>  
>>>>  static void nsim_set_rx_mode(struct net_device *dev)
>>>> @@ -70,6 +88,7 @@ nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
>>>>  		start = u64_stats_fetch_begin(&ns->syncp);
>>>>  		stats->tx_bytes = ns->tx_bytes;
>>>>  		stats->tx_packets = ns->tx_packets;
>>>> +		stats->tx_dropped = ns->tx_dropped;
>>>>  	} while (u64_stats_fetch_retry(&ns->syncp, start));
>>>>  }
>>>>  
>>>> @@ -302,7 +321,6 @@ static void nsim_setup(struct net_device *dev)
>>>>  	eth_hw_addr_random(dev);
>>>>  
>>>>  	dev->tx_queue_len = 0;
>>>> -	dev->flags |= IFF_NOARP;
>>>>  	dev->flags &= ~IFF_MULTICAST;
>>>>  	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
>>>>  			   IFF_NO_QUEUE;
>>>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>>>> index c8b45b0d955e..553c4b9b4f63 100644
>>>> --- a/drivers/net/netdevsim/netdevsim.h
>>>> +++ b/drivers/net/netdevsim/netdevsim.h
>>>> @@ -98,6 +98,7 @@ struct netdevsim {
>>>>  
>>>>  	u64 tx_packets;
>>>>  	u64 tx_bytes;
>>>> +	u64 tx_dropped;
>>>>  	struct u64_stats_sync syncp;
>>>>  
>>>>  	struct nsim_bus_dev *nsim_bus_dev;

