Return-Path: <netdev+bounces-98874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7772B8D2CB6
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 07:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE081C2523B
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 05:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6B815B96E;
	Wed, 29 May 2024 05:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A2QsGjSv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDCD1EB3F
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 05:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716961581; cv=none; b=N49D4HManxdWqw6/Ws43BtQUcbZHbUenoyWwB1SQpsHFqsPElD3vAXCNQBSyT1jAf7l96IsU2QrKYHEBP6YhyUW9+WirbdRm0Buy0ecmS4hjM7KSrxf95811f7Z2u3GDhzE9Ba9yFyjP/iDNnyHK4dCUxQHnU5lHNgfgt4j7y6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716961581; c=relaxed/simple;
	bh=D7a7XfesOgG3q9MgDMFjVy6UNPMczGTgoY+pAydky3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soYrosVw4kdj3uOCHnTNixkCF3JPdM9Pg/CkiA+K/ce0/0LmuBACR6l6rvaDyjrQCPKauowR60VXz8Z4kmB3BX5jB5HcACN886y0pquhF8b2Pae0Wbr3oexD8d4Taphd1Fv8d2QAkLO1Kwc/61FQrYs90Ec2ojbS9FlUHaqSVMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A2QsGjSv; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ad8230bb9so345629e87.3
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 22:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1716961577; x=1717566377; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vbeCbaqIVatsr/JAeekUJECiUoTiQ/W1O7PsGsqgW2Y=;
        b=A2QsGjSvsPfssJ6NWZMsNuEQgtEEdUapRLCQVq/PdD+5hTx3y2WhYBy0/MJBrIl+zg
         HO9JlXKRitX6VuQbjK5I0O5SUt2YmzvDYv29iF9tbix6wyAwMNKKVq6r/uRhVTWjMB/5
         9fhPDzSedHuKD1nniqaOqJ7P61ZNGp9m+jUz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716961577; x=1717566377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbeCbaqIVatsr/JAeekUJECiUoTiQ/W1O7PsGsqgW2Y=;
        b=Uju39RB0EIFxiVeVEzB0uh+jeSllHd81mvcQc8JkbWnhd5E919nfeZUQ7vTxZKtrQD
         naOwZhZ1D+DHbweB2MpKkYEHcBGKp4zpfAJ0enPUforDNFYRKGUpQW5SDk2PKOaKa2k7
         YAWY1rYLLcAFqeTP3K7RG0bO1BwTt84Fm0ngNmdxqVh7Opg1pY3pSgc5LQlZslSQzxHz
         c1isoyMDZ3J3EMkK03RPWPwfMqK7Bz1DMwVFYEs/Hgvdo5je1AfYYRPGiXmEGnihYvt8
         r9UxqLfn4LFQdsy3lt/tUVecfLcKpa0/iibKmurNviCpsu+WE+LpVgg+ATE5wLfbhPd3
         ieAA==
X-Gm-Message-State: AOJu0Yx9dGPicKAn9j3i/QXMo30zjGU1LgouX+KSG7XUCJUQOQt3E2zb
	kYRUoF8KYeWpxt/1PPUXzUuOhiZJhFSA+CD5FLFkIEUoAHS5unhOQNMBcq66UU988pk2U2+8DJu
	nu+AcYbWn7KwU2fH0zpwRcYpSA035h2SfiNBj
X-Google-Smtp-Source: AGHT+IGD1NPFQGs3NpfXBaAjiEJA5+kumLGtHonlifgE5X1g9uuFypYU38Jvh5rb0tSG/BuFEzEqXPZaL9tU2VAurL8=
X-Received: by 2002:ac2:4214:0:b0:525:502a:acc6 with SMTP id
 2adb3069b0e04-529668c9e48mr8429790e87.52.1716961576713; Tue, 28 May 2024
 22:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528135349.932669-1-bbhushan2@marvell.com> <20240528135349.932669-5-bbhushan2@marvell.com>
In-Reply-To: <20240528135349.932669-5-bbhushan2@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 29 May 2024 11:16:05 +0530
Message-ID: <CAH-L+nNoGfb3qB1ztAKhCkU=WMGcJuDF6+Aqqvfg-_mwTkdHyw@mail.gmail.com>
Subject: Re: [net-next,v3 4/8] cn10k-ipsec: Initialize crypto hardware for
 outb inline ipsec
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sgoutham@marvell.com, 
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	jerinj@marvell.com, lcherian@marvell.com, richardcochran@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e7bf5606199144ef"

--000000000000e7bf5606199144ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 7:27=E2=80=AFPM Bharat Bhushan <bbhushan2@marvell.c=
om> wrote:
>
> One crypto hardware logical function (cpt-lf) per netdev is
> required for inline ipsec outbound functionality. Allocate,
> attach and initialize one crypto hardware function when
> enabling inline ipsec crypto offload. Crypto hardware
> function will be detached and freed on disabling inline
> ipsec.
>
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v1->v2:
>  - Fix compilation error to build driver a module
>  - Fix couple of compilation warnings
>
>  .../ethernet/marvell/octeontx2/nic/Makefile   |   1 +
>  .../marvell/octeontx2/nic/cn10k_ipsec.c       | 393 ++++++++++++++++++
>  .../marvell/octeontx2/nic/cn10k_ipsec.h       | 104 +++++
>  .../marvell/octeontx2/nic/otx2_common.h       |  18 +
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  14 +-
>  .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  10 +-
>  6 files changed, 538 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipse=
c.c
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipse=
c.h
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/driver=
s/net/ethernet/marvell/octeontx2/nic/Makefile
> index 5664f768cb0c..9695f967d416 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
> @@ -14,5 +14,6 @@ rvu_nicvf-y :=3D otx2_vf.o otx2_devlink.o
>  rvu_nicpf-$(CONFIG_DCB) +=3D otx2_dcbnl.o
>  rvu_nicvf-$(CONFIG_DCB) +=3D otx2_dcbnl.o
>  rvu_nicpf-$(CONFIG_MACSEC) +=3D cn10k_macsec.o
> +rvu_nicpf-$(CONFIG_XFRM_OFFLOAD) +=3D cn10k_ipsec.o
>
>  ccflags-y +=3D -I$(srctree)/drivers/net/ethernet/marvell/octeontx2/af
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/d=
rivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> new file mode 100644
> index 000000000000..b221b67815ee
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> @@ -0,0 +1,393 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell IPSEC offload driver
> + *
> + * Copyright (C) 2024 Marvell.
> + */
> +
> +#include <net/xfrm.h>
> +#include <linux/netdevice.h>
> +#include <linux/bitfield.h>
> +
> +#include "otx2_common.h"
> +#include "cn10k_ipsec.h"
> +
> +static bool is_dev_support_inline_ipsec(struct pci_dev *pdev)
> +{
> +       return is_dev_cn10ka_b0(pdev) || is_dev_cn10kb(pdev);
> +}
> +
> +static int cn10k_outb_cptlf_attach(struct otx2_nic *pf)
> +{
> +       struct rsrc_attach *attach;
> +       int err;
> +
> +       mutex_lock(&pf->mbox.lock);
> +       /* Get memory to put this msg */
> +       attach =3D otx2_mbox_alloc_msg_attach_resources(&pf->mbox);
> +       if (!attach) {
> +               mutex_unlock(&pf->mbox.lock);
> +               return -ENOMEM;
> +       }
[Kalesh] To make it consistent with other functions, you can add a
label unlock and re-write it as:
if (!attach) {
     err =3D -ENOMEM;
     goto unlock;
}
> +
> +       attach->cptlfs =3D true;
> +       attach->modify =3D true;
> +
> +       /* Send attach request to AF */
> +       err =3D otx2_sync_mbox_msg(&pf->mbox);
> +       if (err) {
> +               mutex_unlock(&pf->mbox.lock);
> +               return err;
> +       }
> +
> +       mutex_unlock(&pf->mbox.lock);
> +       return 0;
> +}
> +
> +static int cn10k_outb_cptlf_detach(struct otx2_nic *pf)
> +{
> +       struct rsrc_detach *detach;
> +
> +       mutex_lock(&pf->mbox.lock);
> +       detach =3D otx2_mbox_alloc_msg_detach_resources(&pf->mbox);
> +       if (!detach) {
> +               mutex_unlock(&pf->mbox.lock);
> +               return -ENOMEM;
> +       }
[Kalesh] Same comment as above
> +
> +       detach->partial =3D true;
> +       detach->cptlfs =3D true;
> +
> +       /* Send detach request to AF */
> +       otx2_sync_mbox_msg(&pf->mbox);
> +       mutex_unlock(&pf->mbox.lock);
> +       return 0;
> +}
> +
> +static int cn10k_outb_cptlf_alloc(struct otx2_nic *pf)
> +{
> +       struct cpt_lf_alloc_req_msg *req;
> +       int ret =3D 0;
[Kalesh] No need to initialize ret here. You are little inconsistent
in naming the variable, ret vs err :)
> +
> +       mutex_lock(&pf->mbox.lock);
> +       req =3D otx2_mbox_alloc_msg_cpt_lf_alloc(&pf->mbox);
> +       if (!req) {
> +               ret =3D -ENOMEM;
> +               goto error;
> +       }
> +
> +       /* PF function */
> +       req->nix_pf_func =3D pf->pcifunc;
> +       /* Enable SE-IE Engine Group */
> +       req->eng_grpmsk =3D 1 << CN10K_DEF_CPT_IPSEC_EGRP;
> +
> +       ret =3D otx2_sync_mbox_msg(&pf->mbox);
> +
> +error:
[Kalesh]: I would be better name the label as unlock.
> +       mutex_unlock(&pf->mbox.lock);
> +       return ret;
> +}
> +
> +static void cn10k_outb_cptlf_free(struct otx2_nic *pf)
> +{
> +       mutex_lock(&pf->mbox.lock);
> +       otx2_mbox_alloc_msg_cpt_lf_free(&pf->mbox);
> +       otx2_sync_mbox_msg(&pf->mbox);
> +       mutex_unlock(&pf->mbox.lock);
> +}
> +
> +static int cn10k_outb_cptlf_config(struct otx2_nic *pf)
> +{
> +       struct cpt_inline_ipsec_cfg_msg *req;
> +       int ret =3D 0;
[Kalesh] No need to initialize the variable here.
> +
> +       mutex_lock(&pf->mbox.lock);
> +       req =3D otx2_mbox_alloc_msg_cpt_inline_ipsec_cfg(&pf->mbox);
> +       if (!req) {
> +               ret =3D -ENOMEM;
> +               goto error;
> +       }
> +
> +       req->dir =3D CPT_INLINE_OUTBOUND;
> +       req->enable =3D 1;
> +       req->nix_pf_func =3D pf->pcifunc;
> +       ret =3D otx2_sync_mbox_msg(&pf->mbox);
> +error:
> +       mutex_unlock(&pf->mbox.lock);
> +       return ret;
> +}
> +
> +static void cn10k_outb_cptlf_iq_enable(struct otx2_nic *pf)
> +{
> +       u64 reg_val;
> +
> +       /* Set Execution Enable of instruction queue */
> +       reg_val =3D otx2_read64(pf, CN10K_CPT_LF_INPROG);
> +       reg_val |=3D BIT_ULL(16);
> +       otx2_write64(pf, CN10K_CPT_LF_INPROG, reg_val);
> +
> +       /* Set iqueue's enqueuing */
> +       reg_val =3D otx2_read64(pf, CN10K_CPT_LF_CTL);
> +       reg_val |=3D BIT_ULL(0);
> +       otx2_write64(pf, CN10K_CPT_LF_CTL, reg_val);
> +}
> +
> +static void cn10k_outb_cptlf_iq_disable(struct otx2_nic *pf)
> +{
> +       u32 inflight, grb_cnt, gwb_cnt;
> +       u32 nq_ptr, dq_ptr;
> +       int timeout =3D 20;
> +       u64 reg_val;
> +       int cnt;
> +
> +       /* Disable instructions enqueuing */
> +       otx2_write64(pf, CN10K_CPT_LF_CTL, 0ull);
> +
> +       /* Wait for instruction queue to become empty.
> +        * CPT_LF_INPROG.INFLIGHT count is zero
> +        */
> +       do {
> +               reg_val =3D otx2_read64(pf, CN10K_CPT_LF_INPROG);
> +               inflight =3D FIELD_GET(CPT_LF_INPROG_INFLIGHT, reg_val);
> +               if (!inflight)
> +                       break;
> +
> +               usleep_range(10000, 20000);
> +               if (timeout-- < 0) {
> +                       netdev_err(pf->netdev, "Timeout to cleanup CPT IQ=
\n");
> +                       break;
> +               }
> +       } while (1);
> +
> +       /* Disable executions in the LF's queue,
> +        * the queue should be empty at this point
> +        */
> +       reg_val &=3D ~BIT_ULL(16);
> +       otx2_write64(pf, CN10K_CPT_LF_INPROG, reg_val);
> +
> +       /* Wait for instruction queue to become empty */
> +       cnt =3D 0;
> +       do {
> +               reg_val =3D otx2_read64(pf, CN10K_CPT_LF_INPROG);
> +               if (reg_val & BIT_ULL(31))
> +                       cnt =3D 0;
> +               else
> +                       cnt++;
> +               reg_val =3D otx2_read64(pf, CN10K_CPT_LF_Q_GRP_PTR);
> +               nq_ptr =3D FIELD_GET(CPT_LF_Q_GRP_PTR_DQ_PTR, reg_val);
> +               dq_ptr =3D FIELD_GET(CPT_LF_Q_GRP_PTR_DQ_PTR, reg_val);
> +       } while ((cnt < 10) && (nq_ptr !=3D dq_ptr));
> +
> +       cnt =3D 0;
> +       do {
> +               reg_val =3D otx2_read64(pf, CN10K_CPT_LF_INPROG);
> +               inflight =3D FIELD_GET(CPT_LF_INPROG_INFLIGHT, reg_val);
> +               grb_cnt =3D FIELD_GET(CPT_LF_INPROG_GRB_CNT, reg_val);
> +               gwb_cnt =3D FIELD_GET(CPT_LF_INPROG_GWB_CNT, reg_val);
> +               if (inflight =3D=3D 0 && gwb_cnt < 40 &&
> +                   (grb_cnt =3D=3D 0 || grb_cnt =3D=3D 40))
> +                       cnt++;
> +               else
> +                       cnt =3D 0;
> +       } while (cnt < 10);
> +}
> +
> +/* Allocate memory for CPT outbound Instruction queue.
> + * Instruction queue memory format is:
> + *      -----------------------------
> + *     | Instruction Group memory    |
> + *     |  (CPT_LF_Q_SIZE[SIZE_DIV40] |
> + *     |   x 16 Bytes)               |
> + *     |                             |
> + *      ----------------------------- <-- CPT_LF_Q_BASE[ADDR]
> + *     | Flow Control (128 Bytes)    |
> + *     |                             |
> + *      -----------------------------
> + *     |  Instruction Memory         |
> + *     |  (CPT_LF_Q_SIZE[SIZE_DIV40] |
> + *     |   =C3=97 40 =C3=97 64 bytes)          |
> + *     |                             |
> + *      -----------------------------
> + */
> +static int cn10k_outb_cptlf_iq_alloc(struct otx2_nic *pf)
> +{
> +       struct cn10k_cpt_inst_queue *iq =3D &pf->ipsec.iq;
> +
> +       iq->size =3D CN10K_CPT_INST_QLEN_BYTES + CN10K_CPT_Q_FC_LEN +
> +                   CN10K_CPT_INST_GRP_QLEN_BYTES + OTX2_ALIGN;
> +
> +       iq->real_vaddr =3D dma_alloc_coherent(pf->dev, iq->size,
> +                                           &iq->real_dma_addr, GFP_KERNE=
L);
> +       if (!iq->real_vaddr)
> +               return -ENOMEM;
> +
> +       /* iq->vaddr/dma_addr points to Flow Control location */
> +       iq->vaddr =3D iq->real_vaddr + CN10K_CPT_INST_GRP_QLEN_BYTES;
> +       iq->dma_addr =3D iq->real_dma_addr + CN10K_CPT_INST_GRP_QLEN_BYTE=
S;
> +
> +       /* Align pointers */
> +       iq->vaddr =3D PTR_ALIGN(iq->vaddr, OTX2_ALIGN);
> +       iq->dma_addr =3D PTR_ALIGN(iq->dma_addr, OTX2_ALIGN);
> +       return 0;
> +}
> +
> +static void cn10k_outb_cptlf_iq_free(struct otx2_nic *pf)
> +{
> +       struct cn10k_cpt_inst_queue *iq =3D &pf->ipsec.iq;
> +
> +       if (!iq->real_vaddr)
> +               dma_free_coherent(pf->dev, iq->size, iq->real_vaddr,
> +                                 iq->real_dma_addr);
> +
> +       iq->real_vaddr =3D NULL;
> +       iq->vaddr =3D NULL;
> +}
> +
> +static int cn10k_outb_cptlf_iq_init(struct otx2_nic *pf)
> +{
> +       u64 reg_val;
> +       int ret;
> +
> +       /* Allocate Memory for CPT IQ */
> +       ret =3D cn10k_outb_cptlf_iq_alloc(pf);
> +       if (ret)
> +               return ret;
> +
> +       /* Disable IQ */
> +       cn10k_outb_cptlf_iq_disable(pf);
> +
> +       /* Set IQ base address */
> +       otx2_write64(pf, CN10K_CPT_LF_Q_BASE, pf->ipsec.iq.dma_addr);
> +
> +       /* Set IQ size */
> +       reg_val =3D FIELD_PREP(CPT_LF_Q_SIZE_DIV40, CN10K_CPT_SIZE_DIV40 =
+
> +                            CN10K_CPT_EXTRA_SIZE_DIV40);
> +       otx2_write64(pf, CN10K_CPT_LF_Q_SIZE, reg_val);
> +
> +       return 0;
> +}
> +
> +static int cn10k_outb_cptlf_init(struct otx2_nic *pf)
> +{
> +       int ret =3D 0;
[Kalesh] There is no need to initialize this variable.
> +
> +       /* Initialize CPTLF Instruction Queue (IQ) */
> +       ret =3D cn10k_outb_cptlf_iq_init(pf);
> +       if (ret)
> +               return ret;
> +
> +       /* Configure CPTLF for outbound inline ipsec */
> +       ret =3D cn10k_outb_cptlf_config(pf);
> +       if (ret)
> +               goto iq_clean;
> +
> +       /* Enable CPTLF IQ */
> +       cn10k_outb_cptlf_iq_enable(pf);
> +       return 0;
> +iq_clean:
> +       cn10k_outb_cptlf_iq_free(pf);
> +       return ret;
> +}
> +
> +static int cn10k_outb_cpt_init(struct net_device *netdev)
> +{
> +       struct otx2_nic *pf =3D netdev_priv(netdev);
> +       int ret;
> +
> +       mutex_lock(&pf->ipsec.lock);
> +
> +       /* Attach a CPT LF for outbound inline ipsec */
> +       ret =3D cn10k_outb_cptlf_attach(pf);
> +       if (ret)
> +               goto unlock;
> +
> +       /* Allocate a CPT LF for outbound inline ipsec */
> +       ret =3D cn10k_outb_cptlf_alloc(pf);
> +       if (ret)
> +               goto detach;
> +
> +       /* Initialize the CPTLF for outbound inline ipsec */
> +       ret =3D cn10k_outb_cptlf_init(pf);
> +       if (ret)
> +               goto lf_free;
> +
> +       pf->ipsec.io_addr =3D (__force u64)otx2_get_regaddr(pf,
> +                                               CN10K_CPT_LF_NQX(0));
> +
> +       /* Set inline ipsec enabled for this device */
> +       pf->flags |=3D OTX2_FLAG_INLINE_IPSEC_ENABLED;
> +
> +       goto unlock;
> +
> +lf_free:
> +       cn10k_outb_cptlf_free(pf);
> +detach:
> +       cn10k_outb_cptlf_detach(pf);
> +unlock:
> +       mutex_unlock(&pf->ipsec.lock);
> +       return ret;
> +}
> +
> +static int cn10k_outb_cpt_clean(struct otx2_nic *pf)
> +{
> +       int err;
> +
> +       mutex_lock(&pf->ipsec.lock);
> +
> +       /* Set inline ipsec disabled for this device */
> +       pf->flags &=3D ~OTX2_FLAG_INLINE_IPSEC_ENABLED;
> +
> +       /* Disable CPTLF Instruction Queue (IQ) */
> +       cn10k_outb_cptlf_iq_disable(pf);
> +
> +       /* Set IQ base address and size to 0 */
> +       otx2_write64(pf, CN10K_CPT_LF_Q_BASE, 0);
> +       otx2_write64(pf, CN10K_CPT_LF_Q_SIZE, 0);
> +
> +       /* Free CPTLF IQ */
> +       cn10k_outb_cptlf_iq_free(pf);
> +
> +       /* Free and detach CPT LF */
> +       cn10k_outb_cptlf_free(pf);
> +       err =3D cn10k_outb_cptlf_detach(pf);
> +       if (err)
> +               netdev_err(pf->netdev, "Failed to detach CPT LF\n");
> +
> +       mutex_unlock(&pf->ipsec.lock);
> +       return err;
> +}
> +
> +int cn10k_ipsec_ethtool_init(struct net_device *netdev, bool enable)
> +{
> +       struct otx2_nic *pf =3D netdev_priv(netdev);
> +
> +       /* Inline ipsec supported on cn10k */
> +       if (!is_dev_support_inline_ipsec(pf->pdev))
> +               return -ENODEV;
[Kalesh] NODEV vs NOTSUPP ?
> +
> +       if (!enable)
> +               return cn10k_outb_cpt_clean(pf);
> +
> +       /* Initialize CPT for outbound inline ipsec */
> +       return cn10k_outb_cpt_init(netdev);
> +}
> +
> +int cn10k_ipsec_init(struct net_device *netdev)
> +{
> +       struct otx2_nic *pf =3D netdev_priv(netdev);
> +
> +       if (!is_dev_support_inline_ipsec(pf->pdev))
> +               return 0;
[Kalesh] This function returns 0 always, maybe you can change it to return =
void.
> +
> +       mutex_init(&pf->ipsec.lock);
> +       return 0;
> +}
> +EXPORT_SYMBOL(cn10k_ipsec_init);
> +
> +void cn10k_ipsec_clean(struct otx2_nic *pf)
> +{
> +       if (!is_dev_support_inline_ipsec(pf->pdev))
> +               return;
> +
> +       cn10k_outb_cpt_clean(pf);
> +}
> +EXPORT_SYMBOL(cn10k_ipsec_clean);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h b/d=
rivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
> new file mode 100644
> index 000000000000..b322e19d5e23
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
> @@ -0,0 +1,104 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Marvell IPSEC offload driver
> + *
> + * Copyright (C) 2024 Marvell.
> + */
> +
> +#ifndef CN10K_IPSEC_H
> +#define CN10K_IPSEC_H
> +
> +#include <linux/types.h>
> +
> +/* CPT instruction size in bytes */
> +#define CN10K_CPT_INST_SIZE    64
> +
> +/* CPT instruction (CPT_INST_S) queue length */
> +#define CN10K_CPT_INST_QLEN    8200
> +
> +/* CPT instruction queue size passed to HW is in units of
> + * 40*CPT_INST_S messages.
> + */
> +#define CN10K_CPT_SIZE_DIV40 (CN10K_CPT_INST_QLEN / 40)
> +
> +/* CPT needs 320 free entries */
> +#define CN10K_CPT_INST_QLEN_EXTRA_BYTES        (320 * CN10K_CPT_INST_SIZ=
E)
> +#define CN10K_CPT_EXTRA_SIZE_DIV40     (320 / 40)
> +
> +/* CPT instruction queue length in bytes */
> +#define CN10K_CPT_INST_QLEN_BYTES                                      \
> +               ((CN10K_CPT_SIZE_DIV40 * 40 * CN10K_CPT_INST_SIZE) +    \
> +               CN10K_CPT_INST_QLEN_EXTRA_BYTES)
> +
> +/* CPT instruction group queue length in bytes */
> +#define CN10K_CPT_INST_GRP_QLEN_BYTES                                  \
> +               ((CN10K_CPT_SIZE_DIV40 + CN10K_CPT_EXTRA_SIZE_DIV40) * 16=
)
> +
> +/* CPT FC length in bytes */
> +#define CN10K_CPT_Q_FC_LEN 128
> +
> +/* Default CPT engine group for inline ipsec */
> +#define CN10K_DEF_CPT_IPSEC_EGRP 1
> +
> +/* CN10K CPT LF registers */
> +#define CPT_LFBASE                     (BLKTYPE_CPT << RVU_FUNC_BLKADDR_=
SHIFT)
> +#define CN10K_CPT_LF_CTL               (CPT_LFBASE | 0x10)
> +#define CN10K_CPT_LF_INPROG            (CPT_LFBASE | 0x40)
> +#define CN10K_CPT_LF_Q_BASE            (CPT_LFBASE | 0xf0)
> +#define CN10K_CPT_LF_Q_SIZE            (CPT_LFBASE | 0x100)
> +#define CN10K_CPT_LF_Q_INST_PTR                (CPT_LFBASE | 0x110)
> +#define CN10K_CPT_LF_Q_GRP_PTR         (CPT_LFBASE | 0x120)
> +#define CN10K_CPT_LF_NQX(a)            (CPT_LFBASE | 0x400 | (a) << 3)
> +#define CN10K_CPT_LF_CTX_FLUSH         (CPT_LFBASE | 0x510)
> +
> +struct cn10k_cpt_inst_queue {
> +       u8 *vaddr;
> +       u8 *real_vaddr;
> +       dma_addr_t dma_addr;
> +       dma_addr_t real_dma_addr;
> +       u32 size;
> +};
> +
> +struct cn10k_ipsec {
> +       /* Outbound CPT */
> +       u64 io_addr;
> +       /* Lock to protect SA management */
> +       struct mutex lock;
> +       struct cn10k_cpt_inst_queue iq;
> +};
> +
> +/* CPT LF_INPROG Register */
> +#define CPT_LF_INPROG_INFLIGHT GENMASK_ULL(8, 0)
> +#define CPT_LF_INPROG_GRB_CNT  GENMASK_ULL(39, 32)
> +#define CPT_LF_INPROG_GWB_CNT  GENMASK_ULL(47, 40)
> +
> +/* CPT LF_Q_GRP_PTR Register */
> +#define CPT_LF_Q_GRP_PTR_DQ_PTR        GENMASK_ULL(14, 0)
> +#define CPT_LF_Q_GRP_PTR_NQ_PTR        GENMASK_ULL(46, 32)
> +
> +/* CPT LF_Q_SIZE Register */
> +#define CPT_LF_Q_BASE_ADDR GENMASK_ULL(52, 7)
> +
> +/* CPT LF_Q_SIZE Register */
> +#define CPT_LF_Q_SIZE_DIV40 GENMASK_ULL(14, 0)
> +
> +#ifdef CONFIG_XFRM_OFFLOAD
> +int cn10k_ipsec_init(struct net_device *netdev);
> +void cn10k_ipsec_clean(struct otx2_nic *pf);
> +int cn10k_ipsec_ethtool_init(struct net_device *netdev, bool enable);
> +#else
> +static inline __maybe_unused int cn10k_ipsec_init(struct net_device *net=
dev)
> +{
> +       return 0;
> +}
> +
> +static inline __maybe_unused void cn10k_ipsec_clean(struct otx2_nic *pf)
> +{
> +}
> +
> +static inline __maybe_unused
> +int cn10k_ipsec_ethtool_init(struct net_device *netdev, bool enable)
> +{
> +       return 0;
> +}
> +#endif
> +#endif // CN10K_IPSEC_H
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index 42a759a33c11..859bbc78e653 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -29,6 +29,7 @@
>  #include "otx2_devlink.h"
>  #include <rvu_trace.h>
>  #include "qos.h"
> +#include "cn10k_ipsec.h"
>
>  /* IPv4 flag more fragment bit */
>  #define IPV4_FLAG_MORE                         0x20
> @@ -39,6 +40,7 @@
>  #define PCI_DEVID_OCTEONTX2_RVU_AFVF           0xA0F8
>
>  #define PCI_SUBSYS_DEVID_96XX_RVU_PFVF         0xB200
> +#define PCI_SUBSYS_DEVID_CN10K_A_RVU_PFVF      0xB900
>  #define PCI_SUBSYS_DEVID_CN10K_B_RVU_PFVF      0xBD00
>
>  /* PCI BAR nos */
> @@ -467,6 +469,7 @@ struct otx2_nic {
>  #define OTX2_FLAG_PTP_ONESTEP_SYNC             BIT_ULL(15)
>  #define OTX2_FLAG_ADPTV_INT_COAL_ENABLED BIT_ULL(16)
>  #define OTX2_FLAG_TC_MARK_ENABLED              BIT_ULL(17)
> +#define OTX2_FLAG_INLINE_IPSEC_ENABLED         BIT_ULL(18)
>         u64                     flags;
>         u64                     *cq_op_addr;
>
> @@ -534,6 +537,9 @@ struct otx2_nic {
>  #if IS_ENABLED(CONFIG_MACSEC)
>         struct cn10k_mcs_cfg    *macsec_cfg;
>  #endif
> +
> +       /* Inline ipsec */
> +       struct cn10k_ipsec      ipsec;
>  };
>
>  static inline bool is_otx2_lbkvf(struct pci_dev *pdev)
> @@ -578,6 +584,15 @@ static inline bool is_dev_cn10kb(struct pci_dev *pde=
v)
>         return pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CN10K_B_RVU=
_PFVF;
>  }
>
> +static inline bool is_dev_cn10ka_b0(struct pci_dev *pdev)
> +{
> +       if (pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CN10K_A_RVU_PF=
VF &&
> +           (pdev->revision & 0xFF) =3D=3D 0x54)
> +               return true;
> +
> +       return false;
> +}
> +
>  static inline void otx2_setup_dev_hw_settings(struct otx2_nic *pfvf)
>  {
>         struct otx2_hw *hw =3D &pfvf->hw;
> @@ -627,6 +642,9 @@ static inline void __iomem *otx2_get_regaddr(struct o=
tx2_nic *nic, u64 offset)
>         case BLKTYPE_NPA:
>                 blkaddr =3D BLKADDR_NPA;
>                 break;
> +       case BLKTYPE_CPT:
> +               blkaddr =3D BLKADDR_CPT0;
> +               break;
>         default:
>                 blkaddr =3D BLKADDR_RVUM;
>                 break;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index cbd5050f58e8..a7e17d870420 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -26,6 +26,7 @@
>  #include "cn10k.h"
>  #include "qos.h"
>  #include <rvu_trace.h>
> +#include "cn10k_ipsec.h"
>
>  #define DRV_NAME       "rvu_nicpf"
>  #define DRV_STRING     "Marvell RVU NIC Physical Function Driver"
> @@ -2201,6 +2202,10 @@ static int otx2_set_features(struct net_device *ne=
tdev,
>                 return otx2_enable_rxvlan(pf,
>                                           features & NETIF_F_HW_VLAN_CTAG=
_RX);
>
> +       if (changed & NETIF_F_HW_ESP)
> +               return cn10k_ipsec_ethtool_init(netdev,
> +                                               features & NETIF_F_HW_ESP=
);
> +
>         return otx2_handle_ntuple_tc_features(netdev, features);
>  }
>
> @@ -3065,10 +3070,14 @@ static int otx2_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
>         /* reset CGX/RPM MAC stats */
>         otx2_reset_mac_stats(pf);
>
> +       err =3D cn10k_ipsec_init(netdev);
> +       if (err)
> +               goto err_mcs_free;
> +
>         err =3D register_netdev(netdev);
>         if (err) {
>                 dev_err(dev, "Failed to register netdevice\n");
> -               goto err_mcs_free;
> +               goto err_ipsec_clean;
>         }
>
>         err =3D otx2_wq_init(pf);
> @@ -3109,6 +3118,8 @@ static int otx2_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
>         otx2_mcam_flow_del(pf);
>  err_unreg_netdev:
>         unregister_netdev(netdev);
> +err_ipsec_clean:
> +       cn10k_ipsec_clean(pf);
>  err_mcs_free:
>         cn10k_mcs_free(pf);
>  err_del_mcam_entries:
> @@ -3286,6 +3297,7 @@ static void otx2_remove(struct pci_dev *pdev)
>
>         otx2_unregister_dl(pf);
>         unregister_netdev(netdev);
> +       cn10k_ipsec_clean(pf);
>         cn10k_mcs_free(pf);
>         otx2_sriov_disable(pf->pdev);
>         otx2_sriov_vfcfg_cleanup(pf);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> index 99fcc5661674..6fc70c3cafb6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> @@ -14,6 +14,7 @@
>  #include "otx2_reg.h"
>  #include "otx2_ptp.h"
>  #include "cn10k.h"
> +#include "cn10k_ipsec.h"
>
>  #define DRV_NAME       "rvu_nicvf"
>  #define DRV_STRING     "Marvell RVU NIC Virtual Function Driver"
> @@ -682,10 +683,14 @@ static int otx2vf_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
>                 snprintf(netdev->name, sizeof(netdev->name), "lbk%d", n);
>         }
>
> +       err =3D cn10k_ipsec_init(netdev);
> +       if (err)
> +               goto err_ptp_destroy;
> +
>         err =3D register_netdev(netdev);
>         if (err) {
>                 dev_err(dev, "Failed to register netdevice\n");
> -               goto err_ptp_destroy;
> +               goto err_ipsec_clean;
>         }
>
>         err =3D otx2_wq_init(vf);
> @@ -719,6 +724,8 @@ static int otx2vf_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
>         otx2_shutdown_tc(vf);
>  err_unreg_netdev:
>         unregister_netdev(netdev);
> +err_ipsec_clean:
> +       cn10k_ipsec_clean(vf);
>  err_ptp_destroy:
>         otx2_ptp_destroy(vf);
>  err_detach_rsrc:
> @@ -771,6 +778,7 @@ static void otx2vf_remove(struct pci_dev *pdev)
>         unregister_netdev(netdev);
>         if (vf->otx2_wq)
>                 destroy_workqueue(vf->otx2_wq);
> +       cn10k_ipsec_clean(vf);
>         otx2_ptp_destroy(vf);
>         otx2_mcam_flow_del(vf);
>         otx2_shutdown_tc(vf);
> --
> 2.34.1
>
>


--=20
Regards,
Kalesh A P

--000000000000e7bf5606199144ef
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
AQkEMSIEIIVuYDfJOxE2WtSOzcQe436FP5rUy5mSm8SaGmzjpLJhMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUyOTA1NDYxN1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBzcm3r1xUz
rwypXqPPlm02pGohgn1iiRhWkWu6xJSNqU/p/0JMoGrvKIEuGp57jw3cxo9DJBxPkJzeohq15AZX
qbZbu9XWFDvaabanx/fq9D1AqefRHyBJ3zV7SdVDp8KQYbYCRKoEXi3nekeLbF4YqN/AJt7i/SFF
PniBzOT6blb+xyYYJgNBdth1JeRA2SB2oLMpGvwa4UAoR9MOQf/kOAd4am5W39tstCc5t4XgQV73
f0fNJHeUCSJn9HnIGaZv1Il5+CMRbr85ex1/omv8btGKoZFHuQXfzVn/e33sHE3xECg1INS4CZLm
g+fbMSGcnnQ8z3AAE2YCXBt+k4JO
--000000000000e7bf5606199144ef--

