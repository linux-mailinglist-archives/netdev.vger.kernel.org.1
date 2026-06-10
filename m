Return-Path: <netdev+bounces-297396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WXTnLQHDKGrSJAMAu9opvQ
	(envelope-from <netdev+bounces-297396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:50:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA9B66551A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:50:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=o2WvagbG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297396-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297396-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D722B30FCFCF
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6482A30677D;
	Wed, 10 Jun 2026 01:46:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1805423395F;
	Wed, 10 Jun 2026 01:46:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781055976; cv=none; b=pXYtIy6oJPuspwmfQ/3OABfHXCybI/n9T7rN3lX/75poAY4PcCbsGnAobSfOkJwETwlkbeaGfpBa4tnlvFmbHiB5H9saL0lhXTdAHF+1ovfiJ//Sd4JwYmreQ9xYLZn+xirGcgtnkWDDglRjRNNxXtLg5o4WzlGcM7Z9L5slSJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781055976; c=relaxed/simple;
	bh=CbtUvIA9KyazIa6IC6+LgzDRqptmbVyJcuLcvHF8fJY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFKTDGiYHQDfLzfP7GNbmXl2/qLffe5J+QcrvlRZcZyyRmpPxT8Po+c/+5UHC1gRz1F0m/OYVzb7dBkEUWCKGdn/knBwd+OM7dqf0vatXqSFuzSzO/e7bwLCRHa0qWELNQgD4q+Mh5Mz58hvw45RLrv2U4yn5FU6b8LXPDXINi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2WvagbG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE461F00893;
	Wed, 10 Jun 2026 01:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781055973;
	bh=/sCY+d1gfCCjoCvIHTPWq3695luc6bFQV6ow0MGS6/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=o2WvagbGbZyWKnaNMm1ZnekisTI6BWbnNcqLzjoZ57uhehENBawYv1jrD7dMrfdLQ
	 /tIJoaa+yiqC/TTvRIIiHXsUxTLZ6aHNEbMgmOTEvXo62liURvP4n1Ns3AE5ch8I4v
	 aww++v5ibWsFQ/jj6ZjkNWz2XIwdj7jcfRZT+Wl5skHZjK7Np99zrF98M2eHxF1Q36
	 Z8qk73yibgaSigS65/XBzuylMfxlAyhq/C7l9VyVHFfc7kgcALRnLUYbQDW90/qvfl
	 SzL6t7F3FkVv+FzwEoVAbBi7WB256qbRvdxH9+OQC0EO0qsjmuRrH6OkcCMER3b5zN
	 tTOXH1ju5kdXg==
Date: Tue, 9 Jun 2026 18:46:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "moderated list:CAKE
 QDISC" <cake@lists.bufferbloat.net>, "open list:TC subsystem"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net/sched: cake: reject overhead values that
 underflow length
Message-ID: <20260609184612.254a8000@kernel.org>
In-Reply-To: <CAE+C+DYpYjQoSsr3PsQ2pN5hf9+u0CbA=JwJ-2aR9Oz1GDDNrg@mail.gmail.com>
References: <20260609232935.1602659.8545fdb04fbe.cake-overhead-underflow@trailofbits.com>
	<20260609174544.114b82e0@kernel.org>
	<CAE+C+DYpYjQoSsr3PsQ2pN5hf9+u0CbA=JwJ-2aR9Oz1GDDNrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297396-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:toke@toke.dk,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:cake@lists.bufferbloat.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1CA9B66551A

On Tue, 9 Jun 2026 20:55:35 -0400 Samuel Moelius wrote:
> On Tue, Jun 9, 2026 at 8:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Tue,  9 Jun 2026 23:29:36 +0000 Samuel Moelius wrote: =20
> > > CAKE accepts overhead values that can make adjusted packet length
> > > arithmetic underflow.  A negative effective length can wrap through
> > > unsigned arithmetic and become a large value. =20
> >
> > Sorry, why are you posting more patches? You were told to stop
> > yesterday. And you received an email which said:
> >
> > Here are a few ground rules which are frequently broken by newcomers:
> >
> >  - You must wait at least 24 hours before posting a new version to give
> >    reviewers time to respond. This is a hard rule, no matter what your
> >    reason to repost is.
> >
> >  - Each new version of your series should be a fresh / separate thread
> >    Add a https://lore.kernel.org/.. link to the previous version to
> >    the cover letter or changelog, instead of threading the submissions.
> >
> >  - Until you gain experience submit one of two patches at a time,
> >    do not send multiple changes at once until some of your changes
> >    were accepted. This avoids reviewers having to provide the same
> >    feedback on multiple patches.
> >
> >  - Avoid changing the subject of the changes or cover letter unless
> >    necessary, it breaks our patch tracking.
> >
> >  - If you're submitting changes for issues discovered using automated
> >    tools - commit message should explain the discovery and testing
> >    process (for drivers explicitly mention that you don't have access
> >    to the device, it's not a blocker).
> >
> >
> > You broke at least 2 of these already.
> >
> > If you keep ignoring direct maintainer feedback you will be banned. =20
>=20
> I'm sorry for my misunderstanding. When should I resume submitting patche=
s?

Please wait until your outstanding submissions get reviewed, here is
the patch review queue for netdev filtered down to your email:

https://patchwork.kernel.org/project/netdevbpf/list/?submitter=3D222403

Once that's empty you can resume but again please try to go slow.
4 patches under review at a time, start from the most impactful ones.
After you get >20 patches accepted (in networking specifically!) you=20
can open up the faucet a bit and go to 10 outstanding patches.

