Return-Path: <netdev+bounces-144114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7904A9C59D3
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3894C28155F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157821FBF51;
	Tue, 12 Nov 2024 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="d0Ut6873"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D448E1C9DD8
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731420161; cv=none; b=kHaWQ/Y8z4TraFjfj9sXLylV1fdmULuSuVCDfU/4dEOHA+M6jtSV9dGEvG6yQyaBKXGM5WXjinqxbnse7uYLsCwOGrd7rNZ0cj0bylIrliLYEpUqkp95oHy11YrdJ6ZgG6jEtICAH/z9aRYMf63g9RJs/SwKYxyM3IRZe/oT82M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731420161; c=relaxed/simple;
	bh=nMEVI/2NGTjHdzsBkszc/gnXp2l5saGrRrIu/NhMqLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WaN/wp1xF6vPlxwtS9zNauWxtFLJyTuMz7ACdtiI5nDg7fH/jgWgZYO7uFwuD2q/RtPoDeEuzT9vLArglmjSHA6bdvcWv4b32azYOCyZcS5afbm/GolWik5a7nlXT07bvOhINAtqEed3HTqvuPOn8qaAnrEiIlD3llvzmty7Yzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=d0Ut6873; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so71699625e9.2
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 06:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731420157; x=1732024957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w9MgzxSfnAckOlGCT28T2HKEGEX2I2woiTYHMo+I8GU=;
        b=d0Ut68739KCOmRuZJUv0Ee2hfPb7791i1QYf3S6nCj/QADRK6Z746gQSmkqC5qkkNZ
         HXLClFW+J3IXgprGfyeQf0SYhlC/sC1Jn/rTINw5HfaBG4bGsN0LR6P2fzWNNhj4Ok01
         S5+nGjd0qRJjmuH9F552+TKKSbxzG+pRsSHyXByVu3Wg2xs0o3Ark/2FVC2XuCh1PV5o
         4dPLH4l2h5L0XPYoHY3tKp6QdLuUrR+azjJAX4/ZowS2MLpfhBllrvDUZwJF3+1QVWRN
         iAKLJHjVVwGfQdITUwLFMCpTFtLcr7BER2onb/hJoucgpg/LCXfLba6KInepOay8Dp6x
         HDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731420157; x=1732024957;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9MgzxSfnAckOlGCT28T2HKEGEX2I2woiTYHMo+I8GU=;
        b=CMQtJerRKbaMt8r+4pdOUX/aQChS4BQ/UGhF6VaJ1vt64ijsOfXlcQHgZLzxOj3vTI
         nf6jLrk83EK7dniOJc7pnfvuco8vxEkzH1eU9VprFzX8msjA1c3IxjDDIr/xEpIHF+z1
         5sviH/SqeZpkJX9YNU09S/hgKlEhjiQ5MgkvB7HmUlCDp938b6K5qiyh6iBrd8gm6kgo
         f5j5mPJyT5dlVr6Xy0qXIhNGtYk9RLy41118XUqqqZPQ8CyNBkP4YGmrcVbN853wwrsH
         SAzcIdb2My0uQlENfpiczl00cz6Q+aRlQRj0KoiCDJ+l84IM005yge1cgaujjLAIozdp
         0KsA==
X-Forwarded-Encrypted: i=1; AJvYcCXhMdTjhKc/3+Xp8raWOfvehbNwVuttVb+R5Ho6R+cRg/7M8vl0oArDdUAZJN/Nwke3AvCEBpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyOfZAHx0vLocTX7XHCdNwRS5viFRhc+A4e+dXw8LkTzxPyM+C
	COpO7iBnfTCFxC3Hyv4W18rmiYqCJJd5kTwJcHTnHYWSFpK6gBP2AWK+4oH+nPo=
X-Google-Smtp-Source: AGHT+IHCPRgv9M9Dduaty+H4R5FyYxKnOSdODxIf4vXyCrDSG2OprcKhqgaK6fmVVKuI8YWK9vHoxQ==
X-Received: by 2002:a05:600c:5107:b0:431:59b2:f0c4 with SMTP id 5b1f17b1804b1-432b7503e9amr182495555e9.8.1731420156526;
        Tue, 12 Nov 2024 06:02:36 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:e829:c484:5241:93b2? ([2001:67c:2fbc:1:e829:c484:5241:93b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5b2dsm243551985e9.1.2024.11.12.06.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 06:02:35 -0800 (PST)
Message-ID: <955030bd-e230-448c-8a63-1b356590dd15@openvpn.net>
Date: Tue, 12 Nov 2024 15:03:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 17/23] ovpn: add support for peer floating
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-17-de4698c73a25@openvpn.net> <ZzM0U81dmvdEWqdF@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZzM0U81dmvdEWqdF@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2024 11:56, Sabrina Dubroca wrote:
> 2024-10-29, 11:47:30 +0100, Antonio Quartulli wrote:
>> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
>> index 63c140138bf98e5d1df79a2565b666d86513323d..0e8a6f2c76bc7b2ccc287ad1187cf50f033bf261 100644
>> --- a/drivers/net/ovpn/io.c
>> +++ b/drivers/net/ovpn/io.c
>> @@ -135,6 +135,15 @@ void ovpn_decrypt_post(void *data, int ret)
>>   	/* keep track of last received authenticated packet for keepalive */
>>   	peer->last_recv = ktime_get_real_seconds();
>>   
>> +	if (peer->sock->sock->sk->sk_protocol == IPPROTO_UDP) {
> 
> What prevents peer->sock from being replaced and released
> concurrently?

Technically nothing.
Userspace currently does not even support updating a peer socket at 
runtime, but I wanted ovpn to be flexible enough from the beginning.

One approach might be to go back to peer->sock being unmutable and 
forget about this.

OTOH, if we want to keep this flexibility (which I think is nice), I 
think I should make peer->sock an RCU pointer and access it accordingly.
Does it make sense?

> 
> Or possibly reading the error value that ovpn_socket_new can return
> before peer->sock is reset to NULL, just noticed this in
> ovpn_nl_peer_modify:
> 
> 	if (attrs[OVPN_A_PEER_SOCKET]) {
> 		// ...
> 		peer->sock = ovpn_socket_new(sock, peer);
> 		if (IS_ERR(peer->sock)) {
> 			// ...
> 			peer->sock = NULL;
> 
> 
> (ovpn_encrypt_post has a similar check on
> peer->sock->sock->sk->sk_protocol that I don't think is safe either)

Yap, agreed.

> 
> 
>> +		/* check if this peer changed it's IP address and update
>> +		 * state
>> +		 */
>> +		ovpn_peer_float(peer, skb);
>> +		/* update source endpoint for this peer */
>> +		ovpn_peer_update_local_endpoint(peer, skb);
> 
> Why not do both in the same function? They're not called anywhere else
> (at least in this version of the series). They both modify peer->bind
> depending on skb_protocol_to_family(skb), and operate under
> peer->lock.

I never considered to do so as I just always assumed the two to be two 
separate features/routines.

I think it's a good idea and I would get rid of a few common 
instructions (along with acquiring the lock twice). Thanks!

> 
> 
>> +void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb)
>> +{
>> +	struct hlist_nulls_head *nhead;
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
>> +	if (unlikely(!bind)) {
>> +		rcu_read_unlock();
>> +		return;
>> +	}
>> +
>> +	spin_lock_bh(&peer->lock);
> 
> You could take the lock from the start, instead of using rcu_read_lock
> to get peer->bind. It would guarantee that the bind we got isn't
> already being replaced just as we wait to update it. And same in
> ovpn_peer_update_local_endpoint, it would make sure we're updating the
> local IP for the active bind.
> 
> (sorry I didn't think about that last time we discussed this)

no worries :) and I like the idea. will do that, thanks.

> 
>> +	if (likely(ovpn_bind_skb_src_match(bind, skb)))
>> +		goto unlock;
>> +
>> +	family = skb_protocol_to_family(skb);
>> +
> 

-- 
Antonio Quartulli
OpenVPN Inc.


