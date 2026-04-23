Return-Path: <netdev+bounces-280661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N4mDAbW6WmglQIAu9opvQ
	(envelope-from <netdev+bounces-280661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:19:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED8344E6E5
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5BBC301B160
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7C82EBB86;
	Thu, 23 Apr 2026 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJjzjklI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iz50G3cr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2F540DFD8
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776932351; cv=none; b=g56cO3p7ZPFz9BtJwhpW5ZJkN2CtE6aKJXOjg7t6DJ4/2altq0RDmqBG99EpGI84SNAR+LnlKpLXhj+JE3iuqUSrukVcP5sCkqwsJwVHwImI11/OeVfvIhIHfBhaz7iObV9jHRPTtT6SbwEcoIlNGlmZ7RNHnM+0yxjTXKqgIv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776932351; c=relaxed/simple;
	bh=kfICvPZDPVSD9QYfF9FgrUrY50v6Hg4W4+I23gYyFy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRGhHqMEuTsCq3G9Lxk4ASdWfO3M9cgFhFzOfp7wqh4rH8B+6dIKhHDQZYqsDRtLtY7o8A11Uuwr+reAQS5oZNHsoYMOTrzMBt7+8AiRsfZvBs70xIyfhLUQ+Zt2ID2LAHLKNKoGS9H9aggIMwwnMwjPRiU1KufFsF7TNM7zfhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJjzjklI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iz50G3cr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776932349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXxT8EijkFiVXC92HQalIcnlNjOggo4M9bQ+pHHzC6A=;
	b=BJjzjklI2lYSmphYFL9qkAcHdEdPz/31U+oFX8Z4x7udi3U4pWi4zTWXQ9oUlQ+1qZQcT0
	HjQlFlFIRGhyrcFJ36QeHgi6UaEX5yUBXT+QszyRP6mS1fhMwWByUYFAHQRhAa6foe3XzJ
	eIlIPYNrTdIXTP7KhUdbBVnNzGp3IqI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-XCEFIQq4M9K4bHhvLkYt0Q-1; Thu, 23 Apr 2026 04:19:07 -0400
X-MC-Unique: XCEFIQq4M9K4bHhvLkYt0Q-1
X-Mimecast-MFC-AGG-ID: XCEFIQq4M9K4bHhvLkYt0Q_1776932347
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488c0fcc6deso38032615e9.2
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 01:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776932346; x=1777537146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXxT8EijkFiVXC92HQalIcnlNjOggo4M9bQ+pHHzC6A=;
        b=iz50G3cryWZfXzQt6Oex/7XLq6gk/Ld+YTh4JGR/a8X2xri37DrN7/X8o9EiMnMosx
         j7sqaLm94lapiG2t25P1RRg8m7o0v/jmXnG1mbhUyn101KK7mHwFE3SPrjinTZJZy5XQ
         GpsjsajrP++dn1vKt1H8dl6nuj/1KrGSpd92IT0G0gsM+35k1/KVlSHIrCsNTv2ei6ED
         myRIrZffaUfluoTr6LpmtZa8gBRzV9Tmp2D83AIcSBomWXIZT8DZ0kWz4PjUdYzI9mEi
         lCYW6KMJGGNgO84dY0NLN45CqfS26XHq7HTYnM83Cf6G+sZYFm7I6vvVcTAmZk8In8sv
         tp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776932346; x=1777537146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXxT8EijkFiVXC92HQalIcnlNjOggo4M9bQ+pHHzC6A=;
        b=hUYMmOKON/ulMlqRRjQ0RRkE8cPI/Rv9NUAoPrpzFS/64gUXbAHZI4aCGW31+oEWlK
         UqWhL5DN59LaO3LkOi6PZyvI2Rp+KhpMwagm2Qk0OGvWS7cvW6E9rQVxNEfrfquPCx+8
         lWce8hJE/+pV46kgKRNKNcDGzwYqJEWJW+bz3qcTem/JlyVVOOwRt9ulvEjExKKsx62C
         NUpEC2HKIznhQ0snB6+HPw+uklzr6ExuKKx/fe2O+rgA1+HdEx2JRMYdVJklYOmwL4Qi
         vz0AtXs5SsC9jULM9cduxxo1+1AwDdcC363Lih9bdFNbM8AD/BNVIyy2UtTd8mWNdK4U
         JeWQ==
X-Gm-Message-State: AOJu0Yy5OhwtJASn6OWI5r0OLWhs643BWoq0KPnoICNPXCmBZgnEXOG5
	FrVe67SuljGSyPf2L60TUg6N7zlyxaCWvwrMVpQrBU2odaCn52+t19hEkFkm+Jidwo3di/d3W7T
	q+UFcNmLoEISiwLn0/asy5rilzWfqX/F+s7AQWZcyuACw8J+5Mj/MCoBIrMjDPhAyOg==
X-Gm-Gg: AeBDieudk9EkXqMiT+LHHS+2uBK4kx3DjpNJ2eShhsDnHfOWiFByglvb48Kr3oCs6/L
	hcR3Ix7nIJ00KLrQyQCbrfxJPGqhJSOUBW3DFuZlnL6xqAnJ817fQGXgQw14VL3GeRAZ19aNvsI
	v367xZ1RlLX1s8BnKnvfkFCONG40LOjQ62k7KJT9NvD1loZC4ga4/tgy/PE5iKMK7S65l4cKC1o
	JzfTfQ4CnH5sdlfjKfvIWIiwUjuy5J4k4erN/ZNMZ2FubjcfOMaH6NT1zGtIcDNk3z/HJpfOCV7
	vow1jri4GZ3/kWr6efTUkaVyPONDJxn/AeAAOiawHAl4dzyWN47aA36Op3MsxbCy8Wtnqv7TcJf
	y5A+ex/L+0TV9pLtNwkrw0t/UK5uqSjfl2CjQlX9ANqZhADSgm0PVzs1bzBwbVVK85LQ=
X-Received: by 2002:a05:600c:4707:b0:488:bfc3:efc with SMTP id 5b1f17b1804b1-488fb6e8eb5mr370527385e9.0.1776932346363;
        Thu, 23 Apr 2026 01:19:06 -0700 (PDT)
X-Received: by 2002:a05:600c:4707:b0:488:bfc3:efc with SMTP id 5b1f17b1804b1-488fb6e8eb5mr370527005e9.0.1776932345888;
        Thu, 23 Apr 2026 01:19:05 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891df9e50asm241951845e9.0.2026.04.23.01.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 01:19:05 -0700 (PDT)
Message-ID: <4f467b95-d135-4c1a-9f44-09138ff2d592@redhat.com>
Date: Thu, 23 Apr 2026 10:19:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: iptunnel: fix stale transport header after
 GRE/TEB decap
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
 syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Pravin B Shelar <pshelar@nicira.com>, Tom Herbert <tom@herbertland.com>,
 linux-kernel@vger.kernel.org
References: <20260419090817.127334-1-jiayuan.chen@linux.dev>
 <CANn89iKJFCw9gPdQN4hYZ94j-0Ua84N+DyYjPjwBTRLveK-j7g@mail.gmail.com>
 <eb0683d9-617f-41b6-b535-e15ffe081a17@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <eb0683d9-617f-41b6-b535-e15ffe081a17@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280661-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,83181a31faf9455499c5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8ED8344E6E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/19/26 3:01 PM, Jiayuan Chen wrote:
> [...]
>>>   +662,18 @@ static inline int iptunnel_pull_offloads(struct sk_buff *skb)
>>>          return 0;
>>>   }
>>>
>>> +static inline void iptunnel_rebuild_transport_header(struct sk_buff *skb)
>>> +{
>>> +       if (!skb_is_gso(skb))
>>> +               return;
>>> +
>>> +       skb->transport_header = (typeof(skb->transport_header))~0U;
>>> +       skb_probe_transport_header(skb);
>>> +
>>> +       if (!skb_transport_header_was_set(skb))
>>> +               skb_gso_reset(skb);
>> I do not think this makes sense.
>> What is a valid case for this packet being processed further?
>> The buggy packet must be dropped, instead of being mangled like this.
> Hi Eric,
> 
> The reproducer builds a gre frame whose inner Ethernet header is 
> all-zero. Tracing the skb through RX:
> 
> 1. At GRE decap exit, skb_transport_offset(skb) < 0 is the rule, not the 
> exception.
> 
> It is negative for every packet leaving the tunnel, including perfectly 
> well-formed inner IPv4 traffic
> because the tunnel leaves skb->transport_header at the outer L4 offset while
> pskb_pull() has already advanced skb->data past it. 

Is it? the transport header is an offset on top of skb->head, pskb_pull
changes head only if the header is not in the linear part (and the
transport offset is already invalid).

> skb_transport_header_was_set() stays true, so downstream
> code that trusts that flag now trusts a stale, negative offset.
> 
> 2. GRO repairs it — but only for protocols it knows.
> 
> In dev_gro_receive(), skb->protocol is dispatched through the offload 
> table. For ETH_P_IP,
> inet_gro_receive() calls skb_set_transport_header(skb, 
> skb_gro_offset(skb)), and the offset
> becomes valid again. But for malformed skb, dev_gro_receive just bypass it.

So only malformed packets cause trouble, right?

> 3. Both kinds then reach __netif_receive_skb_core().
> 
> So the skb that qdisc/tc/BPF segmenters later see has an
> invariant violation — _was_set == true but offset < 0 — that the core
> layer has no intention of catching for us.
> 
> My reading of this is that the tunnel decap path is producing an skb 
> that doesn't
> honor the contract __netif_receive_skb_core() expects from its 
> producers, and that
> it doesn't really make sense to ask GRE to parse or validate the inner 
> L4 in order
> to fix this.
> 
> I'm thinking at the end of GRE decap, before handing the skb to 
> gro_cells_receive(),
> call skb_reset_transport_header(skb).

My take is that you need to address the issue earlier than the current
patch, dropping the malformed packets.

/P


