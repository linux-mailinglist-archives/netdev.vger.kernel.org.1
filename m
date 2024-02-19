Return-Path: <netdev+bounces-72795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3380859A9A
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 03:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22B81C208E9
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 02:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1408EDD;
	Mon, 19 Feb 2024 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WQgZnbIr"
X-Original-To: netdev@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B834810
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 02:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708308205; cv=none; b=Q7AmZQurJM7zeSd08+ueHoMF8TgFIBAjdxOt4WDjfucvoeAJR7yQ3accyIpkzsp08ZZjplgbu81UflAQ3EzbOWSir9HVZKgNB7sPVZbG0wEiuWIQFAiG7jX6FXrb/xB5eCTG3wxPCm5LMdY6TWA4x4jGR+oIq3rSN8Po7wYHrSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708308205; c=relaxed/simple;
	bh=Ipawxy6J+tJMkyBy62Dhgu8gHJrO1aWagg33b3e3l0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBWhEwfmfomGwZ8vGx/yPvn1uFebr9bh5GIVzF+dCTWBW5gbkjlL7WQB2cZ9fgIvzhGVmsbFQLunvIHMY+rNIhxmliFNbpis19m+W2gX8fX6q08NytD4en9+du/rA0Gt8LRkgZA11O9OX41KBWrjfDtSEbhPUGu55sH6TQh8f9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=WQgZnbIr; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202312; t=1708308192;
	bh=AqrMO8EraJBfPYvDNXHUjy7OXr7NkH/BzIlB54mMiBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQgZnbIrAxv8fteYUAgL5bqO0P0MoqhDxFZdfCHetqrVZkgWjW2mpfZrQm/OkbCx8
	 3EEumLWD1cMzf3SixhW+MAf6G/mB3ZZhhAYo8ML2FKlnaS0CV13DWyHrA0A/S4Dxg+
	 U/ZWWWF+nn9VZfVC7t9vcL9cMmdEFhwan5IByvcHPmOm08uIMDXvoo21Kv9+DrFKrN
	 KNE+Nn3+HKjBAZzTdASijD47oQg22b/riOcXYmp8dUn4tDAE4HtxnSzu8iVADiWN+n
	 qmKyr4sIX+jvlGxllpcA9IgG9B8mGRaXgDBXE+zDH60xDKFj+M216zyWrmWQQDZinj
	 9u7as/w9I+zIw==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4TdQmc4kJ3z4wcV; Mon, 19 Feb 2024 13:03:12 +1100 (AEDT)
Date: Mon, 19 Feb 2024 13:02:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Maloy <jmaloy@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com,
	lvivier@redhat.com, dgibson@redhat.com, netdev@vger.kernel.org,
	davem@davemloft.net
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
Message-ID: <ZdK2z4U1naf_T6IM@zatzit>
References: <CANn89iL2FvTVYv6ym58=4L-K-kSan6R4PEv488ztyX4HsNquug@mail.gmail.com>
 <725a92b4813242549f2316e6682d3312b5e658d8.camel@redhat.com>
 <CANn89i+bc=OqkwpHy0F_FDSKCM7Hxr7p2hvxd3Fg7Z+TriPNTA@mail.gmail.com>
 <20687849-ec5c-9ce5-0a18-cc80f5b64816@redhat.com>
 <178b9f2dbb3c56fcfef46a97ea395bdd13ebfb59.camel@redhat.com>
 <CANn89iKXOZdT7_ww_Jytm4wMoXAe0=pqX+M_iVpNGaHqe_9o4Q@mail.gmail.com>
 <89f263be-3403-8404-69ed-313539d59669@redhat.com>
 <9cb12376da3f6cd316320b29f294cc84eaba6cfa.camel@redhat.com>
 <CANn89i+C_mQmTFsqKb3geRADET2ELWeZ=0QHdvuq+v+PKtW0AQ@mail.gmail.com>
 <6a9f5dec-eb0c-51ef-0911-7345f50e08f0@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bxTDMv+/z8aJpho7"
Content-Disposition: inline
In-Reply-To: <6a9f5dec-eb0c-51ef-0911-7345f50e08f0@redhat.com>


--bxTDMv+/z8aJpho7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 05:13:34AM -0500, Jon Maloy wrote:
>=20
>=20
> On 2024-02-16 04:21, Eric Dumazet wrote:
> > On Fri, Feb 16, 2024 at 10:14=E2=80=AFAM Paolo Abeni<pabeni@redhat.com>=
  wrote:
> > > On Thu, 2024-02-15 at 17:24 -0500, Jon Maloy wrote:
> > > > On 2024-02-15 12:46, Eric Dumazet wrote:
> > > > > On Thu, Feb 15, 2024 at 6:41=E2=80=AFPM Paolo Abeni<pabeni@redhat=
=2Ecom>  wrote:
> > > > > > Note: please send text-only email to netdev.
> > > > > >=20
> > > > > > On Thu, 2024-02-15 at 10:11 -0500, Jon Maloy wrote:
> > > > > > > I wonder if the following could be acceptable:
> > > > > > >=20
> > > > > > >    if (flags & MSG_PEEK)
> > > > > > >           sk_peek_offset_fwd(sk, used);
> > > > > > >    else if (peek_offset > 0)
> > > > > > >          sk_peek_offset_bwd(sk, used);
> > > > > > >=20
> > > > > > >    peek_offset is already present in the data cache, and if i=
t has the value
> > > > > > >    zero it means either that that sk->sk_peek_off is unused (=
-1) or actually is zero.
> > > > > > >    Either way, no rewind is needed in that case.
> > > > > > I agree the above should avoid touching cold cachelines in the
> > > > > > fastpath, and looks functionally correct to me.
> > > > > >=20
> > > > > > The last word is up to Eric :)
> > > > > >=20
> > > > > An actual patch seems needed.
> > > > >=20
> > > > > In the current form, local variable peek_offset is 0 when !MSG_PE=
EK.
> > > > >=20
> > > > > So the "else if (peek_offset > 0)" would always be false.
> > > > >=20
> > > > Yes, of course. This wouldn't work unless we read sk->sk_peek_off a=
t the
> > > > beginning of the function.
> > > > I will look at the other suggestions.
> > > I *think* that moving sk_peek_off this way:
> > >=20
> > > ---
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index a9d99a9c583f..576a6a6abb03 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -413,7 +413,7 @@ struct sock {
> > >          unsigned int            sk_napi_id;
> > >   #endif
> > >          int                     sk_rcvbuf;
> > > -       int                     sk_disconnects;
> > > +       int                     sk_peek_off;
> > >=20
> > >          struct sk_filter __rcu  *sk_filter;
> > >          union {
> > > @@ -439,7 +439,7 @@ struct sock {
> > >                  struct rb_root  tcp_rtx_queue;
> > >          };
> > >          struct sk_buff_head     sk_write_queue;
> > > -       __s32                   sk_peek_off;
> > > +       int                     sk_disconnects;
> > >          int                     sk_write_pending;
> > >          __u32                   sk_dst_pending_confirm;
> > >          u32                     sk_pacing_status; /* see enum sk_pac=
ing */
> > > ---
> > >=20
> > > should avoid problematic accesses,
> > >=20
> > > The relevant cachelines layout is as follow:
> > >=20
> > >                          /* --- cacheline 4 boundary (256 bytes) --- =
*/
> > >                  struct sk_buff *   tail;                 /*   256   =
  8 */
> > >          } sk_backlog;                                    /*   240   =
 24 */
> > >          int                        sk_forward_alloc;     /*   264   =
  4 */
> > >          u32                        sk_reserved_mem;      /*   268   =
  4 */
> > >          unsigned int               sk_ll_usec;           /*   272   =
  4 */
> > >          unsigned int               sk_napi_id;           /*   276   =
  4 */
> > >          int                        sk_rcvbuf;            /*   280   =
  4 */
> > >          int                        sk_disconnects;       /*   284   =
  4 */
> > >                                  // will become sk_peek_off
> > >          struct sk_filter *         sk_filter;            /*   288   =
  8 */
> > >          union {
> > >                  struct socket_wq * sk_wq;                /*   296   =
  8 */
> > >                  struct socket_wq * sk_wq_raw;            /*   296   =
  8 */
> > >          };                                               /*   296   =
  8 */
> > >          struct xfrm_policy *       sk_policy[2];         /*   304   =
 16 */
> > >          /* --- cacheline 5 boundary (320 bytes) --- */
> > >=20
> > >          //  ...
> > >=20
> > >          /* --- cacheline 6 boundary (384 bytes) --- */
> > >          __s32                      sk_peek_off;          /*   384   =
  4 */
> > >                                  // will become sk_diconnects
> > >          int                        sk_write_pending;     /*   388   =
  4 */
> > >          __u32                      sk_dst_pending_confirm; /*   392 =
    4 */
> > >          u32                        sk_pacing_status;     /*   396   =
  4 */
> > >          long int                   sk_sndtimeo;          /*   400   =
  8 */
> > >          struct timer_list          sk_timer;             /*   408   =
 40 */
> > >=20
> > >          /* XXX last struct has 4 bytes of padding */
> > >=20
> > >          /* --- cacheline 7 boundary (448 bytes) --- */
> > >=20
> > > sk_peek_off will be in the same cachline of sk_forward_alloc /
> > > sk_reserved_mem / backlog tail, that are already touched by the
> > > tcp_recvmsg_locked() main loop.
> > >=20
> > > WDYT?
> > I was about to send a similar change, also moving sk_rcvtimeo, and
> > adding __cacheline_group_begin()/__cacheline_group_end
> > annotations.
> >=20
> > I can finish this today.
> >=20
> There is also the following alternative:
>=20
> if (flags & MSG_PEEK)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sk_peek_offset_fwd(sk, used);
> else if (flags & MSG_TRUNC)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sk_peek_offset_bwd(sk, used);
>=20
> This is the way we use it, and probably the typical usage.
> It would force a user to drain the receive queue with MSG_TRUNC whenever =
he
> is using
> MSG_PEEK_OFF, but I don't really see that as a limitation.

I really don't like this, although it would certainly do what we need
for passt/pasta.  SO_PEEK_OFF has established semantics for Unix
sockets, which includes regular recv() adjusting the offset.  Having
it behave subtlety differently for TCP seems like a very bad idea.

> Anyway, if Paolo's suggestion solves the problem this shouldn't be
> necessary.
>=20
> ///jon

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bxTDMv+/z8aJpho7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmXSts4ACgkQzQJF27ox
2GdcWw/9Epp0+u3K9tIwTTqx8NhlfYTdvilcKd11V1AxORQrOvzczv4ku/Uu3bUl
HCMgQsHtqBVl10gm9xBLI59GyGaqyrAdPfeVyd7aBN4PbR9E6A47x6yC1xW6JyhW
5rnaN3j6+p5Db6M+MUTc6q48KRAko4P9tm0WGqE30ASO5+/nkoTLUMy4h5/p+xEX
DRcHBItbKoDUf9RTBzlhpUAVdvvMFjmlqsFmLGqLxUPY3WxXrGctUaQURktFokoY
3J6ZDj/RCB7ezgS5ntmeBgY0OExnGST/VVdUmeta93gyzOpO5DzjUtzxrwcPB+JM
6sElQf0pShK+hdm4TsbbbDpV6HE2KKuRR/0l7tEg74O0mWlrrO/ci3RVO1L1T5GK
DtNSLyEu6ss646e2MgqlPYFHGQSEXvqk8UizXtQqqiJrWAOSbk38viTZGSLCfcaz
prp45npk4eL4kHuP+CfF3v7oCTA6X/ERYhTF+VukmpR/IW/MvtEfG/D56nONdveN
sUhp9V5ktgT64nlPpJSheewGLHHXUnaNDFYxAP7490zrjuM0+ICh7JgMAu5ITFAs
Ji+T7+HLLeuaWldFuVC5XorP0/07ijxQLRELVuEtEE2HOPN0OTPD+IsBCGO9WPu5
G5+WncOG+4116J5VXfzReNpCLqyo03u+Gi2Igrey1ku8uMqh+I0=
=56X0
-----END PGP SIGNATURE-----

--bxTDMv+/z8aJpho7--

