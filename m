Return-Path: <netdev+bounces-116530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5E294AACF
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B4B1C2174B
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF1380BF8;
	Wed,  7 Aug 2024 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xqw0g/R8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D2680611
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042594; cv=none; b=c2eXY54ZUPmLJnrUfGUEXb4sfI7GpQdVay+AOnWqFWkRSsQAGXtP/2UCtREWUF/yf/h6i9kTprNBlco6JXXEyRxy71rYWIqWNoPStx5xTNfUh+vZ8ZiImLFpq8IzOIn7E3psJqXl8gjAuFZso63WdkfHCY4YnMB6dCQwdCATIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042594; c=relaxed/simple;
	bh=Uh/MWqMzzl0h+aGDlEE/YtBLmpQMVnfV0SWb2wSwk2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DW+A8CjmvS8lVKOyJST/MnSZIDra3vUHbOgE3qx2S5Q1HLLfKOQ3uG51nfAeaH6C1ACeRPmpJ/kh1eZ+kTJ4UHNLRHbYKRWR8RIjBMOTLksyeBPDaWfU4xFcR1xuQ32iuGpliUOXtR78FHaeWGqH8nWVXNUFZwVQwFVcOGeoJTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xqw0g/R8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723042590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D7XS14Rp99DiHzzmnfJ9ZxvQ7vPKgGWF1We83XDN5hI=;
	b=Xqw0g/R8t/KvwmWz1qMlgrsOUCNTG4680NW53n0nzMQYqGyeLQOZnUtacLgySiXLKCq7Ra
	AxtAZZDECdzhm5rJ2gNCGV/hUWgnQJjCHRheyxhny5L/jcQzbld7zJbEDGxqCxvoLBlyvN
	PHTyreceGhKuhIKUuMVKJ5L9X2GcPu4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-RyX98Qx5M-uYocxmkyeSWw-1; Wed, 07 Aug 2024 10:56:28 -0400
X-MC-Unique: RyX98Qx5M-uYocxmkyeSWw-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-66628e9ec89so40614217b3.1
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 07:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723042585; x=1723647385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7XS14Rp99DiHzzmnfJ9ZxvQ7vPKgGWF1We83XDN5hI=;
        b=kb3lGIlRF7iZ84AyHr6ARTlkLhUlaYZGjdjiuYnjsg2NlOmhG2K9Lmayticnp43y1K
         fHMDtlEK6PEm3Kyx+/vpwgGFEqsorP+2IHH9/DdnDCg+PJGVjpT+3pBSnpPcPDuy3gzq
         Sr2MF5HeCnJAVw2yULyU6uv1cjaUJz7N8bfWvylyagJt8vMg2eEK7rIqEK0lWsQl2zLB
         Kv4YUKNLI3iHteOmXTpXlo07ZY8FJlZCFn+M4XnTC6UIQM2vKLSGUCB339OTnDYtFijk
         YQDsw15VtxAi67zJTmrhTks9xbI+t4vWizf4Cqom+1TbJw/ovNzgo24bIt7TDk5G5KUe
         NwYw==
X-Forwarded-Encrypted: i=1; AJvYcCUP+Ox6NnKeb9d+doZHY0MptKSX0Bmci9f5hTSI7ZQlmZ1Yub9CsTaYhEBGAKMPBa5sMjauXcv46QiLGDX3cfcsb+ySPs9j
X-Gm-Message-State: AOJu0YwpXKntYEUDqCur1BF21j00cJlCDgvbJROmQ/Wmxw8ATLWon/MQ
	O6FX1eknBNWJqRD7Z1qwwI/0l9HNfRIVtW3C5xcyvq1C+KtS6YNxTmFj2+YdB8L3qj6in5LcYje
	yMO8pzeUYGP5iwYGwS6gBv1Fy49nQuzW6OwQKfwVm7USJPnRw0LuXLQ8P9pdkc6TfagGV9AZe5z
	Eg67YYvGV6YrWalibtw9uwVsPE2I77
X-Received: by 2002:a81:c20e:0:b0:63c:aa2:829d with SMTP id 00721157ae682-689637fccd4mr216733197b3.44.1723042585017;
        Wed, 07 Aug 2024 07:56:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPRthvBmmpGFq+gGcFUD1IFvGcQuXwaKL9Ygnzu35GTMGehx3rIcR+0CewGcdfLropPfl1bqV3v5ZDUA8Z53Q=
X-Received: by 2002:a81:c20e:0:b0:63c:aa2:829d with SMTP id
 00721157ae682-689637fccd4mr216732867b3.44.1723042584580; Wed, 07 Aug 2024
 07:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802095931.24376-1-louis.peens@corigine.com> <20240802095931.24376-4-louis.peens@corigine.com>
In-Reply-To: <20240802095931.24376-4-louis.peens@corigine.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 7 Aug 2024 16:55:48 +0200
Message-ID: <CAJaqyWfHP0UYoaVVJDVv1ouy22eMb9EQrV4dTRV6urOXNdRMJw@mail.gmail.com>
Subject: Re: [RFC net-next 3/3] drivers/vdpa: add NFP devices vDPA driver
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Kyle Xu <zhenbing.xu@corigine.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	oss-drivers@corigine.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 12:00=E2=80=AFPM Louis Peens <louis.peens@corigine.c=
om> wrote:
>
> From: Kyle Xu <zhenbing.xu@corigine.com>
>
> Add a new kernel module =E2=80=98nfp_vdpa=E2=80=99 for the NFP vDPA netwo=
rking driver.
>
> The vDPA driver initializes the necessary resources on the VF and the
> data path will be offloaded. It also implements the =E2=80=98vdpa_config_=
ops=E2=80=99
> and the corresponding callback interfaces according to the requirement
> of kernel vDPA framework.
>
> Signed-off-by: Kyle Xu <zhenbing.xu@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>
> ---
>  MAINTAINERS                            |   1 +
>  drivers/vdpa/Kconfig                   |  10 +
>  drivers/vdpa/Makefile                  |   1 +
>  drivers/vdpa/netronome/Makefile        |   5 +
>  drivers/vdpa/netronome/nfp_vdpa_main.c | 821 +++++++++++++++++++++++++
>  5 files changed, 838 insertions(+)
>  create mode 100644 drivers/vdpa/netronome/Makefile
>  create mode 100644 drivers/vdpa/netronome/nfp_vdpa_main.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c0a3d9e93689..3231b80af331 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15836,6 +15836,7 @@ R:      Jakub Kicinski <kuba@kernel.org>
>  L:     oss-drivers@corigine.com
>  S:     Maintained
>  F:     drivers/net/ethernet/netronome/
> +F:     drivers/vdpa/netronome/
>
>  NETWORK BLOCK DEVICE (NBD)
>  M:     Josef Bacik <josef@toxicpanda.com>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 5265d09fc1c4..da5a8461359e 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -137,4 +137,14 @@ config OCTEONEP_VDPA
>           Please note that this driver must be built as a module and it
>           cannot be loaded until the Octeon emulation software is running=
.
>
> +config NFP_VDPA
> +       tristate "vDPA driver for NFP devices"
> +       depends on NFP
> +       help
> +         VDPA network driver for NFP4000 NFP5000 NFP6000 and newer. Prov=
ides
> +         offloading of virtio_net datapath such that descriptors put on =
the
> +         ring will be executed by the hardware. It also supports a varie=
ty
> +         of stateless offloads depending on the actual device used and
> +         firmware version.
> +
>  endif # VDPA
> diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
> index 5654d36707af..a8e335756829 100644
> --- a/drivers/vdpa/Makefile
> +++ b/drivers/vdpa/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_ALIBABA_ENI_VDPA) +=3D alibaba/
>  obj-$(CONFIG_SNET_VDPA) +=3D solidrun/
>  obj-$(CONFIG_PDS_VDPA) +=3D pds/
>  obj-$(CONFIG_OCTEONEP_VDPA) +=3D octeon_ep/
> +obj-$(CONFIG_NFP_VDPA) +=3D netronome/
> diff --git a/drivers/vdpa/netronome/Makefile b/drivers/vdpa/netronome/Mak=
efile
> new file mode 100644
> index 000000000000..ccba4ead3e4f
> --- /dev/null
> +++ b/drivers/vdpa/netronome/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +ccflags-y +=3D -I$(srctree)/drivers/net/ethernet/netronome/nfp
> +ccflags-y +=3D -I$(srctree)/drivers/net/ethernet/netronome/nfp/nfpcore
> +obj-$(CONFIG_NFP_VDPA) +=3D nfp_vdpa.o
> +nfp_vdpa-$(CONFIG_NFP_VDPA) +=3D nfp_vdpa_main.o
> diff --git a/drivers/vdpa/netronome/nfp_vdpa_main.c b/drivers/vdpa/netron=
ome/nfp_vdpa_main.c
> new file mode 100644
> index 000000000000..a60905848094
> --- /dev/null
> +++ b/drivers/vdpa/netronome/nfp_vdpa_main.c
> @@ -0,0 +1,821 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/* Copyright (C) 2023 Corigine, Inc. */
> +/*
> + * nfp_vdpa_main.c
> + * Main entry point for vDPA device driver.
> + * Author: Xinying Yu <xinying.yu@corigine.com>
> + *         Zhenbing Xu <zhenbing.xu@corigine.com>
> + */
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/vdpa.h>
> +
> +#include <uapi/linux/virtio_config.h>
> +#include <uapi/linux/virtio_ids.h>
> +#include <uapi/linux/virtio_net.h>
> +#include <uapi/linux/virtio_ring.h>
> +
> +#include "nfp_net.h"
> +#include "nfp_dev.h"
> +
> +/* Only one queue pair for now. */
> +#define NFP_VDPA_NUM_QUEUES 2
> +
> +/* RX queue index in queue pair */
> +#define NFP_VDPA_RX_QUEUE 0
> +
> +/* TX queue index in queue pair */
> +#define NFP_VDPA_TX_QUEUE 1
> +
> +/* Max MTU supported */
> +#define NFP_VDPA_MTU_MAX 9216
> +
> +/* Default freelist buffer size */
> +#define NFP_VDPA_FL_BUF_SZ 10240
> +
> +/* Max queue supported */

Just some nitpicks,

Max queue *size* supported.

> +#define NFP_VDPA_QUEUE_MAX 256
> +
> +/* Queue space stride */
> +#define NFP_VDPA_QUEUE_SPACE_STRIDE 4
> +
> +/* Notification area base on VF CFG BAR */
> +#define NFP_VDPA_NOTIFY_AREA_BASE 0x4000
> +
> +/* Notification area offset of each queue */
> +#define NFP_VDPA_QUEUE_NOTIFY_OFFSET 0x1000
> +
> +/* Maximum number of rings supported */

I guess it should be *queue pairs*, as we have one ring for tx and
another for rx.

> +#define NFP_VDPA_QUEUE_RING_MAX 1
> +
> +/* VF auxiliary device name */
> +#define NFP_NET_VF_ADEV_NAME "nfp"
> +
> +#define NFP_NET_SUPPORTED_FEATURES \
> +               ((1ULL << VIRTIO_F_ANY_LAYOUT)                  | \
> +                (1ULL << VIRTIO_F_VERSION_1)                   | \
> +                (1ULL << VIRTIO_F_ACCESS_PLATFORM)             | \
> +                (1ULL << VIRTIO_NET_F_MTU)                     | \
> +                (1ULL << VIRTIO_NET_F_MAC)                     | \
> +                (1ULL << VIRTIO_NET_F_STATUS))
> +
> +struct nfp_vdpa_virtqueue {
> +       u64 desc;
> +       u64 avail;
> +       u64 used;
> +       u16 size;
> +       u16 last_avail_idx;
> +       u16 last_used_idx;
> +       bool ready;
> +
> +       void __iomem *kick_addr;
> +       struct vdpa_callback cb;
> +};
> +
> +struct nfp_vdpa_net {
> +       struct vdpa_device vdpa;
> +
> +       void __iomem *ctrl_bar;
> +       void __iomem *q_bar;
> +       void __iomem *qcp_cfg;
> +
> +       struct nfp_vdpa_virtqueue vring[NFP_VDPA_NUM_QUEUES];
> +
> +       u32 ctrl;
> +       u32 ctrl_w1;
> +
> +       u32 reconfig_in_progress_update;
> +       struct semaphore bar_lock;
> +
> +       u8 status;
> +       u64 features;
> +       struct virtio_net_config config;
> +
> +       struct msix_entry vdpa_rx_irq;
> +       struct nfp_net_r_vector vdpa_rx_vec;
> +
> +       struct msix_entry vdpa_tx_irq;
> +       struct nfp_net_r_vector vdpa_tx_vec;
> +};
> +
> +struct nfp_vdpa_mgmt_dev {
> +       struct vdpa_mgmt_dev mdev;
> +       struct nfp_vdpa_net *ndev;
> +       struct pci_dev *pdev;
> +       const struct nfp_dev_info *dev_info;
> +};
> +
> +static uint16_t vdpa_cfg_readw(struct nfp_vdpa_net *ndev, int off)
> +{
> +       return readw(ndev->ctrl_bar + off);
> +}
> +
> +static u32 vdpa_cfg_readl(struct nfp_vdpa_net *ndev, int off)
> +{
> +       return readl(ndev->ctrl_bar + off);
> +}
> +
> +static void vdpa_cfg_writeb(struct nfp_vdpa_net *ndev, int off, uint8_t =
val)
> +{
> +       writeb(val, ndev->ctrl_bar + off);
> +}
> +
> +static void vdpa_cfg_writel(struct nfp_vdpa_net *ndev, int off, u32 val)
> +{
> +       writel(val, ndev->ctrl_bar + off);
> +}
> +
> +static void vdpa_cfg_writeq(struct nfp_vdpa_net *ndev, int off, u64 val)
> +{
> +       writeq(val, ndev->ctrl_bar + off);
> +}
> +
> +static bool nfp_vdpa_is_little_endian(struct nfp_vdpa_net *ndev)
> +{
> +       return virtio_legacy_is_little_endian() ||
> +               (ndev->features & BIT_ULL(VIRTIO_F_VERSION_1));
> +}
> +
> +static __virtio16 cpu_to_nfpvdpa16(struct nfp_vdpa_net *ndev, u16 val)
> +{
> +       return __cpu_to_virtio16(nfp_vdpa_is_little_endian(ndev), val);
> +}
> +
> +static void nfp_vdpa_net_reconfig_start(struct nfp_vdpa_net *ndev, u32 u=
pdate)
> +{
> +       vdpa_cfg_writel(ndev, NFP_NET_CFG_UPDATE, update);
> +       /* Flush posted PCI writes by reading something without side effe=
cts */
> +       vdpa_cfg_readl(ndev, NFP_NET_CFG_VERSION);
> +       /* Write a none-zero value to the QCP pointer for configuration n=
otification */
> +       writel(1, ndev->qcp_cfg + NFP_QCP_QUEUE_ADD_WPTR);
> +       ndev->reconfig_in_progress_update |=3D update;
> +}
> +
> +static bool nfp_vdpa_net_reconfig_check_done(struct nfp_vdpa_net *ndev, =
bool last_check)
> +{
> +       u32 reg;
> +
> +       reg =3D vdpa_cfg_readl(ndev, NFP_NET_CFG_UPDATE);
> +       if (reg =3D=3D 0)
> +               return true;
> +       if (reg & NFP_NET_CFG_UPDATE_ERR) {
> +               dev_err(ndev->vdpa.dma_dev, "Reconfig error (status: 0x%0=
8x update: 0x%08x ctrl: 0x%08x)\n",
> +                       reg, ndev->reconfig_in_progress_update,
> +                       vdpa_cfg_readl(ndev, NFP_NET_CFG_CTRL));
> +               return true;
> +       } else if (last_check) {
> +               dev_err(ndev->vdpa.dma_dev, "Reconfig timeout (status: 0x=
%08x update: 0x%08x ctrl: 0x%08x)\n",
> +                       reg, ndev->reconfig_in_progress_update,
> +                       vdpa_cfg_readl(ndev, NFP_NET_CFG_CTRL));
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +static bool __nfp_vdpa_net_reconfig_wait(struct nfp_vdpa_net *ndev, unsi=
gned long deadline)
> +{
> +       bool timed_out =3D false;
> +       int i;
> +
> +       /* Poll update field, waiting for NFP to ack the config.
> +        * Do an opportunistic wait-busy loop, afterward sleep.
> +        */
> +       for (i =3D 0; i < 50; i++) {
> +               if (nfp_vdpa_net_reconfig_check_done(ndev, false))
> +                       return false;
> +               udelay(4);
> +       }
> +
> +       while (!nfp_vdpa_net_reconfig_check_done(ndev, timed_out)) {
> +               usleep_range(250, 500);
> +               timed_out =3D time_is_before_eq_jiffies(deadline);
> +       }
> +
> +       return timed_out;
> +}
> +
> +static int nfp_vdpa_net_reconfig_wait(struct nfp_vdpa_net *ndev, unsigne=
d long deadline)
> +{
> +       if (__nfp_vdpa_net_reconfig_wait(ndev, deadline))
> +               return -EIO;
> +
> +       if (vdpa_cfg_readl(ndev, NFP_NET_CFG_UPDATE) & NFP_NET_CFG_UPDATE=
_ERR)
> +               return -EIO;
> +
> +       return 0;
> +}
> +
> +static int nfp_vdpa_net_reconfig(struct nfp_vdpa_net *ndev, u32 update)
> +{
> +       int ret;
> +
> +       down(&ndev->bar_lock);
> +
> +       nfp_vdpa_net_reconfig_start(ndev, update);
> +       ret =3D nfp_vdpa_net_reconfig_wait(ndev, jiffies + HZ * NFP_NET_P=
OLL_TIMEOUT);
> +       ndev->reconfig_in_progress_update =3D 0;
> +
> +       up(&ndev->bar_lock);
> +       return ret;
> +}
> +
> +static irqreturn_t nfp_vdpa_irq_rx(int irq, void *data)
> +{
> +       struct nfp_net_r_vector *r_vec =3D data;
> +       struct nfp_vdpa_net      *ndev;
> +
> +       ndev =3D container_of(r_vec, struct nfp_vdpa_net, vdpa_rx_vec);
> +
> +       ndev->vring[NFP_VDPA_RX_QUEUE].cb.callback(ndev->vring[NFP_VDPA_R=
X_QUEUE].cb.private);
> +
> +       vdpa_cfg_writeq(ndev, NFP_NET_CFG_ICR(ndev->vdpa_rx_irq.entry), N=
FP_NET_CFG_ICR_UNMASKED);
> +
> +       /* The FW auto-masks any interrupt, either via the MASK bit in
> +        * the MSI-X table or via the per entry ICR field. So there
> +        * is no need to disable interrupts here.
> +        */
> +       return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t nfp_vdpa_irq_tx(int irq, void *data)
> +{
> +       struct nfp_net_r_vector *r_vec =3D data;
> +       struct nfp_vdpa_net      *ndev;
> +
> +       ndev =3D container_of(r_vec, struct nfp_vdpa_net, vdpa_tx_vec);
> +
> +       /* This memory barrier is needed to make sure the used ring and i=
ndex
> +        * has been written back before we notify the frontend driver.
> +        */
> +       dma_rmb();
> +
> +       ndev->vring[NFP_VDPA_TX_QUEUE].cb.callback(ndev->vring[NFP_VDPA_T=
X_QUEUE].cb.private);
> +
> +       vdpa_cfg_writeq(ndev, NFP_NET_CFG_ICR(ndev->vdpa_tx_irq.entry), N=
FP_NET_CFG_ICR_UNMASKED);
> +
> +       /* The FW auto-masks any interrupt, either via the MASK bit in
> +        * the MSI-X table or via the per entry ICR field. So there
> +        * is no need to disable interrupts here.
> +        */
> +       return IRQ_HANDLED;
> +}
> +
> +static struct nfp_vdpa_net *vdpa_to_ndev(struct vdpa_device *vdpa_dev)
> +{
> +       return container_of(vdpa_dev, struct nfp_vdpa_net, vdpa);
> +}
> +
> +static void nfp_vdpa_ring_addr_cfg(struct nfp_vdpa_net *ndev)
> +{
> +       vdpa_cfg_writeq(ndev, NFP_NET_CFG_TXR_ADDR(0), ndev->vring[NFP_VD=
PA_TX_QUEUE].desc);
> +       vdpa_cfg_writeb(ndev, NFP_NET_CFG_TXR_SZ(0), ilog2(ndev->vring[NF=
P_VDPA_TX_QUEUE].size));
> +       vdpa_cfg_writeq(ndev, NFP_NET_CFG_TXR_ADDR(1), ndev->vring[NFP_VD=
PA_TX_QUEUE].avail);
> +       vdpa_cfg_writeq(ndev, NFP_NET_CFG_TXR_ADDR(2), ndev->vring[NFP_VD=
PA_TX_QUEUE].used);
> +
> +       vdpa_cfg_writeq(ndev, NFP_NET_CFG_RXR_ADDR(0), ndev->vring[NFP_VD=
PA_RX_QUEUE].desc);
> +       vdpa_cfg_writeb(ndev, NFP_NET_CFG_RXR_SZ(0), ilog2(ndev->vring[NF=
P_VDPA_RX_QUEUE].size));
> +       vdpa_cfg_writeq(ndev, NFP_NET_CFG_RXR_ADDR(1), ndev->vring[NFP_VD=
PA_RX_QUEUE].avail);
> +       vdpa_cfg_writeq(ndev, NFP_NET_CFG_RXR_ADDR(2), ndev->vring[NFP_VD=
PA_RX_QUEUE].used);
> +}
> +
> +static int nfp_vdpa_setup_driver(struct vdpa_device *vdpa_dev)
> +{
> +       struct nfp_vdpa_net *ndev =3D vdpa_to_ndev(vdpa_dev);
> +       u32 new_ctrl, new_ctrl_w1, update =3D 0;
> +
> +       nfp_vdpa_ring_addr_cfg(ndev);
> +
> +       vdpa_cfg_writeb(ndev, NFP_NET_CFG_TXR_VEC(1), ndev->vdpa_tx_vec.i=
rq_entry);
> +       vdpa_cfg_writeb(ndev, NFP_NET_CFG_RXR_VEC(0), ndev->vdpa_rx_vec.i=
rq_entry);
> +
> +       vdpa_cfg_writeq(ndev, NFP_NET_CFG_TXRS_ENABLE, 1);
> +       vdpa_cfg_writeq(ndev, NFP_NET_CFG_RXRS_ENABLE, 1);
> +
> +       vdpa_cfg_writel(ndev, NFP_NET_CFG_MTU, NFP_VDPA_MTU_MAX);
> +       vdpa_cfg_writel(ndev, NFP_NET_CFG_FLBUFSZ, NFP_VDPA_FL_BUF_SZ);
> +
> +       /* Enable device */
> +       new_ctrl =3D NFP_NET_CFG_CTRL_ENABLE;
> +       new_ctrl_w1 =3D NFP_NET_CFG_CTRL_VIRTIO | NFP_NET_CFG_CTRL_ENABLE=
_VNET;
> +       update |=3D NFP_NET_CFG_UPDATE_GEN | NFP_NET_CFG_UPDATE_RING | NF=
P_NET_CFG_UPDATE_MSIX;
> +
> +       vdpa_cfg_writel(ndev, NFP_NET_CFG_CTRL, new_ctrl);
> +       vdpa_cfg_writel(ndev, NFP_NET_CFG_CTRL_WORD1, new_ctrl_w1);
> +       if (nfp_vdpa_net_reconfig(ndev, update) < 0)
> +               return -EINVAL;
> +
> +       ndev->ctrl =3D new_ctrl;
> +       ndev->ctrl_w1 =3D new_ctrl_w1;
> +       return 0;
> +}
> +
> +static void nfp_reset_vring(struct nfp_vdpa_net *ndev)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < NFP_VDPA_NUM_QUEUES; i++) {
> +               ndev->vring[i].last_avail_idx =3D 0;
> +               ndev->vring[i].desc =3D 0;
> +               ndev->vring[i].avail =3D 0;
> +               ndev->vring[i].used =3D 0;
> +               ndev->vring[i].ready =3D 0;
> +               ndev->vring[i].cb.callback =3D NULL;
> +               ndev->vring[i].cb.private =3D NULL;

The member vring[i].size is not reset here. Since it is not modifiable
at this moment, isn't it better to remove the member and just inline
NFP_VDPA_QUEUE_MAX?

> +       }
> +}
> +
> +static int nfp_vdpa_set_vq_address(struct vdpa_device *vdpa_dev, u16 qid=
,
> +                                  u64 desc_area, u64 driver_area,
> +                                  u64 device_area)
> +{
> +       struct nfp_vdpa_net *ndev =3D vdpa_to_ndev(vdpa_dev);
> +
> +       ndev->vring[qid].desc =3D desc_area;
> +       ndev->vring[qid].avail =3D driver_area;
> +       ndev->vring[qid].used =3D device_area;
> +
> +       return 0;
> +}
> +
> +static void nfp_vdpa_set_vq_num(struct vdpa_device *vdpa_dev, u16 qid, u=
32 num)
> +{
> +       struct nfp_vdpa_net *ndev =3D vdpa_to_ndev(vdpa_dev);
> +
> +       ndev->vring[qid].size =3D num;
> +}
> +
> +static void nfp_vdpa_kick_vq(struct vdpa_device *vdpa_dev, u16 qid)
> +{
> +       struct nfp_vdpa_net *ndev =3D vdpa_to_ndev(vdpa_dev);
> +
> +       if (!ndev->vring[qid].ready)
> +               return;
> +
> +       writel(qid, ndev->vring[qid].kick_addr);
> +}
> +
> +static void nfp_vdpa_set_vq_cb(struct vdpa_device *vdpa_dev, u16 qid,
> +                              struct vdpa_callback *cb)
> +{
> +       struct nfp_vdpa_net *ndev =3D vdpa_to_ndev(vdpa_dev);
> +
> +       ndev->vring[qid].cb =3D *cb;
> +}
> +
> +static void nfp_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev, u16 qid,
> +                                 bool ready)
> +{
> +       struct nfp_vdpa_net *ndev =3D vdpa_to_ndev(vdpa_dev);
> +
> +       ndev->vring[qid].ready =3D ready;
> +}
> +
> +static bool nfp_vdpa_get_vq_ready(struct vdpa_device *vdpa_dev, u16 qid)
> +{
> +       struct nfp_vdpa_net *ndev =3D vdpa_to_ndev(vdpa_dev);
> +
> +       return ndev->vring[qid].ready;
> +}
> +
> +static int nfp_vdpa_set_vq_state(struct vdpa_device *vdev, u16 idx,
> +                                const struct vdpa_vq_state *state)
> +{
> +       /* Required by live migration, leave for future work */
> +       return 0;
> +}
> +
> +static int nfp_vdpa_get_vq_state(struct vdpa_device *vdev, u16 idx,
> +                                struct vdpa_vq_state *state)
> +{
> +       /* Required by live migration, leave for future work */
> +       return 0;
> +}
> +
> +static u32 nfp_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
> +{
> +       return PAGE_SIZE;
> +}
> +
> +static u64 nfp_vdpa_get_features(struct vdpa_device *vdpa_dev)
> +{
> +       struct nfp_vdpa_net *ndev =3D vdpa_to_ndev(vdpa_dev);
> +
> +       return ndev->features;
> +}
> +
> +static int nfp_vdpa_set_features(struct vdpa_device *vdpa_dev, u64 featu=
res)
> +{
> +       struct nfp_vdpa_net *ndev =3D vdpa_to_ndev(vdpa_dev);
> +
> +       /* DMA mapping must be done by driver */
> +       if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
> +               return -EINVAL;
> +
> +       ndev->features =3D features & NFP_NET_SUPPORTED_FEATURES;
> +
> +       return 0;
> +}
> +
> +static void nfp_vdpa_set_config_cb(struct vdpa_device *vdpa_dev,
> +                                  struct vdpa_callback *cb)
> +{
> +       /* Don't support config interrupt yet */
> +}
> +
> +static u16 nfp_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
> +{
> +       /* Currently the firmware for kernel vDPA only support ring size =
256 */
> +       return NFP_VDPA_QUEUE_MAX;
> +}
> +
> +static u32 nfp_vdpa_get_device_id(struct vdpa_device *vdpa_dev)
> +{
> +       return VIRTIO_ID_NET;
> +}
> +
> +static u32 nfp_vdpa_get_vendor_id(struct vdpa_device *vdpa_dev)
> +{
> +       struct nfp_vdpa_mgmt_dev *mgmt;
> +
> +       mgmt =3D container_of(vdpa_dev->mdev, struct nfp_vdpa_mgmt_dev, m=
dev);
> +       return mgmt->pdev->vendor;
> +}
> +
> +static u8 nfp_vdpa_get_status(struct vdpa_device *vdpa_dev)
> +{
> +       struct nfp_vdpa_net *ndev =3D vdpa_to_ndev(vdpa_dev);
> +
> +       return ndev->status;
> +}
> +
> +static void nfp_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
> +{
> +       struct nfp_vdpa_net *ndev =3D vdpa_to_ndev(vdpa_dev);
> +
> +       if ((status ^ ndev->status) & VIRTIO_CONFIG_S_DRIVER_OK) {
> +               if ((status & VIRTIO_CONFIG_S_DRIVER_OK) =3D=3D 0) {
> +                       dev_err(ndev->vdpa.dma_dev,
> +                               "Did not expect DRIVER_OK to be cleared\n=
");
> +                       return;
> +               }
> +
> +               if (nfp_vdpa_setup_driver(vdpa_dev)) {
> +                       ndev->status |=3D VIRTIO_CONFIG_S_FAILED;
> +                       dev_err(ndev->vdpa.dma_dev,
> +                               "Failed to setup driver\n");
> +                       return;
> +               }
> +       }
> +
> +       ndev->status =3D status;
> +}
> +
> +static int nfp_vdpa_reset(struct vdpa_device *vdpa_dev)
> +{
> +       struct nfp_vdpa_net *ndev =3D vdpa_to_ndev(vdpa_dev);
> +       u32 new_ctrl, new_ctrl_w1, update =3D 0;
> +
> +       if (ndev->status =3D=3D 0)
> +               return 0;
> +
> +       vdpa_cfg_writeb(ndev, NFP_NET_CFG_TXR_VEC(1), 0);
> +       vdpa_cfg_writeb(ndev, NFP_NET_CFG_RXR_VEC(0), 0);
> +
> +       nfp_vdpa_ring_addr_cfg(ndev);
> +
> +       vdpa_cfg_writeq(ndev, NFP_NET_CFG_TXRS_ENABLE, 0);
> +       vdpa_cfg_writeq(ndev, NFP_NET_CFG_RXRS_ENABLE, 0);
> +
> +       new_ctrl =3D ndev->ctrl & ~NFP_NET_CFG_CTRL_ENABLE;
> +       update =3D NFP_NET_CFG_UPDATE_GEN | NFP_NET_CFG_UPDATE_RING | NFP=
_NET_CFG_UPDATE_MSIX;
> +       vdpa_cfg_writel(ndev, NFP_NET_CFG_CTRL, new_ctrl);
> +
> +       new_ctrl_w1 =3D ndev->ctrl_w1 & ~NFP_NET_CFG_CTRL_VIRTIO;
> +       vdpa_cfg_writel(ndev, NFP_NET_CFG_CTRL_WORD1, new_ctrl_w1);
> +
> +       if (nfp_vdpa_net_reconfig(ndev, update) < 0)
> +               return -EINVAL;
> +
> +       nfp_reset_vring(ndev);
> +
> +       ndev->ctrl =3D new_ctrl;
> +       ndev->ctrl_w1 =3D new_ctrl_w1;
> +
> +       ndev->status =3D 0;
> +       return 0;
> +}
> +
> +static size_t nfp_vdpa_get_config_size(struct vdpa_device *vdev)
> +{
> +       struct nfp_vdpa_net *ndev =3D vdpa_to_ndev(vdev);
> +
> +       return sizeof(ndev->config);
> +}
> +
> +static void nfp_vdpa_get_config(struct vdpa_device *vdev, unsigned int o=
ffset,
> +                               void *buf, unsigned int len)
> +{
> +       struct nfp_vdpa_net *ndev =3D vdpa_to_ndev(vdev);
> +
> +       if (offset + len > sizeof(ndev->config))
> +               return;
> +
> +       memcpy(buf, (void *)&ndev->config + offset, len);
> +}
> +
> +static void nfp_vdpa_set_config(struct vdpa_device *vdev, unsigned int o=
ffset,
> +                               const void *buf, unsigned int len)
> +{
> +       struct nfp_vdpa_net *ndev =3D vdpa_to_ndev(vdev);
> +
> +       if (offset + len > sizeof(ndev->config))
> +               return;
> +
> +       memcpy((void *)&ndev->config + offset, buf, len);
> +}
> +
> +static const struct vdpa_config_ops nfp_vdpa_ops =3D {
> +       .set_vq_address         =3D nfp_vdpa_set_vq_address,
> +       .set_vq_num             =3D nfp_vdpa_set_vq_num,
> +       .kick_vq                =3D nfp_vdpa_kick_vq,
> +       .set_vq_cb              =3D nfp_vdpa_set_vq_cb,
> +       .set_vq_ready           =3D nfp_vdpa_set_vq_ready,
> +       .get_vq_ready           =3D nfp_vdpa_get_vq_ready,
> +       .set_vq_state           =3D nfp_vdpa_set_vq_state,
> +       .get_vq_state           =3D nfp_vdpa_get_vq_state,
> +       .get_vq_align           =3D nfp_vdpa_get_vq_align,
> +       .get_device_features    =3D nfp_vdpa_get_features,
> +       .get_driver_features    =3D nfp_vdpa_get_features,
> +       .set_driver_features    =3D nfp_vdpa_set_features,
> +       .set_config_cb          =3D nfp_vdpa_set_config_cb,
> +       .get_vq_num_max         =3D nfp_vdpa_get_vq_num_max,
> +       .get_device_id          =3D nfp_vdpa_get_device_id,
> +       .get_vendor_id          =3D nfp_vdpa_get_vendor_id,
> +       .get_status             =3D nfp_vdpa_get_status,
> +       .set_status             =3D nfp_vdpa_set_status,
> +       .reset                  =3D nfp_vdpa_reset,
> +       .get_config_size        =3D nfp_vdpa_get_config_size,
> +       .get_config             =3D nfp_vdpa_get_config,
> +       .set_config             =3D nfp_vdpa_set_config,
> +};
> +
> +static int nfp_vdpa_map_resources(struct nfp_vdpa_net *ndev,
> +                                 struct pci_dev *pdev,
> +                                 const struct nfp_dev_info *dev_info)
> +{
> +       unsigned int bar_off, bar_sz, tx_bar_sz, rx_bar_sz;
> +       unsigned int max_tx_rings, max_rx_rings, txq, rxq;
> +       u64 tx_bar_off, rx_bar_off;
> +       resource_size_t map_addr;
> +       void __iomem  *tx_bar;
> +       void __iomem  *rx_bar;
> +       int err;
> +
> +       /* Map CTRL BAR */
> +       ndev->ctrl_bar =3D ioremap(pci_resource_start(pdev, NFP_NET_CTRL_=
BAR),
> +                                NFP_NET_CFG_BAR_SZ);
> +       if (!ndev->ctrl_bar)
> +               return -EIO;
> +
> +       /* Find out how many rings are supported */
> +       max_tx_rings =3D readl(ndev->ctrl_bar + NFP_NET_CFG_MAX_TXRINGS);
> +       max_rx_rings =3D readl(ndev->ctrl_bar + NFP_NET_CFG_MAX_RXRINGS);
> +       /* Currently, only one ring is supported */
> +       if (max_tx_rings !=3D NFP_VDPA_QUEUE_RING_MAX || max_rx_rings !=
=3D NFP_VDPA_QUEUE_RING_MAX) {
> +               err =3D -EINVAL;
> +               goto ctrl_bar_unmap;
> +       }
> +
> +       /* Map Q0_BAR as a single overlapping BAR mapping */
> +       tx_bar_sz =3D NFP_QCP_QUEUE_ADDR_SZ * max_tx_rings * NFP_VDPA_QUE=
UE_SPACE_STRIDE;
> +       rx_bar_sz =3D NFP_QCP_QUEUE_ADDR_SZ * max_rx_rings * NFP_VDPA_QUE=
UE_SPACE_STRIDE;
> +
> +       txq =3D readl(ndev->ctrl_bar + NFP_NET_CFG_START_TXQ);
> +       tx_bar_off =3D nfp_qcp_queue_offset(dev_info, txq);
> +       rxq =3D readl(ndev->ctrl_bar + NFP_NET_CFG_START_RXQ);
> +       rx_bar_off =3D nfp_qcp_queue_offset(dev_info, rxq);
> +
> +       bar_off =3D min(tx_bar_off, rx_bar_off);
> +       bar_sz =3D max(tx_bar_off + tx_bar_sz, rx_bar_off + rx_bar_sz);
> +       bar_sz -=3D bar_off;
> +
> +       map_addr =3D pci_resource_start(pdev, NFP_NET_Q0_BAR) + bar_off;
> +       ndev->q_bar =3D ioremap(map_addr, bar_sz);
> +       if (!ndev->q_bar) {
> +               err =3D -EIO;
> +               goto ctrl_bar_unmap;
> +       }
> +
> +       tx_bar =3D ndev->q_bar + (tx_bar_off - bar_off);
> +       rx_bar =3D ndev->q_bar + (rx_bar_off - bar_off);
> +
> +       /* TX queues */
> +       ndev->vring[txq].kick_addr =3D ndev->ctrl_bar + NFP_VDPA_NOTIFY_A=
REA_BASE
> +                                    + txq * NFP_VDPA_QUEUE_NOTIFY_OFFSET=
;
> +       /* RX queues */
> +       ndev->vring[rxq].kick_addr =3D ndev->ctrl_bar + NFP_VDPA_NOTIFY_A=
REA_BASE
> +                                    + rxq * NFP_VDPA_QUEUE_NOTIFY_OFFSET=
;
> +       /* Stash the re-configuration queue away. First odd queue in TX B=
ar */
> +       ndev->qcp_cfg =3D tx_bar + NFP_QCP_QUEUE_ADDR_SZ;
> +
> +       return 0;
> +
> +ctrl_bar_unmap:
> +       iounmap(ndev->ctrl_bar);
> +       return err;
> +}
> +
> +static int nfp_vdpa_init_ndev(struct nfp_vdpa_net *ndev)
> +{
> +       ndev->features =3D NFP_NET_SUPPORTED_FEATURES;
> +
> +       ndev->config.mtu =3D cpu_to_nfpvdpa16(ndev, NFP_NET_DEFAULT_MTU);
> +       ndev->config.status =3D cpu_to_nfpvdpa16(ndev, VIRTIO_NET_S_LINK_=
UP);
> +
> +       put_unaligned_be32(vdpa_cfg_readl(ndev, NFP_NET_CFG_MACADDR + 0),=
 &ndev->config.mac[0]);
> +       put_unaligned_be16(vdpa_cfg_readw(ndev, NFP_NET_CFG_MACADDR + 6),=
 &ndev->config.mac[4]);
> +
> +       return 0;
> +}
> +
> +static int nfp_vdpa_mgmt_dev_add(struct vdpa_mgmt_dev *mdev,
> +                                const char *name,
> +                                const struct vdpa_dev_set_config *add_co=
nfig)
> +{
> +       struct nfp_vdpa_mgmt_dev *mgmt =3D container_of(mdev, struct nfp_=
vdpa_mgmt_dev, mdev);
> +       struct msix_entry vdpa_irq[NFP_VDPA_NUM_QUEUES];
> +       struct device *dev =3D &mgmt->pdev->dev;
> +       struct nfp_vdpa_net *ndev;
> +       int ret;
> +
> +       /* Only allow one ndev at a time. */
> +       if (mgmt->ndev)
> +               return -EOPNOTSUPP;
> +
> +       ndev =3D vdpa_alloc_device(struct nfp_vdpa_net, vdpa, dev, &nfp_v=
dpa_ops, 1, 1, name, false);
> +
> +       if (IS_ERR(ndev))
> +               return PTR_ERR(ndev);
> +
> +       mgmt->ndev =3D ndev;
> +
> +       ret =3D nfp_net_irqs_alloc(mgmt->pdev, (struct msix_entry *)&vdpa=
_irq, 2, 2);
> +       if (!ret) {
> +               ret =3D -ENOMEM;
> +               goto free_dev;
> +       }
> +
> +       ndev->vdpa_rx_irq.entry =3D vdpa_irq[NFP_VDPA_RX_QUEUE].entry;
> +       ndev->vdpa_rx_irq.vector =3D vdpa_irq[NFP_VDPA_RX_QUEUE].vector;
> +
> +       snprintf(ndev->vdpa_rx_vec.name, sizeof(ndev->vdpa_rx_vec.name), =
"nfp-vdpa-rx0");
> +       ndev->vdpa_rx_vec.irq_entry =3D ndev->vdpa_rx_irq.entry;
> +       ndev->vdpa_rx_vec.irq_vector =3D ndev->vdpa_rx_irq.vector;
> +
> +       ndev->vdpa_tx_irq.entry =3D vdpa_irq[NFP_VDPA_TX_QUEUE].entry;
> +       ndev->vdpa_tx_irq.vector =3D vdpa_irq[NFP_VDPA_TX_QUEUE].vector;
> +
> +       snprintf(ndev->vdpa_tx_vec.name, sizeof(ndev->vdpa_tx_vec.name), =
"nfp-vdpa-tx0");
> +       ndev->vdpa_tx_vec.irq_entry =3D ndev->vdpa_tx_irq.entry;
> +       ndev->vdpa_tx_vec.irq_vector =3D ndev->vdpa_tx_irq.vector;
> +
> +       ret =3D request_irq(ndev->vdpa_tx_vec.irq_vector, nfp_vdpa_irq_tx=
,
> +                         0, ndev->vdpa_tx_vec.name, &ndev->vdpa_tx_vec);
> +       if (ret)
> +               goto disable_irq;
> +
> +       ret =3D request_irq(ndev->vdpa_rx_vec.irq_vector, nfp_vdpa_irq_rx=
,
> +                         0, ndev->vdpa_rx_vec.name, &ndev->vdpa_rx_vec);
> +       if (ret)
> +               goto free_tx_irq;
> +
> +       ret =3D nfp_vdpa_map_resources(mgmt->ndev, mgmt->pdev, mgmt->dev_=
info);
> +       if (ret)
> +               goto free_rx_irq;
> +
> +       ret =3D nfp_vdpa_init_ndev(mgmt->ndev);
> +       if (ret)
> +               goto unmap_resources;
> +
> +       sema_init(&ndev->bar_lock, 1);
> +
> +       ndev->vdpa.dma_dev =3D dev;
> +       ndev->vdpa.mdev =3D &mgmt->mdev;
> +
> +       mdev->supported_features =3D NFP_NET_SUPPORTED_FEATURES;
> +       mdev->max_supported_vqs =3D NFP_VDPA_QUEUE_MAX;
> +

This should be NFP_VDPA_NUM_QUEUES actually?

> +       ret =3D _vdpa_register_device(&ndev->vdpa, NFP_VDPA_NUM_QUEUES);
> +       if (ret)
> +               goto unmap_resources;
> +
> +       return 0;
> +
> +unmap_resources:
> +       iounmap(ndev->ctrl_bar);
> +       iounmap(ndev->q_bar);
> +free_rx_irq:
> +       free_irq(ndev->vdpa_rx_vec.irq_vector, &ndev->vdpa_rx_vec);
> +free_tx_irq:
> +       free_irq(ndev->vdpa_tx_vec.irq_vector, &ndev->vdpa_tx_vec);
> +disable_irq:
> +       nfp_net_irqs_disable(mgmt->pdev);
> +free_dev:
> +       put_device(&ndev->vdpa.dev);
> +       return ret;
> +}
> +
> +static void nfp_vdpa_mgmt_dev_del(struct vdpa_mgmt_dev *mdev,
> +                                 struct vdpa_device *dev)
> +{
> +       struct nfp_vdpa_mgmt_dev *mgmt =3D container_of(mdev, struct nfp_=
vdpa_mgmt_dev, mdev);
> +       struct nfp_vdpa_net *ndev =3D vdpa_to_ndev(dev);
> +
> +       free_irq(ndev->vdpa_rx_vec.irq_vector, &ndev->vdpa_rx_vec);
> +       free_irq(ndev->vdpa_tx_vec.irq_vector, &ndev->vdpa_tx_vec);
> +       nfp_net_irqs_disable(mgmt->pdev);
> +       _vdpa_unregister_device(dev);
> +
> +       iounmap(ndev->ctrl_bar);
> +       iounmap(ndev->q_bar);
> +
> +       mgmt->ndev =3D NULL;
> +}
> +
> +static const struct vdpa_mgmtdev_ops nfp_vdpa_mgmt_dev_ops =3D {
> +       .dev_add =3D nfp_vdpa_mgmt_dev_add,
> +       .dev_del =3D nfp_vdpa_mgmt_dev_del,
> +};
> +
> +static struct virtio_device_id nfp_vdpa_mgmt_id_table[] =3D {
> +       { VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
> +       { 0 },
> +};
> +
> +static int nfp_vdpa_probe(struct auxiliary_device *adev, const struct au=
xiliary_device_id *id)
> +{
> +       struct nfp_net_vf_aux_dev *nfp_vf_aux_dev;
> +       struct nfp_vdpa_mgmt_dev *mgmt;
> +       int ret;
> +
> +       nfp_vf_aux_dev =3D container_of(adev, struct nfp_net_vf_aux_dev, =
aux_dev);
> +
> +       mgmt =3D kzalloc(sizeof(*mgmt), GFP_KERNEL);
> +       if (!mgmt)
> +               return -ENOMEM;
> +
> +       mgmt->pdev =3D nfp_vf_aux_dev->pdev;
> +
> +       mgmt->mdev.device =3D &nfp_vf_aux_dev->pdev->dev;
> +       mgmt->mdev.ops =3D &nfp_vdpa_mgmt_dev_ops;
> +       mgmt->mdev.id_table =3D nfp_vdpa_mgmt_id_table;
> +       mgmt->dev_info =3D nfp_vf_aux_dev->dev_info;
> +
> +       ret =3D vdpa_mgmtdev_register(&mgmt->mdev);
> +       if (ret)
> +               goto err_free_mgmt;
> +
> +       auxiliary_set_drvdata(adev, mgmt);
> +
> +       return 0;
> +
> +err_free_mgmt:
> +       kfree(mgmt);
> +
> +       return ret;
> +}
> +
> +static void nfp_vdpa_remove(struct auxiliary_device *adev)
> +{
> +       struct nfp_vdpa_mgmt_dev *mgmt;
> +
> +       mgmt =3D auxiliary_get_drvdata(adev);
> +       if (!mgmt)
> +               return;
> +
> +       vdpa_mgmtdev_unregister(&mgmt->mdev);
> +       kfree(mgmt);
> +
> +       auxiliary_set_drvdata(adev, NULL);
> +}
> +
> +static const struct auxiliary_device_id nfp_vdpa_id_table[] =3D {
> +       { .name =3D NFP_NET_VF_ADEV_NAME "." NFP_NET_VF_ADEV_DRV_MATCH_NA=
ME, },
> +       {},
> +};
> +
> +MODULE_DEVICE_TABLE(auxiliary, nfp_vdpa_id_table);
> +
> +static struct auxiliary_driver nfp_vdpa_driver =3D {
> +       .name =3D NFP_NET_VF_ADEV_DRV_MATCH_NAME,
> +       .probe =3D nfp_vdpa_probe,
> +       .remove =3D nfp_vdpa_remove,
> +       .id_table =3D nfp_vdpa_id_table,
> +};
> +
> +module_auxiliary_driver(nfp_vdpa_driver);
> +
> +MODULE_AUTHOR("Corigine, Inc. <oss-drivers@corigine.com>");
> +MODULE_DESCRIPTION("NFP vDPA driver");
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
>


