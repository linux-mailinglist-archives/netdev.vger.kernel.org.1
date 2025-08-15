Return-Path: <netdev+bounces-213952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6CFB2773B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 05:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200F8AA50D4
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6346C21D3E9;
	Fri, 15 Aug 2025 03:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eHK0lJ8p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1C113AA2D
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 03:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755230053; cv=none; b=VHAp2Yb3XKlXL4KFNbGHoXhpKclQjHKIlVpJ82glMgTOtizqOKZKppS0xww6waA+nnfyC2/GVVFA1ZlFiYLKLNpAfL9IKay3qXbcJSTVyP/vQ4kywyhA7vPwrSMGtO0u4GWCIl6EIDEztxY6VnGX4pRERUnEoiT1StwLFHkwjAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755230053; c=relaxed/simple;
	bh=8Act1oil8WYFYYnl4O3qWoBEGR2tOlRIBru/5My4hgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlBRJLDN166Snc3Z0FRxlcf5KvFNVKyvdrMtwwHbc1IGlYKlQeImT0+ukNsm3aBSd7RYBcHZgIVU/qDlU19NCdHOMAuQtY1A7Zb1DDlEndPD7MKChpFklQplcmM6ASH1pQIDeBP5eSk3wgHMVu7VaUsDDnjgrw2AxZLyBmjP7p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eHK0lJ8p; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55ce508d4d6so1255698e87.0
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 20:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755230050; x=1755834850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NS1sCk2jaj6fQ+JKQ824bLbj5DJYUpkN66EHpy4E2b4=;
        b=eHK0lJ8pesEIU9CpeVO8edrITLoXiVZ66lMiMWe/FlgWbXDI4u7XvAyxE/395QBbCp
         OSjOKvfSlKEJnGn2N14yGhUQA4TnOIXYMVbrlnaLtw8QC/3fXPqaHPHPbnv7y7lcH2+Q
         tcP8IMWRlDKwjuezBLVaPcCDlWsIViY+dxKbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755230050; x=1755834850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NS1sCk2jaj6fQ+JKQ824bLbj5DJYUpkN66EHpy4E2b4=;
        b=GE9PEkrwc4h+4gm1h1m7bJuMp3szmoD1OS79VAQp6W+0KvQX5k77FP0WmMmZcCHgau
         Q030wh7zCHwptNn3NoCzkY1zVowVtkn6mR9ZJCsL66wNgHTtLD7aB9FdL14PV7hGg4GB
         V/DqH0c8LrcdytV1inizJqdE4r/6ABTHn/FB5IbRfpLrTFWQRyaZ7jgZVBRD4UTsRtgm
         K7ZsOcJpRxaQRiH1NXb0uoq+5IfEU15vfYnrg2gtOiZmP5PJNUCBYhUOiawWeamMZtBq
         OeaBY5Dq3WbcEM659B7RDRPLvmTRcryvJUakxkpA06fsn6Qw/JCC0DDNuduawiCozjdP
         D1Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXBvBT0q+KuKE0a5TKyFdbgW/fz1uD/K+fe7HAaV8Gl4LlM4rJmjHA4fz8krsZpn9f2ceovGzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6eLxenT3VYDNf670SlSK4WlCrTy6Nn84oEqrRZ+Q+g75l+m5Z
	FnK1KlyPNYD6EbFf36vJEgSQ/pEfyjHA9ILREJMGAS3I83FneahjQMzITwFGG5GaQwgg5eofWNo
	tu+cau4vBeNMtUC/qQrybR+FVACO24OKKEhoiRvwGDWFCvFc2HIti8g==
X-Gm-Gg: ASbGncuez+QhPLLG/3NW1sq5WQHq4ZmYOkJgYC+U7oHWQgPws0v4+s1qTrbySD/saQ6
	su+k9tm6borY+HKqZoQzgGMKvN9OGda4a4IflK+nU6Px4tu3CraZKfWeCLAmR0mrkBqvFksq0m9
	zZOuInOForIaNl/5imbQnYoT6VyfHXUoIN+GIEnnQJqCSi0KIVdi41s7whDI9cMhBAkeIBxsHJr
	PWpXobrAe9HhnWEuv5lhOQG67aCnwXwtTY+RA==
X-Google-Smtp-Source: AGHT+IGIV7mvkFPQZuFUz43yWCcXkxtysXLVWZnhXnNTP1ZgJAEPVlAYJWIr84Go4WLQoos1hIvAKUr4yPJ/fc7kwL0=
X-Received: by 2002:a05:6512:2256:b0:55a:2f6e:99bf with SMTP id
 2adb3069b0e04-55ceeb0da8amr172578e87.37.1755230049594; Thu, 14 Aug 2025
 20:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805135447.149231-1-laura.nao@collabora.com> <20250805135447.149231-17-laura.nao@collabora.com>
In-Reply-To: <20250805135447.149231-17-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 15 Aug 2025 12:53:58 +0900
X-Gm-Features: Ac12FXzPhchsvkR2KgC75ucJdBbVv2BRvVoAd0vv5jb3C5Va-SRZ59TCxVHQ5SA
Message-ID: <CAGXv+5Gs+1deOMpVrqVmeiPywyAkUM_TD-6Q8sT7Oc014vBE1Q@mail.gmail.com>
Subject: Re: [PATCH v4 16/27] clk: mediatek: Add MT8196 pextpsys clock support
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
> Add support for the MT8196 pextpsys clock controller, which provides
> clock gate control for PCIe.
>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  drivers/clk/mediatek/Kconfig            |   7 ++
>  drivers/clk/mediatek/Makefile           |   1 +
>  drivers/clk/mediatek/clk-mt8196-pextp.c | 131 ++++++++++++++++++++++++
>  3 files changed, 139 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8196-pextp.c
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index d99c39a7f10e..c977719046a4 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -1010,6 +1010,13 @@ config COMMON_CLK_MT8196
>         help
>           This driver supports MediaTek MT8196 basic clocks.
>
> +config COMMON_CLK_MT8196_PEXTPSYS
> +       tristate "Clock driver for MediaTek MT8196 pextpsys"
> +       depends on COMMON_CLK_MT8196
> +       default COMMON_CLK_MT8196
> +       help
> +         This driver supports MediaTek MT8196 pextpsys clocks.
> +
>  config COMMON_CLK_MT8196_UFSSYS
>         tristate "Clock driver for MediaTek MT8196 ufssys"
>         depends on COMMON_CLK_MT8196
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefil=
e
> index 1a497de00846..88f7d8a229c2 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -153,6 +153,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) +=3D clk-mt819=
5-wpe.o
>  obj-$(CONFIG_COMMON_CLK_MT8196) +=3D clk-mt8196-apmixedsys.o clk-mt8196-=
topckgen.o \
>                                    clk-mt8196-topckgen2.o clk-mt8196-vlpc=
kgen.o \
>                                    clk-mt8196-peri_ao.o
> +obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) +=3D clk-mt8196-pextp.o
>  obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) +=3D clk-mt8196-ufs_ao.o
>  obj-$(CONFIG_COMMON_CLK_MT8365) +=3D clk-mt8365-apmixedsys.o clk-mt8365.=
o
>  obj-$(CONFIG_COMMON_CLK_MT8365_APU) +=3D clk-mt8365-apu.o
> diff --git a/drivers/clk/mediatek/clk-mt8196-pextp.c b/drivers/clk/mediat=
ek/clk-mt8196-pextp.c
> new file mode 100644
> index 000000000000..9a7623bf2b1c
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8196-pextp.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + *                    Guangjie Song <guangjie.song@mediatek.com>
> + * Copyright (c) 2025 Collabora Ltd.
> + *                    Laura Nao <laura.nao@collabora.com>
> + */
> +#include <dt-bindings/clock/mediatek,mt8196-clock.h>
> +#include <dt-bindings/reset/mediatek,mt8196-resets.h>

Nit: empty line here for separation.

> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +#include "reset.h"
> +
> +#define MT8196_PEXTP_RST0_SET_OFFSET   0x8
> +
> +static const struct mtk_gate_regs pext_cg_regs =3D {
> +       .set_ofs =3D 0x18,
> +       .clr_ofs =3D 0x1c,
> +       .sta_ofs =3D 0x14,
> +};
> +
> +#define GATE_PEXT(_id, _name, _parent, _shift) {\
> +               .id =3D _id,                      \
> +               .name =3D _name,                  \
> +               .parent_name =3D _parent,         \
> +               .regs =3D &pext_cg_regs,          \
> +               .shift =3D _shift,                \
> +               .flags =3D CLK_OPS_PARENT_ENABLE, \

Same issue as the previous patch. If one of the parents shown below
needs to be enabled for register access, this is going to fail badly.
If it's not needed, then this flag makes no sense here.

ChenYu

> +               .ops =3D &mtk_clk_gate_ops_setclr,\
> +       }
> +
> +static const struct mtk_gate pext_clks[] =3D {
> +       GATE_PEXT(CLK_PEXT_PEXTP_MAC_P0_TL, "pext_pm0_tl", "tl", 0),
> +       GATE_PEXT(CLK_PEXT_PEXTP_MAC_P0_REF, "pext_pm0_ref", "clk26m", 1)=
,
> +       GATE_PEXT(CLK_PEXT_PEXTP_PHY_P0_MCU_BUS, "pext_pp0_mcu_bus", "clk=
26m", 6),
> +       GATE_PEXT(CLK_PEXT_PEXTP_PHY_P0_PEXTP_REF, "pext_pp0_pextp_ref", =
"clk26m", 7),
> +       GATE_PEXT(CLK_PEXT_PEXTP_MAC_P0_AXI_250, "pext_pm0_axi_250", "ufs=
_pexpt0_mem_sub", 12),
> +       GATE_PEXT(CLK_PEXT_PEXTP_MAC_P0_AHB_APB, "pext_pm0_ahb_apb", "ufs=
_pextp0_axi", 13),
> +       GATE_PEXT(CLK_PEXT_PEXTP_MAC_P0_PL_P, "pext_pm0_pl_p", "clk26m", =
14),
> +       GATE_PEXT(CLK_PEXT_PEXTP_VLP_AO_P0_LP, "pext_pextp_vlp_ao_p0_lp",=
 "clk26m", 19),
> +};
> +
> +static u16 pext_rst_ofs[] =3D { MT8196_PEXTP_RST0_SET_OFFSET };
> +
> +static u16 pext_rst_idx_map[] =3D {
> +       [MT8196_PEXTP0_RST0_PCIE0_MAC] =3D 0,
> +       [MT8196_PEXTP0_RST0_PCIE0_PHY] =3D 1,
> +};
> +
> +static const struct mtk_clk_rst_desc pext_rst_desc =3D {
> +       .version =3D MTK_RST_SET_CLR,
> +       .rst_bank_ofs =3D pext_rst_ofs,
> +       .rst_bank_nr =3D ARRAY_SIZE(pext_rst_ofs),
> +       .rst_idx_map =3D pext_rst_idx_map,
> +       .rst_idx_map_nr =3D ARRAY_SIZE(pext_rst_idx_map),
> +};
> +
> +static const struct mtk_clk_desc pext_mcd =3D {
> +       .clks =3D pext_clks,
> +       .num_clks =3D ARRAY_SIZE(pext_clks),
> +       .rst_desc =3D &pext_rst_desc,
> +};
> +
> +static const struct mtk_gate pext1_clks[] =3D {
> +       GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P1_TL, "pext1_pm1_tl", "tl_p1", 0),
> +       GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P1_REF, "pext1_pm1_ref", "clk26m", =
1),
> +       GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P2_TL, "pext1_pm2_tl", "tl_p2", 2),
> +       GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P2_REF, "pext1_pm2_ref", "clk26m", =
3),
> +       GATE_PEXT(CLK_PEXT1_PEXTP_PHY_P1_MCU_BUS, "pext1_pp1_mcu_bus", "c=
lk26m", 8),
> +       GATE_PEXT(CLK_PEXT1_PEXTP_PHY_P1_PEXTP_REF, "pext1_pp1_pextp_ref"=
, "clk26m", 9),
> +       GATE_PEXT(CLK_PEXT1_PEXTP_PHY_P2_MCU_BUS, "pext1_pp2_mcu_bus", "c=
lk26m", 10),
> +       GATE_PEXT(CLK_PEXT1_PEXTP_PHY_P2_PEXTP_REF, "pext1_pp2_pextp_ref"=
, "clk26m", 11),
> +       GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P1_AXI_250, "pext1_pm1_axi_250",
> +                  "pextp1_usb_axi", 16),
> +       GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P1_AHB_APB, "pext1_pm1_ahb_apb",
> +                  "pextp1_usb_mem_sub", 17),
> +       GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P1_PL_P, "pext1_pm1_pl_p", "clk26m"=
, 18),
> +       GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P2_AXI_250, "pext1_pm2_axi_250",
> +                  "pextp1_usb_axi", 19),
> +       GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P2_AHB_APB, "pext1_pm2_ahb_apb",
> +                  "pextp1_usb_mem_sub", 20),
> +       GATE_PEXT(CLK_PEXT1_PEXTP_MAC_P2_PL_P, "pext1_pm2_pl_p", "clk26m"=
, 21),
> +       GATE_PEXT(CLK_PEXT1_PEXTP_VLP_AO_P1_LP, "pext1_pextp_vlp_ao_p1_lp=
", "clk26m", 26),
> +       GATE_PEXT(CLK_PEXT1_PEXTP_VLP_AO_P2_LP, "pext1_pextp_vlp_ao_p2_lp=
", "clk26m", 27),
> +};
> +
> +static u16 pext1_rst_idx_map[] =3D {
> +       [MT8196_PEXTP1_RST0_PCIE1_MAC] =3D 0,
> +       [MT8196_PEXTP1_RST0_PCIE1_PHY] =3D 1,
> +       [MT8196_PEXTP1_RST0_PCIE2_MAC] =3D 8,
> +       [MT8196_PEXTP1_RST0_PCIE2_PHY] =3D 9,
> +};
> +
> +static const struct mtk_clk_rst_desc pext1_rst_desc =3D {
> +       .version =3D MTK_RST_SET_CLR,
> +       .rst_bank_ofs =3D pext_rst_ofs,
> +       .rst_bank_nr =3D ARRAY_SIZE(pext_rst_ofs),
> +       .rst_idx_map =3D pext1_rst_idx_map,
> +       .rst_idx_map_nr =3D ARRAY_SIZE(pext1_rst_idx_map),
> +};
> +
> +static const struct mtk_clk_desc pext1_mcd =3D {
> +       .clks =3D pext1_clks,
> +       .num_clks =3D ARRAY_SIZE(pext1_clks),
> +       .rst_desc =3D &pext1_rst_desc,
> +};
> +
> +static const struct of_device_id of_match_clk_mt8196_pextp[] =3D {
> +       { .compatible =3D "mediatek,mt8196-pextp0cfg-ao", .data =3D &pext=
_mcd },
> +       { .compatible =3D "mediatek,mt8196-pextp1cfg-ao", .data =3D &pext=
1_mcd },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_pextp);
> +
> +static struct platform_driver clk_mt8196_pextp_drv =3D {
> +       .probe =3D mtk_clk_simple_probe,
> +       .remove =3D mtk_clk_simple_remove,
> +       .driver =3D {
> +               .name =3D "clk-mt8196-pextp",
> +               .of_match_table =3D of_match_clk_mt8196_pextp,
> +       },
> +};
> +
> +module_platform_driver(clk_mt8196_pextp_drv);
> +MODULE_DESCRIPTION("MediaTek MT8196 PCIe transmit phy clocks driver");
> +MODULE_LICENSE("GPL");
> --
> 2.39.5
>

