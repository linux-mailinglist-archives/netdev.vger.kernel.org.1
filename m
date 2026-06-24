Return-Path: <netdev+bounces-301713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RVNQCjsFPGrOiggAu9opvQ
	(envelope-from <netdev+bounces-301713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:26:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC496BFF5D
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:26:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mandelbit.com header.s=MBO0001 header.b=SG4LA9ij;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301713-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301713-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81BE4301CC49
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999C22BDC2A;
	Wed, 24 Jun 2026 16:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADDF1C84A6;
	Wed, 24 Jun 2026 16:26:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782318390; cv=none; b=tznEoFEofqH1TmESMB//ytq+ccdKePb8UZDL5swvM25yVjQh8xp3IIuQqcu9v3G0XRv94JbLBkX0y1xCYxE2HF3XPUDH8aRp0sPsylPLNCu5Le07zeMhyFqo5/wEs67m+kO8MeGnQ9Dv9voVZ3osjj6kDGCF+kS8Oh1pr6mXdvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782318390; c=relaxed/simple;
	bh=dqheWV0MoBE8GFdeH5pTuxFjJ46lZ7tAJI2rPyDPQ1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+gio+VUMH1xy36S0JX2A7Tw6IegcNUCXYt2LeAnrwh6+hnc9ODYsL3S/eMEbZ8jThOc3XH0TORVFZfXRm+H9WHwv+o7EqfeofTpOT1DXGer32nKdyhFR4iHOl4CWXIeGcjHbmPCuoJZTc7KzV3DEUujgrW9JYTrgOloQOuy5Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=SG4LA9ij; arc=none smtp.client-ip=195.10.208.40
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4glnFB0stVzMm3v;
	Wed, 24 Jun 2026 18:19:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1782317950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/WLT1yFW6o+7ddGyEm3OpCyzzUL7JiZATagfJStkU4=;
	b=SG4LA9ij845HuzjRwxoIBCYwje70OKH3X50VitM6aC0Gte3nWwQCsTltezpxxP1Zk5IVsM
	uBosnlUJ324e/7+SLIYEUf5A0RinQM6rpi5eYnYW4fGQDPloMDqW9RhsJ4r0QTYMPndGaH
	czZI+NMVWhO2yrKavOyLnrnYohkA6lbgvsym/TnldIIA1NZWfFiSwGVKydUDQaHu6HXSA8
	WmdTwcuKibIb5J5cmtwhd/D3ebL0i602An8LgJ+KqEgcfkKUNFy0It/SeVz0bfSaxulhYK
	FEAehBqlEQAenOhMqioTV+qAoD95xm9u7Z1OAnhFjY7DsxdyLgjx+HhsDmDSGA==
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
Date: Wed, 24 Jun 2026 18:18:52 +0200
Message-ID: <20260624161854.686569-1-ralf@mandelbit.com>
In-Reply-To: <87v7b9c9jj.fsf@toke.dk>
References: <87v7b9c9jj.fsf@toke.dk>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[mandelbit.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:toke@kernel.org,m:netdev@vger.kernel.org,m:dxld@darkboxed.org,m:antonio@mandelbit.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:bgalvani@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301713-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mandelbit.com];
	FORGED_SENDER(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CC496BFF5D

On Tue, 23 Jun 2026 21:59:44 +0200, Toke Høiland-Jørgensen <toke@kernel.org> wrote:
> Ralf Lici <ralf@mandelbit.com> writes:
> > On the BPF point specifically: I agree a BPF program should be able to
> > decide whether to translate. What I am less sure about is whether
> > redirecting to a netdevice is the best way to expose that. A TC action
> > (yet another model, I know :)) gives you the same thing in-pipeline and
> > more directly:
> >
> >     tc filter add dev wwan0 egress \
> >         bpf obj match.o action ipxlat4to6 domain clat0
> >
> > Let BPF make the policy decision, with the native action doing the
> > translation work that the current BPF CLAT implementations have trouble
> > with: fragmentation, checksum corner cases, and ICMP error inner
> > headers (as explained by Beniamino).
> >
> > So TC clsact looks like the natural in-kernel replacement for today's
> > TC-BPF CLAT programs: no extra netdev, you attach to the existing
> > uplink, direction is explicit, and on egress you sit on the real route
> > dst, so the synthetic-dst and double-routing problems above just don't
> > arise. The cost is more moving parts than a single bpf_redirect since
> > userspace has to manage clsact, filters, priorities and action
> > lifecycle/cleanup.
>
> Hmm, so no one really uses the bpf filter mechanism, since you can just
> do everything from an action anyway (and with TCX attachment, you can
> even avoid the overhead of the TC filter/action infrastructure
> entirely). However, point taken wrt how to integrate this with BPF. I
> guess the most flexible thing would be to expose the functionality
> directly (as a kfunc callable from a BPF program). Which also fits with
> your point below:
>

Ah, I see, the cls_bpf example was dated, and I like the kfunc angle
better than a new TC action.

I would probably keep that as the minimal per-packet interface: BPF can
decide whether a packet should be translated, and the kfunc can do the
actual translation work for packets whose translated form still fits the
output MTU. The full 4->6 fragmentation case still looks like
output-path/harness territory to me, since it is a 1->N fan-out
operation.

> > For a gateway translator, though, I still think a device-bound model is
> > less natural. There the translation point is more like a forwarding
> > decision across routes and nexthops, so a route/LWT attachment, or
> > possibly a netfilter attachment seems easier to reason about. Also, as
> > you already pointed out while discussing LWT, an admin setting up NAT64
> > is more likely to reach for an nft rule than for a clsact filter on a
> > specific device.
> >
> > Taking a step back, ipxlat is really a generic translation engine plus a
> > thin harness around it. So rather than pick one attachment, it might be
> > worth structuring the engine so different harnesses can drive it.
> > There's interesting precedent for this shape:
> >
> > - ILA, again, is the closest sibling: stateless IPv6 address translation
> >   with a shared core in ila_common.c, driven both by an LWT frontend in
> >   ila_lwt.c and by an inline netfilter hook with a netlink-configured
> >   mapping table in ila_xlat.c.
> >
> > - act_ct is the precedent for the TC side specifically: a TC action that
> >   reuses the netfilter conntrack engine rather than reimplementing it.
> >
> > And act_nat is the cautionary counter-example: a standalone TC
> > reimplementation of stateless NAT that shares no code with nf_nat, and
> > carries a "would be nice to share code" comment :)
> >
> > So I am wondering whether the right direction is to factor the
> > translation engine cleanly, land it with one harness first, and keep the
> > other attachment points as follow-up work once the core semantics are
> > settled.
> >
> > Does that direction seem reasonable to you?
>
> Yes, reusable functionality that can be called from multiple places
> sounds like a good fit; let's try to structure it that way!
>

Great, that's the direction I'll take then.

> As for which hook to start with, well, let's see if we hear back from
> the netfilter devs, but either netfilter or the routing subsystem (LWT
> style) would be OK for me I think.
>

Works for me. The engine factoring is common to all of them, so I'll
start there. Once it's in shape I can sketch a harness against it to
sanity-check the interface.

-- 
Ralf Lici
Mandelbit Srl

