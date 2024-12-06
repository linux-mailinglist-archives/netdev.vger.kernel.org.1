Return-Path: <netdev+bounces-149567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE279E63EE
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 03:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05426163E6C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 02:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BAF47F69;
	Fri,  6 Dec 2024 02:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PnC8sIL8"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C08018B09
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 02:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451400; cv=none; b=dhbSaKvAHyCkC/z4PnJE/nHnjTNSVaDQO39WHfVTUTn8iajhTh7YWQCrlRTyBR5cPqxPEIMbAg6QMr0Cg3gDWqK0L7tfdLr3MazSvRW5/C46ERzHGZjiGNznekFw4jMdTtv7WbymJbaBo4R6DIjxGtYMrk5ktBgWy3iLdKWbrNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451400; c=relaxed/simple;
	bh=On2oRxLyHP05sOalK3nVEblmgUAO744WIOinZ4i+LiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9vamxGvqDT/d/bdrlYG37K5NH8ZxImfPzpZSVT50bbyb5pUpJsmbDMe3/j/cgkpGYtR61noJpKlOmuWvWcLWqVQF1ondzlnb8Sz6q9uGWeFTj9KOUMFufaC86YphVV+R7BtIQTSFLZtFi5TjuGNmWiKybji5CrsqxuMqXuNHLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=PnC8sIL8; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202410; t=1733451384;
	bh=z03h4bL+QegCodkBmoyKnXXNHAkm5Q2wksSfOXAsu70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PnC8sIL8pnCoZ3CKvpXpRReGWkfKn1hlnSXFSs7Yio38O67Y0NHFI/rZVIdehm3p2
	 /QUjtZu0vRFGuChOCegMp2lv9qjRG9GAcvP9tSvnro3KHpchvNM7pnRoIWeYcuFbZD
	 sCLsfzCPpq7CCAo89RLyUPiAwMXLHCJ+RqPEPPsOput6r6lVrdBGRMvLN9mblIICL9
	 w++MC83rPBz7MScXtjBgkM1DCeVLw4asaEAs1ZGpSSfvwjVkIlTjUqQ7SryEK5lZSL
	 YvtDvbGQKgfOgnFBkorKkUk4s97C++Xcrcu4sc98twYRdp6XcqkGWcWUavdAIW1Z3t
	 uUMuE1hXsVZjQ==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4Y4FHX2ksdz4x63; Fri,  6 Dec 2024 13:16:24 +1100 (AEDT)
Date: Fri, 6 Dec 2024 13:16:24 +1100
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
Message-ID: <Z1JeePBN5f1YCmYd@zatzit>
References: <20241204221254.3537932-1-sbrivio@redhat.com>
 <20241204221254.3537932-3-sbrivio@redhat.com>
 <CANn89i+iULeqTO2GrTCDZEOKPmU_18zwRxG6-P1XoqhP_j1p3A@mail.gmail.com>
 <Z1Ip9Ij8_JpoFu8c@zatzit>
 <CANn89i+PCsOHvd02nvM0oRjAXxPTgX6V1Y1-xfRL_43Ew9=H=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TM2Q45GO6H13v2TL"
Content-Disposition: inline
In-Reply-To: <CANn89i+PCsOHvd02nvM0oRjAXxPTgX6V1Y1-xfRL_43Ew9=H=w@mail.gmail.com>


--TM2Q45GO6H13v2TL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 11:52:38PM +0100, Eric Dumazet wrote:
> On Thu, Dec 5, 2024 at 11:32=E2=80=AFPM David Gibson
> <david@gibson.dropbear.id.au> wrote:
> >
> > On Thu, Dec 05, 2024 at 05:35:52PM +0100, Eric Dumazet wrote:
> > > On Wed, Dec 4, 2024 at 11:12=E2=80=AFPM Stefano Brivio <sbrivio@redha=
t.com> wrote:
> > [snip]
> > > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > > index 6a01905d379f..8490408f6009 100644
> > > > --- a/net/ipv4/udp.c
> > > > +++ b/net/ipv4/udp.c
> > > > @@ -639,18 +639,21 @@ struct sock *__udp4_lib_lookup(const struct n=
et *net, __be32 saddr,
> > > >                 int sdif, struct udp_table *udptable, struct sk_buf=
f *skb)
> > > >  {
> > > >         unsigned short hnum =3D ntohs(dport);
> > > > -       struct udp_hslot *hslot2;
> > > > +       struct udp_hslot *hslot, *hslot2;
> > > >         struct sock *result, *sk;
> > > >         unsigned int hash2;
> > > >
> > > > +       hslot =3D udp_hashslot(udptable, net, hnum);
> > > > +       spin_lock_bh(&hslot->lock);
> > >
> > > This is not acceptable.
> > > UDP is best effort, packets can be dropped.
> > > Please fix user application expectations.
> >
> > The packets aren't merely dropped, they're rejected with an ICMP Port
> > Unreachable.
>=20
> We made UDP stack scalable with RCU, it took years of work.
>=20
> And this patch is bringing back the UDP stack to horrible performance
> from more than a decade ago.
> Everybody will go back to DPDK.

It's reasonable to be concerned about the performance impact.  But
this seems like preamture hyperbole given no-one has numbers yet, or
has even suggested a specific benchmark to reveal the impact.

> I am pretty certain this can be solved without using a spinlock in the
> fast path.

Quite possibly.  But Stefano has tried, and it certainly wasn't
trivial.

> Think about UDP DNS/QUIC servers, using SO_REUSEPORT and receiving
> 10,000,000 packets per second....
>=20
> Changing source address on an UDP socket is highly unusual, we are not
> going to slow down UDP for this case.

Changing in a general way is very rare, one specific case is not.
Every time you connect() a socket that wasn't previously bound to a
specific address you get an implicit source address change from
0.0.0.0 or :: to something that depends on the routing table.

> Application could instead open another socket, and would probably work
> on old linux versions.

Possibly there's a procedure that would work here, but it's not at all
obvious:

 * Clearly, you can't close the non-connected socket before opening
   the connected one - that just introduces a new much wider race.  It
   doesn't even get rid of the existing one, because unless you can
   independently predict what the correct bound address will be
   for a given peer address, the second socket will still have an
   address change when you connect().

 * So, you must create the connected socket before closing the
   unconnected one, meaning you have to use SO_REUSEADDR or
   SO_REUSEPORT whether or not you otherwise wanted to.

 * While both sockets are open, you need to handle the possibility
   that packets could be delivered to either one.  Doable, but a pain
   in the arse.

 * How do you know when the transition is completed and you can close
   the unconnected socket?  The fact that the rehashing has completed
   and all the necessary memory barriers passed isn't something
   userspace can directly discern.

> If the regression was recent, this would be considered as a normal regres=
sion,
> but apparently nobody noticed for 10 years. This should be saying somethi=
ng...

It does.  But so does the fact that it can be trivially reproduced.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--TM2Q45GO6H13v2TL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmdSXnQACgkQzQJF27ox
2GeeqhAAk2zAF3COOlREAiR/zb2Nss35hRL2mDjLHm+QVMNc8xNiYhmnkhTg9xWZ
KyqS5nD75xegj2m1tDBGcK+8dF9TCTFloCBb7FizEJjVssbllG9yAOcPD9zaWLhS
4ytdMPBKitvVzQPJxzfaK/W+sKzO1rVqE0MWr0O7cH3/dsEBKzFfro7AZ+G/Ydju
q+NC6e8FmnwmQ16lnyOoSH3Myf4oknxzsJfUkrm4h+VBPSRfIgU5MPZPeWZ3iU8y
ajGTqqAV+wclF3VZr1w0T77HQhYUy9BtaMOGdCgDtHgBsQOEizguvdd99bBbqWrq
dDCuvok7s0y/Iu9WS/TZaJzeIke5EGNRvBz5p4DlgB6MBI/eiwCZT8177gawhoxH
ru1YguSvExUy4yHcklVZVcgp2hyqf6J1tCGlwz4zKX2qEKrp2TsT7wdJcayDwIoG
on8KzBzhgl9gbVWRRKqQVJiwco5Ge18R09zlhzduDytmq93NVe/CWrkqQ2uGebB/
/kYZVwWPI59W/5Du6vVDFgYbI0eUvfCRHbnmuFhvGC36sl4l0mPtwaS5TFl9B7F0
xe2nvqrl1vwRtzfTsJ1sRp3TgyiQGMQVWZ67lfxVU0JJDqlSZKzrbUqPrStuLkkL
unFgi9d3MCC0dQBlHMx6Zq9oJJAWGnIe+Q7IyKw/p0T5eY9+wmc=
=0pKR
-----END PGP SIGNATURE-----

--TM2Q45GO6H13v2TL--

