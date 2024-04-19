Return-Path: <netdev+bounces-89683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9D98AB2DA
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 18:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8399BB20BE4
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 16:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755B0130AC4;
	Fri, 19 Apr 2024 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Sf2Xlu6Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E212F59E
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713542897; cv=none; b=VvaLvirvEKq38IZ0hN5WOdH+aRdJTU7mcZTrEWcPPCavinXc+ka1JCN+9qyX0W+rZb5+fXnsfaR+moHBFklzpzgpeKek1moWaRclMb4WGuNxzJCwLK5lEYC7rmWL9iVjoMgyGmd/MnVDpvVQGozgfqIU+uQrnhMdYF7lPxGtsEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713542897; c=relaxed/simple;
	bh=FYXvL+rq1vg5JorOHdN62ahNaVprMd1yoASqXtkzb80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFLpw/DaUgnUPyJ2hf3mv28IatF6jCEQoZQDS2lUchtK/CVUnDSCq+sEUkLGM0CwRxcIwsdFpxxd9QhfaOgdlBSj9sLpoRWXuYeheKVf5eTK7jhO9KST5Tn4z6aKKVNKsJnpA+9fvAPtNLqeZD3+232Kkd0WIKbiTSSmgKOR/b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Sf2Xlu6Q; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed627829e6so2394147b3a.1
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 09:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1713542895; x=1714147695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4bA2qYmiZxHE8ktpVD1aLFjKcriisXRkhg5ejBTRO0Y=;
        b=Sf2Xlu6QywJkg2o52xiJinlzjXhy9A21eLFxiTiPQaOIQE0OwczuEzUk7EIFv+zHCb
         6iE0ezF2v16Ad81HLC7wRLRpn1/VGe0xCNk3UxUv+fFtdZ5GHA3azpzRzD8RPESEBmSa
         4lkxuEl6hRoi5bghnQsmzA+rRSc3NZHVHG1mZUeOiyxEHzYtu1yMao0cjqSMPcn8Q28/
         LA2DLwDvMoqH+20LEFpf0B4Hz3AH55IliId/7vFsTtpX/z38bwMWjpkHKsy6cVlSZOpX
         huFaLvHh5tS9yJ8dXZ1eORs4kL4iZiKtwo2oMTmM6e+XoOp5Y1wVjjqSGSSDIoajUX2k
         7aPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713542895; x=1714147695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4bA2qYmiZxHE8ktpVD1aLFjKcriisXRkhg5ejBTRO0Y=;
        b=D7CKVZWP6tKy5R8FDL+xu03n4uTCE1TSDVYuD32wsk7hN5UfdNjB6A1/8fBc8R/JZS
         wtz9X7keeC9RVHi8aJd/Arp+cOxuJ/0h9iRZs7+YsmiJSap9j9p1uKqoGOxzC8huRYCm
         MCLfJdzSp2lc8b96GhXBxM/Y0uxNCkl4dAKJGI/yHkI9wp6hYPmuXBsFQAA9+mN1Y9L3
         FG2zDQyulYRWPOYULS8/ORuKkyRRcvuPVAj+JzZzyjWAgKF+dqxSDac3VYPGSSSL7lmH
         4XHbY4ekn+mILqXwCuYc5VmbJfV092tV+IWTjmm/gpnHsG/jMMBUbc+0EVRUv2tncml7
         O5fA==
X-Gm-Message-State: AOJu0Yxj9Bg/pfTWsC6PTy7TGdQiU93Hf2UaqjnIoUrevRkaaAeSRmuB
	vEOr7uJa1A8Deum/DyEC2CHEeODm4qwL1aBvUyB/yE+yxFIbmqWd+FivaS9Zz+I=
X-Google-Smtp-Source: AGHT+IFhe9C4VBtM4vnp8oYrZBPNX+QIYjAIfYhGrctc47Ljbn7X1aAixaJJ+SeozCJ8vfJ/HzckiA==
X-Received: by 2002:a05:6a20:1055:b0:1a7:5bba:98bd with SMTP id gt21-20020a056a20105500b001a75bba98bdmr2661741pzc.36.1713542894950;
        Fri, 19 Apr 2024 09:08:14 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::5:d1b7])
        by smtp.gmail.com with ESMTPSA id r8-20020a63fc48000000b005dbd0facb4dsm3235113pgk.61.2024.04.19.09.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 09:08:14 -0700 (PDT)
Message-ID: <89c29a49-0f32-4222-8c71-5317eb8b0d1a@davidwei.uk>
Date: Fri, 19 Apr 2024 09:08:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] netdevsim: add NAPI support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240416051527.1657233-1-dw@davidwei.uk>
 <20240416051527.1657233-2-dw@davidwei.uk>
 <20240416172730.1b588eef@kernel.org>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240416172730.1b588eef@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-16 5:27 pm, Jakub Kicinski wrote:
> On Mon, 15 Apr 2024 22:15:26 -0700 David Wei wrote:
>> Add NAPI support to netdevim, similar to veth.
>>
>> * Add a nsim_rq rx queue structure to hold a NAPI instance and a skb
>>   queue.
>> * During xmit, store the skb in the peer skb queue and schedule NAPI.
>> * During napi_poll(), drain the skb queue and pass up the stack.
>> * Add assoc between rxq and NAPI instance using netif_queue_set_napi().
> 
>> +#define NSIM_RING_SIZE		256
>> +
>> +static int nsim_napi_rx(struct nsim_rq *rq, struct sk_buff *skb)
>> +{
>> +	if (list_count_nodes(&rq->skb_queue) > NSIM_RING_SIZE) {
>> +		dev_kfree_skb_any(skb);
>> +		return NET_RX_DROP;
>> +	}
>> +
>> +	list_add_tail(&skb->list, &rq->skb_queue);
> 
> Why not use struct sk_buff_head ?
> It has a purge helper for freeing, and remembers its own length.

Didn't know about sk_buff_head! Thanks, it's much better.

> 
>> +static int nsim_poll(struct napi_struct *napi, int budget)
>> +{
>> +	struct nsim_rq *rq = container_of(napi, struct nsim_rq, napi);
>> +	int done;
>> +
>> +	done = nsim_rcv(rq, budget);
>> +
>> +	if (done < budget && napi_complete_done(napi, done)) {
>> +		if (unlikely(!list_empty(&rq->skb_queue)))
>> +			napi_schedule(&rq->napi);
> 
> I think you can drop the re-check, NAPI has a built in protection 
> for this kind of race.

Would veth also want this dropped, or does it serve a different purpose
there?

> 
>> +	}
>> +
>> +	return done;
>> +}
> 
>>  static int nsim_open(struct net_device *dev)
>>  {
>>  	struct netdevsim *ns = netdev_priv(dev);
>> -	struct page_pool_params pp = { 0 };
>> +	int err;
>> +
>> +	err = nsim_init_napi(ns);
>> +	if (err)
>> +		return err;
>> +
>> +	nsim_enable_napi(ns);
>>  
>> -	pp.pool_size = 128;
>> -	pp.dev = &dev->dev;
>> -	pp.dma_dir = DMA_BIDIRECTIONAL;
>> -	pp.netdev = dev;
>> +	netif_carrier_on(dev);
> 
> Why the carrier? It's on by default.
> Should be a separate patch if needed.

Symmetry, not sure if it was needed or not. Will remove.

> 
>> -	ns->pp = page_pool_create(&pp);
>> -	return PTR_ERR_OR_ZERO(ns->pp);
>> +	return 0;
>> +}
> 
>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>> index 7664ab823e29..87bf45ec4dd2 100644
>> --- a/drivers/net/netdevsim/netdevsim.h
>> +++ b/drivers/net/netdevsim/netdevsim.h
>> @@ -90,11 +90,18 @@ struct nsim_ethtool {
>>  	struct ethtool_fecparam fec;
>>  };
>>  
>> +struct nsim_rq {
>> +	struct napi_struct napi;
>> +	struct list_head skb_queue;
>> +	struct page_pool *page_pool;
> 
> You added the new page_pool pointer but didn't delete the one
> I added recently to the device?

Yeah, sorry that slipped through the rebase.

> 
>> +};
>> +
>>  struct netdevsim {
>>  	struct net_device *netdev;
>>  	struct nsim_dev *nsim_dev;
>>  	struct nsim_dev_port *nsim_dev_port;
>>  	struct mock_phc *phc;
>> +	struct nsim_rq *rq;
>>  
>>  	u64 tx_packets;
>>  	u64 tx_bytes;
> 

