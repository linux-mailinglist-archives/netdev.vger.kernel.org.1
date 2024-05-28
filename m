Return-Path: <netdev+bounces-98758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E59E8D257D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 22:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0CC0B2C7DA
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 20:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C3417839A;
	Tue, 28 May 2024 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XdAp6kyu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5EC178393
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716926893; cv=none; b=UrXYbZxeMSl3enuIq9O4wzJiHpm/r08rc0W69m5Bd5dfuEulx/2l45dOdjV7h1EY+G3WduWtk3CZEdUfApYceB8ylBU3I+0aKOPlxm6n4w5dvm6+b7xmuSqJMHOVNMJrf9zHkr9wDZ2H/zotKSoSLLzYMLKx999WpPLEBV0PhyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716926893; c=relaxed/simple;
	bh=U8Z8jVkgaPt4S4IaF13c/DpLGJJcUhYQ4kHiCaTkyK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oF8yG2T0P88m6bQS10D3KUSiWk/qSJ1XUMv7ZE36PImgRJHzhvTDt5ZFlG+9PS9TmlC4/rLLg6drsJ8cARcgPKBEi+2kvIBtz6zYXn03+3qeTHkVB+zDrut8/hPvEPLGI2iusfM88iQ+nZiX+5A8yfi9lXEHJ13KM6w+EJZMdyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XdAp6kyu; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a635c83bb7eso26760566b.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1716926890; x=1717531690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oj+6Cfxr26VF5IofZ9z5Li7D7t07MkOWaOUEUG8ppko=;
        b=XdAp6kyugBusBVz96JmYjICn13UjMQ1vCZF4hNEVOOIOZ2XZK8VzNBoacK/O/YHYic
         y57w6iSZhrS4mUUf/dVLXhT50f6tLAJa6MY0eiCHK7nsKiPyCV++QvlORXWOvLECaHA4
         auaUESCekDGJYS1u7W4x04bjOGwjwm3WVjAyJUr4uOmBq1I+GoeuM+TqgES3KRjk8+Gp
         CYQmFiiaVtq35a7Edx+2WIP0sG7h+Ubuc6ZnBxn0RY3znme+XGhKLxJS9M+ZQiuldlfG
         o3OunLdrtfNngFnSOHhb4RESy8Vxfy1PE5b+vlb8Ga4RSra7mZaP3SRE22RaPTXDbhlH
         zCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716926890; x=1717531690;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oj+6Cfxr26VF5IofZ9z5Li7D7t07MkOWaOUEUG8ppko=;
        b=dAULSm83MUdy2hrls6lQXW24K8V/FhKtV/zrnGFTcnJ8NEqYr9680sd5nMEGaiLTtX
         C/hC0r8S76f4zDGe1lLtQZpmIu2cA7IFS5qDrAlvvGDfQbhFUok9zgfmI8aukFhrYEoQ
         4lMol7wOi9KcioDTVlMUEfdjasHtZMa1AUN1tIPCBHRUUunxeQ6JbYh1PXPGl3G7ixSm
         BBwJ1mAjEZRvMKCSHsQZkLwvEVMpnFPkhAV/uQXmkxO/Hjh4VlaPGO1QxVAEehFXM9J3
         RfxCg0WSffLo81SweUZJKvyAo9x9fB+tKPuAdFm+wlc59CiuHOFglI9NEcAH+FvUpZUn
         TsAA==
X-Gm-Message-State: AOJu0Yw6B+eFXDxnaYkHMASEK4TiiHsXzcrF3IbdJ+sPUE8VksJDKsCo
	IWdj0skxwb6FVuYzqHgkCwU0UsOzbTH+EViZiLtyNeSLRDH/D3sGRSub3y/C6Tc=
X-Google-Smtp-Source: AGHT+IEODrGczPwb0jYSNY+XIzt8YYBSDWDIo+FbyoYMhuCvd4VpriySL63QOZdef4ElxmyLhyZMyg==
X-Received: by 2002:a50:955e:0:b0:579:be37:fa68 with SMTP id 4fb4d7f45d1cf-579be37fca1mr8952402a12.20.1716926888749;
        Tue, 28 May 2024 13:08:08 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:166f:d3a:3b2:a599? ([2001:67c:2fbc:0:166f:d3a:3b2:a599])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785238d355sm7620360a12.31.2024.05.28.13.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 13:08:08 -0700 (PDT)
Message-ID: <75ff57a6-dcd8-47f7-99bf-f46a1daee4b0@openvpn.net>
Date: Tue, 28 May 2024 22:09:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 15/24] ovpn: implement peer lookup logic
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-16-antonio@openvpn.net> <ZlYJaIvXY3nuNd98@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZlYJaIvXY3nuNd98@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/05/2024 18:42, Sabrina Dubroca wrote:
> 2024-05-06, 03:16:28 +0200, Antonio Quartulli wrote:
>> +static struct in6_addr ovpn_nexthop_from_skb6(struct sk_buff *skb)
>> +{
>> +	struct rt6_info *rt = (struct rt6_info *)skb_rtable(skb);
> 
> skb_rt6_info?

Yes! I have been looking for this guy all over the place in 
sk_buff.h....it was just in another header :) thanks!

> 
>> +
>> +	if (!rt || !(rt->rt6i_flags & RTF_GATEWAY))
>> +		return ipv6_hdr(skb)->daddr;
>> +
>> +	return rt->rt6i_gateway;
>> +}
>> +
>> +/**
>> + * ovpn_peer_get_by_vpn_addr4 - retrieve peer by its VPN IPv4 address
>> + * @head: list head to search
>> + * @addr: VPN IPv4 to use as search key
>> + *
>> + * Return: the peer if found or NULL otherwise
> 
> The doc for all those ovpn_peer_get_* functions could indicate that on
> success, a reference on the peer is held.

ACK

> 
> 
> [...]
>> +static struct ovpn_peer *ovpn_peer_get_by_vpn_addr6(struct hlist_head *head,
>> +						    struct in6_addr *addr)
>> +{
>> +	struct ovpn_peer *tmp, *peer = NULL;
>> +	int i;
>> +
>> +	rcu_read_lock();
>> +	hlist_for_each_entry_rcu(tmp, head, hash_entry_addr6) {
>> +		for (i = 0; i < 4; i++) {
>> +			if (addr->s6_addr32[i] !=
>> +			    tmp->vpn_addrs.ipv6.s6_addr32[i])
>> +				continue;
>> +		}
> 
> ipv6_addr_equal

Thanks

> 
> [...]
>> +	default:
>> +		return NULL;
>> +	}
>> +
>> +	index = ovpn_peer_index(ovpn->peers.by_transp_addr, &ss, sa_len);
>> +	head = &ovpn->peers.by_transp_addr[index];
> 
> Maybe worth adding a get_bucket helper (with a better name :)) instead
> of ovpn_peer_index, since all uses of ovpn_peer_index are followed by
> a "head = TBL[index]" (or direct use in some hlist iterator), but the
> index itself is not used later on, only the bucket.

yup, good idea

> 
>> +
>> +	rcu_read_lock();
>> +	hlist_for_each_entry_rcu(tmp, head, hash_entry_transp_addr) {
>> +		found = ovpn_peer_transp_match(tmp, &ss);
>> +		if (!found)
> 
> nit: call ovpn_peer_transp_match directly and drop the found variable

ACK.
I presume it's a leftover from the past, otherwise it wouldn't make much 
sense.

> 
>> +			continue;
>> +
>> +		if (!ovpn_peer_hold(tmp))
>> +			continue;
>> +
>> +		peer = tmp;
>> +		break;
>> +	}
>> +	rcu_read_unlock();
>>   
>>   	return peer;
>>   }
>> @@ -303,10 +427,28 @@ static struct ovpn_peer *ovpn_peer_get_by_id_p2p(struct ovpn_struct *ovpn,
>>   
>>   struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id)
>>   {
>> -	struct ovpn_peer *peer = NULL;
>> +	struct ovpn_peer *tmp, *peer = NULL;
>> +	struct hlist_head *head;
>> +	u32 index;
>>   
>>   	if (ovpn->mode == OVPN_MODE_P2P)
>> -		peer = ovpn_peer_get_by_id_p2p(ovpn, peer_id);
>> +		return ovpn_peer_get_by_id_p2p(ovpn, peer_id);
>> +
>> +	index = ovpn_peer_index(ovpn->peers.by_id, &peer_id, sizeof(peer_id));
>> +	head = &ovpn->peers.by_id[index];
>> +
>> +	rcu_read_lock();
>> +	hlist_for_each_entry_rcu(tmp, head, hash_entry_id) {
>> +		if (tmp->id != peer_id)
>> +			continue;
>> +
>> +		if (!ovpn_peer_hold(tmp))
>> +			continue;
> 
> Can there ever be multiple peers with the same id? (ie, is it worth
> continuing the loop if this fails? the same question probably applies
> to ovpn_peer_get_by_transp_addr as well)

Well, not at the same time, but theoretically we could re-use the ID of 
a peer that is being released (i.e. still in the list but refcnt at 0) 
because it won't be returned by this lookup.

This said, I truly believe it's impossible for a peer to have refcnt 0 
and still being in the list:
Either
* delete on the peer was not yet called, thus peer is in the list and 
the last reference wasn't yet dropped
* delete on the peer was called, thus peer cannot be in the list anymore 
and refcnt may or may not be 0...


> 
> 
>> +		peer = tmp;
>> +		break;
>> +	}
>> +	rcu_read_unlock();
>>   
>>   	return peer;
>>   }
>> @@ -328,6 +470,11 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
>>   				       struct sk_buff *skb)
>>   {
>>   	struct ovpn_peer *tmp, *peer = NULL;
>> +	struct hlist_head *head;
>> +	sa_family_t sa_fam;
>> +	struct in6_addr addr6;
>> +	__be32 addr4;
>> +	u32 index;
>>   
>>   	/* in P2P mode, no matter the destination, packets are always sent to
>>   	 * the single peer listening on the other side
>> @@ -338,15 +485,123 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
>>   		if (likely(tmp && ovpn_peer_hold(tmp)))
>>   			peer = tmp;
>>   		rcu_read_unlock();
>> +		return peer;
>> +	}
>> +
>> +	sa_fam = skb_protocol_to_family(skb);
>> +
>> +	switch (sa_fam) {
>> +	case AF_INET:
>> +		addr4 = ovpn_nexthop_from_skb4(skb);
>> +		index = ovpn_peer_index(ovpn->peers.by_vpn_addr, &addr4,
>> +					sizeof(addr4));
>> +		head = &ovpn->peers.by_vpn_addr[index];
>> +
>> +		peer = ovpn_peer_get_by_vpn_addr4(head, &addr4);
>> +		break;
>> +	case AF_INET6:
>> +		addr6 = ovpn_nexthop_from_skb6(skb);
>> +		index = ovpn_peer_index(ovpn->peers.by_vpn_addr, &addr6,
>> +					sizeof(addr6));
>> +		head = &ovpn->peers.by_vpn_addr[index];
>> +
>> +		peer = ovpn_peer_get_by_vpn_addr6(head, &addr6);
> 
> The index -> head -> peer code is identical in get_by_dst and
> get_by_src, it could be stuffed into ovpn_peer_get_by_vpn_addr{4,6}.

hm yeah, you're right. I'll do it!

> 
>> +		break;
>>   	}
>>   
>>   	return peer;
>>   }
> 
> 
> [snip the _rt4 variant, comments apply to both]
>> +/**
>> + * ovpn_nexthop_from_rt6 - look up the IPv6 nexthop for the given destination
> 
> I'm a bit confused by this talk about "destination" when those two
> functions are then used with the source address from the packet, from
> a function called "get_by_src".

well, in my brain a next hop can exists only when I want to reach a 
certain destination. Therefore, at a low level, the terms nextop and 
destination always need to go hand in hand.

This said, when implementing RPF (Reverse Path Filtering) I need to 
imagine that I want to route to the source IP of the incoming packet. If 
the nexthop I looked up matches the peer the packet came from, then 
everything is fine.

makes sense?

[FTR I have already renamed/changed get_by_src into check_by_src, 
because I don't need to truly extract a peer and get a reference, but I 
only need to perform the aforementioned comparison.]

> 
>> + * @ovpn: the private data representing the current VPN session
>> + * @dst: the destination to be looked up
>> + *
>> + * Looks up in the IPv6 system routing table the IO of the nexthop to be used
> 
> "the IO"?

typ0: "the IP"

> 
>> + * to reach the destination passed as argument. IF no nexthop can be found, the
>> + * destination itself is returned as it probably has to be used as nexthop.
>> + *
>> + * Return: the IP of the next hop if found or the dst itself otherwise
> 
> "the dst" tends to refer to a dst_entry, maybe "or @dst otherwise"?

it refers to @dst (the function argument). That's basically the case 
where the destination is "onlink" and thus it is the nexthop (basically 
the destination is the connected peer).

> (though I'm not sure that's valid kdoc)
> 
> (also for ovpn_nexthop_from_rt4)
> 
>> + */
>> +static struct in6_addr ovpn_nexthop_from_rt6(struct ovpn_struct *ovpn,
>> +					     struct in6_addr dst)
>> +{
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +	struct dst_entry *entry;
>> +	struct rt6_info *rt;
>> +	struct flowi6 fl = {
>> +		.daddr = dst,
>> +	};
>> +
>> +	entry = ipv6_stub->ipv6_dst_lookup_flow(dev_net(ovpn->dev), NULL, &fl,
>> +						NULL);
>> +	if (IS_ERR(entry)) {
>> +		net_dbg_ratelimited("%s: no route to host %pI6c\n", __func__,
>> +				    &dst);
>> +		/* if we end up here this packet is probably going to be
>> +		 * thrown away later
>> +		 */
>> +		return dst;
>> +	}
>> +
>> +	rt = container_of(entry, struct rt6_info, dst);
> 
> dst_rt6_info(entry)

Oh, I see this just came to life in 6.10-rc1. Thanks!

> 
>> +
>> +	if (!(rt->rt6i_flags & RTF_GATEWAY))
>> +		goto out;
>> +
>> +	dst = rt->rt6i_gateway;
>> +out:
>> +	dst_release((struct dst_entry *)rt);
>> +#endif
>> +	return dst;
>> +}
>> +
>>   struct ovpn_peer *ovpn_peer_get_by_src(struct ovpn_struct *ovpn,
>>   				       struct sk_buff *skb)
>>   {
>>   	struct ovpn_peer *tmp, *peer = NULL;
>> +	struct hlist_head *head;
>> +	sa_family_t sa_fam;
>> +	struct in6_addr addr6;
>> +	__be32 addr4;
>> +	u32 index;
>>   
>>   	/* in P2P mode, no matter the destination, packets are always sent to
>>   	 * the single peer listening on the other side
>> @@ -357,6 +612,28 @@ struct ovpn_peer *ovpn_peer_get_by_src(struct ovpn_struct *ovpn,
>>   		if (likely(tmp && ovpn_peer_hold(tmp)))
>>   			peer = tmp;
>>   		rcu_read_unlock();
>> +		return peer;
>> +	}
>> +
>> +	sa_fam = skb_protocol_to_family(skb);
>> +
>> +	switch (sa_fam) {
> 
> nit:
> 	switch (skb_protocol_to_family(skb))
> seems a bit more readable to me (also in ovpn_peer_get_by_dst) - and
> saves you from reverse xmas tree complaints (sa_fam should have been
> after addr6)

ACK, thanks!

> 
>> +	case AF_INET:
>> +		addr4 = ovpn_nexthop_from_rt4(ovpn, ip_hdr(skb)->saddr);
>> +		index = ovpn_peer_index(ovpn->peers.by_vpn_addr, &addr4,
>> +					sizeof(addr4));
>> +		head = &ovpn->peers.by_vpn_addr[index];
>> +
>> +		peer = ovpn_peer_get_by_vpn_addr4(head, &addr4);
>> +		break;
>> +	case AF_INET6:
>> +		addr6 = ovpn_nexthop_from_rt6(ovpn, ipv6_hdr(skb)->saddr);
>> +		index = ovpn_peer_index(ovpn->peers.by_vpn_addr, &addr6,
>> +					sizeof(addr6));
>> +		head = &ovpn->peers.by_vpn_addr[index];
>> +
>> +		peer = ovpn_peer_get_by_vpn_addr6(head, &addr6);
>> +		break;
>>   	}
>>   
>>   	return peer;
>> -- 
>> 2.43.2
>>
>>
> 

-- 
Antonio Quartulli
OpenVPN Inc.

