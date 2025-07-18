Return-Path: <netdev+bounces-208104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B378DB09E04
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 10:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C61563E4E
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 08:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF02293B7E;
	Fri, 18 Jul 2025 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jcUY6gG9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8702224891
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752827497; cv=none; b=hjgYtlMRu9sYRnxnE8dsznr3Dy64Ta/lWqdOcIjqvEu14ZxdlcrqYJbC+CXk9KLFN6MHGjlbrcKPCsVJmf6VgChHQ3cLA/kzZalJyFa7KNIowdSEPjrdcqaSYc7GvABh0RheLhRgF1rkSrHZVUup9sOJVFLF2xcj2dXnTOTrXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752827497; c=relaxed/simple;
	bh=Yba3a+fvg4oQMcRXf/uCECjshMtgdjfwvuJXl0/DER8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbFTHu5JEAwkueIA+KBpv1nHFMRoVS2e1BT8XnB4nUyX6kJzXms/5ZqQOCDconqhArXUVF5tVlCrwL+83Ok881zMFMhLDWS7E8EC2GOJceMOQnO2Lqu4XWzLdKNNjWh1+x7YDKJRC1PPBo8qBfRmE3myUHyDHbyZgmOVd0HTXoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jcUY6gG9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55622414cf4so1625907e87.3
        for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 01:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752827492; x=1753432292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8xwpmkMzspiOongpmX1MNLbl0q1sdU9S7sc4man+Jg=;
        b=jcUY6gG9UyTDsGt5NDFDkKgfRwiN8UW+nFeFUhG9vDLkla/es1ModDc/h8hjA8PcWh
         OyZqC3GiT/BNYXRxJRkyFlcBVEXVueeDp1qL3NbCJtWTqbMvD8cqMlAq+uVKcgtuRK6O
         xavOMth0ovUkEWWN4eC19Lfr6xLh8LLCmIMNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752827492; x=1753432292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8xwpmkMzspiOongpmX1MNLbl0q1sdU9S7sc4man+Jg=;
        b=jZlo0OhXGd4OrBtDoY0mwL6VUNEaw8AmvwOkh+my613lkB1T3SLcRw7PjQExzPfjBH
         Mgoqles+ltYhP9s/rIFlFp2F3Tlkqf3otI9yDe5v/1be5rw0Iuh0lk1FnR9dl7CmdomP
         LvFPSS7+QdG04b0BLqBYomOz7ApoY2Xh6JcnaH8iFEj8PpVtizuc8k6/9dU43ikiKlOp
         /FS0Y6RDYV7MF/KKeZaIoAcEzB3hsZrLO+rTJHfEWDwNyx6BYgDIdloQD/8O6UpVgklC
         f4c3GXUzElCQHQ/1hwBzS2q5brpCQDUMXeSSNXoJK6w557RoOA5UWq1xV0eFu2Jy7clg
         bYYg==
X-Forwarded-Encrypted: i=1; AJvYcCU2oFFYgnoa1kAtp5gxE9UPJETxQP6tcwre9tfcbglF4nASSmMORCeIqDxK0CsU4w2MDMlSJNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGv2TwBamhYsbI0xdkEUXNiRnKRxKjLpi7y5kJrd7TmIoGrzNu
	It1c+T68E/g2p2MyCnudlUWRvI0bg73rMpC4Mu1sgoIlKlpa+CoSUHpzi2JfXULfiu8Kc06hQnr
	VGXQa3oSRWle2bX6LozAUkNfj1VKGHKmaN4OEyGJ9
X-Gm-Gg: ASbGnctL4zkBUDvNOxUbPr2MoXsl5P3iSp4zJKVQSBatiYoO9+v7XUYqJ/GDFk+jFkt
	sv3TL/Z/jq1arfvJldjYa+RTcdOZS9EissGlW27lv28i846p58b5ydrVeVpoqFnb8BP/0nRqcAi
	XFgMB+WmRiKdBeqhzOLVQ2S9CUc+m6ZTR8EZSQN2LbVnxsfM6S9OChHSA3HwPl3J9JhgqLyLe9t
	eWhtdmU6iMgAV9or+PKTWVydyiC36WUizQ=
X-Google-Smtp-Source: AGHT+IE2YCP3qtGwbWMMf4nA+VHzKJt73OAglarAy2N4KkRi0JUERUKf9Ryw1zRIfRne1bwjjAb8n8O/WhX1Et2H5P0=
X-Received: by 2002:ac2:4bd3:0:b0:553:543d:d963 with SMTP id
 2adb3069b0e04-55a3188f091mr482109e87.36.1752827491972; Fri, 18 Jul 2025
 01:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624143220.244549-1-laura.nao@collabora.com>
 <20250624143220.244549-15-laura.nao@collabora.com> <CAGXv+5EsVOPC+i2=9d-Be1U-DuB8tPDAyokzhTOeVZQtZJ9+CQ@mail.gmail.com>
In-Reply-To: <CAGXv+5EsVOPC+i2=9d-Be1U-DuB8tPDAyokzhTOeVZQtZJ9+CQ@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 18 Jul 2025 16:31:18 +0800
X-Gm-Features: Ac12FXy4SClgcQRcJIHHX9Uew0lkKbfgQ80ydRk_k7muDqm79-Y_wxCCK4MPdyc
Message-ID: <CAGXv+5ErtDLNf3u5OdHrEBdrA-2bPA5wy32S+Bqd1c_1Z9u1pA@mail.gmail.com>
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

On Tue, Jul 15, 2025 at 3:28=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> Hi,
>
>
> On Tue, Jun 24, 2025 at 10:33=E2=80=AFPM Laura Nao <laura.nao@collabora.c=
om> wrote:
> >
> > Add support for the MT8196 vlpckgen clock controller, which provides
> > muxes and dividers for clock selection in other IP blocks.
> >
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> > Signed-off-by: Laura Nao <laura.nao@collabora.com>
> > ---
> >  drivers/clk/mediatek/Makefile              |   2 +-
> >  drivers/clk/mediatek/clk-mt8196-vlpckgen.c | 769 +++++++++++++++++++++
> >  2 files changed, 770 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/clk/mediatek/clk-mt8196-vlpckgen.c
> >
> > diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makef=
ile
> > index 0688d7bf4979..24683dd51783 100644
> > --- a/drivers/clk/mediatek/Makefile
> > +++ b/drivers/clk/mediatek/Makefile
> > @@ -161,7 +161,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) +=3D clk-mt=
8195-venc.o
> >  obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS) +=3D clk-mt8195-vpp0.o clk-mt81=
95-vpp1.o
> >  obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) +=3D clk-mt8195-wpe.o
> >  obj-$(CONFIG_COMMON_CLK_MT8196) +=3D clk-mt8196-apmixedsys.o clk-mt819=
6-topckgen.o \
> > -                                  clk-mt8196-topckgen2.o
> > +                                  clk-mt8196-topckgen2.o clk-mt8196-vl=
pckgen.o
> >  obj-$(CONFIG_COMMON_CLK_MT8365) +=3D clk-mt8365-apmixedsys.o clk-mt836=
5.o
> >  obj-$(CONFIG_COMMON_CLK_MT8365_APU) +=3D clk-mt8365-apu.o
> >  obj-$(CONFIG_COMMON_CLK_MT8365_CAM) +=3D clk-mt8365-cam.o
> > diff --git a/drivers/clk/mediatek/clk-mt8196-vlpckgen.c b/drivers/clk/m=
ediatek/clk-mt8196-vlpckgen.c
> > new file mode 100644
> > index 000000000000..23a673dd4c5c
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-mt8196-vlpckgen.c
> > @@ -0,0 +1,769 @@
>
> [...]
>
> > +static const char * const vlp_camtg0_parents[] =3D {
> > +       "clk26m",
> > +       "univpll_192m_d32",
> > +       "univpll_192m_d16",
> > +       "clk13m",
> > +       "osc_d40",
> > +       "osc_d32",
> > +       "univpll_192m_d10",
> > +       "univpll_192m_d8",
> > +       "univpll_d6_d16",
> > +       "ulposc3",
> > +       "osc_d20",
> > +       "ck2_tvdpll1_d16",
> > +       "univpll_d6_d8"
> > +};
>
> It seems all the vlp_camtg* parents are the same. Please merge them
> and just have one list.
>
> > +static const char * const vlp_sspm_26m_parents[] =3D {
> > +       "clk26m",
> > +       "osc_d20"
> > +};
> > +
> > +static const char * const vlp_ulposc_sspm_parents[] =3D {
> > +       "clk26m",
> > +       "osc_d2",
> > +       "mainpll_d4_d2"
> > +};
> > +
> > +static const char * const vlp_vlp_pbus_26m_parents[] =3D {
> > +       "clk26m",
> > +       "osc_d20"
> > +};
> > +
> > +static const char * const vlp_debug_err_flag_parents[] =3D {
> > +       "clk26m",
> > +       "osc_d20"
> > +};
> > +
> > +static const char * const vlp_dpmsrdma_parents[] =3D {
> > +       "clk26m",
> > +       "mainpll_d7_d2"
> > +};
> > +
> > +static const char * const vlp_vlp_pbus_156m_parents[] =3D {
> > +       "clk26m",
> > +       "osc_d2",
> > +       "mainpll_d7_d2",
> > +       "mainpll_d7"
> > +};
> > +
> > +static const char * const vlp_spm_parents[] =3D {
> > +       "clk26m",
> > +       "mainpll_d7_d4"
> > +};
> > +
> > +static const char * const vlp_mminfra_parents[] =3D {
> > +       "clk26m",
> > +       "osc_d4",
> > +       "mainpll_d3"
> > +};
> > +
> > +static const char * const vlp_usb_parents[] =3D {
> > +       "clk26m",
> > +       "mainpll_d9"
> > +};
>
> The previous and the next one are the same.
>
> > +static const char * const vlp_usb_xhci_parents[] =3D {
> > +       "clk26m",
> > +       "mainpll_d9"
> > +};
> > +
> > +static const char * const vlp_noc_vlp_parents[] =3D {
> > +       "clk26m",
> > +       "osc_d20",
> > +       "mainpll_d9"
> > +};
> > +
> > +static const char * const vlp_audio_h_parents[] =3D {
> > +       "clk26m",
> > +       "vlp_apll1",
> > +       "vlp_apll2"
> > +};
> > +
> > +static const char * const vlp_aud_engen1_parents[] =3D {
> > +       "clk26m",
> > +       "apll1_d8",
> > +       "apll1_d4"
> > +};
>
> The previous and the next one are the same.
>
> > +static const char * const vlp_aud_engen2_parents[] =3D {
> > +       "clk26m",
> > +       "apll2_d8",
> > +       "apll2_d4"
> > +};
> > +
> > +static const char * const vlp_aud_intbus_parents[] =3D {
> > +       "clk26m",
> > +       "mainpll_d7_d4",
> > +       "mainpll_d4_d4"
> > +};

Also, all these audio related clocks (audio_h, aud_engen1, aud_engen2
aud_intbus) have a "vlp_clk26m" clock as their parent. It should be:

  - clk26m (clk26m from the top ckgen domain)
  - vlp_clk26m (clk26m from the VLP domain)
  - (from PLLs)
  - (from PLLs)

Moreover, an offline discussion with the audio owner suggests that
of the two 26 MHz clock parents, we really just want the one from
the VLP domain, as that one is usable even under suspend. This
could be done by providing an index table.

ChenYu

> > +
> > +static const char * const vlp_spvlp_26m
>
> [...]
>
> > +static int clk_mt8196_vlp_probe(struct platform_device *pdev)
> > +{
> > +       struct clk_hw_onecell_data *clk_data;
> > +       int r;
> > +       struct device_node *node =3D pdev->dev.of_node;
> > +
> > +       clk_data =3D mtk_alloc_clk_data(ARRAY_SIZE(vlp_muxes) +
> > +                                     ARRAY_SIZE(vlp_plls));
> > +       if (!clk_data)
> > +               return -ENOMEM;
> > +
> > +       r =3D mtk_clk_register_muxes(&pdev->dev, vlp_muxes, ARRAY_SIZE(=
vlp_muxes),
> > +                                  node, &mt8196_clk_vlp_lock, clk_data=
);
> > +       if (r)
> > +               goto free_clk_data;
> > +
> > +       r =3D mtk_clk_register_plls(node, vlp_plls, ARRAY_SIZE(vlp_plls=
),
> > +                                 clk_data);
> > +       if (r)
> > +               goto unregister_muxes;
> > +
> > +       r =3D of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_d=
ata);
> > +       if (r)
> > +               goto unregister_plls;
> > +
> > +       platform_set_drvdata(pdev, clk_data);
> > +
> > +       return r;
> > +
> > +unregister_plls:
> > +       mtk_clk_unregister_plls(vlp_plls, ARRAY_SIZE(vlp_plls), clk_dat=
a);
> > +unregister_muxes:
> > +       mtk_clk_unregister_muxes(vlp_muxes, ARRAY_SIZE(vlp_muxes), clk_=
data);
> > +free_clk_data:
> > +       mtk_free_clk_data(clk_data);
>
> The AFE driver sets some tuner parameters in the VLPCKGEN block at probe
> time. Maybe we could do that here instead?
>
> /* vlp_cksys_clk: 0x1c016000 */
> #define VLP_APLL1_TUNER_CON0 0x02a4
> #define VLP_APLL2_TUNER_CON0 0x02a8
>
> /* vlp apll1 tuner default value*/
> #define VLP_APLL1_TUNER_CON0_VALUE 0x6f28bd4d
> /* vlp apll2 tuner default value + 1*/
> #define VLP_APLL2_TUNER_CON0_VALUE 0x78fd5265
>
>        regmap_write(afe_priv->vlp_ck, VLP_APLL1_TUNER_CON0,
> VLP_APLL1_TUNER_CON0_VALUE);
>        regmap_write(afe_priv->vlp_ck, VLP_APLL2_TUNER_CON0,
> VLP_APLL2_TUNER_CON0_VALUE);
>
> ChenYu
>
> > +
> > +       return r;
> > +}
> > +
> > +static void clk_mt8196_vlp_remove(struct platform_device *pdev)
> > +{
> > +       struct clk_hw_onecell_data *clk_data =3D platform_get_drvdata(p=
dev);
> > +       struct device_node *node =3D pdev->dev.of_node;
> > +
> > +       of_clk_del_provider(node);
> > +       mtk_clk_unregister_plls(vlp_plls, ARRAY_SIZE(vlp_plls), clk_dat=
a);
> > +       mtk_clk_unregister_muxes(vlp_muxes, ARRAY_SIZE(vlp_muxes), clk_=
data);
> > +       mtk_free_clk_data(clk_data);
> > +}
> > +
> > +static const struct of_device_id of_match_clk_mt8196_vlp_ck[] =3D {
> > +       { .compatible =3D "mediatek,mt8196-vlpckgen" },
> > +       { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_vlp_ck);
> > +
> > +static struct platform_driver clk_mt8196_vlp_drv =3D {
> > +       .probe =3D clk_mt8196_vlp_probe,
> > +       .remove =3D clk_mt8196_vlp_remove,
> > +       .driver =3D {
> > +               .name =3D "clk-mt8196-vlpck",
> > +               .of_match_table =3D of_match_clk_mt8196_vlp_ck,
> > +       },
> > +};
> > +
> > +MODULE_DESCRIPTION("MediaTek MT8196 VLP clock generator driver");
> > +module_platform_driver(clk_mt8196_vlp_drv);
> > +MODULE_LICENSE("GPL");
> > --
> > 2.39.5
> >

