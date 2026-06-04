Return-Path: <netdev+bounces-295002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yeL/ELXUIGom8QAAu9opvQ
	(envelope-from <netdev+bounces-295002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:28:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B11163C318
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:28:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gibson.dropbear.id.au header.s=202602 header.b=gr47qIwA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295002-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295002-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBEF93016D3A
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 01:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4F626A08A;
	Thu,  4 Jun 2026 01:28:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4A263C8C
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 01:28:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780536491; cv=none; b=Wt0zrTjDMc0iFVcfGeaKz02zcGauwXnLqouPIvJc0aKLQzICrKWGjsyz8r3xCBesc2cDh5l8oagtjRNQCeoT/h3maIPaNSUoD8XySi1CmUS0Nvec1Q+D2d30j1lHLHxiIYgYo5OfSUs+UP9pkH4y5CHSSlfWilouGUNxuTf4rf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780536491; c=relaxed/simple;
	bh=2fEcU29Ulxu8w13YHxPVFYYYAP49xmwNvpY1X0g7OYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYmyAMAwDa335vU2MwQH/vf14RflCBMTnhnpZ1/KYrNRh3Tuy715Jvq6AT6DMgQTtGgMKP1rkEiEfx+lEtFTlrR0xO7SUnPK8s9WACUHychQzsZfSuOjAEqLRVnmCZLS3tmsu8ETO1wvO5QdJTv/At5jfIOvA9OGGJSfP7bjm6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=gr47qIwA; arc=none smtp.client-ip=150.107.74.76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202602; t=1780536486;
	bh=qmc+aIeVLzapfjJy5dGL3NPue98zdQLZBSV6ljb0IBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gr47qIwAZA5yCWnBpvroQT0aBB+A5Pbp4Y9TLFSQhfHH8WsQMpCFmT6RKIzqREdfD
	 hkXxr3W6TBCqmO56veQEFbSVxthjXO7aCyZi6hR0H4nhAD61p5dGWrjxRvMhyM3PBl
	 2i6j/cT5kUq6Cv3mAyFxEfHjMYoahzdicnZ+VA48/GgmQoFSG641123z46cobinBNx
	 gKAL7F3zJTwMbyLhs1FS4kukRGNkH48kd3hV5d9fFsV7iEhD2db/38H/JnwOxLJ+73
	 NdWNSr6C7FOzygXMPokQGIxQ/XkaLuOGCiHOrXg4AJ8lcH1UJBW1v/gXDpnxk2DJ6K
	 Bjsqh1kS0qhAg==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4gW6QG1R0Sz4wvg; Thu, 04 Jun 2026 11:28:06 +1000 (AEST)
Date: Thu, 4 Jun 2026 11:26:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>,
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
Message-ID: <aiDUMHKi2Sn1_dYD@zatzit>
References: <20260529112357.5079-1-fmancera@suse.de>
 <20260529134045.56330243@elisabeth>
 <ah57wxGjL7JBORR1@zatzit>
 <20260602132118.GA508395@shredder>
 <ah-SvHdPRrYXX6lx@zatzit>
 <20260603074717.GA569921@shredder>
 <20260603174538.5454bb93@elisabeth>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NcKP958AVt6R3vlt"
Content-Disposition: inline
In-Reply-To: <20260603174538.5454bb93@elisabeth>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[gibson.dropbear.id.au:s=202602];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sbrivio@redhat.com,m:idosch@nvidia.com,m:fmancera@suse.de,m:netdev@vger.kernel.org,m:yuhuang@redhat.com,m:justin.iurman@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:linux@cmadams.net,m:bgalvani@redhat.com,m:regressions@leemhuis.info,m:andrew@lunn.ch,m:ihuguet@redhat.com,m:regressions@lists.linux.dev,m:justiniurman@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[david@gibson.dropbear.id.au,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DMARC_NA(0.00)[dropbear.id.au];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295002-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gibson.dropbear.id.au:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@gibson.dropbear.id.au,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,suse.de,vger.kernel.org,redhat.com,gmail.com,kernel.org,google.com,davemloft.net,cmadams.net,leemhuis.info,lunn.ch,lists.linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:email,zatzit:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B11163C318


--NcKP958AVt6R3vlt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2026 at 05:45:39PM +0200, Stefano Brivio wrote:
> On Wed, 3 Jun 2026 10:47:17 +0300
> Ido Schimmel <idosch@nvidia.com> wrote:
>=20
> > On Wed, Jun 03, 2026 at 12:34:36PM +1000, David Gibson wrote:
> > > On Tue, Jun 02, 2026 at 04:21:18PM +0300, Ido Schimmel wrote: =20
> > > > On Tue, Jun 02, 2026 at 04:44:19PM +1000, David Gibson wrote: =20
> > > > > I get the impression there's a rough consensus that the best we c=
an do
> > > > > now is revert this change (already done), and make a new patch wh=
ich
> > > > > changes the insertion order to the "correct" one conditional on a=
 new
> > > > > flag.
> > > > >=20
> > > > > Stefano has enough other fires to fight, so I'm taking a look at
> > > > > implementing that.  Some initial thoughts, that I'm soliciting
> > > > > feedback on:
> > > > >=20
> > > > > 1) I'm assuming the idea here is to add the new flag to nlmsg_fla=
gs in
> > > > >    nlmsghdr
> > > > >=20
> > > > > ifa_flags in ifaddrmsg would be the other candidate, but it looks=
 like
> > > > > it's encoding properties of the address itself, not about the act=
ion
> > > > > of inserting it.  Plus all its bits are allocated, anyway.
> > > > >=20
> > > > > 2) Could we re-use NLM_F_APPEND?
> > > > >=20
> > > > > The short description of this existing flag in linux/uapi/netlink=
=2Eh is
> > > > > "Add to end of list" which sounds like the right thing.  Looking
> > > > > closer, however, it seems like what is' used for so far is things
> > > > > where the entity added with the NEW<whatever> operation is itself=
 a
> > > > > list, and NLM_F_APPEND causes it to be added to rather than repla=
ced.
> > > > > It's not used for addresses at present, AFAICT the list of addres=
ses
> > > > > is a semantic level above the address entity itself.
> > > > >=20
> > > > > So maybe re-using it for the thing I tentatively called
> > > > > NLM_F_INSERT_LAST would be confusing?
> > > > >=20
> > > > > On the other hand, it's not used for addresses at the moment, so
> > > > > AFAICT there's nothing actually preventing us reusing it for this
> > > > > purpose. That would save a bit - we only have 2 general and 4 NEW
> > > > > specific bits left, by the looks of it. =20
> > > >=20
> > > > This is not really viable. Even if the kernel is not using NLM_F_AP=
PEND
> > > > for RTM_NEWADDR, but not rejecting its presence either, then we can
> > > > create a change in behavior for a user space that is currently sett=
ing
> > > > it (intentionally or not).
> > > >
> > > > Example:
> > > >=20
> > > > https://lore.kernel.org/netdev/27c249d80c346a258cfbf32f1d131ad4fe64=
e77c.camel@debian.org/ =20
> > >=20
> > > Hmm.  So, in this example case we have a known, widely deployed
> > > userspace that was broken by the change.  Similarly with the
> > > original now-reverted "fix" for the ordering, we have a known, widely
> > > deployed userspace that was broken. =20
> >=20
> > It was also reported over three years after the kernel change went in.
> > Point is that we have no way of knowing how user space is using these
> > flags. Suddenly giving them meaning when we simply ignored them before
> > is risky.
>=20
> I think that's a very different type of issue because, there, *another*
> existing flag (NLM_F_EXCL) was suddenly given a meaning, as it happened
> to have the same value as NLM_F_BULK, and that's what broke libvirt.
> Not support for NLM_F_BULK itself.
>=20
> Here, NLM_F_APPEND doesn't share its value with any other flag, and it
> really is documented as "Add to end of list", but we don't do that.
> That's a bug.

Eh.. that's the short description in the header.  But looking at how
it's actually used it generally means "append as opposed to replace"
(which is not relevant for addresses) rather than "append as opposed
to prepend".  So in that sense we would be assigning a new meaning.

> I think it's actually more likely that some bits of userspace are
> currently broken and causing subtle issues because the author expected
> NLM_F_APPEND to actually do what it promises, but maybe they only
> tested that with IPv4.

That's possible, although I'd guess far less likely that simply
expecting insert last behaviour without any extra flag.

> Allow me to draw a parallel that looks more fitting to me: in commit=20
> 1e47b4837f3b ("ipv6: Dump route exceptions if requested") I happened to
> fix a two-year old issue that made 'ip -6 route list cache' show no
> output and 'ip -6 route flush cache' have no effect.
>=20
> You could take this to the extreme and say that it was risky to fix
> that because some userspace application could meanwhile have started
> relying on the fact that 'ip -6 route list cache' returned no output.
> I guess we agree it was a good idea to fix that, though.
>=20
> Of course there are several degrees of UAPI expectations in between,
> but *not* allowing to use NLM_F_APPEND to append objects because
> userspace might rely on NLM_F_APPEND to *not* append objects sounds
> a bit like this extreme to me, or at least closer to it than the
> NLM_F_BULK kind of breakage.
>=20
> > > That's a different case from a hypothetical userspace that incorrectly
> > > used NLM_F_APPEND on RTM_NEWADDR.  Moreover, to be broken it would
> > > need to incorrectly use NLM_F_APPEND on RTM_NEWADDR *and also* rely on
> > > the counterintuitive and inconsistent insertion order for IPv6
> > > addresses.  Absent a concrete example of something meeting both those
> > > conditions, I'm inclined to breaking that hypothetical case when the
> > > payoff is an easier route to get known cases working with the
> > > preferred insertion semantics.
> > >=20
> > > Fwiw, I did look at the most likely candidates: iproute2,
> > > network-manager and libvirt, and I see no signs that they're misusing
> > > NLM_F_APPEND in this way. =20
> >=20
> > See above. I don't like this approach. IMO, it's not worth making it
> > slightly a bit easier for some user space programs to adopt when the
> > risk is breaking other programs and repeating this ordeal.
>=20
> Another fact we shouldn't ignore is that, compared to the NLM_F_BULK
> incident, we're actively surveying userspace before touching this.

So, I second Stefano's arguments for the most part, as well as
re-iterating that being broken by this change would require the
intersection of two unlikely conditions (misusing NLM_F_APPEND *and*
expecting the "wrong" order).

That said, Ido, if you're still not convinced I can do this as an
attribute.  It's more hassle, but I can make it work.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--NcKP958AVt6R3vlt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmog1CAACgkQzQJF27ox
2GcIEQ/9HvCxKHY+qShIsybFXcsNTmuJQBwiHEgB4kOnvDYdlL1PYFVkbXlq8u7Z
Y8GlDV7JSh3tcz+HFpxtRTiLUb0T3SogSgb3FjVHj/IL21TdbQUJBKZcq1Lb0mm7
vroiH3EH449v6txTnQn1Su2B6OAZS3nwBXgOq875Na6LIcWj+YxuSX98AOmrDtOf
NsGg9Y56rAudOXF3dYqaVRFFtvJjdwl5gZFC9gzlktXVU7lCAFBRKfwOUFju0Maz
IMmJ4BI54WA96MLq2TdZa7wxJaGj35mKCUuH7nex/pk3DgwEBQzfr0WDhf3vuFSH
OqWaZnr0LiCFOHsdHacmD2X79an6bdSPD2wbvplNFT8zpJnWt23Qy5A56kLdc8mR
el+JM+LrNj9qlJsh82hXLCMW/YRDCDOQMe9ha3E8WMlE8x1vX4Fa/j9q4ECNIq1H
FiKyvp+9slBbbdqRQzartGZMx/6dgfXj29+nQCkk2CyXlmObpvx3wqw/7X7fz+N1
+XgnPo6BI4j2IOcBlsXc46J06WPGs18GodOl5VBGTIch8nnsSZPBDaok5Thar8OC
68ZbpVijyTPeH+/8F2aoCqPBmXd6km5ieTglfJWq7oeEkcUUUHox8SVI3AyQlJI5
v7KoRS3k5FZnyBUJXTDvNsWpfJqdcjvPOqmFE34FePG9FzK+JxI=
=YqG1
-----END PGP SIGNATURE-----

--NcKP958AVt6R3vlt--

