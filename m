Return-Path: <netdev+bounces-301706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5Y1NJAT9O2qYhggAu9opvQ
	(envelope-from <netdev+bounces-301706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:51:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D83FA6BFCAD
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:51:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mandelbit.com header.s=MBO0001 header.b=Zp3173wh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301706-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301706-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AB143013A84
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E713CC7EA;
	Wed, 24 Jun 2026 15:50:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF0730C62D;
	Wed, 24 Jun 2026 15:50:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316257; cv=none; b=sXzooKNDTsxxMQteJqiudWPc2sFjnIhRHEM8GtQY3trILHjOY4hYfuIxGiCpvYIfxdsnjgV/ksAp+gn03Qz/RIIixLP21ynxKdKohpNZFTFrNONTtjQpp1QtimkemoZNAkxqZwaRmmmDab25ZRnLteAhMC1HTwZT1jI1FuTSUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316257; c=relaxed/simple;
	bh=eVFC3aAUTYWOS7jwxST034tkdLT5yHiylnmC5r3iB7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNifjVik9ma0RwzCGO5fDuzO6JH+ipp2opJlSs45iJMgWT4Ux4IwHqA1zKcBE+zps2Bsb/mS/cefgLBkfviJppd0d0naAieJY/CgOUdeddHSGqwaDMdxCwbPaJUuqhv4StUlZRqBJnHl1kakXkEu0RCuM+AJVyOqW3PVQCIMgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=Zp3173wh; arc=none smtp.client-ip=195.10.208.51
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4glmRw3LxCz9y30;
	Wed, 24 Jun 2026 17:43:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1782315804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGYET4ZRL4nyd5bBfdArZm2W2mNGdcOA4HZCe8MRkhE=;
	b=Zp3173whzYyQq9Qh1Q81Y0rnUl1GON3UMmuBMlsykwjHlcaDmQU+tsVL8f3drhDhCXC7e1
	/nnF3J9ZSy471l0NvsRBbIUK8r1jEBg7Xkt0AHP+oTaPiKwArkZOg24zT9nCxr8ZKYwgjz
	oA6vWwOLkahNaE4YaKBvkmc4ku2lH24G/a2z5b/L3coS9rb/gP1+JbfC8xDi3JEfbveg/f
	cNCwOjqPf+AP8Ywle8RUPUOLc5Iqk1Wr2U2aEsiSnIatA+Ac91zZXriLnLshsCsrSIz/lf
	71w8zkCz2Qh8qZVCIDuqG6yfY1+hfDII1zQ3Llm6MN8lhyvhmtyaKzXaIym9EA==
From: Ralf Lici <ralf@mandelbit.com>
To: Beniamino Galvani <bgalvani@redhat.com>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	netdev@vger.kernel.org,
	=?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 08/15] ipxlat: add translation engine and dispatch core
Date: Wed, 24 Jun 2026 17:43:10 +0200
Message-ID: <20260624154311.643380-1-ralf@mandelbit.com>
In-Reply-To: <ajo-MgpZ8jA8YDwi@tp>
References: <ajo-MgpZ8jA8YDwi@tp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mandelbit.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301706-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bgalvani@redhat.com,m:toke@kernel.org,m:netdev@vger.kernel.org,m:dxld@darkboxed.org,m:antonio@mandelbit.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mandelbit.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ietf.org:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D83FA6BFCAD

On Tue, 23 Jun 2026 10:05:06 +0200, Beniamino Galvani <bgalvani@redhat.com> wrote:
> On Mon, Jun 22, 2026 at 05:56:11PM +0200, Ralf Lici wrote:
> > While reading the BPF programs, two things stood out that would help
> > shape v2. On addressing, both implementations use a single NAT64/PLAT
> > prefix for destinations plus an explicit local_v4<>local_v6 mapping for
> > the host itself. ipxlat today maps both source and destination through
> > one RFC 6052 prefix, so this suggests v2 should probably support
> > explicit 1:1 address mappings (EAM, RFC 7757) alongside prefix
> > embedding. Is a single local mapping enough for your case, or do you
> > foresee needing several?
>
> Based on these:
>
>   https://datatracker.ietf.org/doc/html/rfc6877#section-6.3
>   https://www.ietf.org/archive/id/draft-ietf-v6ops-claton-14.html#name-obtaining-clat-ipv6-address
>
> there are two cases to consider for CLAT.
>
> If the node doing CLAT extends the IPv4 connectivity downstream, it
> should acquire a dedicated prefix via DHCPv6-PD for the downstream
> network, and use this prefix to generate IPv4-Embedded IPv6 Addresses
> (RFC 6052 2.2) for downlink hosts. In this case, the ipxlat device
> would need to be configured with two prefixes: one is the NAT64 prefix
> used to synthesize IPv6 destinations for IPv4 Internet addresses, and
> the other is the delegated prefix used to synthesize IPv6 source
> addresses for hosts on the downstream IPv4 network. Ideally, the
> ipxlat device should also be aware of the address range of the
> downstream IPv4 network, and check that the source addresses of
> packets belong to that network.
>
> If the node doing CLAT does not extend IPv4 connectivity downstream
> (or it does, but it also uses NAT44), the "downstream network" is
> basically just one host. The CLAT only needs to map a single
> locally-generated IPv4 address (usually in the 192.0.0.0/29 range) to
> a single SLAAC IPv6 address reserved for the CLAT. In this case, the
> ipxlat device would need to know the CLAT IPv4 address, the CLAT IPv6
> address and the NAT64 prefix.
>
> Currently, NetworkManager only uses a single IPv4 address and doesn't
> request a dedicated prefix via DHCPv6-PD for the CLAT. If it needs to
> provide downstream connectivity, it does IPv4 masquerading so that the
> traffic originates from a single IPv4 address. I think the ipxlat
> implementation should also support the delegated-prefix case, as this
> architecture is described in the standards.
>

I see. Your CLAT breakdown makes it clear that the single-prefix model
in this RFC is too narrow for v2. What I am currently thinking is to
shape the config as a far-side prefix plus an optional near-side map.
The 2 CLAT cases then can be represented roughly as:

    remote-prefix6 64:ff9b::/96
    local-map      192.0.0.1/32 2001:db8:1:2::1234/128

for the single-host CLAT case (which is an explicit 1:1 mapping), and:

    remote-prefix6 64:ff9b::/96
    local-map      192.0.2.0/24 2001:db8:100:64::/96

for the downstream/delegated-prefix case.

The idea is that remote-prefix6 is the RFC 6052 prefix used for the
NAT64/PLAT side, while local-map optionally describes the near-side
mapping. If local-map is omitted, the translator falls back to the
symmetric v1 behavior where the same RFC 6052 prefix is used for both
source and destination.

On the source-range check you mentioned: it falls out of the near-side
map for free. In the 4->6 direction the source is resolved through
local-map only, so a source outside its IPv4 domain (the /32 or the /24
above) simply has no near-side mapping and is dropped, so no separate
anti-spoofing knob should be needed. Anything broader than "is this a
valid near-side source" I'd leave to routing/nft rather than bake into
the translator.

Names and exact attribute shape are still WIP, but does this capture the
two CLAT cases you had in mind?

> > On the consumer side, is there anything in how NM models a connection
> > that would make a particular kernel model awkward to drive, e.g. needing
> > to attach to an already-managed interface, or conversely being able to
> > create and own a dedicated device? We're still settling the
> > kernel-facing model for v2, so consumer input here is genuinely
> > valuable.
>
> Any of the solutions mentioned in the thread (dedicated device,
> netfilter, LWT) would be fine from NetworkManager's point of
> view. Compared to what we are doing now, they would be a great
> simplification ;)
>

Nice, thanks for confirming!

-- 
Ralf Lici
Mandelbit Srl

