Return-Path: <netdev+bounces-150021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DE29E8927
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 03:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D5628302F
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 02:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534E617741;
	Mon,  9 Dec 2024 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="B8r37hoZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045F9B66E
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733710833; cv=none; b=drzNyy7+lelrcmgLqdBNOP4G5HWMHQ2hOMTYocPNdbrm2hrExtNbM6eWow08AyXN3hLgZC/PR0SpZQcZWeMcllIQndPZaU5mywcUw4PGbuCrj/rlmf5BJRmZQfZp2D9/9wNeYo10I7aDYVD2oHiqPqU9uiNtcL++LXWSjY9e7wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733710833; c=relaxed/simple;
	bh=ab5tQMeE5JGalpqbVUwNFQC3sASHXoQDxbnZx3PceTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPzro7JA70RlATOexmVZxvB4CJTKr1D1nv/OVPH2/OY0xpSmiMpCFysDrIiUhh9Y6hvkvebbNuCIxorHvMVpyZoGPmjaxlzcFjziDroAxCCzmlQeYzZFgvRhNtBrIGM+ka1AeSRkNq+UZxwqPmWtq7SK7dTs3p0MOEUlqqbOQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=B8r37hoZ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202412; t=1733710820;
	bh=r24AQkVP2WD7kYtnInbRp5c88nw+YFsVknxvi5YGyk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B8r37hoZKbap4d7hdxxI2iJ2AG8wN0b8Y1yL1MOeFmvCi3D7ifC16OwUumZXU7dti
	 IHuqEQMfkf1UzYMW03kb5/Pm63vLbU8SzAppaYEV6YLqszOS1odNPaG1aZ94h2GnqU
	 5YZ8ThalOE0nsOYRsjKVtwuMeNZPNvF4b5KHJvUOJSfhCDoOkvbZz69rWtGuJQaLiy
	 tounFIoobm0CysLSXN1vsQsZpH8FBYwlvPD+Md5iQ7DBBoV6wj21ehSbvOx6xKkeAd
	 qmzwH9yRwG7qyMBLuvcqaeWpvchuFE+BJcwh+n9BeLl79zH/R7tX8Ub4ivyGf95UE9
	 d1HtVlhAIFJLw==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4Y65Dh5L9Gz4wcj; Mon,  9 Dec 2024 13:20:20 +1100 (AEDT)
Date: Mon, 9 Dec 2024 13:20:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Eric Dumazet <edumazet@google.com>
Cc: Stefano Brivio <sbrivio@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Mike Manning <mvrmanning@gmail.com>,
	Paul Holzinger <pholzing@redhat.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Cambda Zhu <cambda@linux.alibaba.com>,
	Fred Chen <fred.cc@alibaba-inc.com>,
	Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
Subject: Re: [PATCH net-next 2/2] datagram, udp: Set local address and rehash
 socket atomically against lookup
Message-ID: <Z1ZT5Cwd-VXK1_27@zatzit>
References: <20241204221254.3537932-1-sbrivio@redhat.com>
 <20241204221254.3537932-3-sbrivio@redhat.com>
 <CANn89i+iULeqTO2GrTCDZEOKPmU_18zwRxG6-P1XoqhP_j1p3A@mail.gmail.com>
 <Z1Ip9Ij8_JpoFu8c@zatzit>
 <CANn89i+PCsOHvd02nvM0oRjAXxPTgX6V1Y1-xfRL_43Ew9=H=w@mail.gmail.com>
 <Z1JeePBN5f1YCmYd@zatzit>
 <CANn89iJqLU6RuHgdbz3iGNL_K8XaPBYr3pWqQmgth2TFf14obg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pjliFRe7kRWNYCIi"
Content-Disposition: inline
In-Reply-To: <CANn89iJqLU6RuHgdbz3iGNL_K8XaPBYr3pWqQmgth2TFf14obg@mail.gmail.com>


--pjliFRe7kRWNYCIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 10:04:33AM +0100, Eric Dumazet wrote:
> On Fri, Dec 6, 2024 at 3:16=E2=80=AFAM David Gibson <david@gibson.dropbea=
r.id.au> wrote:
> >
> > On Thu, Dec 05, 2024 at 11:52:38PM +0100, Eric Dumazet wrote:
> > > On Thu, Dec 5, 2024 at 11:32=E2=80=AFPM David Gibson
> > > <david@gibson.dropbear.id.au> wrote:
> > > >
> > > > On Thu, Dec 05, 2024 at 05:35:52PM +0100, Eric Dumazet wrote:
> > > > > On Wed, Dec 4, 2024 at 11:12=E2=80=AFPM Stefano Brivio <sbrivio@r=
edhat.com> wrote:
> > > > [snip]
> > > > > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > > > > index 6a01905d379f..8490408f6009 100644
> > > > > > --- a/net/ipv4/udp.c
> > > > > > +++ b/net/ipv4/udp.c
> > > > > > @@ -639,18 +639,21 @@ struct sock *__udp4_lib_lookup(const stru=
ct net *net, __be32 saddr,
> > > > > >                 int sdif, struct udp_table *udptable, struct sk=
_buff *skb)
> > > > > >  {
> > > > > >         unsigned short hnum =3D ntohs(dport);
> > > > > > -       struct udp_hslot *hslot2;
> > > > > > +       struct udp_hslot *hslot, *hslot2;
> > > > > >         struct sock *result, *sk;
> > > > > >         unsigned int hash2;
> > > > > >
> > > > > > +       hslot =3D udp_hashslot(udptable, net, hnum);
> > > > > > +       spin_lock_bh(&hslot->lock);
> > > > >
> > > > > This is not acceptable.
> > > > > UDP is best effort, packets can be dropped.
> > > > > Please fix user application expectations.
> > > >
> > > > The packets aren't merely dropped, they're rejected with an ICMP Po=
rt
> > > > Unreachable.
> > >
> > > We made UDP stack scalable with RCU, it took years of work.
> > >
> > > And this patch is bringing back the UDP stack to horrible performance
> > > from more than a decade ago.
> > > Everybody will go back to DPDK.
> >
> > It's reasonable to be concerned about the performance impact.  But
> > this seems like preamture hyperbole given no-one has numbers yet, or
> > has even suggested a specific benchmark to reveal the impact.
> >
> > > I am pretty certain this can be solved without using a spinlock in the
> > > fast path.
> >
> > Quite possibly.  But Stefano has tried, and it certainly wasn't
> > trivial.
> >
> > > Think about UDP DNS/QUIC servers, using SO_REUSEPORT and receiving
> > > 10,000,000 packets per second....
> > >
> > > Changing source address on an UDP socket is highly unusual, we are not
> > > going to slow down UDP for this case.
> >
> > Changing in a general way is very rare, one specific case is not.
> > Every time you connect() a socket that wasn't previously bound to a
> > specific address you get an implicit source address change from
> > 0.0.0.0 or :: to something that depends on the routing table.
> >
> > > Application could instead open another socket, and would probably work
> > > on old linux versions.
> >
> > Possibly there's a procedure that would work here, but it's not at all
> > obvious:
> >
> >  * Clearly, you can't close the non-connected socket before opening
> >    the connected one - that just introduces a new much wider race.  It
> >    doesn't even get rid of the existing one, because unless you can
> >    independently predict what the correct bound address will be
> >    for a given peer address, the second socket will still have an
> >    address change when you connect().
> >
>=20
> The order is kind of obvious.
>=20
> Kernel does not have to deal with wrong application design.

What we're talking about is:

	bind("0.0.0.0:12345");
	connect("1.2.3.4:54321");

Which AFAIK has been a legal sequence since the sockets interface was
a thing.  I don't think it's reasonable to call expecting that *not*
to trigger ICMPs around the connect "wrong application design".

> >  * So, you must create the connected socket before closing the
> >    unconnected one, meaning you have to use SO_REUSEADDR or
> >    SO_REUSEPORT whether or not you otherwise wanted to.
> >
> >  * While both sockets are open, you need to handle the possibility
> >    that packets could be delivered to either one.  Doable, but a pain
> >    in the arse.
>=20
> Given UDP does not have a proper listen() + accept() model, I am
> afraid this is the only way
>=20
> You need to keep the generic UDP socket as a catch all, and deal with
> packets received on it.
>=20
> >
> >  * How do you know when the transition is completed and you can close
> >    the unconnected socket?  The fact that the rehashing has completed
> >    and all the necessary memory barriers passed isn't something
> >    userspace can directly discern.
> >
> > > If the regression was recent, this would be considered as a normal re=
gression,
> > > but apparently nobody noticed for 10 years. This should be saying som=
ething...
> >
> > It does.  But so does the fact that it can be trivially reproduced.
>=20
> If a kernel fix is doable without making UDP stack a complete nogo for
> most of us,

The benchmarks Stefano has tried so far don't show an impact, and you
haven't yet suggested another one.  Again, calling this a "complete
nogo" seems like huge hyperbole without more data.

> I will be happy to review it.
>=20

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--pjliFRe7kRWNYCIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmdWU+AACgkQzQJF27ox
2Gc7MBAAlKE2MaTMEXVMHAQ8efnVXmSqwlinYohSWZfH9tEV7q2qOZK0CizRP7ZQ
tc/i9l7FLVMgqGaC9syT2dWTnaQ5F+hJeKuLnoLBAL+IOCSeR+DqlBvfLqAFgsqp
dUG6YVKteNnRrMnMt3aPBMSufAwfd2gPVOOJYYrNoshYIgvAiP72jj59RajYuYXi
nIOduFQAbfI9XsQRwqn+758C44z2YsVZttxcU+fCyztCD1ZTnHXP921/aENvyKvQ
t4Ai70yh2rERlh69cUnNNWX6e034Xu8bX5hjT1jLKCNymsEk4pYAXztW2QaTpx6n
FeSqeP80nBAUqGDEr97JmGvDNi00QteqWbBcb1Jbt47dUVQqtWrDNe7rFWi9sumx
7oi7Ul+TlaD9lJvLrcEcK3T+g7H0pXW5w++iAcmdLUM0AgaXnuJbjLNlWevRMySB
0+mDjuwQQp+Q0Htc+YNjTgjXDWpxLRYCaFNE59xXiOUdBtmS5jY20rptzO09kbGj
Ai0URnfwFYjkvEjJWMbZnFYvLhjr68NEqQaanEwXuCaXAcO06NGTsyDo7nhtETME
dwiFsHHAanpiE/3wZ/p0SpSgBGqDdAeGPHmbBT7kTtapgujk/7gTa6Lan8fZkXbD
6z+tfveuipssKTV3p24hpwDryZATcaQOMMVuzWFV6sDH4vREOvg=
=90rr
-----END PGP SIGNATURE-----

--pjliFRe7kRWNYCIi--

