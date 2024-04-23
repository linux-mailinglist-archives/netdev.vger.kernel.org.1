Return-Path: <netdev+bounces-90674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A0A8AF79E
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 21:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4341F23D9C
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 19:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C384713FD67;
	Tue, 23 Apr 2024 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="byer4bvb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5AD13D510
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 19:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901926; cv=none; b=MBgeeY6JfwmVBy08nffXZBHzRd643+ZXcGpHvOX0ypp5D/cXaDL30DsKQyRbGKjrRTurmVYxR8Zvclj30KCvVe8TBNoUYXysfTygMYb+5S+w8G57U7ioxE9sxmhjGG6CMlGWRO8emPxiW+Dgi7Q7akklwSnBhEYI2kTw8uFMLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901926; c=relaxed/simple;
	bh=U4O5NapLL/mqYVIhwwfuDJJrCpIEgzECX18rzduQv/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gh1UnF/mgaXOHhCbXM3yXrTZ/4zfvrGFKsTil8vuw7ws1K4yWonvbx8QD2E4eQGP+vtX7YNXrWkJXnlnrxikzI2tkMUcqnp2/YvvDVhzCzrQlQ2qW+OxBYLf2juGgdwdu0BYFrpwfCXpwA104icGefMbp1vQoVBIhch3B9Va8Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=byer4bvb; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-61b4387ae4fso42900607b3.2
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 12:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713901923; x=1714506723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AmHyjU9v8KuiULYTpLU8UwMRK7TavrSL5Ffs4PPVM/g=;
        b=byer4bvbyJ0I6XOo3E+TI2obs06Ufr5YkUeT+uGFs3q6E+Pv/bYg54O6rqd8kFGYr9
         t/ioWDz0oQ1SeYlMAksjidXQS9MVrxJQJjoG5fvdYsjONmck8VPTTX83TSQThaWeM7oV
         1LtCkKBTRghCFYhKy0OVogv15WKeyBOuUoL9tZLqQxvzp1me78Zz3ppKElOsGe/IxhVb
         AhyiegKFkmFwF7PYchBVPW6K1cB17KnfvazG0GfoNfa8L+Pu4au5t0zkWmrqF0M4KTTM
         K5L0/OB7n9PPhjC2KrPTZi5v78jA7uXZ1/DKPJzKhkqLoF980qPSQUJPesdoOutbQ5EI
         9UuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713901923; x=1714506723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AmHyjU9v8KuiULYTpLU8UwMRK7TavrSL5Ffs4PPVM/g=;
        b=epY0yMtb60R5aPprLk0Fe61+60jzTnej1z7a2IB8ZLd5dWs4Bb2Tz9rXJ/Q96DsnA2
         5mXSuh9DiYDY6Qka+2GA5bYqhmMqaR+1qQwaHouCApx57JlMIfUxJJ/YX7my9MjvSjRx
         nOuXcYv5EU8F8n/kPfnfb8kGAMc9j8KCs9cX0NpyvQd43HugusEI5VFkc3491y+VCVv0
         Q55tVjpwiM8QXa/RRKO5aofqaL2Ds6Ty0jzKchVcKJkrXwxJD0d4r7ii5ucilUX/iFgo
         NZTXKZHlQeYzBzGYyKObb4ASXI55croVrRflg8xmYhGm1Fz5fejaxP5NVo0Tykob5nvl
         5OxA==
X-Forwarded-Encrypted: i=1; AJvYcCWmnNOZyEA3Ct07J1SodzvCxrlkZkljTBTs+e04E/VHOb3Y5p2FoUL0jOgXS76CWvJ+5tl/f3RuxILioXIVblDx2IHJndC4
X-Gm-Message-State: AOJu0YwvaNqDOhx9E73/ZvF9VPFaj/o3g2iDy5VawBwwQ7E3e9JbBmGl
	rt32hjbclZRK8l1yTcLVVQJuqmxxOf6oo90ppAVTtWURDP/JtcRsZOBA1yQcP40=
X-Google-Smtp-Source: AGHT+IHCwk0ZKgpLUcGpY5mIW6vA1aX6OFVRkHVVIL/BxCKr2HNWv1bc4mFv2doYk1K9PfjqAnVV3g==
X-Received: by 2002:a25:f904:0:b0:de4:645a:9131 with SMTP id q4-20020a25f904000000b00de4645a9131mr638456ybe.34.1713901923463;
        Tue, 23 Apr 2024 12:52:03 -0700 (PDT)
Received: from [10.73.215.90] ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id o17-20020a258d91000000b00de55b84ab49sm281902ybl.43.2024.04.23.12.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 12:52:03 -0700 (PDT)
Message-ID: <56624947-a319-4781-a9f7-1cf09ee71d8c@bytedance.com>
Date: Tue, 23 Apr 2024 12:51:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH net-next v2 2/3] sock: add MSG_ZEROCOPY
 notification mechanism based on msg_control
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 cong.wang@bytedance.com, xiaochun.lu@bytedance.com
References: <20240419214819.671536-1-zijianzhang@bytedance.com>
 <20240419214819.671536-3-zijianzhang@bytedance.com>
 <6625349824651_1dff99294db@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <6625349824651_1dff99294db@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/24 8:45 AM, Willem de Bruijn wrote:
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
>> pattern, the user will keep calling sendmsg with SO_ZC_NOTIFICATION
>> msg_control, and the notification will be delivered as soon as possible.
>>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
>> ---
>>   arch/alpha/include/uapi/asm/socket.h  |  2 +
>>   arch/mips/include/uapi/asm/socket.h   |  2 +
>>   arch/parisc/include/uapi/asm/socket.h |  2 +
>>   arch/sparc/include/uapi/asm/socket.h  |  2 +
>>   include/uapi/asm-generic/socket.h     |  2 +
>>   include/uapi/linux/socket.h           | 16 ++++++
>>   net/core/sock.c                       | 70 +++++++++++++++++++++++++++
>>   7 files changed, 96 insertions(+)
>>
>> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
>> index e94f621903fe..b24622a9cd47 100644
>> --- a/arch/alpha/include/uapi/asm/socket.h
>> +++ b/arch/alpha/include/uapi/asm/socket.h
>> @@ -140,6 +140,8 @@
>>   #define SO_PASSPIDFD		76
>>   #define SO_PEERPIDFD		77
>>   
>> +#define SO_ZC_NOTIFICATION 78
>> +
> 
> SCM_ for cmsgs
> 

Ack.

>>   /*
>>    * Desired design of maximum size and alignment (see RFC2553)
>>    */
>> @@ -35,4 +37,18 @@ struct __kernel_sockaddr_storage {
>>   #define SOCK_TXREHASH_DISABLED	0
>>   #define SOCK_TXREHASH_ENABLED	1
>>   
>> +#define SOCK_ZC_INFO_MAX 256
>> +
>> +struct zc_info_elem {
>> +	__u32 lo;
>> +	__u32 hi;
>> +	__u8 zerocopy;
>> +};
>> +
>> +struct zc_info_usr {
>> +	__u64 usr_addr;
>> +	unsigned int length;
>> +	struct zc_info_elem info[];
>> +};
>> +
> 
> Don't pass a pointer to user memory, just have msg_control point to an
> array of zc_info_elem.
> 

Ack.

>>   #endif /* _UAPI_LINUX_SOCKET_H */
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index fe9195186c13..13f06480f2d8 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -2809,6 +2809,13 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>>   		     struct sockcm_cookie *sockc)
>>   {
>>   	u32 tsflags;
>> +	int ret, zc_info_size, i = 0;
>> +	unsigned long flags;
>> +	struct sk_buff_head *q, local_q;
>> +	struct sk_buff *skb, *tmp;
>> +	struct sock_exterr_skb *serr;
>> +	struct zc_info_usr *zc_info_usr_p, *zc_info_kern_p;
>> +	void __user	*usr_addr;
> 
> Please wrap the case in parentheses and define variables in that scope
> (Since there are so many variables for this case only.)
> 
>>   
>>   	switch (cmsg->cmsg_type) {
>>   	case SO_MARK:
>> @@ -2842,6 +2849,69 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>>   	case SCM_RIGHTS:
>>   	case SCM_CREDENTIALS:
>>   		break;
>> +	case SO_ZC_NOTIFICATION:
>> +		if (!sock_flag(sk, SOCK_ZEROCOPY) || sk->sk_family == PF_RDS)
>> +			return -EINVAL;
>> +
> 
> Why allow PF_RDS without the sock flag set?
> 

PF_RDS uses POLLIN instead of POLLERR, thus this mechanism cannot work
for PF_RDS. I am rejecting any PF_RDS socket here.

>> +		zc_info_usr_p = (struct zc_info_usr *)CMSG_DATA(cmsg);
>> +		if (zc_info_usr_p->length <= 0 || zc_info_usr_p->length > SOCK_ZC_INFO_MAX)
>> +			return -EINVAL;
>> +
>> +		zc_info_size = struct_size(zc_info_usr_p, info, zc_info_usr_p->length);
>> +		if (cmsg->cmsg_len != CMSG_LEN(zc_info_size))
>> +			return -EINVAL;
> 
> By passing a straightforward array, the array len can be inferred from
> cmsg_len, simplifying all these checks.
> 
> See for instance how SO_DEVMEM_DONTNEED returns an array of tokens to
> the kernel.
> 

Ack.

>> +
>> +		usr_addr = (void *)(uintptr_t)(zc_info_usr_p->usr_addr);
>> +		if (!access_ok(usr_addr, zc_info_size))
>> +			return -EFAULT;
>> +
>> +		zc_info_kern_p = kmalloc(zc_info_size, GFP_KERNEL);
>> +		if (!zc_info_kern_p)
>> +			return -ENOMEM;
>> +
>> +		q = &sk->sk_error_queue;
>> +		skb_queue_head_init(&local_q);
>> +		spin_lock_irqsave(&q->lock, flags);
>> +		skb = skb_peek(q);
>> +		while (skb && i < zc_info_usr_p->length) {
>> +			struct sk_buff *skb_next = skb_peek_next(skb, q);
>> +
>> +			serr = SKB_EXT_ERR(skb);
>> +			if (serr->ee.ee_errno == 0 &&
>> +			    serr->ee.ee_origin == SO_EE_ORIGIN_ZEROCOPY) {
>> +				zc_info_kern_p->info[i].hi = serr->ee.ee_data;
>> +				zc_info_kern_p->info[i].lo = serr->ee.ee_info;
>> +				zc_info_kern_p->info[i].zerocopy = !(serr->ee.ee_code
>> +								& SO_EE_CODE_ZEROCOPY_COPIED);
>> +				__skb_unlink(skb, q);
>> +				__skb_queue_tail(&local_q, skb);
>> +				i++;
>> +			}
>> +			skb = skb_next;
>> +		}
>> +		spin_unlock_irqrestore(&q->lock, flags);
> 
> In almost all sane cases, all outstanding notifications can be passed
> to userspace.
> 
> It may be interesting to experiment with briefly taking the lock to
> move to a private list. See for instance net_rx_action.
> 

Nice catch.

> Then if userspace cannot handle all notifications, the rest have to be
> spliced back. This can reorder notifications. But rare reordering is
> not a correctness issue.
> 
> I would choose the more complex splice approach only if it shows
> benefit, i.e., if taking the lock does contend with error enqueue
> events.
> 

Maybe when the network is very busy, it will contend with
__msg_zerocopy_callback(where new notifications are added)?
I think splice is a better idea.

>> +
>> +		zc_info_kern_p->usr_addr = zc_info_usr_p->usr_addr;
>> +		zc_info_kern_p->length = i;
>> +
>> +		ret = copy_to_user(usr_addr,
>> +				   zc_info_kern_p,
>> +					struct_size(zc_info_kern_p, info, i));
> 
> You'll still need to support the gnarly MSG_CMSG_COMPAT version too.
> 

Assume users pass in zc_info_elem array pointer here, I may use
in_compat_syscall function to check if it's compat. If so, I can
use compat_ptr to convert it. Is it correct?

> Wait, is this the reason to pass a usr_addr explicitly? To get around
> any compat issues?
> 

Yes, I try to make it u64 regardless of 32-bit or 64-bit program, but
it is indeed ugly though.

> Or even the entire issue of having to copy msg_sys->msg_control to
> user if !msg_control_is_user.
> 
> I suppose this simplifies a lot in terms of development. If making the
> user interface uglier.
> 
> IMHO the sane interface should be used eventually. There may also be
> other uses of passing msg_control data up to userspace from sendmsg.
> 
> But this approach works for now for evaluation and discussion.
> 
> 

