Return-Path: <netdev+bounces-55461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0567D80AF3F
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 22:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38CF28125F
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 21:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D4258AAC;
	Fri,  8 Dec 2023 21:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="pkgyc5QO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BECE1BDC
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 13:58:40 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-58e28e0461bso1301634eaf.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 13:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702072719; x=1702677519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ETWLY+ecFepyYVwvrlPYsQoa+1xXdJV7zHCTgPb5q1w=;
        b=pkgyc5QOd60CZab/at3GZMoZbEb2wSBh/GxzwktMAWw1rjaoEPcfbIqZ2WFP/Wxtu8
         lFtgmeRWsyen4QnFQGChObHl5CLaJUCuAEIJLfeIdAsxGz5AV0QToH/8cwSIo4PXirxz
         oyZGIw3JqP6+dIxHLQSIyeXRsMI3ay5Fu9Cx6a9slLDEk7/DO+D1/Rw619DqjCvPd6jg
         PiK7KuvQpfQPpaSbWzB0IiD+spMy7XMG5Q3BSGnQ+F7HzPzd3J94ewCjpQhTXH+1W++c
         W1XCx2ajSNAyj4Fe87DoiVOoCKGB71ZfBkiFolKt3GtAtC1ZoAN9IQxIKYhekwK0eWGl
         MTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702072719; x=1702677519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETWLY+ecFepyYVwvrlPYsQoa+1xXdJV7zHCTgPb5q1w=;
        b=m/QMvxmYipGR9EJ/AVEASCUQlruUILgVUdgwUdkvRb+yulC9zgL8DvigADJDURNYDB
         FviY6f49Xeq1hbcqRWdFtOMTo4/+3qLCrEU9f222wHJHhRkIbVMKgzo3gk120aIxncml
         eqkgNp7BG3/JoESL4MrkwPLPf30qbJo6s2GAu70dDcYFRLnrUhRMGYTdhjIEEHrW1tYk
         X8BoNeKuxpeoCcJFU0ZVNoJCeMjJtx3NgTAyEOChNc9jnyZT9P0kKBpO/NxE8anNHPL1
         4nTvHsV+WREZ46eqqiEBTU+C7pQkIlFl3McfNzM1PWz89zUMoaQsiDm8q3X6ISEjK/Cf
         adtg==
X-Gm-Message-State: AOJu0YxD1aRUDlR170fBjBwRHzQYbVnuVycj6rFSU4UXUgFVaJ1D/NnX
	tsGO5/dNZbi5wBrZQGLNgw5v8w==
X-Google-Smtp-Source: AGHT+IE6TuYzHO9CK06rKsUFYSHooarRJsdq32XQhZi6GTEG/3KN1YoTdwk/KfoBPQMHJnJ3jGpJEw==
X-Received: by 2002:a05:6359:a1a:b0:170:52eb:af31 with SMTP id el26-20020a0563590a1a00b0017052ebaf31mr575454rwb.56.1702072719691;
        Fri, 08 Dec 2023 13:58:39 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::5:34a6])
        by smtp.gmail.com with ESMTPSA id t2-20020a62d142000000b00690c0cf97c9sm2145195pfl.73.2023.12.08.13.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 13:58:39 -0800 (PST)
Message-ID: <2c46131e-56f4-4cd6-8259-7ba555c2b88a@davidwei.uk>
Date: Fri, 8 Dec 2023 13:58:38 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] netdevsim: forward skbs from one connected
Content-Language: en-GB
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20231207172117.3671183-1-dw@davidwei.uk>
 <20231207172117.3671183-3-dw@davidwei.uk> <ZXL3kL6EPLNa+c7Z@nanopsycho>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <ZXL3kL6EPLNa+c7Z@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-08 03:01, Jiri Pirko wrote:
> Thu, Dec 07, 2023 at 06:21:16PM CET, dw@davidwei.uk wrote:
>> Forward skbs sent from one netdevsim port to its connected netdevsim
>> port using dev_forward_skb, in a spirit similar to veth.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>> drivers/net/netdevsim/netdev.c | 20 +++++++++++++++-----
>> 1 file changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>> index 1abdcd470f21..698819072c4f 100644
>> --- a/drivers/net/netdevsim/netdev.c
>> +++ b/drivers/net/netdevsim/netdev.c
>> @@ -29,19 +29,30 @@
>> static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>> {
>> 	struct netdevsim *ns = netdev_priv(dev);
>> +	struct netdevsim *peer_ns;
>> +	int ret = NETDEV_TX_OK;
>>
>> 	if (!nsim_ipsec_tx(ns, skb))
>> -		goto out;
>> +		goto err;
>>
>> 	u64_stats_update_begin(&ns->syncp);
>> 	ns->tx_packets++;
>> 	ns->tx_bytes += skb->len;
>> 	u64_stats_update_end(&ns->syncp);
>>
>> -out:
>> -	dev_kfree_skb(skb);
>> +	peer_ns = ns->peer;
> 
> What is stopping the peer to be removed and freed right now?

Thanks for pointing this out, you're right, nothing is stopping it. I'll
add some synchronisation here.

> 
> 
>> +	if (!peer_ns)
>> +		goto err;
>> +
>> +	skb_tx_timestamp(skb);
>> +	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
>> +		ret = NET_XMIT_DROP;
>>
>> -	return NETDEV_TX_OK;
>> +	return ret;
>> +
>> +err:
>> +	dev_kfree_skb(skb);
>> +	return ret;
>> }
>>
>> static void nsim_set_rx_mode(struct net_device *dev)
>> @@ -302,7 +313,6 @@ static void nsim_setup(struct net_device *dev)
>> 	eth_hw_addr_random(dev);
>>
>> 	dev->tx_queue_len = 0;
>> -	dev->flags |= IFF_NOARP;
>> 	dev->flags &= ~IFF_MULTICAST;
>> 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
>> 			   IFF_NO_QUEUE;
>> -- 
>> 2.39.3
>>
>>

