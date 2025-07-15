Return-Path: <netdev+bounces-207011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 890C1B05346
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98CC7B7722
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 07:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6622701A3;
	Tue, 15 Jul 2025 07:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SACTP6Vx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B326FD91
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 07:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752564497; cv=none; b=u5CNrpFzUeXsO1IAUdwvkJyO1Pyh4vsrguk+bX99ElD/el8DT3uiLvHaxn4Am66ZNbO+5kD3Od4WSEnMZQZJ+MlgbQb541OI+DEOwRC2xywFAEAJjkwCdhvBmt1dDx1XaBeSgZKLTwV2Q91DjgXjUnWHsf6X+ws17MqF5WR7zX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752564497; c=relaxed/simple;
	bh=BK4PRwXIV83i4q+617lou8DQ231b26kX7zcVhKVZMmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1YQSg9QfOqpy3AJ29z3FT3l87yq52YpP58DsPQetrhKydWZI6pYzpW7KEi/EnDfeaIkMtzNLvOwxUXgVUU6+RM37szpRCRj16nEjYvXsdFd3euyI4tKux8BwBItkwqRSyV5TTtFRaJjoMCfaXHnH3qsURe8fEsF/kWgNd5IjNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SACTP6Vx; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553b5165cf5so6261020e87.0
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 00:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752564493; x=1753169293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZzpiYZwNaf+7GMBi0VLlcvQKHbRH+NQQeTOtdaqsaY=;
        b=SACTP6Vxysm66Ktsx+EWd1HmyJguBTFQ01wPveYd0GcEmc8vGi916XUyRaIqMbctRm
         JBgPm2sNdX7kHdoYfbj1EsOS9SLgtKvU70OpBKwdUYg53b8S3TRWqrok+dRgfTVGgOCo
         kPtWvXtBZsK/ZteLzm6adGWExHPLt4xIcXXEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752564493; x=1753169293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZzpiYZwNaf+7GMBi0VLlcvQKHbRH+NQQeTOtdaqsaY=;
        b=uEaLhrwRZr9jrOZuoZ5qW1cped57Rp49rzt/OZpD9TOVOVxJqCtylyar967JVnaYc5
         bsIiaNNGwaH9Qvrao/PF7DxXZiWr5SgEEx12v/J2wXGDKG6c7yfu7srqYcdhdT65ArL0
         vIY1zPWI9rLMTqjJXO/8Y9BcbCjSKYVqScUihkfAAUt+uQaR2aSWYE9jA+bV0WjLjocl
         Cw1KplGZFSrMBuYHt0fCv1b/u7Zl/zXjihcDiCp3QytRQE6p0/L00bfHks+K3qkigF0q
         0rXoayROTbRzc0rEGL0XA2lNQPciG1bKw2F1nh38BB444gyiVqiK173tih+4eSGqB/PP
         kvyg==
X-Forwarded-Encrypted: i=1; AJvYcCXfMBovirA2WGVC50VvgDx5OKnVKLNRrGYwltWoR8ko1FGb4H4TBnfXxSkBajPJLDpEZFKmIcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcSC2i29dPkkgA5X2XQ3XL0AtzhZNTENv5mtC1xyrnxx/LvKvw
	Lim/lcvyzhLjBD9HUc1M4S784sb5cbdmFe5R4E2P3B5sfM0bA07Qg9uLSUhHTA2WLmei9Z1MWed
	1IC3kRwmaZAxNufLThpNiQAPPuLZIic4robc7j6b4
X-Gm-Gg: ASbGncsQK4S0dLCYgFfhTsrFJshblYEieCTRHD+DREhgj9AT6XAFhfK2jcXCywDqMNA
	c4TARO23flkBALcoGh1SL0st5RhQNX6yrlYaGq/Lc1+2+NxcU4IWVvql48qjjsEkxEG1tIvWJwk
	MgaHs5WN3obNopy9ANUbX9SYi28UaGOs7r/+mbUaJUjEsNhS1Jk96LA4KOf6AWWie/EL6e14zM5
	MtFUfRVsytHKgZMbc5PUvKvUtI/8/nCuGWl4hupn11yEg==
X-Google-Smtp-Source: AGHT+IE+I2EKW/Vlk3fRtykPHngODTfgQlgraXU23nzszgS13v7r+PoSUsWI29YIuHFK4Z4/TZxfjJyjsgNva6Nvih0=
X-Received: by 2002:a05:6512:23a0:b0:553:a32a:6c6 with SMTP id
 2adb3069b0e04-55a058cca78mr3983896e87.51.1752564492768; Tue, 15 Jul 2025
 00:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624143220.244549-1-laura.nao@collabora.com> <20250624143220.244549-15-laura.nao@collabora.com>
In-Reply-To: <20250624143220.244549-15-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 15 Jul 2025 15:28:01 +0800
X-Gm-Features: Ac12FXyU8Sq6NaxHfbh3KFMLAH5aLMP41sVO2AcuKk50klccx7LXTjHhhdUwccY
Message-ID: <CAGXv+5EsVOPC+i2=9d-Be1U-DuB8tPDAyokzhTOeVZQtZJ9+CQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/29] clk: mediatek: Add MT8196 vlpckgen clock support
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


On Tue, Jun 24, 2025 at 10:33=E2=80=AFPM Laura Nao <laura.nao@collabora.com=
> wrote:
>
> Add support for the MT8196 vlpckgen clock controller, which provides
> muxes and dividers for clock selection in other IP blocks.
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  drivers/clk/mediatek/Makefile              |   2 +-
>  drivers/clk/mediatek/clk-mt8196-vlpckgen.c | 769 +++++++++++++++++++++
>  2 files changed, 770 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/mediatek/clk-mt8196-vlpckgen.c
>
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefil=
e
> index 0688d7bf4979..24683dd51783 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -161,7 +161,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) +=3D clk-mt81=
95-venc.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS) +=3D clk-mt8195-vpp0.o clk-mt8195=
-vpp1.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) +=3D clk-mt8195-wpe.o
>  obj-$(CONFIG_COMMON_CLK_MT8196) +=3D clk-mt8196-apmixedsys.o clk-mt8196-=
topckgen.o \
> -                                  clk-mt8196-topckgen2.o
> +                                  clk-mt8196-topckgen2.o clk-mt8196-vlpc=
kgen.o
>  obj-$(CONFIG_COMMON_CLK_MT8365) +=3D clk-mt8365-apmixedsys.o clk-mt8365.=
o
>  obj-$(CONFIG_COMMON_CLK_MT8365_APU) +=3D clk-mt8365-apu.o
>  obj-$(CONFIG_COMMON_CLK_MT8365_CAM) +=3D clk-mt8365-cam.o
> diff --git a/drivers/clk/mediatek/clk-mt8196-vlpckgen.c b/drivers/clk/med=
iatek/clk-mt8196-vlpckgen.c
> new file mode 100644
> index 000000000000..23a673dd4c5c
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8196-vlpckgen.c
> @@ -0,0 +1,769 @@

[...]

> +static const char * const vlp_camtg0_parents[] =3D {
> +       "clk26m",
> +       "univpll_192m_d32",
> +       "univpll_192m_d16",
> +       "clk13m",
> +       "osc_d40",
> +       "osc_d32",
> +       "univpll_192m_d10",
> +       "univpll_192m_d8",
> +       "univpll_d6_d16",
> +       "ulposc3",
> +       "osc_d20",
> +       "ck2_tvdpll1_d16",
> +       "univpll_d6_d8"
> +};

It seems all the vlp_camtg* parents are the same. Please merge them
and just have one list.

> +static const char * const vlp_sspm_26m_parents[] =3D {
> +       "clk26m",
> +       "osc_d20"
> +};
> +
> +static const char * const vlp_ulposc_sspm_parents[] =3D {
> +       "clk26m",
> +       "osc_d2",
> +       "mainpll_d4_d2"
> +};
> +
> +static const char * const vlp_vlp_pbus_26m_parents[] =3D {
> +       "clk26m",
> +       "osc_d20"
> +};
> +
> +static const char * const vlp_debug_err_flag_parents[] =3D {
> +       "clk26m",
> +       "osc_d20"
> +};
> +
> +static const char * const vlp_dpmsrdma_parents[] =3D {
> +       "clk26m",
> +       "mainpll_d7_d2"
> +};
> +
> +static const char * const vlp_vlp_pbus_156m_parents[] =3D {
> +       "clk26m",
> +       "osc_d2",
> +       "mainpll_d7_d2",
> +       "mainpll_d7"
> +};
> +
> +static const char * const vlp_spm_parents[] =3D {
> +       "clk26m",
> +       "mainpll_d7_d4"
> +};
> +
> +static const char * const vlp_mminfra_parents[] =3D {
> +       "clk26m",
> +       "osc_d4",
> +       "mainpll_d3"
> +};
> +
> +static const char * const vlp_usb_parents[] =3D {
> +       "clk26m",
> +       "mainpll_d9"
> +};

The previous and the next one are the same.

> +static const char * const vlp_usb_xhci_parents[] =3D {
> +       "clk26m",
> +       "mainpll_d9"
> +};
> +
> +static const char * const vlp_noc_vlp_parents[] =3D {
> +       "clk26m",
> +       "osc_d20",
> +       "mainpll_d9"
> +};
> +
> +static const char * const vlp_audio_h_parents[] =3D {
> +       "clk26m",
> +       "vlp_apll1",
> +       "vlp_apll2"
> +};
> +
> +static const char * const vlp_aud_engen1_parents[] =3D {
> +       "clk26m",
> +       "apll1_d8",
> +       "apll1_d4"
> +};

The previous and the next one are the same.

> +static const char * const vlp_aud_engen2_parents[] =3D {
> +       "clk26m",
> +       "apll2_d8",
> +       "apll2_d4"
> +};
> +
> +static const char * const vlp_aud_intbus_parents[] =3D {
> +       "clk26m",
> +       "mainpll_d7_d4",
> +       "mainpll_d4_d4"
> +};
> +
> +static const char * const vlp_spvlp_26m

[...]

> +static int clk_mt8196_vlp_probe(struct platform_device *pdev)
> +{
> +       struct clk_hw_onecell_data *clk_data;
> +       int r;
> +       struct device_node *node =3D pdev->dev.of_node;
> +
> +       clk_data =3D mtk_alloc_clk_data(ARRAY_SIZE(vlp_muxes) +
> +                                     ARRAY_SIZE(vlp_plls));
> +       if (!clk_data)
> +               return -ENOMEM;
> +
> +       r =3D mtk_clk_register_muxes(&pdev->dev, vlp_muxes, ARRAY_SIZE(vl=
p_muxes),
> +                                  node, &mt8196_clk_vlp_lock, clk_data);
> +       if (r)
> +               goto free_clk_data;
> +
> +       r =3D mtk_clk_register_plls(node, vlp_plls, ARRAY_SIZE(vlp_plls),
> +                                 clk_data);
> +       if (r)
> +               goto unregister_muxes;
> +
> +       r =3D of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_dat=
a);
> +       if (r)
> +               goto unregister_plls;
> +
> +       platform_set_drvdata(pdev, clk_data);
> +
> +       return r;
> +
> +unregister_plls:
> +       mtk_clk_unregister_plls(vlp_plls, ARRAY_SIZE(vlp_plls), clk_data)=
;
> +unregister_muxes:
> +       mtk_clk_unregister_muxes(vlp_muxes, ARRAY_SIZE(vlp_muxes), clk_da=
ta);
> +free_clk_data:
> +       mtk_free_clk_data(clk_data);

The AFE driver sets some tuner parameters in the VLPCKGEN block at probe
time. Maybe we could do that here instead?

/* vlp_cksys_clk: 0x1c016000 */
#define VLP_APLL1_TUNER_CON0 0x02a4
#define VLP_APLL2_TUNER_CON0 0x02a8

/* vlp apll1 tuner default value*/
#define VLP_APLL1_TUNER_CON0_VALUE 0x6f28bd4d
/* vlp apll2 tuner default value + 1*/
#define VLP_APLL2_TUNER_CON0_VALUE 0x78fd5265

       regmap_write(afe_priv->vlp_ck, VLP_APLL1_TUNER_CON0,
VLP_APLL1_TUNER_CON0_VALUE);
       regmap_write(afe_priv->vlp_ck, VLP_APLL2_TUNER_CON0,
VLP_APLL2_TUNER_CON0_VALUE);

ChenYu

> +
> +       return r;
> +}
> +
> +static void clk_mt8196_vlp_remove(struct platform_device *pdev)
> +{
> +       struct clk_hw_onecell_data *clk_data =3D platform_get_drvdata(pde=
v);
> +       struct device_node *node =3D pdev->dev.of_node;
> +
> +       of_clk_del_provider(node);
> +       mtk_clk_unregister_plls(vlp_plls, ARRAY_SIZE(vlp_plls), clk_data)=
;
> +       mtk_clk_unregister_muxes(vlp_muxes, ARRAY_SIZE(vlp_muxes), clk_da=
ta);
> +       mtk_free_clk_data(clk_data);
> +}
> +
> +static const struct of_device_id of_match_clk_mt8196_vlp_ck[] =3D {
> +       { .compatible =3D "mediatek,mt8196-vlpckgen" },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_vlp_ck);
> +
> +static struct platform_driver clk_mt8196_vlp_drv =3D {
> +       .probe =3D clk_mt8196_vlp_probe,
> +       .remove =3D clk_mt8196_vlp_remove,
> +       .driver =3D {
> +               .name =3D "clk-mt8196-vlpck",
> +               .of_match_table =3D of_match_clk_mt8196_vlp_ck,
> +       },
> +};
> +
> +MODULE_DESCRIPTION("MediaTek MT8196 VLP clock generator driver");
> +module_platform_driver(clk_mt8196_vlp_drv);
> +MODULE_LICENSE("GPL");
> --
> 2.39.5
>

