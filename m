Return-Path: <netdev+bounces-63192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A1982B961
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 03:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4981C23D87
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 02:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF251118;
	Fri, 12 Jan 2024 02:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7d0FBfY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1E5110D
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cd5c55d6b8so53584841fa.3
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 18:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705025768; x=1705630568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asoHgvYegma2BpYBv6X+BwZ+hgHf1FbO+65sZQ7sll4=;
        b=K7d0FBfY80SepLdlDrtdAsRGXQETqTwLb59KtiKs5dO75IyOrf9cbBB0XGAMuLjTbX
         cIDk52uZrFy6LBHr4xV2rV+Zq/jz6SFJ68eBVhzgTFR3fgoLIE6qP4/gSJomIOBic+6G
         HsTDxgQ51eXecyTmo6hwUrMjX0SpWL+Y6J/GlEZd+Yhep0eht/AYEun6eRY3wUiSWKmO
         v3CFaAAEBJhnmTraFYXp+d6XXW0y8P+EQ4OAz+FhnIzKkeZMgae9lDLO39tvq3GwpQxR
         DVzqH1L15S/fY03PY4nxolEj9mQhVuLJDDnWkUvxd14zBjNvTGEW791dwkkptvWr0JSF
         sLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705025768; x=1705630568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asoHgvYegma2BpYBv6X+BwZ+hgHf1FbO+65sZQ7sll4=;
        b=UeNAsbjCv30Aoz8yEEA9yOmhf0B6sy/hq1OYEgR7Eu/LE38bVfxACDLUaXERy6IURJ
         H4X+3MFMbkZvAlMEQMOQ2pYjod9X0MX3ALdFf0rJQxmWCEGSenD86brICruBcN2tAfsv
         MF0suzjgKTf7R2wMFR3zlpFcZh3XZvIbFSyiL4bJ/M3SQ4Ir0nCIjSIDNClXebin9+ZU
         MrgnMBgj4v0X47OyhyU8IOnNPQXdLTL46HrFCVYrKXwYepybP6c0Yf891Fp202EVIieB
         kbH76Fou+3SB7UreLZk1X7LGdKHYzzVGH9LXST8dLpHZ31pHgeR29c9A8tW2mWUoiqNk
         vXQA==
X-Gm-Message-State: AOJu0YxI5Tt1tZQz2gTdXudi9vWfhuLLFrgfLkEdSrjfqLm1Y0y88H1K
	+Ji0sR5zVYmXE2IEXKH0SWaJazrUf/mTC/VL3Kw=
X-Google-Smtp-Source: AGHT+IG4Ar1WDZGFm/gPfluGOfXo54BThTVbrpZ3PdebHbzBYq2/DqEPVV7s1WQWQCOiwO27gPnk6Ll//OLiuqPFWI4=
X-Received: by 2002:a2e:868a:0:b0:2cd:87ca:d4bc with SMTP id
 l10-20020a2e868a000000b002cd87cad4bcmr200466lji.26.1705025767399; Thu, 11 Jan
 2024 18:16:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223005253.17891-1-luizluca@gmail.com> <20231223005253.17891-4-luizluca@gmail.com>
 <20240108140002.wpf6zj7qv2ftx476@skbuf> <CAJq09z6g+qTbzzaFAy94aV6HuESAeb4aLOUHWdUkOB4+xR_vDg@mail.gmail.com>
 <20240109123658.vqftnqsxyd64ik52@skbuf> <CAJq09z6JF0K==fO53RcimoRgujHjEkvmDKWGK3pYQAig58j__g@mail.gmail.com>
 <20240111094148.jltccq4r6b42wbgq@skbuf>
In-Reply-To: <20240111094148.jltccq4r6b42wbgq@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 11 Jan 2024 23:15:56 -0300
Message-ID: <CAJq09z7deOf1qt+4eK5d3ZX0oGjwgn0VGnCeHbLtin3oDFvxiw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/8] net: dsa: realtek: common realtek-dsa module
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em qui., 11 de jan. de 2024 =C3=A0s 06:41, Vladimir Oltean
<olteanv@gmail.com> escreveu:
>
> On Thu, Jan 11, 2024 at 03:20:10AM -0300, Luiz Angelo Daros de Luca wrote=
:
> > IMHO, the constant regmap_config looks cleaner than a sequence of
> > assignments. However, we don't actually need 4 of them.
> > As we already have a writable regmap_config in stack (to assign
> > lock_arg), we can reuse the same struct and simply set
> > disable_locking.
> > It makes the regmap ignore all locking fields and we don't even need
> > to unset them for map_nolock. Something like this:
> >
> > realtek_common_probe(struct device *dev, const struct regmap_config *rc=
_base)
> > {
> >
> >        (...)
> >
> >        rc =3D *rc_base;
> >        rc.lock_arg =3D priv;
> >        priv->map =3D devm_regmap_init(dev, NULL, priv, &rc);
> >        if (IS_ERR(priv->map)) {
> >                ret =3D PTR_ERR(priv->map);
> >                dev_err(dev, "regmap init failed: %d\n", ret);
> >                return ERR_PTR(ret);
> >        }
> >
> >        rc.disable_locking =3D true;
> >        priv->map_nolock =3D devm_regmap_init(dev, NULL, priv, &rc);
> >        if (IS_ERR(priv->map_nolock)) {
> >                ret =3D PTR_ERR(priv->map_nolock);
> >                dev_err(dev, "regmap init failed: %d\n", ret);
> >                return ERR_PTR(ret);
> >        }
> >
> > It has a cleaner function signature and we can remove the _nolock
> > constants as well.
> >
> > The regmap configs still have some room for improvement, like moving
> > from interfaces to variants, but this series is already too big. We
> > can leave that as it is.
>
> I was thinking something like this, does it look bad?
>
> From 2e462507171ed0fd8393598842dc0f7e6c50d499 Mon Sep 17 00:00:00 2001
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Date: Thu, 11 Jan 2024 11:38:17 +0200
> Subject: [PATCH] realtek_common_info
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/dsa/realtek/realtek-common.c | 35 ++++++++++++++++++------
>  drivers/net/dsa/realtek/realtek-common.h |  9 ++++--
>  drivers/net/dsa/realtek/realtek-mdio.c   | 27 ++----------------
>  drivers/net/dsa/realtek/realtek-smi.c    | 35 ++++--------------------
>  4 files changed, 41 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/r=
ealtek/realtek-common.c
> index 80b37e5fe780..bd6b04922b6d 100644
> --- a/drivers/net/dsa/realtek/realtek-common.c
> +++ b/drivers/net/dsa/realtek/realtek-common.c
> @@ -22,10 +22,21 @@ void realtek_common_unlock(void *ctx)
>  EXPORT_SYMBOL_GPL(realtek_common_unlock);
>
>  struct realtek_priv *
> -realtek_common_probe(struct device *dev, struct regmap_config rc,
> -                    struct regmap_config rc_nolock)
> +realtek_common_probe(struct device *dev,
> +                    const struct realtek_common_info *info)
>  {
>         const struct realtek_variant *var;
> +       struct regmap_config rc =3D {
> +               .reg_bits =3D 10, /* A4..A0 R4..R0 */
> +               .val_bits =3D 16,
> +               .reg_stride =3D 1,
> +               /* PHY regs are at 0x8000 */
> +               .max_register =3D 0xffff,
> +               .reg_format_endian =3D REGMAP_ENDIAN_BIG,
> +               .reg_read =3D info->reg_read,
> +               .reg_write =3D info->reg_write,
> +               .cache_type =3D REGCACHE_NONE,
> +       };
>         struct realtek_priv *priv;
>         int ret;
>
> @@ -40,17 +51,23 @@ realtek_common_probe(struct device *dev, struct regma=
p_config rc,
>
>         mutex_init(&priv->map_lock);
>
> -       rc.lock_arg =3D priv;
> -       priv->map =3D devm_regmap_init(dev, NULL, priv, &rc);
> -       if (IS_ERR(priv->map)) {
> -               ret =3D PTR_ERR(priv->map);
> +       /* Initialize the non-locking regmap first */
> +       rc.disable_locking =3D true;
> +       priv->map_nolock =3D devm_regmap_init(dev, NULL, priv, &rc);
> +       if (IS_ERR(priv->map_nolock)) {
> +               ret =3D PTR_ERR(priv->map_nolock);
>                 dev_err(dev, "regmap init failed: %d\n", ret);
>                 return ERR_PTR(ret);
>         }
>
> -       priv->map_nolock =3D devm_regmap_init(dev, NULL, priv, &rc_nolock=
);
> -       if (IS_ERR(priv->map_nolock)) {
> -               ret =3D PTR_ERR(priv->map_nolock);
> +       /* Then the locking regmap */
> +       rc.disable_locking =3D false;
> +       rc.lock =3D realtek_common_lock;
> +       rc.unlock =3D realtek_common_unlock;
> +       rc.lock_arg =3D priv;
> +       priv->map =3D devm_regmap_init(dev, NULL, priv, &rc);
> +       if (IS_ERR(priv->map)) {
> +               ret =3D PTR_ERR(priv->map);
>                 dev_err(dev, "regmap init failed: %d\n", ret);
>                 return ERR_PTR(ret);
>         }
> diff --git a/drivers/net/dsa/realtek/realtek-common.h b/drivers/net/dsa/r=
ealtek/realtek-common.h
> index 518d091ff496..71fc43d8d90a 100644
> --- a/drivers/net/dsa/realtek/realtek-common.h
> +++ b/drivers/net/dsa/realtek/realtek-common.h
> @@ -5,11 +5,16 @@
>
>  #include <linux/regmap.h>
>
> +struct realtek_common_info {
> +       int (*reg_read)(void *ctx, u32 reg, u32 *val);
> +       int (*reg_write)(void *ctx, u32 reg, u32 val);
> +};
> +
>  void realtek_common_lock(void *ctx);
>  void realtek_common_unlock(void *ctx);
>  struct realtek_priv *
> -realtek_common_probe(struct device *dev, struct regmap_config rc,
> -                    struct regmap_config rc_nolock);
> +realtek_common_probe(struct device *dev,
> +                    const struct realtek_common_info *info);
>  int realtek_common_register_switch(struct realtek_priv *priv);
>  void realtek_common_remove(struct realtek_priv *priv);
>
> diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/rea=
ltek/realtek-mdio.c
> index 1eed09ab3aa1..8725cd1b027b 100644
> --- a/drivers/net/dsa/realtek/realtek-mdio.c
> +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> @@ -101,31 +101,9 @@ static int realtek_mdio_read(void *ctx, u32 reg, u32=
 *val)
>         return ret;
>  }
>
> -static const struct regmap_config realtek_mdio_regmap_config =3D {
> -       .reg_bits =3D 10, /* A4..A0 R4..R0 */
> -       .val_bits =3D 16,
> -       .reg_stride =3D 1,
> -       /* PHY regs are at 0x8000 */
> -       .max_register =3D 0xffff,
> -       .reg_format_endian =3D REGMAP_ENDIAN_BIG,
> +static const struct realtek_common_info realtek_mdio_info =3D {
>         .reg_read =3D realtek_mdio_read,
>         .reg_write =3D realtek_mdio_write,
> -       .cache_type =3D REGCACHE_NONE,
> -       .lock =3D realtek_common_lock,
> -       .unlock =3D realtek_common_unlock,
> -};
> -
> -static const struct regmap_config realtek_mdio_nolock_regmap_config =3D =
{
> -       .reg_bits =3D 10, /* A4..A0 R4..R0 */
> -       .val_bits =3D 16,
> -       .reg_stride =3D 1,
> -       /* PHY regs are at 0x8000 */
> -       .max_register =3D 0xffff,
> -       .reg_format_endian =3D REGMAP_ENDIAN_BIG,
> -       .reg_read =3D realtek_mdio_read,
> -       .reg_write =3D realtek_mdio_write,
> -       .cache_type =3D REGCACHE_NONE,
> -       .disable_locking =3D true,
>  };
>
>  int realtek_mdio_probe(struct mdio_device *mdiodev)
> @@ -134,8 +112,7 @@ int realtek_mdio_probe(struct mdio_device *mdiodev)
>         struct realtek_priv *priv;
>         int ret;
>
> -       priv =3D realtek_common_probe(dev, realtek_mdio_regmap_config,
> -                                   realtek_mdio_nolock_regmap_config);
> +       priv =3D realtek_common_probe(dev, &realtek_mdio_info);
>         if (IS_ERR(priv))
>                 return PTR_ERR(priv);
>
> diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/real=
tek/realtek-smi.c
> index fc54190839cf..7697dc66e5e8 100644
> --- a/drivers/net/dsa/realtek/realtek-smi.c
> +++ b/drivers/net/dsa/realtek/realtek-smi.c
> @@ -312,33 +312,6 @@ static int realtek_smi_read(void *ctx, u32 reg, u32 =
*val)
>         return realtek_smi_read_reg(priv, reg, val);
>  }
>
> -static const struct regmap_config realtek_smi_regmap_config =3D {
> -       .reg_bits =3D 10, /* A4..A0 R4..R0 */
> -       .val_bits =3D 16,
> -       .reg_stride =3D 1,
> -       /* PHY regs are at 0x8000 */
> -       .max_register =3D 0xffff,
> -       .reg_format_endian =3D REGMAP_ENDIAN_BIG,
> -       .reg_read =3D realtek_smi_read,
> -       .reg_write =3D realtek_smi_write,
> -       .cache_type =3D REGCACHE_NONE,
> -       .lock =3D realtek_common_lock,
> -       .unlock =3D realtek_common_unlock,
> -};
> -
> -static const struct regmap_config realtek_smi_nolock_regmap_config =3D {
> -       .reg_bits =3D 10, /* A4..A0 R4..R0 */
> -       .val_bits =3D 16,
> -       .reg_stride =3D 1,
> -       /* PHY regs are at 0x8000 */
> -       .max_register =3D 0xffff,
> -       .reg_format_endian =3D REGMAP_ENDIAN_BIG,
> -       .reg_read =3D realtek_smi_read,
> -       .reg_write =3D realtek_smi_write,
> -       .cache_type =3D REGCACHE_NONE,
> -       .disable_locking =3D true,
> -};
> -
>  static int realtek_smi_mdio_read(struct mii_bus *bus, int addr, int regn=
um)
>  {
>         struct realtek_priv *priv =3D bus->priv;
> @@ -396,14 +369,18 @@ static int realtek_smi_setup_mdio(struct dsa_switch=
 *ds)
>         return ret;
>  }
>
> +static const struct realtek_common_info realtek_smi_info =3D {
> +       .reg_read =3D realtek_smi_read,
> +       .reg_write =3D realtek_smi_write,
> +};
> +
>  int realtek_smi_probe(struct platform_device *pdev)
>  {
>         struct device *dev =3D &pdev->dev;
>         struct realtek_priv *priv;
>         int ret;
>
> -       priv =3D realtek_common_probe(dev, realtek_smi_regmap_config,
> -                                   realtek_smi_nolock_regmap_config);
> +       priv =3D realtek_common_probe(dev, &realtek_smi_info);
>         if (IS_ERR(priv))
>                 return PTR_ERR(priv);
>
> --
> 2.34.1
>

I don't have a strong opinion on how the regmap config is prepared.
I'll adopt your suggestion, with some minor changes.

Regmap config for realtek dsa driver should be composed of values that
(should) depend on the variant, the management interface (read/write)
and some common values. Today it is only dependent on the interface
and common values (with register range being a forced coincidence).
However, that is a topic for another series. We do need to stop this
series at some point. It already has 11 patches (and not counting the
2 bindings + 1 code that are actually my target). We already have some
nice features for delivery.

Regards,

Luiz

