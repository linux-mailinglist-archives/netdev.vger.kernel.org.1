Return-Path: <netdev+bounces-113131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E631093CBA3
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 02:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2156FB219C0
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 00:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1A018E;
	Fri, 26 Jul 2024 00:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LQsiJYiN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C3CB67F
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 00:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721952115; cv=none; b=M9qN7GTnPrk7hVyHNmRPmXNlIBjZT3vIz/xUp6Ww+2Mq3uRWyotyY1FwybtSHmV5vINeMNp2w+yoAmuOJxGbCqM33PZbGjCg3MNZ+72OSmHpB25eK6WPMoUQ+6wL7suYOQwJXmD+oflLMxULzPRnd/AErEHDrPVlDIy0ctlgha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721952115; c=relaxed/simple;
	bh=paeFH1ZRPdI9c0Bs0SRrrYkQg/dFdKOckKLi/SQjnEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EekgHAkpJKZP3N8/1GejA+4TWtpNZQuK6SQdzO6bVztGPnZfft0oORkSuBYssabykl9ZE5duzc//YYPiQfCVJh3j7YCRpSXn2ENVr9hwx7ke2t028+RZEACnbo3g4ZgLWz7aEP8Z7vF7M0iDcox2dQZsWcavDteiHI/mPRzuuV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LQsiJYiN; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b796667348so1078196d6.0
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 17:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721952112; x=1722556912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8O1M/mJxxUckrzc1hO5TyDwRUQ1nE1m+6l4GNkgVGCc=;
        b=LQsiJYiNgUzAoy2dJdw3KuMWoPUSJZddHbqcUekpwn5CjpdpRDOZ/nKjimp8pjhCEh
         De9x4b7LKjvqvJPPvGbK3PFWU2kSPdEhdgR2H3zMSWjDRsDqY4cjleZ37OO8maOsTlq8
         X8sJC+vi7kUfSNP4/UjzodtsDsbBB288LjVIrzRr/IS6pFZBYnN+qjnvCaFJf7KCBVtf
         ZirLcFufNS0R1hMcHg8aeUSYtPx8/zRWBPXG82dxzcv+IiqS2lDu0Vqo/DwlIfSE3s70
         ujyFSnZxuPdaeVLTaEiiSpvoBKQ0lFXWtShUuBVbdezCrNsSoj+o9xkdEGY03LHzeKlF
         MuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721952112; x=1722556912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8O1M/mJxxUckrzc1hO5TyDwRUQ1nE1m+6l4GNkgVGCc=;
        b=IkpW2MbFRinOQq1D0+B62VS3Jr9mwecn+vOlSNpP/iYU5IpA/900cIHFakdjuBYHr8
         0BMLuHxMkE13J8+61PQHKK6/1I7HsQBXFbEmSPUJZA25EWySsosB7dRj3iRHyxIui38F
         xT0pRhq79xEHWY8RNe528nZt2tHLl3In1KBTmVIiqCqsXaqXAVASelSnRD8FumPUrrcC
         XoK+mPLkrXSpF/ru9Y89jv/fJhRxBKkbSGgVN0arzec76WTwr7JF8SEwYjdesOyERlgL
         VYJMVhFZq0GjbFm5CO4YAJcvdHcc1OAdH7w6jarB5MGa30fXppXul9IdIrnv6SBXbEuk
         N52g==
X-Gm-Message-State: AOJu0YzBY1lcW2wRaRVYDF6i8qwWw58YN8WjoiJ0dhmIAii/ms0Qnpjy
	BhuKwbvnEFQQxfWnn5+khwtcFS2xB5siBH4PsyQWmhcTpAaCLtG9JodWIii9voQ=
X-Google-Smtp-Source: AGHT+IHw9yAMsxYtUxyY3rxGpu5pOgsblRBmc8i6jM+YPJbL+06hVjyk/2OWNXNwsdGi7e9bqxEhyQ==
X-Received: by 2002:a05:6214:1d0a:b0:6b5:e1dd:369a with SMTP id 6a1803df08f44-6bb3c8adecdmr83577966d6.11.1721952111906;
        Thu, 25 Jul 2024 17:01:51 -0700 (PDT)
Received: from [10.5.119.35] (ec2-54-92-141-197.compute-1.amazonaws.com. [54.92.141.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa94c50sm11538786d6.81.2024.07.25.17.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 17:01:51 -0700 (PDT)
Message-ID: <b2dd03f7-34de-4a56-a727-8ec2effa2288@bytedance.com>
Date: Thu, 25 Jul 2024 17:01:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH net-next v7 2/3] sock: add MSG_ZEROCOPY
 notification mechanism based on msg_control
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, edumazet@google.com,
 willemdebruijn.kernel@gmail.com, cong.wang@bytedance.com,
 xiaochun.lu@bytedance.com
References: <20240708210405.870930-1-zijianzhang@bytedance.com>
 <20240708210405.870930-3-zijianzhang@bytedance.com>
 <ZqLKy8OqpMi-kPQ3@google.com>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <ZqLKy8OqpMi-kPQ3@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 2:59 PM, Mina Almasry wrote:
> On Mon, Jul 08, 2024 at 09:04:04PM +0000, zijianzhang@bytedance.com wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
>> However, zerocopy is not a free lunch. Apart from the management of user
>> pages, the combination of poll + recvmsg to receive notifications incurs
>> unignorable overhead in the applications. We try to mitigate this overhead
>> with a new notification mechanism based on msg_control. Leveraging the
>> general framework to copy cmsgs to the user space, we copy zerocopy
>> notifications to the user upon returning of sendmsgs.
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
>>   include/uapi/linux/socket.h           | 13 ++++++++
>>   net/core/sock.c                       | 46 +++++++++++++++++++++++++++
>>   8 files changed, 70 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
>> index e94f621903fe..7c32d9dbe47f 100644
>> --- a/arch/alpha/include/uapi/asm/socket.h
>> +++ b/arch/alpha/include/uapi/asm/socket.h
>> @@ -140,6 +140,8 @@
>>   #define SO_PASSPIDFD		76
>>   #define SO_PEERPIDFD		77
>>
>> +#define SCM_ZC_NOTIFICATION	78
>> +
>>   #if !defined(__KERNEL__)
>>
>>   #if __BITS_PER_LONG == 64
>> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
>> index 60ebaed28a4c..3f7fade998cb 100644
>> --- a/arch/mips/include/uapi/asm/socket.h
>> +++ b/arch/mips/include/uapi/asm/socket.h
>> @@ -151,6 +151,8 @@
>>   #define SO_PASSPIDFD		76
>>   #define SO_PEERPIDFD		77
>>
>> +#define SCM_ZC_NOTIFICATION	78
>> +
>>   #if !defined(__KERNEL__)
>>
>>   #if __BITS_PER_LONG == 64
>> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
>> index be264c2b1a11..77f5bee0fdc9 100644
>> --- a/arch/parisc/include/uapi/asm/socket.h
>> +++ b/arch/parisc/include/uapi/asm/socket.h
>> @@ -132,6 +132,8 @@
>>   #define SO_PASSPIDFD		0x404A
>>   #define SO_PEERPIDFD		0x404B
>>
>> +#define SCM_ZC_NOTIFICATION	0x404C
>> +
>>   #if !defined(__KERNEL__)
>>
>>   #if __BITS_PER_LONG == 64
>> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
>> index 682da3714686..eb44fc515b45 100644
>> --- a/arch/sparc/include/uapi/asm/socket.h
>> +++ b/arch/sparc/include/uapi/asm/socket.h
>> @@ -133,6 +133,8 @@
>>   #define SO_PASSPIDFD             0x0055
>>   #define SO_PEERPIDFD             0x0056
>>
>> +#define SCM_ZC_NOTIFICATION      0x0057
>> +
>>   #if !defined(__KERNEL__)
>>
>>
>> diff --git a/include/linux/socket.h b/include/linux/socket.h
>> index 75461812a7a3..6f1b791e2de8 100644
>> --- a/include/linux/socket.h
>> +++ b/include/linux/socket.h
>> @@ -171,7 +171,7 @@ static inline struct cmsghdr * cmsg_nxthdr (struct msghdr *__msg, struct cmsghdr
>>
>>   static inline bool cmsg_copy_to_user(struct cmsghdr *__cmsg)
>>   {
>> -	return 0;
>> +	return __cmsg->cmsg_type == SCM_ZC_NOTIFICATION;
>>   }
>>
>>   static inline size_t msg_data_left(struct msghdr *msg)
>> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
>> index 8ce8a39a1e5f..02e9159c7944 100644
>> --- a/include/uapi/asm-generic/socket.h
>> +++ b/include/uapi/asm-generic/socket.h
>> @@ -135,6 +135,8 @@
>>   #define SO_PASSPIDFD		76
>>   #define SO_PEERPIDFD		77
>>
>> +#define SCM_ZC_NOTIFICATION	78
>> +
>>   #if !defined(__KERNEL__)
>>
>>   #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
>> diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
>> index d3fcd3b5ec53..ab361f30f3a6 100644
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
>> @@ -35,4 +37,15 @@ struct __kernel_sockaddr_storage {
>>   #define SOCK_TXREHASH_DISABLED	0
>>   #define SOCK_TXREHASH_ENABLED	1
>>
>> +struct zc_info_elem {
>> +	__u32 lo;
>> +	__u32 hi;
>> +	__u8 zerocopy;
> 
> Some docs please on what each of these are, if possible. Sorry if the repeated
> requests are annoying.
> 
> In particular I'm a bit confused why the zerocopy field is there. Looking at
> the code, is this always set to 1?
> 
```
hi = serr->ee_data;
lo = serr->ee_info;
zerocopy = !(serr->ee_code & SO_EE_CODE_ZEROCOPY_COPIED);
```
In the original method, the above code means one notification for
sendmsg id [lo, hi], with zerocopy=n/y to denote if the zerocopy is
reverted back to copy.

So the zerocopy field aligns the same meaning of
!(serr->ee_code & SO_EE_CODE_ZEROCOPY_COPIED) in the original method.

Sorry for the confusion, I will add more docs to explain it.

>> +};
>> +
>> +struct zc_info {
>> +	__u32 size;
>> +	struct zc_info_elem arr[];
>> +};
>> +
>>   #endif /* _UAPI_LINUX_SOCKET_H */
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index efb30668dac3..e0b5162233d3 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -2863,6 +2863,52 @@ int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
>>   	case SCM_RIGHTS:
>>   	case SCM_CREDENTIALS:
>>   		break;
>> +	case SCM_ZC_NOTIFICATION: {
>> +		struct zc_info *zc_info = CMSG_DATA(cmsg);
>> +		struct zc_info_elem *zc_info_arr;
>> +		struct sock_exterr_skb *serr;
>> +		int cmsg_data_len, i = 0;
>> +		struct sk_buff_head *q;
>> +		unsigned long flags;
>> +		struct sk_buff *skb;
>> +		u32 zc_info_size;
>> +
>> +		if (!sock_flag(sk, SOCK_ZEROCOPY) || sk->sk_family == PF_RDS)
>> +			return -EINVAL;
>> +
>> +		cmsg_data_len = cmsg->cmsg_len - sizeof(struct cmsghdr);
>> +		if (cmsg_data_len < sizeof(struct zc_info))
>> +			return -EINVAL;
>> +
>> +		zc_info_size = zc_info->size;
>> +		zc_info_arr = zc_info->arr;
> 
> Annoying nit: To be honest zc_info->size isn't much longer to type than
> zc_info_size, so I would have not added local variables.
> 

Agree, nice catch!

>> +		if (cmsg_data_len != sizeof(struct zc_info) +
>> +				     zc_info_size * sizeof(struct zc_info_elem))
>> +			return -EINVAL;
>> +
>> +		q = &sk->sk_error_queue;
>> +		spin_lock_irqsave(&q->lock, flags);
>> +		skb = skb_peek(q);
>> +		while (skb && i < zc_info_size) {
>> +			struct sk_buff *skb_next = skb_peek_next(skb, q);
>> +
>> +			serr = SKB_EXT_ERR(skb);
>> +			if (serr->ee.ee_errno == 0 &&
>> +			    serr->ee.ee_origin == SO_EE_ORIGIN_ZEROCOPY) {
>> +				zc_info_arr[i].hi = serr->ee.ee_data;
>> +				zc_info_arr[i].lo = serr->ee.ee_info;
>> +				zc_info_arr[i].zerocopy = !(serr->ee.ee_code
>> +							  & SO_EE_CODE_ZEROCOPY_COPIED);
>> +				__skb_unlink(skb, q);
>> +				consume_skb(skb);
>> +				i++;
>> +			}
>> +			skb = skb_next;
>> +		}
>> +		spin_unlock_irqrestore(&q->lock, flags);
> 
> I wonder if you should drop the spin lock in the middle of this loop somehow,
> otherwise you may end up spinning for a very long time while the spinlock held
> and irq disabled.
> 
> IIRC zc_info_size is user input, right? Maybe you should limit zc_info_size to
> 16 entries or something. So the user doesn't end up passing 100000 as
>     zc_info_size and making the kernel loop for a long time here.
> 

Thanks for the suggestion, totally agree, I should limit the
zc_info_size.

>> +		zc_info->size = i;
>> +		break;
>> +	}
>>   	default:
>>   		return -EINVAL;
>>   	}
>> --
>> 2.20.1
>>

