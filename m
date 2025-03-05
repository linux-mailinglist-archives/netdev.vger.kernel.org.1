Return-Path: <netdev+bounces-171950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4147A4F93E
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 09:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE94188D1FA
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 08:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F5B1FDA61;
	Wed,  5 Mar 2025 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c26htyjx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87364191F75
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164936; cv=none; b=koIuH8Rxl1L0dtohS9MHWp0ZvXQ9z3a08tq5rhc2CmArj3EwxnE7F2KVTsjbc4D3cDW4e0r93rHzyJsOeXE4MkRlB7J9IrLyppAn4Cz3ogrAsLrMq5Rm00TopeljLS38zNOQtDATHO3M/hh2EN+8aDtZW6Rs3cxLNf7FGF+8Fus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164936; c=relaxed/simple;
	bh=zV+iPQBUWzgbRLb07CTVQeBWnbBbJp/+J4LAosdpzlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lk9UM2swF9e+yfQc3GS09tj5m4qPUlsr5YK5VYBNTbXizqXPLYMil4bx+IY+Bn6qLEWWzOS1mr8e+WaDeZhdAVvYsQ0IC/UaPoepIw2Pt1N3al3fPgBg39f466oKy2k72Z3wWP5ueZElRwQjg+jq7FpmoElDv5tRT5rSL8Ki41k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c26htyjx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2238e884f72so66625745ad.3
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 00:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741164934; x=1741769734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PCCBJ+nRq+ql5cmz2OT+83HMtonAZSvPEGTMjf4hSH0=;
        b=c26htyjxZFxEfPE30z5ehxP40qc3ulTW4S2cO0RQ4qZ050JK/5AgOdUVZivmeqcuO2
         XjhreMOTtNPHKf4ahiRHjvhYCuo0KN9u56AgMMuJOxolzqhnyaye+P2b5a2AZKF44/ZI
         bAYAh6NucmBeXVhKRY8U774LRVFHwgGfxaCa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741164934; x=1741769734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCCBJ+nRq+ql5cmz2OT+83HMtonAZSvPEGTMjf4hSH0=;
        b=s2Um79cw55XeuGeSw5zUXjSB42842Oc1DlxbyOR60k7AHOGKLif3gD6aakngiPPn/l
         EX+mPEjwTr3lUeJtz0LJVLhf/VTX35Qxu/duR+8SMhdlL0dNh7scU1PRKB9g2vaqyAln
         oYw3rC+TIZuS08v8OkeTVxrxTEugknsDaI2ct1D+JaSayv6QbJcwQR4L5YgBm3MlK+0M
         rZI6s0VfKW2n+8J/iVRdfWOJ9ZIf7lyCOWK+zdDDUNudnbLJu+3/gy86afgUD5GyT4Fs
         gUDIK4UJY9s4vuhIrUmnZsAQCfxccJSBkQngMCg482w2JP3XYPR/2jQ+u8eDPib1/X0E
         H0/w==
X-Gm-Message-State: AOJu0YzHQOiPwEwPDQgV+aQfeQe6kPQeaADMA8vrvbNsGuvsCWIbeIYu
	lLmWIXpcuDqkw0sHupDzd5wImUjC4Kwlrx05/W7R0ITt4wqEhnGlAjlTb620wOWbjDyK9zRWVt6
	8KUwUB+yT9nDtXZjRRUg+WhLmcMwARpo1SDwHIfB69W0xexWrCg==
X-Gm-Gg: ASbGncv0t1AVL2SkSPBvtR+WozN4PZ3FUGT/Ep86xJtbHIvmTguh2M6Unax1gndXylL
	/JOjQ0U6iZWmMNtfbMvdUftJ96LzVMWJPZ+hCJtX4PfSU94bngVAm57w9aEJpd02NGOUCPWQ1ab
	XtCkSS0Zoy+xU2SECIBoyNl5UEFi0=
X-Google-Smtp-Source: AGHT+IFlu6xhFfDtt77HA4Vbdbn5uof2MXkJGJPErWc+2raW6lK1897XosqUjQf68ObefQcZ+UiWNSzlFRSFRyzaTl4=
X-Received: by 2002:a05:6a00:4b01:b0:736:5b46:489b with SMTP id
 d2e1a72fcca58-73682b55238mr3866346b3a.1.1741164933667; Wed, 05 Mar 2025
 00:55:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228154122.216053-1-tianx@yunsilicon.com> <20250228154122.216053-2-tianx@yunsilicon.com>
In-Reply-To: <20250228154122.216053-2-tianx@yunsilicon.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 5 Mar 2025 14:25:21 +0530
X-Gm-Features: AQ5f1JqtT5llFarFg2NJrh5nAwluOoh7D17nfexJ7qvSzZ9vyEctvC8WjAPjRwo
Message-ID: <CAH-L+nPNR4CjHAFEfzv8sVHvpuHcA1SXMPOMuGuLZ0bTechX0g@mail.gmail.com>
Subject: Re: [PATCH net-next v7 01/14] xsc: Add xsc driver basic framework
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, andrew+netdev@lunn.ch, 
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, davem@davemloft.net, 
	jeff.johnson@oss.qualcomm.com, przemyslaw.kitszel@intel.com, 
	weihg@yunsilicon.com, wanry@yunsilicon.com, jacky@yunsilicon.com, 
	horms@kernel.org, parthiban.veerasooran@microchip.com, masahiroy@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000065112b062f948d52"

--00000000000065112b062f948d52
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 9:12=E2=80=AFPM Xin Tian <tianx@yunsilicon.com> wro=
te:
>
> 1. Add yunsilicon xsc driver basic compile framework, including
> xsc_pci driver and xsc_eth driver
> 2. Implemented PCI device initialization.
>
> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
> ---
>  MAINTAINERS                                   |   7 +
>  drivers/net/ethernet/Kconfig                  |   1 +
>  drivers/net/ethernet/Makefile                 |   1 +
>  drivers/net/ethernet/yunsilicon/Kconfig       |  26 ++
>  drivers/net/ethernet/yunsilicon/Makefile      |   8 +
>  .../ethernet/yunsilicon/xsc/common/xsc_core.h |  53 ++++
>  .../net/ethernet/yunsilicon/xsc/net/Kconfig   |  17 ++
>  .../net/ethernet/yunsilicon/xsc/net/Makefile  |   9 +
>  .../net/ethernet/yunsilicon/xsc/pci/Kconfig   |  16 ++
>  .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   9 +
>  .../net/ethernet/yunsilicon/xsc/pci/main.c    | 255 ++++++++++++++++++
>  11 files changed, 402 insertions(+)
>  create mode 100644 drivers/net/ethernet/yunsilicon/Kconfig
>  create mode 100644 drivers/net/ethernet/yunsilicon/Makefile
>  create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>  create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
>  create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Makefile
>  create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
>  create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
>  create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/main.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc40a9d9b..4892dd63e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25285,6 +25285,13 @@ S:     Maintained
>  F:     Documentation/input/devices/yealink.rst
>  F:     drivers/input/misc/yealink.*
>
> +YUNSILICON XSC DRIVERS
> +M:     Honggang Wei <weihg@yunsilicon.com>
> +M:     Xin Tian <tianx@yunsilicon.com>
> +L:     netdev@vger.kernel.org
> +S:     Maintained
> +F:     drivers/net/ethernet/yunsilicon/xsc
> +
>  Z3FOLD COMPRESSED PAGE ALLOCATOR
>  M:     Vitaly Wool <vitaly.wool@konsulko.com>
>  R:     Miaohe Lin <linmiaohe@huawei.com>
> diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
> index 0baac25db..aa6016597 100644
> --- a/drivers/net/ethernet/Kconfig
> +++ b/drivers/net/ethernet/Kconfig
> @@ -82,6 +82,7 @@ source "drivers/net/ethernet/i825xx/Kconfig"
>  source "drivers/net/ethernet/ibm/Kconfig"
>  source "drivers/net/ethernet/intel/Kconfig"
>  source "drivers/net/ethernet/xscale/Kconfig"
> +source "drivers/net/ethernet/yunsilicon/Kconfig"
>
>  config JME
>         tristate "JMicron(R) PCI-Express Gigabit Ethernet support"
> diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefil=
e
> index c03203439..c16c34d4b 100644
> --- a/drivers/net/ethernet/Makefile
> +++ b/drivers/net/ethernet/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_NET_VENDOR_INTEL) +=3D intel/
>  obj-$(CONFIG_NET_VENDOR_I825XX) +=3D i825xx/
>  obj-$(CONFIG_NET_VENDOR_MICROSOFT) +=3D microsoft/
>  obj-$(CONFIG_NET_VENDOR_XSCALE) +=3D xscale/
> +obj-$(CONFIG_NET_VENDOR_YUNSILICON) +=3D yunsilicon/
>  obj-$(CONFIG_JME) +=3D jme.o
>  obj-$(CONFIG_KORINA) +=3D korina.o
>  obj-$(CONFIG_LANTIQ_ETOP) +=3D lantiq_etop.o
> diff --git a/drivers/net/ethernet/yunsilicon/Kconfig b/drivers/net/ethern=
et/yunsilicon/Kconfig
> new file mode 100644
> index 000000000..ff57fedf8
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/Kconfig
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +# Yunsilicon driver configuration
> +#
> +
> +config NET_VENDOR_YUNSILICON
> +       bool "Yunsilicon devices"
> +       default y
> +       depends on PCI
> +       depends on ARM64 || X86_64
> +       help
> +         If you have a network (Ethernet) device belonging to this class=
,
> +         say Y.
> +
> +         Note that the answer to this question doesn't directly affect t=
he
> +         kernel: saying N will just cause the configurator to skip all
> +         the questions about Yunsilicon cards. If you say Y, you will be=
 asked
> +         for your specific card in the following questions.
> +
> +if NET_VENDOR_YUNSILICON
> +
> +source "drivers/net/ethernet/yunsilicon/xsc/net/Kconfig"
> +source "drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig"
> +
> +endif # NET_VENDOR_YUNSILICON
> diff --git a/drivers/net/ethernet/yunsilicon/Makefile b/drivers/net/ether=
net/yunsilicon/Makefile
> new file mode 100644
> index 000000000..6fc8259a7
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +# Makefile for the Yunsilicon device drivers.
> +#
> +
> +# obj-$(CONFIG_YUNSILICON_XSC_ETH) +=3D xsc/net/
> +obj-$(CONFIG_YUNSILICON_XSC_PCI) +=3D xsc/pci/
> \ No newline at end of file
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/driv=
ers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> new file mode 100644
> index 000000000..6627a176a
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> + * All rights reserved.
> + */
> +
> +#ifndef __XSC_CORE_H
> +#define __XSC_CORE_H
> +
> +#include <linux/pci.h>
> +
> +#define XSC_PCI_VENDOR_ID              0x1f67
> +
> +#define XSC_MC_PF_DEV_ID               0x1011
> +#define XSC_MC_VF_DEV_ID               0x1012
> +#define XSC_MC_PF_DEV_ID_DIAMOND       0x1021
> +
> +#define XSC_MF_HOST_PF_DEV_ID          0x1051
> +#define XSC_MF_HOST_VF_DEV_ID          0x1052
> +#define XSC_MF_SOC_PF_DEV_ID           0x1053
> +
> +#define XSC_MS_PF_DEV_ID               0x1111
> +#define XSC_MS_VF_DEV_ID               0x1112
> +
> +#define XSC_MV_HOST_PF_DEV_ID          0x1151
> +#define XSC_MV_HOST_VF_DEV_ID          0x1152
> +#define XSC_MV_SOC_PF_DEV_ID           0x1153
> +
> +struct xsc_dev_resource {
> +       /* protect buffer allocation according to numa node */
> +       struct mutex            alloc_mutex;
> +};
> +
> +enum xsc_pci_state {
> +       XSC_PCI_STATE_DISABLED,
> +       XSC_PCI_STATE_ENABLED,
> +};
> +
> +struct xsc_core_device {
> +       struct pci_dev          *pdev;
> +       struct device           *device;
> +       struct xsc_dev_resource *dev_res;
> +       int                     numa_node;
> +
> +       void __iomem            *bar;
> +       int                     bar_num;
> +
> +       struct mutex            pci_state_mutex;        /* protect pci_st=
ate */
> +       enum xsc_pci_state      pci_state;
> +       struct mutex            intf_state_mutex;       /* protect intf_s=
tate */
> +       unsigned long           intf_state;
> +};
> +
> +#endif
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig b/drivers/ne=
t/ethernet/yunsilicon/xsc/net/Kconfig
> new file mode 100644
> index 000000000..de743487e
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +# Yunsilicon driver configuration
> +#
> +
> +config YUNSILICON_XSC_ETH
> +       tristate "Yunsilicon XSC ethernet driver"
> +       default n
> +       depends on YUNSILICON_XSC_PCI
> +       depends on NET
> +       help
> +         This driver provides ethernet support for
> +         Yunsilicon XSC devices.
> +
> +         To compile this driver as a module, choose M here. The module
> +         will be called xsc_eth.
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile b/drivers/n=
et/ethernet/yunsilicon/xsc/net/Makefile
> new file mode 100644
> index 000000000..2811433af
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +
> +ccflags-y +=3D -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
> +
> +obj-$(CONFIG_YUNSILICON_XSC_ETH) +=3D xsc_eth.o
> +
> +xsc_eth-y :=3D main.o
> \ No newline at end of file
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig b/drivers/ne=
t/ethernet/yunsilicon/xsc/pci/Kconfig
> new file mode 100644
> index 000000000..2b6d79905
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +# Yunsilicon PCI configuration
> +#
> +
> +config YUNSILICON_XSC_PCI
> +       tristate "Yunsilicon XSC PCI driver"
> +       default n
> +       select PAGE_POOL
> +       help
> +         This driver is common for Yunsilicon XSC
> +         ethernet and RDMA drivers.
> +
> +         To compile this driver as a module, choose M here. The module
> +         will be called xsc_pci.
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/n=
et/ethernet/yunsilicon/xsc/pci/Makefile
> new file mode 100644
> index 000000000..709270df8
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +
> +ccflags-y +=3D -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
> +
> +obj-$(CONFIG_YUNSILICON_XSC_PCI) +=3D xsc_pci.o
> +
> +xsc_pci-y :=3D main.o
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net=
/ethernet/yunsilicon/xsc/pci/main.c
> new file mode 100644
> index 000000000..ec3181a8e
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
> @@ -0,0 +1,255 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> + * All rights reserved.
> + */
> +
> +#include "common/xsc_core.h"
> +
> +static const struct pci_device_id xsc_pci_id_table[] =3D {
> +       { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID) },
> +       { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID_DIAMOND) },
> +       { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MF_HOST_PF_DEV_ID) },
> +       { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MF_SOC_PF_DEV_ID) },
> +       { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MS_PF_DEV_ID) },
> +       { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MV_HOST_PF_DEV_ID) },
> +       { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MV_SOC_PF_DEV_ID) },
> +       { 0 }
> +};
> +
> +static int set_dma_caps(struct pci_dev *pdev)
> +{
> +       int err;
> +
> +       err =3D dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
> +       if (err)
> +               err =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MAS=
K(32));
> +       else
> +               err =3D dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64=
));
You can simplify this as:

        err =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
        if (err)
                err =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(=
32));
> +
> +       if (!err)
> +               dma_set_max_seg_size(&pdev->dev, SZ_2G);
> +
> +       return err;
> +}
> +
> +static int xsc_pci_enable_device(struct xsc_core_device *xdev)
> +{
> +       struct pci_dev *pdev =3D xdev->pdev;
> +       int err =3D 0;
> +
> +       mutex_lock(&xdev->pci_state_mutex);
> +       if (xdev->pci_state =3D=3D XSC_PCI_STATE_DISABLED) {
Why is this pci_state checking needed. any reason to not use
pci_is_enabled(dev)?
> +               err =3D pci_enable_device(pdev);
> +               if (!err)
> +                       xdev->pci_state =3D XSC_PCI_STATE_ENABLED;
> +       }
> +       mutex_unlock(&xdev->pci_state_mutex);
> +
> +       return err;
> +}
> +
> +static void xsc_pci_disable_device(struct xsc_core_device *xdev)
> +{
> +       struct pci_dev *pdev =3D xdev->pdev;
> +
> +       mutex_lock(&xdev->pci_state_mutex);
> +       if (xdev->pci_state =3D=3D XSC_PCI_STATE_ENABLED) {
> +               pci_disable_device(pdev);
> +               xdev->pci_state =3D XSC_PCI_STATE_DISABLED;
> +       }
> +       mutex_unlock(&xdev->pci_state_mutex);
> +}
> +
> +static int xsc_pci_init(struct xsc_core_device *xdev,
> +                       const struct pci_device_id *id)
> +{
> +       struct pci_dev *pdev =3D xdev->pdev;
> +       void __iomem *bar_base;
> +       int bar_num =3D 0;
> +       int err;
> +
> +       xdev->numa_node =3D dev_to_node(&pdev->dev);
> +
> +       err =3D xsc_pci_enable_device(xdev);
> +       if (err) {
> +               pci_err(pdev, "failed to enable PCI device: err=3D%d\n", =
err);
> +               goto err_ret;
You can return directly from here
> +       }
> +
> +       err =3D pci_request_region(pdev, bar_num, KBUILD_MODNAME);
> +       if (err) {
> +               pci_err(pdev, "failed to request %s pci_region=3D%d: err=
=3D%d\n",
> +                       KBUILD_MODNAME, bar_num, err);
> +               goto err_disable;
> +       }
> +
> +       pci_set_master(pdev);
> +
> +       err =3D set_dma_caps(pdev);
> +       if (err) {
> +               pci_err(pdev, "failed to set DMA capabilities mask: err=
=3D%d\n",
> +                       err);
> +               goto err_clr_master;
> +       }
> +
> +       bar_base =3D pci_ioremap_bar(pdev, bar_num);
> +       if (!bar_base) {
> +               pci_err(pdev, "failed to ioremap %s bar%d\n", KBUILD_MODN=
AME,
> +                       bar_num);
> +               err =3D -ENOMEM;
> +               goto err_clr_master;
> +       }
> +
> +       err =3D pci_save_state(pdev);
> +       if (err) {
> +               pci_err(pdev, "pci_save_state failed: err=3D%d\n", err);
> +               goto err_io_unmap;
> +       }
> +
> +       xdev->bar_num =3D bar_num;
> +       xdev->bar =3D bar_base;
> +
> +       return 0;
> +
> +err_io_unmap:
> +       pci_iounmap(pdev, bar_base);
> +err_clr_master:
> +       pci_clear_master(pdev);
> +       pci_release_region(pdev, bar_num);
> +err_disable:
> +       xsc_pci_disable_device(xdev);
> +err_ret:
> +       return err;
> +}
> +
> +static void xsc_pci_fini(struct xsc_core_device *xdev)
> +{
> +       struct pci_dev *pdev =3D xdev->pdev;
> +
> +       if (xdev->bar)
Is this check really needed?
> +               pci_iounmap(pdev, xdev->bar);
> +       pci_clear_master(pdev);
> +       pci_release_region(pdev, xdev->bar_num);
> +       xsc_pci_disable_device(xdev);
> +}
> +
> +static int xsc_dev_res_init(struct xsc_core_device *xdev)
> +{
> +       struct xsc_dev_resource *dev_res;
> +
> +       dev_res =3D kvzalloc(sizeof(*dev_res), GFP_KERNEL);
> +       if (!dev_res)
> +               return -ENOMEM;
> +
> +       xdev->dev_res =3D dev_res;
> +       mutex_init(&dev_res->alloc_mutex);
> +
> +       return 0;
> +}
> +
> +static void xsc_dev_res_cleanup(struct xsc_core_device *xdev)
> +{
> +       kfree(xdev->dev_res);
> +}
> +
> +static int xsc_core_dev_init(struct xsc_core_device *xdev)
> +{
> +       int err;
> +
> +       mutex_init(&xdev->pci_state_mutex);
> +       mutex_init(&xdev->intf_state_mutex);
> +
> +       err =3D xsc_dev_res_init(xdev);
> +       if (err) {
> +               pci_err(xdev->pdev, "xsc dev res init failed %d\n", err);
> +               goto out;
You can avoid this label by doing "return err" instead of "return 0"
the line below
> +       }
> +
> +       return 0;
> +out:
> +       return err;
> +}
> +
> +static void xsc_core_dev_cleanup(struct xsc_core_device *xdev)
> +{
> +       xsc_dev_res_cleanup(xdev);
> +}
> +
> +static int xsc_pci_probe(struct pci_dev *pci_dev,
> +                        const struct pci_device_id *id)
> +{
> +       struct xsc_core_device *xdev;
> +       int err;
> +
> +       xdev =3D kzalloc(sizeof(*xdev), GFP_KERNEL);
> +       if (!xdev)
> +               return -ENOMEM;
> +
> +       xdev->pdev =3D pci_dev;
> +       xdev->device =3D &pci_dev->dev;
> +
> +       pci_set_drvdata(pci_dev, xdev);
> +       err =3D xsc_pci_init(xdev, id);
> +       if (err) {
> +               pci_err(pci_dev, "xsc_pci_init failed %d\n", err);
> +               goto err_unset_pci_drvdata;
> +       }
> +
> +       err =3D xsc_core_dev_init(xdev);
> +       if (err) {
> +               pci_err(pci_dev, "xsc_core_dev_init failed %d\n", err);
> +               goto err_pci_fini;
> +       }
> +
> +       return 0;
> +err_pci_fini:
> +       xsc_pci_fini(xdev);
> +err_unset_pci_drvdata:
> +       pci_set_drvdata(pci_dev, NULL);
> +       kfree(xdev);
> +
> +       return err;
> +}
> +
> +static void xsc_pci_remove(struct pci_dev *pci_dev)
> +{
> +       struct xsc_core_device *xdev =3D pci_get_drvdata(pci_dev);
> +
> +       xsc_core_dev_cleanup(xdev);
> +       xsc_pci_fini(xdev);
> +       pci_set_drvdata(pci_dev, NULL);
> +       kfree(xdev);
> +}
> +
> +static struct pci_driver xsc_pci_driver =3D {
> +       .name           =3D "xsc-pci",
> +       .id_table       =3D xsc_pci_id_table,
> +       .probe          =3D xsc_pci_probe,
> +       .remove         =3D xsc_pci_remove,
> +};
> +
> +static int __init xsc_init(void)
> +{
> +       int err;
> +
> +       err =3D pci_register_driver(&xsc_pci_driver);
> +       if (err) {
> +               pr_err("failed to register pci driver\n");
> +               goto out;
There is no need of this label
> +       }
> +       return 0;
"return err" here
> +
> +out:
> +       return err;
> +}
> +
> +static void __exit xsc_fini(void)
> +{
> +       pci_unregister_driver(&xsc_pci_driver);
> +}
> +
> +module_init(xsc_init);
> +module_exit(xsc_fini);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Yunsilicon XSC PCI driver");
> --
> 2.18.4
>


--=20
Regards,
Kalesh AP

--00000000000065112b062f948d52
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcN
AQkEMSIEINPHKM+w+HZ3+0HV95zg/Y0on8v7LADawBK+LRtsCwnZMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMwNTA4NTUzNFowXAYJKoZIhvcNAQkPMU8wTTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAE3YBf8PnifZKsRbE4w3WhXuwO7v
To48mJcPrFzdl//mDL/scYub8exQGFdH6lvOOkKbEMw0hBWRa1ROq4h5Ls3b7Z8YpgCROjxjgZUZ
PRRo5WyqWAAtn0F6Ie8GUbJhpmX1JwOJ8Onzk0IrF7FfD6KGp5linO/QeOMkBbuqI3li2kPCfGIv
XPdrYUwxZyRTTZ3vpWyO0+ns80TTCv7saVTVhppVKlWiVlgF4noyQiXvZpaBHk/vuoy0NatkOX2T
w2dn6s66HV2ejVAcKFYix5Hsp0gjiFC8qPoe8zMllhytWt1UGR0Xf2VH6L4PxoRCVqJrz3W34FOd
Tj2ZK/Zs22g=
--00000000000065112b062f948d52--

