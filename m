Return-Path: <netdev+bounces-55289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CD480A1F9
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 12:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08891C2096C
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 11:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF071A5A8;
	Fri,  8 Dec 2023 11:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="qI8mD2DO"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 381 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Dec 2023 03:17:24 PST
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C5710CF;
	Fri,  8 Dec 2023 03:17:24 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:440b:0:640:fa3a:0])
	by forward502c.mail.yandex.net (Yandex) with ESMTP id 798A36123F;
	Fri,  8 Dec 2023 14:10:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id TAcpGPeKn8c0-2U9xMJpD;
	Fri, 08 Dec 2023 14:10:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1702033830; bh=QmfAlJThz823b12lB5pGa5H06RW2Ph9k8H5H7/pZ/aM=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=qI8mD2DOT3f6+7kzz3VWGRxsU/pcVCkruaIbYecQqa2oBJU30UuHceB61nk45Mhmo
	 YM9uD2TL86SGNiqkfaWPBo5W8oVa2XUviKvr7RIlzgd7azgko6QY+4k8Z06pzannXK
	 8ExQrG8N4xfUQGcP0QwTugajP97+IL0rR9gfhbO0=
Authentication-Results: mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <2b646678611c3ed7546d880f8875d57a6800c281.camel@maquefel.me>
Subject: Re: [PATCH v5 17/39] net: cirrus: add DT support for Cirrus EP93xx
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org, Alexander Sverdlin
 <alexander.sverdlin@gmail.com>,  Andrew Lunn <andrew@lunn.ch>
Date: Fri, 08 Dec 2023 14:10:29 +0300
In-Reply-To: <ZV3xFjmU56hwBfLc@smile.fi.intel.com>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
	 <20231122-ep93xx-v5-17-d59a76d5df29@maquefel.me>
	 <ZV3xFjmU56hwBfLc@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Andy!

Thanks for review (i am counting all review not only this patch), only
this comment below raised a question:

On Wed, 2023-11-22 at 14:16 +0200, Andy Shevchenko wrote:
> On Wed, Nov 22, 2023 at 11:59:55AM +0300, Nikita Shubin wrote:
> > - add OF ID match table
> > - get phy_id from the device tree, as part of mdio
> > - copy_addr is now always used, as there is no SoC/board that
> > aren't
> > - dropped platform header
>=20
> ...
>=20
> > =C2=A0#include <linux/interrupt.h>
> > =C2=A0#include <linux/moduleparam.h>
> > =C2=A0#include <linux/platform_device.h>
> > +#include <linux/of.h>
>=20
> Perhaps more ordering?
>=20
> > =C2=A0#include <linux/delay.h>
> > =C2=A0#include <linux/io.h>
> > =C2=A0#include <linux/slab.h>
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D of_property_read_u32=
(np, "reg", &phy_id);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0of_node_put(np);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return dev_err_probe(&pdev->dev, -ENOENT, "Failed
> > to locate \"phy_id\"\n");
>=20
> Why shadowing the actual error code?

of_property_read_u32 returns NULL on error.

>=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev =3D alloc_etherdev(sizeo=
f(struct ep93xx_priv));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (dev =3D=3D NULL) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D -ENOMEM;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto err_out;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20


