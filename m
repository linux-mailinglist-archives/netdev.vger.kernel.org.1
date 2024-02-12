Return-Path: <netdev+bounces-71029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C54EA851B88
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 18:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D51AB27E6F
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 17:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBDF3EA9F;
	Mon, 12 Feb 2024 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="TITkb7te"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD863EA95
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759145; cv=none; b=W+eAdERTlR3fS8U0vGgJCIFtn1hW+wTIIXgoA5dUm7QhqgytSNt7gXR5vMPs5A9ooY2WXG/NLqsBAkIothk71a3nKJLb4KyQ+QOXhgaZtgdXv+T07+Qa/GaeFR3okRG7rjmONQwEIZk0Ts+277STK56ktRhZxvZnm4APDWRzduI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759145; c=relaxed/simple;
	bh=uC1Wk7zPEs8uSKgL9/qfr2eyzXa6G4WpZGXH7cAQ2hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXWB0knSgwaN+d8ziygAioDQavFPiMNg+bLcxWWqeCzoHx9kMZKlKiISJT57TUFxhuZQIJ3dDCeQUSl9QnLUiENZshlT6koHfmlUuAXLVnRs1s+wcAfed7knN8lxKzoQmanLwHPbzZnguhvImpsS+7bKjQ9avoln+StkgKo831U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=TITkb7te; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e0cd3bed29so616969b3a.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 09:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1707759143; x=1708363943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yv/6NJh1caKiW/cVBuDbEA0Hf25xWRQn1JJpEjjEvFA=;
        b=TITkb7tegnB91EjMPmwbFpxMe7tepC5ZFFjshF54Q5mSmFm+tPhOaw6QBh0nhCisPT
         1PX0/idDAYPFWaxvEOfAUHMmVrYgav19/Vdl+iVfAiPYaVROd47tn8WJzvPDreSP0W+e
         NkdBcCKr7HU1naiPAO8/lzsrl/2BIBJ+bxPu88a3+193SyVfsp5mUSVvph8YAJJgV9pH
         SGAdpFVtu3P05pD7J8ApOjY7as70ptzx5HJLoRUOEaKJIvRgAAHP1RKVQ7WJqhdGsWeQ
         rRAy07veY9NHsEO6goqzoAGPu3m82laZsP5qbz0BzQ0E0ao4mXMb1il+uqlhoevqpqtN
         Ww2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707759143; x=1708363943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yv/6NJh1caKiW/cVBuDbEA0Hf25xWRQn1JJpEjjEvFA=;
        b=WpdkfCtlwMTHEygBDsI8BVwojsfBK72BlY2H8uDth2W3msXs/5sWo6HPQ71DsshkqC
         h9u8XnFWcXr4crPz9hzDW+Ebk9sL+YsiJnDkdICyE3mbPKOd0hu3kIr+GKJ6CGqgal4L
         lSWmL7POZFIoJAZH4YSof8K1RV55ICJ4M/K6rPD5dY9EEoxCmEGjtGAXb3mzW/SvGl/A
         hPdQCwz74gUzfletgUWmnVlkiITAc4tGJLxsarfPKXudSj6x3NHXS3HYojv0tOZVfSFw
         NOUDojVGWrJseM79bkSrfqGVrCg2IyjrkK6n9L1+sr33Qyxh9izYJtAdE3va4sNHbwXq
         hnDQ==
X-Gm-Message-State: AOJu0YxYy3qjGmGJ1DVjoY5YaD/DW+ONbYjU0F76PrJE03cRnMA1FADp
	Z7KimaAwG1VSXxnOh6+2KBSvV7TaE07nr39sSCSVCMyyB4UTQPidIQCk7xx3d8E=
X-Google-Smtp-Source: AGHT+IFc1kNRbUZnjT5DpnOe4WfeZGpcfqHJbMcjc4swbWn196+G2LPNqhEO5/KCG5h0gD50P2b3dg==
X-Received: by 2002:a05:6a00:390c:b0:6e0:a30c:8c84 with SMTP id fh12-20020a056a00390c00b006e0a30c8c84mr6892728pfb.1.1707759142746;
        Mon, 12 Feb 2024 09:32:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkkStfeL3gSHtgoo6bptutK7slBG9wDf9aOsQv6Kz87QyoJpceOJtQr0f29eNittIFKtIiJi1fnjqLv+x0AH7hW0F0ggPtoFgaOrQZ7j70eAfzZbeNRZPk7KhURIQkDL3Ty7rXhn/6GPgR9B9UlSvY69206Ojzbd2T/PQMWneSA3V4aZUtlTXSu48fFRV71T02JNUrZV2nr+zgnWugQTiFkJv7rH8=
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::6:ad38])
        by smtp.gmail.com with ESMTPSA id s67-20020a625e46000000b006dda103efe6sm3048403pfb.167.2024.02.12.09.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:32:22 -0800 (PST)
Message-ID: <5d23bdfe-df0f-4048-b2d1-c0e025fd3efd@davidwei.uk>
Date: Mon, 12 Feb 2024 09:32:20 -0800
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
From: David Wei <dw@davidwei.uk>
In-Reply-To: <420b3c0a-6321-494b-9181-ff7dd4e1849c@machnikowski.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-10 13:43, Maciek Machnikowski wrote:
> 
> 
> On 10/02/2024 01:32, David Wei wrote:
>> Forward skbs sent from one netdevsim port to its connected netdevsim
>> port using dev_forward_skb, in a spirit similar to veth.
>>
>> Add a tx_dropped variable to struct netdevsim, tracking the number of
>> skbs that could not be forwarded using dev_forward_skb().
>>
>> The xmit() function accessing the peer ptr is protected by an RCU read
>> critical section. The rcu_read_lock() is functionally redundant as since
>> v5.0 all softirqs are implicitly RCU read critical sections; but it is
>> useful for human readers.
>>
>> If another CPU is concurrently in nsim_destroy(), then it will first set
>> the peer ptr to NULL. This does not affect any existing readers that
>> dereferenced a non-NULL peer. Then, in unregister_netdevice(), there is
>> a synchronize_rcu() before the netdev is actually unregistered and
>> freed. This ensures that any readers i.e. xmit() that got a non-NULL
>> peer will complete before the netdev is freed.
>>
>> Any readers after the RCU_INIT_POINTER() but before synchronize_rcu()
>> will dereference NULL, making it safe.
>>
>> The codepath to nsim_destroy() and nsim_create() takes both the newly
>> added nsim_dev_list_lock and rtnl_lock. This makes it safe with
>> concurrent calls to linking two netdevsims together.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  drivers/net/netdevsim/netdev.c    | 28 +++++++++++++++++++++++-----
>>  drivers/net/netdevsim/netdevsim.h |  1 +
>>  2 files changed, 24 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>> index 9063f4f2971b..13d3e1536451 100644
>> --- a/drivers/net/netdevsim/netdev.c
>> +++ b/drivers/net/netdevsim/netdev.c
>> @@ -29,19 +29,37 @@
>>  static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>  {
>>  	struct netdevsim *ns = netdev_priv(dev);
>> +	unsigned int len = skb->len;
>> +	struct netdevsim *peer_ns;
>> +	int ret = NETDEV_TX_OK;
>>  
>>  	if (!nsim_ipsec_tx(ns, skb))
>>  		goto out;
>>  
>> +	rcu_read_lock();
>> +	peer_ns = rcu_dereference(ns->peer);
>> +	if (!peer_ns)
>> +		goto out_stats;
> Change ret to NET_XMIT_DROP to correctly count packets as dropped

Linking and forwarding between two netdevsims is optional, so I don't
want to always return NET_XMIT_DROP.

> 
>> +
>> +	skb_tx_timestamp(skb);
>> +	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
>> +		ret = NET_XMIT_DROP;
>> +
>> +out_stats:
>> +	rcu_read_unlock();
>>  	u64_stats_update_begin(&ns->syncp);
>> -	ns->tx_packets++;
>> -	ns->tx_bytes += skb->len;
>> +	if (ret == NET_XMIT_DROP) {
>> +		ns->tx_dropped++;
> add dev_kfree_skb(skb);

dev_forward_skb() frees the skb if dropped already.

> 
> Thanks,
> Maciek
> 
>> +	} else {
>> +		ns->tx_packets++;
>> +		ns->tx_bytes += len;
>> +	}
>>  	u64_stats_update_end(&ns->syncp);
>> +	return ret;
>>  
>>  out:
>>  	dev_kfree_skb(skb);
>> -
>> -	return NETDEV_TX_OK;
>> +	return ret;
>>  }
>>  
>>  static void nsim_set_rx_mode(struct net_device *dev)
>> @@ -70,6 +88,7 @@ nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
>>  		start = u64_stats_fetch_begin(&ns->syncp);
>>  		stats->tx_bytes = ns->tx_bytes;
>>  		stats->tx_packets = ns->tx_packets;
>> +		stats->tx_dropped = ns->tx_dropped;
>>  	} while (u64_stats_fetch_retry(&ns->syncp, start));
>>  }
>>  
>> @@ -302,7 +321,6 @@ static void nsim_setup(struct net_device *dev)
>>  	eth_hw_addr_random(dev);
>>  
>>  	dev->tx_queue_len = 0;
>> -	dev->flags |= IFF_NOARP;
>>  	dev->flags &= ~IFF_MULTICAST;
>>  	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
>>  			   IFF_NO_QUEUE;
>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>> index c8b45b0d955e..553c4b9b4f63 100644
>> --- a/drivers/net/netdevsim/netdevsim.h
>> +++ b/drivers/net/netdevsim/netdevsim.h
>> @@ -98,6 +98,7 @@ struct netdevsim {
>>  
>>  	u64 tx_packets;
>>  	u64 tx_bytes;
>> +	u64 tx_dropped;
>>  	struct u64_stats_sync syncp;
>>  
>>  	struct nsim_bus_dev *nsim_bus_dev;

