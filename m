Return-Path: <netdev+bounces-99186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8778D3F6F
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 22:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43532B24813
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 20:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D595F1C8FAF;
	Wed, 29 May 2024 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SgcnHMoZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF361C8FAB
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717013642; cv=none; b=jlXD3FSefZK3trDnCztRHRRRPp6S9DLyqdw3Wq/8GiWFxjM5IHppgTKCm+0i6mBUNHVbySrmHIbVeH8YI6lvvP+6oAcHrQgD/VQ/Dpc8bhjiUDwdkSSU2jJwyBK926KhBnYVmDiyvnMj4hG0phg9ciPqGaeoLJd3I4z7mDmXICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717013642; c=relaxed/simple;
	bh=c7JL/I/graJ+88NBl7jE1by+A2/t12JyNV/q5tOKMxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kh9W2oJmFrlX24qFghPKUtgU/E1TychZz/E2m3V0OEzuNADSl/CInMQ8rqIsXHjx7OLIbUsAnNqJic0rCS7cXKGM+t0ODBNdXjMPXLIxX9hqoOU12vccAwWw3mQb0jJOJva63uvdBfcxOCnbNpJrxXY6yGl8rvtgdJQSx1q2nEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SgcnHMoZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a352bbd9so15715166b.1
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 13:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1717013639; x=1717618439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w4bWnC/Kv0JT6M7iEoT0TCRj85yFx52hi58rCV4nqWM=;
        b=SgcnHMoZ3DjlCg0cEWomUVRbE8JmI9o3Tr/RVCCXtum7iUMeICUS85xflY9H2DYwHQ
         Zn07BR1Lm6dTug2+oRR+WePKsg/M5gKpTm33OdoXaMLUHabec0u0itH75bKnvdylYIzb
         P8SzCZsNjjtCU04k0LdtlSCfLbX30zfk5FmtOvtQWadbvwTwMmOqt/HbGLKkMIhdeaTQ
         RsWf7Mn35SLTSQqt59ik5zFJztiUbvtIrheQxqHW3GCuwSqOnMnBI8NhhtlSp+wGUfcW
         p3PKc5y/wNKWNMjCNaGExSXWRZYL2kFEhAQuLe6hLUfH7Zi+ZqgqL0Ab7E1Q55DwWj1x
         uHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717013639; x=1717618439;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4bWnC/Kv0JT6M7iEoT0TCRj85yFx52hi58rCV4nqWM=;
        b=wBn8IEfMmcn+EQ0h77qksF6mwMGb3Bb4TOHMmI0a8sgJzDNWj/V1eELr2rGoXh/tuq
         rFFByDnzKkPN5FvAImU3vT1sx6zM8lTDGWNe+O/9iTRNaOmsyWd86h4PXxGiQE8o0Ojz
         Ft7XntY5JzU/TJaNJgMlR4lqmv4boORBat4KorkSrQLxloc3CFiCyfA1mzpDzhtB7vCb
         OeT1MpHjE+a+K21YzUm66VvpUyfqFZX6LA2HDZZu7mPNeLSic5CJ224XWyhVwp/IfuP8
         K5Hvcmv2+Fc28EGjZu0t5UJGDgxIkjezjTzWB8Irqftp2Etm8vITZr8OMKUmwsHOfmf2
         P3tA==
X-Gm-Message-State: AOJu0YyCFJlvzKEOe0GKSmJoRkw8aqJa80oWM5zrqEG75hnkA5iNBzIi
	pAR7wAG7lr8F4iXgfxtNg+qiA2xiaC6czRIOALvuXSMZRH6YcTgLqWssF/5KHHg=
X-Google-Smtp-Source: AGHT+IEVrm0SX/N4wdCpIiXmdaj/QShuKjmUiC4CFPngfIZhAXfbJrQ+C1tPPLKkvGF3Y50Nb1/ZhQ==
X-Received: by 2002:a17:906:48d6:b0:a59:cf0d:d7c8 with SMTP id a640c23a62f3a-a642d37e9cfmr275702666b.15.1717013638805;
        Wed, 29 May 2024 13:13:58 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:a2ed:fbea:c7f7:f383? ([2001:67c:2fbc:0:a2ed:fbea:c7f7:f383])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a644f347fd4sm105638966b.212.2024.05.29.13.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 13:13:58 -0700 (PDT)
Message-ID: <8252647b-0301-4f14-bdc7-208e9779fc2f@openvpn.net>
Date: Wed, 29 May 2024 22:15:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 14/24] ovpn: implement multi-peer support
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-15-antonio@openvpn.net> <ZlXtyn2Sgk_W8h92@hog>
 <de937f69-b5ae-4d4f-b16a-e18fa70a8e7b@openvpn.net> <ZldG5PNlvAkJ4fat@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZldG5PNlvAkJ4fat@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/05/2024 17:16, Sabrina Dubroca wrote:
> 2024-05-28, 21:41:15 +0200, Antonio Quartulli wrote:
>> On 28/05/2024 16:44, Sabrina Dubroca wrote:
>>> Hi Antonio, I took a little break but I'm looking at your patches
>>> again now.
>>
>> Thanks Sabrina! Meanwhile I have been working on all your suggested changes.
>> Right now I am familiarizing with the strparser.
> 
> Cool :)
> 
>>> 2024-05-06, 03:16:27 +0200, Antonio Quartulli wrote:
>>>> +	index = ovpn_peer_index(ovpn->peers.by_id, &peer->id, sizeof(peer->id));
>>>> +	hlist_add_head_rcu(&peer->hash_entry_id, &ovpn->peers.by_id[index]);
>>>> +
>>>> +	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
>>>> +		index = ovpn_peer_index(ovpn->peers.by_vpn_addr,
>>>> +					&peer->vpn_addrs.ipv4,
>>>> +					sizeof(peer->vpn_addrs.ipv4));
>>>> +		hlist_add_head_rcu(&peer->hash_entry_addr4,
>>>> +				   &ovpn->peers.by_vpn_addr[index]);
>>>> +	}
>>>> +
>>>> +	hlist_del_init_rcu(&peer->hash_entry_addr6);
>>>
>>> Why are hash_entry_transp_addr and hash_entry_addr6 getting a
>>> hlist_del_init_rcu() call, but not hash_entry_id and hash_entry_addr4?
>>
>> I think not calling del_init_rcu on hash_entry_addr4 was a mistake.
>>
>> Calling del_init_rcu on addr4, addr6 and transp_addr is needed to put them
>> in a known state in case they are not hashed.
> 
> hlist_del_init_rcu does nothing if node is not already on a list.

Mh you're right. I must have got confused for some reason.
Those del_init_rcu can go then.

> 
>> While hash_entry_id always goes through hlist_add_head_rcu, therefore
>> del_init_rcu is useless (to my understanding).
> 
> I'm probably missing something about how this all fits together. In
> patch 19, I see ovpn_nl_set_peer_doit can re-add a peer that is
> already added (but I'm not sure why, since you don't allow changing
> the addresses, so it won't actually be re-hashed).

Actually it's not a "re-add", but the intent is to "update" a peer that 
already exists. However, some fields are forbidden from being updated, 
like the address.

[NOTE: I found some issue with the "peer update" logic in 
ovpn_nl_set_peer_doit and it's being changed a bit]

> 
> I don't think doing a 2nd add of the same element to peers.by_id (or
> any of the other hashtables) is correct, so I'd say you need
> hlist_del_init_rcu for all of them.

This is exactly the bug I mentioned above: we should not go through the 
add again. Ideally we should just update the fields and be done with it, 
without re-hashing the object.

I hope it makes sense.

Cheers,

> 

-- 
Antonio Quartulli
OpenVPN Inc.

