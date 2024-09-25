Return-Path: <netdev+bounces-129633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8579984F3D
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 02:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8342F285533
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 00:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37674BA4D;
	Wed, 25 Sep 2024 00:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="IwHUF9tP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAABA92D
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222467; cv=none; b=eFnk8tu4qQ5ue4wDO1d1CZprR+PkT9X2hC+EekZ2+ymMd+fA7k0pWoS0ndV/JiI5gFv3WNaQg16cjjdR4IuBV2YDDsIdI6V/XZwGB5r53zjp8m3ggzQ6jFRsOwU/NtdMRnwelMd4i2jLQs88I+vTPo0YaDNTRwanhEZeyvZd3Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222467; c=relaxed/simple;
	bh=T672pX/mPSGyJ/70VoBS/GGt4M3iQ6+XvR0nZrx1fRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcZfegA3z6QDs7XynF88hdIHabDOaFXrcErQe5McjQK2GrU5vh/g3m5a4t/wY+OddvddL0SM5yCtDknb/1WNHvKPtQNTzH29dm55tk7zeeCACY6AzAWvgvDJRdgEKAxVhXn17E4M2qieKXhCTfocfW5mJBlOtBT2bXXhtohaabE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=IwHUF9tP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374c84dcc90so3704300f8f.1
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 17:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727222462; x=1727827262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tHYP5VIkvKcg9HclmhtHLZNWk50hI1qg5V3IK5KlLeo=;
        b=IwHUF9tP1W3SYjQY79ODzHP5CMr3BDRyl0KjCQ2RxPn+j/6jWqSCzxgCW9lBjmw2p3
         NDXZzl2k+hgIEia5IgLFP5FmtrogGzCC1eGl++hAru5P25tAs9Jm+q03wbXnTBPrlSaB
         nRsD3GMk11xIFR4f9My1FAhK3p9xvCN7KUznhffVosw9/Lw4G/687L5Y5TQj99Fqmdn5
         U99uImbRT23mpI7kRIFAvPK12QN6TFSyOLjdWWN6DKPdeoQMe2U7jr05Vs+aPFlnJ9pr
         OeZpWifxU0F6trRLPPSxWh0CQYf/USbt4b+ozddtIJCE8Is/jL9LKbcbmITvuTOXMcn7
         m4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727222462; x=1727827262;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHYP5VIkvKcg9HclmhtHLZNWk50hI1qg5V3IK5KlLeo=;
        b=qfoKCrKLt8XxkW8D161LYCWuUerROfFABVZIqhkz9+qjj/JTz9wErxew3R2knVbXbc
         Wgbt//coSVsx3T32aa0zyJyOwc7w2RifqNvtAdUUGhM2ZlnJ7AvbWc3MSKyHCSwSuYix
         c/D1JoNYh6lo0Np6x5Vd1Wkj6OJ6ceou+Yk2SgrV8KboJCI3Bulhg0rPWirx/MRGWAau
         EemepaA3T2Q5tga302JL+jg2hY1vEVrGO2+pmwSRC/wnDseZoazE64tRKqCPvbxT+zI9
         i/isHynAMWLLSUMxBilrXrobXHuIyv2y6Gs+RbP48cjSzodSxb2eQ9qRVENT2Tw6pUlh
         d+wA==
X-Gm-Message-State: AOJu0Yzyh/AyFFqKq5+fGOmpzI0gVWQ8zwCxw4Gb4wdWUGaDAqkdDUB4
	cR7HW52nCfgGDNQQztEz0+Ist03g6+0beP4oGnwTx5YOutF0PuX3eOs4bMGjWwU=
X-Google-Smtp-Source: AGHT+IHsyhgzwNG1Uh5Jw1CytrOD25e72NzpmWmaXL2N1zkTTB5T/dWjYM8IRhxlh+SbPCd/shRT+A==
X-Received: by 2002:a5d:568c:0:b0:374:c2e9:28ad with SMTP id ffacd0b85a97d-37cc2461b64mr704123f8f.1.1727222462331;
        Tue, 24 Sep 2024 17:01:02 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:e5c:af75:5ff3:1644? ([2001:67c:2fbc:1:e5c:af75:5ff3:1644])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc31873csm2584419f8f.93.2024.09.24.17.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 17:01:00 -0700 (PDT)
Message-ID: <cca86695-54ae-4784-a76b-c8c38031f79d@openvpn.net>
Date: Wed, 25 Sep 2024 02:01:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 04/25] ovpn: add basic netlink support
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew@lunn.ch, sd@queasysnail.net,
 donald.hunter@gmail.com
References: <20240917010734.1905-1-antonio@openvpn.net>
 <20240917010734.1905-5-antonio@openvpn.net>
 <70952b00-ec86-4317-8a6d-c73e884d119f@gmail.com>
 <e45ed911-8e48-4fac-9b56-d39471b0d631@openvpn.net>
 <20c73bae-0c79-4a8a-af60-6dbc6a88e953@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20c73bae-0c79-4a8a-af60-6dbc6a88e953@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/09/2024 00:10, Sergey Ryazanov wrote:
> Hi Antonio,
> 
> On 23.09.2024 15:59, Antonio Quartulli wrote:
>> On 23/09/2024 01:20, Sergey Ryazanov wrote:
>>> On 17.09.2024 04:07, Antonio Quartulli wrote:
>>>> +    -
>>>> +      name: set-peer
>>>> +      attribute-set: ovpn
>>>> +      flags: [ admin-perm ]
>>>> +      doc: Add or modify a remote peer
>>>
>>> As Donald already mentioned, the typical approach to manage objects 
>>> via Netlink is to provide an interface with four commands: New, Set, 
>>> Get, Del. Here, peer created implicitely using the "set" comand. Out 
>>> of curiosity, what the reason to create peers in the such way?
>>
>> To be honest, I just wanted to keep the API as concise as possible and 
>> having ADD and SET looked like duplicating methods, from a conceptual 
>> perspective.
> 
> Could you elaborate, what is wrong with separated NEW and SET method 
> conceptually?

I don't think it is wrong, I think it's just a matter of preference.
In the ovpn context SET and NEW would kinda do the same thing, except 
that NEW should be called for a non existing peer-id, while SET needs it 
to exist.

Given the above, I just preferred to have one op only and avoid possible 
confusion.

> 
>  From the implementation point of view I can see that both methods can 
> setup a same set of object properties. What can be resolved using a 
> shared (between NEW and SET) peer configuration method.
> 
>> What userspace wants is "ensure we have a peer with ID X and these 
>> attributes". If this ID was already known is not extremely important.
>>
>> I can understand in other contexts knowing if an object already exists 
>> can be crucial.
> 
> Looks like you want a "self synchronizing" API that automatically 
> recovers synchronization between userspace and kernel.

Consider that userspace and kernelspace must always be in sync, 
therefore keeping it easy allows to avoid desynchronization.

> 
> On one hand this approach can mask potential bug. E.g. management 
> application assumes that a peer was not configured and trying to 
> configure it and kernel quietly reconfigure earlier known peer. Shall we 
> in that case loudly inform everyone that something already went wrong?

I get your point, but I am not sure this can truly happen, since 
userspace will always issue a DEL_PEER if it believes the peer is 
gone/should go.

Assuming this can really be the case, the solution would either be to 
self-destroy everything or to try deleting and re-adding the peer.
That's what the SET would already achieve.
After all, the goal of SET is truly to tell ovpn to mirror what usespace 
knows about a certain peer-id.

> 
> On another hand, I see that current implementation does not do this. The 
> SET method handler works differently depending on prior peer existence. 
> The SET method will not allow an existing peer reconfiguration since it 
> will trigger error due to inability to update "VPN" IPv4/IPv6 address. 
> So looks like we have two different methods merged into the single 
> function with complex behaviour.

This is a leftover that I am going to change in v8.
I will use hlist_nulls to happily rehash peers upon IP change.
This is a must do because we'll want to support client IP change at runtime.

> 
> BTW, if you want an option to recreate a peer, did you consider the 
> NLM_F_REPLACE flag support in the NEW method?

you mean supporting NLM_F_REPLACE in SET_PEER and returning -EEXIST if 
peer-id is known and the flag was not passed?

I am not sure it'd be truly helpful.
I am pretty sure userspace will just end up passing that flag all the 
time :-D "just to be safe, since it doesn't break anything"

Cheers,

> 
>>> Is the reason to create keys also implicitly same?
>>
>> basically yes: userspace tells kernelspace "this is what I have 
>> configured in my slots - make sure to have the same"
>> (this statement also goes back to the other reply I have sent 
>> regarding changing the KEY APIs)
> 
> If we save the current conception of slots, then yes it make sense.
> 
>>>> +      do:
>>>> +        pre: ovpn-nl-pre-doit
>>>> +        post: ovpn-nl-post-doit
>>>> +        request:
>>>> +          attributes:
>>>> +            - ifindex
>>>> +            - peer
>>>> +    -
>>>> +      name: get-peer
>>>> +      attribute-set: ovpn
>>>> +      flags: [ admin-perm ]
>>>> +      doc: Retrieve data about existing remote peers (or a specific 
>>>> one)
>>>> +      do:
>>>> +        pre: ovpn-nl-pre-doit
>>>> +        post: ovpn-nl-post-doit
>>>> +        request:
>>>> +          attributes:
>>>> +            - ifindex
>>>> +            - peer
>>>> +        reply:
>>>> +          attributes:
>>>> +            - peer
>>>> +      dump:
>>>> +        request:
>>>> +          attributes:
>>>> +            - ifindex
>>>> +        reply:
>>>> +          attributes:
>>>> +            - peer
>>>> +    -
>>>> +      name: del-peer
>>>> +      attribute-set: ovpn
>>>> +      flags: [ admin-perm ]
>>>> +      doc: Delete existing remote peer
>>>> +      do:
>>>> +        pre: ovpn-nl-pre-doit
>>>> +        post: ovpn-nl-post-doit
>>>> +        request:
>>>> +          attributes:
>>>> +            - ifindex
>>>> +            - peer
>>>> +    -
>>>> +      name: set-key
>>>> +      attribute-set: ovpn
>>>> +      flags: [ admin-perm ]
>>>> +      doc: Add or modify a cipher key for a specific peer
>>>> +      do:
>>>> +        pre: ovpn-nl-pre-doit
>>>> +        post: ovpn-nl-post-doit
>>>> +        request:
>>>> +          attributes:
>>>> +            - ifindex
>>>> +            - peer
>>>> +    -
>>>> +      name: swap-keys
>>>> +      attribute-set: ovpn
>>>> +      flags: [ admin-perm ]
>>>> +      doc: Swap primary and secondary session keys for a specific peer
>>>> +      do:
>>>> +        pre: ovpn-nl-pre-doit
>>>> +        post: ovpn-nl-post-doit
>>>> +        request:
>>>> +          attributes:
>>>> +            - ifindex
>>>> +            - peer
>>>> +    -
>>>> +      name: del-key
>>>> +      attribute-set: ovpn
>>>> +      flags: [ admin-perm ]
>>>> +      doc: Delete cipher key for a specific peer
>>>> +      do:
>>>> +        pre: ovpn-nl-pre-doit
>>>> +        post: ovpn-nl-post-doit
>>>> +        request:
>>>> +          attributes:
>>>> +            - ifindex
>>>> +            - peer
>>>> +
> 
> -- 
> Sergey

-- 
Antonio Quartulli
OpenVPN Inc.

