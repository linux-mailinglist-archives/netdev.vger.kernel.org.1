Return-Path: <netdev+bounces-128785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE1F97BB72
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 13:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F83282752
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 11:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2714D45008;
	Wed, 18 Sep 2024 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Q8L0eW2G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97380291E
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726658213; cv=none; b=i0ioa17nehiKApRUvbzGqyS9c6hoE68SVxreBSidan+AAL1KgQMa6o5ct95JV8CSUMTEl/p3Plc/n4azgB58+uD3TgI2oq0iO+ZoUDv1ToQUhvPqxvv2If7U/2F4Q38Fyl0JJxqQSCB9PKsOnzjMPU64r71JRgRa6FEnLmyJWk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726658213; c=relaxed/simple;
	bh=Ar0p74stLEqGBZItQhKzF3YeYdpbbmzAjmCMWH8xsfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yu22EjKDWeT2VcLOv3DmpVJjljYFTDirVvn5QXuP9yzaGsFoAr8ld65YsxfFRyk78L+IHLWkEkeMDcgtehbtA6bZIbRLjWv1OFIQkGOmcX1BjtVCl0BlKig2aWeEuamNeay7EQ4ck/x1gXX+6rpjy2PkAT3UzHGbBA/VTlLyfw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Q8L0eW2G; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374c326c638so3173720f8f.2
        for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 04:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726658209; x=1727263009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uHzsEAytpCFVDykaHao+BcGaLu0CLhlTBqKdn+BFXZY=;
        b=Q8L0eW2GF6dc+6p2GeIKQJSIbLL+IzjNZLEDfp1o6aZU6bqAhWGOn7m0hE0ZzS/mCD
         5wMbuxKd359T/BgsYUcs/KQBZrYcBKZDWLn3RVTCOpdWP7AJVGGatez9CONTu+qmF5qp
         vJGJCVg9ae4Cwz/s+iQH2n2EA045DuyWteA4nW9xBuvnmxl+iXNe/HH13YiO9cMjDGUJ
         ztOoeZ/L+pW4/W9zBjDxkmKZg23lklIOr5SkcWsdhrwOCpo8eB3lw7eDZ5/Hwh+VMW3Q
         N66nI4nPJMMSUEjFAH8jsrqufqWJ+Mz2ifUkh29uWvqKYoTfYq3ZObRWFTdtv3sYScFs
         /FZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726658209; x=1727263009;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHzsEAytpCFVDykaHao+BcGaLu0CLhlTBqKdn+BFXZY=;
        b=VxJDAIxmq7lUg0UA3JK5D2kuSSVNgos4n5ocK+hJvAVgH2zt/tVPr9uiP3apO5eMPI
         YbxUYKZcZksc8YhFk3lutkUAzTJlD7QoUDdH99+y9jnzFTcv/W6NRdcnE83WTglUCPVg
         EQb9eHFwukIgthq/oPPQ4D0vdiJngp5BAn10zv7r5p7d/IbkOIzbqbC7Wp5XoZdbAYMB
         dM6nT16RLNw2hTXBAxShIY8eFe3/jjdd8+j3O7TDl4fsomI/LfqvLH6dGPxxSKtSN0Cr
         KG4VuhY8jBjZ+etR3/5voxRQws1du2W1/VcBiscZBmu8SodxW2UFW7L0OxijuAyTu13G
         0igA==
X-Gm-Message-State: AOJu0YwoTO28wyZkv266zfR/ELci+vU/O+uIghdwMVUEwTHpUhRE4tMp
	IZYwR9fM0VGRfEal+cAkuhLX3emqqNDduV956G5xA3Q58RyhH6j/vJ5/yGUO3xY=
X-Google-Smtp-Source: AGHT+IHcKukK+fPJhtqv9tEqp+TbQXQx98UsdTlXzU2gH7ghflpBggfb6N4QdLcMARuHchqMyu1zSg==
X-Received: by 2002:a05:6000:1049:b0:378:c887:5874 with SMTP id ffacd0b85a97d-378d625b559mr10142232f8f.59.1726658208542;
        Wed, 18 Sep 2024 04:16:48 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:d8e0:71ee:e68e:3ac7? ([2001:67c:2fbc:1:d8e0:71ee:e68e:3ac7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7805193sm11957596f8f.98.2024.09.18.04.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 04:16:48 -0700 (PDT)
Message-ID: <63c452f7-041e-4a28-96ba-c37ea8170dfd@openvpn.net>
Date: Wed, 18 Sep 2024 13:16:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 04/25] ovpn: add basic netlink support
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch,
 sd@queasysnail.net
References: <20240917010734.1905-1-antonio@openvpn.net>
 <20240917010734.1905-5-antonio@openvpn.net> <m2wmjabehc.fsf@gmail.com>
 <99028055-f440-45e8-8fb1-ec4e19e0cafa@openvpn.net> <m2o74lb7hu.fsf@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <m2o74lb7hu.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/09/2024 12:07, Donald Hunter wrote:
> Antonio Quartulli <antonio@openvpn.net> writes:
>>>> +      -
>>>> +        name: local-ip
>>>> +        type: binary
>>>> +        doc: The local IP to be used to send packets to the peer (UDP only)
>>>> +        checks:
>>>> +          max-len: 16
>>> It might be better to have separate attrs fopr local-ipv4 and
>>> local-ipv6, to be consistent with vpn-ipv4 / vpn-ipv6
>>
>> while it is possible for a peer to be dual stack and have both an IPv4 and IPv6 address assigned
>> to the VPN tunnel, the local transport endpoint can only be one (either v4 or v6).
>> This is why we have only one local_ip.
>> Does it make sense?
> 
> I was thinking that the two attributes would be mutually exclusive. You
> could accept local-ipv4 OR local-ipv6. If both are provided then you can
> report an extack error.

Ok then, I'll split the local-ip in two attrs.

It also gets cleaner as we have an explicit type definition, while right 
now we infer the type from the data length.

> 
>>>
>>>> +      -
>>>> +        name: keyconf
>>>> +        type: nest
>>>> +        doc: Peer specific cipher configuration
>>>> +        nested-attributes: keyconf
>>> Perhaps keyconf should just be used as a top-level attribute-set. The
>>> only attr you'd need to duplicate would be peer-id? There are separate
>>> ops for setting peers and for key configuration, right?
>>
>> This is indeed a good point.
>> Yes, SET_PEER and SET_KEY are separate ops.
>>
>> I could go with SET_PEER only, and let the user specify a keyconf within a peer (like now).
>>
>> Or I could keep to SET_KEY, but then do as you suggest and move KEYCONF to the root level.
>>
>> Is there any preferred approach?
> 
> I liked the separate ops for key management because the sematics are
> explicit and it is very obvious that there is no op for reading keys. If
> you also keep keyconf attrs separate from the peer attrs then it would be
> obvious that the peer ops would never expose any keyconf attrs.

Ok, will move KEYCONF to the root level and will duplicate the PEER_ID.

> 
>>>
>>>> +    -
>>>> +      name: del-peer
>>>> +      attribute-set: ovpn
>>>> +      flags: [ admin-perm ]
>>>> +      doc: Delete existing remote peer
>>>> +      do:
>>>> +        pre: ovpn-nl-pre-doit
>>>> +        post: ovpn-nl-post-doit
>>>> +        request:
>>>> +          attributes:
>>>> +            - ifindex
>>>> +            - peer
>>> I think you need to add an op for 'del-peer-notify' to specify the
>>> notification, not reuse the 'del-peer' command.
>>
>> my idea was to use CMD_DEL_PEER and then send back a very very short PEER object.
>> I took inspiration from nl80211 that sends CMD_NEW_STATION and CMD_DEL_STATION when a wifi host
>> connects or disconnect. In that case the full STATION object is also delivered (maybe I should
>> do the same?)
>>
>> Or is there some other technical reason for not reusing CMD_DEL_PEER?
> 
> nl80211 is maybe not a good example to follow because it predates the
> ynl specs and code generation. The netdev.yaml spec is a good example of
> a modern genetlink spec. It specifies ops for 'dev-add-ntf' and
> 'dev-del-ntf' that both reuse the definition from 'dev-get' with the
> 'notify: dev-get' attribute:
> 
>      -
>        name: dev-get
>        doc: Get / dump information about a netdev.
>        attribute-set: dev
>        do:
>          request:
>            attributes:
>              - ifindex
>          reply: &dev-all
>            attributes:
>              - ifindex
>              - xdp-features
>              - xdp-zc-max-segs
>              - xdp-rx-metadata-features
>              - xsk-features
>        dump:
>          reply: *dev-all
>      -
>        name: dev-add-ntf
>        doc: Notification about device appearing.
>        notify: dev-get
>        mcgrp: mgmt
>      -
>        name: dev-del-ntf
>        doc: Notification about device disappearing.
>        notify: dev-get
>        mcgrp: mgmt
> 
> The notify ops get distinct ids so they should never be confused with
> normal command responses.

Interesting. I will do the same then.

> 
>>>
>>>> +    -
>>>> +      name: set-key
>>>> +      attribute-set: ovpn
>>>> +      flags: [ admin-perm ]
>>>> +      doc: Add or modify a cipher key for a specific peer
>>>> +      do:
>>>> +        pre: ovpn-nl-pre-doit
>>>> +        post: ovpn-nl-post-doit
>>>> +        request:
>>>> +          attributes:
>>>> +            - ifindex
>>>> +            - peer
>>>> +    -
>>>> +      name: swap-keys
>>>> +      attribute-set: ovpn
>>>> +      flags: [ admin-perm ]
>>>> +      doc: Swap primary and secondary session keys for a specific peer
>>>> +      do:
>>>> +        pre: ovpn-nl-pre-doit
>>>> +        post: ovpn-nl-post-doit
>>>> +        request:
>>>> +          attributes:
>>>> +            - ifindex
>>>> +            - peer
>>> Same for swap-keys notifications.
>>
>> Yeah, here I can understand. My rationale was: tell userspace that now we truly need a
>> SWAP_KEYS. Do you think this can create problems/confusion?
> 
> Right, so this is a notification to user space that it is time to swap
> keys, not that a swap-keys operation has happened?

Correct. It is delivered when the current key cannot be used anymore and 
we need userspace to inject a new one.

> If the payload is
> unique to this notification then you should probably use the 'event' op
> format. For example:
> 
>      -
>        name: swap-keys-ntf
>        doc: Notify user space that a swap-keys op is due.
>        attribute-set: ovpn
>        event:
>          attributes:
>            - ifindex
>            - peer
>        mcgrp: peers

make sense. Will create the new op.
Since we're moving the KEYCONF to the root level, we can just send that 
instead of the PEER.

> 
>>>
>>>> +    -
>>>> +      name: del-key
>>>> +      attribute-set: ovpn
>>>> +      flags: [ admin-perm ]
>>>> +      doc: Delete cipher key for a specific peer
>>>> +      do:
>>>> +        pre: ovpn-nl-pre-doit
>>>> +        post: ovpn-nl-post-doit
>>>> +        request:
>>>> +          attributes:
>>>> +            - ifindex
>>>> +            - peer
>>>> +
>>>> +mcast-groups:
>>>> +  list:
>>>> +    -
>>>> +      name: peers

Thanks!

-- 
Antonio Quartulli
OpenVPN Inc.

