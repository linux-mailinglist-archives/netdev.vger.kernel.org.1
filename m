Return-Path: <netdev+bounces-129214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D897E40E
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 00:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E501C20C41
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 22:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E90F74063;
	Sun, 22 Sep 2024 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HK2KGgtg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D779BA27
	for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727043860; cv=none; b=WVMKE1MSFZ+CCyYkvskSwHdw6LsEWuCployrbFuJdQ3HernLrghM3bPvfCuBeorWG/EuLaBP4RdGjzremGFLofSwv7aUuOEeu7FZIhnjPqGHDTF+DYnNeLq7ImKMKGs8XgC3494jG9nN/YV9K9u6FumLGdDgtpecgePqVN5rb74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727043860; c=relaxed/simple;
	bh=3U2iMJndTOUXN068tQELfCE09th6zQydQ0ESnvkdj7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjItR3TS9qDZ5eSicO1tkKP098hFTIKIUSgeNTW2g3olXoGCEebEhd+0KBSaFphvKWmT5WIsvO+2keVLGnHic/wPOH+PKJzTNH/f1aeq2ErJDFwLfbwR+HiTinGspVJfrL2ZY7wHEAu56F9IabEzY/Nn9UuBCL1/G005RIlr1qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HK2KGgtg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso23286275e9.0
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 15:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727043857; x=1727648657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Du3hNak9h6BGqgpjqudfrCzAlifwkfHE2sHybutD6Es=;
        b=HK2KGgtgeWLdNgLhf0rl4GdBnQ3mXQShIW75TvGWWo961DfB/Rlu1qV4eKq5G6y/5P
         mGh7rjP4PUi2PG7Z0rXp2kqN6dLjIx0z1VBQ3HV6rEiAkQc1DF7UYS90ESMfEf1UWy9M
         fKV6/jEqsk520xyWE3+3xEAzp210/FG7W2amc0mAcOflEAkPlDvpYr12JortIC6x64bu
         e+4a46vTkZAp+clgCOHxbV6ZxxVrxzvHiEufHhwzL92WnBmu27szC7S2TNORHsM0PnDS
         rWeYB7NrbhhcXb6btkMspN8Iyol1nmHuawmtooQ3M1/75CnWoPHUxyaxMPHvRGRAaeXI
         Ka4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727043857; x=1727648657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Du3hNak9h6BGqgpjqudfrCzAlifwkfHE2sHybutD6Es=;
        b=q+ZcENM3x14qvIiiU3IoXhEDtHq4EvZZMbD5u9viXrCkifp7BY5dA5F3dX3vPOOoHH
         RIvOWoGxX5/xtkRZN301gYmBWXWsl1gp+UoPMRIHEeOGr8q0uNkQQzH7QnZvnCnTradA
         nXB7nfuUMGsuuYtq8zN/FeFcNpsV3x5yoMQwXMT5TkBtARLxXohIl6QpLUCYv6OevdU2
         h9+cwQLorfeVlgJ5bppyzNYJm6gEadnZmgbXnee+paFW/lXVQJlvWi5vGcMAkLEOXe8w
         HC7fa+u54+qIhYQgc8g+ENj8LB/Gfm4wSII3WCruJNnBTmYqTVBh87aY0GVt911tn2te
         CUyQ==
X-Gm-Message-State: AOJu0YwrytzOw6ktqzpjk515rA9cxPiYs9rGaCYa84ilNJtE99eSjVTd
	whBS2DItdrD/raD380gV7lV5+SgaMIwRq8KCNP3bLAvCngWrNQVS
X-Google-Smtp-Source: AGHT+IFo+IWHteaKb47ytpHati03m08mocCqj+kW3jZJivUWd/ziHro7sS4iyg2Xl+7fWJMlrnOL5A==
X-Received: by 2002:a05:600c:154d:b0:42c:b2a2:af3a with SMTP id 5b1f17b1804b1-42e744279b1mr84074365e9.9.1727043856556;
        Sun, 22 Sep 2024 15:24:16 -0700 (PDT)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e8340sm22889870f8f.46.2024.09.22.15.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 15:24:15 -0700 (PDT)
Message-ID: <782b53e2-58ef-47a7-b392-c18d807d3e72@gmail.com>
Date: Mon, 23 Sep 2024 01:24:32 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 04/25] ovpn: add basic netlink support
To: Antonio Quartulli <antonio@openvpn.net>,
 Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew@lunn.ch, sd@queasysnail.net
References: <20240917010734.1905-1-antonio@openvpn.net>
 <20240917010734.1905-5-antonio@openvpn.net> <m2wmjabehc.fsf@gmail.com>
 <99028055-f440-45e8-8fb1-ec4e19e0cafa@openvpn.net> <m2o74lb7hu.fsf@gmail.com>
 <63c452f7-041e-4a28-96ba-c37ea8170dfd@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <63c452f7-041e-4a28-96ba-c37ea8170dfd@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Antonio, Donald,

On 18.09.2024 14:16, Antonio Quartulli wrote:
> On 18/09/2024 12:07, Donald Hunter wrote:
>> Antonio Quartulli <antonio@openvpn.net> writes:
>>>>> +      -
>>>>> +        name: local-ip
>>>>> +        type: binary
>>>>> +        doc: The local IP to be used to send packets to the peer 
>>>>> (UDP only)
>>>>> +        checks:
>>>>> +          max-len: 16
>>>> It might be better to have separate attrs fopr local-ipv4 and
>>>> local-ipv6, to be consistent with vpn-ipv4 / vpn-ipv6
>>>
>>> while it is possible for a peer to be dual stack and have both an 
>>> IPv4 and IPv6 address assigned
>>> to the VPN tunnel, the local transport endpoint can only be one 
>>> (either v4 or v6).
>>> This is why we have only one local_ip.
>>> Does it make sense?
>>
>> I was thinking that the two attributes would be mutually exclusive. You
>> could accept local-ipv4 OR local-ipv6. If both are provided then you can
>> report an extack error.
> 
> Ok then, I'll split the local-ip in two attrs.
> 
> It also gets cleaner as we have an explicit type definition, while right 
> now we infer the type from the data length.
> 
>>
>>>>
>>>>> +      -
>>>>> +        name: keyconf
>>>>> +        type: nest
>>>>> +        doc: Peer specific cipher configuration
>>>>> +        nested-attributes: keyconf
>>>> Perhaps keyconf should just be used as a top-level attribute-set. The
>>>> only attr you'd need to duplicate would be peer-id? There are separate
>>>> ops for setting peers and for key configuration, right?
>>>
>>> This is indeed a good point.
>>> Yes, SET_PEER and SET_KEY are separate ops.
>>>
>>> I could go with SET_PEER only, and let the user specify a keyconf 
>>> within a peer (like now).
>>>
>>> Or I could keep to SET_KEY, but then do as you suggest and move 
>>> KEYCONF to the root level.
>>>
>>> Is there any preferred approach?
>>
>> I liked the separate ops for key management because the sematics are
>> explicit and it is very obvious that there is no op for reading keys. If
>> you also keep keyconf attrs separate from the peer attrs then it would be
>> obvious that the peer ops would never expose any keyconf attrs.
> 
> Ok, will move KEYCONF to the root level and will duplicate the PEER_ID.

Nice idea! A was about to suggest the same. Besides making semantic 
simple, what somehow subjective, it should make parsing way simple. Two 
nested attributes parsing calls will be saved.

--
Sergey

