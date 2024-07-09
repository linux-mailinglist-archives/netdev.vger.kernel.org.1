Return-Path: <netdev+bounces-110379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1357E92C230
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3751A1C208CC
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A658C1B86F8;
	Tue,  9 Jul 2024 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="G73oaRI+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716D93612D
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720545436; cv=none; b=QUYfGtZv5qMRjAW3I+AudWmNJznbqskttqWkW8IZodJBJuPGWDtyjV68KJx+MgJWzzgaSzksiZsfdMFa2I2Q9/P7gJbQICUJFU9QnoGvk/qsckVbY1Z23co3x7vhfPxatpN9UuxVY9X+nOypH43eqxBWMaBY+sUi5cvHgLiXPBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720545436; c=relaxed/simple;
	bh=/GplYZFAYnyGor/9c7EhpQZ1Yn/979UufoGz/nhv6tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNu+O5Tt34Ozw5HIEGhZMnaa7q0oFlf7tRKWSJSq9z7nWlnEjCdlPBAiiZJHCFEC02jd9xyyfruq2kFFYtaaCHsWQTJA3yEVGbHeXXP8da946NtgwGu4PA6a6Mo1RnTy4QSDAxjKGWbnscn5Kj3j9Fk6/3yZF6qyIEIWuqQ898c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=G73oaRI+; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b97a9a9b4bso2548447eaf.0
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 10:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1720545433; x=1721150233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4aVaDLS/uXD/VIEA1QZ42uEk2VtuU1LuO6slrv6KM4Q=;
        b=G73oaRI+DNEr8luE2EmfhCR+/B7fp12YqBA22PwKhMfEFTiGflfbm1HvmsrxAt4+zI
         UMQLTjWrLx/42Wbn5Z8wFBXf82yj/QMKkLxMdwik2O+0ZiL7k3ZXQIqQe/N+jxiKr76S
         qAkvHlwynT89OeQAI122yHBkxoewmHh1hwxfSaxO6bQqxozbzuygr6zTPKYrHhFWeJqO
         jKovivAIbfqhw19/hiwcDINeXljwH610uIoLSzGR15NrfSlUjaUgjdEWf5KAmxBUMQk4
         3lV3zfjgequNJkCLarMv5d8yisRF9bkCv52E+hEnpWRJ9k80vUmnx7/qtM4b3OPY5wd9
         pT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720545433; x=1721150233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4aVaDLS/uXD/VIEA1QZ42uEk2VtuU1LuO6slrv6KM4Q=;
        b=aLygbisgmH7d7xHbaB6u/feJ4kHzdb0URHBhj7kDmN/kdCsxzvLH9UiBWo9HM7rADE
         3GwQsbogBqEAGyaxvpoeUB4CrR/jQMiRLkcvI9SUfNCE+x4Fv1dkgCLqqj1boSeG0xjX
         fW+BbSZg9FkqJQ0JckSFRsZ4SAcakOskmA9EEeArTfyQkGMU3UpdX+q0In3E3KoKRsnx
         SBCw/c5AgNMkIvgBFg8JfM9+Ou4eRvi9IbHL+bYF7NHqYnhRwOO1ogmNX1gsxnF02TqT
         uTCcWPQc3Nq+5l2JX9BnJSXlkliIEEu67aIirOdEPwQB4Rdge0v4g1aFGUOAGg4YiEV4
         eTxA==
X-Gm-Message-State: AOJu0YwST6wNu8p10K/jGcTzvCWbKzBUPUT4JeQyCenZ5qeLDRtvnryi
	a1KGobtKqVA6ZXJ6l6ekI+8iRJmTrWVR7T9DUfJh0zbhcPbndYFN1v27fzWNIXQ=
X-Google-Smtp-Source: AGHT+IE48j1iCSPHOfhMIkTRwQSKxVaBaDCeR12g6tsOftlvZ4aB50MYHmpa9g2YLneWCRYwXyrXiQ==
X-Received: by 2002:a05:6870:4207:b0:259:83dc:2a5b with SMTP id 586e51a60fabf-25eaec3f155mr2564074fac.54.1720545433340;
        Tue, 09 Jul 2024 10:17:13 -0700 (PDT)
Received: from [10.73.215.90] ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25eaa29d0ddsm723486fac.48.2024.07.09.10.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 10:17:12 -0700 (PDT)
Message-ID: <6fca7568-6eef-479d-afdf-7960a4f6382c@bytedance.com>
Date: Tue, 9 Jul 2024 10:17:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/3] sock: support copying cmsgs to the user
 space in sendmsg
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com,
 willemdebruijn.kernel@gmail.com, cong.wang@bytedance.com,
 xiaochun.lu@bytedance.com, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Jens Axboe <axboe@kernel.dk>
References: <20240708210405.870930-1-zijianzhang@bytedance.com>
 <20240708210405.870930-2-zijianzhang@bytedance.com>
 <20240709091400.GE346094@kernel.org>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <20240709091400.GE346094@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 2:14 AM, Simon Horman wrote:
> + Dave Miller, Jakub Kicinski, Paolo Abeni, David Ahern, and Jens Axboe
> 
>    Please generate the CC list Networking for patches using
>    get_maintainer.pl --git-min-percent=25 this.patch
>    but omitting LKML.
> 
> 
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
> 
> ...
> 
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
> 
> nit: Sparse seems unhappy about the use of a __user pointer here.
> 
>       net/socket.c:2540:37: warning: dereference of noderef expression
> 
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
> 
> nit: The line above could be trivially line-wrapped so that it is
>       no more than 80 columns wide, as is still preferred in Networking code.
> 
>       Flagged by: checkpatch.pl --max-line-length=80
> 
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
> 
> ...

Thanks for the suggestions, will update in the next version.

