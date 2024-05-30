Return-Path: <netdev+bounces-99496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8733E8D50FD
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12F441F24625
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9833BB2E;
	Thu, 30 May 2024 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="qo8XaPPp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DB1187560
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090046; cv=none; b=JaVi64Zuw+DEnpQIpaLKKt5qEaF79ARPQ8fsEykqODjEPw5s7hp0T8Jr8fJUKONuSpcQP2bQXiV/lZ1rdWQtS5c38mzcmcOfh+PUQG/ECxjYxIO7rq8PP5AKMbwu94RPwOveiRXMNV1yQvgBAVGEnCCR+wc2GEzLsr27YyekbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090046; c=relaxed/simple;
	bh=AzPPrQvWftZavVm8o7x8tDX+QGoOOGJh4cLKvdDATCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3pNfOrvWKzr83pRVgb4M19Fdm2+r/pdVg/0xB/HCCpOFVoSbmvESgsKZR/Ytg/TmCtH2a5aspPEOIAcmiWVnISBVYgU1/AjT+VpVSO5Z+gEaI9A0cGzoEFRoz4eV6T8SUg6IIk0MOVpcKZTIyLUG3ObNc+hB30IMBSYVMXc7nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=qo8XaPPp; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a2406f951so955906a12.1
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 10:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717090043; x=1717694843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bjn6kV+I1+puKhuNk+vFEkh0Zq4tZL1VGL97CFzqy7o=;
        b=qo8XaPPpdPN4hI6pgMYZ9iEUHHnysbzhFaLkCWeKmzDDvpjUB2Iy7/gSxGYHXDuqD4
         OKye8tOhbWJQNvQaObI0MLxGt3wmPDEZu3hqoXGdJyv3hO9r/F5XQc9kW5Prw8EWcOlG
         mNcFdo4NwaQsdXRDHnR6hlOsShryok/XRjbqwm0De1m+zb29y0VwAafO/5xlrY5YC/ki
         UOQ36puHPFpWnfjjAxNmKc2A2thjHU8LdxJBy5yR6/HwHlNdq+jDiJQxX7KCMSiaOF3s
         M2EJttIUI8u7r+0e8X2KcXG5a72nBupPRdnBiBFMHCBJUvEACAKvlITc7tJ6vkYHLuc+
         MTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717090043; x=1717694843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bjn6kV+I1+puKhuNk+vFEkh0Zq4tZL1VGL97CFzqy7o=;
        b=FlvAH3YTP8CZCOBQgr6GuhpefCOgNz71lQpnf3LDeLnPoCFkz8J5KwDKKeDDAhGjDo
         ef3vxPFgHuP7P7mwj5Z/3ZnkeqeSL5JLLpbk8sCrYr/1G0o+OPyRqlCQChZXSy0zUmyO
         VO6jWvFK4Nf6Cil3PcHfjDwewLrgHqpJ1n4oJVloJwqqQRZ5cF3BS5AhvlrcU7Y5rT88
         Jg3wGtA5gkhEPX35rBFJJ5ht1mKhG12mmNVyAJP8weS5Ru7enHy8Jy5O/4Gv+sX0szQL
         dIrLIWp8XVdq1deF1ivUkByJ7B/69NJTwFmHoFHM2x/Ut2t1oZ/S08oV6cz8uYo/NSzc
         VAAA==
X-Forwarded-Encrypted: i=1; AJvYcCVFFE4gQ/JnqvHdfgaU3g6iM2BTElz/eeRxDDpxz8cQwWIQEQ7onFXvxO6HKpczQwsHzQbfvS5fBQP+UDdqLrQsj6GLemAo
X-Gm-Message-State: AOJu0YxzRg01ZUlMPHTWldd+qUbzNEHDxVMungG98th3jeOspu4vkB5x
	6K/l3V1LgEvib//V4Ih8WbiFQSKeHT4FTP38QVXxCLrrjy5TYQwptHJ07844BnyYE+cEnc7obQ5
	4IjEtVQ==
X-Google-Smtp-Source: AGHT+IFRAtJRLfiYDc7FcZZcJbfFnMzj0OUctLnGljxS15fNIrA18znVuoboXkovavrwQU+wlAtKKA==
X-Received: by 2002:a50:8d57:0:b0:57a:27b9:25f5 with SMTP id 4fb4d7f45d1cf-57a27b9285dmr1260770a12.35.1717090042576;
        Thu, 30 May 2024 10:27:22 -0700 (PDT)
Received: from [192.168.0.105] (bras-109-160-25-143.comnet.bg. [109.160.25.143])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c6d30esm35285a12.73.2024.05.30.10.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 10:27:22 -0700 (PDT)
Message-ID: <a9a50b48-d85f-4465-a7b0-dec8b3f49281@blackwall.org>
Date: Thu, 30 May 2024 20:27:20 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] Allow configuration of multipath hash seed
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>
References: <20240529111844.13330-1-petrm@nvidia.com>
 <878d1248-a710-4b02-b9c7-70937328c939@blackwall.org>
 <878qzr9qk6.fsf@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <878qzr9qk6.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/30/24 18:25, Petr Machata wrote:
> 
> Nikolay Aleksandrov <razor@blackwall.org> writes:
> 
>> I think that using memory management for such simple task is an
>> overkill. Would it be simpler to define 2 x 4 byte seed variables
>> in netns_ipv4 (e.g. user_seed, mp_seed). One is set only by the
>> user through the sysctl, which would also set mp_seed. Then you
>> can use mp_seed in the fast-path to construct that siphash key.
>> If the user_seed is set to 0 then you reset to some static init
>> hash value that is generated on init_net's creation. The idea
> 
> Currently the flow dissector siphash key is initialized lazily so that
> the pool of random bytes is full when the initialization is done:
> 
>     https://lore.kernel.org/all/20131023180527.GC2403@order.stressinduktion.org
>     https://lore.kernel.org/all/20131023111219.GA31531@order.stressinduktion.org
> 
> I'm not sure how important that is -- the mailing does not really
> discuss much in the way of rationale, and admits it's not critical. But
> initializing the seed during net init would undo that. At the same time,
> initializing it lazily would be a bit of a mess, as we would have to
> possibly retroactively update mp_hash as well, which would be racy vs.
> user_hash update unless locked. So dunno.

If you want to keep the late init, untested:
init_mp_seed_once() -> DO_ONCE(func (net_get_random_once(&init_mp_seed),
memcpy(&init_net.mp_seed, &init_mp_seed))

> 
> If you are OK with giving up on the siphash key "quality", I'm fine with
> this.
> 

IMO that's fine, early init of the seed wouldn't be a problem. net's
hash_mix is already initialized early.

> Alternatively I can keep the dispatch in like it currently is. I.e.:
> 
> 	if (user_seed) {
> 		sip_hash = construct(user_seed)
> 		return flow_hash_from_keys_seed(sip_hash)
> 	} else {
> 		return flow_hash_from_keys()
> 	}
> 
> I wanted to have the flow dispatcher hash init early as well, as it made
> the code branch-free like you note below, but then Ido dug out that

+1

> there are $reasons for how it's currently done.
> >> is to avoid leaking that initial seed, to have the same seed
>> for all netns (known behaviour), be able to recognize when a
>> seed was set and if the user sets a seed then overwrite it for
>> that ns, but to be able to reset it as well.
>> Since 32 bits are enough I don't see why we should be using
>> the flow hash seed, note that init_net's initialization already
> 
> No deep reason in using the dissector hash as far as I'm concerned.
> I just didn't want to change things arbitrarily, so kept the current
> behavior except where I needed it to change.
> 
>> uses get_random_bytes() for hashes. This seems like a simpler
>> scheme that doesn't require memory management for a 32 bit seed.
>> Also it has the benefit that it will remove the test when generating
>> a hash because in the initial/non-user-set case we just have the
>> initial seed in mp_seed which is used to generate the siphash key,
>> i.e. we always use that internal seed for the hash, regardless if
>> it was set by the user or it's the initial seed.
>>
>> That's just one suggestion, if you decide to use more memory you
>> can keep the whole key in netns_ipv4 instead, the point is I don't
>> think we need memory management for this value.
> 
> I kept the RCU stuff in because it makes it easy to precompute the
> siphash key while allowing readers to access it lock-free. I could
> inline it and guard with a seqlock instead, but that's a bit messier
> code-wise. Or indeed construct in-situ, it's an atomic access plus like
> four instructions or something like that.

You can READ/WRITE_ONCE() the full 8 bytes every time so it's lock-free
and consistent view of both values for observers. For fast-path it'll
only be accessing one of the two values, so it's fine either way. You
can use barriers to ensure latest value is seen by interested readers,
but for most eventual consistency would be enough.


