Return-Path: <netdev+bounces-137359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF52C9A5940
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 05:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559C31F21F41
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 03:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FA75FEE4;
	Mon, 21 Oct 2024 03:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Vh7vhpq7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142C14A90
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 03:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729481466; cv=none; b=aBSkibGEjfOMU/3j7NQOQ45+Q9UKQ2GRgzo4s++q0JwZsqDU0jrJi+m0jAMUN4zphcPBST9mE/5QLrBbf6YAjDtitUZIrUiK+Pq3IefNvyatikZxLNDYen4/QRF7t7HQT77BP73xNk2t8z7d2nub4LqKcOcErLM96k5drM7I5tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729481466; c=relaxed/simple;
	bh=86dOc3KMWX0yHRD0tLllDSpJB/PEUisu+PfSbRNhl4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/u1/DZDiTJPuaGFmI4zw/lzmBndSoICRezi6aKraNpKkBxhzEWDc3uw/xWaR3lJBk3sre0zqeDxyhQJPl09aNM5EorcF10NSK7rWtEJzljwHHDQ6uPBsMimoZmonZ7e/mHd2PjtKP1oSFdIKzV4E7M58Rkh+S1cU9mNtdeMNus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Vh7vhpq7; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso38699831fa.0
        for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 20:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729481461; x=1730086261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s7fSPS1dvX+yf2Mp6aEWASzwZkZkFCgsunSKq6ktlTk=;
        b=Vh7vhpq7XNcoGMckf6J1DCu1yXJ+ZQ+sGL+0Fj1bh4bnPH6wW2iIaAzGovF64l3GH8
         qtqbpQGSOWhAjz4D6MsI7Yh/0YnNVhhihy3k2cG9jvYUlQm8P8gg6dqQNtMdlyKBUZnC
         olhzHIUvuvWdZU11UB6u97SNOuEsKufx23vII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729481461; x=1730086261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7fSPS1dvX+yf2Mp6aEWASzwZkZkFCgsunSKq6ktlTk=;
        b=XIJAnwYGyeshWclLqcT18zsduale+4o56TG4GScb5+bfrksnR6/OASdC/PQZt1tjCq
         wKndS3zJjwp7Y0eN7JEihFyiYQM6cUdI2QyXQyVG63UMtfukvOtQTcEbif+3nHvHnoo6
         pYKxYRHwziFwAHEKLPMxID2P0W+rrsbbcJa0A32rIWob0rlVPR/CT13IfP5NEhJCBTPa
         SgRpbtbqGprnlNk9OpE24cupBYCy9GeNIxi/U7Tbz0gAvnh3/Yb+3jy7HkkDtal6Pwws
         69n2GLgwHnx2/Ycrv4OuwuLtI39K09Q7qoJVtFxYINGZV2/Kxataz9hE4ZwDVS/q/gak
         XnBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfMqX+28YdX0OjcyoJ/JfTshgsPKMFmhJyFD/WcaMRBZy/TqiDiEoCALvwRTQTYldM6uXQkwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSHInQdiSJEdPvaqZBt1k9CVqlJWKGhSWCecXb8L1ZvZ46FT9j
	eOj5SJFuww8AmehUbvE/AHteU+RhQ69/gzB+wUvLTB+RXh/oFtPc2aBOGCFXiANFU0hGfUdKznr
	Dd6hR+UfBBvuJ+84gRl1qvNwuD45CJi/ufJiL
X-Google-Smtp-Source: AGHT+IHusIWrhxphMlh2pY5HTo0q3hBTPbtLQTXC0ep0t6OWGFC0G24tW69fhM7UDp4/o0q8sYnxOGw2ktM1q8ETZK8=
X-Received: by 2002:a05:6512:3d90:b0:539:e513:1f66 with SMTP id
 2adb3069b0e04-53a154f9114mr4725997e87.37.1729481461298; Sun, 20 Oct 2024
 20:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018203058.3641959-1-saikrishnag@marvell.com> <20241018203058.3641959-3-saikrishnag@marvell.com>
In-Reply-To: <20241018203058.3641959-3-saikrishnag@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 21 Oct 2024 09:00:49 +0530
Message-ID: <CAH-L+nMzLbRXbNeiQVYWRcCnvqAXs7S6wHp1JqOPMU==78rATA@mail.gmail.com>
Subject: Re: [net-next PATCH 2/6] octeontx2-af: CN20k basic mbox operations
 and structures
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sgoutham@marvell.com, gakula@marvell.com, lcherian@marvell.com, 
	jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002d24e90624f448de"

--0000000000002d24e90624f448de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 2:02=E2=80=AFAM Sai Krishna <saikrishnag@marvell.co=
m> wrote:
>
> This patch adds basic mbox operation APIs and structures to add support
> for mbox module on CN20k silicon. There are few CSR offsets, interrupts
> changed between CN20k and prior Octeon series of devices.
>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/af/Makefile    |  3 +-
>  .../ethernet/marvell/octeontx2/af/cn20k/api.h | 22 +++++++
>  .../marvell/octeontx2/af/cn20k/mbox_init.c    | 52 +++++++++++++++
>  .../ethernet/marvell/octeontx2/af/cn20k/reg.h | 27 ++++++++
>  .../net/ethernet/marvell/octeontx2/af/mbox.c  |  3 +
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |  7 ++
>  .../net/ethernet/marvell/octeontx2/af/rvu.c   | 65 +++++++++++++++----
>  .../net/ethernet/marvell/octeontx2/af/rvu.h   | 22 +++++++
>  .../marvell/octeontx2/af/rvu_struct.h         |  6 +-
>  9 files changed, 192 insertions(+), 15 deletions(-)
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_=
init.c
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/Makefile b/drivers=
/net/ethernet/marvell/octeontx2/af/Makefile
> index 3cf4c8285c90..38d8599dc6eb 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/Makefile
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
> @@ -11,4 +11,5 @@ rvu_mbox-y :=3D mbox.o rvu_trace.o
>  rvu_af-y :=3D cgx.o rvu.o rvu_cgx.o rvu_npa.o rvu_nix.o \
>                   rvu_reg.o rvu_npc.o rvu_debugfs.o ptp.o rvu_npc_fs.o \
>                   rvu_cpt.o rvu_devlink.o rpm.o rvu_cn10k.o rvu_switch.o =
\
> -                 rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb=
.o
> +                 rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb=
.o \
> +                 cn20k/mbox_init.o
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h b/driv=
ers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
> new file mode 100644
> index 000000000000..b57bd38181aa
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Marvell RVU Admin Function driver
> + *
> + * Copyright (C) 2024 Marvell.
> + *
> + */
> +
> +#ifndef CN20K_API_H
> +#define CN20K_API_H
> +
> +#include "../rvu.h"
> +
> +struct ng_rvu {
> +       struct mbox_ops         *rvu_mbox_ops;
> +       struct qmem             *pf_mbox_addr;
> +};
> +
> +/* Mbox related APIs */
> +int cn20k_rvu_mbox_init(struct rvu *rvu, int type, int num);
> +int cn20k_rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
> +                              int num, int type, unsigned long *pf_bmap)=
;
> +#endif /* CN20K_API_H */
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c =
b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
> new file mode 100644
> index 000000000000..0d7ad31e5dfb
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell RVU Admin Function driver
> + *
> + * Copyright (C) 2024 Marvell.
> + *
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +
> +#include "rvu_trace.h"
> +#include "mbox.h"
> +#include "reg.h"
> +#include "api.h"
> +
> +int cn20k_rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
> +                              int num, int type, unsigned long *pf_bmap)
> +{
> +       int region;
> +       u64 bar;
> +
> +       for (region =3D 0; region < num; region++) {
> +               if (!test_bit(region, pf_bmap))
> +                       continue;
> +
> +               bar =3D (u64)phys_to_virt((u64)rvu->ng_rvu->pf_mbox_addr-=
>base);
> +               bar +=3D region * MBOX_SIZE;
> +
> +               mbox_addr[region] =3D (void *)bar;
> +
> +               if (!mbox_addr[region])
> +                       goto error;
[Kalesh] Maybe you can return directly from here as there is no
cleanup action performed under the label.
> +       }
> +       return 0;
> +
> +error:
> +       return -ENOMEM;
> +}
> +
> +int cn20k_rvu_mbox_init(struct rvu *rvu, int type, int ndevs)
> +{
> +       int dev;
> +
> +       if (!is_cn20k(rvu->pdev))
> +               return 0;
> +
> +       for (dev =3D 0; dev < ndevs; dev++)
> +               rvu_write64(rvu, BLKADDR_RVUM,
> +                           RVU_MBOX_AF_PFX_CFG(dev), ilog2(MBOX_SIZE));
> +
> +       return 0;
> +}
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h b/driv=
ers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
> new file mode 100644
> index 000000000000..58152a4024ec
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Marvell RVU Admin Function driver
> + *
> + * Copyright (C) 2024 Marvell.
> + *
> + */
> +
> +#ifndef RVU_MBOX_REG_H
> +#define RVU_MBOX_REG_H
> +#include "../rvu.h"
> +#include "../rvu_reg.h"
> +
> +/* RVUM block registers */
> +#define RVU_PF_DISC                            (0x0)
> +#define RVU_PRIV_PFX_DISC(a)                   (0x8000208 | (a) << 16)
> +#define RVU_PRIV_HWVFX_DISC(a)                 (0xD000000 | (a) << 12)
> +
> +/* Mbox Registers */
> +/* RVU AF BAR0 Mbox registers for AF =3D> PFx */
> +#define RVU_MBOX_AF_PFX_ADDR(a)                        (0x5000 | (a) << =
4)
> +#define RVU_MBOX_AF_PFX_CFG(a)                 (0x6000 | (a) << 4)
> +#define RVU_AF_BAR2_SEL                                (0x9000000)
> +#define RVU_AF_BAR2_PFID                       (0x16400)
> +#define NIX_CINTX_INT_W1S(a)                   (0xd30 | (a) << 12)
> +#define NIX_QINTX_CNT(a)                       (0xc00 | (a) << 12)
> +
> +#endif /* RVU_MBOX_REG_H */
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/n=
et/ethernet/marvell/octeontx2/af/mbox.c
> index 791c468a10c5..1e3e72107a9d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
> @@ -10,8 +10,11 @@
>  #include <linux/pci.h>
>
>  #include "rvu_reg.h"
> +#include "cn20k/reg.h"
> +#include "cn20k/api.h"
>  #include "mbox.h"
>  #include "rvu_trace.h"
> +#include "rvu.h"
>
>  /* Default values of PF and VF bit encodings in PCIFUNC for
>   * CN9XXX and CN10K series silicons.
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/n=
et/ethernet/marvell/octeontx2/af/mbox.h
> index 38a0badcdb68..df64a18fe1d6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -55,6 +55,11 @@ extern u16 rvu_pcifunc_pf_mask;
>  extern u16 rvu_pcifunc_func_shift;
>  extern u16 rvu_pcifunc_func_mask;
>
> +enum {
> +       TYPE_AFVF,
> +       TYPE_AFPF,
> +};
> +
>  struct otx2_mbox_dev {
>         void        *mbase;   /* This dev's mbox region */
>         void        *hwbase;
> @@ -83,6 +88,8 @@ struct otx2_mbox {
>  struct mbox_hdr {
>         u64 msg_size;   /* Total msgs size embedded */
>         u16  num_msgs;   /* No of msgs embedded */
> +       u16 opt_msg;
> +       u8 sig;
>  };
>
>  /* Header which precedes every msg and is also part of it */
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/ne=
t/ethernet/marvell/octeontx2/af/rvu.c
> index dcfc27a60b43..a5ebd7cd3a5c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> @@ -20,6 +20,8 @@
>
>  #include "rvu_trace.h"
>  #include "rvu_npc_hash.h"
> +#include "cn20k/reg.h"
> +#include "cn20k/api.h"
>
>  #define DRV_NAME       "rvu_af"
>  #define DRV_STRING      "Marvell OcteonTX2 RVU Admin Function Driver"
> @@ -34,10 +36,8 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_=
wq_info *mw,
>                          int type, int num,
>                          void (mbox_handler)(struct work_struct *),
>                          void (mbox_up_handler)(struct work_struct *));
> -enum {
> -       TYPE_AFVF,
> -       TYPE_AFPF,
> -};
> +static irqreturn_t rvu_mbox_pf_intr_handler(int irq, void *rvu_irq);
> +static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq);
>
>  /* Supported devices */
>  static const struct pci_device_id rvu_id_table[] =3D {
> @@ -2212,6 +2212,22 @@ static void __rvu_mbox_handler(struct rvu_work *mw=
ork, int type, bool poll)
>
>         offset =3D mbox->rx_start + ALIGN(sizeof(*req_hdr), MBOX_MSG_ALIG=
N);
>
> +       if (req_hdr->sig) {
> +               req_hdr->opt_msg =3D mw->mbox_wrk[devid].num_msgs;
> +               rvu_write64(rvu, BLKADDR_NIX0, RVU_AF_BAR2_SEL,
> +                           RVU_AF_BAR2_PFID);
> +               if (type =3D=3D TYPE_AFPF)
> +                       rvu_write64(rvu, BLKADDR_NIX0,
> +                                   AF_BAR2_ALIASX(0, NIX_CINTX_INT_W1S(d=
evid)),
> +                                   0x1);
> +               else
> +                       rvu_write64(rvu, BLKADDR_NIX0,
> +                                   AF_BAR2_ALIASX(0, NIX_QINTX_CNT(devid=
)),
> +                                   0x1);
> +               usleep_range(1000, 2000);
> +               goto done;
> +       }
> +
>         for (id =3D 0; id < mw->mbox_wrk[devid].num_msgs; id++) {
>                 msg =3D mdev->mbase + offset;
>
> @@ -2245,9 +2261,10 @@ static void __rvu_mbox_handler(struct rvu_work *mw=
ork, int type, bool poll)
>                                  err, otx2_mbox_id2name(msg->id),
>                                  msg->id, devid);
>         }
> +done:
>         mw->mbox_wrk[devid].num_msgs =3D 0;
>
> -       if (poll)
> +       if (!is_cn20k(mbox->pdev) && poll)
>                 otx2_mbox_wait_for_zero(mbox, devid);
>
>         /* Send mbox responses to VF/PF */
> @@ -2360,6 +2377,10 @@ static int rvu_get_mbox_regions(struct rvu *rvu, v=
oid **mbox_addr,
>         int region;
>         u64 bar4;
>
> +       if (is_cn20k(rvu->pdev))
> +               return cn20k_rvu_get_mbox_regions(rvu, mbox_addr,
> +                                                 num, type, pf_bmap);
> +
>         /* For cn10k platform VF mailbox regions of a PF follows after th=
e
>          * PF <-> AF mailbox region. Whereas for Octeontx2 it is read fro=
m
>          * RVU_PF_VF_BAR4_ADDR register.
> @@ -2413,12 +2434,17 @@ static int rvu_get_mbox_regions(struct rvu *rvu, =
void **mbox_addr,
>         return -ENOMEM;
>  }
>
> +static struct mbox_ops rvu_mbox_ops =3D {
> +       .pf_intr_handler =3D rvu_mbox_pf_intr_handler,
> +};
> +
>  static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
>                          int type, int num,
>                          void (mbox_handler)(struct work_struct *),
>                          void (mbox_up_handler)(struct work_struct *))
>  {
>         int err =3D -EINVAL, i, dir, dir_up;
> +       struct ng_rvu *ng_rvu_mbox;
>         void __iomem *reg_base;
>         struct rvu_work *mwork;
>         unsigned long *pf_bmap;
> @@ -2443,6 +2469,18 @@ static int rvu_mbox_init(struct rvu *rvu, struct m=
box_wq_info *mw,
>                 }
>         }
>
> +       ng_rvu_mbox =3D kzalloc(sizeof(*ng_rvu_mbox), GFP_KERNEL);
> +       if (!ng_rvu_mbox) {
> +               err =3D -ENOMEM;
> +               goto free_bitmap;
> +       }
> +
> +       rvu->ng_rvu =3D ng_rvu_mbox;
> +
> +       rvu->ng_rvu->rvu_mbox_ops =3D &rvu_mbox_ops;
> +
> +       cn20k_rvu_mbox_init(rvu, type, num);
> +
>         mutex_init(&rvu->mbox_lock);
>
>         mbox_regions =3D kcalloc(num, sizeof(void *), GFP_KERNEL);
> @@ -2475,7 +2513,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mb=
ox_wq_info *mw,
>         }
>
>         mw->mbox_wq =3D alloc_workqueue("%s",
> -                                     WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RE=
CLAIM,
> +                                     WQ_HIGHPRI | WQ_MEM_RECLAIM,
>                                       num, name);
>         if (!mw->mbox_wq) {
>                 err =3D -ENOMEM;
> @@ -2553,8 +2591,8 @@ static void rvu_mbox_destroy(struct mbox_wq_info *m=
w)
>         otx2_mbox_destroy(&mw->mbox_up);
>  }
>
> -static void rvu_queue_work(struct mbox_wq_info *mw, int first,
> -                          int mdevs, u64 intr)
> +void rvu_queue_work(struct mbox_wq_info *mw, int first,
> +                   int mdevs, u64 intr)
>  {
>         struct otx2_mbox_dev *mdev;
>         struct otx2_mbox *mbox;
> @@ -2965,12 +3003,14 @@ static int rvu_register_interrupts(struct rvu *rv=
u)
>
>         /* Register mailbox interrupt handler */
>         sprintf(&rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], "RVUAF M=
box");
> -       ret =3D request_irq(pci_irq_vector(rvu->pdev, RVU_AF_INT_VEC_MBOX=
),
> -                         rvu_mbox_pf_intr_handler, 0,
> -                         &rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE]=
, rvu);
> +       ret =3D request_irq(pci_irq_vector
> +                         (rvu->pdev, RVU_AF_INT_VEC_MBOX),
> +                         rvu->ng_rvu->rvu_mbox_ops->pf_intr_handler, 0,
> +                         &rvu->irq_name[RVU_AF_INT_VEC_MBOX *
> +                         NAME_SIZE], rvu);
>         if (ret) {
>                 dev_err(rvu->dev,
> -                       "RVUAF: IRQ registration failed for mbox irq\n");
> +                       "RVUAF: IRQ registration failed for mbox\n");
>                 goto fail;
>         }
>
> @@ -3478,6 +3518,7 @@ static void rvu_remove(struct pci_dev *pdev)
>         pci_set_drvdata(pdev, NULL);
>
>         devm_kfree(&pdev->dev, rvu->hw);
> +       kfree(rvu->ng_rvu);
>         devm_kfree(&pdev->dev, rvu);
>  }
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/ne=
t/ethernet/marvell/octeontx2/af/rvu.h
> index 938a911cbf1c..9fd7aea8c481 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> @@ -444,6 +444,10 @@ struct mbox_wq_info {
>         struct workqueue_struct *mbox_wq;
>  };
>
> +struct mbox_ops {
> +       irqreturn_t (*pf_intr_handler)(int irq, void *rvu_irq);
> +};
> +
>  struct channel_fwdata {
>         struct sdp_node_info info;
>         u8 valid;
> @@ -594,6 +598,7 @@ struct rvu {
>         spinlock_t              cpt_intr_lock;
>
>         struct mutex            mbox_lock; /* Serialize mbox up and down =
msgs */
> +       struct ng_rvu           *ng_rvu;
>  };
>
>  static inline void rvu_write64(struct rvu *rvu, u64 block, u64 offset, u=
64 val)
> @@ -875,11 +880,28 @@ static inline bool is_cgx_vf(struct rvu *rvu, u16 p=
cifunc)
>                 is_pf_cgxmapped(rvu, rvu_get_pf(pcifunc)));
>  }
>
> +#define CN20K_CHIPID   0x20
> +
> +/*
> + * Silicon check for CN20K family
> + */
> +static inline bool is_cn20k(struct pci_dev *pdev)
> +{
> +       if ((pdev->subsystem_device & 0xFF) =3D=3D CN20K_CHIPID)
> +               return true;
> +
> +       return false;
[Kalesh] You can simplify this as:
return (pdev->subsystem_device & 0xFF) =3D=3D CN20K_CHIPID;
> +}
> +
>  #define M(_name, _id, fn_name, req, rsp)                               \
>  int rvu_mbox_handler_ ## fn_name(struct rvu *, struct req *, struct rsp =
*);
>  MBOX_MESSAGES
>  #undef M
>
> +/* Mbox APIs */
> +void rvu_queue_work(struct mbox_wq_info *mw, int first,
> +                   int mdevs, u64 intr);
> +
>  int rvu_cgx_init(struct rvu *rvu);
>  int rvu_cgx_exit(struct rvu *rvu);
>  void *rvu_cgx_pdata(u8 cgx_id, struct rvu *rvu);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/dri=
vers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
> index fc8da2090657..90cb063d00f0 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
> @@ -33,7 +33,8 @@ enum rvu_block_addr_e {
>         BLKADDR_NDC_NIX1_RX     =3D 0x10ULL,
>         BLKADDR_NDC_NIX1_TX     =3D 0x11ULL,
>         BLKADDR_APR             =3D 0x16ULL,
> -       BLK_COUNT               =3D 0x17ULL,
> +       BLKADDR_MBOX            =3D 0x1bULL,
> +       BLK_COUNT               =3D 0x1cULL,
>  };
>
>  /* RVU Block Type Enumeration */
> @@ -49,7 +50,8 @@ enum rvu_block_type_e {
>         BLKTYPE_TIM  =3D 0x8,
>         BLKTYPE_CPT  =3D 0x9,
>         BLKTYPE_NDC  =3D 0xa,
> -       BLKTYPE_MAX  =3D 0xa,
> +       BLKTYPE_MBOX =3D 0x13,
> +       BLKTYPE_MAX  =3D 0x13,
>  };
>
>  /* RVU Admin function Interrupt Vector Enumeration */
> --
> 2.25.1
>
>


--=20
Regards,
Kalesh A P

--0000000000002d24e90624f448de
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQiwYJKoZIhvcNAQcCoIIQfDCCEHgCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3iMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
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
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEILprROFsIcu2hBfAEf9spHprRyoEM46XzQoX0qFCq6lZMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAyMTAzMzEwMVowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC9gPkqE5Nq
5cuM07YnDYQnMS5EbCf7fSjjksOgf4+IhdpjNzc1VxIyuXFzvhNEoN1dWvuycQiRGQKsuClAeSaZ
50ZFR3OtU/HQVtHM7cW1XVosd4hkbiIv/n+Qtgm3G/XAG4fUeN363/3w8lof1/07CBFX+40BYAUW
v3Ms9VHpmKwCjSmhBiWxM/Z74pLjRM/ze135hpf9iW/Y+xjbTZDEeTwLer4/WMCoJm7v6Grglcd2
JXmguKj7X4C0TcgIJtkspVw/Fadh1p3fQFCm70Klid82idhbkKuChupUt1xhYLjrgtDWuB/Bg7pr
mbFm1yjMkpKTvmh0L64KK506bhY6
--0000000000002d24e90624f448de--

