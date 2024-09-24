Return-Path: <netdev+bounces-129625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0BD984D6A
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 00:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8761C2094B
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 22:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540D913D89D;
	Tue, 24 Sep 2024 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1TwkJIW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E1E6E614
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215833; cv=none; b=FCKuCQuCmlfmgZdYa0fouJnKtRt7T/WBTLE4QhWUNvnIwUciB2kdKGTgQM0C1atJHlz71vkW93pBJE9Z4Ol5fRb8o3tCCuoZxGgPXEWg/5LSK4S2xOhdciMO1LhubIUkKRpnLGc9J+KIkrxJVQV2gO5bum1JKGrnXj1OBvPi50g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215833; c=relaxed/simple;
	bh=OCeuJkBJ5HkMjBG8VsX5Rzg/FLiFvtZfMxaWBS9eF8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYwUu+R4Q4UU1JYsZJFT91h/zAVpst0xPa9TRmJt+P9RTBtSQp29dyyC6BzQ7XM+jzCqBA/5ZWZ5nFyX7/rwbyevchBngzSRAlFsNe+jQgIik895yVXbOEOWrID5I47tisAgvs6xjOPPVdaFc2uaZkgVtZKEzEaQfV2DXmdOGx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1TwkJIW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so60044235e9.3
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 15:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727215829; x=1727820629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0WHTm4Q1RgD9bg5lzukVPigQpOM69dfNMzxWRlwJRhI=;
        b=K1TwkJIWWU7tDEH+c0vKDvmnfVIQdTsuBF05jYn7TCLcKQKnS72VQRSj+1D1MD1kEf
         hpoMtMDyMnYA/Pvc7bjyh5vOSvBgsfT6tvFCiVfQ5+tWunZEVpyb364YSD9noMKuoa5W
         bJrYBClUebkkdjd5Y7MNV25gQQDj1AFQ88NyQsu4SB4/m7JxOGm4sg2UVRV81Lnm6rAo
         /a/KOvIonJ4avgccSbJM+XofwLcrxjBAUMx7CiYlqumInDsTmpt7p+waHkHS5dVetmLA
         KlkChX6kb+nG7UG/mMzRbVohQzi/oqPecwMtC9d15uIen6HnGwP8caYQ6O+hZnIjhjgD
         QgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727215829; x=1727820629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WHTm4Q1RgD9bg5lzukVPigQpOM69dfNMzxWRlwJRhI=;
        b=F00ilCIfS1gXmNM/lQ97t+blcnMnIZEqCMo0Hbx7y8zS7AxhXVs52kclW4MkOlVM7p
         hEjhSKud+uXcQ+rcWigqLnVKqHYg0EEc3qJsDdYrDmGqaVROg2BAIiqbySFnCcesJAZd
         OQO4mcB0j1D4bugAyb0RLUjF9jYYqgxZBze/Mmq4TBDSbPcv3pzJz6Gl0t2FGR9HA2yp
         qFSDHQYzSZ9S8FRj/o5ULe6ZkmcRrym9j3Hqi6hUuWTOCb0URjqvTZJTCoUbz5/emNae
         FefOwHOTmWIE29YXpmibV7CWbw3XLeK2QzGAeLBPkStGxdYUzGi86A0FxT1KTomrs6/m
         eSsQ==
X-Gm-Message-State: AOJu0YzQZLTpUr562RNPXbKDX1JyXpBn8DiKvMay+gaVObkc3nUx7CMF
	ES2G6f9/NLVEF2NHAoMuozvJUtul2F44QbbzFwvLswgpBX7Gj+dZ
X-Google-Smtp-Source: AGHT+IHUrIcmTZaiQFGNlk5kgX+5dRkG1FqkUIOCMVGcI3UjIwfOSBpCSlQUs9WVKwwPIR0vmaQ9nA==
X-Received: by 2002:a05:600c:45cf:b0:42c:c4c8:7090 with SMTP id 5b1f17b1804b1-42e9610b567mr3177635e9.9.1727215829200;
        Tue, 24 Sep 2024 15:10:29 -0700 (PDT)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a1697dsm627625e9.38.2024.09.24.15.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 15:10:27 -0700 (PDT)
Message-ID: <20c73bae-0c79-4a8a-af60-6dbc6a88e953@gmail.com>
Date: Wed, 25 Sep 2024 01:10:46 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 04/25] ovpn: add basic netlink support
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew@lunn.ch, sd@queasysnail.net,
 donald.hunter@gmail.com
References: <20240917010734.1905-1-antonio@openvpn.net>
 <20240917010734.1905-5-antonio@openvpn.net>
 <70952b00-ec86-4317-8a6d-c73e884d119f@gmail.com>
 <e45ed911-8e48-4fac-9b56-d39471b0d631@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <e45ed911-8e48-4fac-9b56-d39471b0d631@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Antonio,

On 23.09.2024 15:59, Antonio Quartulli wrote:
> On 23/09/2024 01:20, Sergey Ryazanov wrote:
>> On 17.09.2024 04:07, Antonio Quartulli wrote:
>>> +    -
>>> +      name: set-peer
>>> +      attribute-set: ovpn
>>> +      flags: [ admin-perm ]
>>> +      doc: Add or modify a remote peer
>>
>> As Donald already mentioned, the typical approach to manage objects 
>> via Netlink is to provide an interface with four commands: New, Set, 
>> Get, Del. Here, peer created implicitely using the "set" comand. Out 
>> of curiosity, what the reason to create peers in the such way?
> 
> To be honest, I just wanted to keep the API as concise as possible and 
> having ADD and SET looked like duplicating methods, from a conceptual 
> perspective.

Could you elaborate, what is wrong with separated NEW and SET method 
conceptually?

 From the implementation point of view I can see that both methods can 
setup a same set of object properties. What can be resolved using a 
shared (between NEW and SET) peer configuration method.

> What userspace wants is "ensure we have a peer with ID X and these 
> attributes". If this ID was already known is not extremely important.
> 
> I can understand in other contexts knowing if an object already exists 
> can be crucial.

Looks like you want a "self synchronizing" API that automatically 
recovers synchronization between userspace and kernel.

On one hand this approach can mask potential bug. E.g. management 
application assumes that a peer was not configured and trying to 
configure it and kernel quietly reconfigure earlier known peer. Shall we 
in that case loudly inform everyone that something already went wrong?

On another hand, I see that current implementation does not do this. The 
SET method handler works differently depending on prior peer existence. 
The SET method will not allow an existing peer reconfiguration since it 
will trigger error due to inability to update "VPN" IPv4/IPv6 address. 
So looks like we have two different methods merged into the single 
function with complex behaviour.

BTW, if you want an option to recreate a peer, did you consider the 
NLM_F_REPLACE flag support in the NEW method?

>> Is the reason to create keys also implicitly same?
> 
> basically yes: userspace tells kernelspace "this is what I have 
> configured in my slots - make sure to have the same"
> (this statement also goes back to the other reply I have sent regarding 
> changing the KEY APIs)

If we save the current conception of slots, then yes it make sense.

>>> +      do:
>>> +        pre: ovpn-nl-pre-doit
>>> +        post: ovpn-nl-post-doit
>>> +        request:
>>> +          attributes:
>>> +            - ifindex
>>> +            - peer
>>> +    -
>>> +      name: get-peer
>>> +      attribute-set: ovpn
>>> +      flags: [ admin-perm ]
>>> +      doc: Retrieve data about existing remote peers (or a specific 
>>> one)
>>> +      do:
>>> +        pre: ovpn-nl-pre-doit
>>> +        post: ovpn-nl-post-doit
>>> +        request:
>>> +          attributes:
>>> +            - ifindex
>>> +            - peer
>>> +        reply:
>>> +          attributes:
>>> +            - peer
>>> +      dump:
>>> +        request:
>>> +          attributes:
>>> +            - ifindex
>>> +        reply:
>>> +          attributes:
>>> +            - peer
>>> +    -
>>> +      name: del-peer
>>> +      attribute-set: ovpn
>>> +      flags: [ admin-perm ]
>>> +      doc: Delete existing remote peer
>>> +      do:
>>> +        pre: ovpn-nl-pre-doit
>>> +        post: ovpn-nl-post-doit
>>> +        request:
>>> +          attributes:
>>> +            - ifindex
>>> +            - peer
>>> +    -
>>> +      name: set-key
>>> +      attribute-set: ovpn
>>> +      flags: [ admin-perm ]
>>> +      doc: Add or modify a cipher key for a specific peer
>>> +      do:
>>> +        pre: ovpn-nl-pre-doit
>>> +        post: ovpn-nl-post-doit
>>> +        request:
>>> +          attributes:
>>> +            - ifindex
>>> +            - peer
>>> +    -
>>> +      name: swap-keys
>>> +      attribute-set: ovpn
>>> +      flags: [ admin-perm ]
>>> +      doc: Swap primary and secondary session keys for a specific peer
>>> +      do:
>>> +        pre: ovpn-nl-pre-doit
>>> +        post: ovpn-nl-post-doit
>>> +        request:
>>> +          attributes:
>>> +            - ifindex
>>> +            - peer
>>> +    -
>>> +      name: del-key
>>> +      attribute-set: ovpn
>>> +      flags: [ admin-perm ]
>>> +      doc: Delete cipher key for a specific peer
>>> +      do:
>>> +        pre: ovpn-nl-pre-doit
>>> +        post: ovpn-nl-post-doit
>>> +        request:
>>> +          attributes:
>>> +            - ifindex
>>> +            - peer
>>> +

--
Sergey

