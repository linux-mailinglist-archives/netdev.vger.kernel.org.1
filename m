Return-Path: <netdev+bounces-86342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D3789E6A3
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 02:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC9D1F21D20
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8458619E;
	Wed, 10 Apr 2024 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="leFdilpe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA707F
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707889; cv=none; b=jMh6lEkbDHCN8dyNrmn1aU/3lOI4JOA3eQa/oUS7a+G6BSXmKOcEKR8qu/2Ur5W8+yUz+flMJggwOncQYfD4trMz72YpNFAkcLusgvC+sBtZsy+IcvzIA6mqG3eaCP99KSb/5a27s+2WmFsNokSD3hxGHXwD74lkzhJ9dlnL5W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707889; c=relaxed/simple;
	bh=yP1T8LauDeG0xL/mXbvVH0aOxNdjjRZEaCcRo06xg0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYFBq5U1r3SzADREwsGE/MEisiG+e1pNKT7jD5PGi68DR2g+C4NZRR+d4FCYfenrYG7tGSw9ebY3Ko/4fLqQOei1yXJFSLT7eR2Ne9Bte/1BwZdTUpXtmlzFOx/24wt9xAeMXaITyle1Em0A1hnMNw1UwHa9YBVKfpIbpy8jNs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=leFdilpe; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c4f23d23d9so3680776b6e.3
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 17:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712707886; x=1713312686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BAro7GlA5y2deIcN92MfW9cqCmZtqng01ISzr1s9aeU=;
        b=leFdilpe8/mJmLt6wtyKFApwBP7oKRHFa14nxoBzSKz4VlosennENdWIZFBG/9cwvr
         mAcnb9hkn4z6Q1oKEYQhET9c20ttJeGa+68SoGZUC3U8GEogzsQgEahec45nxFENQKFa
         oc9sCD1VcFLrGDpd1rXOOXB5HEvaIRfuVJAfsmwLpSClzqpHnk1qNhMajowighrglVQe
         KmMCGLteKL0WDjVvI/RmPQDpTu2cpLTtyOGM8xj1z6108MjdZrOGZmccCbt8//PuxKfA
         8T/31lUUqct164v3Kgc+yPRGcqD5zbh/VmxOnq6IjKNM85nYel0+WCq2j1dH6pzf0xSr
         hjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712707886; x=1713312686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAro7GlA5y2deIcN92MfW9cqCmZtqng01ISzr1s9aeU=;
        b=EfDckPVBkQfIQOv33JXICJbSnYWfqP+pq0bj686zdwQhfIKD5GKgWBbbKis5fEdE1Q
         dZMWZd1o3P46C91aaCcOW2EnlKD5WRHKAa011AVqA51efrXQZYu2jU4R3dsZuLwz9syv
         wlWz16Wihlv3g751aYscKNUA1I/3PDbJWlVvuL8WCbJDLe9ZuxixqM6g75TXjmYGdVyB
         aIPSVvrABfsKV/svantpZGjFIZbZi6AQFNQwH08koHlP+nvTWZcg2uEWGqucfdsqiU2p
         Ztsgcy3aqqB45RPeqRc+nwFFYMRYfd3AtUmr4t9JWgIIKAw/9JvLFa2hYkUPGYlEQh61
         VP0w==
X-Gm-Message-State: AOJu0YzzUKPgLBSjUOxw0D0Qx5DjxxVxJOq2Mfin9GM8q9jnxKrxrMeA
	qgajnmLWFnJTLbKM/50Bz5r/XIpG0gh7LT/KwjCZiOco5HL33uMlk54UMRVwFbE=
X-Google-Smtp-Source: AGHT+IGJxM0qOu1rRQONFnvZl6YAIUVAEwbWTP/uQM6/EZqYoOKRlPwtx0G2XBVSFiQuSFxlm7QjcQ==
X-Received: by 2002:a05:6808:2909:b0:3c4:e499:dff6 with SMTP id ev9-20020a056808290900b003c4e499dff6mr975518oib.11.1712707886720;
        Tue, 09 Apr 2024 17:11:26 -0700 (PDT)
Received: from [10.73.215.90] ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id k1-20020a544401000000b003c5f66569c9sm755139oiw.46.2024.04.09.17.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 17:11:26 -0700 (PDT)
Message-ID: <2f7982b4-1474-4bf3-bf72-d78c0e5170d3@bytedance.com>
Date: Tue, 9 Apr 2024 17:11:23 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH net-next 1/3] sock: add MSG_ZEROCOPY_UARG
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, kuba@kernel.org, cong.wang@bytedance.com,
 xiaochun.lu@bytedance.com
References: <20240409205300.1346681-1-zijianzhang@bytedance.com>
 <20240409205300.1346681-2-zijianzhang@bytedance.com>
 <CANn89iKjoEaSgHHKNvgWJ+Ro=rY_Z4ZzukTKe1Qn3y3Bt3X_-g@mail.gmail.com>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <CANn89iKjoEaSgHHKNvgWJ+Ro=rY_Z4ZzukTKe1Qn3y3Bt3X_-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/9/24 2:23 PM, Eric Dumazet wrote:
> On Tue, Apr 9, 2024 at 10:53 PM <zijianzhang@bytedance.com> wrote:
>>
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
>> However, zerocopy is not a free lunch. Apart from the management of user
>> pages, the combination of poll + recvmsg to receive notifications incurs
>> unignorable overhead in the applications. The overhead of such sometimes
>> might be more than the CPU savings from zerocopy. We try to solve this
>> problem with a new option for TCP and UDP, MSG_ZEROCOPY_UARG.
>> This new mechanism aims to reduce the overhead associated with receiving
>> notifications by embedding them directly into user arguments passed with
>> each sendmsg control message. By doing so, we can significantly reduce
>> the complexity and overhead for managing notifications. In an ideal
>> pattern, the user will keep calling sendmsg with MSG_ZEROCOPY_UARG
>> flag, and the notification will be delivered as soon as possible.
>>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
>> ---
>>   include/linux/skbuff.h                  |   7 +-
>>   include/linux/socket.h                  |   1 +
>>   include/linux/tcp.h                     |   3 +
>>   include/linux/udp.h                     |   3 +
>>   include/net/sock.h                      |  17 +++
>>   include/net/udp.h                       |   1 +
>>   include/uapi/asm-generic/socket.h       |   2 +
>>   include/uapi/linux/socket.h             |  17 +++
> 
> ...
> 
>> +
>> +static inline void tx_message_zcopy_queue_init(struct tx_msg_zcopy_queue *q)
>> +{
>> +       spin_lock_init(&q->lock);
>> +       INIT_LIST_HEAD(&q->head);
>> +}
>> +
>>
> 
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index e767721b3a58..6254d0eef3af 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -462,6 +462,8 @@ void tcp_init_sock(struct sock *sk)
>>
>>          set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>>          sk_sockets_allocated_inc(sk);
>> +
>> +       tx_message_zcopy_queue_init(&tp->tx_zcopy_queue);
>>   }
> 
> 
> FYI,  tcp_init_sock() is not called for passive sockets.
> 
> syzbot would quite easily crash if zerovopy is used after accept()...

Thanks for the info, I will reuse error queue in the next patch set and
this line of code will be deleted.

