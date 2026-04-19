Return-Path: <netdev+bounces-279582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFYAKUjS5GnAaQEAu9opvQ
	(envelope-from <netdev+bounces-279582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 15:02:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 148DA424023
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 15:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9737300D45D
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 13:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FC3358364;
	Sun, 19 Apr 2026 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rJFMTZZy"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C16361DDA
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776603699; cv=none; b=UP/8Rv6swrvfaeDpb9BRTSGw/OKd8U1ujybxJXYrb+2HOPVVbaU7Nin326c7v3dHI4MGGjCq+qpxB3eW5Z/alYzeyMXDAq/A7Df+1IunzAgaB4xdHVbPTwMXn6AobGKxhIdkJsO+pBK/35Ppj7CLxlGxGtQ/Jes+5CgW/0ymsLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776603699; c=relaxed/simple;
	bh=pX5EvkDZNatuuN3n/U7mYJ/WQU/4SAOnlLh4teqFHLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXxvWqmMCxM1I1RlTVUXYX+H8BVOJL2y6kReo+VTm5cgf8J9WLz3LEofpFajJ/HfjmfQO95SsA9NIyCXyMLPUjfO1RQspH+R9pQ3y1TjTsqQd20PIvmgJEEKCQ/QhwOsvhinQftQOuxmQyu5whOJvHb5UoTnxlIVAO981X6Pfpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rJFMTZZy; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eb0683d9-617f-41b6-b535-e15ffe081a17@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776603695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ELsZ4zsAX7/4xYOMb704nnpfFkN1la3I7mXql9fMiGY=;
	b=rJFMTZZyu0DARjLvx7zpKKNR9LRUtHiT1HhzXqtlU8YGrpEEG2KPWyUMs7MDDIhpCGlifZ
	TKOfXpNRi3ijtuRt7qKaANH2prg7u/9ixSC/8VKp0s66nsCfsm5YjXeS96RXImpjSh5t5a
	fluyvdsZzXvctGE5ODWm03qeBFnF1r4=
Date: Sun, 19 Apr 2026 21:01:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net: iptunnel: fix stale transport header after
 GRE/TEB decap
To: Eric Dumazet <edumazet@google.com>, Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org,
 syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pravin B Shelar <pshelar@nicira.com>,
 Tom Herbert <tom@herbertland.com>, linux-kernel@vger.kernel.org
References: <20260419090817.127334-1-jiayuan.chen@linux.dev>
 <CANn89iKJFCw9gPdQN4hYZ94j-0Ua84N+DyYjPjwBTRLveK-j7g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CANn89iKJFCw9gPdQN4hYZ94j-0Ua84N+DyYjPjwBTRLveK-j7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279582-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,83181a31faf9455499c5];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 148DA424023
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[...]
>>   +662,18 @@ static inline int iptunnel_pull_offloads(struct sk_buff *skb)
>>          return 0;
>>   }
>>
>> +static inline void iptunnel_rebuild_transport_header(struct sk_buff *skb)
>> +{
>> +       if (!skb_is_gso(skb))
>> +               return;
>> +
>> +       skb->transport_header = (typeof(skb->transport_header))~0U;
>> +       skb_probe_transport_header(skb);
>> +
>> +       if (!skb_transport_header_was_set(skb))
>> +               skb_gso_reset(skb);
> I do not think this makes sense.
> What is a valid case for this packet being processed further?
> The buggy packet must be dropped, instead of being mangled like this.
Hi Eric,

The reproducer builds a gre frame whose inner Ethernet header is 
all-zero. Tracing the skb through RX:

1. At GRE decap exit, skb_transport_offset(skb) < 0 is the rule, not the 
exception.

It is negative for every packet leaving the tunnel, including perfectly 
well-formed inner IPv4 traffic
because the tunnel leaves skb->transport_header at the outer L4 offset while
pskb_pull() has already advanced skb->data past it. 
skb_transport_header_was_set() stays true, so downstream
code that trusts that flag now trusts a stale, negative offset.

2. GRO repairs it — but only for protocols it knows.

In dev_gro_receive(), skb->protocol is dispatched through the offload 
table. For ETH_P_IP,
inet_gro_receive() calls skb_set_transport_header(skb, 
skb_gro_offset(skb)), and the offset
becomes valid again. But for malformed skb, dev_gro_receive just bypass it.

3. Both kinds then reach __netif_receive_skb_core().

So the skb that qdisc/tc/BPF segmenters later see has an
invariant violation — _was_set == true but offset < 0 — that the core
layer has no intention of catching for us.

My reading of this is that the tunnel decap path is producing an skb 
that doesn't
honor the contract __netif_receive_skb_core() expects from its 
producers, and that
it doesn't really make sense to ask GRE to parse or validate the inner 
L4 in order
to fix this.

I'm thinking at the end of GRE decap, before handing the skb to 
gro_cells_receive(),
call skb_reset_transport_header(skb).

Thanks,
Jiayuan

