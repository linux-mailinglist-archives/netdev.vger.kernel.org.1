Return-Path: <netdev+bounces-171845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FC0A4F153
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 00:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8769188B5E0
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 23:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3151927814C;
	Tue,  4 Mar 2025 23:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ny8tYnQd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F05924DFE1
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 23:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130381; cv=none; b=tHbJnWb3ybQlEAo83ceS70cImulNV/EQFpbrfAtgxgQxwKVdao/kZf3i6XW/cGSDT4SWV6yVdPxdeFJl0pogmjoZFKb6vq0h1sTRSCWMidl9ADgsIK4J69VN7wXaGaemXwYUD14ALCGmIvBPRHNKpzRV9CZtMhPxH7bxRVNKyFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130381; c=relaxed/simple;
	bh=Pg+j0w08LFQvvhKXGAGSv3WfAYhVXVP5qvtsyQZ1KhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gopb9YeUeWWve2P6awGku0pcqKbVTqOHEGPnZ7oC/UWehTD+ar7IvMj6ZX3/+O6E/UXpJ8y6xx8bveK83S6Cv9dtD/9uufHt5W6JfMZbqGtnrTeQJUgTyADKSHL1T9ON+F/n2XcH+jLZnVWcxM6DAeo4gnUuAPndSHU4sceMbVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ny8tYnQd; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e4ebc78da5so9184454a12.2
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 15:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741130376; x=1741735176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi1tDJofCuitzWIascvhhVcUILEUWxoEMLUbwJHwkNk=;
        b=Ny8tYnQdKSaTzVrBxwNx77PBL0rB/Ime4oJkiDCpNqurs1yZZzb0qx52Q9j1ZGazBs
         y6W9O4P84EGTGXcQZpUx0gqfaW1mJLCDztTyeNRPye+HIL3W7OoRUUAliWOrxqq3lviV
         KDNebyHcfRNZV/pbtc470WYYAW5njsmOuS2gMtkrJInPreOsFDTEY7uD9VBYOsLG6zrl
         w1r+Wd9zHtb1+1GEnyaf8c+YGiJDXfhR3p37+dTC7S8yAAbpAzpKA7OJuXWMJy0qBQkg
         cP9hZlV42IGwGqpjt40Br5by+Tn4R5RUCcIGm7wMew2mMsoHFQpCAu3CgOuL/yUzKS1r
         kaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741130376; x=1741735176;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi1tDJofCuitzWIascvhhVcUILEUWxoEMLUbwJHwkNk=;
        b=vu1oMZ7qEgRFeZx5bk/W/1Wrd13g2stnGOj1ro7bLLGyowU1u4Q5fet/+Qh7v60Mow
         rEtAryW+lFDEgQxvRyXUR7wWSKj6w4LDDZxb2NazvnnWvpDd+mA22sgask8mIlf3aR+6
         D6UnIc0di9wRBF0D3ahmXIPERDmfCa5QeH60/2oeyr/Q6fMu0Oc7nkKqELLJgJs98W9F
         63Wlkj/bwGJ5z0BI3hCDUKiAVe1ZvVzbvwuKnDYyGSCES5/eb/4pwu67P+cmwZkllq87
         cc3BkrklfoZFhlOJIOZcKlIkP54vJlC6dBW+1IuDz3Th/9cVDfUQXXZFoAwhrCD96C/G
         TdtQ==
X-Gm-Message-State: AOJu0YwNw1cs+rQBd54ixYYgoLvU/CnxlEEdTFam5xCjOjijHodQfp/5
	CKvOEqIQ17TChOK6bmUHstS28cvaUjT5n2cy9g35Cedcq7Eoz7NZVvk1i2TxjjQ=
X-Gm-Gg: ASbGnctASz1I2h2+JymGIN+EERE/YXbtKnVZcoQP8kRqkvyiRJLiCEXOqKUO44+4DSm
	+S/UNZniok+VpjO864fNBIYcldeAlxf5Y2ZpUqOVK0rOGCE8dkuX0GAWWQSi+alO7bx9h548G10
	B0zlMnAselFoUQw9egazBnRRS0HAwa6GluaIHN0jj48bAOvZd4to861mBmNjYNE1VMhCcyQkyW+
	Eq6cwTJUgpMhoahfGw81Jb6AApjsbnsazWj9YsbDaJmgGHAQsU2xQ0j3mDIX/E0Z1QUZG3ljWFw
	6dOVz8oBV/RDsuO/YczTCgRvAf4v+z9qERch0eTG3uOQ2XCCel59PZnMXoxTIhdjq06NZfTvMoo
	2LwhCH9M=
X-Google-Smtp-Source: AGHT+IGSWBBLLOEgGm5d12Y0VLhxBPzcA+VG2L+2ZEf6ixg9c/BHEGiY5ClxGVzJJS5exDVTZ77Ceg==
X-Received: by 2002:a05:6402:2351:b0:5e4:9a0e:38a3 with SMTP id 4fb4d7f45d1cf-5e59f3c5f22mr765296a12.17.1741130375762;
        Tue, 04 Mar 2025 15:19:35 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:2107:3d4f:958a:fa5f? ([2001:67c:2fbc:1:2107:3d4f:958a:fa5f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4aad0sm8840121a12.2.2025.03.04.15.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 15:19:34 -0800 (PST)
Message-ID: <9c919407-fb91-48d7-bf2d-8437c2f3f4da@openvpn.net>
Date: Wed, 5 Mar 2025 00:19:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 18/24] ovpn: add support for peer floating
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
 <20250304-b4-ovpn-tmp-v21-18-d3cbb74bb581@openvpn.net> <Z8dIXjwZ3QmiEcd-@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z8dIXjwZ3QmiEcd-@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/03/2025 19:37, Sabrina Dubroca wrote:
> 2025-03-04, 01:33:48 +0100, Antonio Quartulli wrote:
>> A peer connected via UDP may change its IP address without reconnecting
>> (float).
> 
> Should that trigger a reset of the peer->dst_cache? And same when
> userspace updates the remote address? Otherwise it seems we could be
> stuck with a cached dst that cannot reach the peer.

Yeah, that make sense, otherwise ovpn_udpX_output would just try over 
and over to re-use the cached source address (unless it becomes 
unavailable).

> 
> 
>> +void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
>> +{
>> +	struct hlist_nulls_head *nhead;
>> +	struct sockaddr_storage ss;
>> +	const u8 *local_ip = NULL;
>> +	struct sockaddr_in6 *sa6;
>> +	struct sockaddr_in *sa;
>> +	struct ovpn_bind *bind;
>> +	size_t salen = 0;
>> +
>> +	spin_lock_bh(&peer->lock);
>> +	bind = rcu_dereference_protected(peer->bind,
>> +					 lockdep_is_held(&peer->lock));
>> +	if (unlikely(!bind))
>> +		goto unlock;
>> +
>> +	switch (skb->protocol) {
>> +	case htons(ETH_P_IP):
>> +		/* float check */
>> +		if (unlikely(!ovpn_bind_skb_src_match(bind, skb))) {
>> +			if (bind->remote.in4.sin_family == AF_INET)
>> +				local_ip = (u8 *)&bind->local;
> 
> If I'm reading this correctly, we always reuse the existing local
> address when we have to re-create the bind, even if it doesn't match
> the skb? The "local endpoint update" chunk below is doing that, but
> only if we're keeping the same remote? It'll get updated the next time
> we receive a packet and call ovpn_peer_endpoints_update.
> 
> That might irritate the RPF check on the other side, if we still use
> our "old" source to talk to the new dest?
> 
>> +			sa = (struct sockaddr_in *)&ss;
>> +			sa->sin_family = AF_INET;
>> +			sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
>> +			sa->sin_port = udp_hdr(skb)->source;
>> +			salen = sizeof(*sa);
>> +			break;

I think the issue is simply this 'break' above - by removing it, 
everything should work as expected.

I thin this is a leftover from when float check and endpoint update were 
two different functions/switch blocks.

>> +		}
>> +
>> +		/* local endpoint update */
>> +		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
>> +			net_dbg_ratelimited("%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
>> +					    netdev_name(peer->ovpn->dev),
>> +					    peer->id, &bind->local.ipv4.s_addr,
>> +					    &ip_hdr(skb)->daddr);
>> +			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
>> +		}
>> +		break;
> 
> [...]
>> +	if (peer->ovpn->mode == OVPN_MODE_MP) {
>> +		spin_lock_bh(&peer->ovpn->lock);
>> +		spin_lock_bh(&peer->lock);
>> +		bind = rcu_dereference_protected(peer->bind,
>> +						 lockdep_is_held(&peer->lock));
>> +		if (unlikely(!bind)) {
>> +			spin_unlock_bh(&peer->lock);
>> +			spin_unlock_bh(&peer->ovpn->lock);
>> +			return;
>> +		}
>> +
>> +		/* his function may be invoked concurrently, therefore another
> 
> typo:
>                     ^ This

ACK

> 
> 
> [...]
>> -/* variable name __tbl2 needs to be different from __tbl1
>> - * in the macro below to avoid confusing clang
>> - */
>> -#define ovpn_get_hash_slot(_tbl, _key, _key_len) ({	\
>> -	typeof(_tbl) *__tbl2 = &(_tbl);			\
>> -	jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl2);	\
>> -})
>> -
>> -#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
>> -	typeof(_tbl) *__tbl1 = &(_tbl);				\
>> -	&(*__tbl1)[ovpn_get_hash_slot(*__tbl1, _key, _key_len)];\
>> -})
>> -
>>   /**
>>    * ovpn_peer_get_by_vpn_addr4 - retrieve peer by its VPN IPv4 address
>>    * @ovpn: the openvpn instance to search
>> @@ -522,51 +694,6 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
>>   	llist_add(&peer->release_entry, release_list);
>>   }
>>   
>> -/**
>> - * ovpn_peer_update_local_endpoint - update local endpoint for peer
>> - * @peer: peer to update the endpoint for
>> - * @skb: incoming packet to retrieve the destination address (local) from
>> - */
>> -void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
>> -				     struct sk_buff *skb)
>> -{
>> -	struct ovpn_bind *bind;
>> -
>> -	rcu_read_lock();
>> -	bind = rcu_dereference(peer->bind);
>> -	if (unlikely(!bind))
>> -		goto unlock;
>> -
>> -	spin_lock_bh(&peer->lock);
>> -	switch (skb->protocol) {
>> -	case htons(ETH_P_IP):
>> -		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
>> -			net_dbg_ratelimited("%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
>> -					    netdev_name(peer->ovpn->dev),
>> -					    peer->id, &bind->local.ipv4.s_addr,
>> -					    &ip_hdr(skb)->daddr);
>> -			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
>> -		}
>> -		break;
>> -	case htons(ETH_P_IPV6):
>> -		if (unlikely(!ipv6_addr_equal(&bind->local.ipv6,
>> -					      &ipv6_hdr(skb)->daddr))) {
>> -			net_dbg_ratelimited("%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
>> -					    netdev_name(peer->ovpn->dev),
>> -					    peer->id, &bind->local.ipv6,
>> -					    &ipv6_hdr(skb)->daddr);
>> -			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
>> -		}
>> -		break;
>> -	default:
>> -		break;
>> -	}
>> -	spin_unlock_bh(&peer->lock);
>> -
>> -unlock:
>> -	rcu_read_unlock();
>> -}
> 
> I guess you could squash this and the previous patch into one to
> reduce the churn (and get a little bit closer to the 15-patch limit :))

Hehe I can see you're getting familiar with the code :-)
Will do!

Thanks!

> 

-- 
Antonio Quartulli
OpenVPN Inc.


