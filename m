Return-Path: <netdev+bounces-288859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP6EGPynCmp/5QQAu9opvQ
	(envelope-from <netdev+bounces-288859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:47:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C178B566719
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A5FA305C608
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68CC3B47E4;
	Mon, 18 May 2026 05:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BwIX724I"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33383B4E84;
	Mon, 18 May 2026 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779082583; cv=none; b=F4/Yy9XhshV7CkvASNtNtYxGckr6jw9U82Ryr+UIy1yaBiCBNk9IgqQdSTiHFr+GUBjeQRiqUG/dnt+oQgBSt6zD9MXZmr6/1wzyOjz9EghUatxiJg0h/qWAvc+ALLtVLNrdmZv/cGJXQ9+GZzHjdo6aVv8x+v334+DeaQtQJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779082583; c=relaxed/simple;
	bh=6O0R2jTR9rZDQ6+V43jfT5moBn4nIJlWkIanR+PSKoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRaQjjhMPQ6D3c2jHyHYrOWrc3yY4J8w931F9SNrZYNXmOoF28YmfDSm0KhmLUzZ8B1yaX5eaXdmGOU4Sur5DoPDSsyCxoArLJoEZgo/6d/OxfbCeviarM40ieHXfO2ozZPAwpcjgntfAS1Wo8v0u/MgdQ1A/AwUec4SDaGJOSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=BwIX724I; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202602; t=1779082563;
	bh=hw2gv/6TsP3dThKptCuBS/fQsaP2Z7xDPwtTLr/Mx/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BwIX724ItkpKIx3F8YJFf73Cuz7TP6J0JEbT+Acobm4jxdOZZ2le9EFqL0GCROW/p
	 R6bEszzFV+1IG8YHfeh8wuWx33MYHQwaR8cMJtrKXxb3ZY1VusXb6qCeKMyI6GsIzu
	 bzGgdIQV9buPENmB1Fxcsi+2Y2zl+1KsOh53U00kaHrdr6tHZ6KzZtrMjNwckBR02y
	 Yq2yGRRhmXsxQTYUhc8gw9KUTnZixRgvnnHy6uLakDurC9FGjaeal0vI9eqIbf1FgS
	 f3+QKojpje8MTOFnddPLxsH/7aSaMInONuhVmU+ssJOJHhujqxKWsLePY8z8/Y7YBt
	 +NO+A2LbSZLqw==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4gJmkC27Sjz58mB; Mon, 18 May 2026 15:36:03 +1000 (AEST)
Date: Mon, 18 May 2026 15:32:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Stefano Brivio <sbrivio@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pavel Emelyanov <xemul@scylladb.com>,
	Laurent Vivier <lvivier@redhat.com>, Jon Maloy <jmaloy@redhat.com>,
	Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@google.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net 1/2] tcp: Don't accept data when socket is in repair
 mode
Message-ID: <agqkcUNI8Y9x_sz7@zatzit>
References: <20260517184158.2757505-1-sbrivio@redhat.com>
 <20260517184158.2757505-2-sbrivio@redhat.com>
 <CAAVpQUCiHA=z62udnWLVyv0LeGsAHr+A=_o-8fomHZfJZJO2aQ@mail.gmail.com>
 <20260517215307.13cda56a@elisabeth>
 <CAAVpQUDc5FL2Ab-J3GHCU-LxPAwsZVfo=BG3chun6zRxOPVQtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3X8wjBCcNzjYhJjg"
Content-Disposition: inline
In-Reply-To: <CAAVpQUDc5FL2Ab-J3GHCU-LxPAwsZVfo=BG3chun6zRxOPVQtA@mail.gmail.com>
X-Rspamd-Queue-Id: C178B566719
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gibson.dropbear.id.au:s=202602];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[dropbear.id.au];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-288859-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@gibson.dropbear.id.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gibson.dropbear.id.au:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gibson.dropbear.id.au:dkim]
X-Rspamd-Action: no action


--3X8wjBCcNzjYhJjg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 02:01:29PM -0700, Kuniyuki Iwashima wrote:
> On Sun, May 17, 2026 at 12:53=E2=80=AFPM Stefano Brivio <sbrivio@redhat.c=
om> wrote:
> >
> > On Sun, 17 May 2026 12:05:45 -0700
> > Kuniyuki Iwashima <kuniyu@google.com> wrote:
> >
> > > On Sun, May 17, 2026 at 11:41=E2=80=AFAM Stefano Brivio <sbrivio@redh=
at.com> wrote:
> > > >
> > > > Once a socket enters repair mode (TCP_REPAIR socket option with
> > > > TCP_REPAIR_ON value), it's possible to dump the receive sequence
> > > > number (TCP_QUEUE_SEQ) and the contents of the receive queue itself
> > > > (using TCP_REPAIR_QUEUE to select it).
> > > >
> > > > If we receive data after the application fetched the sequence number
> > > > or saved the contents of the queue, though, the application will now
> > > > have outdated information, which defeats the whole functionality,
> > > > because this leads to gaps in sequence and data once they're restor=
ed
> > > > by the target instance of the application, resulting in a hanging or
> > > > otherwise non-functional TCP connection.
> > > >
> > > > This type of race condition was discovered in the KubeVirt integrat=
ion
> > > > of passt(1), using a remote iperf3 client connected to an iperf3
> > > > server running in the guest which is being migrated. The setup allo=
ws
> > > > traffic to reach the origin node hosting the guest during the
> > > > migration.
> > > >
> > > > If passt dumps sequence number and contents of the queue *before*
> > > > further data is received and acknowledged to the peer by the kernel,
> > > > once the TCP data connection is migrated to the target node, the
> > > > remote client becomes unable to continue sending, because a portion
> > > > of the data it sent *and received an acknowledgement for* is now lo=
st.
> > > >
> > > > Schematically:
> > > >
> > > > 1. client --seq 1:100--> origin host --> passt --> guest --> server
> > > >
> > > > 2. client <--ACK: 100-- origin host
> > > >
> > > > 3. migration starts,
> > >
> > > Here, a netfilter rule or bpf prog must be installed to
> > > drop packets temporarily until migration completes.
> >
> > Thanks for the review.
> >
> > I have to say it's rather unexpected to have to work around obvious
> > kernel issues in userspace: TCP_REPAIR implies that queues are frozen,
> > and this is handled correctly on the sending side (see
> > tcp_write_xmit()), but was clearly forgotten on the receiving side.
> >
> > TCP_REPAIR also allows to dump queues, not just sequence numbers, so
> > this really is a bad race condition making the whole functionality
> > unreliable.
> >
> > But anyway, even looking for a practical workaround of the kind you
> > suggested, I see two issues with it:
> >
> > 1. we would still have a race condition, because userspace doesn't have
> >    a way to synchronise application of nftables rules (or even a BPF
> >    program) with the effects of TCP_REPAIR.
>=20
> Note that setsockopt(TCP_REPAIR) is under lock_sock(), so the
> backlog is always cleared before returning to userspace, and the
> following getsockopt() will have stable view.
>=20
>=20
> > We could apply nftables
> >    rules "a while before" just to be sure, but this is severely going to
> >    impact migration downtime
>=20
> So it's "just before", not "a while before".
>=20
>=20
> >
> > 2. passt(1) runs unprivileged and uses a very simple helper to set
> >    TCP_REPAIR on the socket.
>=20
> I guess it uses userns ?

It does, but it doesn't help.

> setsockopt(TCP_REPAIR) requires CAP_NET_ADMIN in the
> userns tied to the socket's netns (in tcp_can_repair_sock()),
> so you should be able to use netfilter anyway.

The sockets we use TCP_REPAIR on are *outside* the netns/userns - the
whole point is that we're bridging between the outside world and the
ns.  So we have no privileges there to use netfilter (and even if we
did, we couldn't safely use it, since we don't know how else netfilter
is being used on the host system).

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--3X8wjBCcNzjYhJjg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmoKpGQACgkQzQJF27ox
2GcF4Q//enKLHMmzoXrrbkAb5tu22/rJxfCV0tId3sIMAB7R2hjX/PU7z90LiqJu
SnQptjfzZzUjOsMASC9SIcoBXWNfI9rdKAOW0a62Bwb5l8K70l+wo3Etk5Y2k/pF
+lVkl2puB6+ztKaXwA5KlSXQP8VvLLF0vViTYYLX8uzFVj2/QdWaucQLI3TmRpCB
biY2inFL0URutXpqML6orXA/IduT7aYWFPskSmYl6MNxGcvy53O7eJKZQuWmWmzd
znt78UkXWFiI2ujhNZxGLqqcTr2IG7qohRmeLVGLE0kFrtAZT0+kwQ+tbmRkLBS7
/fdUleyCSDvntni+SXMjLxoEBra+QfAKs1DhzD7UuYm/p0eS3cPZzCIYSJzB7ELS
gn6o4kxXvVRDHASdh2ScQ6z++FBMKo68pPcq50ojgFxjfkYdCYm7Rbo7I6deyy0n
i3+l/Da2EQp3Jo60z9WdK3kMN7LW2RBbQ4UOU+322PCSB00vLhBkIEZQx7ftfeiT
Vii76NK1bsMTOfJydicX9mqvCCdfpEwDprQu6rfTwTaT85KRynOnaQFMUSBY8wdA
75cPWuW9wJuhEcd2812yWKUwXYYY+Y+9nusoezOLw+j2Up1RPJiZRBuabNs6wwLo
wulrf9tzFtrTIVnK973Jo68nAlM2L8f2oXCyo2YNiUjsh0C/ZGo=
=1Ssk
-----END PGP SIGNATURE-----

--3X8wjBCcNzjYhJjg--

