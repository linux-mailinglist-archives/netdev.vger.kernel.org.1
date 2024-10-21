Return-Path: <netdev+bounces-137360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F05B9A5942
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 05:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594861C20D87
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 03:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AA21714B7;
	Mon, 21 Oct 2024 03:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h+6Fpnyc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286D91C32
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 03:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729481748; cv=none; b=KajAz04PyZtUttK+E+PrfDbqaDcbfQ+FjrvzNtWTKOupWFj+p3jEQcVZr1fD4C/Y5jnJMNCBOkm9fCR0A0SP+PkShqeUHqdIxHayXOe3myD0xvVHvrrlynYebpf/0XYNiif9ycRAhRUX/MeXLOTFgzG/XuzVpCGFGz6n7LdkIrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729481748; c=relaxed/simple;
	bh=q/bXllYKagUn1Ekbss+k4lZbGxgZcduG42IhS2nkrTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAzccFOrLGncuGgN4DCw++fuAk+lHh1f2dyzKz70XE/U8KhW13aLJSbMQYOUQMavomHukGrZkkPjFIzgxQ92ZM+nqJIgN3nqqYPCXjdV86CusmfCVGTpVVHISNiMldU65Yun5sSoQiCQPXUIM5tfjIXU+XoezWft5iM3MkBqwCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h+6Fpnyc; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539983beb19so4221632e87.3
        for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 20:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729481743; x=1730086543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b+GNH5FYJxVxmDVzUYAA7jXvNYZ+8J3oVpiKj/9Kkbg=;
        b=h+6FpnycbiLJkdzAsqK+r4DiVitd0NrqxFUspxEeXmc6WSp9U/JZIT7V0Y1XyTZQTe
         Tb281zojzsDaeKp9rrtHsrevp14Hw1SDrrMhRJhWkxiVopXPL1Dd0C7vtQbKglb3gdTT
         uVly+jbjqDp/WUV9O9kdbcugiE5M2aex3DNS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729481743; x=1730086543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+GNH5FYJxVxmDVzUYAA7jXvNYZ+8J3oVpiKj/9Kkbg=;
        b=ucSMPGdHwQqxo3pGAU1L95L1jTt8CQ4RgJBGqzTF06x0u2faBPDBYiNd+vXgkQ3MEU
         A8pna+x83I2r4Y7VKLjyiqdjSk7aLjKzjYJKOCR42c5ErfteLAKE+xmr/Jvr+2/NbL5R
         OtTxbdK+Zf2vge4ukQ0x4ss5XO9/Y9qT2RuMM+LJoSX2XxZP/CjUm8psZ8AFdzgyQsnM
         bTvoM4Uo5b6jBXbSig6a3NX9x5e4u96fKwSR2ZSUZtS5GU3Gcxmmg6PBaqOERLZJYtq8
         29cLVaimly01kDyGfaOwbGUHZ9MbEOodAmvdk+osZFHKuvaAzMmB8TtMp5URb6F6Hq7B
         XNVA==
X-Forwarded-Encrypted: i=1; AJvYcCVxjPoUG3JZN1QZV7c80CfFjI/Y8hgDALKmelVN+pohLAfLgV95JgY8Wmjy5SH9OIJeEtJH01Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT4+gIgtLcDSyLerPZVAN15gxwND8heFDWIY8EKpsDgTwxdM1N
	10sTa9aHN4fQBKHZr/nX92kGnQPT4iUUbQJemtMcFbh/DLCyK3/dMl5lGbDDUp398NgFCmb57q+
	mq77Q8Zp4M5tu/I3XYEWPaDVf+zoB8cnwnisa
X-Google-Smtp-Source: AGHT+IFOYOXKgD1AHcKZ51hWsF1PA9F6IrFoJuIa/XejstMHt0JtGGIJ4LSys/jxEv+b4gqJUUbEJY3tPx0d+wV89io=
X-Received: by 2002:a05:6512:280d:b0:53a:d8b:95c0 with SMTP id
 2adb3069b0e04-53a154a26ecmr4544130e87.30.1729481742930; Sun, 20 Oct 2024
 20:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018203058.3641959-1-saikrishnag@marvell.com> <20241018203058.3641959-4-saikrishnag@marvell.com>
In-Reply-To: <20241018203058.3641959-4-saikrishnag@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 21 Oct 2024 09:05:32 +0530
Message-ID: <CAH-L+nNCMPubP5LMG1aV_C8n9Uau8zMuFy_y504VL=Rcy9FG9w@mail.gmail.com>
Subject: Re: [net-next PATCH 3/6] octeontx2-af: CN20k mbox to support AF
 REQ/ACK functionality
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sgoutham@marvell.com, gakula@marvell.com, lcherian@marvell.com, 
	jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f8b1990624f458ea"

--000000000000f8b1990624f458ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 2:02=E2=80=AFAM Sai Krishna <saikrishnag@marvell.co=
m> wrote:
>
> This implementation uses separate trigger interrupts for request,
> response MBOX messages against using trigger message data in CN10K.
> This patch adds support for basic mbox implementation for CN20K
> from AF side.
>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/af/cn20k/api.h |   8 +
>  .../marvell/octeontx2/af/cn20k/mbox_init.c    | 214 ++++++++++++++++++
>  .../ethernet/marvell/octeontx2/af/cn20k/reg.h |  17 ++
>  .../marvell/octeontx2/af/cn20k/struct.h       |  25 ++
>  .../net/ethernet/marvell/octeontx2/af/mbox.c  |  77 ++++++-
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
>  .../net/ethernet/marvell/octeontx2/af/rvu.c   |  62 +++--
>  .../net/ethernet/marvell/octeontx2/af/rvu.h   |  16 +-
>  8 files changed, 401 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/struc=
t.h
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h b/driv=
ers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
> index b57bd38181aa..9436a4a4d815 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
> @@ -15,8 +15,16 @@ struct ng_rvu {
>         struct qmem             *pf_mbox_addr;
>  };
>
> +struct rvu;
> +
>  /* Mbox related APIs */
>  int cn20k_rvu_mbox_init(struct rvu *rvu, int type, int num);
> +int cn20k_register_afpf_mbox_intr(struct rvu *rvu);
>  int cn20k_rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
>                                int num, int type, unsigned long *pf_bmap)=
;
> +void cn20k_rvu_enable_mbox_intr(struct rvu *rvu);
> +void cn20k_rvu_unregister_interrupts(struct rvu *rvu);
> +void cn20k_free_mbox_memory(struct rvu *rvu);
> +int cn20k_mbox_setup(struct otx2_mbox *mbox, struct pci_dev *pdev,
> +                    void *reg_base, int direction, int ndevs);
>  #endif /* CN20K_API_H */
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c =
b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
> index 0d7ad31e5dfb..e19de47da84a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
> @@ -13,6 +13,137 @@
>  #include "reg.h"
>  #include "api.h"
>
> +/* CN20K mbox PFx =3D> AF irq handler */
> +static irqreturn_t cn20k_mbox_pf_common_intr_handler(int irq, void *rvu_=
irq)
> +{
> +       struct rvu_irq_data *rvu_irq_data =3D (struct rvu_irq_data *)rvu_=
irq;
> +       struct rvu *rvu =3D rvu_irq_data->rvu;
> +       u64 intr;
> +
> +       /* Clear interrupts */
> +       intr =3D rvu_read64(rvu, BLKADDR_RVUM, rvu_irq_data->intr_status)=
;
> +       rvu_write64(rvu, BLKADDR_RVUM, rvu_irq_data->intr_status, intr);
> +
> +       if (intr)
> +               trace_otx2_msg_interrupt(rvu->pdev, "PF(s) to AF", intr);
> +
> +       /* Sync with mbox memory region */
> +       rmb();
> +
> +       rvu_irq_data->rvu_queue_work_hdlr(&rvu->afpf_wq_info,
> +                                         rvu_irq_data->start,
> +                                         rvu_irq_data->mdevs, intr);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +void cn20k_rvu_enable_mbox_intr(struct rvu *rvu)
> +{
> +       struct rvu_hwinfo *hw =3D rvu->hw;
> +
> +       /* Clear spurious irqs, if any */
> +       rvu_write64(rvu, BLKADDR_RVUM,
> +                   RVU_MBOX_AF_PFAF_INT(0), INTR_MASK(hw->total_pfs));
> +
> +       rvu_write64(rvu, BLKADDR_RVUM,
> +                   RVU_MBOX_AF_PFAF_INT(1), INTR_MASK(hw->total_pfs - 64=
));
> +
> +       rvu_write64(rvu, BLKADDR_RVUM,
> +                   RVU_MBOX_AF_PFAF1_INT(0), INTR_MASK(hw->total_pfs));
> +
> +       rvu_write64(rvu, BLKADDR_RVUM,
> +                   RVU_MBOX_AF_PFAF1_INT(1), INTR_MASK(hw->total_pfs - 6=
4));
> +
> +       /* Enable mailbox interrupt for all PFs except PF0 i.e AF itself =
*/
> +       rvu_write64(rvu, BLKADDR_RVUM, RVU_MBOX_AF_PFAF_INT_ENA_W1S(0),
> +                   INTR_MASK(hw->total_pfs) & ~1ULL);
> +
> +       rvu_write64(rvu, BLKADDR_RVUM, RVU_MBOX_AF_PFAF_INT_ENA_W1S(1),
> +                   INTR_MASK(hw->total_pfs - 64));
> +
> +       rvu_write64(rvu, BLKADDR_RVUM, RVU_MBOX_AF_PFAF1_INT_ENA_W1S(0),
> +                   INTR_MASK(hw->total_pfs) & ~1ULL);
> +
> +       rvu_write64(rvu, BLKADDR_RVUM, RVU_MBOX_AF_PFAF1_INT_ENA_W1S(1),
> +                   INTR_MASK(hw->total_pfs - 64));
> +}
> +
> +void cn20k_rvu_unregister_interrupts(struct rvu *rvu)
> +{
> +       rvu_write64(rvu, BLKADDR_RVUM, RVU_MBOX_AF_PFAF_INT_ENA_W1C(0),
> +                   INTR_MASK(rvu->hw->total_pfs) & ~1ULL);
> +
> +       rvu_write64(rvu, BLKADDR_RVUM, RVU_MBOX_AF_PFAF_INT_ENA_W1C(1),
> +                   INTR_MASK(rvu->hw->total_pfs - 64));
> +
> +       rvu_write64(rvu, BLKADDR_RVUM, RVU_MBOX_AF_PFAF1_INT_ENA_W1C(0),
> +                   INTR_MASK(rvu->hw->total_pfs) & ~1ULL);
> +
> +       rvu_write64(rvu, BLKADDR_RVUM, RVU_MBOX_AF_PFAF1_INT_ENA_W1C(1),
> +                   INTR_MASK(rvu->hw->total_pfs - 64));
> +}
> +
> +int cn20k_register_afpf_mbox_intr(struct rvu *rvu)
> +{
> +       struct rvu_irq_data *irq_data;
> +       int intr_vec, ret, vec =3D 0;
> +
> +       /* irq data for 4 PF intr vectors */
> +       irq_data =3D devm_kcalloc(rvu->dev, 4,
> +                               sizeof(struct rvu_irq_data), GFP_KERNEL);
> +       if (!irq_data)
> +               return -ENOMEM;
> +
> +       for (intr_vec =3D RVU_AF_CN20K_INT_VEC_PFAF_MBOX0; intr_vec <=3D
> +                               RVU_AF_CN20K_INT_VEC_PFAF1_MBOX1; intr_ve=
c++,
> +                               vec++) {
> +               switch (intr_vec) {
> +               case RVU_AF_CN20K_INT_VEC_PFAF_MBOX0:
> +                       irq_data[vec].intr_status =3D
> +                                               RVU_MBOX_AF_PFAF_INT(0);
> +                       irq_data[vec].start =3D 0;
> +                       irq_data[vec].mdevs =3D 64;
> +                       break;
> +               case RVU_AF_CN20K_INT_VEC_PFAF_MBOX1:
> +                       irq_data[vec].intr_status =3D
> +                                               RVU_MBOX_AF_PFAF_INT(1);
> +                       irq_data[vec].start =3D 64;
> +                       irq_data[vec].mdevs =3D 96;
> +                       break;
> +               case RVU_AF_CN20K_INT_VEC_PFAF1_MBOX0:
> +                       irq_data[vec].intr_status =3D
> +                                               RVU_MBOX_AF_PFAF1_INT(0);
> +                       irq_data[vec].start =3D 0;
> +                       irq_data[vec].mdevs =3D 64;
> +                       break;
> +               case RVU_AF_CN20K_INT_VEC_PFAF1_MBOX1:
> +                       irq_data[vec].intr_status =3D
> +                                               RVU_MBOX_AF_PFAF1_INT(1);
> +                       irq_data[vec].start =3D 64;
> +                       irq_data[vec].mdevs =3D 96;
> +                       break;
> +               }
> +               irq_data[vec].rvu_queue_work_hdlr =3D rvu_queue_work;
> +               irq_data[vec].vec_num =3D intr_vec;
> +               irq_data[vec].rvu =3D rvu;
> +
> +               /* Register mailbox interrupt handler */
> +               sprintf(&rvu->irq_name[intr_vec * NAME_SIZE],
> +                       "RVUAF PFAF%d Mbox%d",
> +                       vec / 2, vec % 2);
> +               ret =3D request_irq(pci_irq_vector(rvu->pdev, intr_vec),
> +                                 rvu->ng_rvu->rvu_mbox_ops->pf_intr_hand=
ler, 0,
> +                                 &rvu->irq_name[intr_vec * NAME_SIZE],
> +                                 &irq_data[vec]);
> +               if (ret)
> +                       return ret;
> +
> +               rvu->irq_allocated[intr_vec] =3D true;
> +       }
> +
> +       return 0;
> +}
> +
>  int cn20k_rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
>                                int num, int type, unsigned long *pf_bmap)
>  {
> @@ -37,6 +168,50 @@ int cn20k_rvu_get_mbox_regions(struct rvu *rvu, void =
**mbox_addr,
>         return -ENOMEM;
>  }
>
> +static struct mbox_ops cn20k_mbox_ops =3D {
> +       .pf_intr_handler =3D cn20k_mbox_pf_common_intr_handler,
> +};
> +
> +static int rvu_alloc_mbox_memory(struct rvu *rvu, int type,
> +                                int ndevs, int mbox_size)
> +{
> +       struct qmem *mbox_addr;
> +       dma_addr_t iova;
> +       int pf, err;
> +
> +       /* Allocate contiguous memory for mailbox communication.
> +        * eg: AF <=3D> PFx mbox memory
> +        * This allocated memory is split into chunks of MBOX_SIZE
> +        * and setup into each of the RVU PFs. In HW this memory will
> +        * get aliased to an offset within BAR2 of those PFs.
> +        *
> +        * AF will access mbox memory using direct physical addresses
> +        * and PFs will access the same shared memory from BAR2.
> +        */
> +
> +       err =3D qmem_alloc(rvu->dev, &mbox_addr, ndevs, mbox_size);
> +       if (err) {
> +               dev_err(rvu->dev, "qmem alloc fail\n");
[Kalesh] I think you can drop the failure log message from here. I see
in other places there is no error log in case qmem_alloc fails
> +               return -ENOMEM;
> +       }
> +
> +       switch (type) {
> +       case TYPE_AFPF:
> +               rvu->ng_rvu->pf_mbox_addr =3D mbox_addr;
> +               iova =3D (u64)mbox_addr->iova;
> +               for (pf =3D 0; pf < ndevs; pf++) {
> +                       rvu_write64(rvu, BLKADDR_RVUM, RVU_MBOX_AF_PFX_AD=
DR(pf),
> +                                   (u64)iova);
> +                       iova +=3D mbox_size;
> +               }
> +               break;
> +       default:
> +               return 0;
> +       }
> +
> +       return 0;
> +}
> +
>  int cn20k_rvu_mbox_init(struct rvu *rvu, int type, int ndevs)
>  {
>         int dev;
> @@ -44,9 +219,48 @@ int cn20k_rvu_mbox_init(struct rvu *rvu, int type, in=
t ndevs)
>         if (!is_cn20k(rvu->pdev))
>                 return 0;
>
> +       rvu->ng_rvu->rvu_mbox_ops =3D &cn20k_mbox_ops;
> +
>         for (dev =3D 0; dev < ndevs; dev++)
>                 rvu_write64(rvu, BLKADDR_RVUM,
>                             RVU_MBOX_AF_PFX_CFG(dev), ilog2(MBOX_SIZE));
>
> +       return rvu_alloc_mbox_memory(rvu, type, ndevs, MBOX_SIZE);
> +}
> +
> +void cn20k_free_mbox_memory(struct rvu *rvu)
> +{
> +       qmem_free(rvu->dev, rvu->ng_rvu->pf_mbox_addr);
> +}
> +
> +int rvu_alloc_cint_qint_mem(struct rvu *rvu, struct rvu_pfvf *pfvf,
> +                           int blkaddr, int nixlf)
> +{
> +       int qints, hwctx_size, err;
> +       u64 cfg, ctx_cfg;
> +
> +       ctx_cfg =3D rvu_read64(rvu, blkaddr, NIX_AF_CONST3);
> +       /* Alloc memory for CQINT's HW contexts */
> +       cfg =3D rvu_read64(rvu, blkaddr, NIX_AF_CONST2);
> +       qints =3D (cfg >> 24) & 0xFFF;
> +       hwctx_size =3D 1UL << ((ctx_cfg >> 24) & 0xF);
> +       err =3D qmem_alloc(rvu->dev, &pfvf->cq_ints_ctx, qints, hwctx_siz=
e);
> +       if (err)
> +               return -ENOMEM;
> +
> +       rvu_write64(rvu, blkaddr, NIX_AF_LFX_CINTS_BASE(nixlf),
> +                   (u64)pfvf->cq_ints_ctx->iova);
> +
> +       /* Alloc memory for QINT's HW contexts */
> +       cfg =3D rvu_read64(rvu, blkaddr, NIX_AF_CONST2);
> +       qints =3D (cfg >> 12) & 0xFFF;
> +       hwctx_size =3D 1UL << ((ctx_cfg >> 20) & 0xF);
> +       err =3D qmem_alloc(rvu->dev, &pfvf->nix_qints_ctx, qints, hwctx_s=
ize);
> +       if (err)
> +               return -ENOMEM;
> +
> +       rvu_write64(rvu, blkaddr, NIX_AF_LFX_QINTS_BASE(nixlf),
> +                   (u64)pfvf->nix_qints_ctx->iova);
> +
>         return 0;
>  }
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h b/driv=
ers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
> index 58152a4024ec..df2d52567da7 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
> @@ -19,6 +19,23 @@
>  /* RVU AF BAR0 Mbox registers for AF =3D> PFx */
>  #define RVU_MBOX_AF_PFX_ADDR(a)                        (0x5000 | (a) << =
4)
>  #define RVU_MBOX_AF_PFX_CFG(a)                 (0x6000 | (a) << 4)
> +#define RVU_MBOX_AF_AFPFX_TRIGX(a)             (0x9000 | (a) << 3)
> +#define RVU_MBOX_AF_PFAF_INT(a)                        (0x2980 | (a) << =
6)
> +#define RVU_MBOX_AF_PFAF_INT_W1S(a)            (0x2988 | (a) << 6)
> +#define RVU_MBOX_AF_PFAF_INT_ENA_W1S(a)                (0x2990 | (a) << =
6)
> +#define RVU_MBOX_AF_PFAF_INT_ENA_W1C(a)                (0x2998 | (a) << =
6)
> +#define RVU_MBOX_AF_PFAF1_INT(a)               (0x29A0 | (a) << 6)
> +#define RVU_MBOX_AF_PFAF1_INT_W1S(a)           (0x29A8 | (a) << 6)
> +#define RVU_MBOX_AF_PFAF1_INT_ENA_W1S(a)       (0x29B0 | (a) << 6)
> +#define RVU_MBOX_AF_PFAF1_INT_ENA_W1C(a)       (0x29B8 | (a) << 6)
> +
> +/* RVU PF =3D> AF mbox registers */
> +#define RVU_MBOX_PF_PFAF_TRIGX(a)              (0xC00 | (a) << 3)
> +#define RVU_MBOX_PF_INT                                (0xC20)
> +#define RVU_MBOX_PF_INT_W1S                    (0xC28)
> +#define RVU_MBOX_PF_INT_ENA_W1S                        (0xC30)
> +#define RVU_MBOX_PF_INT_ENA_W1C                        (0xC38)
> +
>  #define RVU_AF_BAR2_SEL                                (0x9000000)
>  #define RVU_AF_BAR2_PFID                       (0x16400)
>  #define NIX_CINTX_INT_W1S(a)                   (0xd30 | (a) << 12)
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h b/d=
rivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
> new file mode 100644
> index 000000000000..fccad6e422e8
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Marvell RVU Admin Function driver
> + *
> + * Copyright (C) 2024 Marvell.
> + *
> + */
> +
> +#ifndef STRUCT_H
> +#define STRUCT_H
> +
> +/* RVU Admin function Interrupt Vector Enumeration */
> +enum rvu_af_cn20k_int_vec_e {
> +       RVU_AF_CN20K_INT_VEC_POISON             =3D 0x0,
> +       RVU_AF_CN20K_INT_VEC_PFFLR0             =3D 0x1,
> +       RVU_AF_CN20K_INT_VEC_PFFLR1             =3D 0x2,
> +       RVU_AF_CN20K_INT_VEC_PFME0              =3D 0x3,
> +       RVU_AF_CN20K_INT_VEC_PFME1              =3D 0x4,
> +       RVU_AF_CN20K_INT_VEC_GEN                =3D 0x5,
> +       RVU_AF_CN20K_INT_VEC_PFAF_MBOX0         =3D 0x6,
> +       RVU_AF_CN20K_INT_VEC_PFAF_MBOX1         =3D 0x7,
> +       RVU_AF_CN20K_INT_VEC_PFAF1_MBOX0        =3D 0x8,
> +       RVU_AF_CN20K_INT_VEC_PFAF1_MBOX1        =3D 0x9,
> +       RVU_AF_CN20K_INT_VEC_CNT                =3D 0xa,
> +};
> +#endif
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/n=
et/ethernet/marvell/octeontx2/af/mbox.c
> index 1e3e72107a9d..15aaa5e166e4 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
> @@ -46,8 +46,10 @@ void __otx2_mbox_reset(struct otx2_mbox *mbox, int dev=
id)
>         mdev->rsp_size =3D 0;
>         tx_hdr->num_msgs =3D 0;
>         tx_hdr->msg_size =3D 0;
> +       tx_hdr->sig =3D 0;
>         rx_hdr->num_msgs =3D 0;
>         rx_hdr->msg_size =3D 0;
> +       rx_hdr->sig =3D 0;
>  }
>  EXPORT_SYMBOL(__otx2_mbox_reset);
>
> @@ -71,9 +73,78 @@ void otx2_mbox_destroy(struct otx2_mbox *mbox)
>  }
>  EXPORT_SYMBOL(otx2_mbox_destroy);
>
> +int cn20k_mbox_setup(struct otx2_mbox *mbox, struct pci_dev *pdev,
> +                    void *reg_base, int direction, int ndevs)
> +{
> +       switch (direction) {
> +       case MBOX_DIR_AFPF:
> +               mbox->tx_start =3D MBOX_DOWN_TX_START;
> +               mbox->rx_start =3D MBOX_DOWN_RX_START;
> +               mbox->tx_size  =3D MBOX_DOWN_TX_SIZE;
> +               mbox->rx_size  =3D MBOX_DOWN_RX_SIZE;
> +               break;
> +       case MBOX_DIR_PFAF:
> +               mbox->tx_start =3D MBOX_DOWN_RX_START;
> +               mbox->rx_start =3D MBOX_DOWN_TX_START;
> +               mbox->tx_size  =3D MBOX_DOWN_RX_SIZE;
> +               mbox->rx_size  =3D MBOX_DOWN_TX_SIZE;
> +               break;
> +       case MBOX_DIR_AFPF_UP:
> +               mbox->tx_start =3D MBOX_UP_TX_START;
> +               mbox->rx_start =3D MBOX_UP_RX_START;
> +               mbox->tx_size  =3D MBOX_UP_TX_SIZE;
> +               mbox->rx_size  =3D MBOX_UP_RX_SIZE;
> +               break;
> +       case MBOX_DIR_PFAF_UP:
> +               mbox->tx_start =3D MBOX_UP_RX_START;
> +               mbox->rx_start =3D MBOX_UP_TX_START;
> +               mbox->tx_size  =3D MBOX_UP_RX_SIZE;
> +               mbox->rx_size  =3D MBOX_UP_TX_SIZE;
> +               break;
> +       default:
> +               return -ENODEV;
> +       }
> +
> +       switch (direction) {
> +       case MBOX_DIR_AFPF:
> +               mbox->trigger =3D RVU_MBOX_AF_AFPFX_TRIGX(1);
> +               mbox->tr_shift =3D 4;
> +               break;
> +       case MBOX_DIR_AFPF_UP:
> +               mbox->trigger =3D RVU_MBOX_AF_AFPFX_TRIGX(0);
> +               mbox->tr_shift =3D 4;
> +               break;
> +       case MBOX_DIR_PFAF:
> +               mbox->trigger =3D RVU_MBOX_PF_PFAF_TRIGX(0);
> +               mbox->tr_shift =3D 0;
> +               break;
> +       case MBOX_DIR_PFAF_UP:
> +               mbox->trigger =3D RVU_MBOX_PF_PFAF_TRIGX(1);
> +               mbox->tr_shift =3D 0;
> +               break;
> +       default:
> +               return -ENODEV;
> +       }
> +       mbox->reg_base =3D reg_base;
> +       mbox->pdev =3D pdev;
> +
> +       mbox->dev =3D kcalloc(ndevs, sizeof(struct otx2_mbox_dev), GFP_KE=
RNEL);
> +       if (!mbox->dev) {
> +               otx2_mbox_destroy(mbox);
> +               return -ENOMEM;
> +       }
> +       mbox->ndevs =3D ndevs;
> +
> +       return 0;
> +}
> +
>  static int otx2_mbox_setup(struct otx2_mbox *mbox, struct pci_dev *pdev,
>                            void *reg_base, int direction, int ndevs)
>  {
> +       if (is_cn20k(pdev))
> +               return cn20k_mbox_setup(mbox, pdev, reg_base,
> +                                                       direction, ndevs)=
;
> +
>         switch (direction) {
>         case MBOX_DIR_AFPF:
>         case MBOX_DIR_PFVF:
> @@ -252,7 +323,10 @@ static void otx2_mbox_msg_send_data(struct otx2_mbox=
 *mbox, int devid, u64 data)
>
>         spin_lock(&mdev->mbox_lock);
>
> -       tx_hdr->msg_size =3D mdev->msg_size;
> +       if (!tx_hdr->sig) {
> +               tx_hdr->msg_size =3D mdev->msg_size;
> +               tx_hdr->num_msgs =3D mdev->num_msgs;
> +       }
>
>         /* Reset header for next messages */
>         mdev->msg_size =3D 0;
> @@ -266,7 +340,6 @@ static void otx2_mbox_msg_send_data(struct otx2_mbox =
*mbox, int devid, u64 data)
>          * messages.  So this should be written after writing all the mes=
sages
>          * to the shared memory.
>          */
> -       tx_hdr->num_msgs =3D mdev->num_msgs;
>         rx_hdr->num_msgs =3D 0;
>
>         trace_otx2_msg_send(mbox->pdev, tx_hdr->num_msgs, tx_hdr->msg_siz=
e);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/n=
et/ethernet/marvell/octeontx2/af/mbox.h
> index df64a18fe1d6..86d07fc4a7ff 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -13,6 +13,7 @@
>
>  #include "rvu_struct.h"
>  #include "common.h"
> +#include "cn20k/struct.h"
>
>  #define MBOX_SIZE              SZ_64K
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/ne=
t/ethernet/marvell/octeontx2/af/rvu.c
> index a5ebd7cd3a5c..e49f9bc7ebda 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> @@ -755,6 +755,13 @@ static void rvu_free_hw_resources(struct rvu *rvu)
>
>         rvu_reset_msix(rvu);
>         mutex_destroy(&rvu->rsrc_lock);
> +
> +       /* Free the QINT/CINt memory */
> +       pfvf =3D &rvu->pf[RVU_AFPF];
> +       if (pfvf->nix_qints_ctx)
[Kalesh] This NULL check is not needed as qmem_free() already has as
check inside that
> +               qmem_free(rvu->dev, pfvf->nix_qints_ctx);
> +       if (pfvf->cq_ints_ctx)
[Kalesh] same comment as above
> +               qmem_free(rvu->dev, pfvf->cq_ints_ctx);
>  }
>
>  static void rvu_setup_pfvf_macaddress(struct rvu *rvu)
> @@ -2683,6 +2690,11 @@ static void rvu_enable_mbox_intr(struct rvu *rvu)
>  {
>         struct rvu_hwinfo *hw =3D rvu->hw;
>
> +       if (is_cn20k(rvu->pdev)) {
> +               cn20k_rvu_enable_mbox_intr(rvu);
> +               return;
> +       }
> +
>         /* Clear spurious irqs, if any */
>         rvu_write64(rvu, BLKADDR_RVUM,
>                     RVU_AF_PFAF_MBOX_INT, INTR_MASK(hw->total_pfs));
> @@ -2936,9 +2948,12 @@ static void rvu_unregister_interrupts(struct rvu *=
rvu)
>
>         rvu_cpt_unregister_interrupts(rvu);
>
> -       /* Disable the Mbox interrupt */
> -       rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_PFAF_MBOX_INT_ENA_W1C,
> -                   INTR_MASK(rvu->hw->total_pfs) & ~1ULL);
> +       if (!is_cn20k(rvu->pdev))
> +               /* Disable the Mbox interrupt */
> +               rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_PFAF_MBOX_INT_ENA_W=
1C,
> +                           INTR_MASK(rvu->hw->total_pfs) & ~1ULL);
> +       else
> +               cn20k_rvu_unregister_interrupts(rvu);
>
>         /* Disable the PF FLR interrupt */
>         rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_PFFLR_INT_ENA_W1C,
> @@ -3001,20 +3016,30 @@ static int rvu_register_interrupts(struct rvu *rv=
u)
>                 return ret;
>         }
>
> -       /* Register mailbox interrupt handler */
> -       sprintf(&rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], "RVUAF M=
box");
> -       ret =3D request_irq(pci_irq_vector
> -                         (rvu->pdev, RVU_AF_INT_VEC_MBOX),
> -                         rvu->ng_rvu->rvu_mbox_ops->pf_intr_handler, 0,
> -                         &rvu->irq_name[RVU_AF_INT_VEC_MBOX *
> -                         NAME_SIZE], rvu);
> -       if (ret) {
> -               dev_err(rvu->dev,
> -                       "RVUAF: IRQ registration failed for mbox\n");
> -               goto fail;
> -       }
> +       if (!is_cn20k(rvu->pdev)) {
> +               /* Register mailbox interrupt handler */
> +               sprintf(&rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE],
> +                       "RVUAF Mbox");
> +               ret =3D request_irq(pci_irq_vector
> +                                 (rvu->pdev, RVU_AF_INT_VEC_MBOX),
> +                                 rvu->ng_rvu->rvu_mbox_ops->pf_intr_hand=
ler, 0,
> +                                 &rvu->irq_name[RVU_AF_INT_VEC_MBOX *
> +                                 NAME_SIZE], rvu);
> +               if (ret) {
> +                       dev_err(rvu->dev,
> +                               "RVUAF: IRQ registration failed for mbox\=
n");
> +                       goto fail;
> +               }
>
> -       rvu->irq_allocated[RVU_AF_INT_VEC_MBOX] =3D true;
> +               rvu->irq_allocated[RVU_AF_INT_VEC_MBOX] =3D true;
> +       } else {
> +               ret =3D cn20k_register_afpf_mbox_intr(rvu);
> +               if (ret) {
> +                       dev_err(rvu->dev,
> +                               "RVUAF: IRQ registration failed for mbox\=
n");
> +                       goto fail;
> +               }
> +       }
>
>         /* Enable mailbox interrupts from all PFs */
>         rvu_enable_mbox_intr(rvu);
> @@ -3467,6 +3492,9 @@ static int rvu_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *id)
>                 ptp_start(rvu, rvu->fwdata->sclk, rvu->fwdata->ptp_ext_cl=
k_rate,
>                           rvu->fwdata->ptp_ext_tstamp);
>
> +       /* Alloc CINT and QINT memory */
> +       rvu_alloc_cint_qint_mem(rvu, &rvu->pf[RVU_AFPF], BLKADDR_NIX0,
> +                               (rvu->hw->block[BLKADDR_NIX0].lf.max));
>         return 0;
>  err_dl:
>         rvu_unregister_dl(rvu);
> @@ -3518,6 +3546,8 @@ static void rvu_remove(struct pci_dev *pdev)
>         pci_set_drvdata(pdev, NULL);
>
>         devm_kfree(&pdev->dev, rvu->hw);
> +       if (is_cn20k(rvu->pdev))
> +               cn20k_free_mbox_memory(rvu);
>         kfree(rvu->ng_rvu);
>         devm_kfree(&pdev->dev, rvu);
>  }
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/ne=
t/ethernet/marvell/octeontx2/af/rvu.h
> index 9fd7aea8c481..c3a6947e5e70 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> @@ -47,6 +47,9 @@
>  #define RVU_PFVF_FUNC_MASK     rvu_pcifunc_func_mask
>
>  #ifdef CONFIG_DEBUG_FS
> +
> +#define RVU_AFPF           25
> +
>  struct dump_ctx {
>         int     lf;
>         int     id;
> @@ -444,6 +447,16 @@ struct mbox_wq_info {
>         struct workqueue_struct *mbox_wq;
>  };
>
> +struct rvu_irq_data {
> +       u64 intr_status;
> +       void (*rvu_queue_work_hdlr)(struct mbox_wq_info *mw, int first,
> +                                   int mdevs, u64 intr);
> +       struct  rvu *rvu;
> +       int vec_num;
> +       int start;
> +       int mdevs;
> +};
> +
>  struct mbox_ops {
>         irqreturn_t (*pf_intr_handler)(int irq, void *rvu_irq);
>  };
> @@ -956,7 +969,8 @@ int rvu_nix_mcast_get_mce_index(struct rvu *rvu, u16 =
pcifunc,
>  int rvu_nix_mcast_update_mcam_entry(struct rvu *rvu, u16 pcifunc,
>                                     u32 mcast_grp_idx, u16 mcam_index);
>  void rvu_nix_flr_free_bpids(struct rvu *rvu, u16 pcifunc);
> -
> +int rvu_alloc_cint_qint_mem(struct rvu *rvu, struct rvu_pfvf *pfvf,
> +                           int blkaddr, int nixlf);
>  /* NPC APIs */
>  void rvu_npc_freemem(struct rvu *rvu);
>  int rvu_npc_get_pkind(struct rvu *rvu, u16 pf);
> --
> 2.25.1
>
>


--=20
Regards,
Kalesh A P

--000000000000f8b1990624f458ea
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
AQkEMSIEIMc8kEzSVZ/Ga38dGUNdEe78t8hv06Sics8d7h/LFiwFMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAyMTAzMzU0M1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAieY4/zFJv
qnNuPT2bbhHR+6QZW1oo6od+H1IPEwz4+ac09XzdZsHq2xgUGEfBOR0dr2f2kZum6YFNaIF+3fQf
+TY2nCHWhtVuzAxEttDZGsBYR8eOIAnDRTf5P5/amYbpufcArxuHTEkC9SAeaO0lgljFm3MV8XIR
8EwK2X9caOTxpG2rGr6wXL6/tYhGA5JTH0hGBKN1pMBp4VFXT3JuPwiX5JtAbDroUVUdL0crQskr
Efn89FOZqNilAQek1tGgoTxJmni7fMSxGzAtdrX8ryVsuN/5S45fuhFvm4jRbiT9fj/+EF1EQfRJ
oKu3WcyqRSFi8RaNBN77ATXh9G+f
--000000000000f8b1990624f458ea--

