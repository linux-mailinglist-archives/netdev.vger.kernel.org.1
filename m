Return-Path: <netdev+bounces-213940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581DAB276A9
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 05:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53770603010
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F35A29C341;
	Fri, 15 Aug 2025 03:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kHvVaBrK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A546292B4B
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 03:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755227909; cv=none; b=P8p1ievTEPxzF+MO99oXwHC66TMOwtrcXgqN0o8gCssKhIlgPWTwlD3S0gCcmZJBs+SqkzRBjVEe+a5vNAUqkdhovmcnrULQlVfFIpHYx0tomtHazh2BSwIoGPXzc7228zjFpQ14tHgAyVNvP48xcTvn+cbEAEt8UWhIiG6O2+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755227909; c=relaxed/simple;
	bh=jKT5nWw9vmP9Z0FRgLZt/Ds93pTqdST6BRO8N8k9BMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHelsyVZvefMFfLN+mTrDJgNDsIlPpi4rRoIsfD7ZUTzBD6l/b/fCFrdZ2C+/Q/oBFx8NfNXLtqNl2N+nTo58VGXSspoZffbu/PHnXakChxBq9YFQWNHXt/Q3ZoZL2EvcwLxskwB1CgEEbIj8mYKZXJkwG0DCoZUnfB/4c5LU14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kHvVaBrK; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-333f9145edaso11226041fa.2
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 20:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755227905; x=1755832705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/gqheUAiJBZVnBDKCO9AHvkTlNKIjI8xnUPe2UrTYE=;
        b=kHvVaBrK+uGmIhpE/x6XrTpzkz8RDBNzFnitv0fywrymBq/hWzG20467ns6WN4qdpz
         s0fZOVDyDUwLLvUtBY8mSMl9oGeGV0kG4BoVFrqt8Aar+rTY2/lLGsg6Yo3OnLLN1KFd
         Y176X7Ywq6clpYfRP8CoR02Qe2hqyisadMBAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755227905; x=1755832705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/gqheUAiJBZVnBDKCO9AHvkTlNKIjI8xnUPe2UrTYE=;
        b=G7H3FwEdTZNQh+Cld5IQv5e5qnJ4CXT1bT2+OmaWUef3lw0+6f0aXYDBATFFHp2aMw
         2EaMZSnC7W/x0ekiPaYi/C0fxbJ+Tz9UHouXfvFgQAjbuiwV2Ak//CFC5LZscYFVwDDN
         h+33SM2EEMBC7YNtmE+HOEZwM179z4pANxlFugKvb91g3dEgxrIpEDddEDgWoY2vD2Wb
         Xgl2WaDVAXDuJTn5dIb2sUSK/yie3lbpNg7EFLogf8OpVa4mc3vzeLU6Ua7XPLBiLhT3
         K87M6Qc28pJU3GmrQq5XetWOXRzzaBp3Z8DiUTZpcSqHrk3TJrrXYg/9f28PGHlIkZ9O
         /Dpg==
X-Forwarded-Encrypted: i=1; AJvYcCUqjubwevwG5KEGSrBXwMQgOTO+FJFH05Q/0qsjfyEpa7nvzeD7hd6EUZlLbJZBiw+hOolssDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQxB0AOarD2vywYVCSmWbBuGSuPPckZN4laD2GUClRJQAXNBby
	8KFuYK2KVBUk28ew3MfGUBSe/HcdDLJWFA5G+Xy5fZmLGGHwin91mNI+IHO4YbJikFOICiffvMW
	exxGp2ArQykZklFgdy5XkiY5PtCWdRX5D9rYTelLa
X-Gm-Gg: ASbGncsaAj9Q2CRyfGW9/9aLTeN9Trp7yQ3WiMFCQGUf4UHFpVZTawoHhtb3V800aKB
	tmN4RH3rD5aLw3iXrddplr+VtHsP5ENlgzbhUr+ipNCRwDb4mzW6acTSTLi479Sy2BV2bFFtNbt
	0gATx4hT9cWE3a2SxZWR1B68tOEoYxx0Ngm8JwXoqonm2PveAB8ihTvpxvibU1Vb/bM5NqyFcWH
	X7jtYTPmjYT8IGP3aTOkhVja+0MtK19t7iUGg==
X-Google-Smtp-Source: AGHT+IH45CMxbyHBWhXJ/RabdXbIvSLoKeM5EMqrf7xlLady27fRhPu6U8KzyNXc6RGLGWgakK4Y6MekAcD2c3hLvVo=
X-Received: by 2002:a2e:b8c5:0:b0:332:6304:3076 with SMTP id
 38308e7fff4ca-33409809835mr1950611fa.1.1755227905389; Thu, 14 Aug 2025
 20:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805135447.149231-1-laura.nao@collabora.com> <20250805135447.149231-3-laura.nao@collabora.com>
In-Reply-To: <20250805135447.149231-3-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 15 Aug 2025 12:18:14 +0900
X-Gm-Features: Ac12FXwqbJqR6dXDCHoREy9cuJVuDHi_sxjr2uRku7Hw7ujClZ2WhTJ_l5duokI
Message-ID: <CAGXv+5Fnaict=9Agixn1vCrP3GkugaR3qEKmEYyYiXCGx8ZZ6w@mail.gmail.com>
Subject: Re: [PATCH v4 02/27] clk: mediatek: clk-pll: Add ops for PLLs using
 set/clr regs and FENC
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com, =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 10:55=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> MT8196 uses a combination of set/clr registers to control the PLL
> enable state, along with a FENC bit to check the preparation status.
> Add new set of PLL clock operations with support for set/clr enable and
> FENC status logic.
>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  drivers/clk/mediatek/clk-pll.c | 42 +++++++++++++++++++++++++++++++++-
>  drivers/clk/mediatek/clk-pll.h |  5 ++++
>  2 files changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pl=
l.c
> index 49ca25dd5418..8f46de77f42d 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -37,6 +37,13 @@ int mtk_pll_is_prepared(struct clk_hw *hw)
>         return (readl(pll->en_addr) & BIT(pll->data->pll_en_bit)) !=3D 0;
>  }
>
> +static int mtk_pll_fenc_is_prepared(struct clk_hw *hw)
> +{
> +       struct mtk_clk_pll *pll =3D to_mtk_clk_pll(hw);
> +
> +       return readl(pll->fenc_addr) & pll->fenc_mask;

Nits:

I'd do a double-negate (!!) just to indicate that we only care about
true or false.

Also, why do we need to store fenc_mask instead of just shifting the bit
here? Same goes for the register address. |pll| has the base address.
Why do we need to pre-calculate it?

The code is OK; it just seems a bit wasteful on memory.

Either way, this is

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> +}
> +
>  static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 =
fin,
>                 u32 pcw, int postdiv)
>  {
> @@ -274,6 +281,25 @@ void mtk_pll_unprepare(struct clk_hw *hw)
>         writel(r, pll->pwr_addr);
>  }
>
> +static int mtk_pll_prepare_setclr(struct clk_hw *hw)
> +{
> +       struct mtk_clk_pll *pll =3D to_mtk_clk_pll(hw);
> +
> +       writel(BIT(pll->data->pll_en_bit), pll->en_set_addr);
> +
> +       /* Wait 20us after enable for the PLL to stabilize */
> +       udelay(20);
> +
> +       return 0;
> +}
> +
> +static void mtk_pll_unprepare_setclr(struct clk_hw *hw)
> +{
> +       struct mtk_clk_pll *pll =3D to_mtk_clk_pll(hw);
> +
> +       writel(BIT(pll->data->pll_en_bit), pll->en_clr_addr);
> +}
> +
>  const struct clk_ops mtk_pll_ops =3D {
>         .is_prepared    =3D mtk_pll_is_prepared,
>         .prepare        =3D mtk_pll_prepare,
> @@ -283,6 +309,16 @@ const struct clk_ops mtk_pll_ops =3D {
>         .set_rate       =3D mtk_pll_set_rate,
>  };
>
> +const struct clk_ops mtk_pll_fenc_clr_set_ops =3D {
> +       .is_prepared    =3D mtk_pll_fenc_is_prepared,
> +       .prepare        =3D mtk_pll_prepare_setclr,
> +       .unprepare      =3D mtk_pll_unprepare_setclr,
> +       .recalc_rate    =3D mtk_pll_recalc_rate,
> +       .round_rate     =3D mtk_pll_round_rate,
> +       .set_rate       =3D mtk_pll_set_rate,
> +};
> +EXPORT_SYMBOL_GPL(mtk_pll_fenc_clr_set_ops);
> +
>  struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
>                                         const struct mtk_pll_data *data,
>                                         void __iomem *base,
> @@ -315,6 +351,9 @@ struct clk_hw *mtk_clk_register_pll_ops(struct mtk_cl=
k_pll *pll,
>         pll->hw.init =3D &init;
>         pll->data =3D data;
>
> +       pll->fenc_addr =3D base + data->fenc_sta_ofs;
> +       pll->fenc_mask =3D BIT(data->fenc_sta_bit);
> +
>         init.name =3D data->name;
>         init.flags =3D (data->flags & PLL_AO) ? CLK_IS_CRITICAL : 0;
>         init.ops =3D pll_ops;
> @@ -337,12 +376,13 @@ struct clk_hw *mtk_clk_register_pll(const struct mt=
k_pll_data *data,
>  {
>         struct mtk_clk_pll *pll;
>         struct clk_hw *hw;
> +       const struct clk_ops *pll_ops =3D data->ops ? data->ops : &mtk_pl=
l_ops;
>
>         pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
>         if (!pll)
>                 return ERR_PTR(-ENOMEM);
>
> -       hw =3D mtk_clk_register_pll_ops(pll, data, base, &mtk_pll_ops);
> +       hw =3D mtk_clk_register_pll_ops(pll, data, base, pll_ops);
>         if (IS_ERR(hw))
>                 kfree(pll);
>
> diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pl=
l.h
> index c4d06bb11516..7fdc5267a2b5 100644
> --- a/drivers/clk/mediatek/clk-pll.h
> +++ b/drivers/clk/mediatek/clk-pll.h
> @@ -29,6 +29,7 @@ struct mtk_pll_data {
>         u32 reg;
>         u32 pwr_reg;
>         u32 en_mask;
> +       u32 fenc_sta_ofs;
>         u32 pd_reg;
>         u32 tuner_reg;
>         u32 tuner_en_reg;
> @@ -51,6 +52,7 @@ struct mtk_pll_data {
>         u32 en_clr_reg;
>         u8 pll_en_bit; /* Assume 0, indicates BIT(0) by default */
>         u8 pcw_chg_bit;
> +       u8 fenc_sta_bit;
>  };
>
>  /*
> @@ -72,6 +74,8 @@ struct mtk_clk_pll {
>         void __iomem    *en_addr;
>         void __iomem    *en_set_addr;
>         void __iomem    *en_clr_addr;
> +       void __iomem    *fenc_addr;
> +       u32             fenc_mask;
>         const struct mtk_pll_data *data;
>  };
>
> @@ -82,6 +86,7 @@ void mtk_clk_unregister_plls(const struct mtk_pll_data =
*plls, int num_plls,
>                              struct clk_hw_onecell_data *clk_data);
>
>  extern const struct clk_ops mtk_pll_ops;
> +extern const struct clk_ops mtk_pll_fenc_clr_set_ops;
>
>  static inline struct mtk_clk_pll *to_mtk_clk_pll(struct clk_hw *hw)
>  {
> --
> 2.39.5
>

