Return-Path: <netdev+bounces-94433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AB68BF73F
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6AB1C22902
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 07:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE80E3D96A;
	Wed,  8 May 2024 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="VbcGnmAM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779073B7A0
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154097; cv=none; b=aIl8mhxxsrZnB1gRgrDZMRUbYNls646S4MB9wvkY2LjRDUy95fSYnHPjK/h0EFRIxQ1euCy62wtL1bAjaSK8WANuQpISaM55pvLsPWQV+o64MuFMHuZEApfN6MJmxoljlCr3YF5adZOuMVAdcd/aOQPpL1DB3cnGJsH4h5CXecY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154097; c=relaxed/simple;
	bh=cQENho5bjzVXZo8DG+sXh/y29+SVb+DUWBQebImxI/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDPa34Tch1O+3amk7O8FtNoyXwXXx7yXnmEN+6nNsxeA9EXNgoYyLuKSFISbM73M6byszaw2IyQPEAlJQZ/67eoQNjsopy/BS4FZ92yF//2oTwJDoHh5IoGYQg3bDp/t37TZnYRja+bqJ0CoK4YuSqSm9MHY7yeXHHXgdnFFXAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=VbcGnmAM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso821153966b.2
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 00:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715154094; x=1715758894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yL658NzvZlNgLAceLAw1n0pqniv/Csn4CCchrckgnTY=;
        b=VbcGnmAMcenCSLoaw7n7VJ7JdCeq4mJyPv8K7ldyZv721AHV7BfUrS4cxiCjQZKYar
         1CbKhDrkdzZjRbjbs7Asb1TE80fPVQkFGzCgadH/CWZ5IjQfpxanBgPjONXwdSn+9Xux
         TNSYWjBfh49VUVrNJlODQnnVfKiPPl+uTCHJPtXATn5/bP+cGZEPy2DvMCaA9LU6PNod
         trA2bm/2lc9jZqH1wARIA2RwBcAUgzgPnjo94z1DhooV9Ignt8r3wWJVFvCz/s+ZUB0Y
         ePuYUqCY9sm/29WJOjRzR3sC+KmmHCvmRxJWYglS7u/JyzoMdN5Y5R9gh8lahkHvXlEA
         XRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154094; x=1715758894;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL658NzvZlNgLAceLAw1n0pqniv/Csn4CCchrckgnTY=;
        b=W9c93Eh/IoGbEpIN3Vg2gV2Y+MN0HWOqn1bUP9+kAVtFkr9GiwZ3FixHNFn7mqEWN8
         dFRZ6VXsjzCLyIkb3akQbUH+Wqulni4D9jwftTZYFSkT7O48tnn/GiIh9y7XTEtzHpMN
         dvWAc4ust5kP971mrbMubE7TfalkY4nVv/Zc3cqWzKRUPcNWSC8B0OZKl9xESX/vRTej
         uQAkb9LhNQgY3DiITqTw8NdLDmh7SuOmoPBm35Iqb5rpDVFm0789akldLv1QEuMunI8+
         6Tvt8ojxpb6E2zeboxUgkiMRG9vnJ6Ig51SXAgewXVVwe9c1egVydh0T6JYU4U33aG6p
         artg==
X-Gm-Message-State: AOJu0YyX6Epaf80D0tpIkbWQxR+NqZUc/WQJoVdVqELY2+2QZ8oVsCL4
	WAR3/9AkszLSolZzkMQlypgVij3qqNNAUx69WQ3wVB9jD/GJ4TmFbRSHCl3Uyv4=
X-Google-Smtp-Source: AGHT+IEIrJM1oDw3UkUc6wqsVt4+DYEceXuTi9ZlmjnTaZf0CVqSUkFBXVLAAMt6zNcEM6orpMg9lg==
X-Received: by 2002:a17:906:54c7:b0:a59:9edf:14b6 with SMTP id a640c23a62f3a-a59fb9699ccmr111195866b.45.1715154093725;
        Wed, 08 May 2024 00:41:33 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:9ca5:af56:50eb:bcf3? ([2001:67c:2fbc:0:9ca5:af56:50eb:bcf3])
        by smtp.gmail.com with ESMTPSA id g8-20020a1709067c4800b00a59a9cfec7esm5091900ejp.133.2024.05.08.00.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 00:41:33 -0700 (PDT)
Message-ID: <4609f3bf-b79a-412a-9b9c-5fde8b7c4a99@openvpn.net>
Date: Wed, 8 May 2024 09:42:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 03/24] ovpn: add basic netlink support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-4-antonio@openvpn.net>
 <20240507171058.6ec1308b@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240507171058.6ec1308b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/05/2024 02:10, Jakub Kicinski wrote:
> On Mon,  6 May 2024 03:16:16 +0200 Antonio Quartulli wrote:
>> +    name: nonce_tail_size
> 
> nit: typically we hyphenate the names in YAML and C codegen replaces
> the hyphens with underscores (and converts to uppercase)

ACK will go with hyphens.

> 
>> +         exact-len: OVPN_NONCE_TAIL_SIZE
> 
> speaking of which - is the codegen buggy or this can be nonce_tail_size?
> (or rather nonce-tail-size)

yeah, something was wrong.
I used 'nonce_tail_size' at first, but it did not get converted, 
therefore I hardcoded the final define name.

 From what you say this seems to be unexpected.
Will check what the script does.

> 
>> +      -
>> +        name: pad
>> +        type: pad
> 
> You shouldn't need this, now that we have uint.
> replace nla_put_u64_64bit() with nla_put_uint().

ACK

> Unfortunately libnl hasn't caught up so you may need to open code
> the getter a little in user space CLI.

ok, no big deal.

> 
> BTW I'd also bump the packet counters to uint.
> Doesn't cost much if they don't grow > 32b and you never know..

Ok, will do

> 
>> +        request:
>> +          attributes:
>> +            - ifname
>> +            - mode
>> +        reply:
>> +          attributes:
>> +            - ifname
> 
> The attribute lists
> 
>> +	struct net_device *dev;
>> +	int ifindex;
>> +
>> +	if (!attrs[OVPN_A_IFINDEX])
> 
> GENL_REQ_ATTR_CHECK()

ACK, I must have missed this one.

> 
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	ifindex = nla_get_u32(attrs[OVPN_A_IFINDEX]);
>> +
>> +	dev = dev_get_by_index(net, ifindex);
>> +	if (!dev)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	if (!ovpn_dev_is_valid(dev))
>> +		goto err_put_dev;
>> +
>> +	return dev;
>> +
>> +err_put_dev:
>> +	dev_put(dev);
> 
> NL_SET_BAD_ATTR(info->extack, ...[OVPN_A_IFINDEX])

Oh, thanks for pointing this out.

> 
>> +	return ERR_PTR(-EINVAL);

-- 
Antonio Quartulli
OpenVPN Inc.

