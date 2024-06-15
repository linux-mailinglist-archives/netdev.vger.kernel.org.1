Return-Path: <netdev+bounces-103813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D279099AC
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 21:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18EE1C20CAE
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 19:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEFF16426;
	Sat, 15 Jun 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Sl7aazj4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E4E4437
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718478378; cv=none; b=fF26wuQmDl/1MeTt0UJJPiUJTDmumsIMHx7d1uceLyola6RO/C1eZT0V/nvkSKlpNUkp1WW/DvGP00Qv5q26wcxZNUSlXnc2Xd16WfaXeQmN3uXdnnc2nTLeVkgftZjK8cAFz7c0M8lXRSHwD/A6DZwaIY3EMzJBHteP22/x8oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718478378; c=relaxed/simple;
	bh=tms3h8UvrU32/eQ3qNNErOfyO6QmXw8ypsHNWO+y85A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=finI1KGi9BdyTXSUevgjqp2CBo8r0Z7Yoz2m9elxisbhOzVygKKHUERoAURxFrWahu/p6LAHpFZ724+9XiB7CuzjloksdchgoCYa26iAWUZ5W1531qt66uJaZ79WwZqG9zBxx6FeoSWLzYqQKfor3dhqzhDdlvWGm6mOzGRliQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Sl7aazj4; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b0682d1b12so19081996d6.0
        for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 12:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718478375; x=1719083175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T2EbaCquphXhknmioyw/mEA8DskTd/2oSxEvAOOfC1w=;
        b=Sl7aazj4y6QixpQjq6JYz+Sn9mQCPvDUTDlcjZUDmdtYyudM15eCKTz/R5WiHAbqXZ
         6cVFJZ0WXWug5J4Of+HwoYdoFYo6cFC2zx+l32dodhmZRYxlGaslnXljaTBvQKoLEPWF
         OzZ75jkP3oWKSjsJP7dCt/CG7F3S02XuWzY1x72rr9/EPv/78hLfzhWeOKVZ7tk/uBAe
         CSJvdP8V+9E5eUeoSG0ZJSOpQBuGkvL2FJDAH0iALvy/U3otB+4JGstVBOwK99uLPnfL
         Y/H0ks7Kg27I8KBZBYnhN0RWNzpegmpc0/UDU+D5trx09UHCc4/XGsh61pGtSr9p6D3f
         RgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718478375; x=1719083175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2EbaCquphXhknmioyw/mEA8DskTd/2oSxEvAOOfC1w=;
        b=XjUzyiLK9tl4ccfhgnsjxkBoJe00ErNyezZLBp3db+aqxyruC+22TbXd7612sfvNhk
         pVfyi0rkwKdUdtnGAsLTO7mqv5K4jKCwWP3lscXx4+Kw37fw4kp6x6KbxCyXabJcbbVA
         A9tAasvCNdc8Q1+yJWS4U0Q/6aC3AAGNDfsbForaapS2zTlt1+jubvXQGUixeqytzSo2
         fguAerHGNBcga9f2KlwZijtvAb7C7YYvT/Huz6YlX/RxaL6KjQZia9mLLDbX6qiPhRla
         UYzuooBr3Hb9ukZedTVJdn1oATMVkZxMN+nPtZdD+L8hMGbu2cxKVSAYXzvfjq/n7vBA
         Bi3w==
X-Forwarded-Encrypted: i=1; AJvYcCVcXU9eIXnBdBe0rmXGNlVe9CprY5zC4Kvf07xhZ/rM7WBVMLKuT1fFCDIPctfA3ngdvvaWyes5jeG3RPe1Afr5EERLdjRz
X-Gm-Message-State: AOJu0Yz6nA0HJQaiy01C2SyLtI0I7EKTk/kbalGqkow1Z97E6dK7dICp
	dzVqbJJ05grC5nCtV7lDFBrTI+wynLBqyXfUgUQW635sAbtqCQ/FbQmDBJ9wmeQ=
X-Google-Smtp-Source: AGHT+IHvplmy8hwc/iykV2Y5tFk6+CemU0TE1ECzATr+OhUKSTEwlVKiJ5tac7J6C28YlJy/e7irKw==
X-Received: by 2002:a0c:de14:0:b0:6a0:cf48:5196 with SMTP id 6a1803df08f44-6b2c9b08df4mr11596506d6.54.1718478374252;
        Sat, 15 Jun 2024 12:06:14 -0700 (PDT)
Received: from [10.5.113.170] (ec2-54-92-141-197.compute-1.amazonaws.com. [54.92.141.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb4827sm34867286d6.93.2024.06.15.12.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jun 2024 12:06:13 -0700 (PDT)
Message-ID: <2fcd2f6c-2c8b-4057-aaa2-e7cfcac3442b@bytedance.com>
Date: Sat, 15 Jun 2024 12:06:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH net-next v5 2/4] sock: support put_cmsg to
 userspace in TX path
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, cong.wang@bytedance.com, xiaochun.lu@bytedance.com
References: <20240613233133.2463193-1-zijianzhang@bytedance.com>
 <20240613233133.2463193-3-zijianzhang@bytedance.com>
 <666d7e1a7b72d_1ba35a294a5@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <666d7e1a7b72d_1ba35a294a5@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/24 4:42 AM, Willem de Bruijn wrote:
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
>> This commit supports put_cmsg to userspace in TX path by storing user
>> msg_control address in a new field in struct msghdr, and adding a new bit
>> flag use_msg_control_user_tx to toggle the behavior of put_cmsg. Thus,
>> it's possible to piggyback information in the msg_control of sendmsg.
>>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
>> ---
>>   include/linux/socket.h |  4 ++++
>>   net/compat.c           | 33 +++++++++++++++++++++++++--------
>>   net/core/scm.c         | 42 ++++++++++++++++++++++++++++++++----------
>>   net/socket.c           |  2 ++
>>   4 files changed, 63 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/linux/socket.h b/include/linux/socket.h
>> index 89d16b90370b..8d3db04f4a39 100644
>> --- a/include/linux/socket.h
>> +++ b/include/linux/socket.h
>> @@ -71,9 +71,12 @@ struct msghdr {
>>   		void __user	*msg_control_user;
>>   	};
>>   	bool		msg_control_is_user : 1;
>> +	bool		use_msg_control_user_tx : 1;
>>   	bool		msg_get_inq : 1;/* return INQ after receive */
>>   	unsigned int	msg_flags;	/* flags on received message */
>> +	void __user	*msg_control_user_tx;	/* msg_control_user in TX piggyback path */
>>   	__kernel_size_t	msg_controllen;	/* ancillary data buffer length */
>> +	__kernel_size_t msg_controllen_user_tx; /* msg_controllen in TX piggyback path */
>>   	struct kiocb	*msg_iocb;	/* ptr to iocb for async requests */
>>   	struct ubuf_info *msg_ubuf;
>>   	int (*sg_from_iter)(struct sock *sk, struct sk_buff *skb,
>> @@ -391,6 +394,7 @@ struct ucred {
>>   
>>   extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr);
>>   extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
> 
>> diff --git a/net/core/scm.c b/net/core/scm.c
>> index 4f6a14babe5a..de70ff1981a1 100644
>> --- a/net/core/scm.c
>> +++ b/net/core/scm.c
>> @@ -228,25 +228,29 @@ int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
>>   }
>>   EXPORT_SYMBOL(__scm_send);
>>   
>> -int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
>> +static int __put_cmsg(struct msghdr *msg, int level, int type, int len, void *data)
>>   {
>>   	int cmlen = CMSG_LEN(len);
>> +	__kernel_size_t msg_controllen;
>>   
>> +	msg_controllen = msg->use_msg_control_user_tx ?
>> +		msg->msg_controllen_user_tx : msg->msg_controllen;
>>   	if (msg->msg_flags & MSG_CMSG_COMPAT)
>>   		return put_cmsg_compat(msg, level, type, len, data);
>>   
>> -	if (!msg->msg_control || msg->msg_controllen < sizeof(struct cmsghdr)) {
>> +	if (!msg->msg_control || msg_controllen < sizeof(struct cmsghdr)) {
>>   		msg->msg_flags |= MSG_CTRUNC;
>>   		return 0; /* XXX: return error? check spec. */
>>   	}
>> -	if (msg->msg_controllen < cmlen) {
>> +	if (msg_controllen < cmlen) {
>>   		msg->msg_flags |= MSG_CTRUNC;
>> -		cmlen = msg->msg_controllen;
>> +		cmlen = msg_controllen;
>>   	}
>>   
>> -	if (msg->msg_control_is_user) {
>> -		struct cmsghdr __user *cm = msg->msg_control_user;
>> +	if (msg->use_msg_control_user_tx || msg->msg_control_is_user) {
>> +		struct cmsghdr __user *cm;
>>   
>> +		cm = msg->msg_control_is_user ? msg->msg_control_user : msg->msg_control_user_tx;
>>   		check_object_size(data, cmlen - sizeof(*cm), true);
>>   
>>   		if (!user_write_access_begin(cm, cmlen))
>> @@ -267,12 +271,17 @@ int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
>>   		memcpy(CMSG_DATA(cm), data, cmlen - sizeof(*cm));
>>   	}
>>   
>> -	cmlen = min(CMSG_SPACE(len), msg->msg_controllen);
>> -	if (msg->msg_control_is_user)
>> +	cmlen = min(CMSG_SPACE(len), msg_controllen);
>> +	if (msg->msg_control_is_user) {
>>   		msg->msg_control_user += cmlen;
>> -	else
>> +		msg->msg_controllen -= cmlen;
>> +	} else if (msg->use_msg_control_user_tx) {
>> +		msg->msg_control_user_tx += cmlen;
>> +		msg->msg_controllen_user_tx -= cmlen;
>> +	} else {
>>   		msg->msg_control += cmlen;
>> -	msg->msg_controllen -= cmlen;
>> +		msg->msg_controllen -= cmlen;
>> +	}
>>   	return 0;
>>   
>>   efault_end:
>> @@ -280,8 +289,21 @@ int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
>>   efault:
>>   	return -EFAULT;
>>   }
>> +
>> +int put_cmsg(struct msghdr *msg, int level, int type, int len, void *data)
>> +{
>> +	msg->use_msg_control_user_tx = false;
>> +	return __put_cmsg(msg, level, type, len, data);
>> +}
>>   EXPORT_SYMBOL(put_cmsg);
>>   
>> +int put_cmsg_user_tx(struct msghdr *msg, int level, int type, int len, void *data)
>> +{
>> +	msg->use_msg_control_user_tx = true;
>> +	return __put_cmsg(msg, level, type, len, data);
>> +}
>> +EXPORT_SYMBOL(put_cmsg_user_tx);
>> +
>>   void put_cmsg_scm_timestamping64(struct msghdr *msg, struct scm_timestamping_internal *tss_internal)
>>   {
>>   	struct scm_timestamping64 tss;
>> diff --git a/net/socket.c b/net/socket.c
>> index e416920e9399..2755bc7bef9c 100644
>> --- a/net/socket.c
>> +++ b/net/socket.c
>> @@ -2561,6 +2561,8 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
>>   		err = -EFAULT;
>>   		if (copy_from_user(ctl_buf, msg_sys->msg_control_user, ctl_len))
>>   			goto out_freectl;
>> +		msg_sys->msg_control_user_tx = msg_sys->msg_control_user;
>> +		msg_sys->msg_controllen_user_tx = msg_sys->msg_controllen;
> 
> No need for this separate user_tx pointer and put_cmsg_user_tx.
> 
> ___sys_sendmsg copies the user data to a stack allocated kernel
> buffer. All subsequent operations are on this buffer. __put_cmsg
> already supports writing to this kernel buffer.
> 
> All that is needed is to copy_to_user the buffer on return from
> __sock_sendmsg. And only if it should be copied, which the bit in
> msghdr can signal.
>
copy_to_user upon returning from __sock_sendmsg is clean, but we may
need to take compat into account.

put_cmsg has already handled compat cleanly, I am trying to reuse it.

Since msg_control_user is overwritten in ____sys_sendmsg to a kernel
stack buffer, I piggyback user_tx pointer for further use by 
put_cmsg_user_tx.

Or, upon returning of ____sys_sendmsg, we can set msg_control_user back
to user addr. And, for_each_cmsghdr, if cmsg_type == SCM_ZC_... we can
do put_cmsg?

>>   		msg_sys->msg_control = ctl_buf;
>>   		msg_sys->msg_control_is_user = false;
>>   	}
>> -- 
>> 2.20.1
>>
> 
> 

