Return-Path: <netdev+bounces-108648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C97924D22
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 03:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145661F22661
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D687B623;
	Wed,  3 Jul 2024 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I25b1PnU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F7879DE
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719969614; cv=none; b=HgaQ4MigPyJY81/GYc/Rys6nRlj1swJtoe521HGeqiYM/Qip5k0f+6b69Wh9fQ9BQtcYeUdohYtJ/wnOxd2G4rux4GZAVVs3MZOAhKyJvGl3JizzrfZ3TRi2h+ps+h9/hqDu7t+cDRbW5iXEyJLYpwtja3JOxdzK1a/CN+j4kkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719969614; c=relaxed/simple;
	bh=ZWrqQ9sn1zmWnDRaxvOCj30qAztsjsa2WsFmWMFJ5zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPr7lQ08UkZzmOQqMqsw37uujWeW1Oj2Zx5XyKQJN5XtTHKUdj+x/9lstC6WgcT3HOq1f7YzMETTpONcBdObJ4g4N5ozmYSJ8/sFZtkuTGM8/64Q/peRVjtBNHNGFAE1RiZjtDskzcVtzgkWtefE6oLaqO009lGupVu256nvrr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I25b1PnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E436C4AF0E
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 01:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719969614;
	bh=ZWrqQ9sn1zmWnDRaxvOCj30qAztsjsa2WsFmWMFJ5zc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I25b1PnUDMoLZ3Z2ZIgdDlhlACT/LsmtUaSecOU0IOdl+ncntBrIS4l7fp3Q8l5II
	 8gmtXPGjQ6Gdoc7hnvspU0OknTplzigW11Y9isROE9coHlfGLkx6HUirMcfKO7Zht6
	 0Yi89UBgWfMCX7aDXMYjU+kDge3juErJVHEpXRVmAkpwDoeq2w1nKZUNmG9kH7T0dC
	 6fEdV9lCPHc0/FS2VN3gHz0Rze/XJAbcdBKv89QO4oMPwQ/SNiGdIa7iM05He838iT
	 m22p/H7EIq3XgaDdmjn6Y1TGL33RqqyCfwvPd7y0J9CzB6+5Km/hczmzK+pRpT2HXq
	 UACAg58jP9pnQ==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6fd513f18bso615587466b.3
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 18:20:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXm4Jn65c4dmQlztr086Nt+mf3sDR2l3b1KLYmCgXXOOAHQXd7JStPp1Dj5BuUgeP62dOsdK7w5VQJpf856WWlFsPK36gO
X-Gm-Message-State: AOJu0Yx8zsHZVX7syV7Nu96rkzonsbjkKJvsKf8gyg0yLsXdWYrhP8CD
	msy9HeDCefzzJm7nbux150Ql7cfI0WpRCNA03s0JkF/TUz0YhrSvvcf72njfJUQHwWeHofG7dnX
	Wn/X8XZkaZK+fy7q8/8vkNvDZXtk=
X-Google-Smtp-Source: AGHT+IEUDbuvivO2pl2K7e+BoMzXN/VcRAcyBgGWswKUnRvdNsQPbb5gAhE+Hq+9V9Nf6lMujR7Gky64VzX68ZScvzo=
X-Received: by 2002:a17:907:971a:b0:a72:64ca:4668 with SMTP id
 a640c23a62f3a-a7514419673mr815694266b.13.1719969612412; Tue, 02 Jul 2024
 18:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716973237.git.siyanteng@loongson.cn> <16ec5a0665bcce96757be140019d81b0fe5f6303.1716973237.git.siyanteng@loongson.cn>
 <ktvlui43g6q7ju3tmga7ut3rg2hkhnbxwfbjzr46jx4kjbubwk@l4gqqvhih5ug>
In-Reply-To: <ktvlui43g6q7ju3tmga7ut3rg2hkhnbxwfbjzr46jx4kjbubwk@l4gqqvhih5ug>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 3 Jul 2024 09:19:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4JEec7CuNDaQX3AUT=9itcTRgRtWa61XACrYEvvLfd8g@mail.gmail.com>
Message-ID: <CAAhV-H4JEec7CuNDaQX3AUT=9itcTRgRtWa61XACrYEvvLfd8g@mail.gmail.com>
Subject: Re: [PATCH net-next v13 14/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	Jose.Abreu@synopsys.com, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 9:43=E2=80=AFPM Serge Semin <fancer.lancer@gmail.com=
> wrote:
>
> > [PATCH net-next v13 14/15] net: stmmac: dwmac-loongson: Add Loongson GN=
ET support
>
> Seeing the multi-channels AV-feature can be found on the Loongson
> GMACs too we have to reconsider this patch logic by converting it to
> adding the multi-channels support for the Loongson GMAC device only.
> Everything Loongson GNET-specific should be moved to a new following
> up patch.
>
> So firstly please change this patch subject to:
> [PATCH net-next v14 13/15] net: stmmac: dwmac-loongson: Add Loongson Mult=
i-channels GMAC support
>
> On Wed, May 29, 2024 at 06:21:09PM +0800, Yanteng Si wrote:
> > Aside with the Loongson GMAC controllers which can be normally found
> > on the LS2K1000 SoC and LS7A1000 chipset, Loongson released a new
> > version of the network controllers called Loongson GNET. It has
> > been synthesized into the new generation LS2K2000 SoC and LS7A2000
> > chipset with the next DW GMAC features enabled:
> >
> >   DW GMAC IP-core: v3.73a
> >   Speeds: 10/100/1000Mbps
> >   Duplex: Full (both versions), Half (LS2K2000 SoC only)
> >   DMA-descriptors type: enhanced
> >   L3/L4 filters availability: Y
> >   VLAN hash table filter: Y
> >   PHY-interface: GMII (PHY is integrated into the chips)
> >   Remote Wake-up support: Y
> >   Mac Management Counters (MMC): Y
> >   Number of additional MAC addresses: 5
> >   MAC Hash-based filter: Y
> >   Hash Table Size: 256
> >   AV feature: Y (LS2K2000 SoC only)
> >   DMA channels: 8 (LS2K2000 SoC), 1 (LS7A2000 chipset)
> >
> > The integrated PHY has a weird problem with switching from the low
> > speeds to 1000Mbps mode. The speedup procedure requires the PHY-link
> > re-negotiation. Besides the LS2K2000 GNET controller the next
> > peculiarities:
> > 1. Split up Tx and Rx DMA IRQ status/mask bits:
> >        Name              Tx          Rx
> >   DMA_INTR_ENA_NIE =3D 0x00040000 | 0x00020000;
> >   DMA_INTR_ENA_AIE =3D 0x00010000 | 0x00008000;
> >   DMA_STATUS_NIS   =3D 0x00040000 | 0x00020000;
> >   DMA_STATUS_AIS   =3D 0x00010000 | 0x00008000;
> >   DMA_STATUS_FBI   =3D 0x00002000 | 0x00001000;
> > 2. Custom Synopsys ID hardwired into the GMAC_VERSION.SNPSVER field.
> > It's 0x10 while it should have been 0x37 in accordance with the actual
> > DW GMAC IP-core version.
> >
> > Thus in order to have the Loongson GNET controllers supported let's
> > modify the Loongson DWMAC driver in accordance with all the
> > peculiarities described above:
> >
> > 1. Create the Loongson GNET-specific
> >    stmmac_dma_ops::dma_interrupt()
> >    stmmac_dma_ops::init_chan()
> >    callbacks due to the non-standard DMA IRQ CSR flags layout.
> > 2. Create the Loongson GNET-specific platform setup() method which
> > gets to initialize the DMA-ops with the dwmac1000_dma_ops instance
> > and overrides the callbacks described in 1, and overrides the custom
> > Synopsys ID with the real one in order to have the rest of the
> > HW-specific callbacks correctly detected by the driver core.
> > 3. Make sure the Loongson GNET-specific platform setup() method
> > enables the duplex modes supported by the controller.
> > 4. Provide the plat_stmmacenet_data::fix_mac_speed() callback which
> > will restart the link Auto-negotiation in case of the speed change.
>
> Please convert the commit log of this patch to containing the
> multi-channels feature description only. Like this (correct me if I am
> wrong in understanding some of the Loongson network controllers
> aspects):
>
> "The Loongson DWMAC driver currently supports the Loongson GMAC
> devices (based on the DW GMAC v3.50a/v3.73a IP-core) installed to the
> LS2K1000 SoC and LS7A1000 chipset. But recently a new generation
> LS2K2000 SoC was released with the new version of the Loongson GMAC
> synthesized in. The new controller is based on the DW GMAC v3.73a
> IP-core with the AV-feature enabled, which implies the multi
> DMA-channels support. The multi DMA-channels feature has the next
> vendor-specific peculiarities:
>
> 1. Split up Tx and Rx DMA IRQ status/mask bits:
>        Name              Tx          Rx
>   DMA_INTR_ENA_NIE =3D 0x00040000 | 0x00020000;
>   DMA_INTR_ENA_AIE =3D 0x00010000 | 0x00008000;
>   DMA_STATUS_NIS   =3D 0x00040000 | 0x00020000;
>   DMA_STATUS_AIS   =3D 0x00010000 | 0x00008000;
>   DMA_STATUS_FBI   =3D 0x00002000 | 0x00001000;
> 2. Custom Synopsys ID hardwired into the GMAC_VERSION.SNPSVER register
> field. It's 0x10 while it should have been 0x37 in accordance with
> the actual DW GMAC IP-core version.
> 3. There are eight DMA-channels available meanwhile the Synopsys DW
> GMAC IP-core supports up to three DMA-channels.
> 4. It's possible to have each DMA-channel IRQ independently delivered.
> The MSI IRQs must be utilized for that.
>
> Thus in order to have the multi-channels Loongson GMAC controllers
> supported let's modify the Loongson DWMAC driver in accordance with
> all the peculiarities described above:
>
> 1. Create the multi-channels Loongson GMAC-specific
>    stmmac_dma_ops::dma_interrupt()
>    stmmac_dma_ops::init_chan()
>    callbacks due to the non-standard DMA IRQ CSR flags layout.
> 2. Create the Loongson DWMAC-specific platform setup() method
> which gets to initialize the DMA-ops with the dwmac1000_dma_ops
> instance and overrides the callbacks described in 1. The method also
> overrides the custom Synopsys ID with the real one in order to have
> the rest of the HW-specific callbacks correctly detected by the driver
> core.
> 3. Make sure the platform setup() method enables the flow control and
> duplex modes supported by the controller.
> "
>
> Once again, please correct the text if I was wrong in understanding
> the way your devices work. Especially regarding the flow-control and
> half-duplex mode.
>
> ---
>
> The Loongson GNET-specific changes should be moved to the new patch
> applied after this one. The subject of the new patch should be the same
> as the former subject of this patch:
> [PATCH net-next v14 14/15] net: stmmac: dwmac-loongson: Add Loongson GNET=
 support
> but of course the commit log shall be different. Like this:
>
> "The new generation Loongson LS2K2000 SoC and LS7A2000 chipset are
> equipped with the network controllers called Loongson GNET. It's the
> single and multi DMA-channels Loongson GMAC but with a PHY attached.
> Here is the summary of the DW GMAC features the controller has:
>
>    DW GMAC IP-core: v3.73a
>    Speeds: 10/100/1000Mbps
>    Duplex: Full (both versions), Half (LS2K2000 GNET only)
>    DMA-descriptors type: enhanced
>    L3/L4 filters availability: Y
>    VLAN hash table filter: Y
>    PHY-interface: GMII (PHY is integrated into the chips)
>    Remote Wake-up support: Y
>    Mac Management Counters (MMC): Y
>    Number of additional MAC addresses: 5
>    MAC Hash-based filter: Y
>    Hash Table Size: 256
>    AV feature: Y (LS2K2000 GNET only)
>    DMA channels: 8 (LS2K2000 GNET), 1 (LS7A2000 GNET)
>
> Let's update the Loongson DWMAC driver to supporting the new Loongson
> GNET controller. The change is mainly trivial: the driver shall be
> bound to the PCIe device with DID 0x7a13, and the device-specific
> setup() method shall be called for it. The only peculiarity concerns
> the integrated PHY speed change procedure. The PHY has a weird problem
> with switching from the low speeds to 1000Mbps mode. The speedup
> procedure requires the PHY-link re-negotiation. So the suggested
> change provide the device-specific fix_mac_speed() method to overcome
> the problem."
>
> >
> > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
> >  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 390 +++++++++++++++++-
> >  2 files changed, 387 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net=
/ethernet/stmicro/stmmac/common.h
> > index 9cd62b2110a1..aed6ae80cc7c 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> > @@ -29,6 +29,7 @@
> >  /* Synopsys Core versions */
> >  #define      DWMAC_CORE_3_40         0x34
> >  #define      DWMAC_CORE_3_50         0x35
> > +#define      DWMAC_CORE_3_70         0x37
> >  #define      DWMAC_CORE_4_00         0x40
> >  #define DWMAC_CORE_4_10              0x41
> >  #define DWMAC_CORE_5_00              0x50
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/dri=
vers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > index 45dcc35b7955..559215e3fe41 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > @@ -8,8 +8,71 @@
> >  #include <linux/device.h>
> >  #include <linux/of_irq.h>
> >  #include "stmmac.h"
> > +#include "dwmac_dma.h"
> > +#include "dwmac1000.h"
> > +
> > +/* Normal Loongson Tx Summary */
> > +#define DMA_INTR_ENA_NIE_TX_LOONGSON 0x00040000
> > +/* Normal Loongson Rx Summary */
> > +#define DMA_INTR_ENA_NIE_RX_LOONGSON 0x00020000
> > +
> > +#define DMA_INTR_NORMAL_LOONGSON     (DMA_INTR_ENA_NIE_TX_LOONGSON | \
> > +                                      DMA_INTR_ENA_NIE_RX_LOONGSON | \
> > +                                      DMA_INTR_ENA_RIE | DMA_INTR_ENA_=
TIE)
> > +
> > +/* Abnormal Loongson Tx Summary */
> > +#define DMA_INTR_ENA_AIE_TX_LOONGSON 0x00010000
> > +/* Abnormal Loongson Rx Summary */
> > +#define DMA_INTR_ENA_AIE_RX_LOONGSON 0x00008000
> > +
> > +#define DMA_INTR_ABNORMAL_LOONGSON   (DMA_INTR_ENA_AIE_TX_LOONGSON | \
> > +                                      DMA_INTR_ENA_AIE_RX_LOONGSON | \
> > +                                      DMA_INTR_ENA_FBE | DMA_INTR_ENA_=
UNE)
> > +
> > +#define DMA_INTR_DEFAULT_MASK_LOONGSON       (DMA_INTR_NORMAL_LOONGSON=
 | \
> > +                                      DMA_INTR_ABNORMAL_LOONGSON)
> > +
> > +/* Normal Loongson Tx Interrupt Summary */
> > +#define DMA_STATUS_NIS_TX_LOONGSON   0x00040000
> > +/* Normal Loongson Rx Interrupt Summary */
> > +#define DMA_STATUS_NIS_RX_LOONGSON   0x00020000
> > +
> > +/* Abnormal Loongson Tx Interrupt Summary */
> > +#define DMA_STATUS_AIS_TX_LOONGSON   0x00010000
> > +/* Abnormal Loongson Rx Interrupt Summary */
> > +#define DMA_STATUS_AIS_RX_LOONGSON   0x00008000
> > +
> > +/* Fatal Loongson Tx Bus Error Interrupt */
> > +#define DMA_STATUS_FBI_TX_LOONGSON   0x00002000
> > +/* Fatal Loongson Rx Bus Error Interrupt */
> > +#define DMA_STATUS_FBI_RX_LOONGSON   0x00001000
> > +
> > +#define DMA_STATUS_MSK_COMMON_LOONGSON       (DMA_STATUS_NIS_TX_LOONGS=
ON | \
> > +                                      DMA_STATUS_NIS_RX_LOONGSON | \
> > +                                      DMA_STATUS_AIS_TX_LOONGSON | \
> > +                                      DMA_STATUS_AIS_RX_LOONGSON | \
> > +                                      DMA_STATUS_FBI_TX_LOONGSON | \
> > +                                      DMA_STATUS_FBI_RX_LOONGSON)
> > +
> > +#define DMA_STATUS_MSK_RX_LOONGSON   (DMA_STATUS_ERI | DMA_STATUS_RWT =
| \
> > +                                      DMA_STATUS_RPS | DMA_STATUS_RU  =
| \
> > +                                      DMA_STATUS_RI  | DMA_STATUS_OVF =
| \
> > +                                      DMA_STATUS_MSK_COMMON_LOONGSON)
> > +
> > +#define DMA_STATUS_MSK_TX_LOONGSON   (DMA_STATUS_ETI | DMA_STATUS_UNF =
| \
> > +                                      DMA_STATUS_TJT | DMA_STATUS_TU  =
| \
> > +                                      DMA_STATUS_TPS | DMA_STATUS_TI  =
| \
> > +                                      DMA_STATUS_MSK_COMMON_LOONGSON)
> >
> >  #define PCI_DEVICE_ID_LOONGSON_GMAC  0x7a03
>
> > +#define PCI_DEVICE_ID_LOONGSON_GNET  0x7a13
>
> Please move this to the new patch adding the Loongson GNET support.
>
> > +#define DWMAC_CORE_LS2K2000          0x10    /* Loongson custom IP */
>
> Note it's perfectly fine to have a device named after the SoC it's
> equipped to. For example see the compatible strings defined for the
> vendor-specific versions of the DW *MAC IP-cores:
> Documentation/devicetree/bindings/net/snps,dwmac.yaml
>
> But if you aren't comfortable with such naming we can change the
> macro to something like:
> #define DWMAC_CORE_LOONGSON_MULTI_CH    0x10
Maybe DWMAC_CORE_LOONGSON_MULTICHAN or DWMAC_CORE_LOONGSON_MULTI_CHAN
is a little better?

Huacai
>
> > +#define CHANNEL_NUM                  8
> > +
> > +struct loongson_data {
> > +     u32 loongson_id;
>
> > +     struct device *dev;
>
> Please add the "dev" field in the new patch adding the Loongson GNET supp=
ort.
>
> > +};
> >
> >  struct stmmac_pci_info {
> >       int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *p=
lat);
> > @@ -67,6 +130,298 @@ static struct stmmac_pci_info loongson_gmac_pci_in=
fo =3D {
> >       .setup =3D loongson_gmac_data,
> >  };
> >
>
> > +static void loongson_gnet_dma_init_channel(struct stmmac_priv *priv,
>
> Since the multi-channel feature is no longer GNET-specific, please
> rename the method prefix to loongson_dwmac_ .
>
> > +                                        void __iomem *ioaddr,
> > +                                        struct stmmac_dma_cfg *dma_cfg=
,
> > +                                        u32 chan)
> > +{
> > +     int txpbl =3D dma_cfg->txpbl ?: dma_cfg->pbl;
> > +     int rxpbl =3D dma_cfg->rxpbl ?: dma_cfg->pbl;
> > +     u32 value;
> > +
> > +     value =3D readl(ioaddr + DMA_CHAN_BUS_MODE(chan));
> > +
> > +     if (dma_cfg->pblx8)
> > +             value |=3D DMA_BUS_MODE_MAXPBL;
> > +
> > +     value |=3D DMA_BUS_MODE_USP;
> > +     value &=3D ~(DMA_BUS_MODE_PBL_MASK | DMA_BUS_MODE_RPBL_MASK);
> > +     value |=3D (txpbl << DMA_BUS_MODE_PBL_SHIFT);
> > +     value |=3D (rxpbl << DMA_BUS_MODE_RPBL_SHIFT);
> > +
> > +     /* Set the Fixed burst mode */
> > +     if (dma_cfg->fixed_burst)
> > +             value |=3D DMA_BUS_MODE_FB;
> > +
> > +     /* Mixed Burst has no effect when fb is set */
> > +     if (dma_cfg->mixed_burst)
> > +             value |=3D DMA_BUS_MODE_MB;
> > +
> > +     if (dma_cfg->atds)
> > +             value |=3D DMA_BUS_MODE_ATDS;
> > +
> > +     if (dma_cfg->aal)
> > +             value |=3D DMA_BUS_MODE_AAL;
> > +
> > +     writel(value, ioaddr + DMA_CHAN_BUS_MODE(chan));
> > +
> > +     /* Mask interrupts by writing to CSR7 */
> > +     writel(DMA_INTR_DEFAULT_MASK_LOONGSON, ioaddr +
> > +            DMA_CHAN_INTR_ENA(chan));
> > +}
> > +
>
> > +static int loongson_gnet_dma_interrupt(struct stmmac_priv *priv,
>
> Similarly the loongson_dwmac_ prefix seems more appropriate now.
>
> > +                                    void __iomem *ioaddr,
> > +                                    struct stmmac_extra_stats *x,
> > +                                    u32 chan, u32 dir)
> > +{
> > +     struct stmmac_pcpu_stats *stats =3D this_cpu_ptr(priv->xstats.pcp=
u_stats);
> > +     u32 abnor_intr_status;
> > +     u32 nor_intr_status;
> > +     u32 fb_intr_status;
> > +     u32 intr_status;
> > +     int ret =3D 0;
> > +
> > +     /* read the status register (CSR5) */
> > +     intr_status =3D readl(ioaddr + DMA_CHAN_STATUS(chan));
> > +
> > +     if (dir =3D=3D DMA_DIR_RX)
> > +             intr_status &=3D DMA_STATUS_MSK_RX_LOONGSON;
> > +     else if (dir =3D=3D DMA_DIR_TX)
> > +             intr_status &=3D DMA_STATUS_MSK_TX_LOONGSON;
> > +
> > +     nor_intr_status =3D intr_status & (DMA_STATUS_NIS_TX_LOONGSON |
> > +             DMA_STATUS_NIS_RX_LOONGSON);
> > +     abnor_intr_status =3D intr_status & (DMA_STATUS_AIS_TX_LOONGSON |
> > +             DMA_STATUS_AIS_RX_LOONGSON);
> > +     fb_intr_status =3D intr_status & (DMA_STATUS_FBI_TX_LOONGSON |
> > +             DMA_STATUS_FBI_RX_LOONGSON);
> > +
> > +     /* ABNORMAL interrupts */
> > +     if (unlikely(abnor_intr_status)) {
> > +             if (unlikely(intr_status & DMA_STATUS_UNF)) {
> > +                     ret =3D tx_hard_error_bump_tc;
> > +                     x->tx_undeflow_irq++;
> > +             }
> > +             if (unlikely(intr_status & DMA_STATUS_TJT))
> > +                     x->tx_jabber_irq++;
> > +             if (unlikely(intr_status & DMA_STATUS_OVF))
> > +                     x->rx_overflow_irq++;
> > +             if (unlikely(intr_status & DMA_STATUS_RU))
> > +                     x->rx_buf_unav_irq++;
> > +             if (unlikely(intr_status & DMA_STATUS_RPS))
> > +                     x->rx_process_stopped_irq++;
> > +             if (unlikely(intr_status & DMA_STATUS_RWT))
> > +                     x->rx_watchdog_irq++;
> > +             if (unlikely(intr_status & DMA_STATUS_ETI))
> > +                     x->tx_early_irq++;
> > +             if (unlikely(intr_status & DMA_STATUS_TPS)) {
> > +                     x->tx_process_stopped_irq++;
> > +                     ret =3D tx_hard_error;
> > +             }
> > +             if (unlikely(fb_intr_status)) {
> > +                     x->fatal_bus_error_irq++;
> > +                     ret =3D tx_hard_error;
> > +             }
> > +     }
> > +     /* TX/RX NORMAL interrupts */
> > +     if (likely(nor_intr_status)) {
> > +             if (likely(intr_status & DMA_STATUS_RI)) {
> > +                     u32 value =3D readl(ioaddr + DMA_INTR_ENA);
> > +                     /* to schedule NAPI on real RIE event. */
> > +                     if (likely(value & DMA_INTR_ENA_RIE)) {
> > +                             u64_stats_update_begin(&stats->syncp);
> > +                             u64_stats_inc(&stats->rx_normal_irq_n[cha=
n]);
> > +                             u64_stats_update_end(&stats->syncp);
> > +                             ret |=3D handle_rx;
> > +                     }
> > +             }
> > +             if (likely(intr_status & DMA_STATUS_TI)) {
> > +                     u64_stats_update_begin(&stats->syncp);
> > +                     u64_stats_inc(&stats->tx_normal_irq_n[chan]);
> > +                     u64_stats_update_end(&stats->syncp);
> > +                     ret |=3D handle_tx;
> > +             }
> > +             if (unlikely(intr_status & DMA_STATUS_ERI))
> > +                     x->rx_early_irq++;
> > +     }
> > +     /* Optional hardware blocks, interrupts should be disabled */
> > +     if (unlikely(intr_status &
> > +                  (DMA_STATUS_GPI | DMA_STATUS_GMI | DMA_STATUS_GLI)))
> > +             pr_warn("%s: unexpected status %08x\n", __func__, intr_st=
atus);
> > +
> > +     /* Clear the interrupt by writing a logic 1 to the CSR5[19-0] */
> > +     writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
> > +
> > +     return ret;
> > +}
> > +
>
>
> > +static void loongson_gnet_fix_speed(void *priv, unsigned int speed,
> > +                                 unsigned int mode)
> > +{
> > +     struct loongson_data *ld =3D (struct loongson_data *)priv;
> > +     struct net_device *ndev =3D dev_get_drvdata(ld->dev);
> > +     struct stmmac_priv *ptr =3D netdev_priv(ndev);
> > +
> > +     /* The integrated PHY has a weird problem with switching from the=
 low
> > +      * speeds to 1000Mbps mode. The speedup procedure requires the PH=
Y-link
> > +      * re-negotiation.
> > +      */
> > +     if (speed =3D=3D SPEED_1000) {
> > +             if (readl(ptr->ioaddr + MAC_CTRL_REG) &
> > +                 GMAC_CONTROL_PS)
> > +                     /* Word around hardware bug, restart autoneg */
> > +                     phy_restart_aneg(ndev->phydev);
> > +     }
> > +}
> > +
> > +static int loongson_gnet_data(struct pci_dev *pdev,
> > +                           struct plat_stmmacenet_data *plat)
> > +{
> > +     loongson_default_data(pdev, plat);
> > +
> > +     plat->phy_interface =3D PHY_INTERFACE_MODE_GMII;
> > +     plat->mdio_bus_data->phy_mask =3D ~(u32)BIT(2);
> > +     plat->fix_mac_speed =3D loongson_gnet_fix_speed;
> > +
> > +     /* GNET devices with dev revision 0x00 do not support manually
> > +      * setting the speed to 1000.
> > +      */
> > +     if (pdev->revision =3D=3D 0x00)
> > +             plat->flags |=3D STMMAC_FLAG_DISABLE_FORCE_1000;
> > +
> > +     return 0;
> > +}
> > +
> > +static struct stmmac_pci_info loongson_gnet_pci_info =3D {
> > +     .setup =3D loongson_gnet_data,
> > +};
>
> Please move this to the new patch adding the Loongson GNET support.
>
> > +
> > +static int loongson_dwmac_intx_config(struct pci_dev *pdev,
> > +                                   struct plat_stmmacenet_data *plat,
> > +                                   struct stmmac_resources *res)
> > +{
> > +     res->irq =3D pdev->irq;
> > +
> > +     return 0;
> > +}
>
> If you get to implement what suggested here
> https://lore.kernel.org/netdev/glm3jfqf36t5vnkmk4gsdqfx53ga7ohs3pxnsizqlo=
gkbim7gg@a3dxav5siczn/
> than the loongson_dwmac_intx_config() won't be needed.
>
> > +
> > +static int loongson_dwmac_msi_config(struct pci_dev *pdev,
> > +                                  struct plat_stmmacenet_data *plat,
> > +                                  struct stmmac_resources *res)
> > +{
> > +     int i, ret, vecs;
> > +
> > +     vecs =3D roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
> > +     ret =3D pci_alloc_irq_vectors(pdev, 1, vecs, PCI_IRQ_MSI | PCI_IR=
Q_INTX);
> > +     if (ret < 0) {
> > +             dev_err(&pdev->dev, "Failed to allocate PCI IRQs\n");
> > +             return ret;
> > +     }
> > +
> > +     if (ret >=3D vecs) {
> > +             for (i =3D 0; i < plat->rx_queues_to_use; i++) {
> > +                     res->rx_irq[CHANNEL_NUM - 1 - i] =3D
> > +                             pci_irq_vector(pdev, 1 + i * 2);
> > +             }
> > +             for (i =3D 0; i < plat->tx_queues_to_use; i++) {
> > +                     res->tx_irq[CHANNEL_NUM - 1 - i] =3D
> > +                             pci_irq_vector(pdev, 2 + i * 2);
> > +             }
> > +
> > +             plat->flags |=3D STMMAC_FLAG_MULTI_MSI_EN;
> > +     }
> > +
> > +     res->irq =3D pci_irq_vector(pdev, 0);
> > +
> > +     return 0;
> > +}
>
> Could you please clarify whether the multi-channel feature will work
> if the pci_alloc_irq_vectors() method failed to allocated as many MSI
> vectors as there are channels?
>
> > +
> > +static int loongson_dwmac_msi_clear(struct pci_dev *pdev)
> > +{
> > +     pci_free_irq_vectors(pdev);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct mac_device_info *loongson_dwmac_setup(void *apriv)
> > +{
> > +     struct stmmac_priv *priv =3D apriv;
> > +     struct mac_device_info *mac;
> > +     struct stmmac_dma_ops *dma;
> > +     struct loongson_data *ld;
> > +     struct pci_dev *pdev;
> > +
> > +     ld =3D priv->plat->bsp_priv;
> > +     pdev =3D to_pci_dev(priv->device);
> > +
> > +     mac =3D devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
> > +     if (!mac)
> > +             return NULL;
> > +
> > +     dma =3D devm_kzalloc(priv->device, sizeof(*dma), GFP_KERNEL);
> > +     if (!dma)
> > +             return NULL;
> > +
>
> > +     /* The original IP-core version is v3.73a in all Loongson GNET
> > +      * (LS2K2000 and LS7A2000), but the GNET HW designers have change=
d the
> > +      * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the Loo=
ngson
> > +      * LS2K2000 MAC to emphasize the differences: multiple DMA-channe=
ls,
> > +      * AV feature and GMAC_INT_STATUS CSR flags layout. Get back the
> > +      * original value so the correct HW-interface would be selected.
> > +      */
>
> The comment needs to be altered since the multi-channel feature is no
> longer GNET-specific. Like this:
>
>         /* The Loongson GMAC and GNET devices are based on the DW GMAC
>          * v3.50a and v3.73a IP-cores. But the HW designers have changed =
the
>          * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the
>          * network controllers with the multi-channels feature
>          * available to emphasize the differences: multiple DMA-channels,
>          * AV feature and GMAC_INT_STATUS CSR flags layout. Get back the
>          * original value so the correct HW-interface would be selected.
>          */
>
> > +     if (ld->loongson_id =3D=3D DWMAC_CORE_LS2K2000) {
> > +             priv->synopsys_id =3D DWMAC_CORE_3_70;
> > +             *dma =3D dwmac1000_dma_ops;
> > +             dma->init_chan =3D loongson_gnet_dma_init_channel;
> > +             dma->dma_interrupt =3D loongson_gnet_dma_interrupt;
> > +             mac->dma =3D dma;
> > +     }
> > +
> > +     priv->dev->priv_flags |=3D IFF_UNICAST_FLT;
> > +
> > +     /* Pre-initialize the respective "mac" fields as it's done in
> > +      * dwmac1000_setup()
> > +      */
> > +     mac->pcsr =3D priv->ioaddr;
> > +     mac->multicast_filter_bins =3D priv->plat->multicast_filter_bins;
> > +     mac->unicast_filter_entries =3D priv->plat->unicast_filter_entrie=
s;
> > +     mac->mcast_bits_log2 =3D 0;
> > +
> > +     if (mac->multicast_filter_bins)
> > +             mac->mcast_bits_log2 =3D ilog2(mac->multicast_filter_bins=
);
> > +
>
> > +     /* Loongson GMAC doesn't support the flow control. LS2K2000
> > +      * GNET doesn't support the half-duplex link mode.
> > +      */
> > +     if (pdev->device =3D=3D PCI_DEVICE_ID_LOONGSON_GMAC) {
> > +             mac->link.caps =3D MAC_10 | MAC_100 | MAC_1000;
> > +     } else {
> > +             if (ld->loongson_id =3D=3D DWMAC_CORE_LS2K2000)
> > +                     mac->link.caps =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE=
 |
> > +                                      MAC_10 | MAC_100 | MAC_1000;
> > +             else
> > +                     mac->link.caps =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE=
 |
> > +                                      MAC_10FD | MAC_100FD | MAC_1000F=
D;
> > +     }
>
> AFAIU The only part that is applicable for the multi-channels case of
> the Loongson GMAC is:
> +       /* Loongson GMAC doesn't support the flow control */
> +       mac->link.caps =3D MAC_10 | MAC_100 | MAC_1000;
>
> If so the rest of the changes in this chunk should be moved to the new
> patch adding the Loongson GNET support.
>
> > +
> > +     mac->link.duplex =3D GMAC_CONTROL_DM;
> > +     mac->link.speed10 =3D GMAC_CONTROL_PS;
> > +     mac->link.speed100 =3D GMAC_CONTROL_PS | GMAC_CONTROL_FES;
> > +     mac->link.speed1000 =3D 0;
> > +     mac->link.speed_mask =3D GMAC_CONTROL_PS | GMAC_CONTROL_FES;
> > +     mac->mii.addr =3D GMAC_MII_ADDR;
> > +     mac->mii.data =3D GMAC_MII_DATA;
> > +     mac->mii.addr_shift =3D 11;
> > +     mac->mii.addr_mask =3D 0x0000F800;
> > +     mac->mii.reg_shift =3D 6;
> > +     mac->mii.reg_mask =3D 0x000007C0;
> > +     mac->mii.clk_csr_shift =3D 2;
> > +     mac->mii.clk_csr_mask =3D GENMASK(5, 2);
> > +
> > +     return mac;
> > +}
> > +
> >  static int loongson_dwmac_dt_config(struct pci_dev *pdev,
> >                                   struct plat_stmmacenet_data *plat,
> >                                   struct stmmac_resources *res)
> > @@ -119,6 +474,7 @@ static int loongson_dwmac_probe(struct pci_dev *pde=
v, const struct pci_device_id
> >       struct plat_stmmacenet_data *plat;
> >       struct stmmac_pci_info *info;
> >       struct stmmac_resources res;
> > +     struct loongson_data *ld;
> >       int ret, i;
> >
> >       plat =3D devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
> > @@ -135,6 +491,10 @@ static int loongson_dwmac_probe(struct pci_dev *pd=
ev, const struct pci_device_id
> >       if (!plat->dma_cfg)
> >               return -ENOMEM;
> >
> > +     ld =3D devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> > +     if (!ld)
> > +             return -ENOMEM;
> > +
> >       /* Enable pci device */
> >       ret =3D pci_enable_device(pdev);
> >       if (ret) {
> > @@ -159,19 +519,39 @@ static int loongson_dwmac_probe(struct pci_dev *p=
dev, const struct pci_device_id
> >
> >       pci_set_master(pdev);
> >
>
> > +     plat->bsp_priv =3D ld;
> > +     plat->setup =3D loongson_dwmac_setup;
> > +     ld->dev =3D &pdev->dev;
> > +
>
> Please make sure the chunk above and
> +       ld->loongson_id =3D readl(res.addr + GMAC_VERSION) & 0xff;
> are performed before the stmmac_pci_info::setup() is called so the
> callback could use the private platform data with the loongson_id
> field initialized.
>
> >       if (dev_of_node(&pdev->dev)) {
> >               ret =3D loongson_dwmac_dt_config(pdev, plat, &res);
> >               if (ret)
> >                       goto err_disable_device;
> > -     } else {
> > -             res.irq =3D pdev->irq;
> >       }
> >
> >       memset(&res, 0, sizeof(res));
>
> I've just realised the memset() call will clear out everything
> initialized in "res" by the loongson_dwmac_dt_config() method.
>
> >       res.addr =3D pcim_iomap_table(pdev)[0];
> > +     ld->loongson_id =3D readl(res.addr + GMAC_VERSION) & 0xff;
> > +
>
>
> > +     if (ld->loongson_id =3D=3D DWMAC_CORE_LS2K2000) {
> > +             plat->rx_queues_to_use =3D CHANNEL_NUM;
> > +             plat->tx_queues_to_use =3D CHANNEL_NUM;
> > +
> > +             /* Only channel 0 supports checksum,
> > +              * so turn off checksum to enable multiple channels.
> > +              */
> > +             for (i =3D 1; i < CHANNEL_NUM; i++)
> > +                     plat->tx_queues_cfg[i].coe_unsupported =3D 1;
> >
> > -     plat->tx_queues_to_use =3D 1;
> > -     plat->rx_queues_to_use =3D 1;
>
> Please move this part to the loongson_gmac_data() method (and to the
> loongson_gnet_data() in the new patch). The only
> code which would be left here is:
>         if (ld->loongson_id =3D=3D DWMAC_CORE_LOONGSON_MULTI_CH) {
>                 ret =3D loongson_dwmac_msi_config(pdev, plat, &res);
>                 if (ret)
>                         goto err_disable_device;
>         }
>
> > +             ret =3D loongson_dwmac_msi_config(pdev, plat, &res);
>
> > +     } else {
> > +             plat->tx_queues_to_use =3D 1;
> > +             plat->rx_queues_to_use =3D 1;
> > +
> > +             ret =3D loongson_dwmac_intx_config(pdev, plat, &res);
> > +     }
> > +     if (ret)
> > +             goto err_disable_device;
>
> This won't be needed if you get to implement what is suggested here
> https://lore.kernel.org/netdev/glm3jfqf36t5vnkmk4gsdqfx53ga7ohs3pxnsizqlo=
gkbim7gg@a3dxav5siczn/
>
> >
> >       ret =3D stmmac_dvr_probe(&pdev->dev, plat, &res);
> >       if (ret)
>
> I don't see the MSI-configs being undone in case of the
> stmmac_dvr_probe() failure. What should have been done:
>
>         ret =3D stmmac_dvr_probe(&pdev->dev, plat, &res);
>         if (ret)
>                 goto err_clear_msi;
>
>         return 0;
>
> err_clear_msi:
>         if (ld->loongson_id =3D=3D DWMAC_CORE_LOONGSON_MULTI_CH)
>                 loongson_dwmac_msi_clear(pdev);
>
> err_disable_device:
>         pci_disable_device(pdev);
>
>         ...
>
> > @@ -202,6 +582,7 @@ static void loongson_dwmac_remove(struct pci_dev *p=
dev)
> >               break;
> >       }
> >
>
> > +     loongson_dwmac_msi_clear(pdev);
>
> Shouldn't this be done for the multi-channels device only? Like this
>         if (ld->loongson_id =3D=3D DWMAC_CORE_LOONGSON_MULTI_CH)
>                 loongson_dwmac_msi_clear(pdev);
>
> >       pci_disable_device(pdev);
> >  }
> >
> > @@ -245,6 +626,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loo=
ngson_dwmac_suspend,
> >
> >  static const struct pci_device_id loongson_dwmac_id_table[] =3D {
> >       { PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
>
> > +     { PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
>
> Please move this to the new patch adding the Loongson GNET support.
>
>
>
> Sigh... The comments are brutal but if no more unexpected details get
> to be revealed the respective alterations shall bring us to the
> coherent set of changes. And hopefully there won't be need in such
> comprehensive patchset refactoring anymore.(
>
> -Serge(y)
>
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
> > --
> > 2.31.4
> >

