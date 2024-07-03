Return-Path: <netdev+bounces-109050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C39926B4F
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 00:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08EA3B20ECE
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 22:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266681422B7;
	Wed,  3 Jul 2024 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="QKw+BhF1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE94141987
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720044911; cv=none; b=lRReYlJigvsGfALxEJbjNikt4qkDSo0Jna75AtZEh2ty9h8ffMC9hpaAH0LAKAR/J41fygV2C42R6b67lY7jk5bmdwBmRq2wGeGzaC4TtuciEJJSM9gA8ZhK4idSiM4V90zwPokeLa6m/wM/CoKbyy5Lrc++ajkW6DUdLt77zTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720044911; c=relaxed/simple;
	bh=cXiMuV7zPK5mYxfonoj5pmfDrVklglhqgm489X1bwv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhfPIe6kiDnAB7l6aoryHCbsMUhoe0ljGGjrho/djkVxxMyAaap7ypkXrF9VbTHz1SDZlftgRsuSOOKCqd5RuL9v77uwqHJCy2sE6ucWNMjdeZ+DqbH1OGIQfWypoGU8RK9jumwu4j81lUQx1FEtZ8bdeoNV5hWUpf8FuJ/GVIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=QKw+BhF1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42561c16ffeso45423555e9.3
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 15:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1720044907; x=1720649707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FX9eAbs1Wlp8D5VlT+9PukjweeuHBmFcQEYjfEvEC2I=;
        b=QKw+BhF1PTkqOMQAl3G7Jkjpe5+9oDA7rs4LicEsDdchgaREv2dcRpIhG8/6tA+kdk
         JT52zJwnj3gIOByYbIVDT8ZCytNvQiDJBgskCEG41w/yUEZ2jciWDVG6AJ5K1uyG0V92
         gUSXsQDuwiBc0rPsEHWw/2jGNQbnxKIrBhCyMlTJK905KeX0Is6FPr/bw40gyCa/h4wf
         jQ46BS5hnMexuykfrLIsWHKbEvBGazzaVULcInG6LWxLGWJfNEflvks5GCvqBwD3MFPv
         BmyoZm81Yh2fkREQaVtPLhk4oFU3JaB7MCNlaDVec2FUG9GPqXKWEehDqLM4KwqBu8Iw
         9NNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720044907; x=1720649707;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FX9eAbs1Wlp8D5VlT+9PukjweeuHBmFcQEYjfEvEC2I=;
        b=iwuZuNZcg2c8j/xOiGNCS7wt+Z57Qk62yYs4toJD7Qaf0AEm6rRXjoAunKXchwUm2d
         5ks2FB9ZDhqlV7Lj8MWj4bS/GUy243sbfDnaKM4rUHRzQKYmW7Q8EKXT+xBxAqv87WxS
         FtJHcmc+vzSzkCEuh10BSy1vLanOiZMYpXwlkOXHd160OXOChyUm9LoSvPa9209KCqyw
         nFvULeZK4VyA4x7pGVSWWYb/uAcsP8qEcpvmw65WycYnBy4g+pEFzhkeJhlVEMmleDEB
         wxxIoHC+2uW3Wf/Z2Z+VPqeBlZJuE/6Jh7ORV6grPfZfKEX7CUiA/udUNEmkG56HcsY1
         iY/A==
X-Gm-Message-State: AOJu0YzALXMDodsQZv8J7vJH/SW06rYcDjR7kgR8DQIjE+IeEDCQfCmp
	QIJbRrF/qiEVFyDtFVrmord8YObDgUN1ZqgeEvi2WdKAPf6DxcDeuHd78EZEn+g=
X-Google-Smtp-Source: AGHT+IFM3j/vompGrkzxDNUxbT8lVeRTIsTD2slMV657k+TvHlua3yPMqmBntGu5Q4gyZqY2PjGj6A==
X-Received: by 2002:a05:600c:3542:b0:425:65fd:449 with SMTP id 5b1f17b1804b1-4257a05c08dmr78117015e9.28.1720044906695;
        Wed, 03 Jul 2024 15:15:06 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:733d:9048:62cb:ccf? ([2001:67c:2fbc:0:733d:9048:62cb:ccf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d6677sm546205e9.17.2024.07.03.15.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 15:15:06 -0700 (PDT)
Message-ID: <69443dab-1eaa-4754-8973-750f653ef716@openvpn.net>
Date: Thu, 4 Jul 2024 00:16:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 08/25] ovpn: introduce the ovpn_peer object
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
 pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-9-antonio@openvpn.net> <ZoXEosCwp6-WR7wb@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZoXEosCwp6-WR7wb@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2024 23:37, Sabrina Dubroca wrote:
> 2024-06-27, 15:08:26 +0200, Antonio Quartulli wrote:
>> +/**
>> + * struct ovpn_sockaddr - basic transport layer address
>> + * @in4: IPv4 address
>> + * @in6: IPv6 address
>> + */
>> +struct ovpn_sockaddr {
>> +	union {
>> +		struct sockaddr_in in4;
>> +		struct sockaddr_in6 in6;
>> +	};
>> +};
> 
> nit: wrapping the anonymous union in a struct that contains nothing
> else is not that useful.

yeah, I guess I can just turn ovpn_sockaddr in a union.

> 
> 
>> +/**
>> + * struct ovpn_bind - remote peer binding
>> + * @sa: the remote peer sockaddress
>> + * @local: local endpoint used to talk to the peer
>> + * @local.ipv4: local IPv4 used to talk to the peer
>> + * @local.ipv6: local IPv6 used to talk to the peer
>> + * @rcu: used to schedule RCU cleanup job
>> + */
>> +struct ovpn_bind {
>> +	struct ovpn_sockaddr sa;  /* remote sockaddr */
> 
> nit: then maybe call it "peer" or "remote" instead of sa?

yap, makes sense. I will call it "remote".

> 
>> +	union {
>> +		struct in_addr ipv4;
>> +		struct in6_addr ipv6;
>> +	} local;
>> +
>> +	struct rcu_head rcu;
>> +};
>> +
> 
> [...]
>> +struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
>> +{
>> +	struct ovpn_peer *peer;
>> +	int ret;
>> +
>> +	/* alloc and init peer object */
>> +	peer = kzalloc(sizeof(*peer), GFP_KERNEL);
>> +	if (!peer)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	peer->id = id;
>> +	peer->halt = false;
>> +	peer->ovpn = ovpn;
>> +
>> +	peer->vpn_addrs.ipv4.s_addr = htonl(INADDR_ANY);
>> +	peer->vpn_addrs.ipv6 = in6addr_any;
>> +
>> +	RCU_INIT_POINTER(peer->bind, NULL);
>> +	spin_lock_init(&peer->lock);
>> +	kref_init(&peer->refcount);
>> +
>> +	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
>> +	if (ret < 0) {
>> +		netdev_err(ovpn->dev, "%s: cannot initialize dst cache\n",
>> +			   __func__);
>> +		kfree(peer);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	netdev_hold(ovpn->dev, NULL, GFP_KERNEL);
> 
> It would be good to add a tracker to help debug refcount issues.

Ok, will do!

> 
> 
>> +
>> +	return peer;
>> +}
>> +
>> +#define ovpn_peer_index(_tbl, _key, _key_len)		\
>> +	(jhash(_key, _key_len, 0) % HASH_SIZE(_tbl))	\
> 
> nit: not used in this patch, and even removed by patch 16 as you
> convert from index to buckets (that conversion should be squashed into
> patch 15)

You're correct. Will merge all these pieces in patch 15.

> 
>> +/**
>> + * ovpn_peer_transp_match - check if sockaddr and peer binding match
>> + * @peer: the peer to get the binding from
>> + * @ss: the sockaddr to match
>> + *
>> + * Return: true if sockaddr and binding match or false otherwise
>> + */
>> +static bool ovpn_peer_transp_match(const struct ovpn_peer *peer,
>> +				   const struct sockaddr_storage *ss)
>> +{
> 
> AFAICT ovpn_peer_transp_match is only called with ss from
> ovpn_peer_skb_to_sockaddr, so it's pretty much ovpn_bind_skb_src_match
> but using peer->bind. You can probably avoid the code duplication
> (ovpn_peer_transp_match and ovpn_bind_skb_src_match are very similar).
> 

mhh it is not called in ovpn_peer_skb_to_sockaddr, but I guess your 
comment still applies: ovpn_peer_transp_match and 
ovpn_bind_skb_src_match are very similar.

However in one we have a sockaddr_storage while in the other we have an 
skb. How do we combine the two?
The only way I see is to create an ss out of the skb and then always use
ovpn_peer_transp_match. Is this what you were alluding to?


Thanks!

-- 
Antonio Quartulli
OpenVPN Inc.

