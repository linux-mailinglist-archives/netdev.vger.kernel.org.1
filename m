Return-Path: <netdev+bounces-146729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683189D54E0
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 22:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCA4DB20F24
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 21:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C975146A6B;
	Thu, 21 Nov 2024 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="AthdK+Dk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0C83CDA
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 21:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225388; cv=none; b=LdaeAgR6W35K+HO45FXS6upTcx9cP6qlC8+cxBkH54hzWIgFNnjU3YYaiIax9Uc5CTEM4D/98yvGFu2pBCya6M4q+mf65itpvYSClJqLCjO3vdKhjGPHpiJvKorEPB8JjW/oN8gPmCn9X0JG43Zov6AOoJciMdGaxYFrWiJ3z2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225388; c=relaxed/simple;
	bh=mQYYxnFi3u4gaMD9AWB8bbQ5zsRgpStVc/p285S6Uek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ih+tau1PwlXbDjWVePpYUpWYP6bxwcq+1F7Xni18G2XhiEUX89LCUa6NggFt3kJI15QnfGrBTgeTNLxJToJUE47+pggIBvLA6l2BuMpCsJEenEHQU5LSQceNZcw9iJ90HeA1WhLM4P2m+QpJOv1TedbwrGE9NBgYx5YQZd+E7Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AthdK+Dk; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cfd2978f95so2059328a12.0
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 13:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732225384; x=1732830184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MuIRpuuG/kMI+ayKarHD3cb1h0utm1aO6zGomxB9fJ4=;
        b=AthdK+DkbtplBxeZKIYlczOpdw9YVxj/yipD+j2GdvkwLb33THMTF6fvl1WP5Q1QOk
         IMmBMP3DGgkmEQmho1kT8DCFsHr7+mpyf8foPzv6e6LmVKdpBCV++kUNdcIhRLZF34p+
         3x1sRIntPHDnf3DCY2wyuLVV+RiKtWs+aAtvdYcSotDT+SceYJWkXKJOE6WCvv6QP0L3
         saGvtSw15310xZWddUnfypM59Ha+xoZZjbzBrQJTHuVEiyuVJsgAParCFE7b4VmOgW5K
         py7JuICX2m3v/J4xg6YjllXgZLrqSCCdEEgX7A1W7cdgZH2xE7lO9EK8GL3GyzuG+upC
         An8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732225384; x=1732830184;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuIRpuuG/kMI+ayKarHD3cb1h0utm1aO6zGomxB9fJ4=;
        b=e4tTGbFaS/Iju7mFD9gj+bmg4I9F1DdPhiYlzdK64MGWTv/cgzJgvqR3xqWamjp8pI
         Pbs4ulAJ1i6M3QN8UPQElBI0ihFRYvnTS+gvfLejT78q3vtoS8DCXYmdHP9rDqRZbb7t
         vMkCHI5lgOKlM94MN8bozPedAGd1e+fcbZv5T1fFHSE3WShfNdoZaFSRJEJMcLsKaxux
         491M3amEwrgEKmQmrW0UklS7kfB9D0rp3MEwV5YDaO9HDBdhbIpOljz2qRvwmlf8Laal
         eO1SlO4hwI8TD5cKYlrNiDe6uUM51qzLYhFZp49RuvxTDKBZz2TLTimR9sURQaUG92Dl
         3Cyw==
X-Forwarded-Encrypted: i=1; AJvYcCUXzaMzk8amJB+3GsvOBWXpuB4vLEoRJI/lRXvzRfZTdJCuByWDOmkjwWGUE/7zrYqxEl3XIrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe6y45tGnWbHuyDYJ2GdzRbIg3gS4rLMOfqouwaNA7I1rU02ED
	TD6pNN36CcYUqgKmf2fOLn+hv07W06JiQXKzb9GO/8WNnQnl/Zxdy+hxv4q5Ejbx5Rlt+J3QVh7
	u
X-Gm-Gg: ASbGncuSggDujWNGeoD7AP5NTxpMsA05vot3jX1sm+YZXHOmGAjGD9gXpDxxd+YWTDm
	qtBc+NJeb2UZQ8BL2FiMM1u42iM3IDkXbXpDBnkDWAxJ+43YtWPRZ9kTnDQKrHNv6fVBRjJ3okk
	fZf3Pu1UI9m54dqRg6Dd7gr3PFIq58kRjdMVAwv0bNtSrD8Fg/ov3WqQzhnc0+DBKsevLHMEt5H
	uWRcPt7Oz8iU3kmEarwJN81+CJtmCuC0h5aoMaKOaXQKtm+wXbe+EiW+LXqA2uSC/id/Ul5nJQk
	yhqfuN4hbA==
X-Google-Smtp-Source: AGHT+IHLGS0Dl6V0j4lAQHy7jaEm+ilgsgfuNG0hT0P6fkZJCJT5WZHBcPw5Alj0sl2zFVApH/6Ueg==
X-Received: by 2002:a17:907:1dd4:b0:a99:5021:bcf0 with SMTP id a640c23a62f3a-aa509b52d6dmr44783466b.34.1732225384285;
        Thu, 21 Nov 2024 13:43:04 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:f55:fe70:5486:7392? ([2001:67c:2fbc:1:f55:fe70:5486:7392])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b57bd96sm16503766b.148.2024.11.21.13.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 13:43:03 -0800 (PST)
Message-ID: <f4baaf5b-0efc-4a10-9af0-e7915fc98287@openvpn.net>
Date: Thu, 21 Nov 2024 22:43:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 18/23] ovpn: implement peer
 add/get/dump/delete via netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-18-de4698c73a25@openvpn.net> <Zz9Zh-5hZrbal5Ww@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Zz9Zh-5hZrbal5Ww@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/11/2024 17:02, Sabrina Dubroca wrote:
> [I'm still thinking about the locking problems for ovpn_peer_float,
> but just noticed this while staring at the rehash code]
> 
> 2024-10-29, 11:47:31 +0100, Antonio Quartulli wrote:
>> +void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
>> +	__must_hold(&peer->ovpn->peers->lock)
>> +{
>> +	struct hlist_nulls_head *nhead;
>> +
>> +	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
>> +		/* remove potential old hashing */
>> +		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
> 
> s/hash_entry_transp_addr/hash_entry_addr4/ ?

cr0p. very good catch!
Thanks

> 
> 
>> +		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_vpn_addr,
>> +					   &peer->vpn_addrs.ipv4,
>> +					   sizeof(peer->vpn_addrs.ipv4));
>> +		hlist_nulls_add_head_rcu(&peer->hash_entry_addr4, nhead);
>> +	}
>> +
>> +	if (!ipv6_addr_any(&peer->vpn_addrs.ipv6)) {
>> +		/* remove potential old hashing */
>> +		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
> 
> s/hash_entry_transp_addr/hash_entry_addr6/ ?

Thanks²
This is what happens when you copy/paste code around.

> 
> 
>> +		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_vpn_addr,
>> +					   &peer->vpn_addrs.ipv6,
>> +					   sizeof(peer->vpn_addrs.ipv6));
>> +		hlist_nulls_add_head_rcu(&peer->hash_entry_addr6, nhead);
>> +	}
>> +}
> 

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


