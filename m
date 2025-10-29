Return-Path: <netdev+bounces-233763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F17C18003
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1C93A3F45
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D8C2E5D32;
	Wed, 29 Oct 2025 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="xZp3x1fm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218432367DF
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703654; cv=none; b=V0/5WhzEwAaGMV09kHCUbR0Dd6TJOTxGUS8deD8fS7dh7uHCQAQ1qXa03CcmAdXqTp0qp8oqymn9qz9AUOOaYD+mNOCthq2jg3SRot6WMfyBSDKJIsSkREsrcVURGUW0m7zJTOOCO0PFmqKNx8zP6JaNi2xb7C3alWXZ521vGTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703654; c=relaxed/simple;
	bh=EFi4CIjRYWouw3Fk26EOcbOpV3k1SeYqp8YCwxUMtE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B96ZRWxMskKDxVQLTR3oTBBNoHi3/7ouO7VZ27I1VnOxK4Q03SeaPtytLmaY/QO/oqT93ZsouoNBOk5Zff5fBJjGCl3s5Tb8KI4+O0iMl5vO2zdh1u0M5NyLEVbiVLRqVJyRcksaMVkdhI0F5NiLqfBiSHqfzxtrcpVaPZ6uuFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=xZp3x1fm; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso6388909b3a.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 19:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761703652; x=1762308452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EwbAWeZOQsCnS4wFS3BFGyep219kWlTwBOi+jj07kfQ=;
        b=xZp3x1fmDbHlpr4kwmHKkILJPFPPpYiXIirWdyaHq8eeQedLPp9kz4Oec/3RqkzpVR
         hrzgnYhjdjWinsBnHOlhBNjLNZdbTkgYi+jUA4v+CKgqwsPNL3Wn3PjSq0r56iG9Zl1b
         8OHJPMKWaZEwGzuxsrX7uc55zrJXiEQB+LaQ9CvhIKCREx80+Sh+qS0faMochOmbzIYO
         E4N/f/krEQjgN7TSJBE/gfsj5jEe2H2qjaSLVCzjTOqww9yDOWkpzJsyUxePGxbgPzmP
         E2b7wRCW25QGnaKS3kXBxFzk1/ThJU04+2HNvGRY3Cqu3AnTlDUUsztCMoJS9JXe8833
         qQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761703652; x=1762308452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwbAWeZOQsCnS4wFS3BFGyep219kWlTwBOi+jj07kfQ=;
        b=dkcJUfCg3LBVSDBA5fN8K5hQaC0pueRt00JZ6bgoRh/9fGMf+nLBTlpUWtbvdVmqGV
         AcI8P6szgUeL7HKyxNt4gxPF/cj3PBNO0r9dfYZMTHGlZ/wQKhp7ncjzq8lyhAyiwaJd
         CkLxL9okH9j3gNAYVQqo+aqgGW7bLQFwKSUPhWekGCqaUsldwuruu10BZr+YThm9uJBB
         /QT+RlwJ4exyaqVYO462Q7ASqOjf6GI+4d2rZVisSKGQN3iXTID/5E1ANsddN4GsCljI
         AKnE3VuUw4BxP0xqMVMiUDvChUXKN1B7GWuHB1qyNnLW6Jk/tlPLFr7qQ2MgZWsaMT1B
         VI0Q==
X-Gm-Message-State: AOJu0YxzNCpGCqCK8nis80DIEmsiMcD7RvfV34sts7XzaA4JDhtswpUl
	tuI5m1ND+KCudRfDdKjA548YXgONCQxqyFaJMIYuqztcNOtZGWK4SGswdHLAN73Ag28=
X-Gm-Gg: ASbGncurIV24KRMUOafDA12QQ6Moi5icDtXakd0qEQPokOLhw2AFUIuDShQEBnTR9Q2
	AZsfCzbuyduO4qMlZ/nM9ytt5WhgeA1cjkWbO5fRBzhLqHr125av9wwSaFbiZnm2+4qkJ/YJxPl
	ppa7CMprhBbkum62usFGdwGX9KJif98gl7/gqVWzZgB/XLWlTszvKCSP9bRHPQvC9X4W8wT5RPT
	wnlvnyf60j531CliLKgTX9VvV6j0TncmXhbz6/BU8669e++KYiT0vRfHkQIkyggwBEA2XxrZTfp
	ARoBB61Pg2KAwE1+eTHb/W8gBxsYw26UVU3ElRDrcMMLNqJOiYOcyjBlBtmanDdcNSgBMdnoKF1
	ZsYjwlyGgNDIJUdeJIVuVqp8QT8u9ahg4r6uvLyGu7PawjDgPicqxPRs2sIFXZ+jxP7zpr9Kmo6
	Gq4YlRsjqCcMKQkkifQGi/Y1O0xqR0uwYX6IBOxE5xtE1A/c+8mQ==
X-Google-Smtp-Source: AGHT+IHxHyk8ir4DX5MhWD7ZjQz9187JFIEmSz1NBSvx/zbXwsWKBnY2fp2LNqat2VgeWtV++KiolQ==
X-Received: by 2002:a05:6a21:9986:b0:343:8a88:2733 with SMTP id adf61e73a8af0-34653145795mr1640244637.3.1761703652354;
        Tue, 28 Oct 2025 19:07:32 -0700 (PDT)
Received: from [192.168.86.109] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414032cabsm13256371b3a.22.2025.10.28.19.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 19:07:31 -0700 (PDT)
Message-ID: <bbab235a-826c-4051-930f-e4209da0c067@davidwei.uk>
Date: Tue, 28 Oct 2025 19:07:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 05/15] net: Proxy net_mp_{open,close}_rxq for
 mapped queues
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
 willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
 martin.lau@kernel.org, jordan@jrife.io, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-6-daniel@iogearbox.net> <aPvHQYXJ8SGA-lSw@mini-arch>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aPvHQYXJ8SGA-lSw@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-24 11:36, Stanislav Fomichev wrote:
> On 10/20, Daniel Borkmann wrote:
>> From: David Wei <dw@davidwei.uk>
>>
>> When a process in a container wants to setup a memory provider, it will
>> use the virtual netdev and a mapped rxq, and call net_mp_{open,close}_rxq
>> to try and restart the queue. At this point, proxy the queue restart on
>> the real rxq in the physical netdev.
>>
>> For memory providers (io_uring zero-copy rx and devmem), it causes the
>> real rxq in the physical netdev to be filled from a memory provider that
>> has DMA mapped memory from a process within a container.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   include/net/page_pool/memory_provider.h |  4 +-
>>   net/core/netdev_rx_queue.c              | 57 +++++++++++++++++--------
>>   2 files changed, 41 insertions(+), 20 deletions(-)
>>
>> diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
>> index ada4f968960a..b6f811c3416b 100644
>> --- a/include/net/page_pool/memory_provider.h
>> +++ b/include/net/page_pool/memory_provider.h
>> @@ -23,12 +23,12 @@ bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr);
>>   void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov);
>>   void net_mp_niov_clear_page_pool(struct net_iov *niov);
>>   
>> -int net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
>> +int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>>   		    struct pp_memory_provider_params *p);
>>   int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>>   		      const struct pp_memory_provider_params *p,
>>   		      struct netlink_ext_ack *extack);
>> -void net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
>> +void net_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
>>   		      struct pp_memory_provider_params *old_p);
>>   void __net_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
>>   			const struct pp_memory_provider_params *old_p);
>> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
>> index 8ee289316c06..b4ff3497e086 100644
>> --- a/net/core/netdev_rx_queue.c
>> +++ b/net/core/netdev_rx_queue.c
>> @@ -170,48 +170,63 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>>   		      struct netlink_ext_ack *extack)
>>   {
>>   	struct netdev_rx_queue *rxq;
>> +	bool needs_unlock = false;
>>   	int ret;
>>   
>>   	if (!netdev_need_ops_lock(dev))
>>   		return -EOPNOTSUPP;
>> -
>>   	if (rxq_idx >= dev->real_num_rx_queues) {
>>   		NL_SET_ERR_MSG(extack, "rx queue index out of range");
>>   		return -ERANGE;
>>   	}
>> -	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
>>   
>> +	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
>> +	rxq = netif_get_rx_queue_peer_locked(&dev, &rxq_idx, &needs_unlock);
>> +	if (!rxq) {
>> +		NL_SET_ERR_MSG(extack, "rx queue peered to a virtual netdev");
>> +		return -EBUSY;
>> +	}
>> +	if (!dev->dev.parent) {
>> +		NL_SET_ERR_MSG(extack, "rx queue is mapped to a virtual netdev");
>> +		ret = -EBUSY;
>> +		goto out;
>> +	}
>>   	if (dev->cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
>>   		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
>> -		return -EINVAL;
>> +		ret = -EINVAL;
>> +		goto out;
>>   	}
>>   	if (dev->cfg->hds_thresh) {
>>   		NL_SET_ERR_MSG(extack, "hds-thresh is not zero");
>> -		return -EINVAL;
>> +		ret = -EINVAL;
>> +		goto out;
>>   	}
>>   	if (dev_xdp_prog_count(dev)) {
>>   		NL_SET_ERR_MSG(extack, "unable to custom memory provider to device with XDP program attached");
>> -		return -EEXIST;
>> +		ret = -EEXIST;
>> +		goto out;
>>   	}
>> -
>> -	rxq = __netif_get_rx_queue(dev, rxq_idx);
>>   	if (rxq->mp_params.mp_ops) {
>>   		NL_SET_ERR_MSG(extack, "designated queue already memory provider bound");
>> -		return -EEXIST;
>> +		ret = -EEXIST;
>> +		goto out;
>>   	}
>>   #ifdef CONFIG_XDP_SOCKETS
>>   	if (rxq->pool) {
>>   		NL_SET_ERR_MSG(extack, "designated queue already in use by AF_XDP");
>> -		return -EBUSY;
>> +		ret = -EBUSY;
>> +		goto out;
>>   	}
>>   #endif
>> -
>>   	rxq->mp_params = *p;
>>   	ret = netdev_rx_queue_restart(dev, rxq_idx);
>>   	if (ret) {
>>   		rxq->mp_params.mp_ops = NULL;
>>   		rxq->mp_params.mp_priv = NULL;
>>   	}
>> +out:
>> +	if (needs_unlock)
>> +		netdev_unlock(dev);
> 
> Can we do something better than needs_unlock flag? Maybe something like the
> following?
> 
> netif_put_rx_queue_peer_locked(orig_dev, dev)
> {
> 	if (orig_dev != dev)
> 		netdev_unlock(dev);
> }
> 
> Then we can do:
> 
> orig_dev = dev;
> rxq = netif_get_rx_queue_peer_locked(&dev, &rx_idx);
> ...
> netif_put_rx_queue_peer_locked(orig_dev, dev);

Thanks, that's a lot cleaner, changed in v4.

