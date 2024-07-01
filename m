Return-Path: <netdev+bounces-108260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 951CA91E8CE
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140861F22EF2
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC84516F8E1;
	Mon,  1 Jul 2024 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lYoRB7ew"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A825516F0C5
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863171; cv=none; b=rqJjhoDylt/xlmzYOlcjUToCztygdjsEDF9oHyoxVmfzEk3qwaPcjrjW8jg/IfG+jz+/kkt4ABFFPdjf2tYL+00ezXiW3QNOWdtyLZ6ds8xUfvJrZy+VatbY4Qz7S9W7+TEIW4Jq8G79iGxcWlomqajBP2KzL3O+v1NO2GeSj5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863171; c=relaxed/simple;
	bh=FvTUuMY8llw+LO1XzCV4P+l5x/4m1liHgeQmhF8j7/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5lJcEx/0/s8FqYVKnz/CitBifThiwGM5WBWeBlhv9DKv+oCWCK+i20tRcwpxEAKbt7/w6fRc65KbTkIRCk8i9VGstE1MpdfEoC0gVPM/rUJ89BdOzTZraXBSEW4r3wOjyUNcSr7cXfZpNG/tfGuPxfduPIZafAfP9pMWktr9Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lYoRB7ew; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-700d1721dd9so2292658a34.0
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 12:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719863169; x=1720467969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=anjWCAcrJmZrjkxgdFdNoXTKCka13dX8dEn7s0vgVp4=;
        b=lYoRB7ewG+WMxSGSlm2DP6L9dMK1+iH0I9EE35dLWP5IETfZu52LUW5q3U2L3O89eJ
         +2OhV+QrLIStAQg4GWYHDpcNonH6CyJt2KTzaVMMeUtTFGKDs4heBaAHNplBECtOw0Xr
         yQNRIh2L+4i2s8aZdTACAVS8VmoYDLxo+Y7iEmaDp6EUaEGijXPisVa+X9d+RXZ7C+MF
         oD/TN0yzwkrhG68jz89jaaBmfO+FhublVIrSYctBrT5EjkbjuJG1DjvrVmZdrruOD9F7
         kbRw0Ym+O1fh5kDHmB4kqTXOKxyKb/72lpmVp8hPIXzDA9/naYDteGrRyuEfNI8kOI6N
         M5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863169; x=1720467969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anjWCAcrJmZrjkxgdFdNoXTKCka13dX8dEn7s0vgVp4=;
        b=fQAYNotzsZyI3BD0NOANlVf3mvGiovydu3dksSknoWGuN3EWzixDLttVxR5+hg6nHW
         qIhFCqLavCBE/7lmwQlZv7BTke2bC6/t+Qs8www/kGhkM4r/RYImM4oQJQOG4omoWLQ1
         jpYr/zn6n2zQg/luWK1lkv3accYj4QvzeGwNgzL0P5qLyqhrCuyEQy3JbNu+bSGIXIX0
         +dKH2GNTWgraFI025iwzbovFbHuHjL7oOSRSr4Gg+j5nVX2YvJmyVzBpgRo59EjE+iJm
         3Z3errv3zM2kwpDAx81snixqDb1dfDsS5KGw9vCgVj6ahrqOLSodFpGfjAvPibzl9lFN
         e5Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUV1CHZMhMYjN+bcc2OyPvnkHYAj4ocj7bB9RiRA7yabEw4xzLTQlasAoXubq3eqKnsTH3KjaMvksamuK6A0A+94JGerhZC
X-Gm-Message-State: AOJu0YwIlKIM5sYVAq/sTbHvdVHu4q+Hn75rdVTkNi1yMczoAhz4+Oz9
	ERewO6lqrvOy3+GJj5uuwImUMnlOJMgd8CmgPYarMQB6g7Nj0tIIoy67GWND8rQNiG4qSh7t9cc
	z
X-Google-Smtp-Source: AGHT+IGyElMMzhdu6V7wXpfKbqi4sVPTLeT1wR33kpWLA+u9Vqh6JEO/o8sannIv6Uz0AMmTX6OYQQ==
X-Received: by 2002:a9d:6956:0:b0:700:d3ec:3633 with SMTP id 46e09a7af769-70207650f3emr8599893a34.8.1719863168646;
        Mon, 01 Jul 2024 12:46:08 -0700 (PDT)
Received: from [10.73.215.90] ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7ad6ca5sm1407963a34.47.2024.07.01.12.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 12:46:08 -0700 (PDT)
Message-ID: <1596dbc6-65cb-4d3f-8e56-33842e3dcd2b@bytedance.com>
Date: Mon, 1 Jul 2024 12:46:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH net-next v6 2/4] sock: support copy cmsg to
 userspace in TX path
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, cong.wang@bytedance.com, xiaochun.lu@bytedance.com
References: <20240626193403.3854451-1-zijianzhang@bytedance.com>
 <20240626193403.3854451-3-zijianzhang@bytedance.com>
 <66816f021ccc4_e25729443@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <66816f021ccc4_e25729443@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/30/24 7:43 AM, Willem de Bruijn wrote:
> zijianzhang@ wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> Since ____sys_sendmsg creates a kernel copy of msg_control and passes
>> that to the callees, put_cmsg will write into this kernel buffer. If
>> people want to piggyback some information like timestamps upon returning
>> of sendmsg. ____sys_sendmsg will have to copy_to_user to the original buf,
>> which is not supported. As a result, users typically have to call recvmsg
>> on the ERRMSG_QUEUE of the socket, incurring extra system call overhead.
>>
>> This commit supports copying cmsg to userspace in TX path by introducing
>> a flag MSG_CMSG_COPY_TO_USER in struct msghdr to guide the copy logic
>> upon returning of ___sys_sendmsg.
>>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
>> ---
>>   include/linux/socket.h |  6 ++++++
>>   net/core/sock.c        |  2 ++
>>   net/ipv4/ip_sockglue.c |  2 ++
>>   net/ipv6/datagram.c    |  3 +++
>>   net/socket.c           | 45 ++++++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 58 insertions(+)
>>
>> diff --git a/include/linux/socket.h b/include/linux/socket.h
>> index 89d16b90370b..35adc30c9db6 100644
>> --- a/include/linux/socket.h
>> +++ b/include/linux/socket.h
>> @@ -168,6 +168,11 @@ static inline struct cmsghdr * cmsg_nxthdr (struct msghdr *__msg, struct cmsghdr
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
>> @@ -329,6 +334,7 @@ struct ucred {
>>   
>>   #define MSG_ZEROCOPY	0x4000000	/* Use user data in kernel path */
>>   #define MSG_SPLICE_PAGES 0x8000000	/* Splice the pages from the iterator in sendmsg() */
>> +#define MSG_CMSG_COPY_TO_USER	0x10000000	/* Copy cmsg to user space */
> 
> Careful that userspace must not be able to set this bit. See also
> MSG_INTERNAL_SENDMSG_FLAGS.
> 
> Perhaps better to define a bit like msg_control_is_user.
> 
>>   #define MSG_FASTOPEN	0x20000000	/* Send data in TCP SYN */
>>   #define MSG_CMSG_CLOEXEC 0x40000000	/* Set close_on_exec for file
>>   					   descriptor received through
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 9abc4fe25953..4a766a91ff5c 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -2879,6 +2879,8 @@ int sock_cmsg_send(struct sock *sk, struct msghdr *msg,
>>   	for_each_cmsghdr(cmsg, msg) {
>>   		if (!CMSG_OK(msg, cmsg))
>>   			return -EINVAL;
>> +		if (cmsg_copy_to_user(cmsg))
>> +			msg->msg_flags |= MSG_CMSG_COPY_TO_USER;
> 
> Probably better to pass msg to __sock_cmsg_send and only set this
> field in the specific cmsg handler that uses it.
> 

Thanks for the above suggestions!

>>   		if (cmsg->cmsg_level != SOL_SOCKET)
>>   			continue;
>>   		ret = __sock_cmsg_send(sk, cmsg, sockc);
...
>> +static int sendmsg_copy_cmsg_to_user(struct msghdr *msg_sys,
>> +				     struct user_msghdr __user *umsg)
>> +{
>> +	struct compat_msghdr __user *umsg_compat =
>> +				(struct compat_msghdr __user *)umsg;
>> +	unsigned long cmsg_ptr = (unsigned long)umsg->msg_control;
>> +	unsigned int flags = msg_sys->msg_flags;
>> +	struct msghdr msg_user = *msg_sys;
>> +	struct cmsghdr *cmsg;
>> +	int err;
>> +
>> +	msg_user.msg_control = umsg->msg_control;
>> +	msg_user.msg_control_is_user = true;
>> +	for_each_cmsghdr(cmsg, msg_sys) {
>> +		if (!CMSG_OK(msg_sys, cmsg))
>> +			break;
>> +		if (cmsg_copy_to_user(cmsg))
>> +			put_cmsg(&msg_user, cmsg->cmsg_level, cmsg->cmsg_type,
>> +				 cmsg->cmsg_len - sizeof(*cmsg), CMSG_DATA(cmsg));
>> +	}
> 
> Alternatively just copy the entire msg_control if any cmsg wants to
> be copied back. The others will be unmodified. No need to iterate
> then.
> 

Copy the entire msg_control via copy_to_user does not take
MSG_CMSG_COMPAT into account. I may have to use put_cmsg to deal
with the compat version, and thus have to keep the for loop?

If so, I may keep the function cmsg_copy_to_user to avoid extra copy?

>> +
>> +	err = __put_user((msg_sys->msg_flags & ~MSG_CMSG_COMPAT), COMPAT_FLAGS(umsg));
>> +	if (err)
>> +		return err;
> 
> Does this value need to be written?
> 

I did this according to ____sys_recvmsg, maybe it's useful to export
flag like MSG_CTRUNC to users?

>> +	if (MSG_CMSG_COMPAT & flags)
>> +		err = __put_user((unsigned long)msg_user.msg_control - cmsg_ptr,
>> +				 &umsg_compat->msg_controllen);
>> +	else
>> +		err = __put_user((unsigned long)msg_user.msg_control - cmsg_ptr,
>> +				 &umsg->msg_controllen);
>> +	return err;
>> +}
>> +
>>   static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
>>   			 struct msghdr *msg_sys, unsigned int flags,
>>   			 struct used_address *used_address,
>> @@ -2638,6 +2671,18 @@ static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
>>   
>>   	err = ____sys_sendmsg(sock, msg_sys, flags, used_address,
>>   				allowed_msghdr_flags);
>> +	if (err < 0)
>> +		goto out;
>> +
>> +	if (msg_sys->msg_flags & MSG_CMSG_COPY_TO_USER) {
>> +		ssize_t len = err;
>> +
>> +		err = sendmsg_copy_cmsg_to_user(msg_sys, msg);
>> +		if (err)
>> +			goto out;
>> +		err = len;
>> +	}
>> +out:
>>   	kfree(iov);
>>   	return err;
>>   }
>> -- 
>> 2.20.1
>>
> 
> 

