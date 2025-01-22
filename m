Return-Path: <netdev+bounces-160304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20D9A19342
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 15:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A4A16BC43
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34647213E81;
	Wed, 22 Jan 2025 14:04:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD52213E70;
	Wed, 22 Jan 2025 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737554645; cv=none; b=r5syWr5ZTdKOAm7qsxWmEvfl+U7bb8ykg3M4MtXG54zIn2PUEHNirSgD6PsUl8EbF+a8Iu1ShfX9v4Tl/c81UzsIae4B20AAUA/5Wu2nO2tOPARFL6GrQ9wXqAnYpN9hmFXKtrtIbloazAqFwnbvwp66vXgVFZTmB7HACIQAu4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737554645; c=relaxed/simple;
	bh=3UidXrvXAd5crjan99AuQxxbHPMkhur6AIYToCRQPMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hfb4qH3dL+M2PNLIWvOxG4dig1YNhzM7FnPzVeuYsgq5bB+LZINEnVuW2MzCoCLfioHnGiZrYSRkHwid12J1y+06AGmVDltzRDIJkD4I0uQxekq4cI5dM4dKSyQLxSn9T33HI6Oq1Pua44K5x0yRSy0iVRlJA4erV6tviVR2As4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: rllhTHFVT+O9isk+OmUwAA==
X-CSE-MsgGUID: gZSY38gxRUC2a4sFMPVHRA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Jan 2025 23:03:55 +0900
Received: from [10.24.0.69] (unknown [10.24.0.69])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4531E40158CC;
	Wed, 22 Jan 2025 23:03:39 +0900 (JST)
Message-ID: <f8b5beb4-ac3d-417c-810e-d96901f688db@bp.renesas.com>
Date: Wed, 22 Jan 2025 14:03:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: phy: Fix suspicious rcu_dereference
 usage
Content-Language: en-GB
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20250120141926.1290763-1-kory.maincent@bootlin.com>
 <20250120111228.6bd61673@kernel.org>
 <20250121103845.6e135477@kmaincent-XPS-13-7390>
 <134f69de-64f9-4d36-94ff-22b93cb32f2e@bp.renesas.com>
 <20250121140124.259e36e0@kmaincent-XPS-13-7390>
 <d512e107-68ac-4594-a7cb-8c26be4b3280@bp.renesas.com>
 <20250121171156.790df4ba@kmaincent-XPS-13-7390>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20250121171156.790df4ba@kmaincent-XPS-13-7390>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0qcw2up6QxQagKhJ0SrdNiTL"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0qcw2up6QxQagKhJ0SrdNiTL
Content-Type: multipart/mixed; boundary="------------R5cyKBAXCkzQrlcJne2ua5Yg";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Sergey Shtylyov <s.shtylyov@omp.ru>
Message-ID: <f8b5beb4-ac3d-417c-810e-d96901f688db@bp.renesas.com>
Subject: Re: [PATCH net-next v3] net: phy: Fix suspicious rcu_dereference
 usage
References: <20250120141926.1290763-1-kory.maincent@bootlin.com>
 <20250120111228.6bd61673@kernel.org>
 <20250121103845.6e135477@kmaincent-XPS-13-7390>
 <134f69de-64f9-4d36-94ff-22b93cb32f2e@bp.renesas.com>
 <20250121140124.259e36e0@kmaincent-XPS-13-7390>
 <d512e107-68ac-4594-a7cb-8c26be4b3280@bp.renesas.com>
 <20250121171156.790df4ba@kmaincent-XPS-13-7390>
In-Reply-To: <20250121171156.790df4ba@kmaincent-XPS-13-7390>

--------------R5cyKBAXCkzQrlcJne2ua5Yg
Content-Type: multipart/mixed; boundary="------------Ay5nQHSsDAQtoVi0Qp0fIgyw"

--------------Ay5nQHSsDAQtoVi0Qp0fIgyw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21/01/2025 16:11, Kory Maincent wrote:
> On Tue, 21 Jan 2025 15:44:34 +0000
> Paul Barker <paul.barker.ct@bp.renesas.com> wrote:
>=20
>> On 21/01/2025 13:01, Kory Maincent wrote:
>>=20
>>> On Tue, 21 Jan 2025 11:34:48 +0000
>>> Paul Barker <paul.barker.ct@bp.renesas.com> wrote:
>>>=20
>>>> Why do we need to hold the rtnl mutex across the calls to
>>>> netif_device_detach() and ravb_wol_setup()?
>>>>
>>>> My reading of Documentation/networking/netdevices.rst is that the rt=
nl
>>>> mutex is held when the net subsystem calls the driver's ndo_stop met=
hod,
>>>> which in our case is ravb_close(). So, we should take the rtnl mutex=

>>>> when we call ravb_close() directly, in both ravb_suspend() and
>>>> ravb_wol_restore(). That would ensure that we do not call
>>>> phy_disconnect() without holding the rtnl mutex and should fix this
>>>> issue. =20
>>>
>>> Not sure about it. For example ravb_ptp_stop() called in ravb_wol_set=
up()
>>> won't be protected by the rtnl lock. =20
>>
>> ravb_ptp_stop() modifies a couple of device registers and calls
>> ptp_clock_unregister(). I don't see anything to suggest that this
>> requires the rtnl lock to be held, unless I am missing something.
>=20
> What happens if two ptp_clock_unregister() with the same ptp_clock poin=
ter are=20
> called simultaneously? From ravb_suspend and ravb_set_ringparam for exa=
mple. It
> may cause some errors.
> For example the ptp->kworker pointer could be used after a kfree.
> https://elixir.bootlin.com/linux/v6.12.6/source/drivers/ptp/ptp_clock.c=
#L416

I've dug into this some more today and looked at the suspend/resume
paths of other Ethernet drivers for comparison.

netif_device_detach() and netif_device_attach() seem to be safe to call
without holding the rtnl lock, e.g. the stmmac driver does this.

In the suspend path, we should hold the rtnl lock across the calls to
ravb_wol_setup() and ravb_close().

In the resume path, we should hold the rtnl lock across the calls to
ravb_wol_restore() and ravb_open(). I don't think there is any harm in
holding the rtnl lock while we call pm_runtime_force_resume(), so we can
take the lock before checking priv->wol_enabled and release after
calling ravb_open().

How does that sound?

Thanks,

--=20
Paul Barker
--------------Ay5nQHSsDAQtoVi0Qp0fIgyw
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------Ay5nQHSsDAQtoVi0Qp0fIgyw--

--------------R5cyKBAXCkzQrlcJne2ua5Yg--

--------------0qcw2up6QxQagKhJ0SrdNiTL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZ5D6ugUDAAAAAAAKCRDbaV4Vf/JGva1u
AQDDP57Gcz+ao4Fsp+KYqVGMQX3rLDritlKi/3RhdS6GbQEAm5+qULUGSuNswrxrAmU4s2MAusp2
5E1jFt8Ye7sFrQM=
=4V+I
-----END PGP SIGNATURE-----

--------------0qcw2up6QxQagKhJ0SrdNiTL--

