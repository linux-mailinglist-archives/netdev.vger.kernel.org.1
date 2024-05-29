Return-Path: <netdev+bounces-99187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B89C8D3F75
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 22:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E511F22CE4
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 20:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960B81A38C9;
	Wed, 29 May 2024 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BT+cxll8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6792412E68
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717013862; cv=none; b=jiQ88Xxpwo/7vg+/BqOUYFmeMR9/tyUNAzEnnPvxtxhfECHGAuD+CGxo9qRt6WA58r8fO6QyliBuWD/zFu0XCSdf8G8SB8hMoXapC5RbzPvkBru5CCi71YU+rvGPApsG+Ve8YWtzR5QNoF0F18R2jgEq7JO8W6QochDhOmgmYQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717013862; c=relaxed/simple;
	bh=42MdNMM6caf05o3QSyNT4/Hu8rTmc5eegGPphSNl/S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZUp4uL2y4Aj5vkcVpXCAM4eUaVYS6OB1LZQMf5a0Su1ufOtSNFvzUc0xiovjETCeFcdoR5nw3RrHI0WJ5AoeNDdmPd6MJZV4WpMY4HaYjic5Bmmt7/OvSVg+bUI4M1nRVemuiNkEtnfjQRwwogehZpxseJRRDemnDagZyn5rBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BT+cxll8; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52a54d664e3so235891e87.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1717013858; x=1717618658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ri/LOSTSBuU06HGYSeqSocqeIQTaUVC6S6HM/iP5Go0=;
        b=BT+cxll8lfdgAQyGa6D9B8ERrXFcjoQR9zTUnw2I09RLbS71MQSn7yle/CUPqSi/6R
         aNZAKQvpnphwZ0qYAI/1AHkOai1t88oeXrKDiVd+2HeF9xIGk+pa8hbQX91vkT/3mOUh
         AC8WU/XbAjcUa/RcC15QNm/EXPYivILLfcdsPMb2K42ZtAsELhW/8tj3PmF9mguetK4K
         7c2fovOSSPBRifAsSRt0/AJZgZoRycserGITQ/7y3VbebkkvoCy3m9bP+1jYlb0fGbnP
         HCelhcYj3mOvEBQKU5hoOUtY+j2YzgfrcSlry58Cw2m55u3z61L6UwrQk8MUZ8jJVZfA
         qtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717013858; x=1717618658;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri/LOSTSBuU06HGYSeqSocqeIQTaUVC6S6HM/iP5Go0=;
        b=VS2Nc6GOqvXP4US6PMn8WT7N0p9AQqazPSbAZ/6qV42BCWKcmGHTwQns9ggGBKSBpE
         07MybRaI1l/RlraVtUnM8jQViPIB6vme6kUyaCP5SsQo0J5ONHXL+0igZkpdIQNY2w1I
         f+WIEnRz4E7RZCTyrcBDtN6+vX/9e7A8earU1RKciGeVrLJQ5eEBYZcLVdCs0VZCn9J2
         TgyQAEZnEMP8W2+DicdVzqzTIig3hIOY7E0TCe3h7qBLhU7TvyPO2I5aixBt5da9kelr
         cunWuSleHOeJTpYFuKYNyHfSaQXKSe5MWxc2fmYHnvzxgw55UJ0qdSVPLOYYVphzz3hS
         4ysA==
X-Gm-Message-State: AOJu0YxKhADTJh+egX8BR/BD/PTaLJ8kiGYmAapUpOzeD2wqTB4O7SwZ
	MmzUDMJ4+7gXUjnrsrog4wSyC8ndWudl9uDjT3nZ1yke87yOeSy+ezK2YV1Z8Tk=
X-Google-Smtp-Source: AGHT+IGQDDvi0nQm2LKN1FN5Xsdfd2r2dpsHXCgjMV2oT+Qu4tt+o+vkCWAteYgg8Q0PqZfgB1k+xQ==
X-Received: by 2002:a05:6512:48d0:b0:52b:6ccf:e631 with SMTP id 2adb3069b0e04-52b7d436ebfmr133229e87.41.1717013858365;
        Wed, 29 May 2024 13:17:38 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:a2ed:fbea:c7f7:f383? ([2001:67c:2fbc:0:a2ed:fbea:c7f7:f383])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6349a5ec60sm197494066b.95.2024.05.29.13.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 13:17:37 -0700 (PDT)
Message-ID: <59cf61cc-d862-4fbc-9b36-a6c051389763@openvpn.net>
Date: Wed, 29 May 2024 22:19:04 +0200
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
 <75ff57a6-dcd8-47f7-99bf-f46a1daee4b0@openvpn.net> <Zlda5GcgKd9Y9O_o@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Zlda5GcgKd9Y9O_o@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/05/2024 18:42, Sabrina Dubroca wrote:
> 2024-05-28, 22:09:37 +0200, Antonio Quartulli wrote:
>> On 28/05/2024 18:42, Sabrina Dubroca wrote:
>>> 2024-05-06, 03:16:28 +0200, Antonio Quartulli wrote:
>>>> @@ -303,10 +427,28 @@ static struct ovpn_peer *ovpn_peer_get_by_id_p2p(struct ovpn_struct *ovpn,
>>>>    struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id)
>>>>    {
>>>> -	struct ovpn_peer *peer = NULL;
>>>> +	struct ovpn_peer *tmp, *peer = NULL;
>>>> +	struct hlist_head *head;
>>>> +	u32 index;
>>>>    	if (ovpn->mode == OVPN_MODE_P2P)
>>>> -		peer = ovpn_peer_get_by_id_p2p(ovpn, peer_id);
>>>> +		return ovpn_peer_get_by_id_p2p(ovpn, peer_id);
>>>> +
>>>> +	index = ovpn_peer_index(ovpn->peers.by_id, &peer_id, sizeof(peer_id));
>>>> +	head = &ovpn->peers.by_id[index];
>>>> +
>>>> +	rcu_read_lock();
>>>> +	hlist_for_each_entry_rcu(tmp, head, hash_entry_id) {
>>>> +		if (tmp->id != peer_id)
>>>> +			continue;
>>>> +
>>>> +		if (!ovpn_peer_hold(tmp))
>>>> +			continue;
>>>
>>> Can there ever be multiple peers with the same id? (ie, is it worth
>>> continuing the loop if this fails? the same question probably applies
>>> to ovpn_peer_get_by_transp_addr as well)
>>
>> Well, not at the same time, but theoretically we could re-use the ID of a
>> peer that is being released (i.e. still in the list but refcnt at 0) because
>> it won't be returned by this lookup.
>>
>> This said, I truly believe it's impossible for a peer to have refcnt 0 and
>> still being in the list:
>> Either
>> * delete on the peer was not yet called, thus peer is in the list and the
>> last reference wasn't yet dropped
>> * delete on the peer was called, thus peer cannot be in the list anymore and
>> refcnt may or may not be 0...
> 
> Ok, thanks. Let's just keep this code.

ok

> 
> 
>>>> +/**
>>>> + * ovpn_nexthop_from_rt6 - look up the IPv6 nexthop for the given destination
>>>
>>> I'm a bit confused by this talk about "destination" when those two
>>> functions are then used with the source address from the packet, from
>>> a function called "get_by_src".
>>
>> well, in my brain a next hop can exists only when I want to reach a certain
>> destination. Therefore, at a low level, the terms nextop and destination
>> always need to go hand in hand.
>>
>> This said, when implementing RPF (Reverse Path Filtering) I need to imagine
>> that I want to route to the source IP of the incoming packet. If the nexthop
>> I looked up matches the peer the packet came from, then everything is fine.
>>
>> makes sense?
> 
> Yeah, that's fair.
> 
>>
>> [FTR I have already renamed/changed get_by_src into check_by_src, because I
>> don't need to truly extract a peer and get a reference, but I only need to
>> perform the aforementioned comparison.]
> 
> Ok.
> 
>>>> + * @ovpn: the private data representing the current VPN session
>>>> + * @dst: the destination to be looked up
>>>> + *
>>>> + * Looks up in the IPv6 system routing table the IO of the nexthop to be used
>>>
>>> "the IO"?
>>
>> typ0: "the IP"
>>
>>>
>>>> + * to reach the destination passed as argument. IF no nexthop can be found, the
>>>> + * destination itself is returned as it probably has to be used as nexthop.
>>>> + *
>>>> + * Return: the IP of the next hop if found or the dst itself otherwise
>>>
>>> "the dst" tends to refer to a dst_entry, maybe "or @dst otherwise"?
>>
>> it refers to @dst (the function argument). That's basically the case where
>> the destination is "onlink" and thus it is the nexthop (basically the
>> destination is the connected peer).
> 
> I understand that, it's just the wording "the dst" that I'm
> nitpicking. s/dst/addr/ would help easily-confused people like me (for
> both "the dst" and my confusion with source vs destination in
> caller/callee), but I can live with this.

Oh ok, now I understand your concern.
I will reword this part a bit and add a comment in the caller to clarify 
why we invoke nexthop_from_rt4/6 passing the source address as param.

Cheers,

> 

-- 
Antonio Quartulli
OpenVPN Inc.

