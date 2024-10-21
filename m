Return-Path: <netdev+bounces-137361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F00E99A5946
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 05:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72AD21F21F89
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 03:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20E51714B7;
	Mon, 21 Oct 2024 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NwdPVfoB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AB72C95
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729481931; cv=none; b=PtibUWWTnzAFqWoATQTdUNWXTlyEpCjI0Y0mjvRfEmQwv4CGER2HrLG/Ls8JOaf+GQZhM915b6sqtyt2a2luPeluxVozpOd50Kk8Hp1464ZBlAAn7VQF2Kq8cTqoHHwsB4KZ+OdyyycxiFF0cXMepFD7HkAHk+4YhUB9/ouo4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729481931; c=relaxed/simple;
	bh=UnJ8P5BlQ91tsCs15Zxre3GYhof6s75v9kVHS3SkpQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VC6+Q5Lc9HdZJXlDCNNHK4P4N0VkR7P+9weX5ev8GMbtNZ/WeYtg6WwVhmunLxe2Isw3D8331jNjH5TEoR3h+RmnB5IvNVJn9AfYOOBr4YN8M4UnR/esk5jUzQLx+tGoNjlYdrS63HK1M+75Ct5N9C6i93C2JCYC7gMhiMNK1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NwdPVfoB; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539eb97f26aso4352455e87.2
        for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 20:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729481927; x=1730086727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EUDY1+Tlh3SoKmYAhRAYT57+4q4iLl40VUrXgLPrnrw=;
        b=NwdPVfoBKyujgYt6Lp3DnIBOROXbQqxafUFLmGjtM359GaBAMVRyCg5jE0M8DtyLEC
         pW7kP0wJo1NP0iQl1SIMPTqNGrH7P8polpSGAJyat9aiHJp1ybKa+Lr0xT9y84M0BPom
         W6pW2PuxrE2rnCmKwKEEzmwONW1aObQ5pCyYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729481927; x=1730086727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUDY1+Tlh3SoKmYAhRAYT57+4q4iLl40VUrXgLPrnrw=;
        b=vsitSVqGEypDwdYphcgBAcM57AnU9bX2K0xas2Hg3SICRqS4NMs8+cWM/59rUBfT19
         A8pheMNLtd6QKil0rJuWdaxnMHnmZlJbMaLHPRqvabXuyZ/cFYxRuTU2aMt7l3CkFosi
         bj6VcE/e71H9KDCfAAXDs1fvIVIUeXQmpzIRF7EdZbg1WTS8Mwnu3di9SRsSzyQQVbiu
         0F/IiTIxS/L94/cGLmRT4Llz9BhE86dsrOEqI0WW7a4C8c7C+mA9oEGSXBTmLal8WkwM
         +8GF5BFv9jpYZ53jbZOSzUIAN1poRS8hsr2pL2L/yzKO35M7PfaSKrTUgMCLVcm2LCAe
         EF7g==
X-Forwarded-Encrypted: i=1; AJvYcCVVybviD53lGwoItJS73e6AiS9yDxjKQGgNz5gm1vnHLz7T2+PvMgc8bjwLFf2g7+r/NIC9S+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQesvE0ciWxr3UBl9UKYvd9ztrzrps4D/Y9YVq3qlFXPToju2F
	mfj0+8B/h4P9gyUuQGeC8ffeqGSPtCVdZ9hgwEryzAf3MC/xCy/0kSDV54Low0+T2zbxpywdkJ2
	65P5ujN23NAO7Yao1QnZwEQs5n/ABcvftDSYf
X-Google-Smtp-Source: AGHT+IEkDqCuOIw2iQj9aTxF7tpeJSNOBSsh0t3TUASuGO+kYneRUhHxWoM0TgJRlDliv+ZBCDpT4FSybC5t4Sc4bS8=
X-Received: by 2002:a05:6512:130b:b0:539:edc9:e81b with SMTP id
 2adb3069b0e04-53a15229cd2mr4564190e87.28.1729481926615; Sun, 20 Oct 2024
 20:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018203058.3641959-1-saikrishnag@marvell.com> <20241018203058.3641959-5-saikrishnag@marvell.com>
In-Reply-To: <20241018203058.3641959-5-saikrishnag@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 21 Oct 2024 09:08:35 +0530
Message-ID: <CAH-L+nNF_pheu9+HtNNAfP0WFQmJpeMeQueYj7JCrOCk9bpPcw@mail.gmail.com>
Subject: Re: [net-next PATCH 4/6] octeontx2-pf: CN20K mbox REQ/ACK
 implementation for NIC PF
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sgoutham@marvell.com, gakula@marvell.com, lcherian@marvell.com, 
	jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ea47770624f463a6"

--000000000000ea47770624f463a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 2:03=E2=80=AFAM Sai Krishna <saikrishnag@marvell.co=
m> wrote:
>
> This implementation uses separate trigger interrupts for request,
> response messages against using trigger message data in CN10K.
> This patch adds support for basic mbox implementation for CN20K
> from NIC PF side.
>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> ---
>  .../marvell/octeontx2/af/cn20k/struct.h       | 15 ++++
>  .../ethernet/marvell/octeontx2/nic/Makefile   |  2 +-
>  .../ethernet/marvell/octeontx2/nic/cn10k.c    | 18 ++++-
>  .../ethernet/marvell/octeontx2/nic/cn10k.h    |  1 +
>  .../ethernet/marvell/octeontx2/nic/cn20k.c    | 65 +++++++++++++++
>  .../ethernet/marvell/octeontx2/nic/cn20k.h    | 14 ++++
>  .../marvell/octeontx2/nic/otx2_common.h       |  5 ++
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 80 +++++++++++++++----
>  .../ethernet/marvell/octeontx2/nic/otx2_reg.h |  4 +
>  .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  6 ++
>  10 files changed, 188 insertions(+), 22 deletions(-)
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h b/d=
rivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
> index fccad6e422e8..055ccc8c4689 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
> @@ -8,6 +8,21 @@
>  #ifndef STRUCT_H
>  #define STRUCT_H
>
> +/**
> + * CN20k RVU PF MBOX Interrupt Vector Enumeration
> + *
> + * Vectors 0 - 3 are compatible with pre cn20k and hence
> + * existing macros are being reused.
> + */
> +enum rvu_mbox_pf_int_vec_e {
> +       RVU_MBOX_PF_INT_VEC_VFPF_MBOX0  =3D 0x4,
> +       RVU_MBOX_PF_INT_VEC_VFPF_MBOX1  =3D 0x5,
> +       RVU_MBOX_PF_INT_VEC_VFPF1_MBOX0 =3D 0x6,
> +       RVU_MBOX_PF_INT_VEC_VFPF1_MBOX1 =3D 0x7,
> +       RVU_MBOX_PF_INT_VEC_AFPF_MBOX   =3D 0x8,
> +       RVU_MBOX_PF_INT_VEC_CNT         =3D 0x9,
> +};
> +
>  /* RVU Admin function Interrupt Vector Enumeration */
>  enum rvu_af_cn20k_int_vec_e {
>         RVU_AF_CN20K_INT_VEC_POISON             =3D 0x0,
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/driver=
s/net/ethernet/marvell/octeontx2/nic/Makefile
> index 64a97a0a10ed..1e2e838959f4 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
> @@ -7,7 +7,7 @@ obj-$(CONFIG_OCTEONTX2_PF) +=3D rvu_nicpf.o otx2_ptp.o
>  obj-$(CONFIG_OCTEONTX2_VF) +=3D rvu_nicvf.o otx2_ptp.o
>
>  rvu_nicpf-y :=3D otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
> -               otx2_flows.o otx2_tc.o cn10k.o otx2_dmac_flt.o \
> +               otx2_flows.o otx2_tc.o cn10k.o cn20k.o otx2_dmac_flt.o \
>                 otx2_devlink.o qos_sq.o qos.o
>  rvu_nicvf-y :=3D otx2_vf.o
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers=
/net/ethernet/marvell/octeontx2/nic/cn10k.c
> index c1c99d7054f8..52e0e036d00b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> @@ -14,6 +14,7 @@ static struct dev_hw_ops      otx2_hw_ops =3D {
>         .sqe_flush =3D otx2_sqe_flush,
>         .aura_freeptr =3D otx2_aura_freeptr,
>         .refill_pool_ptrs =3D otx2_refill_pool_ptrs,
> +       .pfaf_mbox_intr_handler =3D otx2_pfaf_mbox_intr_handler,
>  };
>
>  static struct dev_hw_ops cn10k_hw_ops =3D {
> @@ -21,8 +22,20 @@ static struct dev_hw_ops cn10k_hw_ops =3D {
>         .sqe_flush =3D cn10k_sqe_flush,
>         .aura_freeptr =3D cn10k_aura_freeptr,
>         .refill_pool_ptrs =3D cn10k_refill_pool_ptrs,
> +       .pfaf_mbox_intr_handler =3D otx2_pfaf_mbox_intr_handler,
>  };
>
> +void otx2_init_hw_ops(struct otx2_nic *pfvf)
> +{
> +       if (!test_bit(CN10K_LMTST, &pfvf->hw.cap_flag)) {
> +               pfvf->hw_ops =3D &otx2_hw_ops;
> +               return;
> +       }
> +
> +       pfvf->hw_ops =3D &cn10k_hw_ops;
> +}
> +EXPORT_SYMBOL(otx2_init_hw_ops);
> +
>  int cn10k_lmtst_init(struct otx2_nic *pfvf)
>  {
>
> @@ -30,12 +43,9 @@ int cn10k_lmtst_init(struct otx2_nic *pfvf)
>         struct otx2_lmt_info *lmt_info;
>         int err, cpu;
>
> -       if (!test_bit(CN10K_LMTST, &pfvf->hw.cap_flag)) {
> -               pfvf->hw_ops =3D &otx2_hw_ops;
> +       if (!test_bit(CN10K_LMTST, &pfvf->hw.cap_flag))
>                 return 0;
> -       }
>
> -       pfvf->hw_ops =3D &cn10k_hw_ops;
>         /* Total LMTLINES =3D num_online_cpus() * 32 (For Burst flush).*/
>         pfvf->tot_lmt_lines =3D (num_online_cpus() * LMT_BURST_SIZE);
>         pfvf->hw.lmt_info =3D alloc_percpu(struct otx2_lmt_info);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h b/drivers=
/net/ethernet/marvell/octeontx2/nic/cn10k.h
> index c1861f7de254..bb030816b523 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h
> @@ -39,4 +39,5 @@ int cn10k_alloc_leaf_profile(struct otx2_nic *pfvf, u16=
 *leaf);
>  int cn10k_set_ipolicer_rate(struct otx2_nic *pfvf, u16 profile,
>                             u32 burst, u64 rate, bool pps);
>  int cn10k_free_leaf_profile(struct otx2_nic *pfvf, u16 leaf);
> +void otx2_init_hw_ops(struct otx2_nic *pfvf);
>  #endif /* CN10K_H */
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers=
/net/ethernet/marvell/octeontx2/nic/cn20k.c
> new file mode 100644
> index 000000000000..44472a9f9a6e
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell RVU Ethernet driver
> + *
> + * Copyright (C) 2024 Marvell.
> + *
> + */
> +
> +#include "otx2_common.h"
> +#include "otx2_reg.h"
> +#include "otx2_struct.h"
> +#include "cn10k.h"
> +
> +static struct dev_hw_ops cn20k_hw_ops =3D {
> +       .pfaf_mbox_intr_handler =3D cn20k_pfaf_mbox_intr_handler,
> +};
> +
> +int cn20k_init(struct otx2_nic *pfvf)
[Kalesh] This function returns 0 unconditionally and the caller is not
checking the return value. You can change it to return void
> +{
> +       pfvf->hw_ops =3D &cn20k_hw_ops;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(cn20k_init);
> +/* CN20K mbox AF =3D> PFx irq handler */
> +irqreturn_t cn20k_pfaf_mbox_intr_handler(int irq, void *pf_irq)
> +{
> +       struct otx2_nic *pf =3D (struct otx2_nic *)pf_irq;
> +       struct mbox *mw =3D &pf->mbox;
> +       struct otx2_mbox_dev *mdev;
> +       struct otx2_mbox *mbox;
> +       struct mbox_hdr *hdr;
> +       int pf_trig_val;
> +
> +       pf_trig_val =3D otx2_read64(pf, RVU_PF_INT) & 0x3;
> +
> +       /* Clear the IRQ */
> +       otx2_write64(pf, RVU_PF_INT, pf_trig_val);
> +
> +       if (pf_trig_val & BIT_ULL(0)) {
> +               mbox =3D &mw->mbox_up;
> +               mdev =3D &mbox->dev[0];
> +               otx2_sync_mbox_bbuf(mbox, 0);
> +
> +               hdr =3D (struct mbox_hdr *)(mdev->mbase + mbox->rx_start)=
;
> +               if (hdr->num_msgs)
> +                       queue_work(pf->mbox_wq, &mw->mbox_up_wrk);
> +
> +               trace_otx2_msg_interrupt(pf->pdev, "UP message from AF to=
 PF",
> +                                        BIT_ULL(0));
> +       }
> +
> +       if (pf_trig_val & BIT_ULL(1)) {
> +               mbox =3D &mw->mbox;
> +               mdev =3D &mbox->dev[0];
> +               otx2_sync_mbox_bbuf(mbox, 0);
> +
> +               hdr =3D (struct mbox_hdr *)(mdev->mbase + mbox->rx_start)=
;
> +               if (hdr->num_msgs)
> +                       queue_work(pf->mbox_wq, &mw->mbox_wrk);
> +               trace_otx2_msg_interrupt(pf->pdev, "DOWN reply from AF to=
 PF",
> +                                        BIT_ULL(1));
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h b/drivers=
/net/ethernet/marvell/octeontx2/nic/cn20k.h
> new file mode 100644
> index 000000000000..da6210042c62
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Marvell RVU Ethernet driver
> + *
> + * Copyright (C) 2024 Marvell.
> + *
> + */
> +
> +#ifndef CN20K_H
> +#define CN20K_H
> +
> +#include "otx2_common.h"
> +
> +int cn20k_init(struct otx2_nic *pfvf);
> +#endif /* CN20K_H */
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index 8e7ed3979f80..d0320192e7a5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -30,6 +30,7 @@
>  #include <rvu.h>
>  #include <rvu_trace.h>
>  #include "qos.h"
> +#include "cn20k.h"
>
>  /* IPv4 flag more fragment bit */
>  #define IPV4_FLAG_MORE                         0x20
> @@ -53,6 +54,9 @@
>  #define NIX_PF_PFC_PRIO_MAX                    8
>  #endif
>
> +irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq);
> +irqreturn_t cn20k_pfaf_mbox_intr_handler(int irq, void *pf_irq);
> +
>  enum arua_mapped_qtypes {
>         AURA_NIX_RQ,
>         AURA_NIX_SQ,
> @@ -373,6 +377,7 @@ struct dev_hw_ops {
>                              int size, int qidx);
>         int     (*refill_pool_ptrs)(void *dev, struct otx2_cq_queue *cq);
>         void    (*aura_freeptr)(void *dev, int aura, u64 buf);
> +       irqreturn_t (*pfaf_mbox_intr_handler)(int irq, void *pf_irq);
>  };
>
>  #define CN10K_MCS_SA_PER_SC    4
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 5492dea547a1..c0cf228ac714 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -958,7 +958,7 @@ static void otx2_pfaf_mbox_up_handler(struct work_str=
uct *work)
>         otx2_mbox_msg_send(mbox, 0);
>  }
>
> -static irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq)
> +irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq)
>  {
>         struct otx2_nic *pf =3D (struct otx2_nic *)pf_irq;
>         struct mbox *mw =3D &pf->mbox;
> @@ -1010,10 +1010,18 @@ static irqreturn_t otx2_pfaf_mbox_intr_handler(in=
t irq, void *pf_irq)
>
>  static void otx2_disable_mbox_intr(struct otx2_nic *pf)
>  {
> -       int vector =3D pci_irq_vector(pf->pdev, RVU_PF_INT_VEC_AFPF_MBOX)=
;
> +       int vector;
>
>         /* Disable AF =3D> PF mailbox IRQ */
> -       otx2_write64(pf, RVU_PF_INT_ENA_W1C, BIT_ULL(0));
> +       if (!is_cn20k(pf->pdev)) {
> +               vector =3D pci_irq_vector(pf->pdev, RVU_PF_INT_VEC_AFPF_M=
BOX);
> +               otx2_write64(pf, RVU_PF_INT_ENA_W1C, BIT_ULL(0));
> +       } else {
> +               vector =3D pci_irq_vector(pf->pdev,
> +                                       RVU_MBOX_PF_INT_VEC_AFPF_MBOX);
> +               otx2_write64(pf, RVU_PF_INT_ENA_W1C,
> +                            BIT_ULL(0) | BIT_ULL(1));
> +       }
>         free_irq(vector, pf);
>  }
>
> @@ -1025,10 +1033,24 @@ static int otx2_register_mbox_intr(struct otx2_ni=
c *pf, bool probe_af)
>         int err;
>
>         /* Register mailbox interrupt handler */
> -       irq_name =3D &hw->irq_name[RVU_PF_INT_VEC_AFPF_MBOX * NAME_SIZE];
> -       snprintf(irq_name, NAME_SIZE, "RVUPFAF Mbox");
> -       err =3D request_irq(pci_irq_vector(pf->pdev, RVU_PF_INT_VEC_AFPF_=
MBOX),
> -                         otx2_pfaf_mbox_intr_handler, 0, irq_name, pf);
> +       if (!is_cn20k(pf->pdev)) {
> +               irq_name =3D &hw->irq_name[RVU_PF_INT_VEC_AFPF_MBOX * NAM=
E_SIZE];
> +               snprintf(irq_name, NAME_SIZE, "RVUPF%d AFPF Mbox",
> +                        rvu_get_pf(pf->pcifunc));
> +               err =3D request_irq(pci_irq_vector
> +                                 (pf->pdev, RVU_PF_INT_VEC_AFPF_MBOX),
> +                                 pf->hw_ops->pfaf_mbox_intr_handler,
> +                                 0, irq_name, pf);
> +       } else {
> +               irq_name =3D &hw->irq_name[RVU_MBOX_PF_INT_VEC_AFPF_MBOX =
*
> +                                               NAME_SIZE];
> +               snprintf(irq_name, NAME_SIZE, "RVUPF%d AFPF Mbox",
> +                        rvu_get_pf(pf->pcifunc));
> +               err =3D request_irq(pci_irq_vector
> +                                 (pf->pdev, RVU_MBOX_PF_INT_VEC_AFPF_MBO=
X),
> +                                 pf->hw_ops->pfaf_mbox_intr_handler,
> +                                 0, irq_name, pf);
> +       }
>         if (err) {
>                 dev_err(pf->dev,
>                         "RVUPF: IRQ registration failed for PFAF mbox irq=
\n");
> @@ -1038,8 +1060,14 @@ static int otx2_register_mbox_intr(struct otx2_nic=
 *pf, bool probe_af)
>         /* Enable mailbox interrupt for msgs coming from AF.
>          * First clear to avoid spurious interrupts, if any.
>          */
> -       otx2_write64(pf, RVU_PF_INT, BIT_ULL(0));
> -       otx2_write64(pf, RVU_PF_INT_ENA_W1S, BIT_ULL(0));
> +       if (!is_cn20k(pf->pdev)) {
> +               otx2_write64(pf, RVU_PF_INT, BIT_ULL(0));
> +               otx2_write64(pf, RVU_PF_INT_ENA_W1S, BIT_ULL(0));
> +       } else {
> +               otx2_write64(pf, RVU_PF_INT, BIT_ULL(0) | BIT_ULL(1));
> +               otx2_write64(pf, RVU_PF_INT_ENA_W1S, BIT_ULL(0) |
> +                            BIT_ULL(1));
> +       }
>
>         if (!probe_af)
>                 return 0;
> @@ -1070,7 +1098,7 @@ static void otx2_pfaf_mbox_destroy(struct otx2_nic =
*pf)
>                 pf->mbox_wq =3D NULL;
>         }
>
> -       if (mbox->mbox.hwbase)
> +       if (mbox->mbox.hwbase && !is_cn20k(pf->pdev))
>                 iounmap((void __iomem *)mbox->mbox.hwbase);
>
>         otx2_mbox_destroy(&mbox->mbox);
> @@ -1089,12 +1117,20 @@ static int otx2_pfaf_mbox_init(struct otx2_nic *p=
f)
>         if (!pf->mbox_wq)
>                 return -ENOMEM;
>
> -       /* Mailbox is a reserved memory (in RAM) region shared between
> -        * admin function (i.e AF) and this PF, shouldn't be mapped as
> -        * device memory to allow unaligned accesses.
> +       /* For CN20K, AF allocates mbox memory in DRAM and writes PF
> +        * regions/offsets in RVU_MBOX_AF_PFX_ADDR, the RVU_PFX_FUNC_PFAF=
_MBOX
> +        * gives the aliased address to access AF/PF mailbox regions.
>          */
> -       hwbase =3D ioremap_wc(pci_resource_start(pf->pdev, PCI_MBOX_BAR_N=
UM),
> -                           MBOX_SIZE);
> +       if (is_cn20k(pf->pdev))
> +               hwbase =3D pf->reg_base + RVU_PFX_FUNC_PFAF_MBOX +
> +                       ((u64)BLKADDR_MBOX << RVU_FUNC_BLKADDR_SHIFT);
> +       else
> +               /* Mailbox is a reserved memory (in RAM) region shared be=
tween
> +                * admin function (i.e AF) and this PF, shouldn't be mapp=
ed as
> +                * device memory to allow unaligned accesses.
> +                */
> +               hwbase =3D ioremap_wc(pci_resource_start
> +                                   (pf->pdev, PCI_MBOX_BAR_NUM), MBOX_SI=
ZE);
>         if (!hwbase) {
>                 dev_err(pf->dev, "Unable to map PFAF mailbox region\n");
>                 err =3D -ENOMEM;
> @@ -2957,8 +2993,13 @@ static int otx2_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)
>         if (err)
>                 goto err_free_netdev;
>
> -       err =3D pci_alloc_irq_vectors(hw->pdev, RVU_PF_INT_VEC_CNT,
> -                                   RVU_PF_INT_VEC_CNT, PCI_IRQ_MSIX);
> +       if (!is_cn20k(pf->pdev))
> +               err =3D pci_alloc_irq_vectors(hw->pdev, RVU_PF_INT_VEC_CN=
T,
> +                                           RVU_PF_INT_VEC_CNT, PCI_IRQ_M=
SIX);
> +       else
> +               err =3D pci_alloc_irq_vectors(hw->pdev, RVU_MBOX_PF_INT_V=
EC_CNT,
> +                                           RVU_MBOX_PF_INT_VEC_CNT,
> +                                           PCI_IRQ_MSIX);
>         if (err < 0) {
>                 dev_err(dev, "%s: Failed to alloc %d IRQ vectors\n",
>                         __func__, num_vec);
> @@ -2967,6 +3008,11 @@ static int otx2_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)
>
>         otx2_setup_dev_hw_settings(pf);
>
> +       if (is_cn20k(pf->pdev))
> +               cn20k_init(pf);
> +       else
> +               otx2_init_hw_ops(pf);
> +
>         /* Init PF <=3D> AF mailbox stuff */
>         err =3D otx2_pfaf_mbox_init(pf);
>         if (err)
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h b/driv=
ers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
> index 858f084b9d47..901f8cf7f27a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
> @@ -58,6 +58,10 @@
>  #define        RVU_VF_MSIX_PBAX(a)                 (0xF0000 | (a) << 3)
>  #define RVU_VF_MBOX_REGION                  (0xC0000)
>
> +/* CN20K RVU_MBOX_E: RVU PF/VF MBOX Address Range Enumeration */
> +#define RVU_MBOX_AF_PFX_ADDR(a)             (0x5000 | (a) << 4)
> +#define RVU_PFX_FUNC_PFAF_MBOX             (0x80000)
> +
>  #define RVU_FUNC_BLKADDR_SHIFT         20
>  #define RVU_FUNC_BLKADDR_MASK          0x1FULL
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> index 99fcc5661674..76b97896ff1c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> @@ -616,6 +616,12 @@ static int otx2vf_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)
>         }
>
>         otx2_setup_dev_hw_settings(vf);
> +
> +       if (is_cn20k(vf->pdev))
> +               cn20k_init(vf);
> +       else
> +               otx2_init_hw_ops(vf);
> +
>         /* Init VF <=3D> PF mailbox stuff */
>         err =3D otx2vf_vfaf_mbox_init(vf);
>         if (err)
> --
> 2.25.1
>
>


--=20
Regards,
Kalesh A P

--000000000000ea47770624f463a6
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
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEID9ju7wPGGy9szKmZ8Qbtp0gITC419z3gilqRfQOPURjMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAyMTAzMzg0N1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAYJ9cY1+HX
Jn+AhpB4/IQOAe8uW7XHs6NgCJ9zaJ1KiqFsjHL5+NLZ+Tsj4FDszyak5CpAHsrO1MpPk0IOSjvO
kqHk6fxgAhjDFN8zsipYkRGvONsM2KrEBcfnkHnIYEJSy+7hMlmStgmWGzCgbBrpxBmM8cXXFIB2
Kvh2QPggIDHAt7j7uIWR+4gY/AOFGVo3dOW2l1EhzfkrScroWiLIS6edaLjC2SphLYRbM4U8naBJ
uvntiutRyI12weS5wZJ4N7+54XQid7JKRqpISh7c9Bec+zZ/js+XmTVolgrmGsvTurtEH/mFrhkP
T6bMieoFkUaT6HgiuU+tQ6eNkV5k
--000000000000ea47770624f463a6--

