Return-Path: <netdev+bounces-58208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82972815884
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 10:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9541F24F64
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D566114016;
	Sat, 16 Dec 2023 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="R+CTNKCo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467DC14A85
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-336437ae847so1292175f8f.2
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 01:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702718553; x=1703323353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkpcNizRhtAcIYkAiAQu4ddcuGeGKdGnyd+T+PkhkgI=;
        b=R+CTNKCoFlRJS3lyeOJHeS3RMIPIwBEmjrvI0od2M5skStRqeQaB2vuKUWqNzU96El
         AJQvy6F/xka73wMpBjd/evR4YBMQ/h2qO900AUNCp46kj0YMygNcZqAUT/Gmxf3unw9G
         mn4zBIIRE984ks4QQP6pVcQW4od41hIfjmKfEYHuSybaZWwOBBIsp3nGY9I/zGrspDP0
         T+z2qHeoSDps8znhPTXPgH86eeagjlVof2gVteeZMbZk2qzu6IzzzI8AomUQqiou6B+4
         CPMSlYLmoPovvoH1UKny2i6pM6nRqbr1lCn1yYAAdimU2pTbalxHgKeKs7SH/PHXinZC
         T8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702718553; x=1703323353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkpcNizRhtAcIYkAiAQu4ddcuGeGKdGnyd+T+PkhkgI=;
        b=ITrAh9vN0b9Z35DdzWQDZp90AxyLYJ5w+P07nce6v1P0ixRZb8nMA2j5XvI6Sj4vQ4
         JqTATP0+YotKaweOKD9FypUWdKGdWCkgdtO5qgivX+784QrJlDI3/aximZWXCIbydsyO
         f/R+puttrCBT40g5sF7Cao4E0UQ+r7ifqMFx5LvqoabKN0zZWuUzYy8yCJTVDW7qON01
         3VDe3LDbmm59W+oRvB/tYpblKPCS8E3JqGzoLeLKQyHpQjYTupLiTQOzD4caaHGGrgUS
         670W9DSgGE+XM+OKTrB5UjYGDJak7GUnl9KwVG/updIh0koLvxpJp3qXUe7c60yuf6aX
         b9Ew==
X-Gm-Message-State: AOJu0YxFUk/jGV1A3oDHRWGJaE/PxWzAcApF707mItaZY+jIhrzQd91G
	+E82oNhM17oImD6hkoZ6SjFKdQ==
X-Google-Smtp-Source: AGHT+IGk1K9lZOeYBXwYNsAylAMI4N4AvzM/JbQnsZweX/INUJl5rHgLkFs3Fc5riJ3dN5hQBebyoA==
X-Received: by 2002:a05:600c:6907:b0:40c:30fb:60ab with SMTP id fo7-20020a05600c690700b0040c30fb60abmr7307944wmb.134.1702718553408;
        Sat, 16 Dec 2023 01:22:33 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id e12-20020a05600c4e4c00b0040b398f0585sm33318131wmq.9.2023.12.16.01.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 01:22:32 -0800 (PST)
Date: Sat, 16 Dec 2023 10:22:31 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 2/4] netdevsim: forward skbs from one
 connected port to another
Message-ID: <ZX1sV50prk_zl4TN@nanopsycho>
References: <20231214212443.3638210-1-dw@davidwei.uk>
 <20231214212443.3638210-3-dw@davidwei.uk>
 <ZXwuTRFSbDn_ON_E@nanopsycho>
 <ecefd186-0324-42af-9123-cfcd10267cdb@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecefd186-0324-42af-9123-cfcd10267cdb@davidwei.uk>

Fri, Dec 15, 2023 at 07:31:42PM CET, dw@davidwei.uk wrote:
>On 2023-12-15 02:45, Jiri Pirko wrote:
>> Thu, Dec 14, 2023 at 10:24:41PM CET, dw@davidwei.uk wrote:
>>> Forward skbs sent from one netdevsim port to its connected netdevsim
>>> port using dev_forward_skb, in a spirit similar to veth.
>> 
>> Perhaps better to write "dev_forward_skb()" to make obvious you talk
>> about function.
>
>Sorry, it's a bad habit at this point :)
>
>> 
>> 
>>>
>>> Signed-off-by: David Wei <dw@davidwei.uk>
>>> ---
>>> drivers/net/netdevsim/netdev.c | 23 ++++++++++++++++++-----
>>> 1 file changed, 18 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>>> index e290c54b0e70..c5f53b1dbdcc 100644
>>> --- a/drivers/net/netdevsim/netdev.c
>>> +++ b/drivers/net/netdevsim/netdev.c
>>> @@ -29,19 +29,33 @@
>>> static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>> {
>>> 	struct netdevsim *ns = netdev_priv(dev);
>>> +	struct netdevsim *peer_ns;
>>> +	int ret = NETDEV_TX_OK;
>>>
>>> +	rcu_read_lock();
>> 
>> Why do you need to be in rcu read locked section here?
>
>So the RCU protected pointer `peer` does not change during the critical
>section. Veth does something similar in its xmit() for its peer.

RCU does not work like this. Please check out the documentation.


>
>> 
>> 
>>> 	if (!nsim_ipsec_tx(ns, skb))
>>> -		goto out;
>>> +		goto err;
>> 
>> Not sure why you need to rename the label. Why "out" is not okay?
>> 
>>>
>>> 	u64_stats_update_begin(&ns->syncp);
>>> 	ns->tx_packets++;
>>> 	ns->tx_bytes += skb->len;
>>> 	u64_stats_update_end(&ns->syncp);
>>>
>>> -out:
>>> -	dev_kfree_skb(skb);
>>> +	peer_ns = rcu_dereference(ns->peer);
>>> +	if (!peer_ns)
>>> +		goto err;
>> 
>> This is definitelly not an error path, "err" label name is misleading.
>
>That's fair, I can change it back. Lots has changed since my original
>intentions.
>
>> 
>> 
>>> +
>>> +	skb_tx_timestamp(skb);
>>> +	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
>>> +		ret = NET_XMIT_DROP;
>> 
>> Hmm, can't you track dropped packets in ns->tx_dropped and expose in
>> nsim_get_stats64() ?
>
>I can add this.
>
>> 
>> 
>>>
>>> -	return NETDEV_TX_OK;
>>> +	rcu_read_unlock();
>>> +	return ret;
>>> +
>>> +err:
>>> +	rcu_read_unlock();
>>> +	dev_kfree_skb(skb);
>>> +	return ret;
>>> }
>>>
>>> static void nsim_set_rx_mode(struct net_device *dev)
>>> @@ -302,7 +316,6 @@ static void nsim_setup(struct net_device *dev)
>>> 	eth_hw_addr_random(dev);
>>>
>>> 	dev->tx_queue_len = 0;
>>> -	dev->flags |= IFF_NOARP;
>>> 	dev->flags &= ~IFF_MULTICAST;
>>> 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
>>> 			   IFF_NO_QUEUE;
>>> -- 
>>> 2.39.3
>>>

