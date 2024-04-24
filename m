Return-Path: <netdev+bounces-90952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808368B0C16
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A301B1C22CB8
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3732715E5CB;
	Wed, 24 Apr 2024 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lymFI4VB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AF415B996
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967894; cv=none; b=ejWjwOx4E2dRB72ZbT9+Uw/pwl+NkOYR/02tstXnuRCT9Ejl3swIp1+DT7ZrLfAKGUiExfReEi9V2bjZ8xVpRujj3hxSwf/YpDBmlmJ7owg317y1Ecd2wVUB6hL2wGp0eMy7bWeUXRZGG/nREdwDkvKzrd4aqinggIONsW6upms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967894; c=relaxed/simple;
	bh=x2Old0KVoRA15qcEFJmpekzYO04y/bZhaD+KjPfcLbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRYfXNK1/oPCdA14vU0KSCbPDIKSmU7PI4E6Tqc/d6dtx31X5Mr80hd9A0w/nQRJJk6zhvmtQirMj3fyn3LBoESAv+Wptfpr5jwXJ74BwxWrNl6D5jRgOg1YUMHAW8e5wmIdY/aYnVsXl5zzULejo9nsJopcPcRzW1VmuvXL+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lymFI4VB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C04C32781
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713967893;
	bh=x2Old0KVoRA15qcEFJmpekzYO04y/bZhaD+KjPfcLbE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lymFI4VBuW5/ybeYSSJ+GfA1ebnPh4RIhmeXgUn5A/nAS3BA2wJslnJhHHn4bjfQO
	 YDvO8YjOTFsKxN9wqoogStcXZZDznbYJCHUp88GFurSNJreTQv44cRb2/0E9GeN69h
	 ZTgf+TZizhsWtl/RuDJul71QDFU1lSpmzgRw0nNLuimsGOTAjlDLjOCPzyujlx+szd
	 jotuc0yDNInMcuUSJ71rWVUjWNzg6IrU6aIJRJsGtpEKwZ7q4Wt87ok1UptRl+0M/5
	 Piv+LTIO/KFh42+qSALJ7eoohxgJQQp0IwfQiqyfaMvj2tIylnFRVCBUQTEP+8ohdo
	 SHyEYvh1x2aFw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a55b2f49206so175869866b.1
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 07:11:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWko1+SuM0hZut5/BhXLAOxrV2dOYsmDRsrvqKkKubd96heidoUzJxtOeTKWNcq+ty9GWm23QtzPRdaBHrLNPd1hz09dO59
X-Gm-Message-State: AOJu0YyUmwksSFSZqDiXgj+BYNykmsLa18xMCT7yNAK4hGJjRRpgGPXl
	Lw3gxcS1RdTC6m9hEranvWSEH9GPVxOPctEljw3htcgd31iWdYfCbILkiHda8hT76TLl91PJ0CR
	vntviNMN8bMW2SCTmu5DnlcCr0/E=
X-Google-Smtp-Source: AGHT+IF+c2/78CHuT6xIHQv75JawTVy/v+4xMotHJU/m4dE/ADgz29OexD7WCTul0E3LvMsrRPoWFNeDza9h63rlojw=
X-Received: by 2002:a17:907:9410:b0:a58:83a6:c68f with SMTP id
 dk16-20020a170907941000b00a5883a6c68fmr5308394ejc.17.1713967891804; Wed, 24
 Apr 2024 07:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712917541.git.siyanteng@loongson.cn> <9a8e5dfef0e9706e3d42bb20f59ea9ffa264dc8c.1712917541.git.siyanteng@loongson.cn>
 <jd4wmvwgmuzmdun3np3icp3lfinzhedq7enp5axqxs62ev4q2z@pl2ogfkscmqn>
In-Reply-To: <jd4wmvwgmuzmdun3np3icp3lfinzhedq7enp5axqxs62ev4q2z@pl2ogfkscmqn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 24 Apr 2024 22:11:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5=ZJ603J8ybKyCdMCK9B+OnA1Qu3M9GndbmqdCFgZcMA@mail.gmail.com>
Message-ID: <CAAhV-H5=ZJ603J8ybKyCdMCK9B+OnA1Qu3M9GndbmqdCFgZcMA@mail.gmail.com>
Subject: Re: [PATCH net-next v11 6/6] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	Jose.Abreu@synopsys.com, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Serge,

On Thu, Apr 18, 2024 at 10:01=E2=80=AFPM Serge Semin <fancer.lancer@gmail.c=
om> wrote:
>
> On Fri, Apr 12, 2024 at 07:28:51PM +0800, Yanteng Si wrote:
> > There are two types of Loongson DWGMAC. The first type shares the same
> > register definitions and has similar logic as dwmac1000. The second typ=
e
> > uses several different register definitions, we think it is necessary t=
o
> > distinguish rx and tx, so we split these bits into two.
> >
> > Simply put, we split some single bit fields into double bits fileds:
> >
> >      Name              Tx          Rx
> >
> > DMA_INTR_ENA_NIE =3D 0x00040000 | 0x00020000;
> > DMA_INTR_ENA_AIE =3D 0x00010000 | 0x00008000;
> > DMA_STATUS_NIS   =3D 0x00040000 | 0x00020000;
> > DMA_STATUS_AIS   =3D 0x00010000 | 0x00008000;
> > DMA_STATUS_FBI   =3D 0x00002000 | 0x00001000;
> >
> > Therefore, when using, TX and RX must be set at the same time.
> >
> > How to use them:
> >  1. Create the Loongson GNET-specific
> >  stmmac_dma_ops.dma_interrupt()
> >  stmmac_dma_ops.init_chan()
> >  methods in the dwmac-loongson.c driver. Adding all the
> >  Loongson-specific macros
> >
> >  2. Create a Loongson GNET-specific platform setup method with the next
> >  semantics:
> >     + allocate stmmac_dma_ops instance and initialize it with
> >       dwmac1000_dma_ops.
> >     + override the stmmac_dma_ops.{dma_interrupt, init_chan} with
> >       the pointers to the methods defined in 2.
> >     + allocate mac_device_info instance and initialize the
> >       mac_device_info.dma field with a pointer to the new
> >       stmmac_dma_ops instance.
> >     + initialize mac_device_info in a way it's done in
> >       dwmac1000_setup().
> >
> >  3. Initialize plat_stmmacenet_data.setup() with the pointer to the
> >  method created in 2.
> >
> > GNET features:
> >
> >  Speeds: 10/100/1000Mbps
>
> >  DMA-descriptors type: normal and enhanced
>
> Hm, it's either one or another. They can't be both supported because
> the alternative descriptors are enabled by the DESC_ENHANCED_FORMAT
> HDL parameter defined on the IP-core synthesize stage.
>
> >  L3/L4 filters availability: support
> >  VLAN hash table filter: support
> >  PHY-interface: GMII
> >  Remote Wake-up support: support
> >  Mac Management Counters (MMC): support
> >  DMA chennel number: 0x10 device is 8 and 0x37 device is 1
>
> What about adding the info like:
> Number of additional MAC addresses
> MAC Hash-based filter support and if supported the hash table size.
>
> >
> > Others:
> >
> >  GNET integrates both MAC and PHY chips inside.
> >  GNET device: LS2K2000, LS7A2000, the chip connection between the mac a=
nd
> >              phy of these devices is not normal and requires two rounds=
 of
> >              negotiation; LS7A2000 does not support half-duplex and
> >              multi-channel;
> >
> >              To enable multi-channel on LS2K2000, you need to turn off
> >              hardware checksum.
> >
>
> > **Note**: Currently, only the LS2K2000's IP core is 0x10,
>
> This doesn't sound correct. The LS2K2000's IP-core is v3.73a. But the
> SNPS Version ID was manually altered by the hardware designers.
>
> > while the IP
> > cores of other devices are 0x37.
>
> Real IP-core ID isn't described by the hex number. It's a digit number
> like v3.73a/v3.50a/etc. Hex number you constantly repeat is the
> MAC_Version.SNPSVER register value. So please use the IP-core version
> in the v3.xx format all over the patch text.
>
> >
> > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/common.h  |   2 +
> >  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 476 ++++++++++++++++--
> >  .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |   1 +
> >  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   6 +
> >  include/linux/stmmac.h                        |   1 +
> >  5 files changed, 447 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net=
/ethernet/stmicro/stmmac/common.h
> > index 9cd62b2110a1..6777dc997e9f 100644
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
> > @@ -258,6 +259,7 @@ struct stmmac_safety_stats {
> >  #define CSR_F_300M   300000000
> >
> >  #define      MAC_CSR_H_FRQ_MASK      0x20
>
> > +#define      MAC_CTRL_PORT_SELECT_10_100     BIT(15)
>
> No, this is already defined in:
> drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
> as GMAC_CONTROL_PS macros. Use it instead of adding new macros.
>
> >
> >  #define HASH_TABLE_SIZE 64
> >  #define PAUSE_TIME 0xffff
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/dri=
vers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > index 69078eb1f923..4edfbb4fcb64 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > @@ -8,8 +8,70 @@
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
> > +#define PCI_DEVICE_ID_LOONGSON_GNET  0x7a13
> > +#define LOONGSON_DWMAC_CORE_1_00     0x10    /* Loongson custom IP */
> > +#define CHANNEL_NUM                  8
> > +
> > +struct loongson_data {
> > +     struct device *dev;
> > +};
> >
> >  struct stmmac_pci_info {
> >       int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *p=
lat);
> > @@ -56,6 +117,8 @@ static int loongson_gmac_data(struct pci_dev *pdev,
> >       plat->dma_cfg->pblx8 =3D true;
> >
> >       plat->multicast_filter_bins =3D 256;
>
> > +     plat->mdio_bus_data->phy_mask =3D 0;
> > +
>
> And this change isn't related to the GNET. Why is it here?
>
> >       plat->clk_ref_rate =3D 125000000;
> >       plat->clk_ptp_rate =3D 125000000;
> >
> > @@ -69,13 +132,342 @@ static struct stmmac_pci_info loongson_gmac_pci_i=
nfo =3D {
> >       .setup =3D loongson_gmac_data,
> >  };
> >
> > -static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci=
_device_id *id)
> > +static void loongson_gnet_dma_init_channel(struct stmmac_priv *priv,
> > +                                        void __iomem *ioaddr,
> > +                                        struct stmmac_dma_cfg *dma_cfg=
,
> > +                                        u32 chan)
> > +{
> > +     int txpbl =3D dma_cfg->txpbl ?: dma_cfg->pbl;
> > +     int rxpbl =3D dma_cfg->rxpbl ?: dma_cfg->pbl;
> > +     u32 value;
> > +
>
> > +     /* common channel control register config */
>
> Useless comment. Please drop.
>
> > +     value =3D readl(ioaddr + DMA_CHAN_BUS_MODE(chan));
> > +
>
> > +     /* Set the DMA PBL (Programmable Burst Length) mode.
> > +      *
> > +      * Note: before stmmac core 3.50 this mode bit was 4xPBL, and
> > +      * post 3.5 mode bit acts as 8*PBL.
> > +      */
>
> Do you have an IP-core older than v3.50a? No. So please drop the
> comment.
>
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
> > +static int loongson_gnet_dma_interrupt(struct stmmac_priv *priv,
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
> > +     /* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
> > +     writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
> > +
> > +     return ret;
> > +}
> > +
> > +static void loongson_gnet_fix_speed(void *priv, unsigned int speed,
> > +                                 unsigned int mode)
> > +{
> > +     struct loongson_data *ld =3D (struct loongson_data *)priv;
> > +     struct net_device *ndev =3D dev_get_drvdata(ld->dev);
> > +     struct stmmac_priv *ptr =3D netdev_priv(ndev);
> > +
> > +     /* The controller and PHY don't work well together.
> > +      * We need to use the PS bit to check if the controller's status
> > +      * is correct and reset PHY if necessary.
> > +      * MAC_CTRL_REG.15 is defined by the GMAC_CONTROL_PS macro.
> > +      */
> > +     if (speed =3D=3D SPEED_1000) {
> > +             if (readl(ptr->ioaddr + MAC_CTRL_REG) &
>
> > +                 MAC_CTRL_PORT_SELECT_10_100)
>
> GMAC_CONTROL_PS?
>
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
> > +     plat->phy_addr =3D -1;
> > +     plat->phy_interface =3D PHY_INTERFACE_MODE_GMII;
> > +
> > +     plat->dma_cfg->pbl =3D 32;
> > +     plat->dma_cfg->pblx8 =3D true;
> > +
> > +     plat->multicast_filter_bins =3D 256;
> > +     plat->mdio_bus_data->phy_mask =3D ~(u32)BIT(2);
> > +
>
> > +     plat->clk_ref_rate =3D 125000000;
> > +     plat->clk_ptp_rate =3D 125000000;
>
> If this is common for both GMAC and GNET what about moving it to the
> loongson_default_data() method?
>
> If so please just do that in the patch 4 where you get to add these
> fields initialization in the first place.
>
> > +
> > +     plat->fix_mac_speed =3D loongson_gnet_fix_speed;
> > +
> > +     return 0;
> > +}
> > +
> > +static struct stmmac_pci_info loongson_gnet_pci_info =3D {
> > +     .setup =3D loongson_gnet_data,
> > +};
> > +
> > +static int loongson_dwmac_config_legacy(struct pci_dev *pdev,
> > +                                     struct plat_stmmacenet_data *plat=
,
> > +                                     struct stmmac_resources *res,
> > +                                     struct device_node *np)
> > +{
> > +     if (np) {
> > +             res->irq =3D of_irq_get_byname(np, "macirq");
> > +             if (res->irq < 0) {
> > +                     dev_err(&pdev->dev, "IRQ macirq not found\n");
> > +                     return -ENODEV;
> > +             }
> > +
> > +             res->wol_irq =3D of_irq_get_byname(np, "eth_wake_irq");
> > +             if (res->wol_irq < 0) {
> > +                     dev_info(&pdev->dev,
> > +                              "IRQ eth_wake_irq not found, using macir=
q\n");
> > +                     res->wol_irq =3D res->irq;
> > +             }
> > +
> > +             res->lpi_irq =3D of_irq_get_byname(np, "eth_lpi");
> > +             if (res->lpi_irq < 0) {
> > +                     dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> > +                     return -ENODEV;
> > +             }
> > +     } else {
> > +             res->irq =3D pdev->irq;
> > +             res->wol_irq =3D res->irq;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int loongson_dwmac_config_msi(struct pci_dev *pdev,
> > +                                  struct plat_stmmacenet_data *plat,
> > +                                  struct stmmac_resources *res,
> > +                                  struct device_node *np)
> > +{
> > +     int i, ret, vecs;
> > +
> > +     vecs =3D roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
> > +     ret =3D pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
> > +     if (ret < 0) {
> > +             dev_info(&pdev->dev,
> > +                      "MSI enable failed, Fallback to legacy interrupt=
\n");
> > +             return loongson_dwmac_config_legacy(pdev, plat, res, np);
> > +     }
> > +
> > +     res->irq =3D pci_irq_vector(pdev, 0);
> > +     res->wol_irq =3D 0;
> > +
> > +     /* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> > +      * --------- ----- -------- --------  ...  -------- --------
> > +      * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> > +      */
> > +     for (i =3D 0; i < CHANNEL_NUM; i++) {
> > +             res->rx_irq[CHANNEL_NUM - 1 - i] =3D
> > +                     pci_irq_vector(pdev, 1 + i * 2);
> > +             res->tx_irq[CHANNEL_NUM - 1 - i] =3D
> > +                     pci_irq_vector(pdev, 2 + i * 2);
> > +     }
> > +
> > +     plat->flags |=3D STMMAC_FLAG_MULTI_MSI_EN;
>
> Once again. Please replace this with simpler solution:
In full PCI system the below function works fine, because alloc irq
vectors with PCI_IRQ_LEGACY do the same thing as fallback to call
loongson_dwmac_config_legacy(). But for a DT-based system it doesn't
work.

Huacai
>
> static int loongson_dwmac_config_multi_msi(struct pci_dev *pdev,
> +                                          struct plat_stmmacenet_data *p=
lat,
> +                                          struct stmmac_resources *res)
> +{
> +       int i, ret, vecs;
> +
> +       /* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> +        * --------- ----- -------- --------  ...  -------- --------
> +        * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> +        */
> +       vecs =3D plat->rx_queues_to_use + plat->tx_queues_to_use + 1;
> +       ret =3D pci_alloc_irq_vectors(pdev, 1, vecs, PCI_IRQ_MSI | PCI_IR=
Q_LEGACY);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "Failed to allocate PCI IRQs\n");
> +               return ret;
> +       } else if (ret >=3D vecs) {
> +               for (i =3D 0; i < plat->rx_queues_to_use; i++) {
> +                       res->rx_irq[CHANNELS_NUM - 1 - i] =3D
> +                               pci_irq_vector(pdev, 1 + i * 2);
> +               }
> +               for (i =3D 0; i < plat->tx_queues_to_use; i++) {
> +                       res->tx_irq[CHANNELS_NUM - 1 - i] =3D
> +                               pci_irq_vector(pdev, 2 + i * 2);
> +               }
> +
> +               plat->flags |=3D STMMAC_FLAG_MULTI_MSI_EN;
> +       }
> +
> +       res->irq =3D pci_irq_vector(pdev, 0);
> +
> +       return 0;
> +}
>
>
> > +
> > +     return 0;
> > +}
> > +
> > +static struct mac_device_info *loongson_dwmac_setup(void *apriv)
> > +{
> > +     struct stmmac_priv *priv =3D apriv;
> > +     struct stmmac_resources res;
> > +     struct mac_device_info *mac;
> > +     struct stmmac_dma_ops *dma;
> > +     struct pci_dev *pdev;
> > +     u32 loongson_gmac;
> > +
> > +     memset(&res, 0, sizeof(res));
> > +     pdev =3D to_pci_dev(priv->device);
> > +     res.addr =3D pcim_iomap_table(pdev)[0];
> > +     loongson_gmac =3D readl(res.addr + GMAC_VERSION) & 0xff;
> > +
> > +     mac =3D devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
> > +     if (!mac)
> > +             return NULL;
> > +
> > +     dma =3D devm_kzalloc(priv->device, sizeof(*dma), GFP_KERNEL);
> > +     if (!dma)
> > +             return NULL;
> > +
> > +     /* The original IP-core version is 0x37 in all Loongson GNET
> > +      * (ls2k2000 and ls7a2000), but the GNET HW designers have change=
d the
> > +      * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the Loo=
ngson
> > +      * ls2k2000 MAC to emphasize the differences: multiple DMA-channe=
ls,
> > +      * AV feature and GMAC_INT_STATUS CSR flags layout. Get back the
> > +      * original value so the correct HW-interface would be selected.
> > +      */
> > +     if (loongson_gmac =3D=3D LOONGSON_DWMAC_CORE_1_00) {
> > +             priv->synopsys_id =3D DWMAC_CORE_3_70;
> > +             *dma =3D dwmac1000_dma_ops;
> > +             dma->init_chan =3D loongson_gnet_dma_init_channel;
> > +             dma->dma_interrupt =3D loongson_gnet_dma_interrupt;
> > +             mac->dma =3D dma;
> > +     }
> > +
> > +     mac->mac =3D &dwmac1000_ops;
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
> > +     /* The GMAC devices with PCI ID 0x7a03 does not support any pause=
 mode.
> > +      * The GNET devices without CORE ID 0x10 does not support half-du=
plex.
> > +      */
> > +     if (pdev->device =3D=3D PCI_DEVICE_ID_LOONGSON_GMAC) {
> > +             mac->link.caps =3D MAC_10 | MAC_100 | MAC_1000;
> > +     } else {
> > +             if (loongson_gmac =3D=3D LOONGSON_DWMAC_CORE_1_00)
> > +                     mac->link.caps =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE=
 |
> > +                                      MAC_10 | MAC_100 | MAC_1000;
> > +             else
> > +                     mac->link.caps =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE=
 |
> > +                                      MAC_10FD | MAC_100FD | MAC_1000F=
D;
> > +     }
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
> > +static int loongson_dwmac_probe(struct pci_dev *pdev,
> > +                             const struct pci_device_id *id)
> >  {
> >       struct plat_stmmacenet_data *plat;
> >       int ret, i, bus_id, phy_mode;
> >       struct stmmac_pci_info *info;
> >       struct stmmac_resources res;
> > +     struct loongson_data *ld;
> >       struct device_node *np;
> > +     u32 loongson_gmac;
> >
> >       plat =3D devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
> >       if (!plat)
> > @@ -88,10 +482,14 @@ static int loongson_dwmac_probe(struct pci_dev *pd=
ev, const struct pci_device_id
> >               return -ENOMEM;
> >
> >       plat->dma_cfg =3D devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg)=
, GFP_KERNEL);
> > -     if (!plat->dma_cfg) {
> > -             ret =3D -ENOMEM;
> > -             goto err_put_node;
> > -     }
> > +     if (!plat->dma_cfg)
> > +             return -ENOMEM;
> > +
> > +     ld =3D devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> > +     if (!ld)
> > +             return -ENOMEM;
> > +
>
> > +     np =3D dev_of_node(&pdev->dev);
>
> Here is the missing np from the patch 5...
>
> >
> >       /* Enable pci device */
> >       ret =3D pci_enable_device(pdev);
> > @@ -110,14 +508,6 @@ static int loongson_dwmac_probe(struct pci_dev *pd=
ev, const struct pci_device_id
> >               break;
> >       }
> >
>
> > -     phy_mode =3D device_get_phy_mode(&pdev->dev);
> > -     if (phy_mode < 0) {
> > -             dev_err(&pdev->dev, "phy_mode not found\n");
> > -             ret =3D phy_mode;
> > -             goto err_disable_device;
> > -     }
> > -
> > -     plat->phy_interface =3D phy_mode;
>
> This change must have been added to the Patch 5 where you get to move
> all the NP-related things into the "if (np) {}" clause!
>
> >       plat->mac_interface =3D PHY_INTERFACE_MODE_GMII;
> >
> >       pci_set_master(pdev);
> > @@ -133,7 +523,6 @@ static int loongson_dwmac_probe(struct pci_dev *pde=
v, const struct pci_device_id
> >                       dev_info(&pdev->dev, "Found MDIO subnode\n");
> >                       plat->mdio_bus_data->needs_reset =3D true;
> >               }
> > -
> >               bus_id =3D of_alias_get_id(np, "ethernet");
> >               if (bus_id >=3D 0)
> >                       plat->bus_id =3D bus_id;
> > @@ -145,42 +534,49 @@ static int loongson_dwmac_probe(struct pci_dev *p=
dev, const struct pci_device_id
> >                       goto err_disable_device;
> >               }
> >               plat->phy_interface =3D phy_mode;
>
> > +     }
> >
> > -             res.irq =3D of_irq_get_byname(np, "macirq");
> > -             if (res.irq < 0) {
> > -                     dev_err(&pdev->dev, "IRQ macirq not found\n");
> > -                     ret =3D -ENODEV;
> > -                     goto err_disable_msi;
> > -             }
> > +     plat->bsp_priv =3D ld;
> > +     plat->setup =3D loongson_dwmac_setup;
> > +     ld->dev =3D &pdev->dev;
> >
> > -             res.wol_irq =3D of_irq_get_byname(np, "eth_wake_irq");
> > -             if (res.wol_irq < 0) {
> > -                     dev_info(&pdev->dev, "IRQ eth_wake_irq not found,=
 using macirq\n");
> > -                     res.wol_irq =3D res.irq;
> > -             }
> > +     memset(&res, 0, sizeof(res));
> > +     res.addr =3D pcim_iomap_table(pdev)[0];
> > +     loongson_gmac =3D readl(res.addr + GMAC_VERSION) & 0xff;
> >
> > -             res.lpi_irq =3D of_irq_get_byname(np, "eth_lpi");
> > -             if (res.lpi_irq < 0) {
> > -                     dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> > -                     ret =3D -ENODEV;
> > -                     goto err_disable_msi;
> > -             }
> > -     } else {
> > -             res.irq =3D pdev->irq;
>
> Please, move the loongson_dwmac_config_legacy() method creation change
> into a preparation/pre-requisite patch. That will vastly simplify this
> patch and will help with reviewing it!
>
> > +     switch (loongson_gmac) {
> > +     case LOONGSON_DWMAC_CORE_1_00:
> > +             plat->rx_queues_to_use =3D CHANNEL_NUM;
> > +             plat->tx_queues_to_use =3D CHANNEL_NUM;
> > +
> > +             /* Only channel 0 supports checksum,
> > +              * so turn off checksum to enable multiple channels.
> > +              */
> > +             for (i =3D 1; i < CHANNEL_NUM; i++)
> > +                     plat->tx_queues_cfg[i].coe_unsupported =3D 1;
> > +
> > +             ret =3D loongson_dwmac_config_msi(pdev, plat, &res, np);
> > +             break;
> > +     default:        /* 0x35 device and 0x37 device. */
> > +             plat->tx_queues_to_use =3D 1;
> > +             plat->rx_queues_to_use =3D 1;
> > +             ret =3D loongson_dwmac_config_legacy(pdev, plat, &res, np=
);
> > +             break;
> >       }
> >
> > -     pci_enable_msi(pdev);
> > -     memset(&res, 0, sizeof(res));
> > -     res.addr =3D pcim_iomap_table(pdev)[0];
>
> > +     /* GNET devices with dev revision 0x00 do not support manually
> > +      * setting the speed to 1000.
> > +      */
> > +     if (pdev->device =3D=3D PCI_DEVICE_ID_LOONGSON_GNET &&
> > +         pdev->revision =3D=3D 0x00)
> > +             plat->flags |=3D STMMAC_FLAG_DISABLE_FORCE_1000;
>
> Move this to the loongson_gnet_data() method.
>
> >
> >       ret =3D stmmac_dvr_probe(&pdev->dev, plat, &res);
> >       if (ret)
> > -             goto err_disable_msi;
> > +             goto err_disable_device;
> >
> >       return ret;
> >
> > -err_disable_msi:
> > -     pci_disable_msi(pdev);
> >  err_disable_device:
> >       pci_disable_device(pdev);
> >  err_put_node:
> > @@ -248,6 +644,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loo=
ngson_dwmac_suspend,
> >
> >  static const struct pci_device_id loongson_dwmac_id_table[] =3D {
> >       { PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
> > +     { PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
>
> > @@ -266,4 +663,5 @@ module_pci_driver(loongson_dwmac_driver);
> >
> >  MODULE_DESCRIPTION("Loongson DWMAC PCI driver");
> >  MODULE_AUTHOR("Qing Zhang <zhangqing@loongson.cn>");
> > +MODULE_AUTHOR("Yanteng Si <siyanteng@loongson.cn>");
> >  MODULE_LICENSE("GPL v2");
>
> Please move this into a separate patch. It can be the last patch in
> the series.
>
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/driv=
ers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> > index f161ec9ac490..66c0c22908b1 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> > @@ -296,3 +296,4 @@ const struct stmmac_dma_ops dwmac1000_dma_ops =3D {
> >       .get_hw_feature =3D dwmac1000_get_hw_feature,
> >       .rx_watchdog =3D dwmac1000_rx_watchdog,
> >  };
> > +EXPORT_SYMBOL_GPL(dwmac1000_dma_ops);
>
>
> Please move this into a preparation/pre-requisite patch.
>
>
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/dri=
vers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > index e1537a57815f..e94faa72f30e 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > @@ -420,6 +420,12 @@ stmmac_ethtool_set_link_ksettings(struct net_devic=
e *dev,
> >               return 0;
> >       }
> >
> > +     if (priv->plat->flags & STMMAC_FLAG_DISABLE_FORCE_1000) {
> > +             if (cmd->base.speed =3D=3D SPEED_1000 &&
> > +                 cmd->base.autoneg !=3D AUTONEG_ENABLE)
> > +                     return -EOPNOTSUPP;
> > +     }
> > +
> >       return phylink_ethtool_ksettings_set(priv->phylink, cmd);
> >  }
> >
> > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > index 1b54b84a6785..c5d3d0ddb6f8 100644
> > --- a/include/linux/stmmac.h
> > +++ b/include/linux/stmmac.h
> > @@ -223,6 +223,7 @@ struct dwmac4_addrs {
> >  #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI               BIT(10)
> >  #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING    BIT(11)
> >  #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY BIT(12)
> > +#define STMMAC_FLAG_DISABLE_FORCE_1000               BIT(13)
> >
> >  struct plat_stmmacenet_data {
> >       int bus_id;
>
> Please move this in a separate _pre-requisite/preparation_ patch.
> Really. Why have you merged it into this one? This patch already got
> to be too complicated. Don't make it even more complex.
>
> ---
>
> I look at v8 and look at v9 series. Why have you re-shuffled the
> change so significantly??? It has made my life in reviewing your bits
> much harder because instead of checking whether you took my v8-notes
> into account I had to once again analyze the entire series. Sigh...
>
> -Serge(y)
>
> > --
> > 2.31.4
> >

