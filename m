Return-Path: <netdev+bounces-246028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C39DDCDCF74
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 18:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81B81300EDF8
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 17:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B7F329C74;
	Wed, 24 Dec 2025 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCYro+8z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF068329C5B
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766598602; cv=none; b=Fr2e/ettxDdN6+z5IiC+y92Bg40HC50rzudEDazjK0SxSfZgqOtPGY9WbtPeaScRw2dF3+qXKAnz+xZsB5gJwG5a3wxy0UZ3rXOWaLOGUkszgg/AtBIirircsnQzzrrv6DzVfKT98z040/Dh9kXCZS+3WsWCfNZi9LtOjJumeyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766598602; c=relaxed/simple;
	bh=Uy2GuzMWLXSScd2jys7HD/4lMT6yYktAwCAK7y1dxs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFTPCh0gbRj+ipiTYaqd2ivxLHO3I7N8XzhhKRo+27p4HAyEsOFy7ynZ56VsjpwzNIdTckC6netY5Nxh06gZq799COpMoY/1BvwJLl3kuitfgR6rkOAaiMEpFHZWS7y/skSQgYA+/GWN/EL1j9xP0XFt/BeBOZkrtKuulQAZ4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCYro+8z; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso4750126b3a.3
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 09:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766598596; x=1767203396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dyaIVMgw4ATEaUXqxaNcG5tML3N8wIlrK8h87W4urnk=;
        b=nCYro+8zzvCeE6Xo914YmQ4yIBts6jU6oEjNKLyBU/AFVWdhLGZVeA/lsRPsk7zwny
         8l6aI1dRonJ54hb2ARkUggAYIexArm6icOOrJxR89jO384d8zAaB+YCqRuay/cnxYAOH
         J+kAMe3tc9YVAcsezF+3d2cMEEIwkyjWmgFFcvMidNs3heR2lXmy5CAkeypAWJqCgoQZ
         pg90xoG67xAd1XdTyZCinpl1zwiAy9cAH2rVMNkBpR+6VCOqGed3TiLs5CR/8i8Y5+r2
         ZSWpYHxtxBCktIwFzTmwiS6wBM6m+rMorD093XijjNekJnxMKtVtuberh5cv3tipq9/C
         Dp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766598596; x=1767203396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyaIVMgw4ATEaUXqxaNcG5tML3N8wIlrK8h87W4urnk=;
        b=M69LoFp70UIQjCAhrYM1KxtG5I7qye8v+4Tpx25TiMV5SU25W0gveN/mgfhhYBoHF3
         lP382oz8Zv9jCe5ggomXAVENiNAk0kdo8khiOMp8axat/o09L9MMyKTJORQneG9qomWZ
         Oum7F/GJlUIBnFApyCQqlmWT2w0PSKxYE+vfcarbAGmKMTjdwL2YVmDH2k0mDNFGMRaG
         oABmDV9UP9UKjWsklfc3/Jpfoa5+ycpbZqgx91rOYhMDvKujMoHV9IMY9oHiZsE7xzaY
         4bFY61CsHPKzKJ6vLw6AR/SdUQYxMdGGMCxd5fBM8kVpTKWfBL+2K/FWeVdxw0B3zxrF
         cDIA==
X-Gm-Message-State: AOJu0Yxe6TGL4XQ85m8R/BxW7z7i3N6SkX810z5FK66mht1ttMoxfsYo
	oti0ILLRidnFk+kghcxJ5LM+qk1Q4ouWgueWdyQdRVgJNsLK7TEGNu3e
X-Gm-Gg: AY/fxX50WVsuetQLyy6WBC2ZtB6WKuZAg4sHcFH8F+v6RviEb41RImr+I1diNnLQ9dI
	heiEdga+HaBlq1kA8QOFw0RQfDprVleX/1xg3DBkdoaqhCSEKXM1k2S8ZIB2GOMD7N4R2qc0uu4
	IoRzioJ+28/CdWsQ0Ud1227oiC13MW6ec37YwSbqKZErq+lKFvLqdLzxIoxd2NIvkYoA6SvF77d
	ZHa3i7fv4qYn2mmyaqBnDeUbIKzav9hqxgMD6YuFrr+TMQlPYNtaCq3FoPPlKnAq1CeDeQ5xVWP
	efYB2ed8i/xs+Lw56VOzw28L6IOdukLbDzvttZvxS2FPqcVcx5DUrAazNUa9+oQRndYs3Ga7JBK
	poAI6y6jMpgRXtyM9LsaueIv5d8KENYC440BkNJVZ+OJm6ZINvRQx7XHOqJiWM0cIdsd+9wjRWi
	LlXgqFWoUUw0t8jf9EYSKnjkmLwITmTJYjivqxUoWML/5ryGGKYLpf0em+CqQ=
X-Google-Smtp-Source: AGHT+IGqeYfA0scfRJSZs642UZrJmT7+8QWmvt0tszu/L1Nmzf2uk5Nb/WZyy+4ewshxFonCJ6CNgQ==
X-Received: by 2002:a05:6a00:e13:b0:781:2291:1045 with SMTP id d2e1a72fcca58-7ff64fc5fd4mr15854544b3a.8.1766598596164;
        Wed, 24 Dec 2025 09:49:56 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:c711:242:cd10:6c98? ([2001:ee0:4f4c:210:c711:242:cd10:6c98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e0a19besm17215370b3a.40.2025.12.24.09.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 09:49:55 -0800 (PST)
Message-ID: <3acaaca3-37b3-4104-ac5a-441f3d4243c6@gmail.com>
Date: Thu, 25 Dec 2025 00:49:49 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] virtio-net: ensure rx NAPI is enabled before
 enabling refill work
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-3-minhquangbui99@gmail.com>
 <20251223203908-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20251223203908-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/24/25 08:45, Michael S. Tsirkin wrote:
> On Tue, Dec 23, 2025 at 10:25:32PM +0700, Bui Quang Minh wrote:
>> Calling napi_disable() on an already disabled napi can cause the
>> deadlock. Because the delayed refill work will call napi_disable(), we
>> must ensure that refill work is only enabled and scheduled after we have
>> enabled the rx queue's NAPI.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 31 ++++++++++++++++++++++++-------
>>   1 file changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 63126e490bda..8016d2b378cf 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3208,16 +3208,31 @@ static int virtnet_open(struct net_device *dev)
>>   	int i, err;
>>   
>>   	for (i = 0; i < vi->max_queue_pairs; i++) {
>> +		bool schedule_refill = false;
>
>
>> +
>> +		/* - We must call try_fill_recv before enabling napi of the same
>> +		 * receive queue so that it doesn't race with the call in
>> +		 * virtnet_receive.
>> +		 * - We must enable and schedule delayed refill work only when
>> +		 * we have enabled all the receive queue's napi. Otherwise, in
>> +		 * refill_work, we have a deadlock when calling napi_disable on
>> +		 * an already disabled napi.
>> +		 */
>
> I would do:
>
> 	bool refill = i < vi->curr_queue_pairs;
>
> in fact this is almost the same as resume with
> one small difference. pass a flag so we do not duplicate code?

I'll fix it in next version.

>
>>   		if (i < vi->curr_queue_pairs) {
>> -			enable_delayed_refill(&vi->rq[i]);
>>   			/* Make sure we have some buffers: if oom use wq. */
>>   			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>> -				schedule_delayed_work(&vi->rq[i].refill, 0);
>> +				schedule_refill = true;
>>   		}
>>   
>>   		err = virtnet_enable_queue_pair(vi, i);
>>   		if (err < 0)
>>   			goto err_enable_qp;
>> +
>> +		if (i < vi->curr_queue_pairs) {
>> +			enable_delayed_refill(&vi->rq[i]);
>> +			if (schedule_refill)
>> +				schedule_delayed_work(&vi->rq[i].refill, 0);
>
> hmm. should not schedule be under the lock?

I see that schedule is safe to be called concurrently.

     struct work_struct {
         atomic_long_t data;
         struct list_head entry;
         work_func_t func;
     #ifdef CONFIG_LOCKDEP
         struct lockdep_map lockdep_map;
     #endif
     };

The atomic_long_t field to set pending bit and worker pool's lock help 
with the synchronization.


>
>> +		}
>>   	}
>>   
>>   	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
>> @@ -3456,11 +3471,16 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>>   	bool running = netif_running(vi->dev);
>>   	bool schedule_refill = false;
>>   
>> +	/* See the comment in virtnet_open for the ordering rule
>> +	 * of try_fill_recv, receive queue napi_enable and delayed
>> +	 * refill enable/schedule.
>> +	 */
> so maybe common code?
>
>>   	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
>>   		schedule_refill = true;
>>   	if (running)
>>   		virtnet_napi_enable(rq);
>>   
>> +	enable_delayed_refill(rq);
>>   	if (schedule_refill)
>>   		schedule_delayed_work(&rq->refill, 0);
> hmm. should not schedule be under the lock?
>
>>   }
>> @@ -3470,18 +3490,15 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
>>   	int i;
>>   
>>   	for (i = 0; i < vi->max_queue_pairs; i++) {
>> -		if (i < vi->curr_queue_pairs) {
>> -			enable_delayed_refill(&vi->rq[i]);
>> +		if (i < vi->curr_queue_pairs)
>>   			__virtnet_rx_resume(vi, &vi->rq[i], true);
>> -		} else {
>> +		else
>>   			__virtnet_rx_resume(vi, &vi->rq[i], false);
>> -		}
>>   	}
>>   }
>>   
>>   static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
>>   {
>> -	enable_delayed_refill(rq);
>>   	__virtnet_rx_resume(vi, rq, true);
>>   }
> so I would add bool to virtnet_rx_resume and call it everywhere,
> removing __virtnet_rx_resume. can be a patch on top.

I'll create another patch after this patch to clean up the 
__virtnet_rx_resume in the next version.

Thanks,
Quang Minh.

>
>>   
>> -- 
>> 2.43.0


