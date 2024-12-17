Return-Path: <netdev+bounces-152495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA98E9F43CE
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 07:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815A716A859
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 06:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965CA15B0EE;
	Tue, 17 Dec 2024 06:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btHYrLck"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4C314A095
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417394; cv=none; b=eHiKg+60dxbWXCtgwSXh88yZr41p4Li+5NiXTn2Y0WcHfzIxrvIdfw0p2f50My7uZY7VZUpN02RQNZEPTKwKgCLRNprFvBnPnops2dhWncI023lkxOgQ+Zc7vvXDhKuQkQwV9Mn7xYJXHzfwcowz1BOBWDEHNl9kf4lpiEFNgeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417394; c=relaxed/simple;
	bh=AWvF2j/MJck6A2lbQoUyTLG7fnkX2/wVEcY1KtN+1qc=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DvLw8UCpXpzusHloPy3y0NGAoWPkX52v7iNDl5CCxNbTbN2urF/8Fj9xXobybk91aZNqlfwSZPQFxNIKAadoyjKMhVkDuLtWRwrW8Vr1YOpMacxcCtR4kvLIDdtoG0Qy7u27DlgCaPd72vO/TtP5aOdjgLAxgUsYlK8TaGBW8rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btHYrLck; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43634b570c1so22545045e9.0
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 22:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734417391; x=1735022191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9Hb6aegTpIAjbQ9FI8lX/nYav5UjD6nZeBYzzREv7c=;
        b=btHYrLck45k5N1X7GypsZ5+i0yTEoaTj16hoSDoNn8aIWwEzJ2Ca3BTYUnwMCzgnII
         ZROiRP6QnVGHtsz8sUmc3RQ9eZrBNRf+QHEeMulbqk3Z8zKnjk/5OklyRe/gm2qUZkVR
         d/pITGNdXw4roLS8z+iSpZLFFwdvhAcJ1SeeahU3Winra68HhLo33lSTWzwCL631bg4r
         J6XnwCzWZMzT4pOazcf7SDx828HEit78bMTThc47GhyeDdL+qm8lsiONoivEqj9FEK4g
         sCoMqNiCt+r73riO48TsFYqmW5dayWWC5ZzilAaDm+zEaWFkZoJ1k2Hq7ZzWNvqtnQ/s
         ETYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734417391; x=1735022191;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9Hb6aegTpIAjbQ9FI8lX/nYav5UjD6nZeBYzzREv7c=;
        b=vQ3bSzb7kvN/M3sIkoYN2O0TqS2YtHz7aGgafobyX3VQlGim3jxUNMrNB7uoCa5mNB
         v6IKFmU6WI86dLQp1u/7Osx/D/k9U1ECKJK2nPJTugg8kLhfNkZsqSzohlCjUXgOipbX
         i3YIqJn6O+3YdGMplIwEekbX+Lb0AePOWx9GZeWzJH7UjMAuV+mlXpg73Qjjx6p/SXNk
         TYoRdkaZY8nU4eka7XoAaWibTEvLGaTRpqN+zbq0cUNB0fCLWYZAgHF4VwpUUKidXOJx
         Y68yCJEaar/6QqsAngvueHcSt4+hKCzGJ4IqZMWCvCpZSWtYkYvEzer4oieE5qNcTTAc
         sg1g==
X-Forwarded-Encrypted: i=1; AJvYcCUDNdYK58W8Cyzt8HhEUj2IpEnnk8nuhP6uCqeHQV4qDio4WPggH9AnUXNP9MsOn+R2tGDx5t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWPyndRGIqZhEKYuNGNA20LYXjAeFxHJUh1ICDhOMASd6U7F3j
	idLKWzoU48u0oPXWNzOvfvNJTpUhjjQetywda9U07LFgraeIMiighiggiQ==
X-Gm-Gg: ASbGncu2eSakmt9gZU+JXmS0mB7jVG4kKbeF0zuGk1pYOQRvDAYvBKXd9SkTkTr9Le1
	42YBbMaa24z5k4WZGy4qXJZW3+spCNjbgGZaZWqCVLpqtjB6czvF/t75nG2PcdODJ6UwNusdV3U
	/mPG7mWXO86EvMW1eiZdYESax1s4hYVR8JPO+JDfjwzoRSybjI94caV6qch2B+GfaS3wggmWplG
	unmmf8VyJAlhqbdcTz0Oyvzx8KKRyb7w5I+vC2KfEBn3VU4Oo/0cmEDvOfrVTgr5P6u8MLZUkuG
	3DrDn8/B9macQU+f0qZEMkBh/4JmY/nLqrWRKZglLo+7
X-Google-Smtp-Source: AGHT+IGnPQRGG/wXAjYa0UYauLNZJPlBdQHV1SHQbtKK2xBkYarXMnTrV7Xza3V+YN91ONmvdiFqYw==
X-Received: by 2002:a05:600c:450e:b0:434:f8e5:1bb with SMTP id 5b1f17b1804b1-4362aa42e33mr132392415e9.12.1734417390235;
        Mon, 16 Dec 2024 22:36:30 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602b468sm107249365e9.11.2024.12.16.22.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 22:36:29 -0800 (PST)
Subject: Re: [PATCH net-next v3 03/12] net: homa: create shared Homa header
 files
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
References: <20241209175131.3839-1-ouster@cs.stanford.edu>
 <20241209175131.3839-5-ouster@cs.stanford.edu>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <8a73091e-5d4a-4802-ffef-a382adbbe88f@gmail.com>
Date: Tue, 17 Dec 2024 06:36:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241209175131.3839-5-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 09/12/2024 17:51, John Ousterhout wrote:
> oma_impl.h defines "struct homa", which contains overall information
> about the Homa transport, plus various odds and ends that are used
> throughout the Homa implementation.

Should parts of 'struct homa' be per network namespace, rather than
 global, so that in systems hosting multiple containers each netns can
 configure Homa for the way it wants to use it?

> +struct homa_interest {
> +	/**
> +	 * @thread: Thread that would like to receive a message. Will get
> +	 * woken up when a suitable message becomes available.
> +	 */
> +	struct task_struct *thread;
> +
> +	/**
> +	 * @ready_rpc: This is actually a (struct homa_rpc *) identifying the
> +	 * RPC that was found; NULL if no RPC has been found yet. This
> +	 * variable is used for synchronization to handoff the RPC, and
> +	 * must be set only after @locked is set.
> +	 */
> +	atomic_long_t ready_rpc;
> +
> +	/**
> +	 * @locked: Nonzero means that @ready_rpc is locked; only valid
> +	 * if @ready_rpc is non-NULL.
> +	 */
> +	int locked;

These feel weird; what kind of synchronisation is this for and why
 aren't any of Linux's existing locking primitives suitable?  In
 particular the non-typesafe casting of ready_rpc is unpleasant.
I looked at sync.txt and didn't find an explanation, and it wasn't
 obvious from reading homa_register_interests() either.  (Are plain
 writes to int even guaranteed to be ordered wrt the atomics on
 rpc->flags or ready_rpc?)
My best guess from looking at how `thread` is used is that all this
 is somehow simulating a completion?  You shouldn't need to manually
 do stuff like sleeping and waking threads from within something as
 generic as a protocol implementation.

> +	interest->request_links.next = LIST_POISON1;
> +	interest->response_links.next = LIST_POISON1;

Any particular reason why you're opencoding poisoning, rather than
 using the list helpers (which distinguish between a list_head that
 has been inited but never added, so list_empty() returns true, and
 one which has been list_del()ed and thus poisoned)?
It would likely be easier for others to debug any issues that arise
 in Homa if when they see a list_head in an oops or crashdump they
 can relate it to the standard lifecycle.

> +/**
> + * struct homa - Overall information about the Homa protocol implementation.
> + *
> + * There will typically only exist one of these at a time, except during
> + * unit tests.
> + */
> +struct homa {
> +	/**
> +	 * @next_outgoing_id: Id to use for next outgoing RPC request.
> +	 * This is always even: it's used only to generate client-side ids.
> +	 * Accessed without locks.
> +	 */
> +	atomic64_t next_outgoing_id;

Does the ID need to be unique for the whole machine or just per-
 interface?  I would imagine it should be sufficient for the
 (id, source address) or even (id, saddr, sport) tuple to be
 unique.
And are there any security issues here; ought we to do anything
 like TCP does with sequence numbers to try to ensure they aren't
 guessable by an attacker?

> +	/**
> +	 * @throttled_rpcs: Contains all homa_rpcs that have bytes ready
> +	 * for transmission, but which couldn't be sent without exceeding
> +	 * the queue limits for transmission. Manipulate only with "_rcu"
> +	 * functions.
> +	 */
> +	struct list_head throttled_rpcs;

I'm not sure exactly how it works but I believe you can annotate
 the declaration with __rcu to get sparse to enforce this.

> +	/**
> +	 * @next_client_port: A client port number to consider for the
> +	 * next Homa socket; increments monotonically. Current value may
> +	 * be in the range allocated for servers; must check before using.
> +	 * This port may also be in use already; must check.
> +	 */
> +	__u16 next_client_port __aligned(L1_CACHE_BYTES);

Again, does guessability by an attacker pose any security risks
 here?

> +	/**
> +	 * @link_bandwidth: The raw bandwidth of the network uplink, in
> +	 * units of 1e06 bits per second.  Set externally via sysctl.
> +	 */
> +	int link_mbps;

What happens if a machine has two uplinks and someone wants to
 use Homa on both of them?  I wonder if most of the granting and
 pacing part of Homa ought to be per-netdev rather than per-host.
(Though in an SDN case with a bunch of containers issuing their
 RPCs through veths you'd want a Homa-aware bridge that could do
 the SRPT rather than bandwidth sharing, and having everything go
 through a single Homa stack instance does give you that for free.
 But then a VM use-case still needs the clever bridge anyway.)

> +	/**
> +	 * @timeout_ticks: abort an RPC if its silent_ticks reaches this value.
> +	 */
> +	int timeout_ticks;

This feels more like a socket-level option, perhaps?  Just
 thinking out loud.
> +	/**
> +	 * @gso_force_software: A non-zero value will cause Home to perform
> +	 * segmentation in software using GSO; zero means ask the NIC to
> +	 * perform TSO. Set externally via sysctl.
> +	 */

"Home" appears to be a typo.
> +	/**
> +	 * @temp: the values in this array can be read and written with sysctl.
> +	 * They have no officially defined purpose, and are available for
> +	 * short-term use during testing.
> +	 */
> +	int temp[4];

I don't think this belongs in upstream.  At best maybe under an ifdef
 like CONFIG_HOMA_DEBUG?

> +/**
> + * struct homa_skb_info - Additional information needed by Homa for each
> + * outbound DATA packet. Space is allocated for this at the very end of the
> + * linear part of the skb.
> + */
> +struct homa_skb_info {
> +	/**
> +	 * @next_skb: used to link together all of the skb's for a Homa
> +	 * message (in order of offset).
> +	 */
> +	struct sk_buff *next_skb;
> +
> +	/**
> +	 * @wire_bytes: total number of bytes of network bandwidth that
> +	 * will be consumed by this packet. This includes everything,
> +	 * including additional headers added by GSO, IP header, Ethernet
> +	 * header, CRC, preamble, and inter-packet gap.
> +	 */
> +	int wire_bytes;
> +
> +	/**
> +	 * @data_bytes: total bytes of message data across all of the
> +	 * segments in this packet.
> +	 */
> +	int data_bytes;
> +
> +	/** @seg_length: maximum number of data bytes in each GSO segment. */
> +	int seg_length;
> +
> +	/**
> +	 * @offset: offset within the message of the first byte of data in
> +	 * this packet.
> +	 */
> +	int offset;
> +};
> +
> +/**
> + * homa_get_skb_info() - Return the address of Homa's private information
> + * for an sk_buff.
> + * @skb:     Socket buffer whose info is needed.
> + */
> +static inline struct homa_skb_info *homa_get_skb_info(struct sk_buff *skb)
> +{
> +	return (struct homa_skb_info *)(skb_end_pointer(skb)
> +			- sizeof(struct homa_skb_info));
> +}
> +
> +/**
> + * homa_next_skb() - Compute address of Homa's private link field in @skb.
> + * @skb:     Socket buffer containing private link field.
> + *
> + * Homa needs to keep a list of buffers in a message, but it can't use the
> + * links built into sk_buffs because Homa wants to retain its list even
> + * after sending the packet, and the built-in links get used during sending.
> + * Thus we allocate extra space at the very end of the packet's data
> + * area to hold a forward pointer for a list.
> + */
> +static inline struct sk_buff **homa_next_skb(struct sk_buff *skb)
> +{
> +	return (struct sk_buff **)(skb_end_pointer(skb) - sizeof(char *));
> +}

This is confusing — why doesn't homa_next_skb(skb) equal
 &homa_get_skb_info(skb)->next_skb?  Is one used on TX and the other
 on RX, or something?

And could these subtractions be written as first casting to the
 appropriate pointer type and then subtracting 1, instead of
 subtracting sizeof from the unsigned char *end_pointer?
(Particularly as here you've taken sizeof a different kind of
 pointer — I know sizeof(char *) == sizeof(struct sk_buff *), but
 it's still kind of unclean.)

> +
> +/**
> + * homa_set_doff() - Fills in the doff TCP header field for a Homa packet.
> + * @h:     Packet header whose doff field is to be set.
> + * @size:  Size of the "header", bytes (must be a multiple of 4). This
> + *         information is used only for TSO; it's the number of bytes
> + *         that should be replicated in each segment. The bytes after
> + *         this will be distributed among segments.
> + */
> +static inline void homa_set_doff(struct data_header *h, int size)
> +{
> +	h->common.doff = size << 2;

Either put a comment here about the data offset being the high 4
 bits of doff, or use "(size >> 2) << 4" (or both!); at first
 glance this looks like a typo shifting the wrong way.
(TCP avoids this by playing games with bitfields in struct tcphdr.)

> +/**
> + * ipv4_to_ipv6() - Given an IPv4 address, return an equivalent IPv6 address
> + * (an IPv4-mapped one).
> + * @ip4: IPv4 address, in network byte order.
> + */
> +static inline struct in6_addr ipv4_to_ipv6(__be32 ip4)
> +{
> +	struct in6_addr ret = {};
> +
> +	if (ip4 == htonl(INADDR_ANY))
> +		return in6addr_any;
> +	ret.in6_u.u6_addr32[2] = htonl(0xffff);
> +	ret.in6_u.u6_addr32[3] = ip4;
> +	return ret;
> +}
> +
> +/**
> + * ipv6_to_ipv4() - Given an IPv6 address produced by ipv4_to_ipv6, return
> + * the original IPv4 address (in network byte order).
> + * @ip6:  IPv6 address; assumed to be a mapped IPv4 address.
> + */
> +static inline __be32 ipv6_to_ipv4(const struct in6_addr ip6)
> +{
> +	return ip6.in6_u.u6_addr32[3];
> +}
...
> +/**
> + * is_mapped_ipv4() - Return true if an IPv6 address is actually an
> + * IPv4-mapped address, false otherwise.
> + * @x:  The address to check.
> + */
> +static inline bool is_mapped_ipv4(const struct in6_addr x)
> +{
> +	return ((x.in6_u.u6_addr32[0] == 0) &&
> +		(x.in6_u.u6_addr32[1] == 0) &&
> +		(x.in6_u.u6_addr32[2] == htonl(0xffff)));
> +}

These probably belong in some general inet header rather than being
 buried inside Homa.  There's __ipv6_addr_type() but that might be a
 bit heavyweight; also ipv6_addr_v4mapped() and
 ipv6_addr_set_v4mapped() in include/net/ipv6.h.

