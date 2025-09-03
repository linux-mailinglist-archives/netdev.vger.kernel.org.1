Return-Path: <netdev+bounces-219417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6345B412C7
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 05:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C963AB76E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 03:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A9E27FB2D;
	Wed,  3 Sep 2025 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZPHHFCb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F9B1E8323
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756869015; cv=none; b=ADqyMfwYT0CRUzsw17LCjH8XpIzCFCrCzL+ISVRDKP4tPhUgTQ/sSNKFAvTZUetnOZ3u/Yan9x+4Y6wYoWkChz5pmoEdvzMkchva6K/Ui0HcsZLCWbOB1i5tfJ7yHlbt4WhUHMMAQ/DNK6NOfh4hSZkytG5a1+aaE2MZ5WTbZas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756869015; c=relaxed/simple;
	bh=tGJTaJK9eqhmyb3g2A9wsTh3MdU/zqHRIcdBgFNYQ0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1uvJ781NZAG9iY2Jsj8841opxOB2rq/9+bmK0fm+DIAAKNU/EMl8kdYjvDXR+OZ8sRVktpcN5pf6rPy2fgwhWE9QwdOs7tF47zMNBTTu0HkwTuHsWpCZ+6EOkAObLV9Pr3vA4B/puGy4qSXqWcCzhXueHJ3bjKuC0nynqCVxhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZPHHFCb; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70dfcc589a6so58375546d6.2
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 20:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756869011; x=1757473811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFdPW3e89bGHcqsjJzX70taV8oQEa3XC7VCmKZu/qWA=;
        b=JZPHHFCb+98xkkFPKK3sJaxSFGvCX6lN+4UPPK7AY/oNTZ0wRoamuwGDprGLkADUYF
         dgfpnciM5kRdmh8akJQZDeu3yv0PEEd59kje7GaR9SsqthXINihHhLxR3K6f+NDeSClz
         qm1AKiIMSfWJD3OZZZBwEz9YIZJGjKJnH8o+L01SSJNBQtB+1dZKr2IWWlRH+99+QzXy
         z09w9EnKsw5VpgAOh3VNNeWQS+NuCw9RwS9CUZPLIsogZRstBN5W/pfePlzYqpVfDHwz
         vIWRLF83+O8bvXk4S84ZkUMzi7uSFipY25rq0OQCCkdt+AlOwvq9Nakao/PhceuEEEKE
         +rQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756869011; x=1757473811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFdPW3e89bGHcqsjJzX70taV8oQEa3XC7VCmKZu/qWA=;
        b=oxdY6+zAi7qXpsFVlc/q7oWYb2cSFNaw4A0PT0qcA8rMS+A3MC860iEO5WH27stNyb
         tYBSx6ZUCZG1YsTlEWhMmIHf8Dd2du0wuSlaZm6hNXApp2SCfW6zbNDoLKseJXdkXl0Z
         u0th4GZrexwjSGUi9MtM/Fm5GV6k50SSglDk/ikAKzB0DdCMOXrQjSbEXw60Lp2Q1258
         WJGXbK13t8AhVt6Sre7dAUZnD9vWVwLp8kHEzXWFnR+GR5qH4epJONxMa6UXMebaXAUH
         /YjbqnkVqKZ/FGwHdAVY43rFzGDgjoWZWgPO4ParVc/1TqWq7evWpRzRvXNc3Y7lmmLr
         7vWw==
X-Forwarded-Encrypted: i=1; AJvYcCUz9Mtml4rTRIhEEaxdhUAfh9pmcNsddNzFmpSNjax4moMUHEvr5Up9GApB0a5Yw172+TdZstI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0YHzjGcZG079Q1Kge519VEkAVrrcmFNI89MzRj/oGRkFqfGxB
	wzZQlIMsWGop/SjgUeJZpG+igQ60wQF0Tv5Kosym90blm/HKg+3JXFY2
X-Gm-Gg: ASbGncu31LqtEWYA6ll1k1hzZOtbLIwyImO/80E+OgDbRqZxvJbnjPlO58oWw7h9i9e
	mJi4Qae9Mdg233+o83K7gaHXgzyIIFNhAxFUsaGJzSejFoDlU+R3IB5o/9ejoZgoRJCD1CQGHU9
	8r/wQjS8fX71BtbcAOF5ORF2X/n5KWGV5/d5M7rjZOuc38Vd6mThjEqQAhTs8IyE64xJxNzyC6L
	YeqbPPeFxkIfewqVgDG7F7adZEI6axeTxn12DjLZtJHHd/ZsJ5Lw+HLpbz9bu2tJSIM+4Hmm6HH
	lqqXPyowNs56+uxFV0F3qUO1nQWsAie9X6QoDtWJo0wwU2RMZqhDzwB5EqaRt1GkyKcZy6dDSus
	30I78BYsWte+ICwhS1Ed8N1xsmn5jpxkeHsjR
X-Google-Smtp-Source: AGHT+IGYQr+qEaDKDarGH6olTAaEmljU6nK6CvMjxGz8Nx2tfzw4Y+jw2YFey1YdO7uTEChV/5q0bg==
X-Received: by 2002:a05:6214:1310:b0:70d:b315:beb5 with SMTP id 6a1803df08f44-70fac6fff3cmr168156086d6.14.1756869011511;
        Tue, 02 Sep 2025 20:10:11 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:11c1::11a5? ([2620:10d:c091:400::5:693b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b46660e5sm22161486d6.45.2025.09.02.20.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 20:10:10 -0700 (PDT)
Message-ID: <7ad2677d-06c9-4bfc-8801-66379005f72e@gmail.com>
Date: Tue, 2 Sep 2025 23:10:09 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 17/19] psp: provide decapsulation and receive
 helper for drivers
To: Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
 <20250828162953.2707727-18-daniel.zahka@gmail.com>
 <ba4e41ef-2d68-495d-8450-8f27e3d0b8e7@redhat.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <ba4e41ef-2d68-495d-8450-8f27e3d0b8e7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/2/25 6:28 AM, Paolo Abeni wrote:
> On 8/28/25 6:29 PM, Daniel Zahka wrote:
>> +/* Receive handler for PSP packets.
>> + *
>> + * Presently it accepts only already-authenticated packets and does not
>> + * support optional fields, such as virtualization cookies.
>> + */
>> +int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
>> +{
>> +	const struct psphdr *psph;
>> +	int depth = 0, end_depth;
>> +	struct psp_skb_ext *pse;
>> +	struct ipv6hdr *ipv6h;
>> +	struct ethhdr *eth;
>> +	int encap_bytes;
>> +	__be16 proto;
>> +
>> +	eth = (struct ethhdr *)(skb->data);
>> +	proto = __vlan_get_protocol(skb, eth->h_proto, &depth);
>> +	if (proto != htons(ETH_P_IPV6))
>> +		return -EINVAL;
>> +
>> +	ipv6h = (struct ipv6hdr *)(skb->data + depth);
>> +	depth += sizeof(*ipv6h);
>> +	end_depth = depth + sizeof(struct udphdr) + sizeof(struct psphdr);
> Why aren't you checking the next hdr being UDP? This could potentially
> match unrelated packets.

This assumes the caller knows the packet is psp transport mode packet, 
which I think could be a reasonable API given that all psp 
implementations probably involve parsing packets in hw. I will update 
this patch to properly support IPv4, though.

>
> Also I guess you need pskb_may_pull() above.

we check for: end_depth > skb_headlen(skb). If you prefer 
pskb_may_pull(), I can change it.

