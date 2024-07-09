Return-Path: <netdev+bounces-110398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D9E92C2B1
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E3BBB23FC3
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A878715B116;
	Tue,  9 Jul 2024 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YB4lYrI1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B58A1B86CC
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546947; cv=none; b=hHV5JBgIo+XwgKug1uClYwJUhjRxu6ut5etZdWOgB5oJRuQrbrqmCJQybrGajAVsLUT2pF/f/diviuZR+6y8yDgurLhoE6UsRGbrXMXm6ZSXl4GdQ/ZL938o4sAWaxX07oyIuG6Po2irmfD/YIIIlCwcl+sZMoVovD715Z3k2/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546947; c=relaxed/simple;
	bh=pyKteziCMqIVbaiHo7sandVwQu1XogWlnOkQIzwPoAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKJYEhHvQDEi5qYjTRldPteQ46GE7HuF4QPIPLDYSvNgg6b9alrKuM6erqgoSbnUsNz3TFrzrzLSO7rtly2uHPy6rvl0izE0DvHCQJVAubKlYco6YXznuO8F9Rxk4A9lo2mqYCPLkbK4b3K+SQG4RUtaWGB6Oz7LFCGkE8tI+rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YB4lYrI1; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b97a9a9b4bso2560468eaf.0
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 10:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1720546943; x=1721151743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HsJXldzerWwSLjSbW4Qag2omt77oD66NWBi1rUBpBJ4=;
        b=YB4lYrI1Hxu2PCYCFIyQkcZ+VxzOFMaKCsykGwRwyKSpb7YHu68MJN3JMF0IcZeH0p
         vU6N+avPFOyRFElgU138668bt1JlZFsIjfubeQZDQTr0N1tqeHO/mC4DSw11Gzxaf8Bo
         mXHzvzVR+OqOSffYO1XJcA8t5hcl9WlS56otPDVvHlh5r6Lwf1ls0O4emRajvRnIAndh
         R7RbbP5M2VE7KKpZy7IMsYD6MXU6jFe31o8WwkDCLfdhCqFGRhG+CQfTjLZ09PijHq6u
         pv3ELajPE4bc9SwilWTem0HLoD6gfUlND+ix5jnWFcNBzBYylH3YF4cuRwTTcOqtVbIB
         Mi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720546943; x=1721151743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsJXldzerWwSLjSbW4Qag2omt77oD66NWBi1rUBpBJ4=;
        b=u/NzDGeTwuswkOLY7AHlFDcajNyB0FPD9OFC3MPIxAO8abBxSHz121wdr72yDBU8hu
         BAoN+d+qJb7IJKvR7rSZsJrjrqFGa4J5HmH6irM2Ppc/AZgSymw6EIq1YTtICkzieQrS
         oi9OsTTuWsrcTF1HFJsuBktGMwL60cR7hph3mJlp8CVi2N4z691XjccVDcd3HFGIk+Na
         n4xGEMmFP0vFNNibB/kglt+23BpR3qeGFepu+aVdgv638Y6HO/ZmdKp4Hc7h9gj+LNmR
         UkNTv2Dx/7mHVzE8XSnskbH9IiBoOhanju1AFkY1IsZnJzp6nP8Mgk6kV8fCiXMiSaAz
         q6JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWFxdxjlZsCxFKr9k4UgIXbIQQAZe4n+wgxj8ZoxUvX/JNemaxnTbAKnjfD/K2+cXl8EcbpW/j1IRwh2IJIANSxUvxmBAe
X-Gm-Message-State: AOJu0Yyc85mKrus6QEvJQn/xBGlQbJ5uFQIqpgBbZXXW3LKNb9+3kQlj
	OPm9RnLF9A4BZBLslV7Svjq5kvSTaacpOOf7Fx+7aPtozt7JF4pXqES7q852D+M=
X-Google-Smtp-Source: AGHT+IGImK3vXSrPvuca1VJnO9k29Cn7nH0EpArmtbzSrQX+/eY9cxwqrBsyrZwYl4C1bBwaw1tKBQ==
X-Received: by 2002:a05:6820:270f:b0:5c6:943d:7c1d with SMTP id 006d021491bc7-5c6943d7dbfmr2819661eaf.0.1720546943246;
        Tue, 09 Jul 2024 10:42:23 -0700 (PDT)
Received: from [10.73.215.90] ([72.29.204.230])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c68cd72a81sm390502eaf.9.2024.07.09.10.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 10:42:22 -0700 (PDT)
Message-ID: <7c4354fc-148f-4b34-9dac-2202b59bc6ca@bytedance.com>
Date: Tue, 9 Jul 2024 10:42:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/3] sock: support copying cmsgs to the user
 space in sendmsg
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, cong.wang@bytedance.com, xiaochun.lu@bytedance.com
References: <20240708210405.870930-1-zijianzhang@bytedance.com>
 <20240708210405.870930-2-zijianzhang@bytedance.com>
 <668d680cc7cfc_1c18c329414@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <668d680cc7cfc_1c18c329414@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 9:40 AM, Willem de Bruijn wrote:
> zijianzhang@ wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> Users can pass msg_control as a placeholder to recvmsg, and get some info
>> from the kernel upon returning of it, but it's not available for sendmsg.
>> Recvmsg uses put_cmsg to copy info back to the user, while ____sys_sendmsg
>> creates a kernel copy of msg_control and passes that to the callees,
>> put_cmsg in sendmsg path will write into this kernel buffer.
>>
>> If users want to get info after returning of sendmsg, they typically have
>> to call recvmsg on the ERRMSG_QUEUE of the socket, incurring extra system
> 
> nit: error queue or MSG_ERRQUEUE
> 
>> call overhead. This commit supports copying cmsg from the kernel space to
>> the user space upon returning of sendmsg to mitigate this overhead.
>>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> 
> Overall this approach follows what I had in mind, thanks.
> 
> Looking forward to the discussion with a wider audience at netdevconf
> next week.
> 

No problem, see you next week ;)

>> ---
>>   include/linux/socket.h |  6 +++++
>>   include/net/sock.h     |  2 +-
>>   net/core/sock.c        |  6 +++--
>>   net/ipv4/ip_sockglue.c |  2 +-
>>   net/ipv6/datagram.c    |  2 +-
>>   net/socket.c           | 54 ++++++++++++++++++++++++++++++++++++++----
>>   6 files changed, 62 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/socket.h b/include/linux/socket.h
>> index 2a1ff91d1914..75461812a7a3 100644
>> --- a/include/linux/socket.h
>> +++ b/include/linux/socket.h
>> @@ -71,6 +71,7 @@ struct msghdr {
>>   		void __user	*msg_control_user;
>>   	};
>>   	bool		msg_control_is_user : 1;
>> +	bool		msg_control_copy_to_user : 1;
>>   	bool		msg_get_inq : 1;/* return INQ after receive */
>>   	unsigned int	msg_flags;	/* flags on received message */
>>   	__kernel_size_t	msg_controllen;	/* ancillary data buffer length */
>> @@ -168,6 +169,11 @@ static inline struct cmsghdr * cmsg_nxthdr (struct msghdr *__msg, struct cmsghdr
>>   	return __cmsg_nxthdr(__msg->msg_control, __msg->msg_controllen, __cmsg);
>>   }
>>   
>> +static inline bool cmsg_copy_to_user(struct cmsghdr *__cmsg)
>> +{
>> +	return 0;
>> +}
>> +
>>   static inline size_t msg_data_left(struct msghdr *msg)
>>   {
>>   	return iov_iter_count(&msg->msg_iter);
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index cce23ac4d514..9c728287d21d 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -1804,7 +1804,7 @@ static inline void sockcm_init(struct sockcm_cookie *sockc,
>>   	};
>>   }
>>   
>> -int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>> +int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
>>   		     struct sockcm_cookie *sockc);
>>   int sock_cmsg_send(struct sock *sk, struct msghdr *msg,
>>   		   struct sockcm_cookie *sockc);
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 9abc4fe25953..efb30668dac3 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -2826,7 +2826,7 @@ struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_len,
>>   }
>>   EXPORT_SYMBOL(sock_alloc_send_pskb);
>>   
>> -int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>> +int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
>>   		     struct sockcm_cookie *sockc)
>>   {
>>   	u32 tsflags;
>> @@ -2866,6 +2866,8 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>>   	default:
>>   		return -EINVAL;
>>   	}
>> +	if (cmsg_copy_to_user(cmsg))
>> +		msg->msg_control_copy_to_user = true;
> 
> This seems a bit roundabout.
> 
> Just have case SCM_ZC_NOTIFICATION set this bit directly?

If I directly set this bit in SCM_ZC_... and delete this if code block,
I may have to add "msg" argument to __sock_cmsg_send in the second
commit, because if I still keep it in this commit, there will be an
"unused argument" warning.

However, I think the change to __sock_cmsg_send function declaration is
generic, so I would like to make it in the first commit, but it is truly
a bit roundabout. Not sure which way is better?

>>   	return 0;
>>   }
> 
>> -static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
>> -			   unsigned int flags, struct used_address *used_address,
>> +static int sendmsg_copy_cmsg_to_user(struct msghdr *msg_sys,
>> +				     struct user_msghdr __user *umsg)
>> +{
>> +	struct compat_msghdr __user *umsg_compat =
>> +				(struct compat_msghdr __user *)umsg;
>> +	unsigned int flags = msg_sys->msg_flags;
>> +	struct msghdr msg_user = *msg_sys;
>> +	unsigned long cmsg_ptr;
>> +	struct cmsghdr *cmsg;
>> +	int err;
>> +
>> +	msg_user.msg_control_is_user = true;
>> +	msg_user.msg_control_user = umsg->msg_control;
>> +	cmsg_ptr = (unsigned long)msg_user.msg_control;
>> +	for_each_cmsghdr(cmsg, msg_sys) {
>> +		if (!CMSG_OK(msg_sys, cmsg))
>> +			break;
>> +		if (cmsg_copy_to_user(cmsg))
>> +			put_cmsg(&msg_user, cmsg->cmsg_level, cmsg->cmsg_type,
>> +				 cmsg->cmsg_len - sizeof(*cmsg), CMSG_DATA(cmsg));
>> +	}
>> +
>> +	err = __put_user((msg_sys->msg_flags & ~MSG_CMSG_COMPAT), COMPAT_FLAGS(umsg));
>> +	if (err)
>> +		return err;
>> +	if (MSG_CMSG_COMPAT & flags)
>> +		err = __put_user((unsigned long)msg_user.msg_control - cmsg_ptr,
>> +				 &umsg_compat->msg_controllen);
>> +	else
>> +		err = __put_user((unsigned long)msg_user.msg_control - cmsg_ptr,
>> +				 &umsg->msg_controllen);
>> +	return err;
>> +}
>> +
>> +static int ____sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
>> +			   struct msghdr *msg_sys, unsigned int flags,
>> +			   struct used_address *used_address,
>>   			   unsigned int allowed_msghdr_flags)
>>   {
>>   	unsigned char ctl[sizeof(struct cmsghdr) + 20]
>> @@ -2537,6 +2572,7 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
>>   	ssize_t err;
>>   
>>   	err = -ENOBUFS;
>> +	msg_sys->msg_control_copy_to_user = false;
>>   
>>   	if (msg_sys->msg_controllen > INT_MAX)
>>   		goto out;
>> @@ -2594,6 +2630,14 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
>>   			       used_address->name_len);
>>   	}
>>   
>> +	if (msg && msg_sys->msg_control_copy_to_user && err >= 0) {
>> +		ssize_t len = err;
>> +
>> +		err = sendmsg_copy_cmsg_to_user(msg_sys, msg);
>> +		if (!err)
>> +			err = len;
>> +	}
>> +
> 
> The main issue is adding the above initialization and this branch in
> the hot path, adding a minor cost to every other send call only for
> this use case (and potentially tx timestamps eventually).
> 
>>   out_freectl:
>>   	if (ctl_buf != ctl)
>>   		sock_kfree_s(sock->sk, ctl_buf, ctl_len);
>> @@ -2636,8 +2680,8 @@ static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
>>   	if (err < 0)
>>   		return err;
>>   
>> -	err = ____sys_sendmsg(sock, msg_sys, flags, used_address,
>> -				allowed_msghdr_flags);
>> +	err = ____sys_sendmsg(sock, msg, msg_sys, flags, used_address,
>> +			      allowed_msghdr_flags);
> 
> Does it make more sense to do the copy_to_user here, so as not to have to plumb
> msg down to the callee?

I did this in the previous patchset. The problem is that the msg_control
of msg_sys is either a stack pointer or kmalloc-ed pointer (in
____sys_sendmsg), after returning of it, the msg_control of msg_sys is
either invalid or freed. I may have to do the copy_to_user at the end of
____sys_sendmsg.

>>   	kfree(iov);
>>   	return err;
>>   }
>> @@ -2648,7 +2692,7 @@ static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
>>   long __sys_sendmsg_sock(struct socket *sock, struct msghdr *msg,
>>   			unsigned int flags)
>>   {
>> -	return ____sys_sendmsg(sock, msg, flags, NULL, 0);
>> +	return ____sys_sendmsg(sock, NULL, msg, flags, NULL, 0);
>>   }
>>   
>>   long __sys_sendmsg(int fd, struct user_msghdr __user *msg, unsigned int flags,
>> -- 
>> 2.20.1
>>
> 
> 

