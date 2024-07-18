Return-Path: <netdev+bounces-112082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7DC934DE9
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C680E284AB7
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEC613C80F;
	Thu, 18 Jul 2024 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="U0kMc8l8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5704912F5A1
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721308751; cv=none; b=XNwn227SOhCgb1w7NFMwH9iN/NnoVOSWUMYdy9esxn1LPeh1j4X6UG0k0lY1ZF4OvL8Nvh8DQt52vjZOo8nXqmec9lnc5rSRKIOcEm485V1KujC8oieTEwiiWAnEaivhHmE+UeITvD/T91Xp3vcLzUutEq0zTfKsCXFx2o8PcbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721308751; c=relaxed/simple;
	bh=ClKueRk0MUJAHH8Hzj2x3tcyKOpjItVkVOXBJWEUBOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCzNbHS/Q1s2xD5jixf1JB9RId59xR/GDtYwP/21QNqUWMw4OPnxz0W6Ts86Uq7ZaBTYil2ouABIJXkRo1H6yEoKJjPtu/xz6TDU/H188mjXDR7BwzSkzLohZgfXhrCHzqfhB9zU/9KWpKSA8bn0x2KcRhQta5t9bYY73V0L5qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=U0kMc8l8; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52e9b9fb3dcso353622e87.1
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 06:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1721308747; x=1721913547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=geq14mn0u2rMKIh/uKRDNrrJYvaNsas8PKEC6mko0n4=;
        b=U0kMc8l80tEBDZQQLW3wfIt09+nMUk4iKRGFENnU7wCtFW3+UKIQwz3P6E2/5XOAX7
         2FO4bdPws+ACQi4u/PnZ00NL6oJqbxuy+u2n4T39WHLaNyFC/vXDZVJNpPTYKzWGXpfk
         /FYEU+HVrpxhnZaGAgekH/dCaFyZ/Ig61LjufEdOFMyu6t7U5T3f8tSbjVOHBPYwmF6y
         96GbKwBgfjAfP40xi7lw406Xh1mbfguzmItKPgJadkkzDtUyR1m+pcCn58jbeAOI2wlJ
         Xi8XHhSRQvnRwsvTKjnbaR+B7kOMDVSXQojMZzOHYWSkAyz+62lrv45oUfom6XC3TA8F
         Wn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721308747; x=1721913547;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geq14mn0u2rMKIh/uKRDNrrJYvaNsas8PKEC6mko0n4=;
        b=qM9XyzhEoqoy1luzHifRdChtZqxgpe+x28kFDmYxmHakr/Lo0k+JddOXbovqvQcmqg
         EZ/c0RsWy1NKQaEzwtLb2O2Ysx17XrANVJOXQmVH6rK+/H0Pz77hqSoIQLhogpPp2Crl
         HdrnV5Ne9t7XdYCLAr7IL38owDiunlFYxH3J2Q6IcgSoTXWO8IRURQFG26eWpFbvzgYD
         7n7gZG9TAkbhNRQQVTlmbuPW3UFZXX2XuN4loCClIWq6GXPk2ui+m15MYaKj5bs7aPFD
         0Y6GUABvpKNj/j01E4ofsOV8F6yTHdDCg1R2rJ9OKJV2iHJH6PX/cUVcMzkacIBL40Dr
         u2Xw==
X-Gm-Message-State: AOJu0Yziq8dpHGopZ2wnpYbGZniibeNyszRWPuAVwXlmYWj47Fi1oPK/
	s3k1I7wnZel1eCyUUaMhJgQuzgjSWZsA9sWI3m3REqQtOBshMKxDK+VmHc7LEbA=
X-Google-Smtp-Source: AGHT+IG0dyqs0QtsjEAhcdVjCRZ7hgzv7ZJnUgKYv6brRcewgAPEsXU68B67C8F/68PITBBCBQ1kcQ==
X-Received: by 2002:a05:6512:110a:b0:52c:9f9e:d8e3 with SMTP id 2adb3069b0e04-52ee53c95b0mr3389124e87.31.1721308747213;
        Thu, 18 Jul 2024 06:19:07 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:14d5:6a6d:7aec:1e83? ([2001:67c:2fbc:1:14d5:6a6d:7aec:1e83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f3283sm560122966b.98.2024.07.18.06.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 06:19:06 -0700 (PDT)
Message-ID: <daf370fa-0509-4e49-a2dc-90632d429112@openvpn.net>
Date: Thu, 18 Jul 2024 15:21:07 +0200
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
 <5d49ef6c-ad35-4199-b5af-0caae5a04e85@openvpn.net> <Zpj4jqhGMGPG-6Kq@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Zpj4jqhGMGPG-6Kq@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/07/2024 13:12, Sabrina Dubroca wrote:
>> How do I test running encap_rcv in parallel?
>> This is actually an interesting case that I thought to not be possible (no
>> specific reason for this..).
> 
> It should happen when the packets come from different source IPs and
> the NIC has multiple queues, then they can be spread over different
> CPUs. But it's probably not going to be easy to land multiple packets
> in ovpn_peer_float at the same time to trigger this issue.

I see. Yeah, this is not easy.

> 
> 
>>>> +	netdev_dbg(peer->ovpn->dev, "%s: peer %d floated to %pIScp", __func__,
>>>> +		   peer->id, &ss);
>>>> +	ovpn_peer_reset_sockaddr(peer, (struct sockaddr_storage *)&ss,
>>>> +				 local_ip);
>>>> +
>>>> +	spin_lock_bh(&peer->ovpn->peers->lock);
>>>> +	/* remove old hashing */
>>>> +	hlist_del_init_rcu(&peer->hash_entry_transp_addr);
>>>> +	/* re-add with new transport address */
>>>> +	hlist_add_head_rcu(&peer->hash_entry_transp_addr,
>>>> +			   ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
>>>> +					      &ss, salen));
>>>
>>> That could send a concurrent reader onto the wrong hash bucket, if
>>> it's going through peer's old bucket, finds peer before the update,
>>> then continues reading after peer is moved to the new bucket.
>>
>> I haven't fully grasped this scenario.
>> I am imagining we are running ovpn_peer_get_by_transp_addr() in parallel:
>> reader gets the old bucket and finds peer, because ovpn_peer_transp_match()
>> will still return true (update wasn't performed yet), and will return it.
> 
> The other reader isn't necessarily looking for peer, but maybe another
> item that landed in the same bucket (though your hashtables are so
> large, it would be a bit unlucky).
> 
>> At this point, what do you mean with "continues reading after peer is moved
>> to the new bucket"?
> 
> Continues iterating, in hlist_for_each_entry_rcu inside
> ovpn_peer_get_by_transp_addr.
> 
> ovpn_peer_float                          ovpn_peer_get_by_transp_addr
> 
>                                           start lookup
>                                           head = ovpn_get_hash_head(...)
>                                           hlist_for_each_entry_rcu
>                                           ...
>                                           find peer on head
> 
> peer moved from head to head2
> 
>                                           continue hlist_for_each_entry_rcu with peer->next
>                                           but peer->next is now on head2
>                                           keep walking ->next on head2 instead of head
> 

Ok got it.
Basically we might move the reader from a list to another without it 
noticing.

Will have a look at the pointer provided by Paolo and modify this code 
accordingly.

Thanks!


-- 
Antonio Quartulli
OpenVPN Inc.

