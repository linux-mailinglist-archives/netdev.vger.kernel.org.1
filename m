Return-Path: <netdev+bounces-90913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D74F18B0B3D
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D371C221AE
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 13:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E49E15E5BE;
	Wed, 24 Apr 2024 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAbcB6HO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C9115CD53
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965846; cv=none; b=F78HrG0YqmMsoKQCIBNf1XhM5mJ5Z49iUR0VDPbsFWazMY+bcOfRBDoOf5NfTHdGQktf+Q+BSiLPIgsRoLBJljSejeuZEp3MEERAFxVZk2zNrZQWxhZ9s2OMxTAULtDdLwz/MQs8yomy73qe8Cs7yJcfTfEvqj4gBnxKGl3zKeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965846; c=relaxed/simple;
	bh=ZHsDvClyr3bKB73AKC+iToRGWReBCEeDatDmtMRKmnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MF7OXKOTcdeN/ENeszRW0E7p2KHzRDVT8n8nYwJA0qrFUAK/6NCbKHpFuo/Jo951V9Z1UOYceUj+LUCK70KAClV4F5CsqcotKx3pa/NafeBlv0cYeMj1V4xxR9Vw8wQiBs8k6ARvV6/FmpAyqijAj5FdwhwnliEf+Ma2iW0/URk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAbcB6HO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A42C4AF09
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 13:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713965845;
	bh=ZHsDvClyr3bKB73AKC+iToRGWReBCEeDatDmtMRKmnQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VAbcB6HO+QVEI9vOzhUK3fWvVOGORAU3/xoCDv7x5JxncdvEe+u55nkEBrVqQzWdf
	 /nfznlKgxJXw/7ZYUiTA0DJfkxZrkzIkR0PRYXyd3ZGiTQxjBZX9npEPGO/wNFiEyY
	 DgoBoguIhJv+RVJddj89WDkfErpnrz7j5u5IFx6TaT+S4fbDe0tZETtbyDP8cpzTlp
	 jDH8VNMsTO+aqOTX9cYHpOqYiBlWrJkDk0szajTwHLR6VBvYbVMktXpeVb5f2Gp/fw
	 DrY+0R51PylvTRRTlYYOQAT8Y1qkdK6VwHDHnjhiruj4+Ziet+8e9HLOkBXIwvHZY3
	 wo/ycr4wL/k5w==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so10476086a12.2
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 06:37:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXOHnvPov0O7QrzT6Btwo1UbyEivzvQ3fM1x0nAhky5tJxgOywuRAuLnAVqzeAtpQmVt8M7BTzF9QEPHXRaW6mqyP5enQDw
X-Gm-Message-State: AOJu0Yy85+FjW8vtgiGv0jDR45n78b7YXmm/S6Lg64gZEcvo6aX4qx0d
	qo8QzJ7Y/5XWmzhkBMGI/tPWiltPSTIPMCK4UdPcpndhK1L7DkPDF5VEj9KAJLlZLOYwHY+o4jd
	t6jRDOySL6VDCgb44VA6Msd/Dvdg=
X-Google-Smtp-Source: AGHT+IEurMv434K9d/wJoRnUKRGdj6DujMsztSiCtSS5U6NdRT1wZ+fHyAU4GB0+SYjr2eTLR+urfa/BYkDv1PAx8Jk=
X-Received: by 2002:a17:907:20b5:b0:a58:828b:a4a6 with SMTP id
 pw21-20020a17090720b500b00a58828ba4a6mr2320779ejb.73.1713965844066; Wed, 24
 Apr 2024 06:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712917541.git.siyanteng@loongson.cn> <9a8e5dfef0e9706e3d42bb20f59ea9ffa264dc8c.1712917541.git.siyanteng@loongson.cn>
In-Reply-To: <9a8e5dfef0e9706e3d42bb20f59ea9ffa264dc8c.1712917541.git.siyanteng@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 24 Apr 2024 21:37:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H76DNwB5mrzTYZ=oo=NXHamUZa18g5Skst7i9bC5pnbWA@mail.gmail.com>
Message-ID: <CAAhV-H76DNwB5mrzTYZ=oo=NXHamUZa18g5Skst7i9bC5pnbWA@mail.gmail.com>
Subject: Re: [PATCH net-next v11 6/6] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com, 
	Jose.Abreu@synopsys.com, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Yanteng,

On Fri, Apr 12, 2024 at 7:29=E2=80=AFPM Yanteng Si <siyanteng@loongson.cn> =
wrote:
>
> There are two types of Loongson DWGMAC. The first type shares the same
> register definitions and has similar logic as dwmac1000. The second type
> uses several different register definitions, we think it is necessary to
> distinguish rx and tx, so we split these bits into two.
>
> Simply put, we split some single bit fields into double bits fileds:
>
>      Name              Tx          Rx
>
> DMA_INTR_ENA_NIE =3D 0x00040000 | 0x00020000;
> DMA_INTR_ENA_AIE =3D 0x00010000 | 0x00008000;
> DMA_STATUS_NIS   =3D 0x00040000 | 0x00020000;
> DMA_STATUS_AIS   =3D 0x00010000 | 0x00008000;
> DMA_STATUS_FBI   =3D 0x00002000 | 0x00001000;
>
> Therefore, when using, TX and RX must be set at the same time.
>
> How to use them:
>  1. Create the Loongson GNET-specific
>  stmmac_dma_ops.dma_interrupt()
>  stmmac_dma_ops.init_chan()
>  methods in the dwmac-loongson.c driver. Adding all the
>  Loongson-specific macros
>
>  2. Create a Loongson GNET-specific platform setup method with the next
>  semantics:
>     + allocate stmmac_dma_ops instance and initialize it with
>       dwmac1000_dma_ops.
>     + override the stmmac_dma_ops.{dma_interrupt, init_chan} with
>       the pointers to the methods defined in 2.
>     + allocate mac_device_info instance and initialize the
>       mac_device_info.dma field with a pointer to the new
>       stmmac_dma_ops instance.
>     + initialize mac_device_info in a way it's done in
>       dwmac1000_setup().
>
>  3. Initialize plat_stmmacenet_data.setup() with the pointer to the
>  method created in 2.
>
> GNET features:
>
>  Speeds: 10/100/1000Mbps
>  DMA-descriptors type: normal and enhanced
>  L3/L4 filters availability: support
>  VLAN hash table filter: support
>  PHY-interface: GMII
>  Remote Wake-up support: support
>  Mac Management Counters (MMC): support
>  DMA chennel number: 0x10 device is 8 and 0x37 device is 1
>
> Others:
>
>  GNET integrates both MAC and PHY chips inside.
>  GNET device: LS2K2000, LS7A2000, the chip connection between the mac and
>              phy of these devices is not normal and requires two rounds o=
f
>              negotiation; LS7A2000 does not support half-duplex and
>              multi-channel;
>
>              To enable multi-channel on LS2K2000, you need to turn off
>              hardware checksum.
>
> **Note**: Currently, only the LS2K2000's IP core is 0x10, while the IP
> cores of other devices are 0x37.
>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h  |   2 +
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 476 ++++++++++++++++--
>  .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |   1 +
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   6 +
>  include/linux/stmmac.h                        |   1 +
>  5 files changed, 447 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/e=
thernet/stmicro/stmmac/common.h
> index 9cd62b2110a1..6777dc997e9f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -29,6 +29,7 @@
>  /* Synopsys Core versions */
>  #define        DWMAC_CORE_3_40         0x34
>  #define        DWMAC_CORE_3_50         0x35
> +#define        DWMAC_CORE_3_70         0x37
>  #define        DWMAC_CORE_4_00         0x40
>  #define DWMAC_CORE_4_10                0x41
>  #define DWMAC_CORE_5_00                0x50
> @@ -258,6 +259,7 @@ struct stmmac_safety_stats {
>  #define CSR_F_300M     300000000
>
>  #define        MAC_CSR_H_FRQ_MASK      0x20
> +#define        MAC_CTRL_PORT_SELECT_10_100     BIT(15)
>
>  #define HASH_TABLE_SIZE 64
>  #define PAUSE_TIME 0xffff
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drive=
rs/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 69078eb1f923..4edfbb4fcb64 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -8,8 +8,70 @@
>  #include <linux/device.h>
>  #include <linux/of_irq.h>
>  #include "stmmac.h"
> +#include "dwmac_dma.h"
> +#include "dwmac1000.h"
> +
> +/* Normal Loongson Tx Summary */
> +#define DMA_INTR_ENA_NIE_TX_LOONGSON   0x00040000
> +/* Normal Loongson Rx Summary */
> +#define DMA_INTR_ENA_NIE_RX_LOONGSON   0x00020000
> +
> +#define DMA_INTR_NORMAL_LOONGSON       (DMA_INTR_ENA_NIE_TX_LOONGSON | \
> +                                        DMA_INTR_ENA_NIE_RX_LOONGSON | \
> +                                        DMA_INTR_ENA_RIE | DMA_INTR_ENA_=
TIE)
> +
> +/* Abnormal Loongson Tx Summary */
> +#define DMA_INTR_ENA_AIE_TX_LOONGSON   0x00010000
> +/* Abnormal Loongson Rx Summary */
> +#define DMA_INTR_ENA_AIE_RX_LOONGSON   0x00008000
> +
> +#define DMA_INTR_ABNORMAL_LOONGSON     (DMA_INTR_ENA_AIE_TX_LOONGSON | \
> +                                        DMA_INTR_ENA_AIE_RX_LOONGSON | \
> +                                        DMA_INTR_ENA_FBE | DMA_INTR_ENA_=
UNE)
> +
> +#define DMA_INTR_DEFAULT_MASK_LOONGSON (DMA_INTR_NORMAL_LOONGSON | \
> +                                        DMA_INTR_ABNORMAL_LOONGSON)
> +
> +/* Normal Loongson Tx Interrupt Summary */
> +#define DMA_STATUS_NIS_TX_LOONGSON     0x00040000
> +/* Normal Loongson Rx Interrupt Summary */
> +#define DMA_STATUS_NIS_RX_LOONGSON     0x00020000
> +
> +/* Abnormal Loongson Tx Interrupt Summary */
> +#define DMA_STATUS_AIS_TX_LOONGSON     0x00010000
> +/* Abnormal Loongson Rx Interrupt Summary */
> +#define DMA_STATUS_AIS_RX_LOONGSON     0x00008000
> +
> +/* Fatal Loongson Tx Bus Error Interrupt */
> +#define DMA_STATUS_FBI_TX_LOONGSON     0x00002000
> +/* Fatal Loongson Rx Bus Error Interrupt */
> +#define DMA_STATUS_FBI_RX_LOONGSON     0x00001000
> +
> +#define DMA_STATUS_MSK_COMMON_LOONGSON (DMA_STATUS_NIS_TX_LOONGSON | \
> +                                        DMA_STATUS_NIS_RX_LOONGSON | \
> +                                        DMA_STATUS_AIS_TX_LOONGSON | \
> +                                        DMA_STATUS_AIS_RX_LOONGSON | \
> +                                        DMA_STATUS_FBI_TX_LOONGSON | \
> +                                        DMA_STATUS_FBI_RX_LOONGSON)
> +
> +#define DMA_STATUS_MSK_RX_LOONGSON     (DMA_STATUS_ERI | DMA_STATUS_RWT =
| \
> +                                        DMA_STATUS_RPS | DMA_STATUS_RU  =
| \
> +                                        DMA_STATUS_RI  | DMA_STATUS_OVF =
| \
> +                                        DMA_STATUS_MSK_COMMON_LOONGSON)
> +
> +#define DMA_STATUS_MSK_TX_LOONGSON     (DMA_STATUS_ETI | DMA_STATUS_UNF =
| \
> +                                        DMA_STATUS_TJT | DMA_STATUS_TU  =
| \
> +                                        DMA_STATUS_TPS | DMA_STATUS_TI  =
| \
> +                                        DMA_STATUS_MSK_COMMON_LOONGSON)
>
>  #define PCI_DEVICE_ID_LOONGSON_GMAC    0x7a03
> +#define PCI_DEVICE_ID_LOONGSON_GNET    0x7a13
> +#define LOONGSON_DWMAC_CORE_1_00       0x10    /* Loongson custom IP */
> +#define CHANNEL_NUM                    8
> +
> +struct loongson_data {
> +       struct device *dev;
> +};
>
>  struct stmmac_pci_info {
>         int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *p=
lat);
> @@ -56,6 +117,8 @@ static int loongson_gmac_data(struct pci_dev *pdev,
>         plat->dma_cfg->pblx8 =3D true;
>
>         plat->multicast_filter_bins =3D 256;
> +       plat->mdio_bus_data->phy_mask =3D 0;
> +
>         plat->clk_ref_rate =3D 125000000;
>         plat->clk_ptp_rate =3D 125000000;
>
> @@ -69,13 +132,342 @@ static struct stmmac_pci_info loongson_gmac_pci_inf=
o =3D {
>         .setup =3D loongson_gmac_data,
>  };
>
> -static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_d=
evice_id *id)
> +static void loongson_gnet_dma_init_channel(struct stmmac_priv *priv,
> +                                          void __iomem *ioaddr,
> +                                          struct stmmac_dma_cfg *dma_cfg=
,
> +                                          u32 chan)
> +{
> +       int txpbl =3D dma_cfg->txpbl ?: dma_cfg->pbl;
> +       int rxpbl =3D dma_cfg->rxpbl ?: dma_cfg->pbl;
> +       u32 value;
> +
> +       /* common channel control register config */
> +       value =3D readl(ioaddr + DMA_CHAN_BUS_MODE(chan));
> +
> +       /* Set the DMA PBL (Programmable Burst Length) mode.
> +        *
> +        * Note: before stmmac core 3.50 this mode bit was 4xPBL, and
> +        * post 3.5 mode bit acts as 8*PBL.
> +        */
> +       if (dma_cfg->pblx8)
> +               value |=3D DMA_BUS_MODE_MAXPBL;
> +
> +       value |=3D DMA_BUS_MODE_USP;
> +       value &=3D ~(DMA_BUS_MODE_PBL_MASK | DMA_BUS_MODE_RPBL_MASK);
> +       value |=3D (txpbl << DMA_BUS_MODE_PBL_SHIFT);
> +       value |=3D (rxpbl << DMA_BUS_MODE_RPBL_SHIFT);
> +
> +       /* Set the Fixed burst mode */
> +       if (dma_cfg->fixed_burst)
> +               value |=3D DMA_BUS_MODE_FB;
> +
> +       /* Mixed Burst has no effect when fb is set */
> +       if (dma_cfg->mixed_burst)
> +               value |=3D DMA_BUS_MODE_MB;
> +
> +       if (dma_cfg->atds)
> +               value |=3D DMA_BUS_MODE_ATDS;
> +
> +       if (dma_cfg->aal)
> +               value |=3D DMA_BUS_MODE_AAL;
> +
> +       writel(value, ioaddr + DMA_CHAN_BUS_MODE(chan));
> +
> +       /* Mask interrupts by writing to CSR7 */
> +       writel(DMA_INTR_DEFAULT_MASK_LOONGSON, ioaddr +
> +              DMA_CHAN_INTR_ENA(chan));
> +}
> +
> +static int loongson_gnet_dma_interrupt(struct stmmac_priv *priv,
> +                                      void __iomem *ioaddr,
> +                                      struct stmmac_extra_stats *x,
> +                                      u32 chan, u32 dir)
> +{
> +       struct stmmac_pcpu_stats *stats =3D this_cpu_ptr(priv->xstats.pcp=
u_stats);
> +       u32 abnor_intr_status;
> +       u32 nor_intr_status;
> +       u32 fb_intr_status;
> +       u32 intr_status;
> +       int ret =3D 0;
> +
> +       /* read the status register (CSR5) */
> +       intr_status =3D readl(ioaddr + DMA_CHAN_STATUS(chan));
> +
> +       if (dir =3D=3D DMA_DIR_RX)
> +               intr_status &=3D DMA_STATUS_MSK_RX_LOONGSON;
> +       else if (dir =3D=3D DMA_DIR_TX)
> +               intr_status &=3D DMA_STATUS_MSK_TX_LOONGSON;
> +
> +       nor_intr_status =3D intr_status & (DMA_STATUS_NIS_TX_LOONGSON |
> +               DMA_STATUS_NIS_RX_LOONGSON);
> +       abnor_intr_status =3D intr_status & (DMA_STATUS_AIS_TX_LOONGSON |
> +               DMA_STATUS_AIS_RX_LOONGSON);
> +       fb_intr_status =3D intr_status & (DMA_STATUS_FBI_TX_LOONGSON |
> +               DMA_STATUS_FBI_RX_LOONGSON);
> +
> +       /* ABNORMAL interrupts */
> +       if (unlikely(abnor_intr_status)) {
> +               if (unlikely(intr_status & DMA_STATUS_UNF)) {
> +                       ret =3D tx_hard_error_bump_tc;
> +                       x->tx_undeflow_irq++;
> +               }
> +               if (unlikely(intr_status & DMA_STATUS_TJT))
> +                       x->tx_jabber_irq++;
> +               if (unlikely(intr_status & DMA_STATUS_OVF))
> +                       x->rx_overflow_irq++;
> +               if (unlikely(intr_status & DMA_STATUS_RU))
> +                       x->rx_buf_unav_irq++;
> +               if (unlikely(intr_status & DMA_STATUS_RPS))
> +                       x->rx_process_stopped_irq++;
> +               if (unlikely(intr_status & DMA_STATUS_RWT))
> +                       x->rx_watchdog_irq++;
> +               if (unlikely(intr_status & DMA_STATUS_ETI))
> +                       x->tx_early_irq++;
> +               if (unlikely(intr_status & DMA_STATUS_TPS)) {
> +                       x->tx_process_stopped_irq++;
> +                       ret =3D tx_hard_error;
> +               }
> +               if (unlikely(fb_intr_status)) {
> +                       x->fatal_bus_error_irq++;
> +                       ret =3D tx_hard_error;
> +               }
> +       }
> +       /* TX/RX NORMAL interrupts */
> +       if (likely(nor_intr_status)) {
> +               if (likely(intr_status & DMA_STATUS_RI)) {
> +                       u32 value =3D readl(ioaddr + DMA_INTR_ENA);
> +                       /* to schedule NAPI on real RIE event. */
> +                       if (likely(value & DMA_INTR_ENA_RIE)) {
> +                               u64_stats_update_begin(&stats->syncp);
> +                               u64_stats_inc(&stats->rx_normal_irq_n[cha=
n]);
> +                               u64_stats_update_end(&stats->syncp);
> +                               ret |=3D handle_rx;
> +                       }
> +               }
> +               if (likely(intr_status & DMA_STATUS_TI)) {
> +                       u64_stats_update_begin(&stats->syncp);
> +                       u64_stats_inc(&stats->tx_normal_irq_n[chan]);
> +                       u64_stats_update_end(&stats->syncp);
> +                       ret |=3D handle_tx;
> +               }
> +               if (unlikely(intr_status & DMA_STATUS_ERI))
> +                       x->rx_early_irq++;
> +       }
> +       /* Optional hardware blocks, interrupts should be disabled */
> +       if (unlikely(intr_status &
> +                    (DMA_STATUS_GPI | DMA_STATUS_GMI | DMA_STATUS_GLI)))
> +               pr_warn("%s: unexpected status %08x\n", __func__, intr_st=
atus);
> +
> +       /* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
> +       writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
> +
> +       return ret;
> +}
> +
> +static void loongson_gnet_fix_speed(void *priv, unsigned int speed,
> +                                   unsigned int mode)
> +{
> +       struct loongson_data *ld =3D (struct loongson_data *)priv;
> +       struct net_device *ndev =3D dev_get_drvdata(ld->dev);
> +       struct stmmac_priv *ptr =3D netdev_priv(ndev);
> +
> +       /* The controller and PHY don't work well together.
> +        * We need to use the PS bit to check if the controller's status
> +        * is correct and reset PHY if necessary.
> +        * MAC_CTRL_REG.15 is defined by the GMAC_CONTROL_PS macro.
> +        */
> +       if (speed =3D=3D SPEED_1000) {
> +               if (readl(ptr->ioaddr + MAC_CTRL_REG) &
> +                   MAC_CTRL_PORT_SELECT_10_100)
> +                       /* Word around hardware bug, restart autoneg */
> +                       phy_restart_aneg(ndev->phydev);
> +       }
> +}
> +
> +static int loongson_gnet_data(struct pci_dev *pdev,
> +                             struct plat_stmmacenet_data *plat)
> +{
> +       loongson_default_data(pdev, plat);
> +
> +       plat->phy_addr =3D -1;
> +       plat->phy_interface =3D PHY_INTERFACE_MODE_GMII;
> +
> +       plat->dma_cfg->pbl =3D 32;
> +       plat->dma_cfg->pblx8 =3D true;
> +
> +       plat->multicast_filter_bins =3D 256;
> +       plat->mdio_bus_data->phy_mask =3D ~(u32)BIT(2);
> +
> +       plat->clk_ref_rate =3D 125000000;
> +       plat->clk_ptp_rate =3D 125000000;
> +
> +       plat->fix_mac_speed =3D loongson_gnet_fix_speed;
> +
> +       return 0;
> +}
> +
> +static struct stmmac_pci_info loongson_gnet_pci_info =3D {
> +       .setup =3D loongson_gnet_data,
> +};
> +
> +static int loongson_dwmac_config_legacy(struct pci_dev *pdev,
> +                                       struct plat_stmmacenet_data *plat=
,
> +                                       struct stmmac_resources *res,
> +                                       struct device_node *np)
> +{
> +       if (np) {
> +               res->irq =3D of_irq_get_byname(np, "macirq");
> +               if (res->irq < 0) {
> +                       dev_err(&pdev->dev, "IRQ macirq not found\n");
> +                       return -ENODEV;
> +               }
> +
> +               res->wol_irq =3D of_irq_get_byname(np, "eth_wake_irq");
> +               if (res->wol_irq < 0) {
> +                       dev_info(&pdev->dev,
> +                                "IRQ eth_wake_irq not found, using macir=
q\n");
> +                       res->wol_irq =3D res->irq;
> +               }
> +
> +               res->lpi_irq =3D of_irq_get_byname(np, "eth_lpi");
> +               if (res->lpi_irq < 0) {
> +                       dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> +                       return -ENODEV;
> +               }
> +       } else {
> +               res->irq =3D pdev->irq;
> +               res->wol_irq =3D res->irq;
> +       }
> +
> +       return 0;
> +}
> +
> +static int loongson_dwmac_config_msi(struct pci_dev *pdev,
> +                                    struct plat_stmmacenet_data *plat,
> +                                    struct stmmac_resources *res,
> +                                    struct device_node *np)
> +{
> +       int i, ret, vecs;
> +
> +       vecs =3D roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
> +       ret =3D pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
> +       if (ret < 0) {
> +               dev_info(&pdev->dev,
> +                        "MSI enable failed, Fallback to legacy interrupt=
\n");
> +               return loongson_dwmac_config_legacy(pdev, plat, res, np);
> +       }
> +
> +       res->irq =3D pci_irq_vector(pdev, 0);
> +       res->wol_irq =3D 0;
> +
> +       /* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> +        * --------- ----- -------- --------  ...  -------- --------
> +        * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> +        */
> +       for (i =3D 0; i < CHANNEL_NUM; i++) {
> +               res->rx_irq[CHANNEL_NUM - 1 - i] =3D
> +                       pci_irq_vector(pdev, 1 + i * 2);
> +               res->tx_irq[CHANNEL_NUM - 1 - i] =3D
> +                       pci_irq_vector(pdev, 2 + i * 2);
> +       }
> +
> +       plat->flags |=3D STMMAC_FLAG_MULTI_MSI_EN;
> +
> +       return 0;
> +}
> +
> +static struct mac_device_info *loongson_dwmac_setup(void *apriv)
> +{
> +       struct stmmac_priv *priv =3D apriv;
> +       struct stmmac_resources res;
> +       struct mac_device_info *mac;
> +       struct stmmac_dma_ops *dma;
> +       struct pci_dev *pdev;
> +       u32 loongson_gmac;
> +
> +       memset(&res, 0, sizeof(res));
> +       pdev =3D to_pci_dev(priv->device);
> +       res.addr =3D pcim_iomap_table(pdev)[0];
> +       loongson_gmac =3D readl(res.addr + GMAC_VERSION) & 0xff;
We can add a "gmac_version" in loongson_data, then we only need to
read it once in the probe function.

Huacai

> +
> +       mac =3D devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
> +       if (!mac)
> +               return NULL;
> +
> +       dma =3D devm_kzalloc(priv->device, sizeof(*dma), GFP_KERNEL);
> +       if (!dma)
> +               return NULL;
> +
> +       /* The original IP-core version is 0x37 in all Loongson GNET
> +        * (ls2k2000 and ls7a2000), but the GNET HW designers have change=
d the
> +        * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the Loo=
ngson
> +        * ls2k2000 MAC to emphasize the differences: multiple DMA-channe=
ls,
> +        * AV feature and GMAC_INT_STATUS CSR flags layout. Get back the
> +        * original value so the correct HW-interface would be selected.
> +        */
> +       if (loongson_gmac =3D=3D LOONGSON_DWMAC_CORE_1_00) {
> +               priv->synopsys_id =3D DWMAC_CORE_3_70;
> +               *dma =3D dwmac1000_dma_ops;
> +               dma->init_chan =3D loongson_gnet_dma_init_channel;
> +               dma->dma_interrupt =3D loongson_gnet_dma_interrupt;
> +               mac->dma =3D dma;
> +       }
> +
> +       mac->mac =3D &dwmac1000_ops;
> +       priv->dev->priv_flags |=3D IFF_UNICAST_FLT;
> +
> +       /* Pre-initialize the respective "mac" fields as it's done in
> +        * dwmac1000_setup()
> +        */
> +       mac->pcsr =3D priv->ioaddr;
> +       mac->multicast_filter_bins =3D priv->plat->multicast_filter_bins;
> +       mac->unicast_filter_entries =3D priv->plat->unicast_filter_entrie=
s;
> +       mac->mcast_bits_log2 =3D 0;
> +
> +       if (mac->multicast_filter_bins)
> +               mac->mcast_bits_log2 =3D ilog2(mac->multicast_filter_bins=
);
> +
> +       /* The GMAC devices with PCI ID 0x7a03 does not support any pause=
 mode.
> +        * The GNET devices without CORE ID 0x10 does not support half-du=
plex.
> +        */
> +       if (pdev->device =3D=3D PCI_DEVICE_ID_LOONGSON_GMAC) {
> +               mac->link.caps =3D MAC_10 | MAC_100 | MAC_1000;
> +       } else {
> +               if (loongson_gmac =3D=3D LOONGSON_DWMAC_CORE_1_00)
> +                       mac->link.caps =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE=
 |
> +                                        MAC_10 | MAC_100 | MAC_1000;
> +               else
> +                       mac->link.caps =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE=
 |
> +                                        MAC_10FD | MAC_100FD | MAC_1000F=
D;
> +       }
> +
> +       mac->link.duplex =3D GMAC_CONTROL_DM;
> +       mac->link.speed10 =3D GMAC_CONTROL_PS;
> +       mac->link.speed100 =3D GMAC_CONTROL_PS | GMAC_CONTROL_FES;
> +       mac->link.speed1000 =3D 0;
> +       mac->link.speed_mask =3D GMAC_CONTROL_PS | GMAC_CONTROL_FES;
> +       mac->mii.addr =3D GMAC_MII_ADDR;
> +       mac->mii.data =3D GMAC_MII_DATA;
> +       mac->mii.addr_shift =3D 11;
> +       mac->mii.addr_mask =3D 0x0000F800;
> +       mac->mii.reg_shift =3D 6;
> +       mac->mii.reg_mask =3D 0x000007C0;
> +       mac->mii.clk_csr_shift =3D 2;
> +       mac->mii.clk_csr_mask =3D GENMASK(5, 2);
> +
> +       return mac;
> +}
> +
> +static int loongson_dwmac_probe(struct pci_dev *pdev,
> +                               const struct pci_device_id *id)
>  {
>         struct plat_stmmacenet_data *plat;
>         int ret, i, bus_id, phy_mode;
>         struct stmmac_pci_info *info;
>         struct stmmac_resources res;
> +       struct loongson_data *ld;
>         struct device_node *np;
> +       u32 loongson_gmac;
>
>         plat =3D devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>         if (!plat)
> @@ -88,10 +482,14 @@ static int loongson_dwmac_probe(struct pci_dev *pdev=
, const struct pci_device_id
>                 return -ENOMEM;
>
>         plat->dma_cfg =3D devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg)=
, GFP_KERNEL);
> -       if (!plat->dma_cfg) {
> -               ret =3D -ENOMEM;
> -               goto err_put_node;
> -       }
> +       if (!plat->dma_cfg)
> +               return -ENOMEM;
> +
> +       ld =3D devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> +       if (!ld)
> +               return -ENOMEM;
> +
> +       np =3D dev_of_node(&pdev->dev);
>
>         /* Enable pci device */
>         ret =3D pci_enable_device(pdev);
> @@ -110,14 +508,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev=
, const struct pci_device_id
>                 break;
>         }
>
> -       phy_mode =3D device_get_phy_mode(&pdev->dev);
> -       if (phy_mode < 0) {
> -               dev_err(&pdev->dev, "phy_mode not found\n");
> -               ret =3D phy_mode;
> -               goto err_disable_device;
> -       }
> -
> -       plat->phy_interface =3D phy_mode;
>         plat->mac_interface =3D PHY_INTERFACE_MODE_GMII;
>
>         pci_set_master(pdev);
> @@ -133,7 +523,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,=
 const struct pci_device_id
>                         dev_info(&pdev->dev, "Found MDIO subnode\n");
>                         plat->mdio_bus_data->needs_reset =3D true;
>                 }
> -
>                 bus_id =3D of_alias_get_id(np, "ethernet");
>                 if (bus_id >=3D 0)
>                         plat->bus_id =3D bus_id;
> @@ -145,42 +534,49 @@ static int loongson_dwmac_probe(struct pci_dev *pde=
v, const struct pci_device_id
>                         goto err_disable_device;
>                 }
>                 plat->phy_interface =3D phy_mode;
> +       }
>
> -               res.irq =3D of_irq_get_byname(np, "macirq");
> -               if (res.irq < 0) {
> -                       dev_err(&pdev->dev, "IRQ macirq not found\n");
> -                       ret =3D -ENODEV;
> -                       goto err_disable_msi;
> -               }
> +       plat->bsp_priv =3D ld;
> +       plat->setup =3D loongson_dwmac_setup;
> +       ld->dev =3D &pdev->dev;
>
> -               res.wol_irq =3D of_irq_get_byname(np, "eth_wake_irq");
> -               if (res.wol_irq < 0) {
> -                       dev_info(&pdev->dev, "IRQ eth_wake_irq not found,=
 using macirq\n");
> -                       res.wol_irq =3D res.irq;
> -               }
> +       memset(&res, 0, sizeof(res));
> +       res.addr =3D pcim_iomap_table(pdev)[0];
> +       loongson_gmac =3D readl(res.addr + GMAC_VERSION) & 0xff;
>
> -               res.lpi_irq =3D of_irq_get_byname(np, "eth_lpi");
> -               if (res.lpi_irq < 0) {
> -                       dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> -                       ret =3D -ENODEV;
> -                       goto err_disable_msi;
> -               }
> -       } else {
> -               res.irq =3D pdev->irq;
> +       switch (loongson_gmac) {
> +       case LOONGSON_DWMAC_CORE_1_00:
> +               plat->rx_queues_to_use =3D CHANNEL_NUM;
> +               plat->tx_queues_to_use =3D CHANNEL_NUM;
> +
> +               /* Only channel 0 supports checksum,
> +                * so turn off checksum to enable multiple channels.
> +                */
> +               for (i =3D 1; i < CHANNEL_NUM; i++)
> +                       plat->tx_queues_cfg[i].coe_unsupported =3D 1;
> +
> +               ret =3D loongson_dwmac_config_msi(pdev, plat, &res, np);
> +               break;
> +       default:        /* 0x35 device and 0x37 device. */
> +               plat->tx_queues_to_use =3D 1;
> +               plat->rx_queues_to_use =3D 1;
> +               ret =3D loongson_dwmac_config_legacy(pdev, plat, &res, np=
);
> +               break;
>         }
>
> -       pci_enable_msi(pdev);
> -       memset(&res, 0, sizeof(res));
> -       res.addr =3D pcim_iomap_table(pdev)[0];
> +       /* GNET devices with dev revision 0x00 do not support manually
> +        * setting the speed to 1000.
> +        */
> +       if (pdev->device =3D=3D PCI_DEVICE_ID_LOONGSON_GNET &&
> +           pdev->revision =3D=3D 0x00)
> +               plat->flags |=3D STMMAC_FLAG_DISABLE_FORCE_1000;
>
>         ret =3D stmmac_dvr_probe(&pdev->dev, plat, &res);
>         if (ret)
> -               goto err_disable_msi;
> +               goto err_disable_device;
>
>         return ret;
>
> -err_disable_msi:
> -       pci_disable_msi(pdev);
>  err_disable_device:
>         pci_disable_device(pdev);
>  err_put_node:
> @@ -248,6 +644,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loong=
son_dwmac_suspend,
>
>  static const struct pci_device_id loongson_dwmac_id_table[] =3D {
>         { PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
> +       { PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
>         {}
>  };
>  MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
> @@ -266,4 +663,5 @@ module_pci_driver(loongson_dwmac_driver);
>
>  MODULE_DESCRIPTION("Loongson DWMAC PCI driver");
>  MODULE_AUTHOR("Qing Zhang <zhangqing@loongson.cn>");
> +MODULE_AUTHOR("Yanteng Si <siyanteng@loongson.cn>");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/driver=
s/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> index f161ec9ac490..66c0c22908b1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> @@ -296,3 +296,4 @@ const struct stmmac_dma_ops dwmac1000_dma_ops =3D {
>         .get_hw_feature =3D dwmac1000_get_hw_feature,
>         .rx_watchdog =3D dwmac1000_rx_watchdog,
>  };
> +EXPORT_SYMBOL_GPL(dwmac1000_dma_ops);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drive=
rs/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index e1537a57815f..e94faa72f30e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -420,6 +420,12 @@ stmmac_ethtool_set_link_ksettings(struct net_device =
*dev,
>                 return 0;
>         }
>
> +       if (priv->plat->flags & STMMAC_FLAG_DISABLE_FORCE_1000) {
> +               if (cmd->base.speed =3D=3D SPEED_1000 &&
> +                   cmd->base.autoneg !=3D AUTONEG_ENABLE)
> +                       return -EOPNOTSUPP;
> +       }
> +
>         return phylink_ethtool_ksettings_set(priv->phylink, cmd);
>  }
>
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 1b54b84a6785..c5d3d0ddb6f8 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -223,6 +223,7 @@ struct dwmac4_addrs {
>  #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI         BIT(10)
>  #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING      BIT(11)
>  #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY   BIT(12)
> +#define STMMAC_FLAG_DISABLE_FORCE_1000         BIT(13)
>
>  struct plat_stmmacenet_data {
>         int bus_id;
> --
> 2.31.4
>

