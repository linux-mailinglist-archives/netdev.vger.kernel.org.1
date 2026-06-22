Return-Path: <netdev+bounces-301131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qamAOzw9OWpDpAcAu9opvQ
	(envelope-from <netdev+bounces-301131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:48:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 516B86B000A
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:48:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mandelbit.com header.s=MBO0001 header.b=SGKC6Bh9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301131-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301131-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 883FD3048AE7
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D843A9D88;
	Mon, 22 Jun 2026 13:45:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org [195.10.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286583B52E2;
	Mon, 22 Jun 2026 13:45:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782135906; cv=none; b=U0H5jiB/brXocM6bOfMz7LNNSO52qTKEHtXP/xwUyafAqMolWRK6rtqCkUoHGiR7JN31pkQaElQIclQOWe1uaB7oIs3kTSGexd9w2wZx0p0EIbWc/xGPvL2fvaheHlvMIAQ47EJEyxXFXsd1kzVpUCCLmEO/dMTAbAhJjjrnHKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782135906; c=relaxed/simple;
	bh=3EERqSROkKJeZIS55WvTwPWn1OGBTmhXO/o5MGT/Ivo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxfN7iBlsItITGzUpiJG0rgftLudReGROvEW/W6fDTuZQAwYhbSA4Y72MDdiEo/FADvvXIP1FX9nGFFUJSwHri5uoy1+QIOrekd+d4aoJeR7LgUVuHzoi/gcLRzYH/6tbuAg1BKuDp98TiGYG/+R2XVNJY+5NBcPBOr+7o7UcdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=SGKC6Bh9; arc=none smtp.client-ip=195.10.208.47
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4gkThr3kYSzDs9K;
	Mon, 22 Jun 2026 15:35:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1782135308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YsiunaZljnUO2GDKo2sNr9GAmCWULG3HSc99XfVjq+I=;
	b=SGKC6Bh9nMSCupPhVG2CzVRlFmTFVjd0/6uO6bywYJUVD1qgKU07QSsWtRD4o+kXycvWZ7
	Gsk8CySlegCeuOjUECRfrYe+abZwdBiBLlUkzAei/Y1QjPYt85KkI4KGegzH7OF6eFh/YT
	6NCQw3rn6rdBZ1h35M2owwF6d3RvePDXfqUCJg/SbU/eeukXt0tB4V9PwDHB1p3LOXDhHm
	nmfTSYPGDwkQ6I7hIGcLEiD/hjkoqRWxlq5ANwLh34lQLxFTeKhnYMsbpXUmGuMtoSX/zT
	iZbcp085O9YK1rJolhBECIZP2meqWSblZGsnG/uCVhRE66tkZA6/iFpNDHJEPQ==
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
Date: Mon, 22 Jun 2026 15:34:47 +0200
Message-ID: <20260622133452.432257-1-ralf@mandelbit.com>
In-Reply-To: <87tsr4gcag.fsf@toke.dk>
References: <87tsr4gcag.fsf@toke.dk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:toke@kernel.org,m:netdev@vger.kernel.org,m:dxld@darkboxed.org,m:antonio@mandelbit.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:bgalvani@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mandelbit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301131-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mandelbit.com:dkim,mandelbit.com:mid,mandelbit.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 516B86B000A

On Mon, 15 Jun 2026 15:31:51 +0200, Toke Høiland-Jørgensen <toke@kernel.org> wrote:
> >> >> I think a better model is to treat the device as basically a loopback
> >> >> device that translates packets before looping them back (so when they
> >> >> come back they appear to be coming from that device).
> >> >>
> >> >> Any reason why that wouldn't work?
> >> >>
> >> >
> >> > That's indeed the intended model for the ipxlat netdevice: route packets
> >> > to it, translate them, then loop them back into the stack as packets
> >> > received from that same device. That seemed like the simplest model and
> >> > the one that exposes the translation point most clearly.
> >>
> >> Right. I think this could be made a bit more explicit in the
> >> documentation as well, since it's a bit of an unusual model.
> >>
> >> And, well, taking a step back: is it really the right model? Regular NAT
> >> lives in netfilter, why can't this be a netfilter module as well? Seems
> >> to me you could have something like:
> >>
> >> table ip xlat4 {
> >> 	chain postrouting {
> >> 		type nat hook postrouting priority srcnat; policy accept;
> >> 		ip daddr 0.0.0.0/0 oifname "eth0" xlat to 64:ff9b::/96
> >> 	}
> >> }
> >> table ip6 xlat6 {
> >> 	chain prerouting {
> >> 		type nat hook prerouting priority dstnat; policy accept;
> >> 		ip6 saddr 64::ff0b::/96 iifname "eth0" xlat from 64::ff9b::/96
> >> 	}
> >> }
> >>
> >> and that would provide the functionality without having to implement a
> >> new interface type and the associated multiple traversals through the
> >> stack? Did you consider this as an alternative to the new device type?
> >>
> >
> > We did consider netfilter, and your example is syntactically attractive,
> > but I am no longer convinced it is the cleanest model for SIIT.
> >
> > An nft expression cannot simply rewrite ETH_P_IP <-> ETH_P_IPV6 and
> > return ACCEPT as if this were normal NAT because the current hook
> > invocation, dst, and conntrack-related state were established for the
> > packet as it entered that hook. A cross-family translator would need to
> > consume the skb, clear or rebuild route and ct metadata as appropriate,
> > do an other-family route lookup, and resume at a well-defined point in
> > that family. That seems possible, but it would be a new stateless
> > cross-family action, not just a new mode of the existing nft nat
> > expression (which is built around nf_nat_setup_info and assumes the
> > packet's L3 family does not change AFAICT).
>
> Right, I did not expect it would be possible to actually share code with
> the existing NAT functionality, but conceptually they're similar. I.e.,
> if I was an admin trying to figure out if my system supported SIIT
> translation, my chain of thought would be something along the line of:
> "SIIT is a variant of NAT, and I know NAT is a long-standing feature of
> netfilter, so I wonder if SIIT exists there as well".
>
> Adding the netfilter folks to Cc to try to get their attention and an
> opinion on this :)
>

That's the right move, it would be great to have their opinion on these
architectural questions.

For the netfilter folks just added: the context is a stateless
IPv6<>IPv4 SIIT translator (RFC 7915). The open design question is
whether the stateless cross-family translation should live as an nft
action, or as a route/LWT action (ILA / seg6_local lineage).

> > My second concern is that the SIIT boundary would be a property of
> > rule and hook placement. That gives flexibility, but it also means the
> > translation point has to be constrained and documented very carefully
> > to avoid ambiguous TTL/Hop Limit, PMTU/ICMP, and hook-order behavior.
> > For this use case I would rather have the route that matches the
> > translation prefix also be the object that says: leave this family
> > here and continue in the other one.
>
> Yeah, with flexibility comes the ability to shoot yourself in the foot.
> But that's not really different from much of the other functionality we
> have in the kernel today, is it? For netfilter in particular it's
> certainly possible to configure a broken NAT configuration that leads to
> packet drops (or just invalid packets being sent out on a network
> device).
>

True, misconfiguration is always possible and that alone is not an
argument against the netfilter model. But what do we actually gain in
capability from that flexibility? I agree on the UX argument (an admin
would look in nft first), but in terms of what the feature can do, I
can't yet see what the nft model unlocks. More on this just below.

> > After looking at the available kernel mechanisms again, I think the
> > better model is probably LWT: routes carry an ipxlat encap referencing a
> > named translator domain configured over netlink. That should represent
> > the stateless, prefix-based and symmetric nature of ipxlat.
>
> I think this description actually hits the nail on the head: What are we
> implementing here? Is it a product feature, or a building block for one?
> The properties you mention wrt consistency, symmetry etc are properties
> of the high-level feature (which is also generally the level things are
> specified in RFCs). Whereas other packet mangling features in the kernel
> are more in the "building block" category, where it's possible to
> configure things to implement a particular feature set / compliance with
> a particular RFC, but it's also possible to do things that are outside
> of that.
>
> I think this relates to the "mechanism, not policy" approach that we
> take to most things in the kernel: implement the building blocks to do
> something in the most general way we can, and then leave it up to
> userspace to configure things in a way that results in a consistent
> high-level system behaviour.
>

That's a good point, and I agree that we should not bake a high-level
product policy into the kernel if what we need is a reusable mechanism
(the LWT idea was my attempt at exactly that). What I am still trying to
understand is whether there is a useful generic trigger for stateless
cross-family translation beyond the route/prefix/policy-routing cases.

Routes and policy routing already cover the selectors I can make
coherent for a stateless, per-packet translator: destination/source
prefix, iif/oif/VRF, mark, TOS/DSCP, and so on. nft can of course match
much more than that, but the additional selectors that would materially
change the translation decision seem to be selectors such as L4 fields,
payload state, or conntrack state. Those are exactly the selectors I am
struggling to make correct for a stateless translator:

- non-first fragments carry no L4 header at all, yet the translator must
  rewrite every fragment (an nft ... tcp dport trigger cannot fire on
  them);

- ICMP errors must be translated too, but the flow identity lives in the
  quoted inner header (reversed), not in anything an L4/ct match on the
  error packet can see and there is no conntrack to associate them,
  since this is stateless.

So an L4-conditional trigger does not look like a good primitive for
correct stateless SIIT unless the action also defragments/refragments or
uses conntrack-like state. Those may be valid mechanisms, but they move
the design away from the stateless per-packet SIIT boundary this RFC is
trying to model.

So my first question is: is there a useful nft configuration this should
enable that is not naturally expressible as route selection, while still
remaining stateless SIIT rather than a NAT64-like stateful feature?
Maybe there is a real use case there, but I cannot construct one yet.

> That being said:
>
> > Very roughly, userspace could look like:
> >
> >     ip xlat add siit0 prefix6 64:ff9b::/96
> >     ip route add ... encap ipxlat id siit0
> >     ip -6 route add ... encap ipxlat id siit0
> >
> > There are some useful precedents for this: ILA is stateless address
> > translation as LWT, seg6_local already has cross-family LWT actions, and
> > ioam6 has a similar split between separately configured objects and
> > route attachments.
> >
> > The invariant I would like v2 to follow is that the original-family
> > route lookup selects translation as its terminal route action. The
> > translated skb then gets a fresh lookup in the other family. From that
> > point on, TTL/Hop Limit where applicable, PMTU, ICMP errors, and
> > netfilter visibility belong to the translated family.
> >
> > So I think your question addresses the core design issue in this RFC. My
> > current preference is to rework the next version around an LWT/domain
> > model instead of the virtual netdevice model, unless prototyping shows a
> > fundamental problem with that approach.
> >
> > Does that model make sense to you?
>
> I did consider this as well before suggesting netfilter as the right
> place to hook things, and I do think the route object model has some
> appeal. I agree it's a better model than the magical loopback interface,
> certainly.
>
> I think in the end this comes down to whether flexibility in how to use
> this translation mechanism is a bug or a feature, as outlined above. I'm
> leaning towards "feature", but could probably be persuaded otherwise :)
>

I agree this is the tradeoff to settle now. The reason I suggested LWT
is that making the family-A route lookup the handoff point gives the
TTL/PMTU/ICMP-and-reroute semantics a natural place to live.

So my other question, where the netfilter maintainers' input would be
very useful, is what semantics would be acceptable for changing address
family inside a netfilter hook. Concretely:

- What verdict should such an expression return? My assumption is it
  has to consume the skb and reinject into the other family (NF_STOLEN
  + reinject), since ACCEPT would resume traversal in a family whose
  dst/chain no longer apply.

- What becomes of the original-family conntrack entry, which is now
  orphaned (and is pure overhead in the stateless case)?

- Where do TTL/Hop-Limit, PMTU/ICMP generation, and netfilter
  visibility end up belonging after the family changes?

All that said, the netfilter model has its own strengths, and once we
settle the architectural questions it could turn into a very clean
design. Curious to hear your thoughts on the points above.

-- 
Ralf Lici
Mandelbit Srl

