Return-Path: <netdev+bounces-245559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9126CD1BD4
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 21:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEE8E3055B89
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 20:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F31622154B;
	Fri, 19 Dec 2025 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xQp28CfR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8674832ED37
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 20:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766175876; cv=none; b=A8EycdbH67DKzacZM4GSOaC4ZtdbuxAJIxs8PosTZClbDDIm+PqRSIpEQKy9XorfIRRLt0/+DR19Kv1GCAx+WmayvvLHp2oT0lM1+u45/UjeeKvgeobcPJEIWOj87UBXHMOQq1zUH/HPCZ4o1jRj0PpiHE4/shSD2RMCUgOmQmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766175876; c=relaxed/simple;
	bh=70JLowXkb+x0SSBGMqukpg3bqzTA6B3U4tAHjpGF+qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lzi8CFNEIWpHOigrxPZr6xfyrWdUIZk/khfvMgcGKf/pttK0dBRympp2LuOZqskw5M6eUuYXPV8ypkbVtD0l1ibBnHzkgEpjgtLGXgDc8TzpXmKBUmPcbU5eeUP5va8eCtxBwyAjI/i0WlabxGRC954g0QQLaVjr3uWLRGY3wag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xQp28CfR; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-450823a7776so1270242b6e.2
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 12:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766175871; x=1766780671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IzK+Z1lgN6T87W9afWPd1XIGCFcSEipUO2fUJk46iVA=;
        b=xQp28CfRlTNa3fjiUVFpgl6J2GAvXK3AK0a4w/aE1+GgOYLDIy3CCtzGI4QCOiqntP
         UpDDQQiKYL5IwvlHz8LtP0413UkdLe4GZqrpUEfoHvzpr+dczmZQ/Lh56Sl4PQxWwRzR
         op9VCJ0aMe9UQjEBRrr8mwCQbOJbl1LDo319EjGtqUusFDCZJP/mAMqxfIh+Pz+keqDM
         c5ZQN3yOlZsjEFVGADsQhZLo/zNDyomk1VEbH3yeVBjDOfmOFba7rnmT6eJLk3/EiDeU
         dyjSQGROc10EY6BdBLFe96cE3Ws9ooIurD9r4iu8Y2jDFsmstrXC9EaUfTVKR42oJ93I
         MKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766175871; x=1766780671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzK+Z1lgN6T87W9afWPd1XIGCFcSEipUO2fUJk46iVA=;
        b=Z4bC+nRhgdPYV1tM9Uif6bcjHwlliN8RxF6fyR8/g8F2j0f5DpeSMTcPfZlCYDFN0y
         SCvK/VCb9zQ4we9h6QnxLtyRx3i4Lika5VFdTMF47i//9ePBpS7g9R/wbBEx6+xGzPsy
         JV9KHj+iqS/zgeM0FBizXK1o/swZj4DCjtacSLzi/m/kdDeXrvfPNnYYSzxD2DPlZJr2
         qi6F8ExxgfFmNUEVmr42493mEzQFSV22vUrPVd8jW5t4ewu2+WuOv3g+a9lCYeD1ATFB
         VcfuZ0T5N26SLuUMq89pR9ZIa/rfWnN2TL+R9RphoyO+YVUO8GL7LB9OSwY0UZiCvJbr
         GGGg==
X-Forwarded-Encrypted: i=1; AJvYcCWaHDVlVja5OGhtk6KfgBzVLCJJITbFOgBzZclGa3JUxxGm9wdSIbKdTkd4IyP7EbPfwWVXL/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8cH4Gx56cRPytWh7g0nokBasOMQjd8nqHuCTzVf3Sk+oFppHY
	lHofNAsQCF1ZNtI5SyeX+sf68niPCeTrBGI6yvi44IErp6kgZSRD6XFGM8fppMlbhsU=
X-Gm-Gg: AY/fxX5EzQ7+z3/14ARwnLEkK8K+ZeITtaZP9+3DvD/1OH+aCzvRn0Kj50NmhG/rJ6b
	UC4K52LP3+F1/bpvEWGYK3KGG2Qt8xkTzzVk0w/rqmSpF5dfFdaEjhDHZ9Sock4ggRI6lY6t+I2
	ujZgWdrV7pNKdDP5VFFO30tqkJjqkkGiZ6ITSrIjvpTte84xfUUE6p2zPQwk8H4mctyr7T7LPlk
	9EMwlkOlGbGiJZBv91kYbN3irs67bLfJ5wIQ+LkxEWyEI12Qf0f6MAEtDBhAjtb1P6Ik00n0nNi
	mjgttrWq60IogFesqET28LXZTZNF9J3MX7G8clqmRdwUf8YGI1gVzQlMt9CVXrwoIyhNPRbHgnt
	cXT9+ujfcpQl25dC1jyVeKTaOz3cip8CkJZ3VHNNLnr58Gp1TrO5cvdGoDXsQBeVsDJBX5LTvEO
	Z8kkSJ3Bte
X-Google-Smtp-Source: AGHT+IFt2N2baAzLASkOTIU7+I/03msTHERpTS7+sQ2jyXNzBzoYnOgKqtg/kC7wsNVNHgTTDRq1ow==
X-Received: by 2002:a05:6808:4f51:b0:450:718:24f with SMTP id 5614622812f47-457b1f586bcmr1987107b6e.0.1766175871257;
        Fri, 19 Dec 2025 12:24:31 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457b3ba3715sm1637530b6e.2.2025.12.19.12.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 12:24:30 -0800 (PST)
Message-ID: <460fe33a-bf6d-4966-be04-abb6d89b9f9e@kernel.dk>
Date: Fri, 19 Dec 2025 13:24:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] af_unix: don't post cmsg for SO_INQ unless explicitly
 asked for
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev <netdev@vger.kernel.org>
Cc: io-uring <io-uring@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Julian Orth <ju.orth@gmail.com>
References: <07adc0c2-2c3b-4d08-8af1-1c466a40b6a8@kernel.dk>
 <willemdebruijn.kernel.18e89ba05fbac@gmail.com>
 <fe9dbb70-c345-41b2-96d6-2788e2510886@kernel.dk>
 <willemdebruijn.kernel.1996d0172c2e@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <willemdebruijn.kernel.1996d0172c2e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/25 1:08 PM, Willem de Bruijn wrote:
> [PATCH net v2] assuming this is intended to go through the net tree.

Assuming this will hit -rc3 then, as netdev PRs usually go out on
thursdays?

> Jens Axboe wrote:
>> On 12/19/25 12:02 PM, Willem de Bruijn wrote:
>>> Jens Axboe wrote:
>>>> A previous commit added SO_INQ support for AF_UNIX (SOCK_STREAM), but it
>>>> posts a SCM_INQ cmsg even if just msg->msg_get_inq is set. This is
>>>> incorrect, as ->msg_get_inq is just the caller asking for the remainder
>>>> to be passed back in msg->msg_inq, it has nothing to do with cmsg. The
>>>> original commit states that this is done to make sockets
>>>> io_uring-friendly", but it's actually incorrect as io_uring doesn't use
>>>> cmsg headers internally at all, and it's actively wrong as this means
>>>> that cmsg's are always posted if someone does recvmsg via io_uring.
>>>>
>>>> Fix that up by only posting a cmsg if u->recvmsg_inq is set.
>>>>
>>>> Additionally, mirror how TCP handles inquiry handling in that it should
>>>> only be done for a successful return. This makes the logic for the two
>>>> identical.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: df30285b3670 ("af_unix: Introduce SO_INQ.")
>>>> Reported-by: Julian Orth <ju.orth@gmail.com>
>>>> Link: https://github.com/axboe/liburing/issues/1509
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>
>>>> ---
>>>>
>>>> V2:
>>>> - Unify logic with tcp
>>>> - Squash the two patches into one
>>>>
>>>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>>>> index 55cdebfa0da0..a7ca74653d94 100644
>>>> --- a/net/unix/af_unix.c
>>>> +++ b/net/unix/af_unix.c
>>>> @@ -2904,6 +2904,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>>>>  	unsigned int last_len;
>>>>  	struct unix_sock *u;
>>>>  	int copied = 0;
>>>> +	bool do_cmsg;
>>>>  	int err = 0;
>>>>  	long timeo;
>>>>  	int target;
>>>> @@ -2929,6 +2930,9 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>>>>  
>>>>  	u = unix_sk(sk);
>>>>  
>>>> +	do_cmsg = READ_ONCE(u->recvmsg_inq);
>>>> +	if (do_cmsg)
>>>> +		msg->msg_get_inq = 1;
>>>
>>> I would avoid overwriting user written fields if it's easy to do so.
>>>
>>> In this case it probably is harmless. But we've learned the hard way
>>> that applications can even get confused by recvmsg setting msg_flags.
>>> I've seen multiple reports of applications failing to scrub that field
>>> inbetween calls.
>>>
>>> Also just more similar to tcp:
>>>
>>>        do_cmsg = READ_ONCE(u->recvmsg_inq);
>>>        if ((do_cmsg || msg->msg_get_inq) && (copied ?: err) >= 0) {
>>
>> I think you need to look closer, because this is actually what the tcp
>> path does:
>>
>> if (tp->recvmsg_inq) {
>> 	[...]
>> 	msg->msg_get_inq = 1;
>> }
> 
> I indeed missed that TCP does the same. Ack. Indeed consistency was
> what I asked for.

FWIW, I don't disagree with you, but sorting that out should then be a
followup patch that would then touch both tcp and streams.

> Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks!

-- 
Jens Axboe

