Return-Path: <netdev+bounces-99946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EE08D7296
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 00:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382C5281B53
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 22:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F792BD1E;
	Sat,  1 Jun 2024 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="k1vUEWwt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3128FB657
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 22:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717282351; cv=none; b=s/LLpBz8JfdeWIY1fmzDW7Un8Z3AJf5zo2BFxhMBAH+R1vcXDHwSV9WEHWsoyyjBeQP1y0MykU5vHVTXTYrjxzvmCAj+xR8hg9mhkxkF1fmkGSbsTF32eB1tkOxhwViqJWadn5jEz+0p8VbdnTwke2mLaVmCN1ENetWsTNl9dLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717282351; c=relaxed/simple;
	bh=lM80sPvGu6BzrSvH/gwoj9vQ6j17uYChPMGp65wAF0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jH4dGaAPNzuxTtUc4vOK/I4N2IhoI4Pq2I8SdjnIBpKyjWBow5owc5xJWYvw1/I/Qy650LsH+P/8Chtmyjkwzj2iOdBxAax82pqV299Z29JxhhBXNFY9CMetmlK0EvGIkmwvBvr7KdJApjDmJoyBgk8CJZSnWoAdOBFfE9mbGnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=k1vUEWwt; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f8f024a75cso1909488a34.0
        for <netdev@vger.kernel.org>; Sat, 01 Jun 2024 15:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1717282348; x=1717887148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MGzsfhOCAKZmH+A0f29/QhfN45KZrsUJp3x+kt5HOME=;
        b=k1vUEWwtu68VpvrVyUwTY1dhyhfEbx4QCam2Tict7Uz9QVYXxTLNIHxuEMBlQ7lWzT
         jGpP9/WAvsy+OuAHNDPFmvysqLPKTDnPYq2JO9fjzo9Ps7WdlT9mRtVhHWU5DsSpor64
         WvNwtS4V689cjRdqTK/DA00JGQMgEgDVOZapfEDEbL6M1ktEqudO0SCMER1leMNc1uKY
         zAq099F1z+4loidmVDwXGNCQNS/zq2BEZ4RVuYJCfMQADKdJyWsSgxTsI0yI13apzFxc
         L4zKgG+3UFqWUMErFn4Ms51Vgb+JnZWTZRhCF18M6/N0awBGPdT0MiiAoVDBvKYU2C49
         cCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717282348; x=1717887148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGzsfhOCAKZmH+A0f29/QhfN45KZrsUJp3x+kt5HOME=;
        b=tDAqiu7CaxykDLK+ZzIJ0lmqt0ZvoExNcMeZv5ZmtqV2wsEItCxo+RgwZSqA/CnFAl
         4cZuVyOmjKOvIGCgBum1PuG1TJxMyNZXAwDIO5/Hr03keKGqn853aJkUyMfHHWD1hhQn
         FxLPNgazh2oth9riNX+rHV0Aiy8PYLBB5hAJ79Uts16eHL//5EHzF55CN8TEQr363XFP
         Fwph4odVEGvXcbmU5DYW+RB9DJH7gdz4u0TjrnI692GwII23ayNM2Cjt+Y7WzhraZRR1
         q5KyOAzunHoGokxfNLcGplNZv88ykW/3SvI+fQTt+pWJFWM3rYQMSXaNfEU6VBs7YKOt
         AA1Q==
X-Gm-Message-State: AOJu0YxloArbg0Iu9SWnjzPx6MJbPLz7Jd+Xoty0LrZ87XoDBXzTC3jh
	MBURVi5epyO09YjucfXKEDXxj+Wkv1+kTWhfiEEGqVPfxehBMScdUFOyBxjQ6DE=
X-Google-Smtp-Source: AGHT+IHUU9GKwhJkhVMQ4pMrJfpE7ezmrMXvRoKIWyudlOZWn61D1+zi6M0EBhPZrRoeKsTsfWyx9A==
X-Received: by 2002:a05:6830:1183:b0:6f9:1c03:d40d with SMTP id 46e09a7af769-6f91c03d6b1mr2830512a34.2.1717282347932;
        Sat, 01 Jun 2024 15:52:27 -0700 (PDT)
Received: from [10.5.113.34] (ec2-54-92-141-197.compute-1.amazonaws.com. [54.92.141.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f3017cafsm161685985a.65.2024.06.01.15.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jun 2024 15:52:27 -0700 (PDT)
Message-ID: <1b693647-bccf-48b3-8010-abdb91a32594@bytedance.com>
Date: Sat, 1 Jun 2024 15:52:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH net-next v4 2/3] sock: add MSG_ZEROCOPY
 notification mechanism based on msg_control
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com,
 willemdebruijn.kernel@gmail.com, cong.wang@bytedance.com,
 xiaochun.lu@bytedance.com
References: <20240528212103.350767-1-zijianzhang@bytedance.com>
 <20240528212103.350767-3-zijianzhang@bytedance.com>
 <20240601103701.GD491852@kernel.org>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <20240601103701.GD491852@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/1/24 3:37 AM, Simon Horman wrote:
> On Tue, May 28, 2024 at 09:21:02PM +0000, zijianzhang@bytedance.com wrote:
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
> ...
> 
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 521e6373d4f7..21239469d75c 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -2847,6 +2847,74 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
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
> Hi Zijian Zhang, Xiaochun Lu, all,
> 
> When compiling on ARM (32bit) with multi_v7_defconfig using clang-18
> I see the following warning:
> 
> .../sock.c:2808:5: warning: stack frame size (1664) exceeds limit (1024) in '__sock_cmsg_send' [-Wframe-larger-than]
>   2808 | int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
> 
> I expect this is mostly explained by the addition of zc_info_kern above.
> 

Nice catch, thanks for the info!

>> +
>> +		if (!sock_flag(sk, SOCK_ZEROCOPY) || sk->sk_family == PF_RDS)
>> +			return -EINVAL;
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
>>

