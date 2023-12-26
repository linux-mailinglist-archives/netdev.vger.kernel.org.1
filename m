Return-Path: <netdev+bounces-60246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC3181E5C0
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 08:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CEB41F22171
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 07:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646084C630;
	Tue, 26 Dec 2023 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kz0//zhp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038404C625
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3e4637853so390415ad.0
        for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 23:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703576540; x=1704181340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+F8YPGDD1xR9QL6WEwNCRh3ffA3IsoDteESLTJZnr60=;
        b=Kz0//zhpe3gurtVuQE3ddiOkiCLh0do6EtyfjkIav4+fI1QMZUB33Klfd+Rp0/Wg2y
         LpU6PURzcYL7LaSRb3EaAl8dICATfbet+rJ/Q1hJQImz6J0Eyiq12APHDC30CGrOyMuH
         EiozYNlqAzz46fCx0YOqEcFqeJJLj2GZyvFcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703576540; x=1704181340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+F8YPGDD1xR9QL6WEwNCRh3ffA3IsoDteESLTJZnr60=;
        b=Z5BEVlCgnANRavK1ef93Lw5miaZbA4FiUtIxAXPieuTBDJK4oPNDQ4G90o+rI8ysrQ
         OcDf6WoSf7zH/pXXc4fYWJ4kKkydUxcuCfpFJunHBX7UZaoCs66pGkQIsI6PxevKiLUW
         l+ugkis1akk+MiuySHwLkLz8HA3UGaFHvunTCswX7zqf2xJq9oSos4pC0fDw5xF2gamN
         kH0s+9J8tWUdV7rQZYUuELmJ43vZKtMPlTMy1q3aCDmujcKp6wkvPHQ6CfLnLwz78cNO
         QShUfFAsrvYWzMMFP0ncCXW3jwW+2ZywdFT4eVBXLM3pmpis7nSBEQU17Y54la8ybHcB
         Mk1w==
X-Gm-Message-State: AOJu0YyZb/KB6XcJ4/sEqHE/wDbo7wjNFWLXtevy034JltwU0zxawvtN
	6NWH6+pbayGieK8rZfEOyKYWgLAHA/c8QgOu2P3i/YE5CadTCpbL0YbGYEqps7LH
X-Google-Smtp-Source: AGHT+IHE4C2V9O/f44KmNw9KjE03VtvbSEZb770l+K0OjCJwyYMtjpbTXTm33Xsm9nBCiQAXqcSVetsSCQJxXKJwcaE=
X-Received: by 2002:a17:902:e881:b0:1d4:4482:83a5 with SMTP id
 w1-20020a170902e88100b001d4448283a5mr164244plg.14.1703576539969; Mon, 25 Dec
 2023 23:42:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223233523.4411-1-maxtram95@gmail.com> <20231223233523.4411-3-maxtram95@gmail.com>
 <CANEJEGuJFq3Wf8=DxTnrbENi586ccsi7Y+pgQWOSaqzvCp2aZg@mail.gmail.com>
In-Reply-To: <CANEJEGuJFq3Wf8=DxTnrbENi586ccsi7Y+pgQWOSaqzvCp2aZg@mail.gmail.com>
From: Grant Grundler <grundler@chromium.org>
Date: Mon, 25 Dec 2023 23:42:08 -0800
Message-ID: <CANEJEGu7j8JZ37=94TETTcK_K69YVOnvYWaQZT5Qr+6y6f20ow@mail.gmail.com>
Subject: Re: [PATCH net 2/2] r8152: Switch to using choose_configuration
To: Grant Grundler <grundler@chromium.org>
Cc: Maxim Mikityanskiy <maxtram95@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	=?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hayes Wang <hayeswang@realtek.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Douglas Anderson <dianders@chromium.org>, linux-usb@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 11:18=E2=80=AFPM Grant Grundler <grundler@chromium.=
org> wrote:
>
> On Sat, Dec 23, 2023 at 3:36=E2=80=AFPM Maxim Mikityanskiy <maxtram95@gma=
il.com> wrote:
> >
> > With the introduction of r8152-cfgselector, the following regression
> > appeared on machines that use usbguard: the netdev appears only when th=
e
> > USB device is inserted the first time (before the module is loaded), bu=
t
> > on the second and next insertions no netdev is registered.
> >
> > It happens because the device is probed as unauthorized, and usbguard
> > gives it an authorization a moment later. If the module is not loaded,
> > it's normally loaded slower than the authorization is given, and
> > everything works. If the module is already loaded, the cfgselector's
> > probe function runs first, but then usb_authorize_device kicks in and
> > changes the configuration to something chosen by the standard
> > usb_choose_configuration. rtl8152_probe refuses to probe non-vendor
> > configurations, and the user ends up without a netdev.
> >
> > The previous commit added possibility to override
> > usb_choose_configuration. Use it to fix the bug and pick the right
> > configuration on both probe and authorization.
> >
> > Fixes: ec51fbd1b8a2 ("r8152: add USB device driver for config selection=
")
> > Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
>
> Maxim,
> Does this solve the same problem that Doug Anderson posted patches for
> a few weeks ago?
>
> https://lore.kernel.org/all/20231201183113.343256-1-dianders@chromium.org=
/
>
> Those went through the USB tree, so that probably explains why you
> didn't see them in the net.git tree.

Specifically, usb.git usb-next branch:
"r8152: Choose our USB config with choose_configuration() rather than probe=
()"
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/drive=
rs/net/usb/r8152.c?h=3Dusb-next&id=3Daa4f2b3e418e8673e55145de8b8016a7a99203=
06

Given this has a fixes tag, and two people have now tracked this down
and posted fixes for this problem, is there any chance of this landing
in 6.7?

And it looks like Maxim's change could be rebased on top of Doug's
patch and clean up a few more things. Do I see that correctly?

cheers,
grant

>
> cheers,
> grant
>
> > ---
> >  drivers/net/usb/r8152.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> > index 9bf2140fd0a1..f0ac31a94f3c 100644
> > --- a/drivers/net/usb/r8152.c
> > +++ b/drivers/net/usb/r8152.c
> > @@ -10070,6 +10070,11 @@ static struct usb_driver rtl8152_driver =3D {
> >  };
> >
> >  static int rtl8152_cfgselector_probe(struct usb_device *udev)
> > +{
> > +       return 0;
> > +}
> > +
> > +static int rtl8152_cfgselector_choose_configuration(struct usb_device =
*udev)
> >  {
> >         struct usb_host_config *c;
> >         int i, num_configs;
> > @@ -10078,7 +10083,7 @@ static int rtl8152_cfgselector_probe(struct usb=
_device *udev)
> >          * driver supports it.
> >          */
> >         if (__rtl_get_hw_ver(udev) =3D=3D RTL_VER_UNKNOWN)
> > -               return 0;
> > +               return -EOPNOTSUPP;
> >
> >         /* The vendor mode is not always config #1, so to find it out. =
*/
> >         c =3D udev->config;
> > @@ -10094,20 +10099,15 @@ static int rtl8152_cfgselector_probe(struct u=
sb_device *udev)
> >         }
> >
> >         if (i =3D=3D num_configs)
> > -               return -ENODEV;
> > -
> > -       if (usb_set_configuration(udev, c->desc.bConfigurationValue)) {
> > -               dev_err(&udev->dev, "Failed to set configuration %d\n",
> > -                       c->desc.bConfigurationValue);
> > -               return -ENODEV;
> > -       }
> > +               return -EOPNOTSUPP;
> >
> > -       return 0;
> > +       return c->desc.bConfigurationValue;
> >  }
> >
> >  static struct usb_device_driver rtl8152_cfgselector_driver =3D {
> >         .name =3D         MODULENAME "-cfgselector",
> >         .probe =3D        rtl8152_cfgselector_probe,
> > +       .choose_configuration =3D rtl8152_cfgselector_choose_configurat=
ion,
> >         .id_table =3D     rtl8152_table,
> >         .generic_subclass =3D 1,
> >         .supports_autosuspend =3D 1,
> > --
> > 2.43.0
> >

