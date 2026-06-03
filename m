Return-Path: <netdev+bounces-294524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t74mIYSTH2p8nQAAu9opvQ
	(envelope-from <netdev+bounces-294524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:37:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D75633ACE
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:37:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gibson.dropbear.id.au header.s=202602 header.b=G10Nn3zw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294524-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294524-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 927E1300FB1C
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 02:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92843DBD65;
	Wed,  3 Jun 2026 02:37:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA1C3D6462
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 02:37:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780454268; cv=none; b=cWFu7xEmqyJXEF+zQmlDxZDSZMSS1gF68/mPc2W/FswJgjVjYc29eaZItGzNS5eamqCXYqzMOJ4438ICFqA9Gpo5VPkigFt7ehhbFmd87vu4i7e+BUU5mFUwQdbTcI27pZhkhWZguzhJlV/pKrz/bMBiV1L+qiHFDT6ut6peKpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780454268; c=relaxed/simple;
	bh=pnrDo8mXOZzS/zu/QPEGKYct1x//5K/eKJErBP8HBFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq8VWnGb+y4jnMLnQQnkTEwok2Ig5FPQ3OB4e79gRbf03w9en6Q3R7ovrl5PNzTAobyy2E+zau3lvuJqpdf47RkMSi+i9C3G8q+fv2lrvcN/Mof/4jjVhRBzjLupOog6YhIBtWXfU7jkkkbYsIOrFBUDDb9MvsykRDpwuZqpGLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=G10Nn3zw; arc=none smtp.client-ip=150.107.74.76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202602; t=1780454258;
	bh=76KrfOR2GHr5zOagipHk9aFNkXiX5JVJYNIbsQrwkP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G10Nn3zwwPhZyoW6MfXPsTTwastzc1x13hVwnpQ9UJVVaST4o8snj87pbZxTaAG6z
	 d8cLr47B+Vz9kLPLpXh5tjvVSJ7+ST3uTh6+e5PilfToFwcvewg/VDMu32uGXy+ZBl
	 rvFzMSg5nJLvUNaoCmZ1YScBaG/BHFCvEazIBAd16sG1m+4C1s0rY1VaJIYjaOHs5X
	 frrKaciSigL1xNwGgsOxn/Ev/j0cEGD7oT/MhLGviACJzMevAcMtM8qsrHyabfr4kO
	 O+WnKHQvwQr1PwW9WsWBo0xa/AczQoa0Sz81pWeOpWp6W+RiYh6XBF4gikEAcjeqpq
	 EJLKuoSyiFBng==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4gVX0y5SkRz4wSn; Wed, 03 Jun 2026 12:37:38 +1000 (AEST)
Date: Wed, 3 Jun 2026 11:56:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Stefano Brivio <sbrivio@redhat.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	netdev@vger.kernel.org, yuhuang@redhat.com, justin.iurman@gmail.com,
	horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, idosch@nvidia.com,
	dsahern@kernel.org, Chris Adams <linux@cmadams.net>,
	Beniamino Galvani <bgalvani@redhat.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>, ihuguet@redhat.com,
	regressions@lists.linux.dev
Subject: Re: IPv6 address insertion order (was Re: [PATCH net v2] Revert
 "ipv6: preserve insertion order for same-scope addresses")
Message-ID: <ah-J1dXqU_sVAvZa@zatzit>
References: <20260529112357.5079-1-fmancera@suse.de>
 <20260529134045.56330243@elisabeth>
 <ah57wxGjL7JBORR1@zatzit>
 <da080bf1-fa2b-402a-a249-ee5ac004fb05@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XvmLXKlCb0w9QB4m"
Content-Disposition: inline
In-Reply-To: <da080bf1-fa2b-402a-a249-ee5ac004fb05@lunn.ch>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[gibson.dropbear.id.au:s=202602];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:sbrivio@redhat.com,m:fmancera@suse.de,m:netdev@vger.kernel.org,m:yuhuang@redhat.com,m:justin.iurman@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,m:linux@cmadams.net,m:bgalvani@redhat.com,m:regressions@leemhuis.info,m:ihuguet@redhat.com,m:regressions@lists.linux.dev,m:justiniurman@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[david@gibson.dropbear.id.au,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DMARC_NA(0.00)[dropbear.id.au];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294524-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gibson.dropbear.id.au:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@gibson.dropbear.id.au,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,suse.de,vger.kernel.org,gmail.com,kernel.org,google.com,davemloft.net,nvidia.com,cmadams.net,leemhuis.info,lists.linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gibson.dropbear.id.au:from_mime,gibson.dropbear.id.au:dkim,bootlin.com:url,zatzit:mid,ozlabs.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84D75633ACE


--XvmLXKlCb0w9QB4m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026 at 02:46:22PM +0200, Andrew Lunn wrote:
> On Tue, Jun 02, 2026 at 04:44:19PM +1000, David Gibson wrote:
> > I get the impression there's a rough consensus that the best we can do
> > now is revert this change (already done), and make a new patch which
> > changes the insertion order to the "correct" one conditional on a new
> > flag.
> >=20
> > Stefano has enough other fires to fight, so I'm taking a look at
> > implementing that.  Some initial thoughts, that I'm soliciting
> > feedback on:
>=20
> I've only been partially reading along...
>=20
> Are we talking about RTM_NEWADDR?

Yes.

> I've never worked on the code dealing with addresses. But in general,
> if you want to add new functionality to a netlink message, you add a
> new attribute to the message.
>=20
> https://elixir.bootlin.com/linux/v7.0.10/source/include/uapi/linux/if_add=
r.h#L26

Ah, good point, that's another option, and avoids using scarce flags
bits.  It is a little bit odd, because generally the attributes are,
well, attributes, _of the new object_ being created (an address in
this case).  Here we're adjusting where / how it is created, not
anything about the address itself.

Stil, definitely a better option that allocating a new flags bit.
Versus NLM_F_APPEND, I'll reply to Ido Schimmel.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--XvmLXKlCb0w9QB4m
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmoficQACgkQzQJF27ox
2GckJRAAp/Rom7Qqxxgv2lJyXU6YnG4KgR/0AZL28Pwlz9AwNjz+xvI7nLXUQz6T
dRjoeYf+PxCnBTRkq+Qf6Vj3xHunGVETKFe3RDbccntUhycEjIU5YXfv3mwm0rsO
EJHnD45Uaw40giPBOyirOYQiUGDWunTamtspzBijHMBrusQbav6uSGsIE8B87NaN
TL7CCnKAd5R1neRgbz7GRQcxyuHv4UZ4CbZ1Ur80iDOu6nx9q2WtKtIJliwi2JVz
aPro4dsoy5hKdDOjAD9TMFiUVXURbFWfjfdWQiMr7Tx+XBsnjuFigP5RlMN4LDhG
n62Im1hvUDjO/qWdfvvhEree3Z3a+2NlJmRMKEIV362TRNd+MM77MJ9CL5uveL4R
gE+goVp3P/mD3mV8lYFmNNsXstV5aCUzExo4U8LpxBX9JLFLtNLsPORFOg4zYNUM
qE2ClvXIrWGNbO0QjAUGCBj72QBBUAafWwgwJE3jr6pIZF/NBK2d0r052vAdsQJa
PVjM/9Wn44Rny8B0ZyS9VmYnTyS4YiBPtKEE9Xa5JGgFuU6kSOPHVvwmZ0LkyB6O
fvQGbIu5GdIg54OL9CeFFAMZANN9AglfRyP1ZqHkRp1qleIAr8snpVyqviWPHx/q
dVoa/u1FA89R0tn/yn4cKhuDU8m58VmkYucisr8iX8PjfPexAnM=
=ocnP
-----END PGP SIGNATURE-----

--XvmLXKlCb0w9QB4m--

