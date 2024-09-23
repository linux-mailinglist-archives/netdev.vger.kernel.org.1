Return-Path: <netdev+bounces-129299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A89CE97EBF1
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 15:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8761C210CD
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FC519994A;
	Mon, 23 Sep 2024 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Uf67V8iE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157711991B9
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096344; cv=none; b=TvyhvJxMZ+TP1tNQMvgnaSpcMm2Brqf0tvBfePd1lEvcyYMaL4+dqCyaa3Ry2bkvxBA7NxmUU+1wCMlcDJvdZ3uCRXjxUP/jAum53HsrrNjXyjOC7VkXhYUZMUdRYkLGbV/Bmpvb6aJN2NIfEXkpSsNbpcBgFNHbALDrJ/B5QGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096344; c=relaxed/simple;
	bh=SAhHOfzGyIVxU8mMW7++ySvJuLOW1MucLvgu51lkGPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpRMEPeKSI/HBVZJp0HP0IAP/U0MkoMqxXUnlTZx6U6M73Kt+aTNQPc/OuPoIQ/KdF0GeoH6yb6os5JaEIuzgdfOkw7KdxWVNOXVDF1a4/z3eaQZmaUrGmyE9qeSUVNG+AdXf2jKQfCSvS9vXsuQdATEMa0dFgJg2CXrAn9uLMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Uf67V8iE; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so531379866b.2
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 05:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727096340; x=1727701140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HzEzhd7e6ZdsJsnbA26A5UtQSPsTfdYHINhrCdLhobw=;
        b=Uf67V8iEXpkYmXpPmenHavGJ2eBO1ZG+jwt14/D0IMXJIZOQWg81VbFSwbrLXROnsp
         CjcFLCEOgImFcNYgVZk+FkMH8Fc8gR1EFRpuQhoEZLcZIBQ4YQ/0AIXIJEDLrxt6bbwB
         nAsVhYU/o7+aeeUkm44qsSjMo4g6JCjWyrY9+M+7J76ACPJnxVmIsM68Q5IaXq4sfqOH
         +0udVF+kEaPt+Ppk7sZPDcKU6LP/VvWJf7s9KVfIkrH6zoAhYaZ99AInzfy5vEkHj5pP
         19PeEOYtVKvzRmnofU+qwZBNFdOtcGkJHzpzXfv5YH5MAZejlT5/ZFgfxYyP3XecMrAG
         jihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727096340; x=1727701140;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzEzhd7e6ZdsJsnbA26A5UtQSPsTfdYHINhrCdLhobw=;
        b=cty8/GvCuckH+z95ZWSXqjP1fsjF0AAfFby75yZqjXB4kXDgp48pzpoNClWvvhJcYb
         seXz2p4iUI+SeTILYBOeeIivGRaHm5KOyPdVzng2TsL6VDI1aHbgwlIC3s3FChcz9pSd
         j0vvCQnErs1bRsLdk2KtzI3XUG8gtuIRJbTItihYROsGOTP30EUc9S85p/TeTZ7NCkgA
         AzVXWyv3oU458oeR9PO6fg/Wx/0mBViwfG07roYEk2zRasXicErXEdzT1A4Luam3GcRN
         uxdpemBN/m08r8D4jkewGoJR18bVs423Ygs1XqriSSIvSifUofXz/JtCvnhvSa9yIhkU
         pyJA==
X-Gm-Message-State: AOJu0YwGWrxu4XLVT3lavl/cSXM8OWTNdgOVP6m5nQiMpEmDnaQJZKQo
	fZj85PLwFHmrAYzNmQwHRo8utzn/7PRCznKghzoJ/amCFg7d3zuQBjT+pqKERts=
X-Google-Smtp-Source: AGHT+IEQTmcFzv6LuVmCf3vLEuBPLlQ26j+s3YooaUbQwnN3mGJRXu90Bl5v2csQTa+7uGYhYQTyrQ==
X-Received: by 2002:a17:907:9482:b0:a91:1699:c694 with SMTP id a640c23a62f3a-a911699cca3mr38257966b.2.1727096340317;
        Mon, 23 Sep 2024 05:59:00 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:8a3e:77dd:5f67:bbfc? ([2001:67c:2fbc:1:8a3e:77dd:5f67:bbfc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90bce77c68sm670697266b.66.2024.09.23.05.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 05:58:59 -0700 (PDT)
Message-ID: <e45ed911-8e48-4fac-9b56-d39471b0d631@openvpn.net>
Date: Mon, 23 Sep 2024 14:59:02 +0200
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
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <70952b00-ec86-4317-8a6d-c73e884d119f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/09/2024 01:20, Sergey Ryazanov wrote:
> On 17.09.2024 04:07, Antonio Quartulli wrote:
>> +    -
>> +      name: set-peer
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Add or modify a remote peer
> 
> As Donald already mentioned, the typical approach to manage objects via 
> Netlink is to provide an interface with four commands: New, Set, Get, 
> Del. Here, peer created implicitely using the "set" comand. Out of 
> curiosity, what the reason to create peers in the such way?

To be honest, I just wanted to keep the API as concise as possible and 
having ADD and SET looked like duplicating methods, from a conceptual 
perspective.

What userspace wants is "ensure we have a peer with ID X and these 
attributes". If this ID was already known is not extremely important.

I can understand in other contexts knowing if an object already exists 
can be crucial.

> 
> Is the reason to create keys also implicitly same?

basically yes: userspace tells kernelspace "this is what I have 
configured in my slots - make sure to have the same"
(this statement also goes back to the other reply I have sent regarding 
changing the KEY APIs)

Cheers,

> 
>> +      do:
>> +        pre: ovpn-nl-pre-doit
>> +        post: ovpn-nl-post-doit
>> +        request:
>> +          attributes:
>> +            - ifindex
>> +            - peer
>> +    -
>> +      name: get-peer
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Retrieve data about existing remote peers (or a specific one)
>> +      do:
>> +        pre: ovpn-nl-pre-doit
>> +        post: ovpn-nl-post-doit
>> +        request:
>> +          attributes:
>> +            - ifindex
>> +            - peer
>> +        reply:
>> +          attributes:
>> +            - peer
>> +      dump:
>> +        request:
>> +          attributes:
>> +            - ifindex
>> +        reply:
>> +          attributes:
>> +            - peer
>> +    -
>> +      name: del-peer
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Delete existing remote peer
>> +      do:
>> +        pre: ovpn-nl-pre-doit
>> +        post: ovpn-nl-post-doit
>> +        request:
>> +          attributes:
>> +            - ifindex
>> +            - peer
>> +    -
>> +      name: set-key
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Add or modify a cipher key for a specific peer
>> +      do:
>> +        pre: ovpn-nl-pre-doit
>> +        post: ovpn-nl-post-doit
>> +        request:
>> +          attributes:
>> +            - ifindex
>> +            - peer
>> +    -
>> +      name: swap-keys
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Swap primary and secondary session keys for a specific peer
>> +      do:
>> +        pre: ovpn-nl-pre-doit
>> +        post: ovpn-nl-post-doit
>> +        request:
>> +          attributes:
>> +            - ifindex
>> +            - peer
>> +    -
>> +      name: del-key
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Delete cipher key for a specific peer
>> +      do:
>> +        pre: ovpn-nl-pre-doit
>> +        post: ovpn-nl-post-doit
>> +        request:
>> +          attributes:
>> +            - ifindex
>> +            - peer
>> +
> 
> -- 
> Sergey
> 

-- 
Antonio Quartulli
OpenVPN Inc.

