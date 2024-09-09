Return-Path: <netdev+bounces-126453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4126E9712FF
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B41DAB20CAB
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CC61B29D8;
	Mon,  9 Sep 2024 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NwYOtw3o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FC81B14FB
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873008; cv=none; b=gVHHFmhJzRMfyF09ijpFPb6HnbXyM7owLNov2TphIZ+T4jSgpuhDEjQR2UnVb8O+xBqoyiN9YRmnqGI+Xtu/9HXL1BURRA6wTbKcma7OC5e6Yh1n6mbSTISx6L46hGMFmJqn1qdfXaJvnDqt2TYOtKg0qzvat4mJxBVy7gvTqMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873008; c=relaxed/simple;
	bh=0uzjIxWlej1f72pk6UOHJEMCw8eFkML/ygWmTGIXamI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2caECB8GKjkTngQP3dVcc+OUMIorAVGHOM5VLgl1oyVwR05cbBpGy4+TN88ugTzlwv20cOKRc2qoEwVYglizOMCW13zBf7J3maCPvjowpYMAaf5rnPW3dll6Z0AscBMCF0/G+e7C7wTf9NQ3Aq026SI6m4C31++IV1MGeYRyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NwYOtw3o; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53653682246so5002626e87.1
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 02:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1725873004; x=1726477804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fHBchIktHtRU+SEpMh+JKeTsPR8iQotACkYYCFNPEAs=;
        b=NwYOtw3o736bV4sDfFz8RPb8zOt4ftjSMzsMYGaLXc2B3aj0VYwywZ3AJg6zXe/yMC
         mx1pTYj9m8M1aYic8Du2DtB7okq2wt43/F3UL3YNLmLB3sAOQdCnd4T9ksnSTs0veckL
         o4Ih0fMwE57SbZKd7UYtX2qUfUwmo6J1Cn/BgMG9VtPfxEir2u/8C2jDCR4RBmwQrA6I
         LgLn7M/Z6uUl0n4z77DwLqmaAfXEFXU+PzhYZJPzhOSGgWFJ8toJ2VRgUV5k6hcoPZyg
         CBlPFGhokjzbva5WJnIQJPQKcxq8Y+sx7TICv8hhc4Odlm6jxJQMlBqaIZtaOOPp/qS5
         a7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725873004; x=1726477804;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHBchIktHtRU+SEpMh+JKeTsPR8iQotACkYYCFNPEAs=;
        b=g9eDX8mSTTUDleEIC19tiKcX0mfhZf/Rnk6QOk88E2oNEa7nlo+cwDryooRrj0M/gc
         OTzJfB/yTFf6Zcoz1rXHMie6teWC6amaq3B6lOnRIPXwghlRiDwVvt2WwC+sc8nyG/g0
         P3+4vwBCqDAJ9ko9oIzHMUfJmR6VkY+PIeMTHPQZcuTbZcyRWI1Lkco5ZpCKxwgU+oVM
         JEEvx9Wt36aS+NRjWr3YRA6QYjOJUWwoYvFS6IHCmzQFssD7/MA/H2CfAdnlpIz/86Ik
         w0znW64k+0yc+a7ek6PpG3tdSPhGZAlFgmjxHKWaDWJk90pb9Sudpc5Gc1vKq8mT5ObV
         iLsw==
X-Gm-Message-State: AOJu0YySScKEfBffo+PiDS5vXlkXFezztGGcl8KU7AP0nOXkepkxdTn2
	K0iqFdeUep9Ze6S7PwEO+lunR4++F4jiT9Bqj/w6QdlK0sa/O8DOf4q1GAM2wmULBP+LuXph6jp
	8
X-Google-Smtp-Source: AGHT+IFFd1HbENBZephVYFiyjD9N/AAdnDChz087gmOxKbyA7moH/uuR2gn4/TyzwQsntFDNC2bjtw==
X-Received: by 2002:a05:6512:10d0:b0:535:65ce:e901 with SMTP id 2adb3069b0e04-536587a353dmr7565008e87.4.1725873003725;
        Mon, 09 Sep 2024 02:10:03 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:105f:6dd9:35c9:a9e8? ([2001:67c:2fbc:1:105f:6dd9:35c9:a9e8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2595122asm312927666b.65.2024.09.09.02.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 02:10:03 -0700 (PDT)
Message-ID: <3a7b063d-5dc8-45d9-9064-cfd951da59eb@openvpn.net>
Date: Mon, 9 Sep 2024 11:12:12 +0200
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
 <79b087fc-1e73-4ce5-82cb-b309326ae78e@openvpn.net> <ZtmMKDPZzsFdbTpq@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZtmMKDPZzsFdbTpq@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/09/2024 12:47, Sabrina Dubroca wrote:
>>>> +
>>>> +		spin_lock_init(&ovpn->peers->lock_by_id);
>>>> +		spin_lock_init(&ovpn->peers->lock_by_vpn_addr);
>>>> +		spin_lock_init(&ovpn->peers->lock_by_transp_addr);
>>>
>>> What's the benefit of having 3 separate locks instead of a single lock
>>> protecting all the hashtables?
>>
>> The main reason was to avoid a deadlock - I thought I had added a comment
>> about it...
> 
> Ok.
> 
> I could have missed it, I'm not looking at the comments much now that
> I'm familiar with the code.
> 
>> The problem was a deadlock between acquiring peer->lock and
>> ovpn->peers->lock in float() and in then opposite sequence in peers_free().
>> (IIRC this happens due to ovpn_peer_reset_sockaddr() acquiring peer->lock)
> 
> I don't see a problem with ovpn_peer_reset_sockaddr, but ovpn_peer_put
> can be called with lock_by_id held and then take peer->lock (in
> ovpn_peer_release), which would be the opposite order to
> ovpn_peer_float if the locks were merged (peer->lock then
> lock_by_transp_addr).
> 
> This should be solvable with a single lock by delaying the bind
> cleanup via call_rcu instead of doing it immediately with
> ovpn_peer_release (after that delay, nothing should be using
> peer->bind anymore, since we have no reference and no more
> rcu_read_lock sections that could have found peer, so we can free
> immediately and no need to take peer->lock). And it's I think a bit
> more "correct" wrt RCU rules, since at ovpn_peer_put time, even with
> refcount=0, we could have a reader still using the peer and deciding
> to update its bind (not the case with how ovpn_peer_float is called,
> since we have a reference on the peer).

Yap, I totally agree with your analysis.

In a previous version we simplified the code to the point that call_rcu 
was not needed anymore and we could just rely on kfree_rcu for peer.

Now this "going back to call_rcu" felt a bit wrong, so I tried hard to 
avoid that.
But I agree that actually this is a clear case where a two-steps release 
is the right thing to do.

Will try to get it fixed as per your suggestion. Thanks!

> 
> (This could be completely wrong and/or make no sense at all :))
> 
> But I'm not going to insist on this, you can keep the separate locks.
> 
> 
>> Splitting the larger peers->lock allowed me to avoid this scenario, because
>> I don't need to jump through any hoop to coordinate access to different
>> hashtables.
>>
>>>
>>>> +
>>>> +		for (i = 0; i < ARRAY_SIZE(ovpn->peers->by_id); i++) {
>>>> +			INIT_HLIST_HEAD(&ovpn->peers->by_id[i]);
>>>> +			INIT_HLIST_HEAD(&ovpn->peers->by_vpn_addr[i]);
>>>> +			INIT_HLIST_NULLS_HEAD(&ovpn->peers->by_transp_addr[i],
>>>> +					      i);
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return 0;
>>>>    }
>>>
>>>> +static int ovpn_peer_add_mp(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
>>>> +{
>>>> +	struct sockaddr_storage sa = { 0 };
>>>> +	struct hlist_nulls_head *nhead;
>>>> +	struct sockaddr_in6 *sa6;
>>>> +	struct sockaddr_in *sa4;
>>>> +	struct hlist_head *head;
>>>> +	struct ovpn_bind *bind;
>>>> +	struct ovpn_peer *tmp;
>>>> +	size_t salen;
>>>> +
>>>> +	spin_lock_bh(&ovpn->peers->lock_by_id);
>>>> +	/* do not add duplicates */
>>>> +	tmp = ovpn_peer_get_by_id(ovpn, peer->id);
>>>> +	if (tmp) {
>>>> +		ovpn_peer_put(tmp);
>>>> +		spin_unlock_bh(&ovpn->peers->lock_by_id);
>>>> +		return -EEXIST;
>>>> +	}
>>>> +
>>>> +	hlist_add_head_rcu(&peer->hash_entry_id,
>>>> +			   ovpn_get_hash_head(ovpn->peers->by_id, &peer->id,
>>>> +					      sizeof(peer->id)));
>>>> +	spin_unlock_bh(&ovpn->peers->lock_by_id);
>>>> +
>>>> +	bind = rcu_dereference_protected(peer->bind, true);
>>>> +	/* peers connected via TCP have bind == NULL */
>>>> +	if (bind) {
>>>> +		switch (bind->remote.in4.sin_family) {
>>>> +		case AF_INET:
>>>> +			sa4 = (struct sockaddr_in *)&sa;
>>>> +
>>>> +			sa4->sin_family = AF_INET;
>>>> +			sa4->sin_addr.s_addr = bind->remote.in4.sin_addr.s_addr;
>>>> +			sa4->sin_port = bind->remote.in4.sin_port;
>>>> +			salen = sizeof(*sa4);
>>>> +			break;
>>>> +		case AF_INET6:
>>>> +			sa6 = (struct sockaddr_in6 *)&sa;
>>>> +
>>>> +			sa6->sin6_family = AF_INET6;
>>>> +			sa6->sin6_addr = bind->remote.in6.sin6_addr;
>>>> +			sa6->sin6_port = bind->remote.in6.sin6_port;
>>>> +			salen = sizeof(*sa6);
>>>> +			break;
>>>> +		default:
>>>
>>> And remove from the by_id hashtable? Or is that handled somewhere that
>>> I missed (I don't think ovpn_peer_unhash gets called in that case)?
>>
>> No we don't call unhash in this case as we assume the adding just failed
>> entirely.
>>
>> I will add the removal before returning the error (moving the add below the
>> switch would extend the locked area too much.)
> 
> I don't think setting a few variables would be too much to do under
> the lock (and it would address the issues in my 2nd reply to this
> patch).

Right - pretty much what I replied to that comment (will move the add 
after the bind dereference)

Cheers,


-- 
Antonio Quartulli
OpenVPN Inc.

