Return-Path: <netdev+bounces-194487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A207CAC9A58
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 11:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5693418820D4
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 09:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32A62376F7;
	Sat, 31 May 2025 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="yXIApW4H"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF30842AA6;
	Sat, 31 May 2025 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748685402; cv=none; b=ccVRqhjqZsD0mwGttcBJOuvv6Mt46TR/Dhc0wFj8qQ1YouJVmiZITx3KXDc/VBFH13ODgVmTIZjLvKL1TItWO+5pJbJAtbtpwh3idmftbVOHOL5ZEdTva9khC7fxLAjsZdacgTlRjwIZlSdAvVzVjoIkhU9Srswfh5UWW56XdDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748685402; c=relaxed/simple;
	bh=YH4FPc4zPeMtJdswC/DmhVLJXooDCtARO8fEo50NAeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F88gSF1lCq24CVjM5mAAEqIqQZ27VwrZAoGzrQLD/tkjPJvqoBCLP4w7XYWZ07N3W/+vBVeyjk/a5WD5gMvBHhbj+fdph8DkW8+EkhuUgWZPwEB/y2hQGMg31FAcElIhStjKXvOhba4v6gRQ9AotrjhtsDQY2Z3MjdmyOAmmMkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=yXIApW4H; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1748685398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esolGE2tSmNnPRF4uWyr6841H7n9QIGFhdDzJ0qYsmo=;
	b=yXIApW4HetJxcCx6PbYU2Q6MGzczG2zPhjkkhokn3Wrk5Q5F4MdxlWKesADIWWmNJOo548
	VcTUqqQG9FvvAsjfF6eMVXMn93YX68dm4KK0EIhzX4oFIXTPlPCQpS6l35GJoMhqqPuOgJ
	OUwp+cRrPEtZrF570WH7O4K/For/0DM=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Matthias Schiffer <mschiffer@universe-factory.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Matthias Schiffer <mschiffer@universe-factory.net>
Subject: Re: [PATCH batadv 4/5] batman-adv: remove global hardif list
Date: Sat, 31 May 2025 11:56:34 +0200
Message-ID: <4860101.CbtlEUcBR6@sven-desktop>
In-Reply-To:
 <262d5c5a5afe3d478d2e65187c0913a3a8c4781f.1747687504.git.mschiffer@universe-factory.net>
References:
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
 <262d5c5a5afe3d478d2e65187c0913a3a8c4781f.1747687504.git.mschiffer@universe-factory.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6384946.cEBGB3zze1";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart6384946.cEBGB3zze1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH batadv 4/5] batman-adv: remove global hardif list
Date: Sat, 31 May 2025 11:56:34 +0200
Message-ID: <4860101.CbtlEUcBR6@sven-desktop>
MIME-Version: 1.0

On Monday, 19 May 2025 22:46:31 CEST Matthias Schiffer wrote:
>  struct batadv_hard_iface *
> -batadv_hardif_get_by_netdev(const struct net_device *net_dev)
> +batadv_hardif_get_by_netdev(struct net_device *net_dev)
>  {
>         struct batadv_hard_iface *hard_iface;
> +       struct net_device *mesh_iface;
> =20
> -       rcu_read_lock();
> -       list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
> -               if (hard_iface->net_dev =3D=3D net_dev &&
> -                   kref_get_unless_zero(&hard_iface->refcount))
> -                       goto out;
> -       }
> +       mesh_iface =3D netdev_master_upper_dev_get(net_dev);
> +       if (!mesh_iface || !batadv_meshif_is_valid(mesh_iface))
> +               return NULL;
> =20
> -       hard_iface =3D NULL;
> +       hard_iface =3D netdev_lower_dev_get_private(mesh_iface, net_dev);
> +       if (!kref_get_unless_zero(&hard_iface->refcount))
> +               return NULL;
> =20
> -out:
> -       rcu_read_unlock();
>         return hard_iface;
>  }

This code is now relying on rtnl_lock() (see `ASSERT_RTNL` in=20
`netdev_master_upper_dev_get` and most likely some comments somwhere about =
the=20
lists used by `netdev_lower_dev_get_private`). But `batadv_tt_local_add` is=
=20
using this function without holding this lock all the time. For example dur=
ing
packet processing.

See for example `batadv_tt_local_add` calls in `batadv_interface_tx`. This=
=20
will happen when `skb->skb_iif` is not 0 (so it was forwarded).


Please double check this - I have not actually tested it but just went thro=
ugh=20
the code.


And saying this, the `batadv_hardif_get_by_netdev` call was also used to=20
retrieve additional information about alll kind of interfaces - even when t=
hey=20
are not used by batman-adv directly. For example for figuring out if it is =
a=20
wifi interface(for the TT wifi flag). With you change here, you are basical=
ly=20
breaking this functionality because you now require that the netdev is a lo=
wer=20
interface of batman-adv. Therefore, things like:


                   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90            =20
       =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BCbr-lan=E2=94=9C=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90     =20
       =E2=94=82           =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98      =E2=94=82     =20
       =E2=94=82                         =E2=94=82     =20
       =E2=94=82                         =E2=94=82     =20
     =E2=94=8C=E2=94=80=E2=96=BC=E2=94=80=E2=94=90                    =E2=
=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=90   =20
     =E2=94=82ap0=E2=94=82                    =E2=94=82bat0=E2=94=82   =20
     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=98                    =E2=
=94=94=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=98   =20
                                 =E2=94=82     =20
                                 =E2=94=82     =20
                              =E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=
=E2=94=80=E2=94=90  =20
                              =E2=94=82mesh0=E2=94=82  =20
                              =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98  =20
                                       =20
                                       =20
Is not handled anymore correctly in TT because ap0 is not a lower interface=
 of=20
any batadv mesh interface. And as result, the ap-isolation feature of TT
will break.

Kind regards,
	Sven
--nextPart6384946.cEBGB3zze1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaDrSUwAKCRBND3cr0xT1
y1CLAP0XdjoI2bffn1RBFQJQ9/80BKTDk7uFDARhT1LU3ccLXgD/VigawRbVt5L8
GQJphRNf9pct+c3yAGqgAEw2JOpY7wA=
=BNYO
-----END PGP SIGNATURE-----

--nextPart6384946.cEBGB3zze1--




