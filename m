Return-Path: <netdev+bounces-71576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A09CF85402B
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 00:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04261C2250E
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 23:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D864263108;
	Tue, 13 Feb 2024 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="sK9Chtl7"
X-Original-To: netdev@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D642849C
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867302; cv=none; b=hb5Ve3/1aVcv3H9FrJeIcQJEHW0iJ2AVwc5lNMDoaNnRKuhLfXs6vSQHh5E0GjtZJhsgc3HaEMX0Zp5lDF+vT9R4JtKIl0Qn4YR4uS51tn8zO5h/P+cCXN3OrCZjruQo55kWYaCnqBW4NKAuVwodEiJBfUeFhFQILvJTdCxBDLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867302; c=relaxed/simple;
	bh=junmgqXrmhqsNg+BKyZ0X1U7i9Jpuv3Bkp5wWGcyK0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBLbWMQOZORGK7s1W57rcN4dgZs7YvmCkG/+dbJW05paub+utK+6FSEIyThYHR6ZoQMVtDO1660QyIGBuWJBlbE0pkRS59guu1qp5EFw7ywIxPzmEhHAGcggDJRRRIZS00scDwGa06khZ8m8q0bdsVmRWHIf1kXE9MjiEvEYYxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=sK9Chtl7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202312; t=1707867296;
	bh=3/1iP3HNwb1vm+Hd3oAF3/M+8QwR+TUmgRrX+ZzY2AE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sK9Chtl7iFuSICOEniUcsJmNGMzxn0yXcczGF+m8St3hoclYHXOh1O6i3ECQEWH6/
	 VvAVAHx9dT5Xw0IB6yTeK3qQJ09hIubqCUpCqjqVRbr071j1DsVD1GpXnRugHRIB6W
	 aX1qGlcE4pnlsAEiOJOKJJf4W2EAcQW3eVsr5QABSsXpNyN3SUf9pqDfvq96s3u4F5
	 J7juikRQg3OEIZ/fTYnQ3TokQzu3Ab86kIIXYuNGwN8YJ1J2JYpmwVusihA9ye6DyY
	 mEC23E3h3RsqrDsMYj6EK6HKBYTKkzW712LPPdonFiGZajC0zKce99G1CdGM69i6Es
	 9btJhSZWmOPHQ==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4TZHjr2TNnz4wcr; Wed, 14 Feb 2024 10:34:56 +1100 (AEDT)
Date: Wed, 14 Feb 2024 10:34:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, passt-dev@passt.top,
	sbrivio@redhat.com, lvivier@redhat.com, dgibson@redhat.com,
	jmaloy@redhat.com, netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
Message-ID: <Zcv8mjlWE7F9Of93@zatzit>
References: <20240209221233.3150253-1-jmaloy@redhat.com>
 <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
 <CANn89iJW=nEzVjqxzPht20dUnfqxWGXMO2_EpKUV4JHawBRxfw@mail.gmail.com>
 <eaee3c892545e072095e7b296ddde598f1e966d9.camel@redhat.com>
 <CANn89iL=npDL0S+w-F-iE2kmQ2rnNSA7K9ic9s-4ByLkvHPHYg@mail.gmail.com>
 <20072ba530b34729589a3d527c420a766b49e205.camel@redhat.com>
 <CANn89iL2FvTVYv6ym58=4L-K-kSan6R4PEv488ztyX4HsNquug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lI5RsEVqDHCNRRnC"
Content-Disposition: inline
In-Reply-To: <CANn89iL2FvTVYv6ym58=4L-K-kSan6R4PEv488ztyX4HsNquug@mail.gmail.com>


--lI5RsEVqDHCNRRnC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 04:49:01PM +0100, Eric Dumazet wrote:
> On Tue, Feb 13, 2024 at 4:28=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On Tue, 2024-02-13 at 14:34 +0100, Eric Dumazet wrote:
> > > On Tue, Feb 13, 2024 at 2:02=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> > > >
> > > > On Tue, 2024-02-13 at 13:24 +0100, Eric Dumazet wrote:
> > > > > On Tue, Feb 13, 2024 at 11:49=E2=80=AFAM Paolo Abeni <pabeni@redh=
at.com> wrote:
> > > > >
> > > > > > > @@ -2508,7 +2508,10 @@ static int tcp_recvmsg_locked(struct s=
ock *sk, struct msghdr *msg, size_t len,
> > > > > > >               WRITE_ONCE(*seq, *seq + used);
> > > > > > >               copied +=3D used;
> > > > > > >               len -=3D used;
> > > > > > > -
> > > > > > > +             if (flags & MSG_PEEK)
> > > > > > > +                     sk_peek_offset_fwd(sk, used);
> > > > > > > +             else
> > > > > > > +                     sk_peek_offset_bwd(sk, used);
> > > > >
> > > > > Yet another cache miss in TCP fast path...
> > > > >
> > > > > We need to move sk_peek_off in a better location before we accept=
 this patch.
> > > > >
> > > > > I always thought MSK_PEEK was very inefficient, I am surprised we
> > > > > allow arbitrary loops in recvmsg().
> > > >
> > > > Let me double check I read the above correctly: are you concerned by
> > > > the 'skb_queue_walk(&sk->sk_receive_queue, skb) {' loop that could
> > > > touch a lot of skbs/cachelines before reaching the relevant skb?
> > > >
> > > > The end goal here is allowing an user-space application to read
> > > > incrementally/sequentially the received data while leaving them in
> > > > receive buffer.
> > > >
> > > > I don't see a better option than MSG_PEEK, am I missing something?
> > >
> > >
> > > This sk_peek_offset protocol, needing  sk_peek_offset_bwd() in the non
> > > MSG_PEEK case is very strange IMO.
> > >
> > > Ideally, we should read/write over sk_peek_offset only when MSG_PEEK
> > > is used by the caller.
> > >
> > > That would only touch non fast paths.
> > >
> > > Since the API is mono-threaded anyway, the caller should not rely on
> > > the fact that normal recvmsg() call
> > > would 'consume' sk_peek_offset.
> >
> > Storing in sk_peek_seq the tcp next sequence number to be peeked should
> > avoid changes in the non MSG_PEEK cases.
> >
> > AFAICS that would need a new get_peek_off() sock_op and a bit somewhere
> > (in sk_flags?) to discriminate when sk_peek_seq is actually set. Would
> > that be acceptable?
>=20
> We could have a parallel SO_PEEK_OFFSET option, reusing the same socket f=
ield.
>=20
> The new semantic would be : Supported by TCP (so far), and tcp
> recvmsg() only reads/writes this field when MSG_PEEK is used.
> Applications would have to clear the values themselves.

Those semantics would likely defeat the purpose of using SO_PEEK_OFF
for our use case, since we'd need an additional setsockopt() for every
non-PEEK recv() (which are all MSG_TRUNC in our case).

> BTW I see the man pages say SO_PEEK_OFF is "is currently supported
> only for unix(7) sockets"

Yes, this patch is explicitly aiming to change that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lI5RsEVqDHCNRRnC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmXL/HMACgkQzQJF27ox
2GdsixAAoZ5PJR+8aM96Vzj7TC/TuVc4buPXC0Hx6Q7rEkbNOaWZJHTRziyzbO8x
edfyHa+383wtNI3XkOyExm5HPS5X59Smc0WKvpukm1hv/JsWHhjf3dGuSoO+HKgy
3D6mfuXfCz3rCTpJHqpkEvMk084771XzDE4KfSUdRVu3m3Bhl7HnAlhBS0PssOMr
c2cHxmuzFASfk6lMO5jqRjZkgFN0o5LOL14/EoWLZBN/c2VkIh0Ie1FeyqsZQfa8
GDS5StjkJKsmXWL4Wc0lVQHxorqIPjDDLsT/8IBDn7aYVqTzHKSo63WpklXKzNeh
pcNWU9d7Jz6wcLlPVKAbzDrOcJhhg82oS+RQPGAxu2lH6r+h6rUV5TnOvAZf3mZj
eWJjuJEO6uOpn4grP+4jQ49sDCOWTIPvkBqjGmQP8XjDadIzwerZ1w7+w+k4zSVd
GD7OutqQP2UOpILXEEct6VVICm4GGzUbH8/fnqJlSh38fw/1PJjJiTrOg2SL2OoU
yDZnFYi9xDhy60xd0vq8wSqNDxKwbEgNOF3RVgfF9UaDdOv70PqntOmMjG5UKB40
S/nA2sQohEVgUoqizCW7H3oWtpzIgpeQ428BCNIfda8NwiKnQhGxnpu3j1miOngs
8Hy7Q1zfPoeG68c6bke8PAcHHlZyzhjgSsO17yWD/iQVigLM6qE=
=7qtX
-----END PGP SIGNATURE-----

--lI5RsEVqDHCNRRnC--

