Return-Path: <netdev+bounces-301471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1VPGBbnlOmojKggAu9opvQ
	(envelope-from <netdev+bounces-301471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 21:59:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A40E6B9D1A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 21:59:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=L0QSkjhI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301471-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301471-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 808643084BF3
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E3E39281F;
	Tue, 23 Jun 2026 19:59:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5DE2E0902;
	Tue, 23 Jun 2026 19:59:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782244789; cv=none; b=aOnwazB7TmtaDdMY1aTm/2Iv9ceE3RCYUcWJd/ySOkW+04PJUxvIS37MTj10XZSvfmMZihlig/qpmNQVlFQM65Kc/AvF1WDJczZd/tZFfW1ESV5dos/lzFm+zlo0d1H2960f5wM/YOj74Y1Cgyx+Jk4ZFeGhD9gx9AzEZcrIEvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782244789; c=relaxed/simple;
	bh=Y1rQK8DdECZwtHe0BRuyZVGyB/9hqdCoRQ8Cj/HR9/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C32HvZgS5y8+GU0j75uNF6n1qD5hU4z3mi9j6I2Y6NMWmJkrH5suhLdxgEci6hWedcE4shEy8g7lH4qjTwTepDSDdf69M3V/rsbW3GoeVB6/RwcLpDPxhesa8BgXxKPxx3ig3ramExb7IVzAl8+lOst8T4GV3s5zgN3dqAOubAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0QSkjhI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8201F000E9;
	Tue, 23 Jun 2026 19:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782244787;
	bh=IsxH7MOIh2p46ZJMqngpVvQlSSdPJ/UIZlWgK4gluwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=L0QSkjhIow5sungdraTWJz12bf+DD8calIL5RDrx9Zbo24kSuG9D6cUVz7Nd8zeg1
	 lhWX04ZtSmnmMkK3TjUowyACpKUTkiPDcWzUrZYpa16YZ+CEln4EDhRU/2/UTtzirC
	 TboTbrk1HppaZvKIcNb4ImmlvWVL/mZvpsLWpPjW7t6LfMomTb2tNfcWfo7TDLaEbd
	 6ShqkRzkNDaGK1eIcToawCq3beqJDMp0Kw8Vm4qQUsMO67EXaG/TDBwCL/C/cOLtb1
	 ZxoUdIuYrNb3DMEXR07HdOI2mbWYaIVV0+3zP8oIjEFgge+gci7JGBGNHFh4nNoWUf
	 8uFACuVvaLaIw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 66F0D808D89; Tue, 23 Jun 2026 21:59:44 +0200 (CEST)
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
In-Reply-To: <20260623163606.33510-1-ralf@mandelbit.com>
References: <87ik7aej6f.fsf@toke.dk>
 <20260623163606.33510-1-ralf@mandelbit.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 23 Jun 2026 21:59:44 +0200
Message-ID: <87v7b9c9jj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.07 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-301471-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[toke@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ralf@mandelbit.com,m:netdev@vger.kernel.org,m:dxld@darkboxed.org,m:antonio@mandelbit.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:bgalvani@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,toke.dk:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A40E6B9D1A

Ralf Lici <ralf@mandelbit.com> writes:

> On Mon, 22 Jun 2026 16:36:24 +0200, Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@kernel.org> wrote:
>> >> > My second concern is that the SIIT boundary would be a property of
>> >> > rule and hook placement. That gives flexibility, but it also means =
the
>> >> > translation point has to be constrained and documented very careful=
ly
>> >> > to avoid ambiguous TTL/Hop Limit, PMTU/ICMP, and hook-order behavio=
r.
>> >> > For this use case I would rather have the route that matches the
>> >> > translation prefix also be the object that says: leave this family
>> >> > here and continue in the other one.
>> >>
>> >> Yeah, with flexibility comes the ability to shoot yourself in the foo=
t.
>> >> But that's not really different from much of the other functionality =
we
>> >> have in the kernel today, is it? For netfilter in particular it's
>> >> certainly possible to configure a broken NAT configuration that leads=
 to
>> >> packet drops (or just invalid packets being sent out on a network
>> >> device).
>> >>
>> >
>> > True, misconfiguration is always possible and that alone is not an
>> > argument against the netfilter model. But what do we actually gain in
>> > capability from that flexibility? I agree on the UX argument (an admin
>> > would look in nft first), but in terms of what the feature can do, I
>> > can't yet see what the nft model unlocks. More on this just below.
>> >
>> >> > After looking at the available kernel mechanisms again, I think the
>> >> > better model is probably LWT: routes carry an ipxlat encap referenc=
ing a
>> >> > named translator domain configured over netlink. That should repres=
ent
>> >> > the stateless, prefix-based and symmetric nature of ipxlat.
>> >>
>> >> I think this description actually hits the nail on the head: What are=
 we
>> >> implementing here? Is it a product feature, or a building block for o=
ne?
>> >> The properties you mention wrt consistency, symmetry etc are properti=
es
>> >> of the high-level feature (which is also generally the level things a=
re
>> >> specified in RFCs). Whereas other packet mangling features in the ker=
nel
>> >> are more in the "building block" category, where it's possible to
>> >> configure things to implement a particular feature set / compliance w=
ith
>> >> a particular RFC, but it's also possible to do things that are outside
>> >> of that.
>> >>
>> >> I think this relates to the "mechanism, not policy" approach that we
>> >> take to most things in the kernel: implement the building blocks to do
>> >> something in the most general way we can, and then leave it up to
>> >> userspace to configure things in a way that results in a consistent
>> >> high-level system behaviour.
>> >>
>> >
>> > That's a good point, and I agree that we should not bake a high-level
>> > product policy into the kernel if what we need is a reusable mechanism
>> > (the LWT idea was my attempt at exactly that). What I am still trying =
to
>> > understand is whether there is a useful generic trigger for stateless
>> > cross-family translation beyond the route/prefix/policy-routing cases.
>> >
>> > Routes and policy routing already cover the selectors I can make
>> > coherent for a stateless, per-packet translator: destination/source
>> > prefix, iif/oif/VRF, mark, TOS/DSCP, and so on. nft can of course match
>> > much more than that, but the additional selectors that would materially
>> > change the translation decision seem to be selectors such as L4 fields,
>> > payload state, or conntrack state. Those are exactly the selectors I am
>> > struggling to make correct for a stateless translator:
>> >
>> > - non-first fragments carry no L4 header at all, yet the translator mu=
st
>> >   rewrite every fragment (an nft ... tcp dport trigger cannot fire on
>> >   them);
>> >
>> > - ICMP errors must be translated too, but the flow identity lives in t=
he
>> >   quoted inner header (reversed), not in anything an L4/ct match on the
>> >   error packet can see and there is no conntrack to associate them,
>> >   since this is stateless.
>>
>> True in principle, but if (say) you deploy this on a network that is
>> configured so it will never fragment packets, this won't be an issue in
>> practice.
>>
>> I.e., you're quite right that arbitrary matching criteria cannot be
>> guaranteed to result in coherent translation. But I think that goes into
>> the "use it wrong, get wrong results" bin. E.g., if you match on
>> something that results in only a subset of the packets of a flow being
>> translated, well, only that subset of the packets will make it to the
>> destination. The SIIT translator itself should not try to fix this, but
>> neither should it prevent it; that's what I mean by "building block" -
>> it's up to the builder using the blocks to make sure the building
>> doesn't collapse, that's out of scope for the block manufacturer to
>> worry about :)
>>
>
> I agree with that framing. The translation core should not try to prove
> that the surrounding policy describes a coherent SIIT deployment.

Cool!

>> > So an L4-conditional trigger does not look like a good primitive for
>> > correct stateless SIIT unless the action also defragments/refragments =
or
>> > uses conntrack-like state. Those may be valid mechanisms, but they move
>> > the design away from the stateless per-packet SIIT boundary this RFC is
>> > trying to model.
>> >
>> > So my first question is: is there a useful nft configuration this shou=
ld
>> > enable that is not naturally expressible as route selection, while sti=
ll
>> > remaining stateless SIIT rather than a NAT64-like stateful feature?
>> > Maybe there is a real use case there, but I cannot construct one yet.
>>
>> So the poster child for "match on arbitrary criteria" is of course BPF.
>> You can write BPF programs that match on arbitrary parts of the packet
>> header, custom encapsulation headers,or even on out of band things like
>> system state, phase of the moon, or what have you. And we should
>> certainly allow a BPF program to make the decision on whether to perform
>> the SIIT translation.
>>
>> Which... maybe is an argument to keep it as a device like you do in this
>> RFC series? Redirecting to a device is trivially supported from TC-BPF,
>> which also makes it possible to use the translation mechanism without
>> going through the routing subsystem at all, saving a bit of overhead.
>> Whereas making it a route action ties it very closely to the routing
>> subsystem.
>>
>> WDYT?
>>
>
> I see the netdevice appeal for this, especially as a BPF redirect
> target. But as we discussed earlier, the device model has some real
> problems: the device selected by the first route is not the real
> post-translation egress, so the model ends up doing translation and
> reinjection rather than normal transmission. Concretely:
>
> - it needs synthetic routing state purely to get things like MTU for
>   fragmentation, because the real post-translation nexthop is not known
>   at translation time;
>
> - TTL/Hop Limit handling gets harder to reason about because the packet
>   has effectively gone through two routing decisions;
>
> - rx/tx stats can't be made meaningful for a direction-agnostic device
>   whose ndo_start_xmit is really "translate and receive";
>
> - and the setup is not very obvious: create an interface, route packets
>   to it, then have them come back translated.
>
> None of these is fatal on its own, but together they make me think the
> abstraction does not quite fit.

Right, OK, you're right.

> On the BPF point specifically: I agree a BPF program should be able to
> decide whether to translate. What I am less sure about is whether
> redirecting to a netdevice is the best way to expose that. A TC action
> (yet another model, I know :)) gives you the same thing in-pipeline and
> more directly:
>
>     tc filter add dev wwan0 egress \
>         bpf obj match.o action ipxlat4to6 domain clat0
>
> Let BPF make the policy decision, with the native action doing the
> translation work that the current BPF CLAT implementations have trouble
> with: fragmentation, checksum corner cases, and ICMP error inner
> headers (as explained by Beniamino).
>
> So TC clsact looks like the natural in-kernel replacement for today's
> TC-BPF CLAT programs: no extra netdev, you attach to the existing
> uplink, direction is explicit, and on egress you sit on the real route
> dst, so the synthetic-dst and double-routing problems above just don't
> arise. The cost is more moving parts than a single bpf_redirect since
> userspace has to manage clsact, filters, priorities and action
> lifecycle/cleanup.

Hmm, so no one really uses the bpf filter mechanism, since you can just
do everything from an action anyway (and with TCX attachment, you can
even avoid the overhead of the TC filter/action infrastructure
entirely). However, point taken wrt how to integrate this with BPF. I
guess the most flexible thing would be to expose the functionality
directly (as a kfunc callable from a BPF program). Which also fits with
your point below:

> For a gateway translator, though, I still think a device-bound model is
> less natural. There the translation point is more like a forwarding
> decision across routes and nexthops, so a route/LWT attachment, or
> possibly a netfilter attachment seems easier to reason about. Also, as
> you already pointed out while discussing LWT, an admin setting up NAT64
> is more likely to reach for an nft rule than for a clsact filter on a
> specific device.
>
> Taking a step back, ipxlat is really a generic translation engine plus a
> thin harness around it. So rather than pick one attachment, it might be
> worth structuring the engine so different harnesses can drive it.
> There's interesting precedent for this shape:
>
> - ILA, again, is the closest sibling: stateless IPv6 address translation
>   with a shared core in ila_common.c, driven both by an LWT frontend in
>   ila_lwt.c and by an inline netfilter hook with a netlink-configured
>   mapping table in ila_xlat.c.
>
> - act_ct is the precedent for the TC side specifically: a TC action that
>   reuses the netfilter conntrack engine rather than reimplementing it.
>
> And act_nat is the cautionary counter-example: a standalone TC
> reimplementation of stateless NAT that shares no code with nf_nat, and
> carries a "would be nice to share code" comment :)
>
> So I am wondering whether the right direction is to factor the
> translation engine cleanly, land it with one harness first, and keep the
> other attachment points as follow-up work once the core semantics are
> settled.
>
> Does that direction seem reasonable to you?

Yes, reusable functionality that can be called from multiple places
sounds like a good fit; let's try to structure it that way!

As for which hook to start with, well, let's see if we hear back from
the netfilter devs, but either netfilter or the routing subsystem (LWT
style) would be OK for me I think.

-Toke

