Return-Path: <netdev+bounces-292974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGMqKr8aGWoMqQgAu9opvQ
	(envelope-from <netdev+bounces-292974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:49:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 988C35FD27D
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 698A5302689E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E49938B7B1;
	Fri, 29 May 2026 04:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="T8bvynx2"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8202C36C5B3
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 04:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780030137; cv=none; b=Y8dHc70SKIuckRQW95r654ViFQFBNsc7tGKOT+aDi994Ey3RuOOnfW8vxf8eE4rifyjyWg3KziyGvWR0aCereMfFXlCE3L4tmk0A5VOX63FXuFwXhjmOEUE6/2gHlG+wKZ1GtzdXxU51aq8/hpF0lzWEOCC9Vde1b28gWb47PeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780030137; c=relaxed/simple;
	bh=DTv5cplmBDRk7pRLeksO1jRlcaX+8K9oO/BWaNGE3yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kud+80AT7/FGEHKoR8cjTGSlgdQAtxxZYB8Cc48p/si08GF4qjziVpoqGGADle4VHgkPAd0U7QgBUHqbarYgF+CF1LVr5Qg9262UMadH6oCPmYyIaqXI7pDO/h6CbDzOSSmNYnP/lMm7wAMzPEuoVpVPvUU/PMtXhr6VmJwVeTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=T8bvynx2; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202602; t=1780030131;
	bh=zeW7tmft6pCX3IFbOS6BiTs8HDp9p82gGe5kL0/Yzk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8bvynx2ttL4mbwvpFPr20sEXu3GEFgXkSvj21PL3dYPWrdA+6rRjzCfyTDMTXZrm
	 nNGtj/q9+cHGldzJFQw59CgmN3GM8yP87qI7jrf+QxKWXknT/IRScUFaE48MKj8Zzs
	 dKq9ZT6mgg/SnpqDE5rOLgCY5q3hSq4X4xbsEmZJAUC8xuGc/OSdZDhaa3ZcTJ863D
	 /a6LDSUeLERsYZJMjurgf1mp3EMnWji2UNmc1cVci8C5riHtzyXh0koOXbckuJq62t
	 49hY9PmuUNl/w5/z1T0v7c3QKhZr9esqTacDAlD2cvnqnh9zc57dJsDEmuA46bwE39
	 xyzE5QfwlJVhQ==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4gRW8g650xz4wSt; Fri, 29 May 2026 14:48:51 +1000 (AEST)
Date: Fri, 29 May 2026 14:48:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Yumei Huang <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>,
	Justin Iurman <justin.iurman@gmail.com>,
	David Ahern <dsahern@kernel.org>, ihuguet@redhat.com,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <ahkar8tE5M6u0_zZ@zatzit>
References: <20260527215135.GB16443@cmadams.net>
 <675083b4-e015-4ff3-836c-798e0a971194@suse.de>
 <20260528073849.759da84a@elisabeth>
 <baba855a-7cc9-409e-9c20-6e50f35d255a@suse.de>
 <20260528131250.1352ab48@elisabeth>
 <b21c598b-879c-4f6a-9dc8-27e5c362803b@suse.de>
 <bd669eaf-64dc-4217-bae0-4a531e473762@leemhuis.info>
 <20260528153202.14900687@elisabeth>
 <178a1a95-65bd-475b-a035-c4ebdc5ec325@lunn.ch>
 <20260528171710.1a5f6b6b@elisabeth>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nt6XStKVw0zhM1KE"
Content-Disposition: inline
In-Reply-To: <20260528171710.1a5f6b6b@elisabeth>
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gibson.dropbear.id.au:s=202602];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[dropbear.id.au];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292974-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gibson.dropbear.id.au:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@gibson.dropbear.id.au,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,leemhuis.info,suse.de,kernel.org,vger.kernel.org,redhat.com,idosch.org,gmail.com,lists.linux.dev];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:email,ozlabs.org:url,gibson.dropbear.id.au:dkim]
X-Rspamd-Queue-Id: 988C35FD27D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--nt6XStKVw0zhM1KE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 05:17:11PM +0200, Stefano Brivio wrote:
> On Thu, 28 May 2026 16:34:02 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> > > Actually, an eventually fixed version of NetworkManager doesn't need =
to
> > > know the behaviour of the kernel: it can just order addresses by
> > > timestamps instead, as Fernando mentioned. =20
> >=20
> > Can pasta also use this scheme to order the addresses? Is there a way
> > pasta can be independent of the order?
>=20
> pasta itself doesn't even care, it just inserts (copies) addresses one
> by one as returned. The kernel cares, because it preferentially picks
> the first one, as stored, within a given scope.
>=20
> The problem is that they are inserted in the opposite order than one
> would expect (that is, opposite to what's used by the kernel to select
> them, and opposite to what's done for IPv4).
>=20
> This (with an older kernel version) is quite "funny" (pasta by default
> copies everything it finds to the inner namespace):

Fwiw, a hypothetical tool which copied network configuration from one
namespace to an independent one - or which saved network configuration
to restore it later - would likely hit the same issue.

> ---
> $ pasta -6 -Ix --no-ra
> # ip a a fd00::1 dev x
> # ip a a fd43::1 dev x
> # ip a a 2620::1 dev x
> # ip link set dev x up
> # ip a s x
> 2: x: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default =
qlen 1000
>     link/ether 86:de:6b:53:5c:05 brd ff:ff:ff:ff:ff:ff
>     inet6 2620::1/128 scope global tentative=20
>        valid_lft forever preferred_lft forever
>     inet6 fd43::1/128 scope global tentative=20
>        valid_lft forever preferred_lft forever
>     inet6 fd00::1/128 scope global tentative=20
>        valid_lft forever preferred_lft forever
> # pasta -6 --config-net --no-ra
> # ip a s x scope global
> 2: x: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 65520 qdisc fq_codel state UN=
KNOWN group default qlen 1000
>     link/ether 32:d4:5b:f0:fd:50 brd ff:ff:ff:ff:ff:ff
>     inet6 fd00::1/128 scope global nodad=20
>        valid_lft forever preferred_lft forever
>     inet6 fd43::1/128 scope global nodad=20
>        valid_lft forever preferred_lft forever
>     inet6 2620::1/128 scope global nodad=20
>        valid_lft forever preferred_lft forever
> # pasta -6 --config-net --no-ra
> # ip a s x scope global
> 2: x: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 65520 qdisc fq_codel state UN=
KNOWN group default qlen 1000
>     link/ether 1a:ed:4a:27:f6:9f brd ff:ff:ff:ff:ff:ff
>     inet6 2620::1/128 scope global nodad=20
>        valid_lft forever preferred_lft forever
>     inet6 fd43::1/128 scope global nodad=20
>        valid_lft forever preferred_lft forever
>     inet6 fd00::1/128 scope global nodad=20
>        valid_lft forever preferred_lft forever
> ---
>=20
> ...at every level of namespacing, the order is swapped. Note that
> iproute2 also reports them in the order they're sent over netlink.
>=20
> > Maybe we should just make the order random, so equally breaking
> > everybody, and pushing user space to not assume any order :-)
>=20
> The thing is... the kernel assumes the order. :) But it also has to.
>=20
> --=20
> Stefano
>=20

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--nt6XStKVw0zhM1KE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmoZGq4ACgkQzQJF27ox
2GeUzw//Xf5R4KJQHrOaTwsrOX26p9q1sfPSrLIuvFNz/CVFNPk82YhD0AZ/Papb
GlKq43JUyOrdv88BWFF4Wke2p1gwsL36ATp44Ou5xYZHqwYfBE36OOdEBk5c9w+G
xXRHaTP0lnL92rKOslgXjWEIzvbRHU9qpQDNTuzon1mGJdV34tTnp8s3FHi30Hre
Lgro8xvscKUu2ywBPtRGNNl0ERMZO4QQmuEKbbiNKMOk53DC+x64xtkxaqFaPr/z
LVmiwezWwRI2YSfGMzm8BwG+JbCwmYCmyet83hWjlRTHBPtubJAUAeVtlIho/lKf
q1z47ZzpMREGJVckbrffOIUUngcpkmxNjSHZxzdmXrIwHk1VjCz1aNwVZMR25j/J
s0snNyuOUaccP+aVJE3m/ovRGJsAFz517fm98paV00rMRHRHJc2Jf5PUAwfXuGnL
jTGOo++zjMn3Ny11BnnAamWpAFOhNAZSkSXSFM5pZRav9N/7JrPSeN6D6aSCFb/e
kOg9vTLEoFWv42Y89BV8pODJohI9tLZ1hrLZZYVBbTXtwmUTm6/V/BYtWb0cy3X4
/O9PWKrUEZHizaXW1XfU/IGHGq9/kDWdlm1JS4Qf0nFbSs1/X5nqOfrm1pAX/QNq
7Gr9Y6dudQF/t5AXU7P2kcM6IR6yFMwE64Na/DNFGGguvERi8ZQ=
=yIsZ
-----END PGP SIGNATURE-----

--nt6XStKVw0zhM1KE--

