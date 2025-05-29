Return-Path: <netdev+bounces-194099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C00CAC752E
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 02:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E065FA4194F
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 00:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12EC17C211;
	Thu, 29 May 2025 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hBDUN8SO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEFB126F0A
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748479767; cv=none; b=RaiVPf6Lu3nDHttTERQ1ne/jcEv5+TwOSqtGXAIKwr0Z6cjY2/tL1d//CH9xL/SEOpMOqBfse6H0MQSwLibS2qFKjqc1tm/xclveRW1KqZVNEcyB4dIx8yNyrKfDQD6+87Fgt1Mm8NPjbxGLD68Cbt8NkhMYzRgNvPwBb3ReBeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748479767; c=relaxed/simple;
	bh=hfUqsuqNrfhaPiVk2G40M78HYAyL0SMbPsVKu3y7pQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKNWLLWKdeXfBOxsp8b6/cKpgjJ5mUXQEYB5HI24qqpSunXlOnE22HxGgZYAHgMm59ZwKeoPpMshiJubhIidW4tpBfOGQzcvCxKSr47hMSF2QZWieyMrpPwwk5/DPQw2BcuJy8+hx9KtXZPFzZh8QRJjpcjfvjdOTziuxgUPpnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hBDUN8SO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476b4c9faa2so4417231cf.3
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 17:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748479765; x=1749084565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TKhstJNQESyypLHjwfOabdZIDAN9bNuz9Of7dFpRg2w=;
        b=hBDUN8SOH+bGI3MOkuWKbqhebfQ+3+Z0CO1nAbUUjpbGAyurGWbcNrIde642td1iTT
         mN84Sk3OCoyVIin2ExJmNZh4+5M9VcF1DsE4Uq9Sxd63a0eYA8BFB2yxP/Bbgl5DuAY5
         9w3yd0FABX90JqxTDotmDAfwWLXkbXuCA2cwiPsvcJlMBFL/Wz9m/VlID8yfVRqNvvIs
         cl6e2dcfnjPfocecYc+sjfPKo23H8aBq9lLos+rdtyhVpd9IW8OPXcZEVyj6D5JO4daL
         vQRp/2bHhpk0hVKKl+g3ADUMSE1i1kjnDZrffrFo3/1AW2Dsm9Q2XEOA79BE9tu5qwXj
         O5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748479765; x=1749084565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKhstJNQESyypLHjwfOabdZIDAN9bNuz9Of7dFpRg2w=;
        b=waSg08l+L9qa83WryqFsJSy4RqNCkLNc1GphmVfnIRxNAxg6vHkTtHMeDB/y8a0NwR
         +fZs335PT5CPc21I7/VGihGDoSFjDsrKhlRdF6BprYg6ko02pdvpSuZ9TQx5HwGy9COl
         zZaqtcTgqDejBELf/GmH0xh9LevIcTuRcEEvmNXt+fV/ehBjiBr2uF/IAptg5+8xf5tH
         WDd4l2JGmSiX/z0ErlC4eOhWbt9hdbJdPrJAX7o3OZnLjF3P4j7MKU1RkR+/BhXmCquJ
         VKp6Go5mlsRDEr++NcEshCxvbfMQGJQTi6Ix+kIICM+WWXfI/FAwuO2iJrN7CaGHDxUr
         QAHw==
X-Gm-Message-State: AOJu0Yz+qingQ3x21zjgoNbe3tecGDufmsXJ2zTgFwLOSITht56nb3zd
	4aTBiTNUMObRKjvSkMCDxQaRAYcGDD5ayzDuarmHs4PVtgAw7EIO6gr+a2pbpzWWP64=
X-Gm-Gg: ASbGnctV2HMyo/itjaxU+rtrKA7WeYZJPxTNhNeuegTA7AXj0mCvWgzPy8K3Ao4QWUO
	K8wCsTkTDAiASQTc3C1GZltkzV9N6qmZqBNe1Z1rw6wyqM8LTexhf/AcxZi9QHPHvykpPnJf/TE
	42rcZGdDRs6BvUBXjRdj+DcyZYJnpMKF353exZeQE3XmvnSgFHUxX5WB1vYS7zaYScqZbxfxTzw
	p+TY/XGXe5YiogsObKI+40rGx9WSkAD47ezPLem7Te9eZ7TE9qLuu2+eRBnqy7k8+vDN0jFGu7E
	Q/aif6TLPjyCOL8BfJ0gpyg6UoEjSNAf1ub2z1vuCAMNXX8ZGKGP5zQXm7AIHXUGSNj4lOqXS1a
	U6J9FA0Ot8F4KG+oDApSBTZTKYMExfrDBb5sYF5ujbLSRAekj
X-Google-Smtp-Source: AGHT+IEKhJCaq4H3UPpq63G+EehTUAOzPZ4WqO2UiHjawiFQXbfnvxj3bnUrDOHKVe84tdkwY0HVrQ==
X-Received: by 2002:a05:622a:4ac4:b0:49d:89bf:298a with SMTP id d75a77b69052e-49f4655bb04mr322557621cf.21.1748479764687;
        Wed, 28 May 2025 17:49:24 -0700 (PDT)
Received: from ?IPV6:2601:647:4d81:15e0:fdf3:2533:6562:13e9? ([2601:647:4d81:15e0:fdf3:2533:6562:13e9])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a435a56f7csm1715681cf.66.2025.05.28.17.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 17:49:24 -0700 (PDT)
Message-ID: <c66ac1f6-1626-47d6-9132-1aeedf771032@bytedance.com>
Date: Wed, 28 May 2025 17:49:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch bpf-next v3 2/4] skmsg: implement slab allocator cache for
 sk_msg
To: John Fastabend <john.fastabend@gmail.com>,
 Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, zhoufeng.zf@bytedance.com,
 jakub@cloudflare.com, Cong Wang <cong.wang@bytedance.com>
References: <20250519203628.203596-1-xiyou.wangcong@gmail.com>
 <20250519203628.203596-3-xiyou.wangcong@gmail.com>
 <20250529000348.upto3ztve36ccamv@gmail.com>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <20250529000348.upto3ztve36ccamv@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/25 5:04 PM, John Fastabend wrote:
> On 2025-05-19 13:36:26, Cong Wang wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> Optimizing redirect ingress performance requires frequent allocation and
>> deallocation of sk_msg structures. Introduce a dedicated kmem_cache for
>> sk_msg to reduce memory allocation overhead and improve performance.
>>
>> Reviewed-by: Cong Wang <cong.wang@bytedance.com>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> ---
>>   include/linux/skmsg.h | 21 ++++++++++++---------
>>   net/core/skmsg.c      | 28 +++++++++++++++++++++-------
>>   net/ipv4/tcp_bpf.c    |  5 ++---
>>   3 files changed, 35 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
>> index d6f0a8cd73c4..bf28ce9b5fdb 100644
>> --- a/include/linux/skmsg.h
>> +++ b/include/linux/skmsg.h
>> @@ -121,6 +121,7 @@ struct sk_psock {
>>   	struct rcu_work			rwork;
>>   };
>>   
>> +struct sk_msg *sk_msg_alloc(gfp_t gfp);
>>   int sk_msg_expand(struct sock *sk, struct sk_msg *msg, int len,
>>   		  int elem_first_coalesce);
>>   int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
>> @@ -143,6 +144,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>>   		   int len, int flags);
>>   bool sk_msg_is_readable(struct sock *sk);
>>   
>> +extern struct kmem_cache *sk_msg_cachep;
>> +
>>   static inline void sk_msg_check_to_free(struct sk_msg *msg, u32 i, u32 bytes)
>>   {
>>   	WARN_ON(i == msg->sg.end && bytes);
>> @@ -319,6 +322,13 @@ static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
>>   	kfree_skb(skb);
>>   }
>>   
>> +static inline void kfree_sk_msg(struct sk_msg *msg)
>> +{
>> +	if (msg->skb)
>> +		consume_skb(msg->skb);
>> +	kmem_cache_free(sk_msg_cachep, msg);
>> +}
>> +
>>   static inline bool sk_psock_queue_msg(struct sk_psock *psock,
>>   				      struct sk_msg *msg)
>>   {
>> @@ -330,7 +340,7 @@ static inline bool sk_psock_queue_msg(struct sk_psock *psock,
>>   		ret = true;
>>   	} else {
>>   		sk_msg_free(psock->sk, msg);
>> -		kfree(msg);
>> +		kfree_sk_msg(msg);
> 
> Isn't this a potential use after free on msg->skb? The sk_msg_free() a
> line above will consume_skb() if it exists and its not nil set so we would
> consume_skb() again?
> 

Thanks to sk_msg_free, after consuming the skb, it invokes sk_msg_init
to make msg->skb NULL to prevent further double free.

To avoid the confusion, we can replace kfree_sk_msg here with
kmem_cache_free.


>>   		ret = false;
>>   	}
>>   	spin_unlock_bh(&psock->ingress_lock);
>> @@ -378,13 +388,6 @@ static inline bool sk_psock_queue_empty(const struct sk_psock *psock)
>>   	return psock ? list_empty(&psock->ingress_msg) : true;
>>   }
>>   
>> -static inline void kfree_sk_msg(struct sk_msg *msg)
>> -{
>> -	if (msg->skb)
>> -		consume_skb(msg->skb);
>> -	kfree(msg);
>> -}
>> -
>>   static inline void sk_psock_report_error(struct sk_psock *psock, int err)
>>   {
>>   	struct sock *sk = psock->sk;
>> @@ -441,7 +444,7 @@ static inline void sk_psock_cork_free(struct sk_psock *psock)
>>   {
>>   	if (psock->cork) {
>>   		sk_msg_free(psock->sk, psock->cork);
>> -		kfree(psock->cork);
>> +		kfree_sk_msg(psock->cork);
> 
> Same here.
> 
>>   		psock->cork = NULL;
>>   	}
>>   }


