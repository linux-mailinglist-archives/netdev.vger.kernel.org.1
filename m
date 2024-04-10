Return-Path: <netdev+bounces-86677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F398A89FDB2
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 19:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815921F21D8B
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 17:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E65217B503;
	Wed, 10 Apr 2024 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="W43ud/5F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A876F17B51C
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768621; cv=none; b=lU6iPug2Kh8m4Oj2V+vVJlyeWGAFNBtOYvK/yjhEhXoNZS1UEOWbCtPhceOgshdaXeh7HT0s2OyRG0yrJNieIyDmgX3VZQ6/AalInTIoNW8iTX8d2tiaWiUp+YF5T8oepn6sGGbOiQUcLxl/l4A88Zc0hRLxDuIjx6+OCD6x11o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768621; c=relaxed/simple;
	bh=ZOIF1yDpzthx/xQCbH4Bv9DyhoUChhcSTzQvypp9OCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Il4/6KT390G96CRw/iKsAh4R1YnvklkzvzVsZQ60Q5JoyBliZWXuVimWkfrkFMOZO960RMqrF6irPlpWjYIm/fzj8eYup/riwrvhvUlxL4AhITxYqD428JoaX/e8svlYjJHH+u2Iy6NlT7tFNTg+0277qXQox7tY8ALjMJWALhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=W43ud/5F; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69b16b614d7so19493686d6.0
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 10:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712768618; x=1713373418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ze77qZCX0O6mi0mQxwh6F3kINUO9TpooSSiYi1PH24g=;
        b=W43ud/5FoY5hl2490/HW/tuhhPzZXvy9nSZxM++qq5VKRh6USy9bGf6rafRgzPaGj5
         l4LWNKaVgiB5ZxYixVKRwsyYYgLlMdCivZW6Dhu7PbsxC+LNrXWXWcHgOihYIHBE8CJb
         CgOWCimOUd+OUE6PTZpuAMhq4kRA4i8AsKQqlh6WCOGHGKa8VQvdQClplQ+RqDX5Itei
         9r/8dAKvVFkTcPYzBxYuL59LM0E2uiq/ANTEKOc8xzUkQ6oZwv0F9ClW/ZKWoDhWo9qH
         3ZKpI/+IyXhWphp25EQQTkmlQlDORvivMIXBYTVyVTmr882C+jFAu3UjWL+MixIzAI+u
         JqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712768618; x=1713373418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ze77qZCX0O6mi0mQxwh6F3kINUO9TpooSSiYi1PH24g=;
        b=Z6yfQQaG99erO/7h9om1beef70jNOf+sOhRDqunOwxM7KTYFFxGOG0I91t6ASo05TV
         JM5fW1E/0z/YRy9NJCShzBo6bFVIdyEeEfxo6kfzH7kvUnXzzj02hb/Uigi4Ul49VEXv
         2OGeVkb3qCzSTtOHmdutWxe2UYQ5z3ga0BZ7LJAWMGvI5eYCPXU9k79BsNUlskQiTkUw
         uoLfkY429pU+dboKc2TMY0FfhVkdDyVvJnga8J8abmpptvAs8X0WihO6DTgxsGtX8xA8
         UgrgnQd+6GAlkkML7IfZE0cEuH+E/74VYbKrVVUm9xXpOjOsfsRANhK1h1NfMIG5aLHO
         LOGw==
X-Forwarded-Encrypted: i=1; AJvYcCWr2hxwL5GdXarakdXSxutBOPjdO0lgG0jEDqvLgft1T7F2a7pkiRtkuDWfhvyxwSMN/mO09LpolhL7mO9HoSPXM6TcQubX
X-Gm-Message-State: AOJu0YzK0rA1fJOJr0N7pK+W2tJBGKLcMv2ZIZnN5jeXpwCfktSnYGjF
	1N3LobUM8ToSMDso+PIeSSSbfUlvSJkzlmtn6hPDznJJTvM2cY0RkK64XXab4gs=
X-Google-Smtp-Source: AGHT+IHrIeovGj8MBSOCTSdG3nDeusRTI3zOvTYheFHxMhO4HQhxmoBk4HMdSSYYrvak2nlbAEyBaQ==
X-Received: by 2002:a05:6214:27ec:b0:69b:aa6:4234 with SMTP id jt12-20020a05621427ec00b0069b0aa64234mr2793237qvb.45.1712768618516;
        Wed, 10 Apr 2024 10:03:38 -0700 (PDT)
Received: from [10.200.136.51] (ec2-52-9-159-93.us-west-1.compute.amazonaws.com. [52.9.159.93])
        by smtp.gmail.com with ESMTPSA id h4-20020a0ceec4000000b006986db59235sm5246347qvs.68.2024.04.10.10.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 10:03:38 -0700 (PDT)
Message-ID: <500a5cbd-6611-48c1-8f5e-2b1cb1e814cf@bytedance.com>
Date: Wed, 10 Apr 2024 10:03:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH net-next 0/3] net: socket sendmsg
 MSG_ZEROCOPY_UARG
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, kuba@kernel.org, cong.wang@bytedance.com,
 xiaochun.lu@bytedance.com
References: <20240409205300.1346681-1-zijianzhang@bytedance.com>
 <ae625989c2b1a21b9f2550ff1d835210d2cf2ca9.camel@redhat.com>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <ae625989c2b1a21b9f2550ff1d835210d2cf2ca9.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/24 1:46 AM, Paolo Abeni wrote:
> On Tue, 2024-04-09 at 20:52 +0000, zijianzhang@bytedance.com wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> Original notification mechanism needs poll + recvmmsg which is not
>> easy for applcations to accommodate. And, it also incurs unignorable
>> overhead including extra system calls and usage of optmem.
>>
>> While making maximum reuse of the existing MSG_ZEROCOPY related code,
>> this patch set introduces zerocopy socket send flag MSG_ZEROCOPY_UARG.
>> It provides a new notification method. Users of sendmsg pass a control
>> message as a placeholder for the incoming notifications. Upon returning,
>> kernel embeds notifications directly into user arguments passed in. By
>> doing so, we can significantly reduce the complexity and overhead for
>> managing notifications. In an ideal pattern, the user will keep calling
>> sendmsg with MSG_ZEROCOPY_UARG flag, and the notification will be
>> delivered as soon as possible.
>>
>> MSG_ZEROCOPY_UARG does not need to queue skb into errqueue. Thus,
>> skbuffs allocated from optmem are not a must. In theory, a new struct
>> carrying the zcopy information should be defined along with its memory
>> management code. However, existing zcopy generic code assumes the
>> information is skbuff. Given the very limited performance gain or maybe
>> no gain of this method, and the need to change a lot of existing code,
>> we still use skbuffs allocated from optmem to carry zcopy information.
>>
>> * Performance
>>
>> I extend the selftests/msg_zerocopy.c to accommodate the new flag, test
>> result is as follows, the new flag performs 7% better in TCP and 4%
>> better in UDP.
>>
>> cfg_notification_limit = 8
>> +---------------------+---------+---------+---------+---------+
>>> Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
>> +---------------------+---------+---------+---------+---------+
>>> Copy                | 5328    | 5159    | 8581    | 8457    |
>> +---------------------+---------+---------+---------+---------+
>>> ZCopy               | 5877    | 5568    | 10314   | 10091   |
>> +---------------------+---------+---------+---------+---------+
>>> New ZCopy           | 6254    | 5901    | 10674   | 10293   |
>> +---------------------+---------+---------+---------+---------+
>>> ZCopy / Copy        | 110.30% | 107.93% | 120.20% | 119.32% |
>> +---------------------+---------+---------+---------+---------+
>>> New ZCopy / Copy    | 117.38% | 114.38% | 124.39% | 121.71% |
>> +---------------------+---------+---------+---------+---------+
> 
> Minor nit for a future revision: the relevant part here is the 'New
> ZCopy/ ZCopy' direct comparison, which is missing - even if inferable
> from the above.  You should provide such data, and you could drop the
> 'ZCopy / Copy' 'New ZCopy / Copy' and possibly even 'Copy' lines.
> 
> Thanks,
> 
> Paolo
> 

Thanks for the advice, I will update in the next version :)

