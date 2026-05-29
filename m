Return-Path: <netdev+bounces-292973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KChnB7kbGWrwqQgAu9opvQ
	(envelope-from <netdev+bounces-292973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:53:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6999B5FD2C9
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 504473009F85
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE8D38AC9E;
	Fri, 29 May 2026 04:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Q4SGKjs3"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8216C374192
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 04:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780030137; cv=none; b=KhgiKg9M5znfICOClsxLp7iv0naMg129hdG609ndRUJ81dYbuyfySeUp1NQ+Z9pu8zhMhpJctpGFPHEy9M/GfmsAza5oFXez2rgsoKjeWY+rWAfzFqOwDXrnJMuFX8r4YmG1nSFCvRJdgMJ1x9miHQ5FgG21TrpbJdDcldgo+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780030137; c=relaxed/simple;
	bh=lG71ZW/mAZCSImoxb39bdHRBq5VhWkIrVv9a+8jiYbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWAffDLQYM8RAtuQqqn6heMXcRThYV3nrH/RGqgLn+w9yT6NVmDWFfVMgPMWEQpmtPP1XtpqOEWfDGcJ+nOVG4bN8MZQ4Xc63fautYuMHTj60R/UaubEpX9q4t+h4MCmEi87wAFwpVXhrL60AqLI6nOxXnYSojkwKqIr9WOF35w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=Q4SGKjs3; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202602; t=1780030131;
	bh=nN0JCCcErYWCK65M14oqLgaSf5ucJQDG/nR4CSrY7Lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4SGKjs35h82lLNdNPCbRej1gFIMdtksgu2Fwg6Mko9g3Rgvyv6Uiss7aVms19h49
	 KZRZzByiY0ix5toOARkcadvpspMXEKWqVXAIbICgyZlhTo/OBmW8h4wED5nVrBX23d
	 o4ZaSU/aFn/Rv5Y62rEsK6nWs3BCnKF1toz63tVCkxKvwCm6Cr2Khr/FdL5GZxihOv
	 TzBYcT/gzmhxdsXDYvkZ6TaWX8QdgTSGS4+pYWijc6fhXgrj4wbplVMZwIzTA6M02J
	 nNAWjmYbprkOYvWRdBoHor5zhAP8fHo0SvNsPTzSMTOOzOXjgYEAesDSFrwF1WeR0s
	 t+hcULtlMgP3g==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4gRW8g5x2Qz4wTH; Fri, 29 May 2026 14:48:51 +1000 (AEST)
Date: Fri, 29 May 2026 14:47:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	Beniamino Galvani <bgalvani@redhat.com>,
	=?iso-8859-1?B?zfFpZ28=?= Huguet <ihuguet@redhat.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Yumei Huang <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>,
	Justin Iurman <justin.iurman@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <ahkaRG2uFPThVFNA@zatzit>
References: <bd669eaf-64dc-4217-bae0-4a531e473762@leemhuis.info>
 <20260528153202.14900687@elisabeth>
 <CACT4ouf5ZqGgb=RO8_7NovLCvYKLKL4vD70dEe6xUODT1UEcSA@mail.gmail.com>
 <20260528165320.15b90ded@elisabeth>
 <CACT4oue2EMM9Kfsm9Jii2rG9ooi=D37PK=8886cpLuBkwhrOxw@mail.gmail.com>
 <ahhm1-XfnsWyIWDV@tp>
 <20260528192143.31c9e9ea@elisabeth>
 <ed954836-742a-44c3-8c2d-65dd06c3514e@suse.de>
 <e91507d6-cbfc-447c-8236-d9b3d91f18c5@suse.de>
 <20260528212213.4aa613f8@elisabeth>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZnZSkSTMcSQutOYd"
Content-Disposition: inline
In-Reply-To: <20260528212213.4aa613f8@elisabeth>
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gibson.dropbear.id.au:s=202602];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[dropbear.id.au];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292973-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gibson.dropbear.id.au:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@gibson.dropbear.id.au,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[suse.de,redhat.com,leemhuis.info,kernel.org,vger.kernel.org,idosch.org,gmail.com,lists.linux.dev];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gibson.dropbear.id.au:dkim,ozlabs.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6999B5FD2C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ZnZSkSTMcSQutOYd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 09:22:14PM +0200, Stefano Brivio wrote:
> On Thu, 28 May 2026 20:50:48 +0200
> Fernando Fernandez Mancera <fmancera@suse.de> wrote:
>=20
> > On 5/28/26 8:42 PM, Fernando Fernandez Mancera wrote:
> > > On 5/28/26 7:21 PM, Stefano Brivio wrote: =20
> > >> On Thu, 28 May 2026 18:01:27 +0200 Beniamino Galvani
> > >> <bgalvani@redhat.com> wrote:
> > >> =20
> > >>> On Thu, May 28, 2026 at 05:24:28PM +0200, =C3=8D=C3=B1igo Huguet wr=
ote: =20
> > >>>> On Thu, May 28, 2026 at 4:53=E2=80=AFPM Stefano Brivio
> > >>>> <sbrivio@redhat.com> wrote: =20
> > >>>>> I think what's considered UAPI in this case isn't so clear-
> > >>>>> cut. I guess it would have been pretty hard for anybody not
> > >>>>> familiar with NetworkManager's codebase to imagine that an
> > >>>>> application would rely on IPv6 addresses (and only IPv6) to be
> > >>>>> returned in the reverse order. =20
> > >>>>
> > >>>> IMHO it's not because an application would rely on the order.
> > >>>> It's because the order matters, as the first one is considered
> > >>>> the primary. =20
> > >>
> > >> Yes, that's also the case, but:
> > >> =20
> > >>>> This is not NetworkManager specific. Or I am mistaken? I'm
> > >>>> speaking by memory =20
> > >>
> > >> ...from what I understood of the issue at hand there's a part that's=
=20
> > >> specific to NetworkManager here, because NetworkManager replaces /=
=20
> > >> deletes the Privacy Extensions addresses, instead of different=20
> > >> addresses, because it relies on that specific (reversed) order.
> > >>
> > >> Anyway, yes, I see your point about UAPI now.
> > >> =20
> > >>> Yes, exactly. If you do:
> > >>>
> > >>> ip addr add dev X 3fff::1/64 ip addr dev dev X 3fff::2/64
> > >>>
> > >>> then the old kernel chooses the address that was added last as
> > >>> source address for outgoing communications. With the new kernel it
> > >>> chooses the address that was added first.
> > >>>
> > >>> I think that any script or network management tool that cares
> > >>> about the source address selection is impacted. Indeed, the commit
> > >>> had effects on one of the selftests, which had to be modified to
> > >>> change the order of iproute2 invocations.
> > >>> =20
> > >>>>>> If the fix must be in NetworkManager, we only need to parse
> > >>>>>> them in non-reverse order like IPv4, I guess. =20
> > >>>>>
> > >>>>> But that would then require some form of detection, and, at
> > >>>>> least according to Fernando, isn't the most robust option
> > >>>>> anyway, as ideally NetworkManager shouldn't rely on the order
> > >>>>> at all. =20
> > >>>>
> > >>>> True =20
> > >>>
> > >>> Correct, if the new behavior is considered better, there should be
> > >>> a way to detect which order must be used. Otherwise userspace
> > >>> tools won't be able to maintain the same behavior with different
> > >>> kernels. =20
> > >>
> > >> My remark here is about whether NetworkManager needs to detect this
> > >> at all. If it used timestamps to detect recent / older addresses, as=
=20
> > >> Fernando mentioned, then you wouldn't need any detection at all,
> > >> right? Or is there something else we're missing?
> > >> =20
> > >=20
> > > Ohno. Now that Beniamino and I=C3=B1igo mentioned it, this will likel=
y break
> > > many other environments. In essence, many tools relies on the previou=
s=20
> > > ordering to identify which address is the primary one.
> > >=20
> > > E.g cloud tooling communicating with the metadata server via IMDS(v2)=
 to=20
> > > configure IPv6 primary and secondary addresses. They are likely relyi=
ng=20
> > > on the ordering for that.
>=20
> I haven't seen any tool specifically relying on insertion order for
> this so far and I'm having a hard time believing this kind of tooling
> wouldn't rely explicitly on home / care-of addresses or different
> labels -- see RFC 5014 and RFC 6724 Section 5. (or, perhaps clearer,
> the examples in section 10.1, in particular rule 4. and rule 6.
>=20
> But I'll look for more convincing examples in a bit (maybe you have some
> at hand?)
>=20
> This is all implemented by __ipv6_dev_get_saddr() and friends, by the way.
>=20
> > > So maybe we could fix whatever is wrong with NetworkManager and=20
> > > temporary addresses order but I don't think this will scale for the=
=20
> > > cloud tooling with the primary/secondary issue.
> > >  =20
> > >> By the way, if really needed, one could detect that with the
> > >> equivalent of:
> > >>
> > >> ip a a ::2 dev lo && ip a a ::3 dev lo && [ $(ip -6 -j a | jq -rM '.
> > >> [] .addr_info[0].local') =3D ::3 ] && echo wrong || echo right
> > >>
> > >> ...depending on the application, that's not necessarily practical,
> > >> but so far we have no evidence of any application needing to do that
> > >> at all.
> > >=20
> > > Plenty of tools (NetworkManager included) uses netlink so this isn't=
=20
> > > useful for them.
> > >=20
> > > For now I am more in favor of the revert and to look for an alternati=
ve=20
> > > for pasta situation (like using a flag or something). But I am not a=
=20
> > > maintainer so it isn't my call :)
>=20
> One question I started wondering about later is: should the flag affect
> insertion or reporting, in case? I think we would need one for
> insertion, otherwise it's not really generic / functional.

I'd certainly agree.  The bug? oddity? inconsistency? is on the
insertion side so the fix should be on that side (whether or not it's
conditional on a new flag).  If we "fixed" it on the reporting side
we'd instead be creating another bug that cancels its effect for some,
but not all, purposes.

The idea of NLM_INSERT_LAST seems marginally less ghastly to me than
NLM_F_DUMP_REVERSED, though I'm not sure I could articulate why.
Perhaps because we could also allow the former for IPv4 too (as a
no-op).

> > *facepalm* I just noticed the "with the equivalent of", disregard this=
=20
> > last part tho.
>=20
> Right, yeah, having a netlink implementation makes that a bit more
> convenient. :)
>=20
> --=20
> Stefano
>=20

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--ZnZSkSTMcSQutOYd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmoZGjUACgkQzQJF27ox
2GfNrg/+MbEJ830DBfzPe6JSYtnECD0TZWJTfQSg7zxog79AOfy7ETd8Qwtq/Ifa
oYtZKJOfrRZcZM+C3ZKUiQvXXqQ6c3CPdeBrbL8sDGexNbVF19LJ7+Jr19HVeMU7
LJXuyQeaSjESq/Z+VDPSVhoSaHCzt4Z3mcN7dFAw2Gik4yrZKq5sjfP4i0+EhsqZ
+Y73v1n218T6LK09o4ezVg/bNkaxl4BNe4kzTlE/oCWuSVMMbckNj1iAvQbKHe6w
3pO7Ph/PTdz8ufSskU7gwxTqnCinqH2tTQI/KaXUeY8Z5AarP/RVfWbmYWqOrJ0a
HMRkiJMnG0pfjhG0qsG78qU2cXk5NapwOlWgNAD3cNixdjnY3/iR2E4X5rgkAexa
lYwSy0tpdzpsZ/TCUNWqwro1Ue1JZ3JFXgTtSAeKv19NYGymlxmYHzoa0Gxy120x
F/qSlAPeiMHyiMauXldkYiVUgWtpy8OiuPQJepgemxp8MBauT+CRhyQilv5uB9YG
yDiJ3mX+iJ1MrPgRpi8Y+zBvjqaJp8nj32QLx45uwlp9M6zIAbLmCwxWhQWIWI7K
mWha1Q9JzIj4wP7uj83vgIeDXqR1GCFyFOEpi9wbuJ+oUJYV0Bioco4kRcMV460v
IG2Z9bdo106cmcvJbnUDImAltIR9k199CS+ps2IZvtZIl7q4Uco=
=tF7X
-----END PGP SIGNATURE-----

--ZnZSkSTMcSQutOYd--

