Return-Path: <netdev+bounces-267723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHInO95LtWmzywAAu9opvQ
	(envelope-from <netdev+bounces-267723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:51:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 262C328CED2
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 214393012CC7
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 11:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76246257824;
	Sat, 14 Mar 2026 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c7VuxZHY"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00F2244660
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773489116; cv=none; b=J4iBz2oOg7STr7w7QTSj5u5qEhZVcNoXlOjp3nLfqchcx3A0tTKjqojxNHOfHxND+qLw0dMapE8iwmvP9dYbMmZRNBj0P6BPvE8VjJp5KNwXJSdjId0N6qOFFgC9jFEo6UQq9ZKfUOz8uvO4NMYPZ72HlGOAKzdT7o0JFHxntSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773489116; c=relaxed/simple;
	bh=rxBaYJ440e2RcPDV3AZkwVNqFWwnOJ+/aFOTantP0nE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5xzGdH/pVk5u2vXV8juqLctB6MgJKNhx6hxNo5q3NQbdbm9G8nI8/aXlSNWqTBOR1LpZx0TnrwwMZOMo6Ir5kdGFKY5iC68hBfzoyX1pEVLY2ZIpS5gnK9upDVU8RQ9YoGgUBXzjl70q1wHVXuoE17tjJlfsEXtTRjT0QKUVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c7VuxZHY; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d2f9bd52-f570-441b-b3aa-570cc7f37d0c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773489111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irYzK6XlOb5vUP0S37CSUGxxEWUh/ri+N3dJil7zUSs=;
	b=c7VuxZHYW88fq6mBYAg4wgZn2KRIr3Rj1fyBDLE8H3zXOtpoTIZmxPOJ6M5hY7pFY+8D6v
	nWSg7QoC2OVSg+0TmyeKKesb5RxAU/V6LlDLHP9NpoubsWiAOoWuZEa9M6ImLzRaVom0Er
	63JPCVCwKutrd5x1A4KZPKBOemAUCNA=
Date: Sat, 14 Mar 2026 19:51:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] team: fix header_ops type confusion with
 non-Ethernet ports
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+3d8bc31c45e11450f24c@syzkaller.appspotmail.com,
 Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20260314062306.212765-1-jiayuan.chen@linux.dev>
 <CANn89iJR9bjtoZGsybdpX6T4rg1+kzXL0qV00Bs_Fiduf_+2zw@mail.gmail.com>
 <CANn89iJwZfWtGrQw+hA9DumTuYKZm5MLh8O7nkz9mPCHHazUWw@mail.gmail.com>
 <bacc7c58-b6d5-4566-bd6a-b83a2a25c596@linux.dev>
 <CANn89iLp8eaAj4Qtu4dvGeh9zEw+aQFe=n2dMd-zs4n-cjV4QQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CANn89iLp8eaAj4Qtu4dvGeh9zEw+aQFe=n2dMd-zs4n-cjV4QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267723-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,3d8bc31c45e11450f24c];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 262C328CED2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/14/26 7:46 PM, Eric Dumazet wrote:
>> Thanks,
>>
>> I reproduced the infinite recursion you described with stacked bonds
>> (bond1 -> bond0 -> gre0). With an AF_PACKET SOCK_DGRAM socket on bond1
>> and an inbound GRE packet, bond_header_parse() recurses endlessly
>> because skb->dev always points to bond1.
>>
>> I can verify this patch, but changing the parse() signature touches
>> quite a few places beyond what's in the diff - net/mac802154/iface.c,
>> net/phonet/af_phonet.c, drivers/firewire/net.c all have their own
>> parse() implementations that need updating, plus eth_header_parse() is
>> declared in both etherdevice.h and if_ether.h.
>>
>> I'm wondering if adding a separate callback (e.g. dev_parse) to
>> struct header_ops might be a cleaner approach - dev_parse_header()
>> would check for the new callback first and fall back to the existing
>> parse(). That way only bond (and team) need to implement it, and all
>> other drivers remain untouched. The tradeoff is one extra NULL check
>> in the receive path, which should be negligible.
> My patch is ready and already running our tests before I submit it.
>
> git show | diffstat -p1
>   drivers/firewire/net.c          |    5 +++--
>   drivers/net/bonding/bond_main.c |    8 +++++---
>   include/linux/etherdevice.h     |    3 ++-
>   include/linux/if_ether.h        |    3 ++-
>   include/linux/netdevice.h       |    6 ++++--
>   net/ethernet/eth.c              |    3 ++-
>   net/ipv4/ip_gre.c               |    3 ++-
>   net/mac802154/iface.c           |    4 +++-
>   net/phonet/af_phonet.c          |    5 ++++-
>   9 files changed, 27 insertions(+), 13 deletions(-)
>
> I see no issue with this fix, ->parse() is hardly in a fast path anyway.
>
> Note that ->create() already has a 'struct net_device' pointer.


Thanks for the quick patch.

I also verified it fixes the recursion issue after modifying all signatures.



