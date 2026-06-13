Return-Path: <netdev+bounces-299080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y4nLBR3eLWoplwQAu9opvQ
	(envelope-from <netdev+bounces-299080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:47:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5875B67FF55
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:47:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="M7zpgD+/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299080-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299080-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 047A33019077
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16365376A14;
	Sat, 13 Jun 2026 22:47:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8252032D;
	Sat, 13 Jun 2026 22:47:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781390874; cv=none; b=AAqZ79UF672hkLkFqH5JCkhdioLgVR/IkiWXB+JFJziE6jPD3mIkKpX5zhAWJgAXQA/a1dGhXWZsCiNYIrgoqLucAhXE6eKjXxkIUu9FixiHIvpwWHUIRWXAMxD/+AQ4pmto9UjZpjsuyzTQq6XM4Wyzy2kM9wi5htbifUfhjxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781390874; c=relaxed/simple;
	bh=+jkWcWAyt1Gmd921batUW8VyPvIYZBTgCqPv0MLSDOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lr5at+Ny+PrWcpg43vMyTjhEFW7pY+sqevIAMEFswLhsfa5Hbd10LkeDAyX0VeV6X3kHtfYBI6iuJgX+Ane85+466QG0sJZuBZGxMd+n7bPlX0qMbgKMj+/7fj8eqk0zDcjrXjbZaUH7TXffrkQMYthxcbIWyOENDl1I8ISapeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7zpgD+/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677FF1F000E9;
	Sat, 13 Jun 2026 22:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781390872;
	bh=/VshbjM8bBu/lS5huDW4edOlGHJQX64Vdzk3casHMn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M7zpgD+/JjCsTRa2fubb3P4y2mGOaynWJi//uhYazy4YIVhkRQHhEo39Y542n8ca0
	 w9rWmc4cwyKWFBOaEAZj8PrGXmWwsoyRIE8KFbBRsCq2m4WnePTm9Qka8mmEHvo8cT
	 ty8MeqyukiM7tV/PQCfRr49qgnZaRlq2pCdHghOGBxTwvF4iHND/30zOyBvau/B6c6
	 RRxUMbHMFRKdHEKELaihW9XzaeofRO2V5JS4Jmd3a6TfDu+rfngoU4sxi3NxTJM4Cd
	 tMJ8cKFLsZjeZSuVyITBOQDCd7Fv0uSHd8WrTupjSS20T+VThmdg77tkb0xLerF8Uj
	 glKk9yzm3dyqQ==
Date: Sat, 13 Jun 2026 15:47:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Stanislav
 Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de Bruijn
 <willemb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next/net 0/5] bpf: Support RX/TX HW timestamp
 proxy.
Message-ID: <20260613154750.0a2355a4@kernel.org>
In-Reply-To: <CAAVpQUBP_21b5MB8MS-wFwg9BUdcgMoNxi8s479YQHH9g5ahCw@mail.gmail.com>
References: <20260613010039.1362312-1-kuniyu@google.com>
	<20260613102041.55e3b50e@kernel.org>
	<CAAVpQUBP_21b5MB8MS-wFwg9BUdcgMoNxi8s479YQHH9g5ahCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299080-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:memxor@gmail.com,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:kuni1840@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5875B67FF55

On Sat, 13 Jun 2026 14:43:46 -0700 Kuniyuki Iwashima wrote:
> On Sat, Jun 13, 2026 at 10:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > On Sat, 13 Jun 2026 00:59:57 +0000 Kuniyuki Iwashima wrote: =20
> > > When standard socket applications are run on these hosts,
> > > a userspace proxy is required to mediate traffic between the
> > > hardware and the applications.
> > >
> > >             +---------+                 +----------------------+
> > >             |  proxy  |                 |  socket application  |
> > >             +---------+                 +----------------------+
> > >               ^     ^                               ^
> > >   userspace   |     |                               |
> > >   -----------| |-----------------------------------------------
> > >              | |    |    +---------------------+    | skb
> > >              | |    `--->|  virtual interface  |<---'
> > >   kernel     | |   skb   +---------------------+
> > >   -----------| |-----------------------------------------------
> > >               |
> > >               v
> > >        +------------+
> > >        |  hardware  |
> > >        +------------+ =20
> >
> > The first patch looks kinda nonsensical but then I saw this diagram.
> > Looks like you're vibe coding an integration that makes it easier to
> > treat netdev as a slow path for a user networking stack.
> > Please tell me if I'm missing anything otherwise add my nack if you
> > repost. =20
>=20
> Hmm, what would be a better way to tell users that HW TS is
> available on tunnel devices ?
>=20
> Other options were 1) add attribute to tie the tunnel to a physical
> device and use its ndo_hwtstamp_set/get, or 2) add bpf retval
> hook in the path like update_socket_protocol().

Can you explain the use case for HW timestamps on tunnels?
I see you have some diagrams in patches 3 and 4 but the motivation
isn't really explained, and we have 250 patches in the queue still.
Not much time to play detective right now :/

> Or do you think applications should handle ENOTSUP by ioctl
> as soft error and always set SOF_TIMESTAMPING_XXX_HARDWARE
> since the underlying physical device may support it ?

And explain the deployment model and API semantics you have in mind.

> Anyway, I'm happy to drop patch 1 for now and explore options.

Not patch 1, all of it. I get the feeling y'all are sitting on a pile
of Swift related code that needs to be made upstreamable. Odd series
like this make me think it's never going to happen.

> (Believe it or not, I haven't let AI write code because I don't
>  want AI to take over the most fun part.)

