Return-Path: <netdev+bounces-257116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ8MJBV4hGk23AMAu9opvQ
	(envelope-from <netdev+bounces-257116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:59:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E75A5F1930
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95554305B478
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 10:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DD83A9629;
	Thu,  5 Feb 2026 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qatB8Nta"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF4F20DD75
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770288904; cv=none; b=fuuKIYoTs4YrkGk3/hUPSwWbM+Qz1gBQJcm3pHKz9hu2t/EPnnmmLqmNFTfMO03alYdO04AKnEwX9B0cPTWzSlrIG3Vi7I2UsNS6JzmNeU4ksZ4bOgpfUrY51ueT9bPNi8s8dBd8ms+cu0b6YaRBgRsksbJs/SgmfNy3AtPe9Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770288904; c=relaxed/simple;
	bh=xO9pejZc6Cpo8PT+Km9MrY4BCumZsIt6jUvp2GyWgGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NlQJJukG49xGFaenD7scWplWZFFbKgG+n+rvdOKb+GhXgp7dhIOFEp75753Pw1hz2/FH7NDI9JpgOb7Hje7dHrPOfXnS4+LUv7Eg3M33+r35uN0vdTB2/r6Y1Fzc/TaWWVj8+rgZU7CnC/ZXyRvjGWKABQbuH4K3dlbDTnjPf+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qatB8Nta; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <731d97df-a17e-4f9b-8746-d6281d8d53b4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770288901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XgQRlmaw6r5/fI+hwGfOcBQxOqUtNuU0ml82+MVy9KA=;
	b=qatB8Nta0KtdOX5xGAlcwBh4hNXBaE5dk834QXi3eRiq+xYX/dnEw9FKHFCxlar9qFqLkk
	aHKvAE1LdmqBKuypjUVLlnA7oQQVhFu7JaG++arobC3dLK48FHMh6LgDIyOwgjf3/OvZiU
	3ExxJkxSLy7rPey0MlsuSSARfpWt+XQ=
Date: Thu, 5 Feb 2026 10:54:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 1/4] arp: discard invalid sha addr (b/mcast
 ARP poison)
To: =?UTF-8?B?TWFyYyBTdcOxw6k=?= <marcdevel@gmail.com>, kuba@kernel.org,
 willemdebruijn.kernel@gmail.com, pabeni@redhat.com
Cc: netdev@vger.kernel.org, dborkman@kernel.org
References: <cover.1770241104.git.marcdevel@gmail.com>
 <d51bdc5aa3236ec4b7cc98c9d6a098f27f45477f.1770241104.git.marcdevel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <d51bdc5aa3236ec4b7cc98c9d6a098f27f45477f.1770241104.git.marcdevel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257116-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E75A5F1930
X-Rspamd-Action: no action

On 04/02/2026 22:11, Marc Suñé wrote:
> Prior to this commit, the ARP implementation accepted ARP req/replies
> with multicast (including broadcast) and null MAC addresses as Sender
> HW Address (SHA), and updated the ARP cache for that neighbour.
> Broadcast, multicast and null MAC addresses shall never be associated
> with a unicast or a multicast IPv4 address (see RFC1812, section 3.3.2).
> 
> ARP poisioning with a broadcast MAC address and certain multicast
> addresses, especially when poisoning a Gateway IP, have some undesired
> implications compared to an ARP poisioning with a regular MAC (see
> Note1).
> 
> Worth mentioning that if an attacker is able to ARP poison in
> a L2 segment, that in itself is probably a bigger security threat
> (Man-in-middle etc., see Note2).
> 
> However, since these MACs should never be announced as SHA,
> discard/drop ARPs with SHA={b/mcast, null}, which prevents the
> broadcast/multicast ARP poisoning vector.
> 
> Note1:
> 
> After a successful broadcast/multicast ARP poisioning attack:
> 
> 1. Unicast packets and refresh ("targeted") ARPs sent to or via
>     the poisioned IP (e.g. the default GW) are flooded by
>     bridges/switches. That is in absence of other security controls.
> 
>     Hardware swiches generally have rate-limits to prevent/mitigate
>     broadcast storms, since ARPs are usually answered by the CPU.
>     Legit unicast packets could be dropped (perf. degradation).
> 
>     Most modern NICs implement some form of L2 MAC filtering to early
>     discard irrelevant packets. In contrast to an ARP poisoning
>     attack with any other MAC, both unicast and ARP ("targeted")
>     refresh packets are passed up to the Kernel networking stack
>     (for all hosts in the L2 segment).
> 
> 2. A single forged ARP packet (e.g. for the Gateway IP) can produce
>     up to N "targeted" (to broadcast) ARPs, where N is the number of
>     hosts in the L2 segment that have an ARP entry for that IP
>     (e.g. GW), and some more traffic, since the real host will answer
>     to targeted refresh ARPs with their (real) reply.
> 
>     This is a relatively low amount of traffic compared to 1).
> 
> 3. An attacker could use this form of ARP poisoning to discover
>     all hosts in a L2 segment in a very short period of time with
>     one or few packets.
> 
>     By poisoning e.g. the default GW (likely multiple times, to
>     avoid races with real gARPs from the GW), all hosts will eventually
>     issue refresh "targeted" ARPs for the GW IP with the broadcast MAC
>     address as destination. These packets will be flooded in the L2
>     segment, revealing the presence of hosts to the attacker.
> 
>     For comparison:
>       * Passive ARP monitoring: also stealthy, but can take a long
>         time or not be possible at all in switches, as most refresh
>         ARPs are targeted.
>       * ARP req flooding: requires swiping the entire subnet. Noisy
>         and easy to detect.
>       * ICMP/L4 port scans: similar to the above.
> 
> 4. In the unlikely case that hosts were to run with
>     `/proc/sys/net/ipv4/conf/*/arp_accept=1` (unsafe, and disabled
>     by default), poisoning with the broadcast MAC could be used to
>     create significantly more broadcast traffic (low-volume
>     amplification attack).
> 
>     An attacker could send M fake gARP with a number of IP addresses,
>     where M is `/proc/sys/net/ipv4/neigh/*/gc_thresh3` (1024 by
>     default). This would result in M x R ARPs, where R is the number
>     of hosts in L2 segment with `arp_accept=1`, and likely other
>     (real) ARP replies coming from the attacked host. This starts to
>     get really relevant when R > 512, which is possible in large LANs
>     but not very common.
> 
> Note2:
> 
> However, broadcast ARP poisoning might be subtle and difficult to
> spot. These ARP packets appear on the surface as regular broadcast
> ARP requests (unless ARP hdr is inspected), traffic continues to
> flow uninterrupted (unless broadcast rate-limit in switches kick-in)
> and, the next refresh ARP reply (from the GW) or any (valid) gARP
> from the GW, will restore the original MAC in the ARP table, making
> the traffic flow normally again.
> 
> Signed-off-by: Marc Suñé <marcdevel@gmail.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

