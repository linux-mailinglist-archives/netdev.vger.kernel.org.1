Return-Path: <netdev+bounces-128266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF864978CC0
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 04:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3728AB21A05
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 02:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B3D10A1F;
	Sat, 14 Sep 2024 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RBn+rxbc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9523A8BEA
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726280411; cv=none; b=WqIWwJ6WYmcnlUJ3f5lJT9DLpq+o0J2UZJgjrpyODYwBNMXSTMHgmeEx2wDDaG6GV2K84umt7DuIUf9qHvG5FrIZ6QnYfYMNCml7Vh2n9gTRqlV2bbbt6VRFlgGJnVZ6i49S6H/usr3Z6vMN3+rbeUyjLs7oBTfJ9SlSnk5Pu1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726280411; c=relaxed/simple;
	bh=fc+/x08DX+TINgND4pncmDpmAczjvfpl6p1dHKJDvLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=guMcMZSBBwTPY9ivulNUPs/8tTC1/zfGILKABkhuCPUX1Ya7tQzuIXs0qPE8pv1pgO/ABsW6Kt59rsrefZx/p9si1ZzONVbNlBJgIymz7lqpV4pdTPnaeeuEBDDHT6dig26YVqaEYCGrhhjuJgwFF+q49YVqYPH1tH/iEMM5SCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RBn+rxbc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d88c5d76eeso1151823a91.2
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 19:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726280408; x=1726885208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdYaNef3ra/euvWEjoCAlfTHZkHcANKdjyGif+4pw+g=;
        b=RBn+rxbcQm3cclXFlw3Dp2l/pgjdLh/k0E4HdUWCOVEEJPPdc30ORIBuH8+u8TEo+K
         AE5Qg0HFQkr6tcRJuP0NkHY0NPi+Ex3BDeLZ7vjeq19+U5apOFbCYkcu8O9GMw/hZK6g
         QPOuS5MUT2OuTi3kyMPj5TqyoIw6Fy83tMdY86mQtNiZCw1l2IE8ZsSPd3u0kmkIaY07
         gq2lOF3bjCKA8N9rv5wf0SQPuNLyh5u2akix684905AgU5vmjhe/5DiqFnhhoqcDtDUv
         reJMB7eo2sv6TeS9dM7ZaRJ2B5SujZsPs1BNBO6vPyL4FuHxnMpXpScpaAtlPclvlvfj
         OE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726280408; x=1726885208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gdYaNef3ra/euvWEjoCAlfTHZkHcANKdjyGif+4pw+g=;
        b=V5GIK3gbFXHutN3yiOw+KlJCTYyOPldLwnl+t6gufwFm1iC2CLYnHfvanwPeFD9YVn
         Ezefelp1xcRWQQp3ozulgsZqk2S9xPMta2MCw4WrJrXTrbBYv+ZgxYgAhIJOwfxI1FZH
         z5Ub1L5LTEiKIwyUNv8gofEgpW1tPHOHpJjJbUQwg2WylAmPqaGMpTBZRsZI8SiKF/5w
         FkN4IIQja6pgDQhlNCiPRhHnMZXjnbV0slywyul3eYDlNsMbexWbtbLb8o7IE3ri3CZP
         Nn67W3zlziG72njmGZx7jGJcEpGQNaYVvNaqjrAPFv0P7tO1HbNFGG3+Fv0/38egM+Bj
         v3ig==
X-Forwarded-Encrypted: i=1; AJvYcCVsK3fvUzQloxbH0Oqm/9ZfnmKQAEkUjGYuyW/kUBBhZzRvNKx2aIFgdjC5SVOH2WouxUWkBkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9sN5ZfDFOR1fyPad+pELiwRz9JuxSB46kXu1p+sw+1Nig5UCU
	UccyURQGNT7YqIIcli34Aes1rzwk93ePRA0OSfgWnxQ9E7B6C4jFCZh7/I45Iow=
X-Google-Smtp-Source: AGHT+IGSHn5hwoBOOe5i2CyLLwasHpV1saKnMdh1oXYk0s+32A8dIUllJsMF2SY1eLtAa8/6ayiInw==
X-Received: by 2002:a17:90b:4b8e:b0:2d8:8ead:f013 with SMTP id 98e67ed59e1d1-2dbb9dc124fmr6861494a91.7.1726280407520;
        Fri, 13 Sep 2024 19:20:07 -0700 (PDT)
Received: from [10.68.123.78] ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd8d9ebsm370118a91.36.2024.09.13.19.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 19:20:07 -0700 (PDT)
Message-ID: <324669ea-e684-4a84-ab70-33f8c857db0a@bytedance.com>
Date: Sat, 14 Sep 2024 10:19:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH bpf-next v2] bpf: Fix bpf_get/setsockopt to tos not
 take effect when TCP over IPv4 via INET6 API
To: Eric Dumazet <edumazet@google.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, dsahern@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
 YiFei Zhu <zhuyifei@google.com>
References: <20240823085313.75419-1-zhoufeng.zf@bytedance.com>
 <CANn89i+ZsktuirATK0nhUmJu+TiqB9Kbozh+HhmCiP3qdnW3Ew@mail.gmail.com>
 <173d3b06-57ed-4e2e-9034-91b99f41512b@linux.dev>
 <CANn89iLKcOBBHXMSduV-DXYZfDCKAZyySggKFnQMpKH3p_Ureg@mail.gmail.com>
 <6c75215b-0bdc-4b5a-b267-6dce0faec496@bytedance.com>
 <CANn89i+9GmBLCdgsfH=WWe-tyFYpiO27wONyxaxiU6aOBC6G8g@mail.gmail.com>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <CANn89i+9GmBLCdgsfH=WWe-tyFYpiO27wONyxaxiU6aOBC6G8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/9/13 22:44, Eric Dumazet 写道:
> On Tue, Aug 27, 2024 at 10:08 AM Feng Zhou <zhoufeng.zf@bytedance.com> wrote:
>>
>> 在 2024/8/24 02:53, Eric Dumazet 写道:
>>> On Fri, Aug 23, 2024 at 8:49 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> On 8/23/24 6:35 AM, Eric Dumazet wrote:
>>>>> On Fri, Aug 23, 2024 at 10:53 AM Feng zhou <zhoufeng.zf@bytedance.com> wrote:
>>>>>>
>>>>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>>>>
>>>>>> when TCP over IPv4 via INET6 API, bpf_get/setsockopt with ipv4 will
>>>>>> fail, because sk->sk_family is AF_INET6. With ipv6 will success, not
>>>>>> take effect, because inet_csk(sk)->icsk_af_ops is ipv6_mapped and
>>>>>> use ip_queue_xmit, inet_sk(sk)->tos.
>>>>>>
>>>>>> So bpf_get/setsockopt needs add the judgment of this case. Just check
>>>>>> "inet_csk(sk)->icsk_af_ops == &ipv6_mapped".
>>>>>>
>>>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202408152034.lw9Ilsj6-lkp@intel.com/
>>>>>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>>>> ---
>>>>>> Changelog:
>>>>>> v1->v2: Addressed comments from kernel test robot
>>>>>> - Fix compilation error
>>>>>> Details in here:
>>>>>> https://lore.kernel.org/bpf/202408152058.YXAnhLgZ-lkp@intel.com/T/
>>>>>>
>>>>>>     include/net/tcp.h   | 2 ++
>>>>>>     net/core/filter.c   | 6 +++++-
>>>>>>     net/ipv6/tcp_ipv6.c | 6 ++++++
>>>>>>     3 files changed, 13 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>>>>>> index 2aac11e7e1cc..ea673f88c900 100644
>>>>>> --- a/include/net/tcp.h
>>>>>> +++ b/include/net/tcp.h
>>>>>> @@ -493,6 +493,8 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
>>>>>>                                                struct tcp_options_received *tcp_opt,
>>>>>>                                                int mss, u32 tsoff);
>>>>>>
>>>>>> +bool is_tcp_sock_ipv6_mapped(struct sock *sk);
>>>>>> +
>>>>>>     #if IS_ENABLED(CONFIG_BPF)
>>>>>>     struct bpf_tcp_req_attrs {
>>>>>>            u32 rcv_tsval;
>>>>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>>>>> index ecf2ddf633bf..02a825e35c4d 100644
>>>>>> --- a/net/core/filter.c
>>>>>> +++ b/net/core/filter.c
>>>>>> @@ -5399,7 +5399,11 @@ static int sol_ip_sockopt(struct sock *sk, int optname,
>>>>>>                              char *optval, int *optlen,
>>>>>>                              bool getopt)
>>>>>>     {
>>>>>> -       if (sk->sk_family != AF_INET)
>>>>>> +       if (sk->sk_family != AF_INET
>>>>>> +#if IS_BUILTIN(CONFIG_IPV6)
>>>>>> +           && !is_tcp_sock_ipv6_mapped(sk)
>>>>>> +#endif
>>>>>> +           )
>>>>>>                    return -EINVAL;
>>>>>
>>>>> This does not look right to me.
>>>>>
>>>>> I would remove the test completely.
>>>>>
>>>>> SOL_IP socket options are available on AF_INET6 sockets just fine.
>>>>
>>>> Good point on the SOL_IP options.
>>>>
>>>> The sk could be neither AF_INET nor AF_INET6. e.g. the bpf_get/setsockopt
>>>> calling from the bpf_lsm's socket_post_create). so the AF_INET test is still needed.
>>>>
>>>
>>> OK, then I suggest using sk_is_inet() helper.
>>>
>>>> Adding "&& sk->sk_family != AF_INET6" should do. From ipv6_setsockopt, I think
>>>> it also needs to consider the "sk->sk_type != SOCK_RAW".
>>>>
>>>> Please add a test in the next re-spin.
>>>>
>>>> pw-bot: cr
>>
>> Thanks for your suggestion, I will add it in the next version.
> 
> Gentle ping.
> 
> Have you sent the new version ?

Sorry, there have been a lot of delays in work recently. V3 will be sent 
in two days. Thanks.


