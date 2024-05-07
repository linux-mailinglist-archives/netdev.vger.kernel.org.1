Return-Path: <netdev+bounces-94140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 573808BE585
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E127B2B464
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01920161318;
	Tue,  7 May 2024 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="Qxob4DHZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79183156C6B
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091016; cv=none; b=aibZi2OZn8r6Wq9R8nJ38sGi3DBm0lHXHR8OqCaSY/ADb8WqmS1Hukv0nm7Ry+2r027SREO2slsJ/D71vNiw5vsP+ILaYzAGTFbe7NFDC/bfJSIjKjLUeQSaKGm0a4DUegNyJhiHpOA3rxtNmObTB3EdL7HH6W8yDDhOz9Mqsck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091016; c=relaxed/simple;
	bh=Aw+k2LTWav+voxJYA+mYYDD9NA+sEEjl31+IivmaMYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lh7h8+c7q5KHfnVcFoRE5UfWIJOtPE8aJnF14zLOrFHjUdmumpOJ6hA/TRWG1ATnQXpoQgthj9tsd9BChbGg07atgBmzV38lDn1SxeTXyuThDYk4cfYRO/tHfpDEs0MxPJbV076aV39x3VdgnJ9ndjey7iOgYqT4YL4ZPkoyOxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=Qxob4DHZ; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from localhost (unknown [IPv6:2a02:8012:909b:0:3397:4b77:9703:8b53])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id BC5CD7D8BA;
	Tue,  7 May 2024 15:10:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1715091012; bh=Aw+k2LTWav+voxJYA+mYYDD9NA+sEEjl31+IivmaMYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:From;
	z=Date:=20Tue,=207=20May=202024=2015:10:12=20+0100|From:=20Tom=20Pa
	 rkin=20<tparkin@katalix.com>|To:=20Jakub=20Kicinski=20<kuba@kernel
	 .org>|Cc:=20netdev@vger.kernel.org|Subject:=20Re:=20[PATCH=20net-n
	 ext]=20l2tp:=20fix=20ICMP=20error=20handling=20for=20UDP-encap=0D=
	 0A=20sockets|Message-ID:=20<Zjo2RHSzCW2xGv7k@katalix.com>|Referenc
	 es:=20<20240430140343.389543-1-tparkin@katalix.com>=0D=0A=20<20240
	 503153214.3432d313@kernel.org>|MIME-Version:=201.0|Content-Disposi
	 tion:=20inline|In-Reply-To:=20<20240503153214.3432d313@kernel.org>
	 ;
	b=Qxob4DHZiwlbUtvoXLuFklcMVfe9EoYRZH1UXZ9rTyC5D+TRyQN3dB8mxIcf7+QO7
	 k2LU+YkXALtY7m1up3dyag9ws+3ZH+6BDkCwHLtyUi8sSIO2WhTphAHNJSIO9GL+xd
	 2DUsEOcrnHjuOBeSjw2Da49gTeGlpW9C6Xcew5NZE06w6kMO/J62RMN7kJjsIBZCST
	 JFrAlNQ07xQZreyf1WjnDI+YJG8u2RkGl9Beki4Hy23B2QWnW/DuHQpGSLiA4bOjfR
	 cu0gP/2LduvHGvK/MIEEqqtiU36vCbOrCoI38UK6bBx7rPqccST9HJPuVj5JkeSzDk
	 niSfat9PM6yYQ==
Date: Tue, 7 May 2024 15:10:12 +0100
From: Tom Parkin <tparkin@katalix.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] l2tp: fix ICMP error handling for UDP-encap
 sockets
Message-ID: <Zjo2RHSzCW2xGv7k@katalix.com>
References: <20240430140343.389543-1-tparkin@katalix.com>
 <20240503153214.3432d313@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZnqshFQ+uiXDkO8j"
Content-Disposition: inline
In-Reply-To: <20240503153214.3432d313@kernel.org>


--ZnqshFQ+uiXDkO8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks Jakub,

On  Fri, May 03, 2024 at 15:32:14 -0700, Jakub Kicinski wrote:
> Seems like we should target it at net? Description indicates it's=20
> a clear regression.

Ack, I'll respin for net.

> not: the !tunnel can't happen, right?

Your question makes me realise that l2tp_udp_encap_err_recv is being
called in the same context as l2tp_udp_encap_recv, and so should be
using rcu_dereference_sk_user_data to access the tunnel handle rather
than l2tp_sk_to_tunnel.

I'll fix that in the respin.

However I note that l2tp_udp_encap_recv also checks for the tunnel
handle being NULL :-|

> nit: mismatch on the braces here, this would be more usual:
>=20
> +	if (ip_hdr(skb)->version =3D=3D IPVERSION) {
> +		if (inet_test_bit(RECVERR, sk))
> +			return ip_icmp_error(sk, skb, err, port, info, payload);
> +#if IS_ENABLED(CONFIG_IPV6)
> +	} else {
> +		if (inet6_test_bit(RECVERR6, sk))
> +			return ipv6_icmp_error(sk, skb, err, port, info, payload);
> +#endif
> +	}
>=20
> +}

Thanks, I will fix this.

--ZnqshFQ+uiXDkO8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEsUkgyDzMwrj81nq0lIwGZQq6i9AFAmY6NkAACgkQlIwGZQq6
i9Ccrgf9EJH+wRskXJDM1MJbW6raZYQZ7CSHsiKiXlNe0tiWTiE9E9+jqPUh8DEL
KLGs5cFA27UFwArwguEjn+6WkTpGhTF6MwoC9fqCwLmPOpoHq6o0ONx0W1WPoVaP
U0erYGHG1XchAM5kYV7Sx8+o2bcTnCILFtLgTu2hmSU5Vg4wriEt7twSMfF9Y/xL
EozQmsOibZHMRliWCDXQ4OjYlzuvthoDgijduI0YIf8s3MeZkNtEI1sVxKPhQA1g
+6A288jVLh64i6YTFm1rlnLv6zPr/aI+qVPCdHcA9uy2+1jqir//kMJjZ3qLJReG
CVEPhdcg6sVuJU8zpMXzYpdDNtTEeg==
=lmIH
-----END PGP SIGNATURE-----

--ZnqshFQ+uiXDkO8j--

