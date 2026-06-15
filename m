Return-Path: <netdev+bounces-299459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JsVJLtH+L2rvLQUAu9opvQ
	(envelope-from <netdev+bounces-299459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:32:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62374686C3F
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:32:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="JUkkdW1/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299459-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299459-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 972883001190
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E0431E841;
	Mon, 15 Jun 2026 13:31:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9351D3B1019;
	Mon, 15 Jun 2026 13:31:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781530315; cv=none; b=P6oHeCzONXDLHRoEJ7Odn6T1F41qp0XxuwHMX4hpxyE72civqxsPF2QMIL9eOYYaYH1J44QiCCszx6d03h9WYeAjk0fBTEg0Ve2UMUWnETUI7d6gPaPS6LyeS7kHtv4bYWxF5SHf4Yz8OjL+1I2ZQnnvdE4wRIc/fBXq1oTnQlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781530315; c=relaxed/simple;
	bh=J0PZwtlc2VuNaUOXmgoS040zBTts3Xn3jXv8piPDHuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I7hnsHAlSJmO+b9wn9ra07ktkZiNVzuy1/UCK7k+8btYCs3Zp1qbF+L2wLBsVdQwtJZ2UKBPsFRvEVni3lZUI2rrxTo7B0azZ8xUIGZATkPDqq31y6jz+IOokZmdN50pF4XTdK2sv9EdkPbDWYIRNRyrsXSWaIfzThyZrdYF4vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUkkdW1/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E181F000E9;
	Mon, 15 Jun 2026 13:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781530314;
	bh=N0wWQi/FeGQj+quTWVwpP8K9Ipllbpi9SvCg6YgYXQ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=JUkkdW1/QVL+1sUybSANORQ+7nGhcGWXw2PvPshwsjdfidJAW0smFwoWnDGO+JPGT
	 PBZwHVepQZTQ/to8hJtBL6nxCHxqSz7gFJ565533A6d7GlSDGh8tgoOxbHZbhFTd2q
	 tWj3HeQG/oV4KK2nRCegKtAXDMSAcHc60eXFncsjVsHuhfu3+ycv18eQyqwD52awTc
	 uETc8rA5geOM79p1d54QeSXndpM6UmZv+Lzqi9ex6dCGpc1/oQdS4Hia5OnD9JXpxn
	 BOaSysVerSC880y9SOpif2fC8EhAVYT5R9VEqfjms9gP/LUP48gqbUiVd5v6ODO8M6
	 oEtK6+6XR0dhA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 815EB806E35; Mon, 15 Jun 2026 15:31:51 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Ralf Lici <ralf@mandelbit.com>
Cc: netdev@vger.kernel.org, Daniel =?utf-8?Q?Gr=C3=B6ber?=
 <dxld@darkboxed.org>, Antonio
 Quartulli <antonio@mandelbit.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org, Pablo Neira Ayuso
 <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter
 <phil@nwl.cc>, Beniamino Galvani <bgalvani@redhat.com>
Subject: Re: [RFC net-next 08/15] ipxlat: add translation engine and
 dispatch core
In-Reply-To: <20260613131720.253936-1-ralf@mandelbit.com>
References: <87y0gm8x5k.fsf@toke.dk>
 <20260613131720.253936-1-ralf@mandelbit.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 15 Jun 2026 15:31:51 +0200
Message-ID: <87tsr4gcag.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.57 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299459-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ralf@mandelbit.com,m:netdev@vger.kernel.org,m:dxld@darkboxed.org,m:antonio@mandelbit.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:bgalvani@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[toke@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62374686C3F

>> >> I think a better model is to treat the device as basically a loopback
>> >> device that translates packets before looping them back (so when they
>> >> come back they appear to be coming from that device).
>> >>
>> >> Any reason why that wouldn't work?
>> >>
>> >
>> > That's indeed the intended model for the ipxlat netdevice: route packets
>> > to it, translate them, then loop them back into the stack as packets
>> > received from that same device. That seemed like the simplest model and
>> > the one that exposes the translation point most clearly.
>>
>> Right. I think this could be made a bit more explicit in the
>> documentation as well, since it's a bit of an unusual model.
>>
>> And, well, taking a step back: is it really the right model? Regular NAT
>> lives in netfilter, why can't this be a netfilter module as well? Seems
>> to me you could have something like:
>>
>> table ip xlat4 {
>> 	chain postrouting {
>> 		type nat hook postrouting priority srcnat; policy accept;
>> 		ip daddr 0.0.0.0/0 oifname "eth0" xlat to 64:ff9b::/96
>> 	}
>> }
>> table ip6 xlat6 {
>> 	chain prerouting {
>> 		type nat hook prerouting priority dstnat; policy accept;
>> 		ip6 saddr 64::ff0b::/96 iifname "eth0" xlat from 64::ff9b::/96
>> 	}
>> }
>>
>> and that would provide the functionality without having to implement a
>> new interface type and the associated multiple traversals through the
>> stack? Did you consider this as an alternative to the new device type?
>>
>
> We did consider netfilter, and your example is syntactically attractive,
> but I am no longer convinced it is the cleanest model for SIIT.
>
> An nft expression cannot simply rewrite ETH_P_IP <-> ETH_P_IPV6 and
> return ACCEPT as if this were normal NAT because the current hook
> invocation, dst, and conntrack-related state were established for the
> packet as it entered that hook. A cross-family translator would need to
> consume the skb, clear or rebuild route and ct metadata as appropriate,
> do an other-family route lookup, and resume at a well-defined point in
> that family. That seems possible, but it would be a new stateless
> cross-family action, not just a new mode of the existing nft nat
> expression (which is built around nf_nat_setup_info and assumes the
> packet's L3 family does not change AFAICT).

Right, I did not expect it would be possible to actually share code with
the existing NAT functionality, but conceptually they're similar. I.e.,
if I was an admin trying to figure out if my system supported SIIT
translation, my chain of thought would be something along the line of:
"SIIT is a variant of NAT, and I know NAT is a long-standing feature of
netfilter, so I wonder if SIIT exists there as well".

Adding the netfilter folks to Cc to try to get their attention and an
opinion on this :)

> My second concern is that the SIIT boundary would be a property of
> rule and hook placement. That gives flexibility, but it also means the
> translation point has to be constrained and documented very carefully
> to avoid ambiguous TTL/Hop Limit, PMTU/ICMP, and hook-order behavior.
> For this use case I would rather have the route that matches the
> translation prefix also be the object that says: leave this family
> here and continue in the other one.

Yeah, with flexibility comes the ability to shoot yourself in the foot.
But that's not really different from much of the other functionality we
have in the kernel today, is it? For netfilter in particular it's
certainly possible to configure a broken NAT configuration that leads to
packet drops (or just invalid packets being sent out on a network
device).

> After looking at the available kernel mechanisms again, I think the
> better model is probably LWT: routes carry an ipxlat encap referencing a
> named translator domain configured over netlink. That should represent
> the stateless, prefix-based and symmetric nature of ipxlat.

I think this description actually hits the nail on the head: What are we
implementing here? Is it a product feature, or a building block for one?
The properties you mention wrt consistency, symmetry etc are properties
of the high-level feature (which is also generally the level things are
specified in RFCs). Whereas other packet mangling features in the kernel
are more in the "building block" category, where it's possible to
configure things to implement a particular feature set / compliance with
a particular RFC, but it's also possible to do things that are outside
of that.

I think this relates to the "mechanism, not policy" approach that we
take to most things in the kernel: implement the building blocks to do
something in the most general way we can, and then leave it up to
userspace to configure things in a way that results in a consistent
high-level system behaviour.

That being said:

> Very roughly, userspace could look like:
>
>     ip xlat add siit0 prefix6 64:ff9b::/96
>     ip route add ... encap ipxlat id siit0
>     ip -6 route add ... encap ipxlat id siit0
>
> There are some useful precedents for this: ILA is stateless address
> translation as LWT, seg6_local already has cross-family LWT actions, and
> ioam6 has a similar split between separately configured objects and
> route attachments.
>
> The invariant I would like v2 to follow is that the original-family
> route lookup selects translation as its terminal route action. The
> translated skb then gets a fresh lookup in the other family. From that
> point on, TTL/Hop Limit where applicable, PMTU, ICMP errors, and
> netfilter visibility belong to the translated family.
>
> So I think your question addresses the core design issue in this RFC. My
> current preference is to rework the next version around an LWT/domain
> model instead of the virtual netdevice model, unless prototyping shows a
> fundamental problem with that approach.
>
> Does that model make sense to you?

I did consider this as well before suggesting netfilter as the right
place to hook things, and I do think the route object model has some
appeal. I agree it's a better model than the magical loopback interface,
certainly.

I think in the end this comes down to whether flexibility in how to use
this translation mechanism is a bug or a feature, as outlined above. I'm
leaning towards "feature", but could probably be persuaded otherwise :)

> Thanks for pushing on this.

You're welcome! Thanks for working on it - will be cool to have this
land in whatever form we end up agreeing on!

-Toke

