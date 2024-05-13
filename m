Return-Path: <netdev+bounces-96154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8CE8C4820
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 22:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44877285AC0
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 20:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21FA7E0FB;
	Mon, 13 May 2024 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NMUxLCoT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A170B39FD8
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715631781; cv=none; b=nsQh0s96novQTyT4uwRH31ppMel7ED+iCiWXfTFkH7bxA5OLptM/d9wkXYs/bbJnjgje4bEJCrraCkCLRAFsQ8fbRc5kEBtIdaLY5IuX0o0RdhisuMl231zpGRRSdIZuOlCUScq8skIV57NsmlFTt1o4luy6RSZdc7CC1+VLuUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715631781; c=relaxed/simple;
	bh=KUKqoqtPohhcx5HS0kuvJuc5xehMXQbh+UXuAArk02E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HHk1ORwkz1QgTH2PwGWqGke2HIlN9FBmtKEqp47wrPXmwMmj6znTlM1Hku60dGhSjbVcCoEx/4s7x1vdkHaksFevz+JcGjJLihlx1F566ANiK8AHpcwQ1/RSe4TuTPRaaB4NBPR9vrVySgpk/dYSN+ERs15PLPiAovzrUYA8WXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NMUxLCoT; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6a0b68733f5so33291446d6.1
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 13:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715631778; x=1716236578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O0RHunAs0/8Rhdj/LOVpCGhwI3PzsBO006bbMTcxFU0=;
        b=NMUxLCoTgW7jJK3J2kE8katnimj5KBeXsxnkmuD/cdkmiAmxeGH8UphgKjuuRYuuzo
         0/h0LbGGuTAVg5al9i/es0D8O+yWjc9aZB2KrH7oh5wGRFvhy/q45RqP45mEg9EQ/Ji8
         DXdWvilOInNJbITL2Aojx91B4zZl6q4e8SG8JlvmhC/lTE/iU8xwp/y1gy2IvJh8Gh29
         YOKmxtFmrXYJvIzK+yCb7lg/F1m8vifId3jv5vvPhr3n6+38g9APUeG1zrSUsvlzMSBh
         OMqnfVTgG9mxd1SlihOvSMDgOyVZgs5HeWpYBk3+PAW69OpWv6GXQe+qeRkizrSn4qZW
         d3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715631778; x=1716236578;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0RHunAs0/8Rhdj/LOVpCGhwI3PzsBO006bbMTcxFU0=;
        b=jod0pV8qdRWXlGtwSVDbkxtwJ5twctHRiGcQP0mLnlGIDE9t8c9P0EF0gM+AClf7fJ
         9C9lua2gz8Uxk64UEg0ZUUNg9wKfQ8T9lk4UMUtNMD2HegeOfH+mj8siTgksXuWQwFa+
         1DLmHNGDEw8QHeCYfK/SdZ9JgdAJDpAxLEXEmaIEGJBatcQLwTXyKfFn30zG3HqtGjHp
         2JSuEffMlPbaYk052jbGjkModk+jctUo763Gi4VABvPaS8FzuQdfTWO+zaE1FsTBrwO9
         XUzAEiBwWC48kTfkqlC9DcYDtEyLV3nkwm3C6QuqJknuweB9/+LDvkguu6caM5PdfNvt
         NjkA==
X-Forwarded-Encrypted: i=1; AJvYcCWWJ/nrGPRPM4mOuhazu4rZheF1fgQSJp4xUuooTYNv9hhv9fqywH+rj4nbCjVwIehDsnq0g2kt9l0/Zx7RUXRzUELz+91f
X-Gm-Message-State: AOJu0YyD2ORzw5op1kda64I7cmzoZHShaOUkx6samXHWKSDVtBTOeGI5
	fXpo8l0xoC15EV+m89cHSUYcfK0cVETBPTl1fvNdFSVdMyD8ahdULAR2qbc95u8=
X-Google-Smtp-Source: AGHT+IGT4eKlEkv0cf5y5DbhGG1C5urq/SbLaC/AeWv/wAZLf3w2Lq56L6fxz5SpNJMOgjgYtFZ9Cw==
X-Received: by 2002:a05:6214:3d97:b0:6a0:a7a9:4ad4 with SMTP id 6a1803df08f44-6a1681792efmr158955756d6.7.1715631778372;
        Mon, 13 May 2024 13:22:58 -0700 (PDT)
Received: from [10.73.215.90] ([72.29.204.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1858d0sm46631916d6.50.2024.05.13.13.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 13:22:57 -0700 (PDT)
Message-ID: <e8311ab0-9efa-47b8-be1d-d5afbb223007@bytedance.com>
Date: Mon, 13 May 2024 13:22:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH net-next v3 2/3] sock: add MSG_ZEROCOPY
 notification mechanism based on msg_control
From: Zijian Zhang <zijianzhang@bytedance.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, cong.wang@bytedance.com, xiaochun.lu@bytedance.com
References: <20240510155900.1825946-1-zijianzhang@bytedance.com>
 <20240510155900.1825946-3-zijianzhang@bytedance.com>
 <664165b9c4bbf_1d6c672948b@willemb.c.googlers.com.notmuch>
 <9e0f5d24-968c-4356-a243-62f972a17570@bytedance.com>
Content-Language: en-US
In-Reply-To: <9e0f5d24-968c-4356-a243-62f972a17570@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/13/24 12:47 PM, Zijian Zhang wrote:
> On 5/12/24 5:58 PM, Willem de Bruijn wrote:
>> zijianzhang@ wrote:
>>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>>
>>> The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
>>> However, zerocopy is not a free lunch. Apart from the management of user
>>> pages, the combination of poll + recvmsg to receive notifications incurs
>>> unignorable overhead in the applications. The overhead of such sometimes
>>> might be more than the CPU savings from zerocopy. We try to solve this
>>> problem with a new notification mechanism based on msgcontrol.
>>> This new mechanism aims to reduce the overhead associated with receiving
>>> notifications by embedding them directly into user arguments passed with
>>> each sendmsg control message. By doing so, we can significantly reduce
>>> the complexity and overhead for managing notifications. In an ideal
>>> pattern, the user will keep calling sendmsg with SCM_ZC_NOTIFICATION
>>> msg_control, and the notification will be delivered as soon as possible.
>>>
>>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>>> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
>>
>>> +#include <linux/types.h>
>>> +
>>>   /*
>>>    * Desired design of maximum size and alignment (see RFC2553)
>>>    */
>>> @@ -35,4 +37,12 @@ struct __kernel_sockaddr_storage {
>>>   #define SOCK_TXREHASH_DISABLED    0
>>>   #define SOCK_TXREHASH_ENABLED    1
>>> +#define SOCK_ZC_INFO_MAX 128
>>> +
>>> +struct zc_info_elem {
>>> +    __u32 lo;
>>> +    __u32 hi;
>>> +    __u8 zerocopy;
>>> +};
>>> +
>>>   #endif /* _UAPI_LINUX_SOCKET_H */
>>> diff --git a/net/core/sock.c b/net/core/sock.c
>>> index 8d6e638b5426..15da609be026 100644
>>> --- a/net/core/sock.c
>>> +++ b/net/core/sock.c
>>> @@ -2842,6 +2842,74 @@ int __sock_cmsg_send(struct sock *sk, struct 
>>> cmsghdr *cmsg,
>>>       case SCM_RIGHTS:
>>>       case SCM_CREDENTIALS:
>>>           break;
>>> +    case SCM_ZC_NOTIFICATION: {
>>> +        int ret, i = 0;
>>> +        int cmsg_data_len, zc_info_elem_num;
>>> +        void __user    *usr_addr;
>>> +        struct zc_info_elem zc_info_kern[SOCK_ZC_INFO_MAX];
>>> +        unsigned long flags;
>>> +        struct sk_buff_head *q, local_q;
>>> +        struct sk_buff *skb, *tmp;
>>> +        struct sock_exterr_skb *serr;
>>
>> minor: reverse xmas tree
>>
> 
> Ack.
> 
>>> +
>>> +        if (!sock_flag(sk, SOCK_ZEROCOPY) || sk->sk_family == PF_RDS)
>>> +            return -EINVAL;
>>
>> Is this mechanism supported for PF_RDS?
>> The next patch fails on PF_RDS + '-n'
>>
> 
> Nice catch! This mechanism does not support PF_RDS, I will update the
> selftest code.
> 

PF_RDS does not use MSGERR queue to store the info, thus it is not
supported by this patch. I will leave it as "unsupported" in the 
"selftest -n" now.

If possible, I may leave the support for PF_RDS in another patch set in
the future.

>>> +
>>> +        cmsg_data_len = cmsg->cmsg_len - sizeof(struct cmsghdr);
>>> +        if (cmsg_data_len % sizeof(struct zc_info_elem))
>>> +            return -EINVAL;
>>> +
>>> +        zc_info_elem_num = cmsg_data_len / sizeof(struct zc_info_elem);
>>> +        if (!zc_info_elem_num || zc_info_elem_num > SOCK_ZC_INFO_MAX)
>>> +            return -EINVAL;
>>> +
>>> +        if (in_compat_syscall())
>>> +            usr_addr = compat_ptr(*(compat_uptr_t *)CMSG_DATA(cmsg));
>>> +        else
>>> +            usr_addr = (void __user *)*(void **)CMSG_DATA(cmsg);
>>
>> The main design issue with this series is this indirection, rather
>> than passing the array of notifications as cmsg.
>>
>> This trick circumvents having to deal with compat issues and having to
>> figure out copy_to_user in ____sys_sendmsg (as msg_control is an
>> in-kernel copy).
>>
>> This is quite hacky, from an API design PoV.
>>
>> As is passing a pointer, but expecting msg_controllen to hold the
>> length not of the pointer, but of the pointed to user buffer.
>>
>> I had also hoped for more significant savings. Especially with the
>> higher syscall overhead due to meltdown and spectre mitigations vs
>> when MSG_ZEROCOPY was introduced and I last tried this optimization.
>>
> Thanks for the summary, totally agree! It's a hard choice to design the
> API like this.
> 
>>> +        if (!access_ok(usr_addr, cmsg_data_len))
>>> +            return -EFAULT;
>>> +
>>> +        q = &sk->sk_error_queue;
>>> +        skb_queue_head_init(&local_q);
>>> +        spin_lock_irqsave(&q->lock, flags);
>>> +        skb = skb_peek(q);
>>> +        while (skb && i < zc_info_elem_num) {
>>> +            struct sk_buff *skb_next = skb_peek_next(skb, q);
>>> +
>>> +            serr = SKB_EXT_ERR(skb);
>>> +            if (serr->ee.ee_errno == 0 &&
>>> +                serr->ee.ee_origin == SO_EE_ORIGIN_ZEROCOPY) {
>>> +                zc_info_kern[i].hi = serr->ee.ee_data;
>>> +                zc_info_kern[i].lo = serr->ee.ee_info;
>>> +                zc_info_kern[i].zerocopy = !(serr->ee.ee_code
>>> +                                & SO_EE_CODE_ZEROCOPY_COPIED);
>>> +                __skb_unlink(skb, q);
>>> +                __skb_queue_tail(&local_q, skb);
>>> +                i++;
>>> +            }
>>> +            skb = skb_next;
>>> +        }
>>> +        spin_unlock_irqrestore(&q->lock, flags);
>>> +
>>> +        ret = copy_to_user(usr_addr,
>>> +                   zc_info_kern,
>>> +                    i * sizeof(struct zc_info_elem));
>>> +
>>> +        if (unlikely(ret)) {
>>> +            spin_lock_irqsave(&q->lock, flags);
>>> +            skb_queue_reverse_walk_safe(&local_q, skb, tmp) {
>>> +                __skb_unlink(skb, &local_q);
>>> +                __skb_queue_head(q, skb);
>>> +            }
>>
>> Can just list_splice_init?
>>
> 
> Ack.
> 
>>> +            spin_unlock_irqrestore(&q->lock, flags);
>>> +            return -EFAULT;
>>> +        }
>>> +
>>> +        while ((skb = __skb_dequeue(&local_q)))
>>> +            consume_skb(skb);
>>> +        break;
>>> +    }
>>>       default:
>>>           return -EINVAL;
>>>       }
>>> -- 
>>> 2.20.1
>>>
>>
>>

