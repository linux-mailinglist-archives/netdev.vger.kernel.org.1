Return-Path: <netdev+bounces-96143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1328C47D1
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 21:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E754D1C230CD
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8AE7BAFF;
	Mon, 13 May 2024 19:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="i/xGtmw1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D8879B87
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629647; cv=none; b=IGRY7xawTLVkIKn4nJosvM681Vvk2aCrrkcjmTnEynGKxlRv0pmlLX147VinF/yHz/E3jZHYNPGhwVjAc7KLY7NKOTQJa9UuJXY4czs5NjsrHre3rbPLz+mAFBKGcxxK/6ttpHUzxwvANrqajpdNwran0sKj5QAvrbMsXFeS5s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629647; c=relaxed/simple;
	bh=d8JtWFaWPH7JM815FJOvBpxFHmPhGpd+cATfxzH5Q/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njYIImvQH8zc21NQ0/TxeFslMJGkhoxFGtEV2Rz5G1dADrWWqjm4Fjl2hxbRkb/tZ2AuppjPJZ01WCoNTjhPgmc6Yv6VqoI/zAaWFnsJEUPG3oPiOJHfkZ9edIJYgKuXpAglrY3aMdHxILbDA8mSVImNZggV/oC+WEOf1Uk0sO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=i/xGtmw1; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43df751b5b8so31673841cf.0
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715629644; x=1716234444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpbwFa5RVgCPsd4J1YQdE/foyCe94LqF6avZiwQOX88=;
        b=i/xGtmw1dAGZvLemoZP3Pi/iEqJA4PlmvLzv367tooiiP3/qcC0cs/EozO0zjMptwM
         PsTg/kbSq4+AF+lYjaQqCTpq1T6fJGeS0DZFdFrJeogiFOoqXQPadZ1Snf28YmV27y/b
         VkhnkaKHNXtxJn3gvXR6+nqIQqi35hhkZrf8SmiLkfqcG6/opP+zUuxLw8fROdR84dkn
         hRRikDLEtCG2eHw8mD43J3rOr7dftmuRhfEmRI5cVH6N7FW22x1bD6hxFHOcIGKTOV2V
         Au/tS20XzMStAHtBf00W6LEePbuHP9vY3H+hmT+uvId9kgPQpgoqgL/qLMm9sEAfSnSr
         4HKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629644; x=1716234444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpbwFa5RVgCPsd4J1YQdE/foyCe94LqF6avZiwQOX88=;
        b=v1w81Kun10XfYZsQI2hBCdXs3E6KnTNLmUS7GUOkA0zBM2VsXFFYzJ0PC6fobkyFOi
         C99QjNUM/6qWZTFB3fjOJRKUmcut5RoYnhysXn0qCnkN4Fpm0NjVgMnzy1i9JnQSh4aS
         5eVR/caJSzzn1rnNHmYe6lBW3RlFLcfqWHo0AgwggEtFOOrf1PK1G1KjZUx1XUj06XYa
         gmQb0yc1mcs2pUoLQfo+GaxfuTmtlfOj99JaSD8MLUCUsTM4+xuTD7BamenkGoZdsO7X
         VBjYxwDjG6Kr71wOk8vnLqMH0BawzQQsy/30JTiT6x/zelac+Y1thB5hc1YBkOQ/4azA
         3WLA==
X-Forwarded-Encrypted: i=1; AJvYcCWHWjhPpz+KNpr7t3oqAKKyXV3YoZI02PvB4tM53is+78U7e5lCbt5hyB/UbdrdWbZyuznRL9Wi3pas1z4JOKwKyYbnJl7v
X-Gm-Message-State: AOJu0YxWPOcxaY8gksVt9BcRJlZrxpqX42ClB7dKC9Br9XtaxjKGuE3m
	96wjXo4ykZzgg9CuT+ZprWqqH1PrByhwkf/Z5L+jSexsV0IIanS9e+F8W7U6IaAT1cLs92BKEMQ
	H
X-Google-Smtp-Source: AGHT+IEjXCZsad5cUyQsYWkb2h7s5HfvLnpg5cqhRqCwu1oZweze8pOGxiY9/0qy/9fyQB2XRQwWwg==
X-Received: by 2002:a05:622a:181c:b0:43a:1d94:c573 with SMTP id d75a77b69052e-43dfce2774dmr194364751cf.22.1715629644408;
        Mon, 13 May 2024 12:47:24 -0700 (PDT)
Received: from [10.73.215.90] ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df87da55bsm55472811cf.33.2024.05.13.12.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 12:47:23 -0700 (PDT)
Message-ID: <9e0f5d24-968c-4356-a243-62f972a17570@bytedance.com>
Date: Mon, 13 May 2024 12:47:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH net-next v3 2/3] sock: add MSG_ZEROCOPY
 notification mechanism based on msg_control
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, cong.wang@bytedance.com, xiaochun.lu@bytedance.com
References: <20240510155900.1825946-1-zijianzhang@bytedance.com>
 <20240510155900.1825946-3-zijianzhang@bytedance.com>
 <664165b9c4bbf_1d6c672948b@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <664165b9c4bbf_1d6c672948b@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/24 5:58 PM, Willem de Bruijn wrote:
> zijianzhang@ wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
>> However, zerocopy is not a free lunch. Apart from the management of user
>> pages, the combination of poll + recvmsg to receive notifications incurs
>> unignorable overhead in the applications. The overhead of such sometimes
>> might be more than the CPU savings from zerocopy. We try to solve this
>> problem with a new notification mechanism based on msgcontrol.
>> This new mechanism aims to reduce the overhead associated with receiving
>> notifications by embedding them directly into user arguments passed with
>> each sendmsg control message. By doing so, we can significantly reduce
>> the complexity and overhead for managing notifications. In an ideal
>> pattern, the user will keep calling sendmsg with SCM_ZC_NOTIFICATION
>> msg_control, and the notification will be delivered as soon as possible.
>>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> 
>> +#include <linux/types.h>
>> +
>>   /*
>>    * Desired design of maximum size and alignment (see RFC2553)
>>    */
>> @@ -35,4 +37,12 @@ struct __kernel_sockaddr_storage {
>>   #define SOCK_TXREHASH_DISABLED	0
>>   #define SOCK_TXREHASH_ENABLED	1
>>   
>> +#define SOCK_ZC_INFO_MAX 128
>> +
>> +struct zc_info_elem {
>> +	__u32 lo;
>> +	__u32 hi;
>> +	__u8 zerocopy;
>> +};
>> +
>>   #endif /* _UAPI_LINUX_SOCKET_H */
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 8d6e638b5426..15da609be026 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -2842,6 +2842,74 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>>   	case SCM_RIGHTS:
>>   	case SCM_CREDENTIALS:
>>   		break;
>> +	case SCM_ZC_NOTIFICATION: {
>> +		int ret, i = 0;
>> +		int cmsg_data_len, zc_info_elem_num;
>> +		void __user	*usr_addr;
>> +		struct zc_info_elem zc_info_kern[SOCK_ZC_INFO_MAX];
>> +		unsigned long flags;
>> +		struct sk_buff_head *q, local_q;
>> +		struct sk_buff *skb, *tmp;
>> +		struct sock_exterr_skb *serr;
> 
> minor: reverse xmas tree
> 

Ack.

>> +
>> +		if (!sock_flag(sk, SOCK_ZEROCOPY) || sk->sk_family == PF_RDS)
>> +			return -EINVAL;
> 
> Is this mechanism supported for PF_RDS?
> The next patch fails on PF_RDS + '-n'
> 

Nice catch! This mechanism does not support PF_RDS, I will update the
selftest code.

>> +
>> +		cmsg_data_len = cmsg->cmsg_len - sizeof(struct cmsghdr);
>> +		if (cmsg_data_len % sizeof(struct zc_info_elem))
>> +			return -EINVAL;
>> +
>> +		zc_info_elem_num = cmsg_data_len / sizeof(struct zc_info_elem);
>> +		if (!zc_info_elem_num || zc_info_elem_num > SOCK_ZC_INFO_MAX)
>> +			return -EINVAL;
>> +
>> +		if (in_compat_syscall())
>> +			usr_addr = compat_ptr(*(compat_uptr_t *)CMSG_DATA(cmsg));
>> +		else
>> +			usr_addr = (void __user *)*(void **)CMSG_DATA(cmsg);
> 
> The main design issue with this series is this indirection, rather
> than passing the array of notifications as cmsg.
> 
> This trick circumvents having to deal with compat issues and having to
> figure out copy_to_user in ____sys_sendmsg (as msg_control is an
> in-kernel copy).
> 
> This is quite hacky, from an API design PoV.
> 
> As is passing a pointer, but expecting msg_controllen to hold the
> length not of the pointer, but of the pointed to user buffer.
> 
> I had also hoped for more significant savings. Especially with the
> higher syscall overhead due to meltdown and spectre mitigations vs
> when MSG_ZEROCOPY was introduced and I last tried this optimization.
>
Thanks for the summary, totally agree! It's a hard choice to design the
API like this.

>> +		if (!access_ok(usr_addr, cmsg_data_len))
>> +			return -EFAULT;
>> +
>> +		q = &sk->sk_error_queue;
>> +		skb_queue_head_init(&local_q);
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
>> +				__skb_queue_tail(&local_q, skb);
>> +				i++;
>> +			}
>> +			skb = skb_next;
>> +		}
>> +		spin_unlock_irqrestore(&q->lock, flags);
>> +
>> +		ret = copy_to_user(usr_addr,
>> +				   zc_info_kern,
>> +					i * sizeof(struct zc_info_elem));
>> +
>> +		if (unlikely(ret)) {
>> +			spin_lock_irqsave(&q->lock, flags);
>> +			skb_queue_reverse_walk_safe(&local_q, skb, tmp) {
>> +				__skb_unlink(skb, &local_q);
>> +				__skb_queue_head(q, skb);
>> +			}
> 
> Can just list_splice_init?
> 

Ack.

>> +			spin_unlock_irqrestore(&q->lock, flags);
>> +			return -EFAULT;
>> +		}
>> +
>> +		while ((skb = __skb_dequeue(&local_q)))
>> +			consume_skb(skb);
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

