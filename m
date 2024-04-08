Return-Path: <netdev+bounces-85833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D10E89C7D6
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 17:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A134FB23234
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18E413F457;
	Mon,  8 Apr 2024 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF9CZ2KN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED85B13F43B
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588790; cv=none; b=GtbQ4f5p1DA6ODxs0I4KYtmC8fQrrHjjo+rsTPyBJrXY9jEIueb7PtiSUOsNPsqAUM/vY4GAxwkv5S6ur47dzd+gnFplMR2Rj/OJvMwtop4s3aAVcfQH9nlFUPGCES5iUrISXU6ziAp5tRmL4EDdvjpvoUy99PGRfabNlZnx+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588790; c=relaxed/simple;
	bh=fWNH2e74kuA+xnAJ9Cmt9ksDWGbJMfXrMABjDArB7CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLYVhF3wWXdD+C+KswkRTJha3o+sQKSVZoI2q50fXNSeXUYwXa+W6k28I+idcon6YcV06BXGD+V3q+t2ISZVBgP54sdDaw0TFOwHrqlQ4bWZP69gP/9N542bXv7Lk+8h24wJslQQ1IxBQvu+m8M1tEwmdbQCX3HO76dDnbjmI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aF9CZ2KN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso999567a12.1
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 08:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712588787; x=1713193587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVRbOo1cwv1BajME1lksI83Oja5hPbHlQWJbBWVJFOk=;
        b=aF9CZ2KNzNEXG1CY8lzMkQx3H4j13t6GIaEoXyjMnvJsZ/3Jf9zwbim3qAT+KMCO4O
         ysHHTMrIUUOOG2sX76HY6TvGW04FTQwzC9OluBA7uNqxkxe4h9FXafyMa788qw/1TAHO
         oz6UsCV2ccjcI/dGcAItk0l8i1mVpRjRpbpjeEMjnZWZQP9ac6syLDBdsfauQ8LXkZP+
         2nE/fWteHNz39mfEjl9D6PEz1+2GkqTs/sU5n2tRRnnFMIl9SI/AGOmJ1z0AIibNS2qX
         WLR0oxQHCmXbypdmeBtbWW5T87vYpmEM/49V7U7fkZr5czD1KnIU0KFs8+4keGoQTmwm
         +gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712588787; x=1713193587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVRbOo1cwv1BajME1lksI83Oja5hPbHlQWJbBWVJFOk=;
        b=d2MIsinAmvsfc7IiBzFQaTpuBjq9glrZzYixypGyWxOu1+P1PkYWXPlGTracV0be1e
         pOf9Hf3M434tpfl+GIHEbWYiOyCge+aMrGDzVsvDnawX4deRnuZiGxHkIEL/ncWCiimy
         MQakXQ0x4T5ZA8+6HPdW4EZcKsBa7N8SZmY3p9eJGnUxKbApcwWa3Vb+DRrB1HI/JL7Q
         xusliB3S7ZCqbuhx+viRPzVlHf0m+6sGS71UohNor6A442UDJtt0mkP31A+EbrVCS1Dw
         kmY5UKGTb7O72EKgtJOdxuPyeQ4yRYhS5NpIZUFoIEru42xAZXE05WGXTzyGWvdGVJOU
         GAGA==
X-Gm-Message-State: AOJu0Yy2NvubneMgffehzskbP/y18VmBaxKTrRkxbF8WnJ4X9kp202rp
	rDmkCP0d9ktmey/aQN12UUE3HQfs+HICxId8JPfsPRIZj2GEoJMA
X-Google-Smtp-Source: AGHT+IEEp5rc8AYQD6f1P5L5Yzb2dH9OUfnOuzMd3/ySO7GFDlijLOL1LNa1VyMWymAOWw5OTKyL9Q==
X-Received: by 2002:a50:bb03:0:b0:56e:2a0a:c131 with SMTP id y3-20020a50bb03000000b0056e2a0ac131mr5627113ede.17.1712588787074;
        Mon, 08 Apr 2024 08:06:27 -0700 (PDT)
Received: from [192.168.42.195] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id er18-20020a056402449200b0056bfc48406csm4155283edb.7.2024.04.08.08.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 08:06:26 -0700 (PDT)
Message-ID: <01d4264c-e54a-4b21-9dbf-6e31ff6c782f@gmail.com>
Date: Mon, 8 Apr 2024 16:06:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: enable SOCK_NOSPACE for UDP
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 pabeni@redhat.com, kuba@kernel.org
References: <0e2077519aafb2a47b6a6f25532bfd43c8b931aa.1712581881.git.asml.silence@gmail.com>
 <CANn89iJoZ6P=BPWNwuxGeJ+eTpAc27y=KgEoO==6LKOw7QB9YQ@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CANn89iJoZ6P=BPWNwuxGeJ+eTpAc27y=KgEoO==6LKOw7QB9YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/8/24 15:31, Eric Dumazet wrote:
> On Mon, Apr 8, 2024 at 4:16 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> wake_up_poll() and variants can be expensive even if they don't actually
>> wake anything up as it involves disabling irqs, taking a spinlock and
>> walking through the poll list, which is fraught with cache bounces.
>> That might happen when someone waits for POLLOUT or even POLLIN as the
>> waitqueue is shared, even though we should be able to skip these
>> false positive calls when the tx queue is not full.
>>
>> Add support for SOCK_NOSPACE for UDP sockets. The udp_poll() change is
>> straightforward and repeats after tcp_poll() and others. In sock_wfree()
>> it's done as an optional feature because it requires support from the
>> poll handlers, however there are users of sock_wfree() that might be
>> unprepared to that.
>>
>> Note, it optimises the sock_wfree() path but not sock_def_write_space().
>> That's fine because it leads to more false positive wake ups, which is
>> tolerable and not performance critical.
>>
>> It wins +5% to throughput testing with a CPU bound tx only io_uring
>> based benchmark and showed 0.5-3% in more realistic workloads.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>
>> v3: fix a race in udp_poll() (Eric)
>>      clear SOCK_NOSPACE in sock_wfree()
>>
>> v2: implement it in sock_wfree instead of adding a UDP specific
>>      free callback.
>>
>>   include/net/sock.h |  1 +
>>   net/core/sock.c    |  9 +++++++++
>>   net/ipv4/udp.c     | 15 ++++++++++++++-
>>   3 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index 2253eefe2848..027a398471c4 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -944,6 +944,7 @@ enum sock_flags {
>>          SOCK_XDP, /* XDP is attached */
>>          SOCK_TSTAMP_NEW, /* Indicates 64 bit timestamps always */
>>          SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
>> +       SOCK_NOSPACE_SUPPORTED, /* socket supports the SOCK_NOSPACE flag */
>>   };
>>
>>   #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 5ed411231fc7..ae7446570726 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -3393,6 +3393,15 @@ static void sock_def_write_space_wfree(struct sock *sk)
>>
>>                  /* rely on refcount_sub from sock_wfree() */
>>                  smp_mb__after_atomic();
>> +
>> +               if (sock_flag(sk, SOCK_NOSPACE_SUPPORTED)) {
>> +                       struct socket *sock = sk->sk_socket;
> 
> It seems sk->sk_socket could be NULL, according to similar helpers
> like sk_stream_write_space()
> 
> udp_lib_close() -> sk_common_release() -> sock_orphan() ...

Yeah, thanks. So sk_socket stays alive even after it's removed,
makes sense, but I wonder why there is no READ_ONCE in likes of
sk_stream_write_space() as seems sk_socket can just randomly
change?

-- 
Pavel Begunkov

