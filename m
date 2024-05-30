Return-Path: <netdev+bounces-99514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AB08D51A2
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 20:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96204282759
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F8247A58;
	Thu, 30 May 2024 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="LehkE9wJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A21650286
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717092469; cv=none; b=JHpRlGsRlguvlXgOAbL7pfNVoWFpCkaLwjgGHUCKPBjoPhRRLPLHVr4OQPSDAnYBpsMlLZbEy2K8jtKeh3xaNsLezyXnBOnO9heUDNZ7ny+2zoj6SmrcgnpFbQmrUxgnMZ2MnGV1pApb6LI0e/18ZfOh1HiCNq8IKFIf/ol1YAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717092469; c=relaxed/simple;
	bh=EordGk9DLoWAiJizUGjjY6hiBA3GbEY1S208+8XbuSI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QSXT3wDtKqyimB6aN4ME6BqyCPVGyQo9gldJ1oo0Deddj1lxd3I2WRFl/NXjKGquCZUsr38YrhIE9iVukBKj85yN6vkOce9T64v0xmtF3K0uXOu3xMx8/9OpigHgt6pSix095gweZgxWjP5TXOlvy9Skez1tY4KqBZToutp+Zhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=LehkE9wJ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5785f861868so1469458a12.2
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717092466; x=1717697266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4w///ifvBe62nEeB+Tey+QlC2+cyMr8c0rojLnSSnio=;
        b=LehkE9wJXJjVmnV9jud/Rv5JPi1oITWRehBGh2hkc3bc8psVqvQyQ0B2WKnR78TMOw
         DPoRqarWumKOo/Qcl4SVsbHAWKYnw8vuJWj5uKa3V/RA8ylGtjIxDPC7msAr7bgukGsj
         A7EYz6D7nltC4QK+rn7+OOHW54AWthMgmUh66UnHBouq7StcxGRVgTOdC0k2LOl8rRKt
         eqUXg5qTiGpwDACTdFWaqaO/yjClmDH3jHZWPigRTYgAFemhBUTNZGm1n+MGfxgNtgoh
         gT92ixZoZfPqAoqI4Ne5NO2SqXVaiFGIbnpGniIGhvkjkU2U3jOdHupVkd+9gIfXJBU4
         KaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717092466; x=1717697266;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4w///ifvBe62nEeB+Tey+QlC2+cyMr8c0rojLnSSnio=;
        b=WoJ5hVFhpPc5stl3n7OvFbhpZhMZjJtS7Oq7vTPbog8NC7zKBE9tEqAN1Mt1G7YDDu
         pO8M10DzQ3zhGKNteyG4j/SmJO/Pvq9uFqYC3MOkkkMKuOMMHk4ZEKdP2yPj3NeQXLyt
         SVMgUECoUZWkpjnDnUr0nTAW6qtA6BN7pXDUy7qs2LRN8AVIms6WF9EO59vSC46jIp3w
         VyWHhPn3z9yLeo5tq4MVtvtGw7zM5kHub0sYRdEt8e0tOEdWjYcHK+OpVaQBeLKh7/iQ
         FgNstJpKC7//+fow3hR3sdcJ0kqISRtAVtk8sH93LKYXBnNqqut4wLmUWqe57C1D8cK+
         9p7w==
X-Forwarded-Encrypted: i=1; AJvYcCX4BryJlfIPsZMoJ0MLelw4cSkBCXAGKOcz+E8hagnH1/5mTwYCDYzt9QsZKH6o9O0DYpSVKgcbMsnIBf5/A/1Q4OjRqsHe
X-Gm-Message-State: AOJu0Yy4YW354WRHAmDPqFUXiYOJn6nIk6EPW8bZTJEgH9a4TCGGju3m
	tv7f2KmLm62hHbOZzVGY56zqfAtymBltlWc6pWrE5mFukF5cEBDP+bjd+V+xCWo=
X-Google-Smtp-Source: AGHT+IEW7RCGogfixRlkfo7i2vI/USEQB4uxGGHN+U953a2tYwA7BqWiZyFcQjssI4N0ySSpLBHp4w==
X-Received: by 2002:a17:906:4ec5:b0:a59:a83b:d435 with SMTP id a640c23a62f3a-a65e8e4080emr202630766b.18.1717092465490;
        Thu, 30 May 2024 11:07:45 -0700 (PDT)
Received: from [192.168.0.105] (bras-109-160-25-143.comnet.bg. [109.160.25.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67ea67b267sm1057166b.141.2024.05.30.11.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 11:07:45 -0700 (PDT)
Message-ID: <4b67d969-b069-4e1a-9f09-f0308a25b03b@blackwall.org>
Date: Thu, 30 May 2024 21:07:43 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] Allow configuration of multipath hash seed
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>
References: <20240529111844.13330-1-petrm@nvidia.com>
 <878d1248-a710-4b02-b9c7-70937328c939@blackwall.org>
 <878qzr9qk6.fsf@nvidia.com>
 <a9a50b48-d85f-4465-a7b0-dec8b3f49281@blackwall.org>
Content-Language: en-US
In-Reply-To: <a9a50b48-d85f-4465-a7b0-dec8b3f49281@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/30/24 20:27, Nikolay Aleksandrov wrote:
> On 5/30/24 18:25, Petr Machata wrote:
>>
>> Nikolay Aleksandrov <razor@blackwall.org> writes:
>>
>>> I think that using memory management for such simple task is an
>>> overkill. Would it be simpler to define 2 x 4 byte seed variables
>>> in netns_ipv4 (e.g. user_seed, mp_seed). One is set only by the
>>> user through the sysctl, which would also set mp_seed. Then you
>>> can use mp_seed in the fast-path to construct that siphash key.
>>> If the user_seed is set to 0 then you reset to some static init
>>> hash value that is generated on init_net's creation. The idea
>>
>> Currently the flow dissector siphash key is initialized lazily so that
>> the pool of random bytes is full when the initialization is done:
>>
>>     https://lore.kernel.org/all/20131023180527.GC2403@order.stressinduktion.org
>>     https://lore.kernel.org/all/20131023111219.GA31531@order.stressinduktion.org
>>
>> I'm not sure how important that is -- the mailing does not really
>> discuss much in the way of rationale, and admits it's not critical. But
>> initializing the seed during net init would undo that. At the same time,
>> initializing it lazily would be a bit of a mess, as we would have to
>> possibly retroactively update mp_hash as well, which would be racy vs.
>> user_hash update unless locked. So dunno.
> 
> If you want to keep the late init, untested:
> init_mp_seed_once() -> DO_ONCE(func (net_get_random_once(&init_mp_seed),
> memcpy(&init_net.mp_seed, &init_mp_seed))
> 

Blah, just get_random_bytes() instead of net_get*. :)
It'll be executed once anyway. But again I think we can do without all
of this.

>>
>> If you are OK with giving up on the siphash key "quality", I'm fine with
>> this.
>>
> 
> IMO that's fine, early init of the seed wouldn't be a problem. net's
> hash_mix is already initialized early.
> 
[snip]
>>
>> I kept the RCU stuff in because it makes it easy to precompute the
>> siphash key while allowing readers to access it lock-free. I could
>> inline it and guard with a seqlock instead, but that's a bit messier
>> code-wise. Or indeed construct in-situ, it's an atomic access plus like
>> four instructions or something like that.
> 
> You can READ/WRITE_ONCE() the full 8 bytes every time so it's lock-free
> and consistent view of both values for observers. For fast-path it'll
> only be accessing one of the two values, so it's fine either way. You
> can use barriers to ensure latest value is seen by interested readers,
> but for most eventual consistency would be enough.
> 

Actually aren't we interested only in user_seed in the external reader
case? We don't care what's in mp_seed, so this is much simpler.



