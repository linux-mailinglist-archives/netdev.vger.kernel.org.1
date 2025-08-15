Return-Path: <netdev+bounces-213947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DED4EB276FB
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 05:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA6D97BAD48
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222951EE7DC;
	Fri, 15 Aug 2025 03:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n6P0IZ3d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E1020E31B
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 03:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755229341; cv=none; b=MghWuclN0qe3XY7JlaPLD6E9Jy6nsl6W/cSKgnQ16tzFjSGYymp3DLYnoGDWEq9KVfyxxtSOf2YHACxLgM291gyRznEuIL/uiyTngU6EnjG3Su6RvoODN8aqOdWuRjb/NidT4dJS9/9x8WFvOa+PS5k42kigGw0swbucBHtz2uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755229341; c=relaxed/simple;
	bh=vsQ52WTwmO3+8ssw1w1cMYYmcVawrOSq6WzepbrpO70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJc+f/QPzdBdabgV5+r9zrmdHodFPEF61GRL/3guLIl6dAz2NeJ1c5tN3/AcA6nram3MALlIz9aiblARZjPtGs9Io9q3lzpCTfAJCQv7CF+RqFcFaLftkyCAX6/eAs51XJJUcshxXMByV1q6BbuF5OiIBqUiNWkaHTtG8uRGjfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n6P0IZ3d; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55ce4b9c904so1940313e87.0
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 20:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755229337; x=1755834137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLAZnsZy8mysFSYeQu/zRgcIgupbd8f4aYQXFFI2MWI=;
        b=n6P0IZ3dVwDyLuzIVnFEG9e8AzVR+RUueC+3GZKs95LqUkbTrECHkRIKM74+Q0KBfE
         IaXH4cTmi6cQ5ePzxrRKjW24eg6mn/tfbtZBy8BLLzZBU8+OA4WjUcpM/PIA114pFehW
         WCKday2Y/RZxYJoSYcI8ZSUe/4+RCpKFcy8rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755229337; x=1755834137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLAZnsZy8mysFSYeQu/zRgcIgupbd8f4aYQXFFI2MWI=;
        b=rERC5nGIqavH6hZ3KN+q/Q0H/Plw2GXnB95HjYVdY8/AfMpNHlrAC4uLsHYMoL0vkI
         Z1oOxVihuGEteNde2kKC+u6EGYo6ezeSs4nChgC0j6fpapqVp1Qv0vrdNR9h7zSqQGpM
         0bv/MQwJ8Fc7Btyw0xoPoq0LHAGFqEIOAiGyKmw2LR1JlmEUvQt19zNZDjaKKKI6M0oX
         NM+pIa8akxjftr25GjvT+RFhvE7XMJqo88q14QJMfetY/pAoAnwPse7uOnRvEpnlnzsz
         ZfqzDT01JkOof/9NZNgj21XLElm//De09U40RyBamUmP/P4wNf4uxzhWmwpzEFljNvwJ
         WQ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+M1NVZLN+rOECvroEzcRdGrsuCUCvhQEpQzSPL7KuIKaqJi5TgfDUn+UKI1zwswVQ8deLRDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8eXrQOCsAFry1ZOJ6lrFqyIpJzeab0bbmx1rRZ2T10TtOWmRe
	5loWb2ACqreE/kBeNUfnlNEKRUzDk3nVhIyRwlzGzAB6mrBFtmIKRQd7tt+OWS73/cDlfKGyodN
	0zozSSTfsCoUzRuNiNp+GJpOWfo6junTdq5jVc+1b
X-Gm-Gg: ASbGncum4+jr9L98NakKB1Oho75wIywPcz/B9V6avv0fvERgnVrpbU730CANKEypTm9
	9i/gOjW7h/kPkK0pxFgcmtk3MDKnfJPpXdEC7G27qRPu5FX4s6YM8QT68IMztkOG7XcYm+ZL9Z/
	WQxhEDnORaLTV5cnJLuDaeKLsYQ7nBkNgzWw2N85/RH7F3ewr299bRRkrIVF8kjSgZQ6nos55hj
	o58dGB/ZpcTTU9Ey5sIfdzZaTN+9aIm35DdUw==
X-Google-Smtp-Source: AGHT+IG4MHT9xlQA8q+aRzeI2TOWcXJ3eWM4zAEjXRmpGzb6++EC3UVO4G2WwSWQHvNm7WXOwl7nEj1UnHJTPSq8Yys=
X-Received: by 2002:a05:6512:230a:b0:55c:d6c9:38df with SMTP id
 2adb3069b0e04-55ce62cd258mr1499674e87.21.1755229337315; Thu, 14 Aug 2025
 20:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805135447.149231-1-laura.nao@collabora.com> <20250805135447.149231-7-laura.nao@collabora.com>
In-Reply-To: <20250805135447.149231-7-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 15 Aug 2025 12:42:06 +0900
X-Gm-Features: Ac12FXy2dCuPlbnz3eN56WS0B1sITUha0hiPx6j9G95oILsqMsxPgE4MrEBU4UM
Message-ID: <CAGXv+5GxJs03EcMt0jm-x_fDuy_RtCrnOmyJvVVgAP9O9R6E2Q@mail.gmail.com>
Subject: Re: [PATCH v4 06/27] clk: mediatek: clk-gate: Refactor
 mtk_clk_register_gate to use mtk_gate struct
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
> MT8196 uses a HW voter for gate enable/disable control, with
> set/clr/sta registers located in a separate regmap. Refactor
> mtk_clk_register_gate() to take a struct mtk_gate instead of individual
> parameters, avoiding the need to add three extra arguments to support
> HW voter register offsets.
>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  drivers/clk/mediatek/clk-gate.c | 35 ++++++++++++---------------------
>  1 file changed, 13 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-g=
ate.c
> index 67d9e741c5e7..0375ccad4be3 100644
> --- a/drivers/clk/mediatek/clk-gate.c
> +++ b/drivers/clk/mediatek/clk-gate.c
> @@ -152,12 +152,9 @@ const struct clk_ops mtk_clk_gate_ops_no_setclr_inv =
=3D {
>  };
>  EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_no_setclr_inv);
>
> -static struct clk_hw *mtk_clk_register_gate(struct device *dev, const ch=
ar *name,
> -                                        const char *parent_name,
> -                                        struct regmap *regmap, int set_o=
fs,
> -                                        int clr_ofs, int sta_ofs, u8 bit=
,
> -                                        const struct clk_ops *ops,
> -                                        unsigned long flags)
> +static struct clk_hw *mtk_clk_register_gate(struct device *dev,
> +                                               const struct mtk_gate *ga=
te,
> +                                               struct regmap *regmap)
>  {
>         struct mtk_clk_gate *cg;
>         int ret;
> @@ -167,17 +164,17 @@ static struct clk_hw *mtk_clk_register_gate(struct =
device *dev, const char *name
>         if (!cg)
>                 return ERR_PTR(-ENOMEM);
>
> -       init.name =3D name;
> -       init.flags =3D flags | CLK_SET_RATE_PARENT;
> -       init.parent_names =3D parent_name ? &parent_name : NULL;
> -       init.num_parents =3D parent_name ? 1 : 0;
> -       init.ops =3D ops;
> +       init.name =3D gate->name;
> +       init.flags =3D gate->flags | CLK_SET_RATE_PARENT;
> +       init.parent_names =3D gate->parent_name ? &gate->parent_name : NU=
LL;
> +       init.num_parents =3D gate->parent_name ? 1 : 0;
> +       init.ops =3D gate->ops;
>
>         cg->regmap =3D regmap;
> -       cg->set_ofs =3D set_ofs;
> -       cg->clr_ofs =3D clr_ofs;
> -       cg->sta_ofs =3D sta_ofs;
> -       cg->bit =3D bit;
> +       cg->set_ofs =3D gate->regs->set_ofs;
> +       cg->clr_ofs =3D gate->regs->clr_ofs;
> +       cg->sta_ofs =3D gate->regs->sta_ofs;
> +       cg->bit =3D gate->shift;

I'd rather see |struct mtk_clk_gate| (the runtime data) gain a pointer
to the static data |struct mtk_gate| instead of doing all the copying.
This is just needless duplication.

ChenYu

>         cg->hw.init =3D &init;
>
> @@ -228,13 +225,7 @@ int mtk_clk_register_gates(struct device *dev, struc=
t device_node *node,
>                         continue;
>                 }
>
> -               hw =3D mtk_clk_register_gate(dev, gate->name, gate->paren=
t_name,
> -                                           regmap,
> -                                           gate->regs->set_ofs,
> -                                           gate->regs->clr_ofs,
> -                                           gate->regs->sta_ofs,
> -                                           gate->shift, gate->ops,
> -                                           gate->flags);
> +               hw =3D mtk_clk_register_gate(dev, gate, regmap);
>
>                 if (IS_ERR(hw)) {
>                         pr_err("Failed to register clk %s: %pe\n", gate->=
name,
> --
> 2.39.5
>

