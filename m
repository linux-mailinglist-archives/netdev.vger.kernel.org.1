Return-Path: <netdev+bounces-196715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96806AD60A4
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 23:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 116587A9BE0
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303F023ABB9;
	Wed, 11 Jun 2025 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="267jpaH2"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D619A
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675846; cv=none; b=uYm4efD8blzulyPPJpMPAhutJYQ4amiPGczp7O8J+d9ZrddE74Vjuw/adYNFrufCx/ddRnvqiHcRtNusKW51wnbX6Oobj/5uHdvRVatkDPF+xWV8OffoDzWndmt9XxqABxXA15atJjCDv0P3SaiyMfOLptdXvL+zQfu3D7avtZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675846; c=relaxed/simple;
	bh=X/oNfTwVvxRJTvcY4bXWod49oQGk+6oqNSmx+lW1Eek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/ZuWIuuFS91aqO/41E3TtblPEx/sgiQp/gkqh11+BpHz0Gd6jYQ8zqUyqxFAwNUQXNo3qfbCM9wLGP/dwWD/EEF2vYgVMyGySy00pe4vzk51ixcxx4OLj7f1GUA7Net87hIIELZtvvZUDs2ZAUMx381AH19IPQdgVNfA0KDepw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=267jpaH2; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1749675836; x=1750280636; i=christian@heusel.eu;
	bh=7kQRjfdNymvaTbY6Xo18TtLrInSfaTRdm5FoPKzCOVY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=267jpaH2NOlgAZbYQW4ozmGlaPWV2kw9ZoneQZstzpNdijQIDvuGeJBPL8or0sEv
	 1/9Tw80ziXzimAdVILnLkiN82HpSUSDQHywMG9eJXnI1CDib9f4MME6r5n6R55N+l
	 9ClzQ3n02KYG5bbb9Ruan3veuAZXOnCsL+pYwdYm2Xe/X35JBDCEOOQS2okAwJ0mW
	 LUsrgqQdh2auRBo2xAPYPjNnCA5FHEhfm02/6ltCCIgresC9KMidCk43ZpkonXZ+F
	 viKQSzNvZLezd6EF6aJhBcUN0eOIEAMv1zh9oCtT+8Ajmo2S86t6+GGjQIvu5TZPB
	 q160cjI5Y7gAUDUpRw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([89.244.90.56]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MJn8J-1u5JC92FPF-00Xcpj; Wed, 11 Jun 2025 23:03:56 +0200
Date: Wed, 11 Jun 2025 23:03:52 +0200
From: Christian Heusel <christian@heusel.eu>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, 
	netdev@vger.kernel.org, Jacek =?utf-8?Q?=C5=81uczak?= <difrost.kernel@gmail.com>
Subject: Re: [PATCH v1 net] af_unix: Allow passing cred for embryo without
 SO_PASSCRED/SO_PASSPIDFD.
Message-ID: <a7a96192-9c45-496e-9bd5-130c6e4f7365@heusel.eu>
References: <20250611202758.3075858-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3omltpkik7q4a6ln"
Content-Disposition: inline
In-Reply-To: <20250611202758.3075858-1-kuni1840@gmail.com>
X-Provags-ID: V03:K1:iz+UjK40YL+GvkHBuFy0BapJhMJUjvOFI3iZkXMlIkp/p6Zhh0c
 4Tl472PPXZhVw6kspzBw4wHo25SPgmiGPfUuzmBBpzwl6tyx5uOFh2EHMw1EdpVv8ISIMNu
 7aibhAHoB01fSJibqIRp/G/C1xpW3E23OwFLPqD4Aq1+FpGMZ+3oGq9u8MZbogKa22U4WG0
 hGWHibq2BY3vO6bQVyAgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W2r+fwJIYS4=;IV4yrVYZk8Mt5boQkpweI1RZFKv
 cCoyr94R9qEz6qWMjANkhr5pqvJPE0On8hBI6cZrnDWnD4i0gA0aIaE6im2Gc3GGNiczT+hlh
 t0nmKliiKaZQZ+MWtFApNHgWaLkzyaP/tcVukNaobmsGtyz4IL6kWiTeZ9FJmfUJdoAXouYZG
 63LvN91MSWBSGMssJ6uvD99cGiwomKbpE6oTMBjz69iutgDZeKobzHjkUPO8+FeTkUPP4jqLf
 H8EYaGDW+0927Z0hIIZYFk484qzX+WaTHzJgTwgF01nfhknR4H3pV4pmYNtyTZp4wI+g32FeT
 /7zYu0JJSjqVdjb5NdNCD5dWAJYzaSXU0/MSQFEMf822wIRQgPmyz8O5VCk4iJzSTR3aXvkEx
 ifmXyNblLB7bnBetrXldfv6u7Woqu7VoYJPd74C0WEnhYM0WCg+J3TlXgmYUtqemRQNPBE7ul
 Zs/InM8Y3u+EHGgV+RcH/FpnH9Nt0v3HdDrOdkyC2b0+NB/HHh+gksh/eCuWswiewVKpqNqw1
 JgxHQuOVStRMfpWbqcobupx1rlWhIxgY1jqYKi+DpvUjHYIkHrLK658E3Epg7K6TuMts05vBY
 hPj4EWFng4gVliaUlTbq5pUuQpYWpVUM0sG+ZymR1uUca4x3wOF0WiZkRlzsUROilMtm2LbPl
 6YeJ+ec0sv+71+J8rwP/hJkAAtuXxcz0n35YrGWpiOhVOodoFkWo9snqlzwmOr1z566xWoMPP
 sticnBevkVtbn0U33/jTwcZymabxzYoyDtJjcwZhrcIj92owYgamFfMRts3dOgEpH7+8YbXba
 vuKsl6FqTrh5ecJuUxISWMNv5R3w6wEv7AVfJwr4fKqmSHFNE9oepnMs2mf61BZNesE0UbCMW
 M/ltJ+wUefyITjYGvZwZyc2Q9bhsQHH4U8Al7eAxoRUsJ/54ubZThbOivtZITgM8seCgDDS7u
 OdKS69nb50iXelT7bxyo/S/GxmibmrDRFyeWVDo6xIRZkTRNFsku8fRwXjjxEK6axI85qnY2t
 w9IQ5QecO2VTT/Pd3mSY3suwFfta7K5ydYRVOje/s7n7/KXL0O3QyKSzT2gf+0aVgvDm3zSYn
 fC+zo+fsoi1SWx6HttXQ4VbF9a+ngXirbbPmzyl1Hy4N8aQCluaCOUN24oB125wIuYDzgrGvn
 g24iGqgkuwFyNxtsyi7jpRa/8csRk3hql+C95Av832s/dS7ibrMGVRDkC6GYZ4c+fmRCICSJb
 6teHz2NS5su+ThqLi1JVHZidW4Zi2JyPJX2AqQsNCj83jfdMao8gtRPt/8scFxxULZ0GSk6m3
 c5W56E+BRrKl5izI0Gu+qrve451esPhPDdu1ZB7YgM1KffK6i2AHjP/Ob6JIaYNuK43a8PhQZ
 NEFByQ1l4zzuZ3XK1qwoGQLwosXgxFF4qEmfXsBUNl6vKW0hUzpALFs2HbzJ55RBoyKNgMY4U
 00b2Ucg==


--3omltpkik7q4a6ln
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 net] af_unix: Allow passing cred for embryo without
 SO_PASSCRED/SO_PASSPIDFD.
MIME-Version: 1.0

On 25/06/11 01:27PM, Kuniyuki Iwashima wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
>=20
> Before the cited commit, the kernel unconditionally embedded SCM
> credentials to skb for embryo sockets even when both the sender
> and listener disabled SO_PASSCRED and SO_PASSPIDFD.
>=20
> Now, the credentials are added to skb only when configured by the
> sender or the listener.
>=20
> However, as reported in the link below, it caused a regression for
> some programs that assume credentials are included in every skb,
> but sometimes not now.
>=20
> The only problematic scenario would be that a socket starts listening
> before setting the option.  Then, there will be 2 types of non-small
> race window, where a client can send skb without credentials, which
> the peer receives as an "invalid" message (and aborts the connection
> it seems ?):
>=20
>   Client                    Server
>   ------                    ------
>                             s1.listen()  <-- No SO_PASS{CRED,PIDFD}
>   s2.connect()
>   s2.send()  <-- w/o cred
>                             s1.setsockopt(SO_PASS{CRED,PIDFD})
>   s2.send()  <-- w/  cred
>=20
> or
>=20
>   Client                    Server
>   ------                    ------
>                             s1.listen()  <-- No SO_PASS{CRED,PIDFD}
>   s2.connect()
>   s2.send()  <-- w/o cred
>                             s3, _ =3D s1.accept()  <-- Inherit cred optio=
ns
>   s2.send()  <-- w/o cred                            but not set yet
>=20
>                             s3.setsockopt(SO_PASS{CRED,PIDFD})
>   s2.send()  <-- w/  cred
>=20
> It's unfortunate that buggy programs depend on the behaviour,
> but let's restore the previous behaviour.
>=20
> Fixes: 3f84d577b79d ("af_unix: Inherit sk_flags at connect().")
> Reported-by: Jacek =C5=81uczak <difrost.kernel@gmail.com>
> Closes: https://lore.kernel.org/all/68d38b0b-1666-4974-85d4-15575789c8d4@=
gmail.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/unix/af_unix.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index fd6b5e17f6c4..87439d7f965d 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1971,7 +1971,8 @@ static void unix_maybe_add_creds(struct sk_buff *sk=
b, const struct sock *sk,
>  	if (UNIXCB(skb).pid)
>  		return;
> =20
> -	if (unix_may_passcred(sk) || unix_may_passcred(other)) {
> +	if (unix_may_passcred(sk) || unix_may_passcred(other) ||
> +	    !other->sk_socket) {
>  		UNIXCB(skb).pid =3D get_pid(task_tgid(current));
>  		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
>  	}
> --=20
> 2.49.0

Tested-by: Christian Heusel <christian@heusel.eu>

--3omltpkik7q4a6ln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmhJ7zgACgkQwEfU8yi1
JYU19xAAgnDvJ2VrhrdVI2ra0MlvKv8EEp1Jga1UBd5wGUBDiyB3HNiTkKSLshJ8
37QE+PVZHtABva176eda22//9VZsw/tpZuplMQdBDaa2CcdgrJvvevjgrF4fG7pU
3ybKVkXHnn8t4wWGCbj6tRtEd9WNAj/uaC+yrUwLqReAAZsFF/WTakdD2DPBJg0c
p6x/AJ89X3vIImwbBQhpbotwGdXFFD2xZPFbvD+DHlseplX2mLKOQUY9JKsOgo8z
pJ2wgH4vf02yqVg1n3tDQnXvnMkFCA1I3Lpc7GQDP7AOCuB7fjpVMn1KHB0tvl0P
PsQFmvNH2FG1/JZKKXU+2hjxRly6XPk3lLEOB2d02FJ5FE4lDCDy5bcfnli0dg5h
KTXA9QLrJu/+C30OgsQPakNKPqxSfYRRwyt+ofgKqJVB/RuLLERqeVC3Pf4xGBGE
HXHWw2oxQJC5zPxiEG5DvjfFiZb6bA2IgttfCX8ctx0hzMhA6k8bzpxwnG68QTxj
vKXwN5DJxoM+U/HwNUX4fmXu9JTzJKb8kTNnn5sCStf7Bh85l63SqXfMIkFt4zcc
s70780TcipcQ27jtuADzf1RQEXlk3bjwbkYAOyXs/tMnyb0nG3HL9H4M0s7b0wuZ
HS+XQsrjrUXh+J6GBSC9tse0BzWivm1vH/1gFWF5/cRYIWqECBw=
=FKxS
-----END PGP SIGNATURE-----

--3omltpkik7q4a6ln--

