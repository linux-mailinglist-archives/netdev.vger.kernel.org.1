Return-Path: <netdev+bounces-294525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zn5HHaGTH2qBnQAAu9opvQ
	(envelope-from <netdev+bounces-294525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:38:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2C2633AD4
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:38:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gibson.dropbear.id.au header.s=202602 header.b=IYur9u49;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294525-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294525-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6401304DA13
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 02:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93463DC4B1;
	Wed,  3 Jun 2026 02:37:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E738333C
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 02:37:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780454268; cv=none; b=S8ehntJaJw+PD5y9ZguNcDBej3X8tnAjpNbxCwaAIMQqgk02wr7MsrPLTW7rW//ZWRLyjQNCVg1lGT5JWpAGWCqGx6Ctogszh3RXhFvmsJtrBoTaOo1UWiPNOrI8rY9Kr9u6o1f9/9eWc1Y48BJx4+/8cbQKJ9EtbkzqL61iC6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780454268; c=relaxed/simple;
	bh=nuv889z5fIH+LA6hl1yrTbq5kRHuVqPU8Z8gUz7ZO9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gx2WdD2BnQd5cfRd43GET0IengV4WQvG4d2AcFU5GoXsR3G9Lql6veqlGgmoQZB84XORiQUjS2svuNw9OYMFEHl4Y16Uqh0yXEu/+E9Im9qxw2ScNqajjzN5keGykckRql6sHJhxzIvTAFWC0h//xlo5kLpCdgmjq6Cl929HEEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=IYur9u49; arc=none smtp.client-ip=150.107.74.76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202602; t=1780454258;
	bh=uKWDa8GjBCU0yPPR4iCN86rQnpbOkWZH9ZIYbLxMY/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IYur9u49CSlELzP6tEs/axxL6nuT6tRUS4Qaotkcnh3h0trHfLefMX60ERtRxQuSS
	 x92g+KwesVgo78ZRVhumTF3InwI/YYFCzNqP+44GvihclclJivwgDeCH2yWR33WZ/j
	 o02jxq8eWIrxfKwoWvCqflhDzOpTo0iuLys/pQeRbST/ElA1qWqeC09c6mKxZl6F0m
	 +DpFmY5mO11u5dw2Xs4eBx/bY4KY10sZm9ga3c5YQdrdVJOHv9sWL8cmkHMQS4Kvef
	 9CLKYh10zvFp8eUTurukdT82DNCzEBcc3qsOIr0IE/SZBD28PmaogzFLR+eAhUwfB1
	 9aIc/tWVRmE5Q==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4gVX0y5kJlz4wJk; Wed, 03 Jun 2026 12:37:38 +1000 (AEST)
Date: Wed, 3 Jun 2026 12:34:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Stefano Brivio <sbrivio@redhat.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	netdev@vger.kernel.org, yuhuang@redhat.com, justin.iurman@gmail.com,
	horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
	Chris Adams <linux@cmadams.net>,
	Beniamino Galvani <bgalvani@redhat.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Andrew Lunn <andrew@lunn.ch>, ihuguet@redhat.com,
	regressions@lists.linux.dev
Subject: Re: IPv6 address insertion order (was Re: [PATCH net v2] Revert
 "ipv6: preserve insertion order for same-scope addresses")
Message-ID: <ah-SvHdPRrYXX6lx@zatzit>
References: <20260529112357.5079-1-fmancera@suse.de>
 <20260529134045.56330243@elisabeth>
 <ah57wxGjL7JBORR1@zatzit>
 <20260602132118.GA508395@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Jqg0IV66smsEkz9g"
Content-Disposition: inline
In-Reply-To: <20260602132118.GA508395@shredder>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[gibson.dropbear.id.au:s=202602];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:sbrivio@redhat.com,m:fmancera@suse.de,m:netdev@vger.kernel.org,m:yuhuang@redhat.com,m:justin.iurman@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:linux@cmadams.net,m:bgalvani@redhat.com,m:regressions@leemhuis.info,m:andrew@lunn.ch,m:ihuguet@redhat.com,m:regressions@lists.linux.dev,m:justiniurman@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[david@gibson.dropbear.id.au,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DMARC_NA(0.00)[dropbear.id.au];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294525-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gibson.dropbear.id.au:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@gibson.dropbear.id.au,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,suse.de,vger.kernel.org,gmail.com,kernel.org,google.com,davemloft.net,cmadams.net,leemhuis.info,lunn.ch,lists.linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zatzit:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gibson.dropbear.id.au:from_mime,gibson.dropbear.id.au:dkim,ozlabs.org:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB2C2633AD4


--Jqg0IV66smsEkz9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026 at 04:21:18PM +0300, Ido Schimmel wrote:
> On Tue, Jun 02, 2026 at 04:44:19PM +1000, David Gibson wrote:
> > I get the impression there's a rough consensus that the best we can do
> > now is revert this change (already done), and make a new patch which
> > changes the insertion order to the "correct" one conditional on a new
> > flag.
> >=20
> > Stefano has enough other fires to fight, so I'm taking a look at
> > implementing that.  Some initial thoughts, that I'm soliciting
> > feedback on:
> >=20
> > 1) I'm assuming the idea here is to add the new flag to nlmsg_flags in
> >    nlmsghdr
> >=20
> > ifa_flags in ifaddrmsg would be the other candidate, but it looks like
> > it's encoding properties of the address itself, not about the action
> > of inserting it.  Plus all its bits are allocated, anyway.
> >=20
> > 2) Could we re-use NLM_F_APPEND?
> >=20
> > The short description of this existing flag in linux/uapi/netlink.h is
> > "Add to end of list" which sounds like the right thing.  Looking
> > closer, however, it seems like what is' used for so far is things
> > where the entity added with the NEW<whatever> operation is itself a
> > list, and NLM_F_APPEND causes it to be added to rather than replaced.
> > It's not used for addresses at present, AFAICT the list of addresses
> > is a semantic level above the address entity itself.
> >=20
> > So maybe re-using it for the thing I tentatively called
> > NLM_F_INSERT_LAST would be confusing?
> >=20
> > On the other hand, it's not used for addresses at the moment, so
> > AFAICT there's nothing actually preventing us reusing it for this
> > purpose. That would save a bit - we only have 2 general and 4 NEW
> > specific bits left, by the looks of it.
>=20
> This is not really viable. Even if the kernel is not using NLM_F_APPEND
> for RTM_NEWADDR, but not rejecting its presence either, then we can
> create a change in behavior for a user space that is currently setting
> it (intentionally or not).
>
> Example:
>=20
> https://lore.kernel.org/netdev/27c249d80c346a258cfbf32f1d131ad4fe64e77c.c=
amel@debian.org/

Hmm.  So, in this example case we have a known, widely deployed
userspace that was broken by the change.  Similarly with the
original now-reverted "fix" for the ordering, we have a known, widely
deployed userspace that was broken.

That's a different case from a hypothetical userspace that incorrectly
used NLM_F_APPEND on RTM_NEWADDR.  Moreover, to be broken it would
need to incorrectly use NLM_F_APPEND on RTM_NEWADDR *and also* rely on
the counterintuitive and inconsistent insertion order for IPv6
addresses.  Absent a concrete example of something meeting both those
conditions, I'm inclined to breaking that hypothetical case when the
payoff is an easier route to get known cases working with the
preferred insertion semantics.

Fwiw, I did look at the most likely candidates: iproute2,
network-manager and libvirt, and I see no signs that they're misusing
NLM_F_APPEND in this way.

> > 3) What other things might need changing to take advantage of the
> >    kernel change
> >=20
> > My innitial testing suggests that unknown nlmsg_flags bits are
> > currently ignored by the kernel.
>=20
> Which is a problem... From the looks of it, the same is true for
> ifa_flags.

ifa_flags is a no go anyway.

> > That means that tools for which the new behviour is desirable, but not
> > essential may be able to avoid probing - they can set the bit and
> > hope.  I think that includes passt/pasta and also iproute's
> > save/restore functionality.
> >=20
> > That said, things which might want updating:
> >  - iproute2 to use this for save/restore
> >  - netlink(7) man page to detail the new flag / new flag semantics
> >  - passt/pasta
> >  - network-manager, here we require the exact behaviour be maintained,
> >    so it would have to attempt the new flag, then apply the existing
> >    workaround (reversing the order itself) if that fails.  Maybe more
> >    trouble that it's worth?
> >=20
> > Any others people can think of?
>=20
> The safest route is probably a new attribute and a corresponding keyword
> in iproute2.

I guess attribute+keyword does make it pretty straightforward to opt
in to the new behaviour in scripts, not just C code.

> Note that new iproute2 versions need to be able to work
> with old kernels, so iproute2 cannot use the new attribute by default
> (it will be rejected by old kernels).

Yes, I'm aware.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--Jqg0IV66smsEkz9g
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmofkq8ACgkQzQJF27ox
2Gcd0Q/+I3Q7qip5ctygDSsZbpvh86X6+my+CQ5xB6Ub55i4634dOStK24bRgFFR
wsr/P7c83GpXfpYTFv1pZqFyB9lLpiM5yY1eTDBVzMX6rQdnSGv7i6AWcLq80VfL
b3fl7MkpTx1sA5YaI/fJ9GjxjmXmMlK/DKtT+XeyHn0LloehFGO6YBUJgQNv2/jl
ISKgRw3jEzDjov4UUMpTPqEv/2dwAKCYCdtvVgRoU4HBLr+t4axeHm+PvJ3IMxsP
jE4OpZt5eaIIqG4Ft/G3CrG4ANNa17pEgBfgPIDvzvWFoGs9E9P2XyfdcrL5IsK0
VEoXpoXYShSrCSdYHTNDwoXlMTgrVXKEoE8Onk35fXziTprZ8mmVTrMefa9YRbgF
T7qzskMcZHoZCqHeg3GfcNZSJOmMWYOIeUOIElCLkNEx+Y1yeJAH46q0Gh4irkel
Iu6zH89YXBJgA0aKqLLexFoyD9PkyfX3TqjRLBW0SFSzmtTXuYj+OzfyrKKUcm4s
ST2ikfbO8ltnvEKpIw109t/b/M891c8Le9o/fEXpPPrlmGqgGot+Rw2n3IuGMGLC
RDaPLSSW8VjHy46QWUB3NqQfxMSx/G+zTbO7HziESxwp4I8GjoxDjVOItGzoXFLA
mKXXXOHAtfedKYrKSXR6d5Nz//UiRkKc62zd2+NHk6b+E/u/J1Y=
=LgKF
-----END PGP SIGNATURE-----

--Jqg0IV66smsEkz9g--

