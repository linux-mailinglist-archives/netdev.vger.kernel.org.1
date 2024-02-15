Return-Path: <netdev+bounces-71950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3A985597B
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 04:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B061C2335D
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E55B6107;
	Thu, 15 Feb 2024 03:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lehy0A4L"
X-Original-To: netdev@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725B84A08
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707967303; cv=none; b=K/7nff91GaawqTeFCH2iKS+yXuumIfjTBAKVu0AVWJ5PSHWAPyXHg2HlHJTcNJccEUGLWmZMYVTXmVkvVm6b8aFoKDfVcBuXH3LT+LBo3wXuMUL29NTs6BzHx4WJa/ui8XQiZ5ttGMrNlZxHbPXJORY39OJdMTLFXKP05oqtCYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707967303; c=relaxed/simple;
	bh=+0DzEhq+CYO/CIE7VFyrJJ8PaToD1z+7ps1Z8Zsgu6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHlQO1nvCPXsWd6KE48v8UHYB8ktxQasdkz1le+aIPqsloNg8S7yhhy+EYmdjyt3rmo2pRSC0XMJ6jVbPpWedmUCf+8TfQtPfN2Bjj2pjAQKbJm18J3qhtXoh9+R1BH5faJCqkPTk6R7YVBan6HqPK228A0Ez+a+YFGMOQKAPT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=lehy0A4L; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202312; t=1707967298;
	bh=gsHdd/rcV85tibN/5M8pMhwJYE+uz0ezc8HK7f8OLgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lehy0A4LXEkEon7jc8JG1icPCNZjeGT3rnyNYXV+ipdrl6zAPHelO2mQUiKDhDFwY
	 eSiSas7g9JsDaDD/Q9SSo4OCu8AXE6IcGrenq8BodJoFeQAL6TO4BUWVV0ySkRGbyy
	 HNEo72k9Ly5g/pHdjqlYYjxtYDMjiuwp4lP9Bhr2lV8Zp2qIVWwsVoEYE7JsMu9fX2
	 TTdxCS4KGgijB2VuZ2gteeOU+wsY3dtm9EZ4pwnBUx8LDVKwEoqXPS5yaVMPwBy51b
	 95uunyWBaJRQwWWaHNKG6q4vwV5uXZyZI/3aZgeiVN1p7qWvfQNBd34B25xmqF6TMd
	 ErnamKTiNuCGA==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4Tb0hy4KJ3z4wcN; Thu, 15 Feb 2024 14:21:38 +1100 (AEDT)
Date: Thu, 15 Feb 2024 14:21:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, passt-dev@passt.top,
	sbrivio@redhat.com, lvivier@redhat.com, dgibson@redhat.com,
	jmaloy@redhat.com, netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
Message-ID: <Zc2DPq8Sh8f_XoAH@zatzit>
References: <20240209221233.3150253-1-jmaloy@redhat.com>
 <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
 <CANn89iJW=nEzVjqxzPht20dUnfqxWGXMO2_EpKUV4JHawBRxfw@mail.gmail.com>
 <eaee3c892545e072095e7b296ddde598f1e966d9.camel@redhat.com>
 <CANn89iL=npDL0S+w-F-iE2kmQ2rnNSA7K9ic9s-4ByLkvHPHYg@mail.gmail.com>
 <20072ba530b34729589a3d527c420a766b49e205.camel@redhat.com>
 <CANn89iL2FvTVYv6ym58=4L-K-kSan6R4PEv488ztyX4HsNquug@mail.gmail.com>
 <Zcv8mjlWE7F9Of93@zatzit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iyh3BKSr+QL7iMHm"
Content-Disposition: inline
In-Reply-To: <Zcv8mjlWE7F9Of93@zatzit>


--iyh3BKSr+QL7iMHm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 10:34:50AM +1100, David Gibson wrote:
> On Tue, Feb 13, 2024 at 04:49:01PM +0100, Eric Dumazet wrote:
> > On Tue, Feb 13, 2024 at 4:28=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On Tue, 2024-02-13 at 14:34 +0100, Eric Dumazet wrote:
> > > > On Tue, Feb 13, 2024 at 2:02=E2=80=AFPM Paolo Abeni <pabeni@redhat.=
com> wrote:
> > > > >
> > > > > On Tue, 2024-02-13 at 13:24 +0100, Eric Dumazet wrote:
> > > > > > On Tue, Feb 13, 2024 at 11:49=E2=80=AFAM Paolo Abeni <pabeni@re=
dhat.com> wrote:
> > > > > >
> > > > > > > > @@ -2508,7 +2508,10 @@ static int tcp_recvmsg_locked(struct=
 sock *sk, struct msghdr *msg, size_t len,
> > > > > > > >               WRITE_ONCE(*seq, *seq + used);
> > > > > > > >               copied +=3D used;
> > > > > > > >               len -=3D used;
> > > > > > > > -
> > > > > > > > +             if (flags & MSG_PEEK)
> > > > > > > > +                     sk_peek_offset_fwd(sk, used);
> > > > > > > > +             else
> > > > > > > > +                     sk_peek_offset_bwd(sk, used);
> > > > > >
> > > > > > Yet another cache miss in TCP fast path...
> > > > > >
> > > > > > We need to move sk_peek_off in a better location before we acce=
pt this patch.
> > > > > >
> > > > > > I always thought MSK_PEEK was very inefficient, I am surprised =
we
> > > > > > allow arbitrary loops in recvmsg().
> > > > >
> > > > > Let me double check I read the above correctly: are you concerned=
 by
> > > > > the 'skb_queue_walk(&sk->sk_receive_queue, skb) {' loop that could
> > > > > touch a lot of skbs/cachelines before reaching the relevant skb?
> > > > >
> > > > > The end goal here is allowing an user-space application to read
> > > > > incrementally/sequentially the received data while leaving them in
> > > > > receive buffer.
> > > > >
> > > > > I don't see a better option than MSG_PEEK, am I missing something?
> > > >
> > > >
> > > > This sk_peek_offset protocol, needing  sk_peek_offset_bwd() in the =
non
> > > > MSG_PEEK case is very strange IMO.
> > > >
> > > > Ideally, we should read/write over sk_peek_offset only when MSG_PEEK
> > > > is used by the caller.
> > > >
> > > > That would only touch non fast paths.
> > > >
> > > > Since the API is mono-threaded anyway, the caller should not rely on
> > > > the fact that normal recvmsg() call
> > > > would 'consume' sk_peek_offset.
> > >
> > > Storing in sk_peek_seq the tcp next sequence number to be peeked shou=
ld
> > > avoid changes in the non MSG_PEEK cases.
> > >
> > > AFAICS that would need a new get_peek_off() sock_op and a bit somewhe=
re
> > > (in sk_flags?) to discriminate when sk_peek_seq is actually set. Would
> > > that be acceptable?
> >=20
> > We could have a parallel SO_PEEK_OFFSET option, reusing the same socket=
 field.
> >=20
> > The new semantic would be : Supported by TCP (so far), and tcp
> > recvmsg() only reads/writes this field when MSG_PEEK is used.
> > Applications would have to clear the values themselves.
>=20
> Those semantics would likely defeat the purpose of using SO_PEEK_OFF
> for our use case, since we'd need an additional setsockopt() for every
> non-PEEK recv() (which are all MSG_TRUNC in our case).

Btw, Eric,

If you're concerned about the extra access added to the "regular" TCP
path, would you be happier with the original approach Jon proposed:
that allowed a user to essentially supply an offset to an individial
MSG_PEEK recvmsg() by inserting a dummy entry as msg_iov[0] with a
NULL pointer and length to skip.

It did the job for us, although I admit it's a little ugly, which I
presume is why Paolo suggested we investigate SO_PEEK_OFF instead.  I
think the SO_PEEK_OFF approach is more elegant, but maybe the
performance impact outweighs that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iyh3BKSr+QL7iMHm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmXNgz0ACgkQzQJF27ox
2Ge9HxAAin8tsw9AkMt3hy/JhIPU4kQASeafgOA7dXeRnG9VnGg6xjFS+Ym92OJb
rO6sa2hpvxY1zM4mGRfdhqvw7WJUbkXLO6yhGPi1DSipN/7k1N1UWcN6c/R8b+4c
z6u3R2kXZqkmCn9HGibGK1Gk2L3WkkLnKa4JwgRj9mygzsoRMOsrIBRnzWFPEEM6
HjcLzQd1k/puZ7XKHrzOPRJS3Hy2pVnPY2trSeUrH7w0lP1niWEaNOlmDDw84Ts5
BrqStIC1dBBt38zBzkeGnivUgAd4Unlyf68fBZh2pMBmRmi3bDBRZaWKYmCEgW/o
nZTd6xgxp3omM45wKH0Tfrxq54O0w0wSsz7tRY9dGCo8spcQYuqegCl8HjscC4xj
g1NRK/iY5BrBgHGfiiBS2AZXFDyqFg4YU0d27rSNA1Rdc0Ftnw2asImS9OBH8rcQ
9c8LEhd295YfgQWG6i1/8/TGq0xdDw7DmY5Pe8FUSjRduv9P3O6n2lrGWZvJycig
ABbzPJeNkBaFp0iHuhBp2CkcHgMahk12goz84M/zx6eY/cg5sexr4JjdQokUNgFv
bpsI/FyPgMypjYGWCF3AtkOwtu/5iSu08kBD/EzdJRF55fDpn41dkAaYnP/18TrT
uct3QQwc6+1CQeVI3UfQINmWhYHr7OfE751rukIyLNL+pyHXvSY=
=RbtH
-----END PGP SIGNATURE-----

--iyh3BKSr+QL7iMHm--

