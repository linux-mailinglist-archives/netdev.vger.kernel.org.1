Return-Path: <netdev+bounces-148541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 686BC9E289E
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D0C7B83AB9
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA781F76B1;
	Tue,  3 Dec 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="UAfQXi/z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0A11F7566
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237862; cv=none; b=juahkv5wtwWNtyjfA4surKG69zNWN2FCWXORXqPJvThujYu5EWpz2lvpE86UigFK08ShJB1t1gCwmmspIEivLW7RnaknvuAXdMhfuwTMIaIxLmVK68Kea0JWivJUumVcjs6MA+Ldlpp2xyAy1tShxkBJKbG/pXMWadKbBC7JE7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237862; c=relaxed/simple;
	bh=4kaDNuHUFD4chxpEZLuFV8m6+PpKHOu1IP0wRoeVpSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2Gf8EndT4EBUXaoJZIHD0okgT5smv3ypc8mujpjuH70U6FZv5TN7KZfvu2aEgOdaRq1ffAX63QXKH/jh82SsodLXwQb402+abkh7i1VYRCH+vCGI8NKIv/pO1Jx1m8SLQc0M8rILPE59FjydAsU89hjXM9XaXU0cdFYKX48YNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=UAfQXi/z; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a68480164so761374166b.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 06:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733237859; x=1733842659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EM5pCjC2cWoCVnQEQZytwK6ACL0xMoDExcO8DX1QkKw=;
        b=UAfQXi/zZtGdKrNigsY0mda+9yTzSBbyxqygMFDmTq+9u2mCjeF/iK2X6NWC2n5rfC
         gyzVf/DRF2F5Tw07tedg0eq+kdVWzNuduTKbqNlJafQUbR5hdq8h83g6sMZBxDhTWtSU
         TOtqLMxWLKfHMT1s7NzZanuCnlNZ37TP1VFgetmw6F025Wjk3qoqR0VAwfAgfUOVfdhB
         4Hpn7hNs9wHtWnPS9vDfAyXkgZkbYzPEMk9MQ/1W+nnJowVg/NsqD7bnEfn2wG0hC37w
         Wu/YZcOBexPsQwQ20Pr0y5zmhd/KPegjTc+SszT9fi9Jhq/+fqoddQKuNsHCVm3vmRhY
         vhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237859; x=1733842659;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EM5pCjC2cWoCVnQEQZytwK6ACL0xMoDExcO8DX1QkKw=;
        b=Uq6o3xLadSz2upoP4K8M67mIQGVZf9BHgoLA0Qy2IaOg+htaZ+LWmYNz2tm2/rx/9+
         chBkG6yps7CtN0BaybcdbHfRjiYK/ivhNOP6w7KNo0UcUxQiuq2kVBR3XsvghKf7ZjF9
         Gp7SHXiYhpCUibvznhYWIP331yUIP07Ye4ex8aqbr4QV3z4Qxsu2MFA14SeTzpry2CW2
         7gahoSPeeCDKSkPHqbgRupay9JPYiyPGS6SFYM1x2IALs4aM9MNfl1xNC7jpMQDv5QAt
         LQRFFvnv+vZQ1l3xEDt871pNp/Iykn3gEtXn/O1n0pwJjGug2aKXrN+N7VGkOPcODcJ8
         yQsg==
X-Forwarded-Encrypted: i=1; AJvYcCVnhLLa1TL6xD93L0fjYr+wd3vgYmhWrCNrdGZ62NO5uqUPe9UsLR8ieBmEKUEZ4Muldj05YhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCK/Xme6az6dqoGheyJFB94hYWhWpATjlt8NzVfXqNj07C8niA
	VmXb+96GF9CrteYGwlGmgR4IM9+yIVrHzFv1Me5YiJEAqJNqz0naoFrq5EV/XMo=
X-Gm-Gg: ASbGncsyw66pBT7mOr/I5AG8av6nm+xZCZ8BGRFtjyrCXpAujpHSYpPd/KMpXTlL7sc
	817H5zK4j7rmIn8xQS3pYmFgOw5KrMa/xeZ41J13+zxqHZqWKGjtpetdDB4VXSP2yxGPx3ukSyT
	aVFPbGGOWIv0zMv8wYeFXCW8KGQ6nL+j+twO4ek0Ak7xxmn3vh0hgYdDB8k155yS0U6/bucpFGv
	DNdZlI73xuERSWeP0v4O7I82ACDKCxYSfisjDcrW9MDHDe6/iLfCSQsNuuYLb8ZAWoTvY4WEba1
	5wf3kPWbGdYk
X-Google-Smtp-Source: AGHT+IFm3HTymLpkzHDlJwTdEhqSNPjIwD18EjPQJ7jfnb/TpAAhZxzdIq/8jT2SyS2gFyft4tUmMA==
X-Received: by 2002:a17:906:23ea:b0:a99:5466:2556 with SMTP id a640c23a62f3a-aa5f7f6e957mr195026266b.61.1733237859165;
        Tue, 03 Dec 2024 06:57:39 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:138c:c1e3:75bf:72b5? ([2001:67c:2fbc:1:138c:c1e3:75bf:72b5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c13e7sm617609566b.18.2024.12.03.06.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 06:57:38 -0800 (PST)
Message-ID: <5052453b-edd8-44e2-8df7-00ea439805ad@openvpn.net>
Date: Tue, 3 Dec 2024 15:58:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 13/22] ovpn: implement peer lookup logic
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 sd@queasysnail.net, ryazanov.s.a@gmail.com
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-13-239ff733bf97@openvpn.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20241202-b4-ovpn-v12-13-239ff733bf97@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/12/2024 16:07, Antonio Quartulli wrote:
[...]
> +#define ovpn_get_hash_slot(_key, _key_len, _tbl) ({	\
> +	typeof(_tbl) *__tbl = &(_tbl);			\
> +	jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl);	\
> +})
> +
> +#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
> +	typeof(_tbl) *__tbl = &(_tbl);				\
> +	&(*__tbl)[ovpn_get_hash_slot(_key, _key_len, *__tbl)];	\
> +})

clang a reporting various warnings like this:

../drivers/net/ovpn/peer.c:406:9: warning: variable '__tbl' is 
uninitialized when used within its own initialization [-Wuninitialized]
   406 |         head = ovpn_get_hash_head(ovpn->peers->by_id, &peer_id,
       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   407 |                                   sizeof(peer_id));
       |                                   ~~~~~~~~~~~~~~~~
../drivers/net/ovpn/peer.c:179:48: note: expanded from macro 
'ovpn_get_hash_head'
   179 |         &(*__tbl)[ovpn_get_hash_slot(_key, _key_len, *__tbl)];  \
       |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
../drivers/net/ovpn/peer.c:173:26: note: expanded from macro 
'ovpn_get_hash_slot'
   173 |         typeof(_tbl) *__tbl = &(_tbl);                  \
       |                       ~~~~~     ^~~~

Anybody willing to help me understand this issue?

I have troubles figuring out how __tbl is being used uninitialized.
I wonder if the parameters naming is fooling clang (or me) somehow.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


