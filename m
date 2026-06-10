Return-Path: <netdev+bounces-297506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xVJ3HjwXKWq+QQMAu9opvQ
	(envelope-from <netdev+bounces-297506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:50:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E31F2666C69
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:50:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=BM0rL+aa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297506-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297506-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 014C2300D145
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794652D063E;
	Wed, 10 Jun 2026 07:50:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0134A38643B
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 07:50:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781077814; cv=none; b=Pos4TqvUe0v4DIIHz4BxUCaVIpqfnM06uDoLDhXL5IDeNR66Ek14RBtXIyu/e6b+1JC4uKotnxGBiDR9ps4EZuNC5qrvZZz3fChedpmqucy4TMrfzl0Cprz4NYU6Im+ie20i9ziRPoqxn2QEQxf0xF7UKL/iISm056Ndbfjscyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781077814; c=relaxed/simple;
	bh=tyUGpCBtA1BH8feEKWhHYTU14OH43JiFA2UXV9u1u60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0KacNJCWj8/lhbjQxqA7rp1GN2Ysoda0U1Mf+S9NNmSQHnns74R/YfNPnIzIazNh6hyRvCKQzfAKOwKx5IAqBXfUBNLGOHvudR8jDV+5gV5aFzlDCXJUI5jOuyhVsbBdpXGWTuzP7nNGPFTev3l3mu1VM+Gu/TmS/Uj216pJgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=BM0rL+aa; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490c737bcafso2590775e9.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 00:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1781077811; x=1781682611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1BVKfWZi7wftjSkYa7BvXVr6m7jLimUgt3u2r7xVGHE=;
        b=BM0rL+aaubGJpqgN4a9VKnSFcxzrI0tz+ytS9xPX5rZz792oTEHuDOAYV5jc/vK87b
         ohiryfZUN5a5mHYHRh7CcSQtlCvdufRG9O9YKijOBsDdD0RcD56G7xEoA8EJH3Qiftri
         WlmH9tyV5c7RS+DfetBK1WKZk54R31AeCaEtUPCHtFUrAP8U+eeZT1yLO6ETNd1o2huJ
         RiYZOmJfkMoqrfoASM0vqIb2yTIpM0+7E2vUqOCU7ekQsu9iw16V2dv6+QI2qeNpwVJc
         J8A9nUgqOyl+UUtJOFjbTbzbEggYeua5wsFjkj3J1mPgs7UqUaz9AtvCddOupAaxZReD
         oQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781077811; x=1781682611;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BVKfWZi7wftjSkYa7BvXVr6m7jLimUgt3u2r7xVGHE=;
        b=Y7nzo1OG2txsKH6A1wEYeL1Uh2A1Q9+akaOpka44dqO39bkIJZTsIVyQ/5fQ3b8X6M
         sj+5pwrEtUZ6B1/vu2gAVI3uvis1DXm+5KxSRlCEHwWL+cmhmJ6u+RSPAPdBtKLKj1vQ
         +zcUjwJ+c3OoWlPiXJMQjiGJhL3WNDbYGu3L3YJNynn7ibIPcu7mpY3nbhSE5KDQSDwT
         MF+vdRL71KKuxUYmXzc8WWfsAU8qW4MR01WiUYmf9KBdVsFTGsFrKC9EJorXnLeeHSam
         1fFkNA98BjBtYYihlMZezeGidkGkJ1atxqFOBeHzhE2Z1SuuCg9AMBEH1dHmC5c1cL/1
         jG8w==
X-Forwarded-Encrypted: i=1; AFNElJ+X5ufNh0iiQ/QHFUIlBOzhw73bBOOKfKAvRB0FcD7B7Yyv2MzB8dDbntl4L9hvph4lLrJrs8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXlWEVV4GjxzS/ehRJ5mpl3GeyZykuNAVVqBcYe+8YpQs6dMfO
	DJOw/DuIEmCeQtTaLht8PituZXHI2PTmJndKPfRdUvs9Qo8knq829SAen/QmNxMD8MbV7WVIGjk
	kD/hm0oI=
X-Gm-Gg: Acq92OF1E/3HuKuw3GPzDrbLNe9ZEhWFkWcMpGdI+WDUgpcb/P0zo/oRM1DKp0h6bxg
	ZtOo/klnH3Tsu5VxqDYclcRloeDReUxArc7JECdgXRs/MzoKy2HfPzuiRpPhKJ2ozI3uVHyPjkE
	bL2c4nnXAwzThiITjgi49VK15SeEkH9vwNaTVdLDXpQL3/4eb4I50N1cLQ0HRZT4CO4fD2PIEbO
	w2M/LoRkz45qFhvu6U/iijaLRG2XCYFJwf4awarvlrksqHYx/sL8+hs+8lRscszdZbRzRWXv1b5
	1lPJGtTd61fUVXSSgb4dogLnGX6SIsyyo7zR1tYNlhUk/0AuyfiR/C0RuljIqZy9FZTwtI2yaH4
	r4Xr2Ao3rY2EqjfiY72p1SQFo0VyWDDFSld0uMQJbIqPEfvHAnh96x5E7KcyD/RFyD76rZKD+00
	txDO7d2owBpbW0/f7wx2zFMYCETp6NWZT8p5bgAj7WdgWFeXN2a5BZFKTWOCwFHV7jIDLe5RqmB
	a64DJATuNUJ2d8=
X-Received: by 2002:a05:600c:3f0e:b0:490:b288:1a82 with SMTP id 5b1f17b1804b1-490c24ff262mr171767545e9.0.1781077811405;
        Wed, 10 Jun 2026 00:50:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3918fcsm624698755e9.3.2026.06.10.00.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 00:50:11 -0700 (PDT)
Message-ID: <fdcc6f4b-6f81-4422-bfbc-7376dd5cd19f@6wind.com>
Date: Wed, 10 Jun 2026 09:50:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] ipv4: igmp: remove multicast group from hash
 table on device destruction
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260609122646.2297540-1-yuyanghuang@google.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260609122646.2297540-1-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297506-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,6wind.com:dkim,6wind.com:replyto,6wind.com:mid,6wind.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E31F2666C69

Le 09/06/2026 à 14:26, Yuyang Huang a écrit :
> When a device is destroyed under RTNL, ip_mc_destroy_dev() iterates through
> the multicast list and calls ip_ma_put() on each membership, scheduling
> them for RCU reclamation. However, they are not unlinked from the device's
> multicast hash table (mc_hash).
> 
> Since the device remains published in dev->ip_ptr until after
> ip_mc_destroy_dev() completes, concurrent RCU readers traversing mc_hash
> can still locate and access the multicast group after its refcount is
> decremented. If the RCU callback runs and frees the group while a reader is
> accessing it, a use-after-free occurs.
> 
> Fix this by unlinking the multicast group from mc_hash using
> ip_mc_hash_remove() before scheduling it for reclamation.
> 
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
A 'Fixes' tag may be useful for backports.

Regards,
Nicolas

