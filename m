Return-Path: <netdev+bounces-146927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 816E59D6C53
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 01:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29E0161331
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 00:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3EF3C12;
	Sun, 24 Nov 2024 00:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="EXlr9kgU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E0D10E3
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 00:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732408062; cv=none; b=qdyXGzrHv7S04Y7OY/OZZHXtS5Tv1ZPhSM7FdeCwcxcD+OD9S4kLqWybEpbNfX+jBvSe9/Vi4I7HhMlir5+e3tGTPJ1scqB1KrQVhJ32+pRS0m5etPqn6EwIKKesLxrdxZY5nAhJuzOcX7UqwPgjooAGu7/kQG+4zRCp1wSnQRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732408062; c=relaxed/simple;
	bh=UceutF7DoxVjBYZ3e0gxKdLIfbkjFGf1TbIBku99vLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4WOhm+RRJvjVk/KboGbOW+Nee9RGSloH8Ti2K2h7IDqdL+Opkkwrioty/VEGt1sXoc+l1tb9evX9wBOH36N2rlr5LLgPSBvzkToPoMATQSTixcSfc5W7+QXbS3XfOo2BRUed93er8jhrZE8qYgn6GxKnTnTIc7pWyef62pXS+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=EXlr9kgU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso30432895e9.0
        for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 16:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732408059; x=1733012859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p874L0yJna1yTwg+JzSlBIKXzs4oBM24PhE71VIgogo=;
        b=EXlr9kgUwOemJYzBcKo8jYN3R91UkXWGRXJ8aXYXp8nTpAxHM06ojGC4ICKjyLIil+
         SVyJmE1JP6GTC+FGly2IgFTXZ7t73TobTmJnprZFZxZHbEVi9IBYGsCUB8Xn+GyROOQk
         xvjvyN1xiNJ+LM6jJf2432VBrKBiwBH15nfWY9qjwqglE4hHmSRQMcf9CznRqTAk+l4Y
         nAiz6rpqY5seHxNOEXaZ0emIT/Ag8JizmR5F7ikr5bqmnYB6K8vMB0H7Wkuay46XkjFw
         /ERsNC57d0QH25cPb2TdbWalMpkd6bxl9oOs9d4r6nCO97Rfu+A9dOTdIfBs+Zo58M6c
         zNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732408059; x=1733012859;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p874L0yJna1yTwg+JzSlBIKXzs4oBM24PhE71VIgogo=;
        b=vs8dvzvXrgdxdOZ2ycbq0KnnJbhBC7znrAyhvoKSTGGHFHshaJiE1dp35WjvWFe/vL
         O/NfAu5v6KspXkrUhVoITMcaamzhluJE14OA3VjsFacHnniDwO813TW9ejGHfwuuokZe
         0WMSGbThdEUb/NXz8AT0K73dJ7ls6VRCqwMlIMGQoDeXqyShqP9qleNmedsFBsj+YLBQ
         0TqNCvnisi0QaJBRKJa1jIYDdlcTEdPuF+K0KDYNQta/G3ltHf4ZVzcI/+4gu0nkCLtp
         l6FeKvERJGasrK0cIHRfq/3jX28m2KCmpGpiqjVtzSZOOusWGxNuAg73iEK+cjzhZrJV
         tgEg==
X-Forwarded-Encrypted: i=1; AJvYcCXAmqnyUczW5/RGQ67F0BdJ4r057Y+qy9dBwlj3DCX0ITxXvCU1Ozjm6CKpsRVWXKFpc0BGMT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcORkT2bGmyniSKApM9hJyURz0Kz0AU3s4PxKxsFDbRjObJ5i8
	9EBKKFiVeBLBcrGn9QHKwLrBW/d3q8wg3JrH82JOpi3pNZwO7ys0nb8n1Bj9NLQ=
X-Gm-Gg: ASbGncsTuugui7LITj4aaiaXEuigGZ8yv9c/13d0czd3GmUoRQuowaLMKQ2SSs8baN3
	WC6/8uW95/uU8y7+5dMGAz0R4Bhl+G9Y45kBgudWJGdnYTIsu3nLt3VSx/NDp3W6v7Gzld0/LA5
	V+pmVzkB8+TG0scDRWHHejr2AaXDrWyEP8fvKqmoFB5imVMcTr1eWSojsF/baCDsGr62BM+pGUd
	4wsuO/QTNkhL7ItSFte0Ho1V07y865l4Xk0IQnMVbCVTvFFnhe1cvU1f4niSbKpZ4bA70MVfwao
	laVZklMcs7Xc
X-Google-Smtp-Source: AGHT+IE7wRuuRmej8hhyu+zKEcDBltvxR/ENpI81tucKM6kppqP1lK7UzFy4zWjDIy3hqW9iB5GiZA==
X-Received: by 2002:a05:6000:1541:b0:382:4145:d3a9 with SMTP id ffacd0b85a97d-38260b69577mr5767591f8f.25.1732408058879;
        Sat, 23 Nov 2024 16:27:38 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:bc8e:433b:87c2:d22e? ([2001:67c:2fbc:1:bc8e:433b:87c2:d22e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafe207sm6493996f8f.36.2024.11.23.16.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 16:27:37 -0800 (PST)
Message-ID: <df0e2597-1f7b-4a72-b607-ab2cbd03c79b@openvpn.net>
Date: Sun, 24 Nov 2024 01:28:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 15/23] ovpn: implement keepalive mechanism
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-15-de4698c73a25@openvpn.net> <ZypfnyfToF1b6YAZ@hog>
 <189dbeea-127a-47e8-84f8-c8cf1cc03536@openvpn.net>
 <5eaf74fb-ad13-4371-95b8-7a5f1f3a9cda@openvpn.net> <Z0CuvYH_ZZMYtDcW@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z0CuvYH_ZZMYtDcW@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/11/2024 17:18, Sabrina Dubroca wrote:
> 2024-11-22, 10:41:26 +0100, Antonio Quartulli wrote:
>> On 12/11/2024 14:20, Antonio Quartulli wrote:
>> [...]
>>>>> +static int ovpn_peer_del_nolock(struct ovpn_peer *peer,
>>>>> +                enum ovpn_del_peer_reason reason)
>>>>> +{
>>>>> +    switch (peer->ovpn->mode) {
>>>>> +    case OVPN_MODE_MP:
>>>>
>>>> I think it would be nice to add
>>>>
>>>>       lockdep_assert_held(&peer->ovpn->peers->lock);
>>
>> Sabrina, in other places I have used the sparse notation __must_hold()
>> instead.
>> Is there any preference in regards to lockdep vs sparse?
>>
>> I could switch them all to lockdep_assert_held if needed.
> 
> __must_hold has the advantage of being checked at compile time (though
> I'm not sure it's that reliable [1]), so you don't need to run a test
> that actually hits that particular code path.
> 
> In this case I see lockdep_assert_held as mainly documenting that the
> locking that makes ovpn_peer_del_nolock safe (as safe as
> ovpn_peer_del) is provided by its caller. The splat for incorrect use
> on debug kernels is a bonus. Sprinkling lockdep_assert_held all over
> ovpn might be bloating the code too much, but I'm not opposed to
> adding them if it helps.
> 
> [1] I ran sparse on drivers/net/ovpn/peer.c before/after removing the
> locking from ovpn_peer_del and didn't get any warnings. sparse is good
> to detect imbalances (function that locks without unlocking), but
> maybe don't trust __must_hold for more than documenting expectations.

Same here. I didn't expect that.
Then I think it's better to rely on lockdep_assert_held() for this kind 
of assumptions.

> 
> [note: if you end up merging ovpn->peers->lock with ovpn->lock as
> we've discussed somewhere else, the locking around keepalive and
> ovpn_peer_del becomes a bit less hairy]

Yeah, this is happening.

Thanks a lot!

Regards,

> 

-- 
Antonio Quartulli
OpenVPN Inc.


