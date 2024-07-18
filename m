Return-Path: <netdev+bounces-112041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A28A934B02
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 11:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE79C1C20E72
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE9B7E0E8;
	Thu, 18 Jul 2024 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BA5yXaJC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E037C25634
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721295342; cv=none; b=tILgB5mjKNXwjV2eMW0mQKJuLbIUX1DOdbf0WYo96+Hwq99841BUm1TkOkQMuyyKT0xstBTH4rnkE+ZrFQLq4Ewqr6GuwodejfzR7qww/adYRZawIWJRPVnX7AgDP91RGM6AEszzwac2xJeoWVIWakqe4tm1u61C6JVzCOTTFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721295342; c=relaxed/simple;
	bh=s98Eg/b9a4AR9paHDkBAkAR0hiToabz6RUuD1FjW8Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eN/qTi8vt0NdWJJdoXP7kibANVA0g3Dr9kp0Zqo/h0O41bPcKFhg27PgZbNNmF30nS2CqnX3HDX+ms7HcqeOr4XBwpgVyuulzl8lGbGO2dpI73Jfh89VphKuivBRQpEhqLuO9LtrsY33rI84GvD11W6GIeS/Ee2diW+FBczlmiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BA5yXaJC; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a77cb7c106dso60465566b.1
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 02:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1721295338; x=1721900138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QBj1Y1xQlBzdrmf8zXgLHAE5TQL749Ow6bTtIHyaEq8=;
        b=BA5yXaJCkW250QoyISZw8xWgrHjJO6QQk+kCXRnRdXxeKlKTpnZLAdC0h8Utg21BAz
         nXmzPg2HSkh8jaIYBx3Em/nC37FI6OkJNcZiNZFIiUTpaPtDeZ/WoqHfVzaRb8jfVJuB
         w2wNyEL5+Qqi1+g54spEjoAXy0s+DAe9kcyeoPvSaruc5pyrMywG/89XWoU2xrLjIX4Q
         iuzulajwPQbjuN9gwH7UuRW2DOOptfhGinbXMiAYoiigfvjpTbInsXPf2zq/oLvXcEMs
         DAV2gg7wXt2Gt0ouKzHTUhvHUht/dNQrE5Wh19eoZrOK5VXjm+8AU7iP63d0mEC5UwWx
         n09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721295338; x=1721900138;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBj1Y1xQlBzdrmf8zXgLHAE5TQL749Ow6bTtIHyaEq8=;
        b=sTzjoszr519JpIOQSEpKNxFlLekJhkscU6AMHcVYhO1arzu31gkNmAlInh4F50g5iA
         /Vo5+qoX70AMESGuns44+qs3P32IpyoPLgZTH3WVX21i2vMvLLy7bGT0E8gwaMUlegVG
         jBfqHWzm18lWKdY6HDcsJPSqQX/vGGEAjfoQYUF1rymssxlhm6mran7l2JMyOABZlfKP
         yb1RiBfl1UOFxnLGld/1arOw6Bs/d2hiE7r9eX7ytcr4Uzmuy8O4i8tGye5AWl+VDEV0
         kYSDotL5NAavnfbEBsVF3VakQaS5iN1JR+SQBoSI4wEX5zyscUUj0KLkXChXlgY/1rTv
         43iQ==
X-Gm-Message-State: AOJu0YwN7Jd+ZQxp9hi4Ya0jpVa+pC9qO7lCTTu7j22ekmgnxx+dz6bv
	VaN4yuOKbGXrIDJ3odZPVzmBpX5UwrbJCeflVRePFlWcTEJXgWbDWCMPL+9gHEQ=
X-Google-Smtp-Source: AGHT+IGDz/lIxmwrW0h5S/ld/2ec2+feR+cT0WVz2XE0KiRJk1huMqe0YMM5TvMZ4HWsTjPgB1crUA==
X-Received: by 2002:a17:906:4c51:b0:a77:c0f5:69d1 with SMTP id a640c23a62f3a-a7a01352d79mr300389866b.60.1721295338218;
        Thu, 18 Jul 2024 02:35:38 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:14d5:6a6d:7aec:1e83? ([2001:67c:2fbc:1:14d5:6a6d:7aec:1e83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff715sm540887566b.161.2024.07.18.02.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 02:35:37 -0700 (PDT)
Message-ID: <5d49ef6c-ad35-4199-b5af-0caae5a04e85@openvpn.net>
Date: Thu, 18 Jul 2024 11:37:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 19/25] ovpn: add support for peer floating
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
 pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-20-antonio@openvpn.net> <Zpf8I5HdJFgehunO@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Zpf8I5HdJFgehunO@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/2024 19:15, Sabrina Dubroca wrote:
> 2024-06-27, 15:08:37 +0200, Antonio Quartulli wrote:
>> +void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb)
>> +{
>> +	struct sockaddr_storage ss;
>> +	const u8 *local_ip = NULL;
>> +	struct sockaddr_in6 *sa6;
>> +	struct sockaddr_in *sa;
>> +	struct ovpn_bind *bind;
>> +	sa_family_t family;
>> +	size_t salen;
>> +
>> +	rcu_read_lock();
>> +	bind = rcu_dereference(peer->bind);
>> +	if (unlikely(!bind))
>> +		goto unlock;
> 
> Why are you aborting here? ovpn_bind_skb_src_match considers
> bind==NULL to be "no match" (reasonable), then we would create a new
> bind for the current address.

(NOTE: float and the following explanation assume connection via UDP)

peer->bind is assigned right after peer creation in ovpn_nl_set_peer_doit().

ovpn_peer_float() is called while the peer is exchanging traffic.

If we got to this point and bind is NULL, then the peer was being 
released, because there is no way we are going to NULLify bind during 
the peer life cycle, except upon ovpn_peer_release().

Does it make sense?

> 
>> +
>> +	if (likely(ovpn_bind_skb_src_match(bind, skb)))
> 
> This could be running in parallel on two CPUs, because ->encap_rcv
> isn't protected against that. So the bind could be getting updated in
> parallel. I would move spin_lock_bh above this check to make sure it
> doesn't happen.

hm, I should actually use peer->lock for this, which is currently only 
used in ovpn_bind_reset() to avoid multiple concurrent assignments...but 
you're right we should include the call to skb_src_check() as well.

> 
> ovpn_peer_update_local_endpoint would also need something like that, I
> think.

at least the test-and-set part should be protected, if we can truly 
invoke ovpn_peer_update_local_endpoint() multiple times concurrently.


How do I test running encap_rcv in parallel?
This is actually an interesting case that I thought to not be possible 
(no specific reason for this..).

> 
>> +		goto unlock;
>> +
>> +	family = skb_protocol_to_family(skb);
>> +
>> +	if (bind->sa.in4.sin_family == family)
>> +		local_ip = (u8 *)&bind->local;
>> +
>> +	switch (family) {
>> +	case AF_INET:
>> +		sa = (struct sockaddr_in *)&ss;
>> +		sa->sin_family = AF_INET;
>> +		sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
>> +		sa->sin_port = udp_hdr(skb)->source;
>> +		salen = sizeof(*sa);
>> +		break;
>> +	case AF_INET6:
>> +		sa6 = (struct sockaddr_in6 *)&ss;
>> +		sa6->sin6_family = AF_INET6;
>> +		sa6->sin6_addr = ipv6_hdr(skb)->saddr;
>> +		sa6->sin6_port = udp_hdr(skb)->source;
>> +		sa6->sin6_scope_id = ipv6_iface_scope_id(&ipv6_hdr(skb)->saddr,
>> +							 skb->skb_iif);
>> +		salen = sizeof(*sa6);
>> +		break;
>> +	default:
>> +		goto unlock;
>> +	}
>> +
>> +	netdev_dbg(peer->ovpn->dev, "%s: peer %d floated to %pIScp", __func__,
>> +		   peer->id, &ss);
>> +	ovpn_peer_reset_sockaddr(peer, (struct sockaddr_storage *)&ss,
>> +				 local_ip);
>> +
>> +	spin_lock_bh(&peer->ovpn->peers->lock);
>> +	/* remove old hashing */
>> +	hlist_del_init_rcu(&peer->hash_entry_transp_addr);
>> +	/* re-add with new transport address */
>> +	hlist_add_head_rcu(&peer->hash_entry_transp_addr,
>> +			   ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
>> +					      &ss, salen));
> 
> That could send a concurrent reader onto the wrong hash bucket, if
> it's going through peer's old bucket, finds peer before the update,
> then continues reading after peer is moved to the new bucket.

I haven't fully grasped this scenario.
I am imagining we are running ovpn_peer_get_by_transp_addr() in 
parallel: reader gets the old bucket and finds peer, because 
ovpn_peer_transp_match() will still return true (update wasn't performed 
yet), and will return it.

At this point, what do you mean with "continues reading after peer is 
moved to the new bucket"?

> 
> This kind of re-hash can be handled with nulls, and re-trying the
> lookup if we ended up on the wrong chain. See for example
> __inet_lookup_established in net/ipv4/inet_hashtables.c (Thanks to
> Paolo for the pointer).
> 
>> +	spin_unlock_bh(&peer->ovpn->peers->lock);
>> +
>> +unlock:
>> +	rcu_read_unlock();
>> +}
> 

-- 
Antonio Quartulli
OpenVPN Inc.

