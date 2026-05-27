Return-Path: <netdev+bounces-292467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJPUFVVwF2pDFAgAu9opvQ
	(envelope-from <netdev+bounces-292467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:29:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DE55EAACD
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7EC030300F7
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 22:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7113C1F37;
	Wed, 27 May 2026 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVFGuG90"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA638BF68;
	Wed, 27 May 2026 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920979; cv=none; b=uPnMYHA/e00K5Dxdef/OIKLNhZXHOEu7hHs8eoS49VPSLdotoaY3OWF9pfvq9O8FmMBOZZncHnla/DUEuSSxVwvNpQ+Q3jl7IzoSj2KujQoRcCdi/rW7ywnXa92eh8pL4Emzv+BJ8jGQ+jiGe/0UILGavxngorVa7h0Qq/HFG7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920979; c=relaxed/simple;
	bh=BRL2elMfUucHebDZHFmsVpPTWvJChLWgzYXPWcjwaYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZXChSU55EitOR/+/WQinEPXesF7F2FyvtMNV6wE1zGzvLTWzKvi/XCvwUJaUNWbtBPUs9gG440cr35c4gPT5GS5h+Zq91T0KE9QHkAr4NXTo7mUKL7sy6lTiqQ2L+EEHvflVhC7lOf2ogvuohLAKK68dU73oN33pK9v6RkGIIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVFGuG90; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310B81F000E9;
	Wed, 27 May 2026 22:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779920977;
	bh=S5tbmrw6C0evQ3n7pf6RVf1GBq2rMc+wfNdESSOmjkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hVFGuG90Yvsxwds12VGSiMzbv9O0PFczEtg0RVAzOTuMUU3c4JLyLTGn8/vBkuFWU
	 0b5pqvvnkD3xD8OH+n6BURDlI1M1hVJr2H2VRGWn2VmpE1s/p3nIhRkfDTSK6ic1ox
	 pVQOTYhKZfi0e9Uxjj7xmS6gzHYUKccR5TlHzetyolnl0F+2FsWkA6ojmryw5SqYp1
	 +BYoWQ7et9Z02TiUHGrl0t7FRZvC7GV5hSDzao9mwDiXiIkisDgNGtX4CvYb4lsW1M
	 Z9Tgmq6VxKzmvVwIeZuwaSy2qm0gn40kpbQv3LxnVgLTSPwrCwocsEBLVius6WrEUQ
	 I0KN0F+Jp08sA==
Date: Wed, 27 May 2026 15:29:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, paul@paul-moore.com, eparis@redhat.com,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, Steve Grubb
 <sgrubb@redhat.com>
Subject: Re: [PATCH v2] netlink, audit: prevent false ENOBUFS on timeout
 expiry
Message-ID: <20260527152936.001d5d28@kernel.org>
In-Reply-To: <CAABTaaC98dqM8U-7xkdW=b=50UKu0SQyBO629LDdphQ9DC=P=g@mail.gmail.com>
References: <20260513172443.1128496-1-rrobaina@redhat.com>
	<20260518173507.2f2529c9@kernel.org>
	<CAABTaaC98dqM8U-7xkdW=b=50UKu0SQyBO629LDdphQ9DC=P=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-292467-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E3DE55EAACD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 16:29:37 -0300 Ricardo Robaina wrote:
> On Mon, May 18, 2026 at 9:35=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Wed, 13 May 2026 14:24:43 -0300 Ricardo Robaina wrote: =20
> > > When auditd is bottlenecked (e.g., by slow disk I/O), kauditd blocks =
on
> > > the netlink socket. =20
> >
> > Holding socket lock during slow IO sounds very wrong. One could say -
> > that's abuse of the socket lock?
> > =20
> > > If the wait timeout fully expires (timeo =3D=3D 0),
> > > netlink mistakenly interprets the zeroed timeout as a non-blocking
> > > request. It then triggers netlink_overrun that drops the event,
> > > completely bypassing the audit subsystem's internal retry queue, and
> > > falsely returns ENOBUFS to user-space, resulting in the following err=
or:
> > >
> > >  auditd[]: Error receiving audit netlink packet (No buffer space avai=
lable)
> > >
> > > Fix this by detecting when a blocking sender's timeout has expired
> > > (timeo =3D=3D 0 && !nonblock) in netlink_unicast(). In this case, ins=
tead
> > > of retrying with timeo=3D0 (which would incorrectly trigger netlink_o=
verrun
> > > on the next iteration), safely free the skb and return -EAGAIN, allow=
ing
> > > the audit subsystem to gracefully enqueue the pending event into its
> > > internal backlog. =20
> >
> > The socket _is_ the queue, normally.
> >
> > Please explore fixing this in audit?
> > --
> > pw-bot: cr
> > =20
>=20
> Hi Jakub,
>=20
> Thanks for reviewing this patch as well.
>=20
> First, regarding the lock: kauditd does not hold the socket lock during
> slow I/O. The sleep in netlink_attachskb() uses schedule_timeout() on
> nlk->wait (a wait queue). No socket lock or mutex is held during the slee=
p.

So you're saying the queue _is_ actually congested?
netlink_attachskb() sleeps because there's no space left in the socket's=20
rcvbuf? So the skbs are moved to audit_retry_queue "temporarily" until
user space drains its socket and kernel can succeed sending?

Could you confirm this understanding is correct?

> Second, regarding an audit-only fix: the symptom manifests as sk->sk_err =
=3D
> ENOBUFS set inside netlink_overrun() (called from netlink_attachskb when
> timeo =3D=3D 0). Audit has no mechanism to prevent or clear this socket s=
tate
> from the outside. Potential workarounds all fail:
>=20
> (1) Clearing sk_err after the fact is racy and affects other socket ops

Why would you clear the sk_err, it's the reader's responsibility to
clear the congestion and the reader is AFAIU a user space process.

> (2) Avoiding timeouts entirely defeats the anti-deadlock mechanism

What's the anti-deadlock mechanism?

> (3) A new NETLINK_F_RECV_NO_ENOBUFS socket flag doesn't exist in stable
> kernels where this bug is actively impacting users

Which commit are you referring to? Isn't that flag itself ancient?

> I've submitted v3 [1] with NETLINK_UNICAST_TIMED as an explicit opt-in
> constant.=20

It's really not great to fall silent for 10+ days, then respond and
immediately posts equally pointless next version of the patch :/

