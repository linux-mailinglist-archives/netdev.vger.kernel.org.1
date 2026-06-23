Return-Path: <netdev+bounces-301411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8wi5B6K3OmpLEwgAu9opvQ
	(envelope-from <netdev+bounces-301411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:43:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 626126B8CC6
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:43:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mandelbit.com header.s=MBO0001 header.b=KhIa09nH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301411-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301411-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24E0E303FBBB
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B78318EC5;
	Tue, 23 Jun 2026 16:41:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D65318EDC;
	Tue, 23 Jun 2026 16:41:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232917; cv=none; b=goh7PeHc+nx+ygVMiQGKaksU9ZkiOKbvF+oZU5ybzUMib4qfkG9ksgCjsDRbhUHFbIYFKcx8REN/Bz+tvkFjY8i1mwAOHpx+FYKpBqSlQc+kQO1JLpnx2PFHkzHKZ/RlvAP/tFzS9QLpls7Kp+VJ1GasvHetd2eErbvSh3U0ZMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232917; c=relaxed/simple;
	bh=/Ozw/pJ649THbLLCrz2kMTyMshGfgnwrsXhgqUAQES8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZdPY7IX8R7ocrV8r82Thhb0f4LOu1sRprp417sV7o/hURI9WuG8bNtMlMxqRapkC/2I+uzc0x0rHkjF4nuC4b9tbUQc02i7+74WFDBhbrfxriH3F8YkpRnVtxs1c4GymyKWFLoE27yEmQR7aA3Vz9k4D4FleQOPHFwZcx+WiCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=KhIa09nH; arc=none smtp.client-ip=195.10.208.52
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4gl9gT3rKxz9yDb;
	Tue, 23 Jun 2026 18:36:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1782232581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dmxk5IGzfmvM4jtNa0odBeix8Um4lg5ptIdqKleDFpE=;
	b=KhIa09nHYDpXmGqj4MEPHbCTdLzb/CCryPctvSdZO7+BEU0mg06dsS6tVRnPDoRJYrMJ4m
	DpRNhgS/VV8bqWMmJzbrD4ZM89AAtuJgzeHql9pu1oc1g8QwGDU51zS1VIa6kM0j9eWoyi
	ODz6kgooNoW/GwGXEp3EhLddUonZh9lmdu0qpwtthFgG/cjB7ULLPOf0g+0hGsYFw1Ivjl
	mt5JW0KBOHoDD/MriQIVv5xUaQCEZ2O5FiDbAzunQZr2SswoO70tYrHMx9GjK9jwrEIETn
	aIIU3XLK0NRtb/Um0bxpcokJH1beTD4tjF6iGwwiSuAZug61d/br11UWdosR4A==
From: Ralf Lici <ralf@mandelbit.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Beniamino Galvani <bgalvani@redhat.com>
Subject: Re: [RFC net-next 08/15] ipxlat: add translation engine and dispatch core
Date: Tue, 23 Jun 2026 18:36:03 +0200
Message-ID: <20260623163606.33510-1-ralf@mandelbit.com>
In-Reply-To: <87ik7aej6f.fsf@toke.dk>
References: <87ik7aej6f.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mandelbit.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:toke@kernel.org,m:netdev@vger.kernel.org,m:dxld@darkboxed.org,m:antonio@mandelbit.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:bgalvani@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mandelbit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301411-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 626126B8CC6

On Mon, 22 Jun 2026 16:36:24 +0200, Toke Høiland-Jørgensen <toke@kernel.org> wrote:
> >> > My second concern is that the SIIT boundary would be a property of
> >> > rule and hook placement. That gives flexibility, but it also means the
> >> > translation point has to be constrained and documented very carefully
> >> > to avoid ambiguous TTL/Hop Limit, PMTU/ICMP, and hook-order behavior.
> >> > For this use case I would rather have the route that matches the
> >> > translation prefix also be the object that says: leave this family
> >> > here and continue in the other one.
> >>
> >> Yeah, with flexibility comes the ability to shoot yourself in the foot.
> >> But that's not really different from much of the other functionality we
> >> have in the kernel today, is it? For netfilter in particular it's
> >> certainly possible to configure a broken NAT configuration that leads to
> >> packet drops (or just invalid packets being sent out on a network
> >> device).
> >>
> >
> > True, misconfiguration is always possible and that alone is not an
> > argument against the netfilter model. But what do we actually gain in
> > capability from that flexibility? I agree on the UX argument (an admin
> > would look in nft first), but in terms of what the feature can do, I
> > can't yet see what the nft model unlocks. More on this just below.
> >
> >> > After looking at the available kernel mechanisms again, I think the
> >> > better model is probably LWT: routes carry an ipxlat encap referencing a
> >> > named translator domain configured over netlink. That should represent
> >> > the stateless, prefix-based and symmetric nature of ipxlat.
> >>
> >> I think this description actually hits the nail on the head: What are we
> >> implementing here? Is it a product feature, or a building block for one?
> >> The properties you mention wrt consistency, symmetry etc are properties
> >> of the high-level feature (which is also generally the level things are
> >> specified in RFCs). Whereas other packet mangling features in the kernel
> >> are more in the "building block" category, where it's possible to
> >> configure things to implement a particular feature set / compliance with
> >> a particular RFC, but it's also possible to do things that are outside
> >> of that.
> >>
> >> I think this relates to the "mechanism, not policy" approach that we
> >> take to most things in the kernel: implement the building blocks to do
> >> something in the most general way we can, and then leave it up to
> >> userspace to configure things in a way that results in a consistent
> >> high-level system behaviour.
> >>
> >
> > That's a good point, and I agree that we should not bake a high-level
> > product policy into the kernel if what we need is a reusable mechanism
> > (the LWT idea was my attempt at exactly that). What I am still trying to
> > understand is whether there is a useful generic trigger for stateless
> > cross-family translation beyond the route/prefix/policy-routing cases.
> >
> > Routes and policy routing already cover the selectors I can make
> > coherent for a stateless, per-packet translator: destination/source
> > prefix, iif/oif/VRF, mark, TOS/DSCP, and so on. nft can of course match
> > much more than that, but the additional selectors that would materially
> > change the translation decision seem to be selectors such as L4 fields,
> > payload state, or conntrack state. Those are exactly the selectors I am
> > struggling to make correct for a stateless translator:
> >
> > - non-first fragments carry no L4 header at all, yet the translator must
> >   rewrite every fragment (an nft ... tcp dport trigger cannot fire on
> >   them);
> >
> > - ICMP errors must be translated too, but the flow identity lives in the
> >   quoted inner header (reversed), not in anything an L4/ct match on the
> >   error packet can see and there is no conntrack to associate them,
> >   since this is stateless.
>
> True in principle, but if (say) you deploy this on a network that is
> configured so it will never fragment packets, this won't be an issue in
> practice.
>
> I.e., you're quite right that arbitrary matching criteria cannot be
> guaranteed to result in coherent translation. But I think that goes into
> the "use it wrong, get wrong results" bin. E.g., if you match on
> something that results in only a subset of the packets of a flow being
> translated, well, only that subset of the packets will make it to the
> destination. The SIIT translator itself should not try to fix this, but
> neither should it prevent it; that's what I mean by "building block" -
> it's up to the builder using the blocks to make sure the building
> doesn't collapse, that's out of scope for the block manufacturer to
> worry about :)
>

I agree with that framing. The translation core should not try to prove
that the surrounding policy describes a coherent SIIT deployment.

> > So an L4-conditional trigger does not look like a good primitive for
> > correct stateless SIIT unless the action also defragments/refragments or
> > uses conntrack-like state. Those may be valid mechanisms, but they move
> > the design away from the stateless per-packet SIIT boundary this RFC is
> > trying to model.
> >
> > So my first question is: is there a useful nft configuration this should
> > enable that is not naturally expressible as route selection, while still
> > remaining stateless SIIT rather than a NAT64-like stateful feature?
> > Maybe there is a real use case there, but I cannot construct one yet.
>
> So the poster child for "match on arbitrary criteria" is of course BPF.
> You can write BPF programs that match on arbitrary parts of the packet
> header, custom encapsulation headers,or even on out of band things like
> system state, phase of the moon, or what have you. And we should
> certainly allow a BPF program to make the decision on whether to perform
> the SIIT translation.
>
> Which... maybe is an argument to keep it as a device like you do in this
> RFC series? Redirecting to a device is trivially supported from TC-BPF,
> which also makes it possible to use the translation mechanism without
> going through the routing subsystem at all, saving a bit of overhead.
> Whereas making it a route action ties it very closely to the routing
> subsystem.
>
> WDYT?
>

I see the netdevice appeal for this, especially as a BPF redirect
target. But as we discussed earlier, the device model has some real
problems: the device selected by the first route is not the real
post-translation egress, so the model ends up doing translation and
reinjection rather than normal transmission. Concretely:

- it needs synthetic routing state purely to get things like MTU for
  fragmentation, because the real post-translation nexthop is not known
  at translation time;

- TTL/Hop Limit handling gets harder to reason about because the packet
  has effectively gone through two routing decisions;

- rx/tx stats can't be made meaningful for a direction-agnostic device
  whose ndo_start_xmit is really "translate and receive";

- and the setup is not very obvious: create an interface, route packets
  to it, then have them come back translated.

None of these is fatal on its own, but together they make me think the
abstraction does not quite fit.

On the BPF point specifically: I agree a BPF program should be able to
decide whether to translate. What I am less sure about is whether
redirecting to a netdevice is the best way to expose that. A TC action
(yet another model, I know :)) gives you the same thing in-pipeline and
more directly:

    tc filter add dev wwan0 egress \
        bpf obj match.o action ipxlat4to6 domain clat0

Let BPF make the policy decision, with the native action doing the
translation work that the current BPF CLAT implementations have trouble
with: fragmentation, checksum corner cases, and ICMP error inner
headers (as explained by Beniamino).

So TC clsact looks like the natural in-kernel replacement for today's
TC-BPF CLAT programs: no extra netdev, you attach to the existing
uplink, direction is explicit, and on egress you sit on the real route
dst, so the synthetic-dst and double-routing problems above just don't
arise. The cost is more moving parts than a single bpf_redirect since
userspace has to manage clsact, filters, priorities and action
lifecycle/cleanup.

For a gateway translator, though, I still think a device-bound model is
less natural. There the translation point is more like a forwarding
decision across routes and nexthops, so a route/LWT attachment, or
possibly a netfilter attachment seems easier to reason about. Also, as
you already pointed out while discussing LWT, an admin setting up NAT64
is more likely to reach for an nft rule than for a clsact filter on a
specific device.

Taking a step back, ipxlat is really a generic translation engine plus a
thin harness around it. So rather than pick one attachment, it might be
worth structuring the engine so different harnesses can drive it.
There's interesting precedent for this shape:

- ILA, again, is the closest sibling: stateless IPv6 address translation
  with a shared core in ila_common.c, driven both by an LWT frontend in
  ila_lwt.c and by an inline netfilter hook with a netlink-configured
  mapping table in ila_xlat.c.

- act_ct is the precedent for the TC side specifically: a TC action that
  reuses the netfilter conntrack engine rather than reimplementing it.

And act_nat is the cautionary counter-example: a standalone TC
reimplementation of stateless NAT that shares no code with nf_nat, and
carries a "would be nice to share code" comment :)

So I am wondering whether the right direction is to factor the
translation engine cleanly, land it with one harness first, and keep the
other attachment points as follow-up work once the core semantics are
settled.

Does that direction seem reasonable to you?

-- 
Ralf Lici
Mandelbit Srl

