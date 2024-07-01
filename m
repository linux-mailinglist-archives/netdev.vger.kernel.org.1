Return-Path: <netdev+bounces-108269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2780C91E911
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 22:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11E0284BCB
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E46D17107F;
	Mon,  1 Jul 2024 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Hw/HIGMa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20A0171081
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863910; cv=none; b=pAWTxpm9M69z49GdHI7A0CQD0BLa0UUIC2/WQKb3IUv7VPNlGqjgVsdu1QoOQqP1KIgmw5mRqrei33TUnOE9u5nJoCyoOMEn2wmIvbtER2KL29Qbvlqjn3w3VfF1WNXAt2MLflTyHidnhzFL0WYHJvf/dzHQm6IOlJBXSc4jdLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863910; c=relaxed/simple;
	bh=6EHTXZEHoD00j/HDpg3i/IoAfT254ZYd82/yVe6xoBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVwJUNYUxXqjplaOIFn4uhvH9xPNM9LQ2vtFDQ69LzQkycWfbL2N2+1ZoVsUCTr9525RsBeL+S7ceXuSLLFylVUvbcbopdXwARAi487W14GrXjsV/bEyoa8Mnx+STi++dZtnzBAS2aCJoaX3lfSICZIZmhG4W/clOTmoVPeAaWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Hw/HIGMa; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7021702f3f1so824467a34.0
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 12:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719863907; x=1720468707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=STiQi67y6glvy/vFVYUeteQlBlmmhNhq5a9Mp7GbFdE=;
        b=Hw/HIGMatHOaieDke+0Of1A2No5BOELvQBR4oHEjn/22K5bxyeO/JqSczn2wnZBr0F
         8QNtH47sVIey0zSp9wunvyGWC5K6JNxft2R2FGR9APrP/wJPtBG4TDXi28ILNAbER72g
         lPr8L5jEhzecOT6Kk/4FXcdaWaNwTkSWZaCgMYS8nWPcOLLNJ32R8Y6Do7k2ClOl0Lny
         NXTqeHn9YPoPIOI6D+QnKEmksTYczd/HQclKKxVclaRAJNzil0ItavlZjhF3DcyS0h5C
         rLXG0Xi35/qz4cGjh97LA6oZ3Yd51EMWR4q4S/n8HAlF/WOo/Kjd846SnFkqLq6qXRm5
         NRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863907; x=1720468707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=STiQi67y6glvy/vFVYUeteQlBlmmhNhq5a9Mp7GbFdE=;
        b=cYIdWxCbVhsWjBAQapG7UWrWMJ8QYEqQOLGLEKxmcMFbPF7/YXGGlwiTZIcJSvBn1m
         cvkd9SJ21JtDdbh9lc3EiS/Hl9RGl73lY2HVzgYiTORjzEksOFN0er8p0YPtvH/5hnk8
         uX7twZnkAdbrsQJWKLGGVqM2DlesZDoBHN4yZNk3QXNldPO+RkKLmlF7HCvGUAKQkO9O
         PwDxZ8BW7OSLvxCViFRCVD0Dv7gcikNTH6f3tWvicqJQuIT5MncBMBP/2lvi+keBC/3b
         L0cd36uJhsD0eiw60lezpiOUh3nt9obiYgzEYEUixxTqrnTtpe0qRHeN7L73l86DHi1O
         LrgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtJo0UfX3g1N46t/FnOA4jKsJUhlf4jF5eBFVdS0Hyd5F1Zun3QL0aoMHW4sYCAGVQe11cQBTfUvnfnPAQ7EfZRbCHI3Fn
X-Gm-Message-State: AOJu0YzC9ZqSsd3L0WfPNlidhPqJDimoXOi25tUAO+87pkqOpvokKJRz
	YThji6PLmC1kxvhMVYrZfVoVS+pGA3z8EdOZVNYgD7YRHpRnKgr5ERiIEG+gE8c=
X-Google-Smtp-Source: AGHT+IHeAWizaugj9aZuc/fRcIzX7pzVo3Dx4u4lXDRO7ei45V/hKHS2tL4Yto0WYVUAv3W0VyKGNA==
X-Received: by 2002:a05:6830:90:b0:702:65e:12ec with SMTP id 46e09a7af769-702075f4b98mr7816213a34.9.1719863906611;
        Mon, 01 Jul 2024 12:58:26 -0700 (PDT)
Received: from [10.73.215.90] ([72.29.204.230])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7ab196fsm1400380a34.23.2024.07.01.12.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 12:58:26 -0700 (PDT)
Message-ID: <8e98eb7f-5263-48ca-86be-dfc43c135385@bytedance.com>
Date: Mon, 1 Jul 2024 12:58:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/4] sock: add MSG_ZEROCOPY notification
 mechanism based on msg_control
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, cong.wang@bytedance.com, xiaochun.lu@bytedance.com
References: <20240626193403.3854451-1-zijianzhang@bytedance.com>
 <20240626193403.3854451-4-zijianzhang@bytedance.com>
 <66816f57ea8e9_e2572942@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <66816f57ea8e9_e2572942@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/24 7:44 AM, Willem de Bruijn wrote:
> zijianzhang@ wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
>> However, zerocopy is not a free lunch. Apart from the management of user
>> pages, the combination of poll + recvmsg to receive notifications incurs
>> unignorable overhead in the applications. The overhead of such sometimes
>> might be more than the CPU savings from zerocopy. We try to solve this
>> problem with a new notification mechanism based on msgcontrol.
>>
>> This new mechanism aims to reduce the overhead associated with receiving
>> notifications by embedding them directly into user arguments passed with
>> each sendmsg control message. By doing so, we can significantly reduce
>> the complexity and overhead for managing notifications. In an ideal
>> pattern, the user will keep calling sendmsg with SCM_ZC_NOTIFICATION
>> msg_control, and the notification will be delivered as soon as possible.
>>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
>> ---
>>   arch/alpha/include/uapi/asm/socket.h  |  2 ++
>>   arch/mips/include/uapi/asm/socket.h   |  2 ++
>>   arch/parisc/include/uapi/asm/socket.h |  2 ++
>>   arch/sparc/include/uapi/asm/socket.h  |  2 ++
>>   include/linux/socket.h                |  2 +-
>>   include/uapi/asm-generic/socket.h     |  2 ++
>>   include/uapi/linux/socket.h           | 10 +++++++
>>   net/core/sock.c                       | 42 +++++++++++++++++++++++++++
>>   8 files changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
>> index e94f621903fe..7761a4e0ea2c 100644
>> --- a/arch/alpha/include/uapi/asm/socket.h
>> +++ b/arch/alpha/include/uapi/asm/socket.h
>> @@ -140,6 +140,8 @@
>>   #define SO_PASSPIDFD		76
>>   #define SO_PEERPIDFD		77
>>   
>> +#define SCM_ZC_NOTIFICATION 78
>> +
>>   #if !defined(__KERNEL__)
>>   
>>   #if __BITS_PER_LONG == 64
>> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
>> index 60ebaed28a4c..89edc51380f0 100644
>> --- a/arch/mips/include/uapi/asm/socket.h
>> +++ b/arch/mips/include/uapi/asm/socket.h
>> @@ -151,6 +151,8 @@
>>   #define SO_PASSPIDFD		76
>>   #define SO_PEERPIDFD		77
>>   
>> +#define SCM_ZC_NOTIFICATION 78
>> +
>>   #if !defined(__KERNEL__)
>>   
>>   #if __BITS_PER_LONG == 64
>> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
>> index be264c2b1a11..2911b43e6a9d 100644
>> --- a/arch/parisc/include/uapi/asm/socket.h
>> +++ b/arch/parisc/include/uapi/asm/socket.h
>> @@ -132,6 +132,8 @@
>>   #define SO_PASSPIDFD		0x404A
>>   #define SO_PEERPIDFD		0x404B
>>   
>> +#define SCM_ZC_NOTIFICATION 0x404C
>> +
>>   #if !defined(__KERNEL__)
>>   
>>   #if __BITS_PER_LONG == 64
>> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
>> index 682da3714686..dc045e87cc8e 100644
>> --- a/arch/sparc/include/uapi/asm/socket.h
>> +++ b/arch/sparc/include/uapi/asm/socket.h
>> @@ -133,6 +133,8 @@
>>   #define SO_PASSPIDFD             0x0055
>>   #define SO_PEERPIDFD             0x0056
>>   
>> +#define SCM_ZC_NOTIFICATION 0x0057
>> +
>>   #if !defined(__KERNEL__)
>>   
>>   
>> diff --git a/include/linux/socket.h b/include/linux/socket.h
>> index 35adc30c9db6..f2f013166525 100644
>> --- a/include/linux/socket.h
>> +++ b/include/linux/socket.h
>> @@ -170,7 +170,7 @@ static inline struct cmsghdr * cmsg_nxthdr (struct msghdr *__msg, struct cmsghdr
>>   
>>   static inline bool cmsg_copy_to_user(struct cmsghdr *__cmsg)
>>   {
>> -	return 0;
>> +	return __cmsg->cmsg_type == SCM_ZC_NOTIFICATION;
>>   }
>>   
>>   static inline size_t msg_data_left(struct msghdr *msg)
>> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
>> index 8ce8a39a1e5f..7474c8a244bc 100644
>> --- a/include/uapi/asm-generic/socket.h
>> +++ b/include/uapi/asm-generic/socket.h
>> @@ -135,6 +135,8 @@
>>   #define SO_PASSPIDFD		76
>>   #define SO_PEERPIDFD		77
>>   
>> +#define SCM_ZC_NOTIFICATION 78
>> +
>>   #if !defined(__KERNEL__)
>>   
>>   #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
>> diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
>> index d3fcd3b5ec53..26bee6291c6c 100644
>> --- a/include/uapi/linux/socket.h
>> +++ b/include/uapi/linux/socket.h
>> @@ -2,6 +2,8 @@
>>   #ifndef _UAPI_LINUX_SOCKET_H
>>   #define _UAPI_LINUX_SOCKET_H
>>   
>> +#include <linux/types.h>
>> +
>>   /*
>>    * Desired design of maximum size and alignment (see RFC2553)
>>    */
>> @@ -35,4 +37,12 @@ struct __kernel_sockaddr_storage {
>>   #define SOCK_TXREHASH_DISABLED	0
>>   #define SOCK_TXREHASH_ENABLED	1
>>   
>> +#define SOCK_ZC_INFO_MAX 16
>> +
>> +struct zc_info_elem {
>> +	__u32 lo;
>> +	__u32 hi;
>> +	__u8 zerocopy;
>> +};
>> +
>>   #endif /* _UAPI_LINUX_SOCKET_H */
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 4a766a91ff5c..1b2ce72e1338 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -2863,6 +2863,48 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>>   	case SCM_RIGHTS:
>>   	case SCM_CREDENTIALS:
>>   		break;
>> +	case SCM_ZC_NOTIFICATION: {
>> +		struct zc_info_elem *zc_info_kern = CMSG_DATA(cmsg);
>> +		int cmsg_data_len, zc_info_elem_num;
>> +		struct sock_exterr_skb *serr;
>> +		struct sk_buff_head *q;
>> +		unsigned long flags;
>> +		struct sk_buff *skb;
>> +		int i = 0;
>> +
>> +		if (!sock_flag(sk, SOCK_ZEROCOPY) || sk->sk_family == PF_RDS)
>> +			return -EINVAL;
>> +
>> +		cmsg_data_len = cmsg->cmsg_len - sizeof(struct cmsghdr);
>> +		if (cmsg_data_len % sizeof(struct zc_info_elem))
>> +			return -EINVAL;
>> +
>> +		zc_info_elem_num = cmsg_data_len / sizeof(struct zc_info_elem);
>> +		if (!zc_info_elem_num || zc_info_elem_num > SOCK_ZC_INFO_MAX)
>> +			return -EINVAL;
>> +
>> +		q = &sk->sk_error_queue;
>> +		spin_lock_irqsave(&q->lock, flags);
>> +		skb = skb_peek(q);
>> +		while (skb && i < zc_info_elem_num) {
>> +			struct sk_buff *skb_next = skb_peek_next(skb, q);
>> +
>> +			serr = SKB_EXT_ERR(skb);
>> +			if (serr->ee.ee_errno == 0 &&
>> +			    serr->ee.ee_origin == SO_EE_ORIGIN_ZEROCOPY) {
>> +				zc_info_kern[i].hi = serr->ee.ee_data;
>> +				zc_info_kern[i].lo = serr->ee.ee_info;
>> +				zc_info_kern[i].zerocopy = !(serr->ee.ee_code
>> +								& SO_EE_CODE_ZEROCOPY_COPIED);
>> +				__skb_unlink(skb, q);
>> +				consume_skb(skb);
>> +			}
>> +			skb = skb_next;
>> +			i++;
>> +		}
> 
> How will userspace know the number of entries written? Since the
> cmsg_len is not updated, is the expectation that the CMSG_DATA is zero
> initialized by the user and the list will be zero-element terminated?
> 

Since zero-element is a valid value(the first sendmsg with non-zerocopy)
in our case, zero-element terminated might not be feasible.

In current selftest, the user initializes zerocopy field to a invalid
value, and upon returning iterate the array until the invalid value. It
is very dependent to the user, I think it's not good enough.

I agree that updating cmsg_len is better.

>> +		spin_unlock_irqrestore(&q->lock, flags);
>> +		break;
>> +	}
>>   	default:
>>   		return -EINVAL;
>>   	}
>> -- 
>> 2.20.1
>>
> 
> 

