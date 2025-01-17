Return-Path: <netdev+bounces-159379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD55A15552
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABDE16734C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 17:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F35719F438;
	Fri, 17 Jan 2025 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mucsvoyJ"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A70919E7D1;
	Fri, 17 Jan 2025 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133762; cv=none; b=OsY7Sm7sXSO6oqfDVq6PdqXd1HVBXVUd6fLdZxOx+mr+8uMX9LJGRjOh1DmT5f/E2/igmBjUgxEEvntteI2aFcaADnGZybj5wZxYFITcKDQxGWjskzE8gMKDDJfQK/3X+zInd1wndDaw6agc8MA7I0ajplCGGE6xY+hiPBgzaFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133762; c=relaxed/simple;
	bh=zDuP+S+EDz/IFsqqUlQOluVeWX80weW+rUlQeW5U/NI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kuHrXSphF7YdWEK7DGDXg2x+t5xdQx3rGiDCRIx1BofSrsV9a9/uAET4doowUe0iNHGkxHqXkQtmuCLN8qdJJnhi+ScLVO3GXhVn6h0hxrnke/hC4wn/u+qx3vIEQum3wuiaqiMp5pzOM7fG2+BmPcvCWPI+3XoAAkW15ovjRN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mucsvoyJ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1379F1C0005;
	Fri, 17 Jan 2025 17:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737133758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhcbEETCkTy853sgQA/WpdL5GWB4s6HbH+/rowEaRP0=;
	b=mucsvoyJDUpq2Gl9IQIeaNKfPIr7gSmSHxTr4Smrcuf9Cp9rBqbQMIacRVxVcnUNb03ntF
	MOb8xrZJuHSaFnHXPOw5uWw6EaSGm/TMksus104i4KhKjFRhm/u2ChwrHTZGsP9yEBnTuk
	Z4zFA3JwWRIZmKSuCg9hPwHtaYDfCvmrlVhalfM8HuAGt270F0Zx6t8CsiH8TQKknvFPDH
	PfZVUhl0peobctd96gKI+InKQb1nvU7f6BNrW1K6RdA+y3o5UVLbI9v+hLdh6L8EBG5WMx
	YCFOiHCRTIeBsSs6K0q5N9j+hQ7mQg717rSSP53n1WUtBMtnm7hCylB9kYaD3Q==
Date: Fri, 17 Jan 2025 18:09:14 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, Kory Maincent
 <kory.maincent@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: phy: Fix suspicious rcu_dereference usage
Message-ID: <20250117180914.76c5fb05@kmaincent-XPS-13-7390>
In-Reply-To: <20250117141446.1076951-1-kory.maincent@bootlin.com>
References: <20250117141446.1076951-1-kory.maincent@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Fri, 17 Jan 2025 15:14:45 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> The phy_detach function can be called with or without the rtnl lock held.
> When the rtnl lock is not held, using rtnl_dereference() triggers a
> warning due to the lack of lock context.
>=20
> Add an rcu_read_lock() to ensure the lock is acquired and to maintain
> synchronization.

Sent the wrong patch which have a ; missing.

pw-bot: cr

>=20
> Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reported-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Closes:
> https://lore.kernel.org/netdev/4c6419d8-c06b-495c-b987-d66c2e1ff848@tuxon=
.dev/
> Fixes: 35f7cad1743e ("net: Add the possibility to support a selected hwts=
tamp
> in netdevice") Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> -=
--
>  drivers/net/phy/phy_device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 5b34d39d1d52..b9b9aa16c10a 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -2001,12 +2001,14 @@ void phy_detach(struct phy_device *phydev)
>  	if (dev) {
>  		struct hwtstamp_provider *hwprov;
> =20
> -		hwprov =3D rtnl_dereference(dev->hwprov);
> +		rcu_read_lock()
> +		hwprov =3D rcu_dereference(dev->hwprov);
>  		/* Disable timestamp if it is the one selected */
>  		if (hwprov && hwprov->phydev =3D=3D phydev) {
>  			rcu_assign_pointer(dev->hwprov, NULL);
>  			kfree_rcu(hwprov, rcu_head);
>  		}
> +		rcu_read_unlock();
> =20
>  		phydev->attached_dev->phydev =3D NULL;
>  		phydev->attached_dev =3D NULL;



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

