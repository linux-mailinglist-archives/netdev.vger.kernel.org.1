Return-Path: <netdev+bounces-144080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDCE9C5870
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB3A5B24C67
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 12:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE99B1F7795;
	Tue, 12 Nov 2024 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dIs8MaFu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ADB2309AA
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731414745; cv=none; b=Q2P4o07D/thzVQmcGcY5h3zKHIae3E/qxsx6RryK3a+1J/oxyiv8XUQ8vsehBxqynvx3PP/WXXxWvllxb9CDZkDHWYr8MlfpRbQP8xAfcpLfhVrwzYbZ6U2MpqzrhyKjVVF6crUgCbJLgVBDaGdwOIfzWghM3rGgzmXmBCBtI9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731414745; c=relaxed/simple;
	bh=2ExIiMEoIVsusLk6+aOr+Ea+OBKoExWdnHGIJbdXKFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFDDyLWzoUtntLDN3HMPEs35BRAxSxwypcSu8LbxaLbF1zzOQ1S/iM0r7mlMMD7oCLAA9viFftMEn2qEFNe2y3SvYPm2nWe8ry10Bm2drvYPfBTIbRiPi4ZZ2uoVLZoBJUjUBeTM5JHTPQ2YNiC0i/ld63c7ZboXP1xRx0aBR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dIs8MaFu; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53c73f01284so6848516e87.0
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 04:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731414742; x=1732019542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8mN/9jLDEEeojmQl31wzMN9jzJ1OIuvDrwKoT9iOXns=;
        b=dIs8MaFuKQtCb9wfh8v4BM4T+4NgOVSsqozqpXPQ2ycki2I/P3EKAMKJbCNs8LWWkZ
         6/1J7o4gYVbQtlkEs38w/edHfp/5SunTA0IgVs8pEQjnAjjwzZf7dezkS49HKKY5J3+n
         dwChv7rFv28ja6A1605YrJn3Jqtl2VOOYkq2WoigCRwU4I9VluWNUFL1xEC3IPnP+Ggv
         M19rD25s62A/9bwMH+UFwg0BAC1bQLn7a4SsyS1+n2gUIqvlqliNBFBY/fJKOuJsQw+z
         zlGHws7EmmdNbO6G9vr/kh4ko0GJ31ezaaCYJpM8bIATL1+XW4kz3P2MwgM69nm9px2C
         nsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731414742; x=1732019542;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mN/9jLDEEeojmQl31wzMN9jzJ1OIuvDrwKoT9iOXns=;
        b=gI+uAfDMlXjRPPzgXcCCuK230TLieV8+ZeGVPXYG77DgFw+sWybcwqJ7m6/eBC9HkQ
         g2pLzhljR35lS0qkSNwVsu8arcFyS+uFClxwEW8KaK3G30WmuK1D1I5Bzshu9KyT84OC
         q/UznCN3BiEomysyk40T2JK/WkV2tcz+9hHt73u6PUFmcp/Wh7ZD6vezZbvrhSaqIaDU
         Xpnbz+nd8UHowahr8Ee/KvpyabGdRYzw0d0bCTFHK6ZamNIY16tzxNLJDgOquCr8nmup
         MKX95XB2b9mxUTKTsQGP9+XzAQHNsFtBiwQcKayPrq99OMLprq/6XOR85JBiP1sH22Il
         aISQ==
X-Forwarded-Encrypted: i=1; AJvYcCXATSljRH8GRvtJslk8iUs4XrwiYTAC+5cuKFql2QvvC8wBYnvHDjNKklUP/Wu1aRqDHHCtdi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBh8zFDbcDU3bpP0gjMY2JGFkw7kfGnqM3KJ79LZNFYkRUM8YQ
	ZFW01c/qgnf17amyTjO57kMOWuA/SksICVTi1g+tT41YZduwJkQr1hzMOqNI8s4=
X-Google-Smtp-Source: AGHT+IFMNwasfmiLl+Z9KOviColnfocGmaijKon2fqUAscqOXZuAu8ZEgK7JfUz/X8ViRyTrfePqIw==
X-Received: by 2002:a05:6512:3053:b0:539:8a7d:9fbf with SMTP id 2adb3069b0e04-53d862be452mr8213078e87.46.1731414741594;
        Tue, 12 Nov 2024 04:32:21 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:e829:c484:5241:93b2? ([2001:67c:2fbc:1:e829:c484:5241:93b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa523a0esm239919655e9.0.2024.11.12.04.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 04:32:21 -0800 (PST)
Message-ID: <52960609-2d3a-4e75-a31d-6643a0411435@openvpn.net>
Date: Tue, 12 Nov 2024 13:32:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 14/23] ovpn: implement peer lookup logic
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-14-de4698c73a25@openvpn.net> <ZyivdrpZhx4WpMbn@hog>
 <77c2a569-6f6c-41d2-ad85-2b0d71e9bae4@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <77c2a569-6f6c-41d2-ad85-2b0d71e9bae4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/2024 02:18, Sergey Ryazanov wrote:
> On 04.11.2024 13:26, Sabrina Dubroca wrote:
>> 2024-10-29, 11:47:27 +0100, Antonio Quartulli wrote:
>>>   struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct 
>>> *ovpn,
>>>                              struct sk_buff *skb)
>>>   {
>>> -    struct ovpn_peer *peer = NULL;
>>> +    struct ovpn_peer *tmp, *peer = NULL;
>>>       struct sockaddr_storage ss = { 0 };
>>> +    struct hlist_nulls_head *nhead;
>>> +    struct hlist_nulls_node *ntmp;
>>> +    size_t sa_len;
>>>       if (unlikely(!ovpn_peer_skb_to_sockaddr(skb, &ss)))
>>>           return NULL;
>>>       if (ovpn->mode == OVPN_MODE_P2P)
>>> -        peer = ovpn_peer_get_by_transp_addr_p2p(ovpn, &ss);
>>> +        return ovpn_peer_get_by_transp_addr_p2p(ovpn, &ss);
>>> +
>>> +    switch (ss.ss_family) {
>>> +    case AF_INET:
>>> +        sa_len = sizeof(struct sockaddr_in);
>>> +        break;
>>> +    case AF_INET6:
>>> +        sa_len = sizeof(struct sockaddr_in6);
>>> +        break;
>>> +    default:
>>> +        return NULL;
>>> +    }
>>
>> You could get rid of that switch by having ovpn_peer_skb_to_sockaddr
>> also set sa_len (or return 0/the size).

Yeah, makes sense. Thanks!

>>
>>> +
>>> +    nhead = ovpn_get_hash_head(ovpn->peers->by_transp_addr, &ss, 
>>> sa_len);
>>> +
>>> +    rcu_read_lock();
>>> +    hlist_nulls_for_each_entry_rcu(tmp, ntmp, nhead,
>>> +                       hash_entry_transp_addr) {
>>
>> I think that's missing the retry in case we ended up in the wrong
>> bucket due to a peer rehash?

Oh, for some reason I convinced myself that this is handled behind the 
scene, but indeed the lookup must be explicitly restarted.

will fix it, thanks for pointing this out!


> 
> Nice catch! I am also wondering why the 'nulls' variant was selected, 
> but there are no nulls value verification with the search respin.
> 
> Since we started discussing the list API, why the 'nulls' variant is 
> used for address hash tables and the normal variant is used for the 
> peer-id lookup?

Because the nulls variant is used only for tables where a re-hash can 
happen.

The peer-id table does not expect its objected to be re-used or 
re-hashed since the ID of a peer cannot change throughout its lifetime.


Regards,


> 
>>
>>> +        if (!ovpn_peer_transp_match(tmp, &ss))
>>> +            continue;
>>> +
>>> +        if (!ovpn_peer_hold(tmp))
>>> +            continue;
>>> +
>>> +        peer = tmp;
>>> +        break;
>>> +    }
>>> +    rcu_read_unlock();
>>>       return peer;
>>>   }
> 
> -- 
> Sergey
> 

-- 
Antonio Quartulli
OpenVPN Inc.


