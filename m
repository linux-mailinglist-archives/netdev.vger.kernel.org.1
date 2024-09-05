Return-Path: <netdev+bounces-125425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD8C96D120
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2201C24822
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 08:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F0A193091;
	Thu,  5 Sep 2024 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BAC0/9J8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0581925B5
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523257; cv=none; b=NFAILK+v3ORSg2hrMAQEGiH32Jp/M9wANzKbt/7NP/cb1IBHFfkM2wRWznYTLGDr7HI1b1fcVnuheb/AS73q+3LNBUvTTv4lqk4P9GMKhmW6fNlp9/2GHxaeKJ3yZoHqpn6FBhH6R7oFMdnBvglgJh5gr+eZt3adWjy0xkeDys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523257; c=relaxed/simple;
	bh=cZvWSc4qPXAzLEyGkXCuxvj4Dd/ms2EHIfkOJHMZICU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+fTsrrmMYXDmjZl8xkFtWOKKeiNUVtzDPZ4atybdfUiOv3ReMAKuAzt3UGRJdZ9ObT/LA0xH3odhxEZrUrbJpSer5XVFVaPu3nMyvbgQuT40sojLSn6Hi7QakYBxe5B+gefFfokLU+jsuAxyKn9lmeZuP47gB/vqlRgjIhd464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BAC0/9J8; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5356ab89665so456680e87.1
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 01:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1725523253; x=1726128053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pE/HfFqpTRxVl8QxYaqS5s35+3YOi44MNREJZhifOe4=;
        b=BAC0/9J89GSMuY/vJr7k6E0taaBdZorwB1plIDkpRYlrIU3dI5OIwZEn2wJcedZN/0
         lWs/4S2u7AmXEIQl4iBh8oaY+fvYz65WlfQ0tqsPjGfFegcqD7SX4X33zxvXB5gfUe0z
         X1lxWo9VrY18eNnasQTsOziDfRha65wWZBostVze85vcvTdJY8xuBu2on83yxNdeAGOt
         Ve+OqxEKO6kryDBGcubAz7WhLtnoRurF7LIQBwmHUoMGReHy536lQEraOjJFYdS1tjPK
         7kDfHNzG4iaejvlIgoS7sWx4bCAY6Tz9qYb6o9PxYwYNPblNDpwCDNP4BhrHkEqTnsKY
         CRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725523253; x=1726128053;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pE/HfFqpTRxVl8QxYaqS5s35+3YOi44MNREJZhifOe4=;
        b=HrESIOwWlkwJ6aiG8q6q+58fd2puBqKNqgS9c4nO9L+wh8IS1A9OQs/HKciyF0s4Pj
         XJ1wz5N4HWzOitMJrxAQfDtUgkmPoIz18jeGNqboUujy7F1YqrxD5y+bJe3F1ExPoxEY
         JuZGc2YSwdWGcDqF0mwKBB/kYTIw2vrrABGloS1gtkSeDPXsWzNYN61clxqvPjVJHne2
         VEJCz1oGZ6m/6xT8yeUFvsdYN3QBQi1UVb7oC2Hfi+oDrKmKTDeKGSG4qIQm6+tnv/+b
         eY9dVOEsynEI3PAxPl076O8cWshY7fPL4VfCKRT3i21uIUajyVy9NwE/AiIxHbTkFAjc
         dZdg==
X-Gm-Message-State: AOJu0YzJq6egu97/JkIgrJo4Y5DKAuZN6kD2GhpLcI8MlrSyyPfmgi4e
	Vq3SAOZW07IP+YD8ULirxwVrRS6pOuaNtBVVaoMSuVk0M3h7ZJ9ISRKkhc2meMA=
X-Google-Smtp-Source: AGHT+IFgozaP/fT6Oqx2dA/1d3fnkrB1BAFvqHYabN7tioMOPS3zRWs/yngemnWONIXly5y7cT+/gA==
X-Received: by 2002:a05:6512:3087:b0:530:e1ee:d95 with SMTP id 2adb3069b0e04-53546afd6f4mr12590242e87.1.1725523252802;
        Thu, 05 Sep 2024 01:00:52 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:d1ae:dbbe:c799:237b? ([2001:67c:2fbc:1:d1ae:dbbe:c799:237b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33f5esm222656445e9.39.2024.09.05.01.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 01:00:52 -0700 (PDT)
Message-ID: <79b087fc-1e73-4ce5-82cb-b309326ae78e@openvpn.net>
Date: Thu, 5 Sep 2024 10:02:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 15/25] ovpn: implement multi-peer support
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-16-antonio@openvpn.net> <Ztcf88I1epYlIYGS@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Ztcf88I1epYlIYGS@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2024 16:40, Sabrina Dubroca wrote:
> 2024-08-27, 14:07:55 +0200, Antonio Quartulli wrote:
>>   static int ovpn_net_init(struct net_device *dev)
>>   {
>>   	struct ovpn_struct *ovpn = netdev_priv(dev);
>> +	int i, err = gro_cells_init(&ovpn->gro_cells, dev);
> 
> I'm not a fan of "hiding" the gro_cells_init call up here. I'd prefer
> if this was done just before the corresponding "if (err)".

I am all with you, but I remember in the past something complaining 
about "variable declared and then re-assigned right after".

But maybe this is not the case anymore.

Will move the initialization down.

> 
>> +	struct in_device *dev_v4;
>>   
>> -	return gro_cells_init(&ovpn->gro_cells, dev);
>> +	if (err)
>> +		return err;
>> +
>> +	if (ovpn->mode == OVPN_MODE_MP) {
>> +		dev_v4 = __in_dev_get_rtnl(dev);
>> +		if (dev_v4) {
>> +			/* disable redirects as Linux gets confused by ovpn
>> +			 * handling same-LAN routing.
>> +			 * This happens because a multipeer interface is used as
>> +			 * relay point between hosts in the same subnet, while
>> +			 * in a classic LAN this would not be needed because the
>> +			 * two hosts would be able to talk directly.
>> +			 */
>> +			IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
>> +			IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) = false;
>> +		}
>> +
>> +		/* the peer container is fairly large, therefore we dynamically
>> +		 * allocate it only when needed
>> +		 */
>> +		ovpn->peers = kzalloc(sizeof(*ovpn->peers), GFP_KERNEL);
>> +		if (!ovpn->peers)
> 
> missing gro_cells_destroy

ACK

> 
>> +			return -ENOMEM;
>> +
>> +		spin_lock_init(&ovpn->peers->lock_by_id);
>> +		spin_lock_init(&ovpn->peers->lock_by_vpn_addr);
>> +		spin_lock_init(&ovpn->peers->lock_by_transp_addr);
> 
> What's the benefit of having 3 separate locks instead of a single lock
> protecting all the hashtables?

The main reason was to avoid a deadlock - I thought I had added a 
comment about it...

The problem was a deadlock between acquiring peer->lock and 
ovpn->peers->lock in float() and in then opposite sequence in peers_free().
(IIRC this happens due to ovpn_peer_reset_sockaddr() acquiring peer->lock)

Splitting the larger peers->lock allowed me to avoid this scenario, 
because I don't need to jump through any hoop to coordinate access to 
different hashtables.

> 
>> +
>> +		for (i = 0; i < ARRAY_SIZE(ovpn->peers->by_id); i++) {
>> +			INIT_HLIST_HEAD(&ovpn->peers->by_id[i]);
>> +			INIT_HLIST_HEAD(&ovpn->peers->by_vpn_addr[i]);
>> +			INIT_HLIST_NULLS_HEAD(&ovpn->peers->by_transp_addr[i],
>> +					      i);
>> +		}
>> +	}
>> +
>> +	return 0;
>>   }
> 
>> +static int ovpn_peer_add_mp(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
>> +{
>> +	struct sockaddr_storage sa = { 0 };
>> +	struct hlist_nulls_head *nhead;
>> +	struct sockaddr_in6 *sa6;
>> +	struct sockaddr_in *sa4;
>> +	struct hlist_head *head;
>> +	struct ovpn_bind *bind;
>> +	struct ovpn_peer *tmp;
>> +	size_t salen;
>> +
>> +	spin_lock_bh(&ovpn->peers->lock_by_id);
>> +	/* do not add duplicates */
>> +	tmp = ovpn_peer_get_by_id(ovpn, peer->id);
>> +	if (tmp) {
>> +		ovpn_peer_put(tmp);
>> +		spin_unlock_bh(&ovpn->peers->lock_by_id);
>> +		return -EEXIST;
>> +	}
>> +
>> +	hlist_add_head_rcu(&peer->hash_entry_id,
>> +			   ovpn_get_hash_head(ovpn->peers->by_id, &peer->id,
>> +					      sizeof(peer->id)));
>> +	spin_unlock_bh(&ovpn->peers->lock_by_id);
>> +
>> +	bind = rcu_dereference_protected(peer->bind, true);
>> +	/* peers connected via TCP have bind == NULL */
>> +	if (bind) {
>> +		switch (bind->remote.in4.sin_family) {
>> +		case AF_INET:
>> +			sa4 = (struct sockaddr_in *)&sa;
>> +
>> +			sa4->sin_family = AF_INET;
>> +			sa4->sin_addr.s_addr = bind->remote.in4.sin_addr.s_addr;
>> +			sa4->sin_port = bind->remote.in4.sin_port;
>> +			salen = sizeof(*sa4);
>> +			break;
>> +		case AF_INET6:
>> +			sa6 = (struct sockaddr_in6 *)&sa;
>> +
>> +			sa6->sin6_family = AF_INET6;
>> +			sa6->sin6_addr = bind->remote.in6.sin6_addr;
>> +			sa6->sin6_port = bind->remote.in6.sin6_port;
>> +			salen = sizeof(*sa6);
>> +			break;
>> +		default:
> 
> And remove from the by_id hashtable? Or is that handled somewhere that
> I missed (I don't think ovpn_peer_unhash gets called in that case)?

No we don't call unhash in this case as we assume the adding just failed 
entirely.

I will add the removal before returning the error (moving the add below 
the switch would extend the locked area too much.)

> 
>> +			return -EPROTONOSUPPORT;
>> +		}
>> +
> 

Thanks a lot

-- 
Antonio Quartulli
OpenVPN Inc.

