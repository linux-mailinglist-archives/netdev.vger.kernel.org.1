Return-Path: <netdev+bounces-160020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03308A17D1B
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 12:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24AA3A21A9
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 11:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A7E1C243D;
	Tue, 21 Jan 2025 11:35:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586D726AFA;
	Tue, 21 Jan 2025 11:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737459304; cv=none; b=YQTOig3NjoS0sEWY4mdOWyhAFxjlK5YqawapUZKN3H/vAbrtXW9mIOSWeabudWmLZM3vfWXG5e9CU5f96lY5WnbuIbSd6oIP7JoRQCBjIUUJeJAXScQMeiNbrH1+SwcJzzTM0HcHHP4BVSvMuhr8wRQZkFMkBaOVwG6jUOD6Ldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737459304; c=relaxed/simple;
	bh=VmgBtEO/hZF7/Q8mEph8YxAOPRVcWVHVA/Irb9NrhW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfaSZ1b/HvEMcN0ZLNx1xuD+uCAEchZvzWnvqZ6RgiM6Ps9czBtHUd5J8cOF3XGjvmXyvGEy9hsgqbmqhqSC3WB1dKlS18Xu84k5YueRoxRJOvZyO7zkJ90LYN3LTv7/eKWtGBGOmvXzDdbNN1I2m/IEKnMF4bRChuRFJSnP1YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: e8BJ3OFSRXaXaPpvPHiknQ==
X-CSE-MsgGUID: pJSgtUGiQ7+MYwEwyv7krA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Jan 2025 20:34:54 +0900
Received: from [10.24.0.69] (unknown [10.24.0.69])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 62B774002654;
	Tue, 21 Jan 2025 20:34:50 +0900 (JST)
Message-ID: <134f69de-64f9-4d36-94ff-22b93cb32f2e@bp.renesas.com>
Date: Tue, 21 Jan 2025 11:34:48 +0000
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
To: Kory Maincent <kory.maincent@bootlin.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
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
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20250121103845.6e135477@kmaincent-XPS-13-7390>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0Shbx1Wbb9cDU9JEO6JOcSx0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0Shbx1Wbb9cDU9JEO6JOcSx0
Content-Type: multipart/mixed; boundary="------------8K1gzAb0cEheIUiNfL8FS00o";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Kory Maincent <kory.maincent@bootlin.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Sergey Shtylyov <s.shtylyov@omp.ru>
Message-ID: <134f69de-64f9-4d36-94ff-22b93cb32f2e@bp.renesas.com>
Subject: Re: [PATCH net-next v3] net: phy: Fix suspicious rcu_dereference
 usage
References: <20250120141926.1290763-1-kory.maincent@bootlin.com>
 <20250120111228.6bd61673@kernel.org>
 <20250121103845.6e135477@kmaincent-XPS-13-7390>
In-Reply-To: <20250121103845.6e135477@kmaincent-XPS-13-7390>

--------------8K1gzAb0cEheIUiNfL8FS00o
Content-Type: multipart/mixed; boundary="------------aPGWf5SQgvaWSLEUfnIF2Bcj"

--------------aPGWf5SQgvaWSLEUfnIF2Bcj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21/01/2025 09:38, Kory Maincent wrote:
> On Mon, 20 Jan 2025 11:12:28 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
>=20
>> On Mon, 20 Jan 2025 15:19:25 +0100 Kory Maincent wrote:
>>> The path reported to not having RTNL lock acquired is the suspend pat=
h of
>>> the ravb MAC driver. Without this fix we got this warning: =20
>>
>> I maintain that ravb is buggy, plenty of drivers take rtnl_lock=20
>> from the .suspend callback. We need _some_ write protection here,
>> the patch as is only silences a legitimate warning.
>=20
> Indeed if the suspend path is buggy we should fix it. Still there is lo=
ts of
> ethernet drivers calling phy_disconnect without rtnl (IIUC) if probe re=
turn an
> error or in the remove path. What should we do about it?
>=20
> About ravb suspend, I don't have the board, Claudiu could you try this =
instead
> of the current fix:
>=20
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c
> b/drivers/net/ethernet/renesas/ravb_main.c index bc395294a32d..c9a0d2d6=
f371
> 100644 --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -3215,15 +3215,22 @@ static int ravb_suspend(struct device *dev)
>         if (!netif_running(ndev))
>                 goto reset_assert;
> =20
> +       rtnl_lock();
>         netif_device_detach(ndev);
> =20
> -       if (priv->wol_enabled)
> -               return ravb_wol_setup(ndev);
> +       if (priv->wol_enabled) {
> +               ret =3D ravb_wol_setup(ndev);
> +               rtnl_unlock();
> +               return ret;
> +       }
> =20
>         ret =3D ravb_close(ndev);
> -       if (ret)
> +       if (ret) {
> +               rtnl_unlock();
>                 return ret;
> +       }
> =20
> +       rtnl_unlock();
>         ret =3D pm_runtime_force_suspend(&priv->pdev->dev);
>         if (ret)
>                 return ret;
>=20
> Regards,

(Cc'ing Niklas and Sergey as this relates to the ravb driver)

Why do we need to hold the rtnl mutex across the calls to
netif_device_detach() and ravb_wol_setup()?

My reading of Documentation/networking/netdevices.rst is that the rtnl
mutex is held when the net subsystem calls the driver's ndo_stop method,
which in our case is ravb_close(). So, we should take the rtnl mutex
when we call ravb_close() directly, in both ravb_suspend() and
ravb_wol_restore(). That would ensure that we do not call
phy_disconnect() without holding the rtnl mutex and should fix this
issue.

Commit 35f7cad1743e ("net: Add the possibility to support a selected
hwtstamp in netdevice") may have unearthed the issue, but the fixes tag
should point to the commits adding those unlocked calls to ravb_close().

I am not super familiar with the rtnl lock so let me know if I've missed
something.

Thanks,

--=20
Paul Barker
--------------aPGWf5SQgvaWSLEUfnIF2Bcj
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------aPGWf5SQgvaWSLEUfnIF2Bcj--

--------------8K1gzAb0cEheIUiNfL8FS00o--

--------------0Shbx1Wbb9cDU9JEO6JOcSx0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZ4+GWQUDAAAAAAAKCRDbaV4Vf/JGvfCC
AQDyp35sx7XpPYGsX2YRdqqJjCPuX+hK3WbdvYM+VMxWGQEA8/Ucz+DoNjW09lU6bxzxGFXESC3g
UZfcNjz0oTH8YQw=
=AFok
-----END PGP SIGNATURE-----

--------------0Shbx1Wbb9cDU9JEO6JOcSx0--

