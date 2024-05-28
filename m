Return-Path: <netdev+bounces-98755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7058D24E7
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 21:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DB31C24E2D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 19:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353A217B4E0;
	Tue, 28 May 2024 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Bie+SlvK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433C0178391
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925192; cv=none; b=JPUXVakYFjSe78YIiLxGC7mZJ4iLMDrXKRP8ecKWwIJM6C/c3YHDisspRtYp5JHdeP8lo3t0Nj1GeiDeNU1rf+Ob7zp8iec1au0UWYfVy40xaydMaiZ0dUWMHcQYThtIhWNL8dtmv5W0W/1ymWUi+CNnspGI4OYt14Du5k64c2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925192; c=relaxed/simple;
	bh=Ej6rGybMmGVz1wAc1FGQLNZ1c9PE38lo+gkc140CoH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUCvI+c5H/1KqxhHpodP/++VzKmGc2aqs6qgueswnZMsULPWy5xp1fjTNTnARmOpNUTYDSDS0n+pI/5tNMeE6n4V7ScRwm5QzMYMfZbPbTtX5TkVnO/SocBo0wWgF1ho4+EKy3DZsYBMQyI4w0T0xH6cPDlJTjardpL0pCtGfns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Bie+SlvK; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-354de3c5d00so83252f8f.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 12:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1716925187; x=1717529987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5UXA+gNMapVHKvX2KeVzOX1aK6j2eerw3c21vePnfPQ=;
        b=Bie+SlvK8QTOHG/CtxZCp6ZFCaNz6v9T23YmwPqTuA5GCCwLe7sUMa6bjs3mJlfvaP
         Km1T0++1y+CQzo0YZLR3yfKaSFOBaM/yYJ4xEQqfO4pq9B9i+Rvm7TYBGWduWBasOVln
         S8iJp5aQJK49Mb4TwjJpczUilejdAONneRwVT62dFOJpfIui7LKVNT1e/Ux6l0eW8al8
         g4A2rTffCQtZH1XnF2KmB41RhnZohrN7RSEibdfcQoVbcIwrvclsxvKsBFNfgEYZ09RM
         D1lnsDq9gj7luX4jOTlXUJkkAsIDjw4P2IgJtXjh3WJ0nzH1wS1w5JZ4yozWJpuG273A
         DBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716925187; x=1717529987;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UXA+gNMapVHKvX2KeVzOX1aK6j2eerw3c21vePnfPQ=;
        b=TxWr26fE7oWonTz/ptGZV1psMYXwtuEfXwJsXSlnKk9l1F+R8eWyLEFGQB//e+Xmg4
         GT5xrlQNoM0i24Pu7ZpP4tBGycJbmOJlwOx0p+q8dcev8WEORWK75ar1lXDE+Uf90+BB
         5m8gF3e11SLPorTQf7ycV9vyHZHaXneUW5wos6j/to4F74S108Wll535Jfi6KBfjusf4
         wQbb3YRDW49Mo8Yd4xVnB8pi0vxGzH7aTPRin1on17RrwyzC1zxHvPRU9HOJxw9bQwrH
         CVVMmJ6FGDSRq1CuzKnSr28v2/eN6BJupUoJU/qHa51gxNEFNDLFVFB+simjl/upRP6H
         mfzw==
X-Gm-Message-State: AOJu0YxjCxhFEtP82DrghxkivGn8oErpDIXJsbdrjsZnMDVm3EyOo4tf
	5QVQLWtdbuMinc3qlzUm4iXT2IF5oLiUEPBqVPOE6YR1ou8MuDVoaf/tY0lb7dA=
X-Google-Smtp-Source: AGHT+IEhNYyQ0GBiaLAbTBjceepCBkLcF5VD5k2VRrgbcIZf26rfyrV932Y7mAkR3WnrCJKYFMu9gg==
X-Received: by 2002:adf:eb11:0:b0:34d:8206:e76b with SMTP id ffacd0b85a97d-35c79c71ccfmr48182f8f.9.1716925187318;
        Tue, 28 May 2024 12:39:47 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:166f:d3a:3b2:a599? ([2001:67c:2fbc:0:166f:d3a:3b2:a599])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c92e7sm12564502f8f.66.2024.05.28.12.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 12:39:46 -0700 (PDT)
Message-ID: <de937f69-b5ae-4d4f-b16a-e18fa70a8e7b@openvpn.net>
Date: Tue, 28 May 2024 21:41:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 14/24] ovpn: implement multi-peer support
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-15-antonio@openvpn.net> <ZlXtyn2Sgk_W8h92@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZlXtyn2Sgk_W8h92@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/05/2024 16:44, Sabrina Dubroca wrote:
> Hi Antonio, I took a little break but I'm looking at your patches
> again now.

Thanks Sabrina! Meanwhile I have been working on all your suggested changes.
Right now I am familiarizing with the strparser.

> 
> 2024-05-06, 03:16:27 +0200, Antonio Quartulli wrote:
>> diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
>> index 7414c2459fb9..58166fdeac63 100644
>> --- a/drivers/net/ovpn/ovpnstruct.h
>> +++ b/drivers/net/ovpn/ovpnstruct.h
>> @@ -31,6 +35,12 @@ struct ovpn_struct {
>>   	spinlock_t lock; /* protect writing to the ovpn_struct object */
>>   	struct workqueue_struct *crypto_wq;
>>   	struct workqueue_struct *events_wq;
>> +	struct {
>> +		DECLARE_HASHTABLE(by_id, 12);
>> +		DECLARE_HASHTABLE(by_transp_addr, 12);
>> +		DECLARE_HASHTABLE(by_vpn_addr, 12);
> 
> Those are really big. I guess for large servers they make sense, but
> you're making clients hold 98kB in memory that they're not going to use.

Right - for clients it doesn't make sense.

> 
> Maybe they could be dynamically sized, but I think struct peers should
> be allocated on demand (only for mode == MP) if you want this size.

Yeah, makes sense. I'll allocate it dynamically then.

> 
>> +		spinlock_t lock; /* protects writes to peers tables */
>> +	} peers;
>>   	struct ovpn_peer __rcu *peer;
>>   	struct list_head dev_list;
>>   };
>> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
>> index 99a2ae42a332..38a89595dade 100644
>> --- a/drivers/net/ovpn/peer.c
>> +++ b/drivers/net/ovpn/peer.c
>> @@ -361,6 +362,91 @@ struct ovpn_peer *ovpn_peer_get_by_src(struct ovpn_struct *ovpn,
>>   	return peer;
>>   }
>>   
>> +/**
>> + * ovpn_peer_add_mp - add per to related tables in a MP instance
>                               ^
>                               s/per/peer/

ACK

> 
>> + * @ovpn: the instance to add the peer to
>> + * @peer: the peer to add
>> + *
>> + * Return: 0 on success or a negative error code otherwise
>> + */
>> +static int ovpn_peer_add_mp(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
>> +{
> [...]
>> +	index = ovpn_peer_index(ovpn->peers.by_id, &peer->id, sizeof(peer->id));
>> +	hlist_add_head_rcu(&peer->hash_entry_id, &ovpn->peers.by_id[index]);
>> +
>> +	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
>> +		index = ovpn_peer_index(ovpn->peers.by_vpn_addr,
>> +					&peer->vpn_addrs.ipv4,
>> +					sizeof(peer->vpn_addrs.ipv4));
>> +		hlist_add_head_rcu(&peer->hash_entry_addr4,
>> +				   &ovpn->peers.by_vpn_addr[index]);
>> +	}
>> +
>> +	hlist_del_init_rcu(&peer->hash_entry_addr6);
> 
> Why are hash_entry_transp_addr and hash_entry_addr6 getting a
> hlist_del_init_rcu() call, but not hash_entry_id and hash_entry_addr4?

I think not calling del_init_rcu on hash_entry_addr4 was a mistake.

Calling del_init_rcu on addr4, addr6 and transp_addr is needed to put 
them in a known state in case they are not hashed.

While hash_entry_id always goes through hlist_add_head_rcu, therefore 
del_init_rcu is useless (to my understanding).

> 
>> +	if (memcmp(&peer->vpn_addrs.ipv6, &in6addr_any,
>> +		   sizeof(peer->vpn_addrs.ipv6))) {
> 
> !ipv6_addr_any(&peer->vpn_addrs.ipv6)

ACK

> 
>> +		index = ovpn_peer_index(ovpn->peers.by_vpn_addr,
>> +					&peer->vpn_addrs.ipv6,
>> +					sizeof(peer->vpn_addrs.ipv6));
>> +		hlist_add_head_rcu(&peer->hash_entry_addr6,
>> +				   &ovpn->peers.by_vpn_addr[index]);
>> +	}
>> +
> 

-- 
Antonio Quartulli
OpenVPN Inc.

