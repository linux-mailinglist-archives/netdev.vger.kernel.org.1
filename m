Return-Path: <netdev+bounces-302570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zHOPIitSQmoM4wkAu9opvQ
	(envelope-from <netdev+bounces-302570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:08:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 225196D931A
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:08:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KQGLJoyn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302570-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302570-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FC2F300D4E0
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EF336C588;
	Mon, 29 Jun 2026 11:08:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FB5367B98;
	Mon, 29 Jun 2026 11:08:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731305; cv=none; b=DRk9vk2mnS9JT7VOtSbl8Kxz2/mDfLsREv0nXzZA3Arm1ZumDHwpU/wuHghb2BjSUoR0G7jra7BodCluJjgVZzWCE6aUk6++0g+18sZ/CJPV/62080GpNq91Q52OjqUzlaPe304a7uwV4CEI6nrkiDG0tYKEauvOUyAixpJ+YvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731305; c=relaxed/simple;
	bh=3rynhgaqXwze0Jqud6scrZk9b7QTG4cBaIRiAHpPZl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uTN71qhFBcohsiZpmx9EAyDSYqqBXYT+ZYmipzpYLC0lBh9vgEMzwOTm4xS7w0KkBDy6ilDAvIDbfUnwXQMWB9PSFdM1XpdgrH1qvGOjs25NSkR1jujVnX7y10xoQNjAKJI/UaHmYSwcRIflSiPGJAeF3ZbWhQwfelyFn+c/dII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQGLJoyn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2AF1F000E9;
	Mon, 29 Jun 2026 11:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782731303;
	bh=8p1TXG4R7ot85xgBmG5jpGYEkGHYg3itgtMPk/OkNlE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=KQGLJoynBpKj+FjZHPakpxLK7VjiyhWgsnoTqyfDP/6kBidefxIXVKXABWcDtGUuZ
	 iOiPkoln+uz3mtoHfczA1QGIjZDzxWfJZ8mz31V6ob0tDxYRShB0dsEv7I8e8f4DBc
	 Gqk1Ep2rvqgB/J3tYGqY1Ci2KVq4TTPd2xNdMhkcmo/ziaqullKjk6xbQWb5PNLHQy
	 42CIn5NUkhntmCYf6iJKVvVlkObDZtgcxYeHQ+ScpzOLz9w5lMhNT0EgSD4XQidemf
	 P2sVo9hePTxJSZ5igHZX/LqsqBpnonkQbWpOHzxsF3nG+0WqfqnXGQEmTVpagUykWS
	 fmw1lNthiHcew==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 107EC80A1C6; Mon, 29 Jun 2026 13:08:21 +0200 (CEST)
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
In-Reply-To: <20260624161854.686569-1-ralf@mandelbit.com>
References: <87v7b9c9jj.fsf@toke.dk>
 <20260624161854.686569-1-ralf@mandelbit.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 29 Jun 2026 13:08:21 +0200
Message-ID: <87bjctd2oq.fsf@toke.dk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-302570-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mandelbit.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 225196D931A

Ralf Lici <ralf@mandelbit.com> writes:

> On Tue, 23 Jun 2026 21:59:44 +0200, Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@kernel.org> wrote:
>> Ralf Lici <ralf@mandelbit.com> writes:
>> > On the BPF point specifically: I agree a BPF program should be able to
>> > decide whether to translate. What I am less sure about is whether
>> > redirecting to a netdevice is the best way to expose that. A TC action
>> > (yet another model, I know :)) gives you the same thing in-pipeline and
>> > more directly:
>> >
>> >     tc filter add dev wwan0 egress \
>> >         bpf obj match.o action ipxlat4to6 domain clat0
>> >
>> > Let BPF make the policy decision, with the native action doing the
>> > translation work that the current BPF CLAT implementations have trouble
>> > with: fragmentation, checksum corner cases, and ICMP error inner
>> > headers (as explained by Beniamino).
>> >
>> > So TC clsact looks like the natural in-kernel replacement for today's
>> > TC-BPF CLAT programs: no extra netdev, you attach to the existing
>> > uplink, direction is explicit, and on egress you sit on the real route
>> > dst, so the synthetic-dst and double-routing problems above just don't
>> > arise. The cost is more moving parts than a single bpf_redirect since
>> > userspace has to manage clsact, filters, priorities and action
>> > lifecycle/cleanup.
>>
>> Hmm, so no one really uses the bpf filter mechanism, since you can just
>> do everything from an action anyway (and with TCX attachment, you can
>> even avoid the overhead of the TC filter/action infrastructure
>> entirely). However, point taken wrt how to integrate this with BPF. I
>> guess the most flexible thing would be to expose the functionality
>> directly (as a kfunc callable from a BPF program). Which also fits with
>> your point below:
>>
>
> Ah, I see, the cls_bpf example was dated, and I like the kfunc angle
> better than a new TC action.
>
> I would probably keep that as the minimal per-packet interface: BPF can
> decide whether a packet should be translated, and the kfunc can do the
> actual translation work for packets whose translated form still fits the
> output MTU. The full 4->6 fragmentation case still looks like
> output-path/harness territory to me, since it is a 1->N fan-out
> operation.

Yeah, that would probably be fine; I would expect that in most cases
you'd want to configure your MTU to avoid fragmentation anyway :)

>> > For a gateway translator, though, I still think a device-bound model is
>> > less natural. There the translation point is more like a forwarding
>> > decision across routes and nexthops, so a route/LWT attachment, or
>> > possibly a netfilter attachment seems easier to reason about. Also, as
>> > you already pointed out while discussing LWT, an admin setting up NAT64
>> > is more likely to reach for an nft rule than for a clsact filter on a
>> > specific device.
>> >
>> > Taking a step back, ipxlat is really a generic translation engine plus=
 a
>> > thin harness around it. So rather than pick one attachment, it might be
>> > worth structuring the engine so different harnesses can drive it.
>> > There's interesting precedent for this shape:
>> >
>> > - ILA, again, is the closest sibling: stateless IPv6 address translati=
on
>> >   with a shared core in ila_common.c, driven both by an LWT frontend in
>> >   ila_lwt.c and by an inline netfilter hook with a netlink-configured
>> >   mapping table in ila_xlat.c.
>> >
>> > - act_ct is the precedent for the TC side specifically: a TC action th=
at
>> >   reuses the netfilter conntrack engine rather than reimplementing it.
>> >
>> > And act_nat is the cautionary counter-example: a standalone TC
>> > reimplementation of stateless NAT that shares no code with nf_nat, and
>> > carries a "would be nice to share code" comment :)
>> >
>> > So I am wondering whether the right direction is to factor the
>> > translation engine cleanly, land it with one harness first, and keep t=
he
>> > other attachment points as follow-up work once the core semantics are
>> > settled.
>> >
>> > Does that direction seem reasonable to you?
>>
>> Yes, reusable functionality that can be called from multiple places
>> sounds like a good fit; let's try to structure it that way!
>>
>
> Great, that's the direction I'll take then.
>
>> As for which hook to start with, well, let's see if we hear back from
>> the netfilter devs, but either netfilter or the routing subsystem (LWT
>> style) would be OK for me I think.
>>
>
> Works for me. The engine factoring is common to all of them, so I'll
> start there. Once it's in shape I can sketch a harness against it to
> sanity-check the interface.

Awesome, sounds good!

-Toke

