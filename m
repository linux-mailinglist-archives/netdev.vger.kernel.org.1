Return-Path: <netdev+bounces-100415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 047748FA748
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 03:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776B61F2394A
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 01:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5629A23;
	Tue,  4 Jun 2024 01:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JPlYtin1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF00818
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 01:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717462922; cv=none; b=fBjF/FAUtuggdE7QvXhu8eIt0wNmsLV4a2KNiuHbp0cConQ9ZmslKLhds0joj4vsKeEiEaHWVH5OlNh9vayrNy97GDCubW3So0nu1n9esl/n8xNx7ULROL1fWf6jZ9EztO+GI30fsz9dCesuoycoevhUfDpg2WH8M2+ewFnvyz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717462922; c=relaxed/simple;
	bh=LPzjcAaSH+FoI+8L7sZy/b1t15bE25xOwc2yU91A/4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lrQHfOah8WYjvS50ZHVuoyNILc68wxS9MlSbOiOx97QD6WnjOOn/Ts+bpallUAJme8xGqVQHUwlJHAFm10VJGUjpOzJnkqN8i2rcnx0xucRoLOKRWu2SIyf0n5R/5mGX7rmg9DaTbHRe8Yx0F/mR1eVJ1xPcpaTFKg4tLDbPUsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JPlYtin1; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79476195696so34252585a.0
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 18:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1717462919; x=1718067719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0FbFdrRxTucZgtyIVJohSw4Ry6aueBm9ldjQwTEh94=;
        b=JPlYtin1HBYldyM1QO3GrDnP7QIWjDUl1g/Gs/LWMQa6zDN0zAvGd5I0SWcuYwf3HT
         UgXJQ9HPyCadg3lEL7FlfAYK78kBYW9wUSlxew4vhPiIpSBsa6M5xa3TQdp4Vq7l+PO1
         Qf4m1dKuVcPTXgUMXi8n2MpO6s0eZoAMQ6GRxY6qKGKgXQEZaKNYu4b2dFLGBYktbKoY
         GVy9wuzRmIbd9cAky2bwCvcEUkDvwpr6A6zNNvBYt/fGTBdCsQBHfMBcxAKhEC8rP1ko
         v931v5DH2wa/6lI21CYrRSotyS6nlxOId0J+8he83ivVqJ3lUoQq9OTBeUrUp9sdpx1F
         bsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717462919; x=1718067719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0FbFdrRxTucZgtyIVJohSw4Ry6aueBm9ldjQwTEh94=;
        b=kwuQx7xti+0lpP4n5X2aJ61YoYE6bY/NqWS0sWYB0DII2lZG6clLt8WLknWReRwY/h
         g78Cnzq0FXazjV1ZX+PS5sXYKOQCnlQlatzK9yIriVAmAWkMGnjkSZ5Rmx1v6LSa1tzk
         drJoQZVJzECqd01W4gFg5rAA7OajirjuMu2u2eAyrE5NuYKw7DPx6iqISoskRK6neaul
         n42xeM2Mz/bJEC9nkzKw0jE8HTM8xymFqYzdIe0j3mazIr+iEbsUA37OgYbnkvxW/6iF
         9Z1SitpB4M/aWUub5uIKm5DZQGZj2BWgvpj7c8wSU0oee/O7qiE2x2zICpz2JagagNQb
         mTSA==
X-Forwarded-Encrypted: i=1; AJvYcCVvYHgWkwHYEGVUTWr/hGlmpWK/PWSlSwTVMx9XByeQ8gy72fPPhW7M3YjcSSwfWaFZl8D8C/rO1HUPQncPOhcEqkj/hBHv
X-Gm-Message-State: AOJu0Yxtu0P9DfrskUXDIFzSQ33weiKimcEGy8lxK7FELKG2nKU8p8qu
	90gFiyDJv1VWlFXi+lV42FcgOZSRqrPt77LtyD8EU1s2LdNzYxNg8QAS9HwZKKc=
X-Google-Smtp-Source: AGHT+IEg6noFEx/gPbFbrk89XZ5QJCzOWU26TxTz+hiTgZ+tFOvr6vwqX8mwBI7Z1bI9ZhA/TCaUbQ==
X-Received: by 2002:a37:e314:0:b0:78d:6b42:6c17 with SMTP id af79cd13be357-794f5ed3c75mr964807885a.76.1717462919136;
        Mon, 03 Jun 2024 18:01:59 -0700 (PDT)
Received: from [10.5.113.34] (ec2-54-92-141-197.compute-1.amazonaws.com. [54.92.141.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f317863asm324326585a.114.2024.06.03.18.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 18:01:58 -0700 (PDT)
Message-ID: <3ce746bd-e1a3-4e3d-bff9-9d692f4d7f20@bytedance.com>
Date: Mon, 3 Jun 2024 18:01:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH net-next v4 2/3] sock: add MSG_ZEROCOPY
 notification mechanism based on msg_control
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: xiaochun.lu@bytedance.com, cong.wang@bytedance.com
References: <20240528212103.350767-1-zijianzhang@bytedance.com>
 <20240528212103.350767-3-zijianzhang@bytedance.com>
 <f2621d81-0d85-440a-ae52-460625bfff40@bytedance.com>
 <CAF=yD-KTcb0RfKLuZ9Sx0gTH-iZyvAfv3u=c6y7Gtm=znDS=nw@mail.gmail.com>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <CAF=yD-KTcb0RfKLuZ9Sx0gTH-iZyvAfv3u=c6y7Gtm=znDS=nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/2/24 3:29 PM, Willem de Bruijn wrote:
> On Fri, May 31, 2024 at 7:20 PM Zijian Zhang <zijianzhang@bytedance.com> wrote:
>>
>>
>>
>> On 5/28/24 2:21 PM, zijianzhang@bytedance.com wrote:
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
>>> ---
>>>    arch/alpha/include/uapi/asm/socket.h  |  2 +
>>>    arch/mips/include/uapi/asm/socket.h   |  2 +
>>>    arch/parisc/include/uapi/asm/socket.h |  2 +
>>>    arch/sparc/include/uapi/asm/socket.h  |  2 +
>>>    include/uapi/asm-generic/socket.h     |  2 +
>>>    include/uapi/linux/socket.h           | 10 ++++
>>>    net/core/sock.c                       | 68 +++++++++++++++++++++++++++
>>>    7 files changed, 88 insertions(+)
>>>
>>> ...
>>> diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
>>> index d3fcd3b5ec53..15cec8819f34 100644
>>> --- a/include/uapi/linux/socket.h
>>> +++ b/include/uapi/linux/socket.h
>>> @@ -2,6 +2,8 @@
>>>    #ifndef _UAPI_LINUX_SOCKET_H
>>>    #define _UAPI_LINUX_SOCKET_H
>>>
>>> +#include <linux/types.h>
>>> +
>>>    /*
>>>     * Desired design of maximum size and alignment (see RFC2553)
>>>     */
>>> @@ -35,4 +37,12 @@ struct __kernel_sockaddr_storage {
>>>    #define SOCK_TXREHASH_DISABLED      0
>>>    #define SOCK_TXREHASH_ENABLED       1
>>>
>>> +#define SOCK_ZC_INFO_MAX 128
>>> +
>>> +struct zc_info_elem {
>>> +     __u32 lo;
>>> +     __u32 hi;
>>> +     __u8 zerocopy;
>>> +};
>>> +
>>>    #endif /* _UAPI_LINUX_SOCKET_H */
>>> diff --git a/net/core/sock.c b/net/core/sock.c
>>> index 521e6373d4f7..21239469d75c 100644
>>> --- a/net/core/sock.c
>>> +++ b/net/core/sock.c
>>> @@ -2847,6 +2847,74 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>>>        case SCM_RIGHTS:
>>>        case SCM_CREDENTIALS:
>>>                break;
>>> +     case SCM_ZC_NOTIFICATION: {
>>> +             int ret, i = 0;
>>> +             int cmsg_data_len, zc_info_elem_num;
>>> +             void __user     *usr_addr;
>>> +             struct zc_info_elem zc_info_kern[SOCK_ZC_INFO_MAX];
>>> +             unsigned long flags;
>>> +             struct sk_buff_head *q, local_q;
>>> +             struct sk_buff *skb, *tmp;
>>> +             struct sock_exterr_skb *serr;
>>> +
>>> +             if (!sock_flag(sk, SOCK_ZEROCOPY) || sk->sk_family == PF_RDS)
>>> +                     return -EINVAL;
>>> +
>>> +             cmsg_data_len = cmsg->cmsg_len - sizeof(struct cmsghdr);
>>> +             if (cmsg_data_len % sizeof(struct zc_info_elem))
>>> +                     return -EINVAL;
>>> +
>>> +             zc_info_elem_num = cmsg_data_len / sizeof(struct zc_info_elem);
>>> +             if (!zc_info_elem_num || zc_info_elem_num > SOCK_ZC_INFO_MAX)
>>> +                     return -EINVAL;
>>> +
>>> +             if (in_compat_syscall())
>>> +                     usr_addr = compat_ptr(*(compat_uptr_t *)CMSG_DATA(cmsg));
>>> +             else
>>> +                     usr_addr = (void __user *)*(void **)CMSG_DATA(cmsg);
>>
>> First of all, thanks for your efforts and time to review this series of
>> patchsets!
> 
> Please try to keep this conversation on the netdev list. What I
> respond below would be good to have in public discourse. Among
> others for others to come disagree with me and tell you that they
> prefer your patchset just the way it is ;-)
> 
>> I believe compat issue has been resolved in this if code block? I know
>> that the current design is quite hacky, and want to discuss next steps
>> with you,
>>
>> 1. Is it possible to change ____sys_sendmsg? So that we can copy
>> msg_controldata back to the user space.
> 
> I do think that this is the clean way to support passing metadata
> up to userspace.
> 
> The current approach looks like a hack to me. It works, but arguably
> is not how you implement a serious user API (ABI).
> 
> A more complete solution can potentially also be reused by other
> features that want to piggy-back information from the kernel back
> up to userspace with sendmsg. Timestamps is an example.
> 
> I did implement the full method once.
> 
> Initially, don't spend time on modifying ___sys_sendmsg *and*
> on supporting the compat version. With the right structs (that are
> not ambiguous between 32 and 64 bit) it may not even be needed.
> 
> But I would be more supportive of this full interface.
> 
> It also ties into the performance benefits observed. If they were
> shockingly good, I would still argue in favor of a cleaner API, to be
> clear. But a minor improvement is even less reason to consider a
> hacky API.
> 
> All of this is just one person's opinion, of course.
> 
>> 2. Is it possible to support this feature in recvmsg instead of
>> sendmsg? In the case of selftest where one thread keeps sending
>> and another keeps recving, this feature is useless. But in other
>> cases where one socket will send and recv, this might help?
> 
> That's a lot easier. And halves the cost of having to calll both
> recvmsg + recvmsg MSG_ERRQUEUE.
> 
>> For sockets that send many times but recv very few times, a hybrid
>> mode of notification using msg_control and errmsg_queue can be used.
>>
>> 3. Or, do you have any idea?
>>

I did not remember the reason why we directly pass in the user address
and have ctl_len to be the array size. Can I pass in a struct like
{
   __user void *user_addr;
   __u32 array_size;
}
and have ctl_len to be the sizeof the struct, just like my first patch
set? Of course, I will consider the compat issue for user_addr this time.

>> If the above solutions are hard to be accepted, I can totally
>> understand, and I will submit the fix to msg_zerocopy selftest only.

