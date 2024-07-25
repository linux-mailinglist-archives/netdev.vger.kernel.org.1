Return-Path: <netdev+bounces-113129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 089D993CB74
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 01:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D45282286
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 23:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C83144D2B;
	Thu, 25 Jul 2024 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ic0jEjDn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B020F3BBC2
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721951465; cv=none; b=BvJ+o30ZMXmxYh9zzkR17rJ32291HKyMPoNWRg18XGen4+uHGBp4y74/hHRe7rEMov7xbmsOTTedUVlbmkZVsbUWNADfT1zftp2ZkkxAbMdxsY8igekRsgn19fyYX7+UGjZ08nYh/QR+wCSxKqLcnK/fCWFTO/GQ1xeMCwcKpDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721951465; c=relaxed/simple;
	bh=4CcvF5nmPbW2yNiRPV1UVQNxrbZAbcQLkBHO0DbYL74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgPf7bhwSTV0nfaih7lkrLwT/jjm2KBHar1Qtd+AA/KofA6Ud0iLyGdkgMGwcpNbaVdJ7mwuz6gWxm0d9MU6nXrxdsrI7PkueWws2c6hn1gMregAm04FOioI/PKSQcKcagm7gDQFTQ8Ca/fYkHhKvdusI76JKi2/I74uKR7tDYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ic0jEjDn; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-447e2d719afso996701cf.0
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 16:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721951461; x=1722556261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GW9MQoAP3KGQ4FcY5J3m51dWQknKynLjvRqoWimhSFE=;
        b=ic0jEjDnyJVDHeDy9X+cM4Gi6KESYtuRE60hSNKkhDz1GivsOvrK4+IErJiblA0Aom
         r6eVLY0PWR+NpXGESDutm8bQ+tLq4FHGP997xT0i7Ynk0InRK9XClXlQ8qH2HRh/Q/oN
         mSRLxfTAol78Dfw4Ryh3ZBfODHzOHN3YyjKtiVlHoPyrC57qp8iA1BuDXoi5BtMXmXx7
         X5Vb27UnrLFG+M12MKhdReC5EhSasVBbHEUc4owbWf+XT4NWZgcOP7FtiAx77GddeQbx
         lR2rvSkoX9KP9Huny/AWv1HAPT9m9Ct78IbuEdxqbC0HZ/+m9vMvlrg3U8Co1rDSIjtQ
         3clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721951461; x=1722556261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GW9MQoAP3KGQ4FcY5J3m51dWQknKynLjvRqoWimhSFE=;
        b=kP6gHXlVOxAC42P+FwfJTBvab6W1sAISqpNEAw6m1F2gCPyL7u+ym0/4z0krvidJjY
         n2g6Wta8khlNGC3u3RRJDVPYKZRUWfy38Wao6EOHy2CHAFV/9qNi9IeRwNmnIf6d/0ZM
         raogT2vNoeVIl+2dlOH/Bq98xS76kFoBtsE5kM7iBg7I7r65eu+fwd6ufLBCfz7tDdAf
         68jl9SpE52d4guo646CMblhWIalrujfJ/lMxN/hHZwbOUP08J8ZhUHNovHat8TFpJxET
         zcsuA0JpqrKxCUoK9tlRQHbwh/qKDB0ni6DdfqyvpLD3CtOb8yGKcqQfO2rhWMxX8RCQ
         l2Bg==
X-Gm-Message-State: AOJu0YwYEt86MXC48OdotLtvxwWPXAVDevaSMfgOMYNcEFfzs7dnpwnK
	53nSUSu7uvN6SWArCL5kHB736c89lXBwmlSe6xoOk7Rv+IdEe3ZuQNzhKGtzVMI=
X-Google-Smtp-Source: AGHT+IG1kUpIQDn+p3CRjyrF4nUKFmcwaeX2wuRvAwVANnoHaXjYlggzqCnP9gg3ZDHugYg7rLwirg==
X-Received: by 2002:a05:622a:1206:b0:447:e591:2d27 with SMTP id d75a77b69052e-44fd7ad5fb6mr118688471cf.6.1721951461401;
        Thu, 25 Jul 2024 16:51:01 -0700 (PDT)
Received: from [10.5.119.35] (ec2-54-92-141-197.compute-1.amazonaws.com. [54.92.141.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe81259cesm9949101cf.6.2024.07.25.16.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 16:51:01 -0700 (PDT)
Message-ID: <6b977a8c-d984-4d1a-b33d-15e2e875602c@bytedance.com>
Date: Thu, 25 Jul 2024 16:50:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/3] sock: support copying cmsgs to the user
 space in sendmsg
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, edumazet@google.com,
 willemdebruijn.kernel@gmail.com, cong.wang@bytedance.com,
 xiaochun.lu@bytedance.com
References: <20240708210405.870930-1-zijianzhang@bytedance.com>
 <20240708210405.870930-2-zijianzhang@bytedance.com>
 <ZqLE-vmo_L1JgUrn@google.com>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <ZqLE-vmo_L1JgUrn@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Firstly, thanks for your attention to this patch set :)

On 7/25/24 2:34 PM, Mina Almasry wrote:
> On Mon, Jul 08, 2024 at 09:04:03PM +0000, zijianzhang@bytedance.com wrote:
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
>> call overhead. This commit supports copying cmsg from the kernel space to
>> the user space upon returning of sendmsg to mitigate this overhead.
>>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
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
> 
> Please add some docs explaining what this does if possible. From reading the
> code, it seems if this is true then we should copy cmsg to user. Not sure where
> or how it's set though.
> 

Agree!

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
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL(__sock_cmsg_send);
>> @@ -2881,7 +2883,7 @@ int sock_cmsg_send(struct sock *sk, struct msghdr *msg,
>>   			return -EINVAL;
>>   		if (cmsg->cmsg_level != SOL_SOCKET)
>>   			continue;
>> -		ret = __sock_cmsg_send(sk, cmsg, sockc);
>> +		ret = __sock_cmsg_send(sk, msg, cmsg, sockc);
>>   		if (ret)
>>   			return ret;
>>   	}
>> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
>> index cf377377b52d..6360b8ba9c84 100644
>> --- a/net/ipv4/ip_sockglue.c
>> +++ b/net/ipv4/ip_sockglue.c
>> @@ -267,7 +267,7 @@ int ip_cmsg_send(struct sock *sk, struct msghdr *msg, struct ipcm_cookie *ipc,
>>   		}
>>   #endif
>>   		if (cmsg->cmsg_level == SOL_SOCKET) {
>> -			err = __sock_cmsg_send(sk, cmsg, &ipc->sockc);
>> +			err = __sock_cmsg_send(sk, msg, cmsg, &ipc->sockc);
>>   			if (err)
>>   				return err;
>>   			continue;
>> diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
>> index fff78496803d..c9ae30acf895 100644
>> --- a/net/ipv6/datagram.c
>> +++ b/net/ipv6/datagram.c
>> @@ -777,7 +777,7 @@ int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
>>   		}
>>
>>   		if (cmsg->cmsg_level == SOL_SOCKET) {
>> -			err = __sock_cmsg_send(sk, cmsg, &ipc6->sockc);
>> +			err = __sock_cmsg_send(sk, msg, cmsg, &ipc6->sockc);
>>   			if (err)
>>   				return err;
>>   			continue;
>> diff --git a/net/socket.c b/net/socket.c
>> index e416920e9399..6a9c9e24d781 100644
>> --- a/net/socket.c
>> +++ b/net/socket.c
>> @@ -2525,8 +2525,43 @@ static int copy_msghdr_from_user(struct msghdr *kmsg,
>>   	return err < 0 ? err : 0;
>>   }
>>
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
> 
> put_cmsg() can fail as far as I can tell. Any reason we don't have to check for
> failure here?
> 
> What happens when these failures happen. Do we end up putting the ZC
> notification later, or is the zc notification lost forever because we did not
> detect the failure to put_cmsg() it?
> 

That's a good question,

The reason why I don't have check here is that I refered to net/socket.c 
and sock.c. It turns out there is no failure check for put_cmsgs in
these files.

For example, in sock_recv_errqueue, it invokes put_cmsg without check,
and kfree_skb anyway. In this case, if put_cmsg fails, we will lose the
information forever. I find cases where sock_recv_errqueue is used for
TX_TIMESTAMP. Maybe loss for timestamp is okay?

However, I find that sock_recv_errqueue is also used in rds_recvmsg to
receive the zc notifications for rds socket. The zc notification could
also be lost forever in this case?

Not sure if anyone knows the reason why there is no failure check for
put_cmsg in net/socket.c and sock.c?

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
> 
> 
> This may be a lack of knowledge on my part, but i'm very confused that
> msg_control_copy_to_user is set to false here, and then checked below, and it's
> not touched in between. How could it evaluate to true below? Is it because something
> overwrites the value in msg_sys between this set and the check?
> 
> If something is overwriting it, is the initialization to false necessary?
> I don't see other fields of msg_sys initialized this way.
> 

```
msg_sys->msg_control_copy_to_user = false;
...
err = __sock_sendmsg(sock, msg_sys); -> __sock_cmsg_send
...
if (msg && msg_sys->msg_control_copy_to_user && err >= 0)
```

The msg_control_copy_to_user maybe updated by the cmsg handler in
the function __sock_cmsg_send. In patch 2/3, we have
msg_control_copy_to_user updated to true in SCM_ZC_NOTIFICATION
handler.

As for the initialization,

msg_sys is allocated from the kernel stack, if we don't initialize
it to false, it might be randomly true, even though there is no
cmsg wants to be copied back.

Why is there only one initialization here? The existing bit 
msg_control_is_user only get initialized where the following code
path will use it. msg_control_is_user is initialized in multiple
locations in net/socket.c. However, In function hidp_send_frame,
msg_control_is_user is not initialized, because the following path will
not use this bit.

We only initialize msg_control_copy_to_user in function
____sys_sendmsg, because only in this function will we check this bit.

If the initialization here makes people confused, I will add some docs.

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
> 
> I'm a bit surprised there isn't any cleanup here if copying the cmsg to user
> fails. It seems that that __sock_sendmsg() is executed, then if we fail here,
> we just return an error without unrolling what __sock_sendmsg() did. Why is
> this ok?
> 
> Should sendmsg_copy_cmsg_to_user() be done before __sock_sendms() with a goto
> out if it fails?
> 

I did this refering to ____sys_recvmsg, in this function, if __put_user
fails, we do not unroll what sock_recvmsg did, and return the error code
of __put_user.

Before __sock_sendmsg, the content of msg_control is not updated by the
function __sock_cmsg_send, so sendmsg_copy_cmsg_to_user at this time
might be not expected.

>> +	}
>> +
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

