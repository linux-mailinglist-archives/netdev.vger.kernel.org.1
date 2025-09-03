Return-Path: <netdev+bounces-219493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A664EB41982
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB67200FC3
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8D02E22A3;
	Wed,  3 Sep 2025 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAmE4eSc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94172E2DFA
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756890131; cv=none; b=FvkpDQXI2yhIg/ESybCKFER3S+cl+4iC6ago3LUOqvq/dbs32KNSGENse+Rd39twVI71mQ/CBlQdXiRARgsV/3lSEMiOYD5g6otPUk+6O8a7Y2mbQHEGMhBqLleR1UswxEuUf80QTIMv7W6EnHq0cv/LhZFb+T+IE+LqroGleSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756890131; c=relaxed/simple;
	bh=kre3EFB4xt/id3Zhw2+lNfqfzKQZlM1ySoCdHlM16po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLfAp3rLKwgpcfttReLm5J6ndMkwbH9kInQxcPGEQhzvEx4yTcMLOVt/cfH8b5FGokBQH/6To9rP+g9AxqSpN/hUFc2AQvFLdbw2ybg8QIeJE7/2C9zgjM7dOjbCm82sVxgZnP9lFJovSahwVsyltQcR+CPlgKKSAgmtp5XKJPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZAmE4eSc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756890124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2mVdgxRN8/ShBWQ2NoBttJB/+qU/iW0HWccEkCiy/DY=;
	b=ZAmE4eScWY9/08yImewrN5y3y+K9DHXH2EGJGTxHwAVAwo+2XU3oCU0+n1/D33MI7NdmGt
	uaKOUGxzPd5MawUVsBRjwBoxqqKr2lmiJ38BXzLfmFDPP5EP4dGxpFKmL9ozFzYPYIV2iu
	ZfAfxnPFW6xlK42STvmWM9mRd1Tsx4M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-9dwsUQlUPki2mSFj-0BFLg-1; Wed, 03 Sep 2025 05:01:58 -0400
X-MC-Unique: 9dwsUQlUPki2mSFj-0BFLg-1
X-Mimecast-MFC-AGG-ID: 9dwsUQlUPki2mSFj-0BFLg_1756890112
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b9a856d58so12189415e9.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 02:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756890112; x=1757494912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mVdgxRN8/ShBWQ2NoBttJB/+qU/iW0HWccEkCiy/DY=;
        b=tDbpJCMi2EaTwzFyK0h54k40ggu6VZ8MrIe7uSsMbKvYXOHWewTvaRs3N8TyOeQq3P
         74rgShrO0vRrUlDYMbgqHJCdOBZYazbcIWFWiDrT20xkUcRSHYEiRMjtySC+OevgG+lj
         m+FOqo+Q21QAvGySepv1xnKtNpPVONF4Ptr3SO9JwHcqdGZ9FBDgzDhZmx6hrZT5gG65
         rcFZo0ZdAqaofouk2c6AWjGt8kF4Q7xt0uBTv19ZTo6rpkl3z6nH5QFmUGCd4qe+l1pD
         QKJsI+OrMz9GQwRUJRNpDrMlFvF4slQnK3Pqg6buFnvf7NKvPfELcjGm5cHhslfX4ewg
         IRXg==
X-Forwarded-Encrypted: i=1; AJvYcCUzb3E2UBIm0cqXGV/nnaTc8m7Ip3ikoSsbvQo2lkw5uiG+5cQ1UeA/Xpz8Ek5zxV/p8dRHqMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuXCfQIcQVs+O32pNQNL3ApSzKfePaVQCBJHWY/GDYi/gr5bpX
	cIjD2fhl67gfhtzpfXUSHFzFIH6vQ4Dd8B/wjaJ7l+ME7qD8mplScb7X9/k7Dga71wRyXd20s6f
	k95DPD3ExwfoIpubumlWFlNhJAE67zvIcMGwm9kLJwHk7wlGPOFxkix1rPg==
X-Gm-Gg: ASbGnctXmHkxcFPW16Wf87URgvIvLvEKaNugmGBCkoQXUqAEdv9mH0Nc3PKoXKZE0QB
	FIQjUrXVYRCxGIw+1zAMcDf0niWQ9mwTMSuVgpUt3FRKmkNicWUxsVcJnnPtwnPlI7IZ/Y65LHu
	cYZh8gk7ZhAdEpHtm5gBAbEgKcS68Q5Be1pbjm0+OOkwcBpivizlmlz5meh266/YoY8tvKhbnEF
	JVV2XS05hPAJbAs6sxM5x+SJyC7A0K1N7TFLRsn9+Dz9YeLf4E5eDdaNzjw7TCKnlUYmIOPeZKz
	ZcTQiIfnkITASd1InH98A9Ayb/WRejyzsMddDQklG9io5t8uU/OteuZtDbnu96f45/6eyzkvQdW
	LiH8v04lgnn8=
X-Received: by 2002:a05:600c:4f8f:b0:456:f1e:205c with SMTP id 5b1f17b1804b1-45b85550704mr118913175e9.4.1756890112021;
        Wed, 03 Sep 2025 02:01:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFsBA/j9bYnCTAXDYfIgmGW9pizkBPSIUGW1lg+dV08WEnlUGHy0kWf98aYIfeHn1vTpKkng==
X-Received: by 2002:a05:600c:4f8f:b0:456:f1e:205c with SMTP id 5b1f17b1804b1-45b85550704mr118912735e9.4.1756890111494;
        Wed, 03 Sep 2025 02:01:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7eb05fd9sm230006555e9.24.2025.09.03.02.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 02:01:50 -0700 (PDT)
Message-ID: <80752de6-d18e-4ed9-9d5a-e6ab4954c3bf@redhat.com>
Date: Wed, 3 Sep 2025 11:01:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 17/19] psp: provide decapsulation and receive
 helper for drivers
To: Daniel Zahka <daniel.zahka@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
 <20250828162953.2707727-18-daniel.zahka@gmail.com>
 <ba4e41ef-2d68-495d-8450-8f27e3d0b8e7@redhat.com>
 <7ad2677d-06c9-4bfc-8801-66379005f72e@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <7ad2677d-06c9-4bfc-8801-66379005f72e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/25 5:10 AM, Daniel Zahka wrote:
> On 9/2/25 6:28 AM, Paolo Abeni wrote:
>> On 8/28/25 6:29 PM, Daniel Zahka wrote:
>>> +/* Receive handler for PSP packets.
>>> + *
>>> + * Presently it accepts only already-authenticated packets and does not
>>> + * support optional fields, such as virtualization cookies.
>>> + */
>>> +int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
>>> +{
>>> +	const struct psphdr *psph;
>>> +	int depth = 0, end_depth;
>>> +	struct psp_skb_ext *pse;
>>> +	struct ipv6hdr *ipv6h;
>>> +	struct ethhdr *eth;
>>> +	int encap_bytes;
>>> +	__be16 proto;
>>> +
>>> +	eth = (struct ethhdr *)(skb->data);
>>> +	proto = __vlan_get_protocol(skb, eth->h_proto, &depth);
>>> +	if (proto != htons(ETH_P_IPV6))
>>> +		return -EINVAL;
>>> +
>>> +	ipv6h = (struct ipv6hdr *)(skb->data + depth);
>>> +	depth += sizeof(*ipv6h);
>>> +	end_depth = depth + sizeof(struct udphdr) + sizeof(struct psphdr);
>> Why aren't you checking the next hdr being UDP? This could potentially
>> match unrelated packets.
> 
> This assumes the caller knows the packet is psp transport mode packet, 
> which I think could be a reasonable API given that all psp 
> implementations probably involve parsing packets in hw. I will update 
> this patch to properly support IPv4, though.

Since you are already reading the header cacheline, I guess validating
the transport will not make any difference performance wise, and better
safe than sorry.

>> Also I guess you need pskb_may_pull() above.
> 
> we check for: end_depth > skb_headlen(skb). If you prefer 
> pskb_may_pull(), I can change it.

It's not a matter of personal preference: different NICs could cook the
skbs with different layouts. It's legit to process here valid PSP skbs
with headlen() less than end_depth - with some/all the headers in the
skb frags.

/P


