Return-Path: <netdev+bounces-196873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CCFAD6BFD
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F908161474
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 09:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43503224244;
	Thu, 12 Jun 2025 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4h9a2/l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970B22222AF;
	Thu, 12 Jun 2025 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719863; cv=none; b=khfXlHU6l2ZyMyAIUZclTTrihW8mOkR54Qa3FotYjtz84JmJHTUfX2uAiHHVT58LrzE2EbY1hwQf0xr8Lk+XiO6FYXLH2SsTpcpUl9W9WRRs3dkK1/OhDyCJp6TSrYwJJcTNmt8sswL4WJRfgb6B6cy09A9Uhst5tIZXbF3+p0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719863; c=relaxed/simple;
	bh=YhEpaBiJYER4CmUExl/67+oPu9bTe3B8CN9TxlhRZso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCQ4j7uv+hHagGAZGt32CgX/aDrRbbsoLtBEzw9hUewRoPSgKixnwSeEruowEOpiKYRZedOeYrqNpZjssw2YQET0L/yac+ghnmllZQD5MfagiFyrUI0CV2zCW1WXAHYYHnc5Gbmbyy39At98k9d5+cwHhKwM0TMApBJGyAGu7zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4h9a2/l; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-710fe491842so4866957b3.0;
        Thu, 12 Jun 2025 02:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749719860; x=1750324660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIbtaKHssUJEXckfGTWWDh+nXM1+6kR9FSNcY89FTOg=;
        b=K4h9a2/lpeaBK0/iVBvAGCW9RGsRFBkrGzhrjK8vfDLki+Ex9cur6bNr0xOCGn1kGW
         ijK6dgus5QGSGso5/IMQSpBw3GhEFzNp/eebsp+5MdHBXypGF0trdhfbMwiSD7C+w1ny
         izkQQWc9FwYJBk1nF92Q86hKsShSD5R9AgFTtaSNxGEl1Cf0Hh/omwzzPb9ywhleSkLE
         gb63BeEWd2iYfu4FUm7uW8vx8IxWq2LYV4YC3+0RJNcI2Q7NipOSOQ8SsCAXCSU0ZU+n
         hT3f17jMx9siGauc8MLsIraeb9P/pP+cUGF6ZnbCyUd5ATv12VWN1m2DYv/7vtmc5TG7
         hQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749719860; x=1750324660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIbtaKHssUJEXckfGTWWDh+nXM1+6kR9FSNcY89FTOg=;
        b=hDDLY3LBEfUsflEXO0AHNZZw7PAn5e/+e/HRoqApa3WMI96YdyTSb6k3li0YqIo405
         ItwHUJmfOTszZ1+P3FQ5sx9ppdu7QJDjYRktpWMdZ20eweXjBCFJpUyBF1o3qINJtSp6
         dJMLLwna1xkYnarFlFGMqCWXESuZ8g7HBoK+4lcVepYm1DYux5vvPnGOjHnKmcKtGS4y
         HCDp/VkBL4CYtucHzffXSjXIGG5l9ndcVvu6xEAXJV6gUgvwihLuDdXeBoxUbF/tPfW0
         /MzOEfiPr4sQP+A+GjTfX4M/r8Ki/lvXC7arR+/qC01XeXky78IH4uBdtBH3cX3IpTcY
         AODw==
X-Forwarded-Encrypted: i=1; AJvYcCUN9CLQ2HJFAZa7JO2Mk4cyHmxvQZwxaAz8IumJM0MuIT8BAvp6VcqHwsP+6ARY0tZRqX4SyMVU@vger.kernel.org, AJvYcCWAwmQLSBdxhjevCwDIgLzkBsmT8fpjCU82VSSL2j5mvHRibpLWdR3iDzrnE/VtkqlEgyzxKNs9ZA9dEyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoZt+fgOmjb3JuDeFxHuOVKmwkCXaNosxT2d13tIg5LSvpVzAm
	zs3xyyc8VW1yWP7jqP7CPfJfls9IldTr6gKzo2T0pJ/asVAbhCyW9jXonesP+hBErayaCIEW1+m
	aQOiKrUek9o+xI2zEprImyi1c754VBXs=
X-Gm-Gg: ASbGncu4/gFsc3a89Rgch6iqcIBkgJB2rQWTPoQfc2WljPLKm9z9luVQWp47Xn8Q5DF
	9qIpXwRp0u7ZBjAD+CHpIM3nKqcnK1A+qILZ4xJODLroYfXBQkRmhDJ/AMXjgPE6JSmsLvnGCNq
	rXaivMy3GyEAZiMLdrPIE6i3s1ZoK3MhpLah+3bjv1vg==
X-Google-Smtp-Source: AGHT+IHq4vHcczgjBHBQfvW7TIgvNGZeXQ7Cmbkdm6j57A1HHRtSaqgK4fFE5mmPZI9ZBmr7rhApVQVLgFFTnxrAXeE=
X-Received: by 2002:a05:690c:4b8a:b0:70e:7638:a3a9 with SMTP id
 00721157ae682-71140ad36eemr103273637b3.18.1749719860516; Thu, 12 Jun 2025
 02:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612083747.26531-1-noltari@gmail.com> <20250612083747.26531-5-noltari@gmail.com>
In-Reply-To: <20250612083747.26531-5-noltari@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 12 Jun 2025 11:17:29 +0200
X-Gm-Features: AX0GCFtDmqKwO5CfjAV0DZXN8WgtFq7n6rKTlAUf1ameVk0AShV_CtHOuXA4Kq4
Message-ID: <CAOiHx=kxcMNDrmzz5Bqd337YrZ23sYNWP0-nZrUynPJXdt4LLg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 04/14] net: dsa: b53: detect BCM5325 variants
To: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, vivien.didelot@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 10:37=E2=80=AFAM =C3=81lvaro Fern=C3=A1ndez Rojas
<noltari@gmail.com> wrote:
>
> Older BCM5325M switches lack some registers that newer BCM5325E have, so
> we need to be able to differentiate them in order to check whether the
> registers are available or not.

Did you test this with a BCM5325M?

> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> ---
>  drivers/net/dsa/b53/b53_common.c | 34 ++++++++++++++++++++++++++------
>  drivers/net/dsa/b53/b53_priv.h   | 16 +++++++++++++--
>  2 files changed, 42 insertions(+), 8 deletions(-)
>
>  v3: detect BCM5325 variants as requested by Florian.
>
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_c=
ommon.c
> index 222107223d109..2975dab6ee0bb 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -2490,8 +2490,18 @@ struct b53_chip_data {
>
>  static const struct b53_chip_data b53_switch_chips[] =3D {
>         {
> -               .chip_id =3D BCM5325_DEVICE_ID,
> -               .dev_name =3D "BCM5325",
> +               .chip_id =3D BCM5325M_DEVICE_ID,
> +               .dev_name =3D "BCM5325M",
> +               .vlans =3D 16,

Are you sure about BCM5325M supporting VLANs at all? All the
documentation I can find implies it does not. And if it does not, not
sure if it makes sense to support it.

> +               .enabled_ports =3D 0x3f,
> +               .arl_bins =3D 2,
> +               .arl_buckets =3D 1024,
> +               .imp_port =3D 5,
> +               .duplex_reg =3D B53_DUPLEX_STAT_FE,
> +       },
> +       {
> +               .chip_id =3D BCM5325E_DEVICE_ID,
> +               .dev_name =3D "BCM5325E",
>                 .vlans =3D 16,
>                 .enabled_ports =3D 0x3f,
>                 .arl_bins =3D 2,
> @@ -2938,10 +2948,22 @@ int b53_switch_detect(struct b53_device *dev)
>                 b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_TABLE_ACCESS_25,=
 0xf);
>                 b53_read16(dev, B53_VLAN_PAGE, B53_VLAN_TABLE_ACCESS_25, =
&tmp);
>
> -               if (tmp =3D=3D 0xf)
> -                       dev->chip_id =3D BCM5325_DEVICE_ID;
> -               else
> +               if (tmp =3D=3D 0xf) {
> +                       u32 phy_id;
> +                       int val;
> +
> +                       val =3D b53_phy_read16(dev->ds, 0, MII_PHYSID1);
> +                       phy_id =3D (val & 0xffff) << 16;
> +                       val =3D b53_phy_read16(dev->ds, 0, MII_PHYSID2);
> +                       phy_id |=3D (val & 0xffff);

You should ignore the least significant nibble, as it encodes the chip revi=
sion.

> +
> +                       if (phy_id =3D=3D 0x0143bc30)
> +                               dev->chip_id =3D BCM5325E_DEVICE_ID;
> +                       else
> +                               dev->chip_id =3D BCM5325M_DEVICE_ID;
> +               } else {
>                         dev->chip_id =3D BCM5365_DEVICE_ID;
> +               }
>                 break;
>         case BCM5389_DEVICE_ID:
>         case BCM5395_DEVICE_ID:
> @@ -2975,7 +2997,7 @@ int b53_switch_detect(struct b53_device *dev)
>                 }
>         }
>
> -       if (dev->chip_id =3D=3D BCM5325_DEVICE_ID)
> +       if (is5325(dev))
>                 return b53_read8(dev, B53_STAT_PAGE, B53_REV_ID_25,
>                                  &dev->core_rev);
>         else
> diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_pri=
v.h
> index a5ef7071ba07b..deea4d83f0e93 100644
> --- a/drivers/net/dsa/b53/b53_priv.h
> +++ b/drivers/net/dsa/b53/b53_priv.h
> @@ -60,7 +60,8 @@ struct b53_io_ops {
>
>  enum {
>         BCM4908_DEVICE_ID =3D 0x4908,
> -       BCM5325_DEVICE_ID =3D 0x25,
> +       BCM5325M_DEVICE_ID =3D 0x25,
> +       BCM5325E_DEVICE_ID =3D 0x25e,

Maybe we should have a b53_priv::variant_id field or so. Other chips
also can have variants, so we might want to avoid polluting the chip
id space. We currently don't care about them, but might in the future
as they have different feature support (e.g. there are bcm531x5
variants with and without CFP support).

Regards,
Jonas

