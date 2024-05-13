Return-Path: <netdev+bounces-95895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F13E8C3CF4
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85908B219D2
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D931474AA;
	Mon, 13 May 2024 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QiiGNoI8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A419F146A60
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588108; cv=none; b=JWKzcayfs7vW9/33cSyBX+n2MTEXDQkmr4SQvEcUd2vkCWTdXHCJdKDy4/DROT/2jFdrXE9J5T0VdguuEwWJXeyLo2j9Rr5AZaXplCbkElGEH+xwZFBwOe5qZcQKmDGMwoFCMW+6Q3zvLEe0XxiMF4MDYtDsrifU9V2czZERkuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588108; c=relaxed/simple;
	bh=W4EaRoR9cDA49JEXjDJpB0yIZX41jqy0HkrXSI1ii5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jN4JsHa6l1fnOQoM5NpgzmFibFcpJEdxtdYPSPDWUSkR5hYsx7PhtxWEuxkuDLKA3PqpbqphkxJFnm3R1vRHuI5ddLvQ9UhuRy7oIsM23pebunT1IDMe8DxdtALqHDPLNBPqn11ECJTxDfLAzOsNoTwxmrbFl3LgSFwInpblxxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QiiGNoI8; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e538a264f7so37264441fa.0
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 01:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715588104; x=1716192904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ujFPPQr21qDmqZ0LZj8oP0zpZV6JfKChFDKml5LEyBs=;
        b=QiiGNoI8ww1EkNusQWkOs+PnBkDix/ZQA0UZ49fY1GwCMC3ogTakm8k6xmYuYS1zUa
         yiGFpPybJ3DT1Jxksqs50uQ8YHNY1ZdOmkj4UyhyVhEHAfc3PN+rgdrQVkIi05xHmaLt
         HXS8WcAccBJXQHYBwRltjeV3kHS5QvNdisnCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715588104; x=1716192904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujFPPQr21qDmqZ0LZj8oP0zpZV6JfKChFDKml5LEyBs=;
        b=NFfqK7lEeKIXQmpir9b4ITk0Cp/HykNW2XrT6+kQITdwYVAlzirdzq+AEzL8bj/Rhb
         o6S4eg6Gg5qzjDTitkZ+cyljfRlwbx4xlTRlr6uHDpxKfT68wcUziA0h0wOUXhLw9Pl0
         OgT5XrW4mTSV6RBZpLfT9XbXZOz7Uy1oHjPTjS33zYvaP8Qx2Zg330ytUwKgXO1rFQ5V
         6hgKF2/aIbyBB/Kskte0IvBllLFzpFD8qGMucINwUgL/hfUJzVund5z5eNRFDqIuxnQW
         cwyE4cahv671kYGgJYo8wdQOUGJzMj0QuCQO1goR/piCW3W3/mws3yUadrRIyAmpv+vE
         Sw9w==
X-Gm-Message-State: AOJu0Yz94wcL/RsmFNdjf5P/d0AI8n5g9Zdggnfjvw580I4b8gkZPTIY
	7MRv+7kZmQ5OnxpAlKHZgakPfNYFohCYJ1/PJ+INS4VSa2paOzwOeOnVVe6854xpuufp7mrK7Pm
	qdXZl9RxbuoDg4cw1l5yHIr8iros7qKuPoWgP70d/QIGlOe5I9pV+
X-Google-Smtp-Source: AGHT+IEQHB8uhsifMHkZSdRzihd6JsgHPPWef0pHin/677Bx4b1jfQ827t7sAbY/7t0uGAcjXjKqLZQ5xegCtSG4b7M=
X-Received: by 2002:a05:651c:1542:b0:2de:7046:b8f8 with SMTP id
 38308e7fff4ca-2e51fd2e6a8mr87469971fa.5.1715588103653; Mon, 13 May 2024
 01:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513054623.270366-1-bbhushan2@marvell.com> <20240513054623.270366-6-bbhushan2@marvell.com>
In-Reply-To: <20240513054623.270366-6-bbhushan2@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 13 May 2024 13:44:51 +0530
Message-ID: <CAH-L+nNk+RrAvxZ_kZLcTeQWY6dv+mCQ+2SKh-8kBgV1DnMDUg@mail.gmail.com>
Subject: Re: [PATCH 5/8] cn10k-ipsec: Add SA add/delete support for outb
 inline ipsec
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sgoutham@marvell.com, 
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000086bbb80618517bb5"

--00000000000086bbb80618517bb5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 11:18=E2=80=AFAM Bharat Bhushan <bbhushan2@marvell.=
com> wrote:
>
> This patch adds support to add and delete Security Association
> (SA) xfrm ops. Hardware maintains SA context in memory allocated
> by software. Each SA context is 128 byte aligned and size of
> each context is multiple of 128-byte. Add support for transport
> and tunnel ipsec mode, ESP protocol, aead aes-gcm-icv16, key size
> 128/192/256-bits with 32bit salt.
>
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
>  .../marvell/octeontx2/nic/cn10k_ipsec.c       | 433 +++++++++++++++++-
>  .../marvell/octeontx2/nic/cn10k_ipsec.h       | 114 +++++
>  2 files changed, 546 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/d=
rivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> index c6e115ab39df..db544dac0424 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> @@ -153,7 +153,7 @@ static inline void cn10k_outb_cptlf_iq_disable(struct=
 otx2_nic *pf)
>
>                 usleep_range(10000, 20000);
>                 if (timeout-- < 0) {
> -                       dev_err(pf->dev, "Error CPT LF is still busy\n");
> +                       netdev_err(pf->netdev, "Timeout to empty IQ\n");
[Kalesh] This looks unrelated change.
>                         break;
>                 }
>         } while (1);
> @@ -336,6 +336,12 @@ static int cn10k_outb_cpt_clean(struct otx2_nic *pf)
>         /* Set inline ipsec disabled for this device */
>         pf->flags &=3D ~OTX2_FLAG_INLINE_IPSEC_ENABLED;
>
> +       if (!bitmap_empty(pf->ipsec.sa_bitmap, CN10K_IPSEC_OUTB_MAX_SA)) =
{
> +               netdev_err(pf->netdev, "SA installed on this device\n");
> +               mutex_unlock(&pf->ipsec.lock);
> +               return -EBUSY;
> +       }
> +
>         /* Disable CPTLF Instruction Queue (IQ) */
>         cn10k_outb_cptlf_iq_disable(pf);
>
> @@ -356,6 +362,414 @@ static int cn10k_outb_cpt_clean(struct otx2_nic *pf=
)
>         return err;
>  }
>
> +static int cn10k_outb_get_sa_index(struct otx2_nic *pf,
> +                                  struct cn10k_tx_sa_s *sa_entry)
> +{
> +       u32 sa_size =3D pf->ipsec.sa_size;
> +       u32 sa_index;
> +
> +       if (!sa_entry || ((void *)sa_entry < pf->ipsec.outb_sa->base))
> +               return -EINVAL;
> +
> +       sa_index =3D ((void *)sa_entry - pf->ipsec.outb_sa->base) / sa_si=
ze;
> +       if (sa_index >=3D CN10K_IPSEC_OUTB_MAX_SA)
> +               return -EINVAL;
> +
> +       return sa_index;
> +}
> +
> +static dma_addr_t cn10k_outb_get_sa_iova(struct otx2_nic *pf,
> +                                        struct cn10k_tx_sa_s *sa_entry)
> +{
> +       u32 sa_index =3D cn10k_outb_get_sa_index(pf, sa_entry);
> +
> +       if (sa_index < 0)
> +               return 0;
> +       return pf->ipsec.outb_sa->iova + sa_index * pf->ipsec.sa_size;
> +}
> +
> +static struct cn10k_tx_sa_s *cn10k_outb_alloc_sa(struct otx2_nic *pf)
> +{
> +       u32 sa_size =3D pf->ipsec.sa_size;
> +       struct cn10k_tx_sa_s *sa_entry;
> +       u32 sa_index;
> +
> +       sa_index =3D find_first_zero_bit(pf->ipsec.sa_bitmap,
> +                                      CN10K_IPSEC_OUTB_MAX_SA);
> +       if (sa_index =3D=3D CN10K_IPSEC_OUTB_MAX_SA)
> +               return NULL;
> +
> +       set_bit(sa_index, pf->ipsec.sa_bitmap);
> +
> +       sa_entry =3D pf->ipsec.outb_sa->base + sa_index * sa_size;
> +       return sa_entry;
> +}
> +
> +static void cn10k_outb_free_sa(struct otx2_nic *pf,
> +                              struct cn10k_tx_sa_s *sa_entry)
> +{
> +       u32 sa_index =3D cn10k_outb_get_sa_index(pf, sa_entry);
> +
> +       if (sa_index < 0)
> +               return;
> +       clear_bit(sa_index, pf->ipsec.sa_bitmap);
> +}
> +
> +static void cn10k_cpt_inst_flush(struct otx2_nic *pf, struct cpt_inst_s =
*inst,
> +                                u64 size)
> +{
> +       struct otx2_lmt_info *lmt_info;
> +       u64 val =3D 0, tar_addr =3D 0;
> +
> +       lmt_info =3D per_cpu_ptr(pf->hw.lmt_info, smp_processor_id());
> +       /* FIXME: val[0:10] LMT_ID.
> +        * [12:15] no of LMTST - 1 in the burst.
> +        * [19:63] data size of each LMTST in the burst except first.
> +        */
> +       val =3D (lmt_info->lmt_id & 0x7FF);
> +       /* Target address for LMTST flush tells HW how many 128bit
> +        * words are present.
> +        * tar_addr[6:4] size of first LMTST - 1 in units of 128b.
> +        */
> +       tar_addr |=3D pf->ipsec.io_addr | (((size / 16) - 1) & 0x7) << 4;
> +       dma_wmb();
> +       memcpy((u64 *)lmt_info->lmt_addr, inst, size);
> +       cn10k_lmt_flush(val, tar_addr);
> +}
> +
> +static int cn10k_wait_for_cpt_respose(struct otx2_nic *pf,
> +                                     struct cpt_res_s *res)
> +{
> +       unsigned long timeout =3D jiffies + msecs_to_jiffies(10000);
> +
> +       do {
> +               if (time_after(jiffies, timeout)) {
> +                       netdev_err(pf->netdev, "CPT response timeout\n");
> +                       return -EBUSY;
> +               }
> +       } while (res->compcode =3D=3D CN10K_CPT_COMP_E_NOTDONE);
> +
> +       if (!(res->compcode =3D=3D CN10K_CPT_COMP_E_GOOD ||
> +             res->compcode =3D=3D CN10K_CPT_COMP_E_WARN) || res->uc_comp=
code) {
> +               netdev_err(pf->netdev, "compcode=3D%x doneint=3D%x\n",
> +                          res->compcode, res->doneint);
> +               netdev_err(pf->netdev, "uc_compcode=3D%x uc_info=3D%llx e=
sn=3D%llx\n",
> +                          res->uc_compcode, (u64)res->uc_info, res->esn)=
;
> +       }
> +       return 0;
> +}
> +
> +static int cn10k_outb_write_sa(struct otx2_nic *pf, struct cn10k_tx_sa_s=
 *sa_cptr)
> +{
> +       dma_addr_t res_iova, dptr_iova, sa_iova;
> +       struct cn10k_tx_sa_s *sa_dptr;
> +       struct cpt_inst_s inst;
> +       struct cpt_res_s *res;
> +       u32 sa_size, off;
> +       u64 reg_val;
> +       int ret;
> +
> +       sa_iova =3D cn10k_outb_get_sa_iova(pf, sa_cptr);
> +       if (!sa_iova)
> +               return -EINVAL;
> +
> +       res =3D dma_alloc_coherent(pf->dev, sizeof(struct cpt_res_s),
> +                                &res_iova, GFP_ATOMIC);
> +       if (!res)
> +               return -ENOMEM;
> +
> +       sa_size =3D sizeof(struct cn10k_tx_sa_s);
> +       sa_dptr =3D dma_alloc_coherent(pf->dev, sa_size, &dptr_iova, GFP_=
ATOMIC);
> +       if (!sa_dptr) {
> +               dma_free_coherent(pf->dev, sizeof(struct cpt_res_s), res,
> +                                 res_iova);
> +               return -ENOMEM;
> +       }
> +
> +       for (off =3D 0; off < (sa_size / 8); off++)
> +               *((u64 *)sa_dptr + off) =3D cpu_to_be64(*((u64 *)sa_cptr =
+ off));
> +
> +       memset(&inst, 0, sizeof(struct cpt_inst_s));
[Kalesh]: You can avoid memset by initializing inst =3D {}; This comment
applies to all other occurrences in this change.
> +
> +       res->compcode =3D CN10K_CPT_COMP_E_NOTDONE;
> +       inst.res_addr =3D res_iova;
> +       inst.dptr =3D (u64)dptr_iova;
> +       inst.param2 =3D sa_size >> 3;
> +       inst.dlen =3D sa_size;
> +       inst.opcode_major =3D CN10K_IPSEC_MAJOR_OP_WRITE_SA;
> +       inst.opcode_minor =3D CN10K_IPSEC_MINOR_OP_WRITE_SA;
> +       inst.cptr =3D sa_iova;
> +       inst.ctx_val =3D 1;
> +       inst.egrp =3D CN10K_DEF_CPT_IPSEC_EGRP;
> +
> +       cn10k_cpt_inst_flush(pf, &inst, sizeof(struct cpt_inst_s));
> +       dmb(sy);
> +       ret =3D cn10k_wait_for_cpt_respose(pf, res);
> +       if (ret)
> +               goto out;
> +
> +       /* Trigger CTX flush to write dirty data back to DRAM */
> +       reg_val =3D FIELD_PREP(CPT_LF_CTX_FLUSH, sa_iova >> 7);
> +       otx2_write64(pf, CN10K_CPT_LF_CTX_FLUSH, reg_val);
> +
> +out:
> +       dma_free_coherent(pf->dev, sa_size, sa_dptr, dptr_iova);
> +       dma_free_coherent(pf->dev, sizeof(struct cpt_res_s), res, res_iov=
a);
> +       return ret;
> +}
> +
> +static inline int cn10k_ipsec_get_hw_ctx_offset(void)
> +{
> +       /* Offset on Hardware-context offset in word */
> +       return (offsetof(struct cn10k_tx_sa_s, hw_ctx) / sizeof(u64)) & 0=
x7F;
> +}
> +
> +static inline int cn10k_ipsec_get_ctx_push_size(void)
[Kalesh] No 'inline' function in c files.
> +{
> +       /* Context push size is round up and in multiple of 8 Byte */
> +       return (roundup(offsetof(struct cn10k_tx_sa_s, hw_ctx), 8) / 8) &=
 0x7F;
> +}
> +
> +static inline int cn10k_ipsec_get_aes_key_len(int key_len)
> +{
> +       if (key_len =3D=3D 16)
> +               return CN10K_IPSEC_SA_AES_KEY_LEN_128;
> +       else if (key_len =3D=3D 24)
> +               return CN10K_IPSEC_SA_AES_KEY_LEN_192;
> +       else
> +               return CN10K_IPSEC_SA_AES_KEY_LEN_256;
[Kalesh]: IMO, it would be better to use switch-case here.
> +}
> +
> +static void cn10k_outb_prepare_sa(struct xfrm_state *x,
> +                                 struct cn10k_tx_sa_s *sa_entry)
> +{
> +       int key_len =3D (x->aead->alg_key_len + 7) / 8;
> +       struct net_device *netdev =3D x->xso.dev;
> +       u8 *key =3D x->aead->alg_key;
> +       struct otx2_nic *pf;
> +       u32 *tmp_salt;
> +       u64 *tmp_key;
> +       int idx;
> +
> +       memset(sa_entry, 0, sizeof(struct cn10k_tx_sa_s));
> +
> +       /* context size, 128 Byte aligned up */
> +       pf =3D netdev_priv(netdev);
> +       sa_entry->ctx_size =3D (pf->ipsec.sa_size / OTX2_ALIGN)  & 0xF;
> +       sa_entry->hw_ctx_off =3D cn10k_ipsec_get_hw_ctx_offset();
> +       sa_entry->ctx_push_size =3D cn10k_ipsec_get_ctx_push_size();
> +
> +       /* Ucode to skip two words of CPT_CTX_HW_S */
> +       sa_entry->ctx_hdr_size =3D 1;
> +
> +       /* Allow Atomic operation (AOP) */
> +       sa_entry->aop_valid =3D 1;
> +
> +       /* Outbound, ESP TRANSPORT/TUNNEL Mode, AES-GCM with AES key leng=
th
> +        * 128bit.
> +        */
> +       sa_entry->sa_dir =3D CN10K_IPSEC_SA_DIR_OUTB;
> +       sa_entry->ipsec_protocol =3D CN10K_IPSEC_SA_IPSEC_PROTO_ESP;
> +       sa_entry->enc_type =3D CN10K_IPSEC_SA_ENCAP_TYPE_AES_GCM;
> +       if (x->props.mode =3D=3D XFRM_MODE_TUNNEL)
> +               sa_entry->ipsec_mode =3D CN10K_IPSEC_SA_IPSEC_MODE_TUNNEL=
;
> +       else
> +               sa_entry->ipsec_mode =3D CN10K_IPSEC_SA_IPSEC_MODE_TRANSP=
ORT;
> +
> +       sa_entry->spi =3D cpu_to_be32(x->id.spi);
> +
> +       /* Last 4 bytes are salt */
> +       key_len -=3D 4;
> +       sa_entry->aes_key_len =3D cn10k_ipsec_get_aes_key_len(key_len);
> +       memcpy(sa_entry->cipher_key, key, key_len);
> +       tmp_key =3D (u64 *)sa_entry->cipher_key;
> +
> +       for (idx =3D 0; idx < key_len / 8; idx++)
> +               tmp_key[idx] =3D be64_to_cpu(tmp_key[idx]);
> +
> +       memcpy(&sa_entry->iv_gcm_salt, key + key_len, 4);
> +       tmp_salt =3D (u32 *)&sa_entry->iv_gcm_salt;
> +       *tmp_salt =3D be32_to_cpu(*tmp_salt);
> +
> +       /* Write SA context data to memory before enabling */
> +       wmb();
> +
> +       /* Enable SA */
> +       sa_entry->sa_valid =3D 1;
> +}
> +
> +static inline int cn10k_ipsec_validate_state(struct xfrm_state *x)
> +{
> +       struct net_device *netdev =3D x->xso.dev;
> +
> +       if (x->props.aalgo !=3D SADB_AALG_NONE) {
> +               netdev_err(netdev, "Cannot offload authenticated xfrm sta=
tes\n");
> +               return -EINVAL;
> +       }
> +       if (x->props.ealgo !=3D SADB_X_EALG_AES_GCM_ICV16) {
> +               netdev_err(netdev, "Only AES-GCM-ICV16 xfrm state may be =
offloaded\n");
> +               return -EINVAL;
> +       }
> +       if (x->props.calgo !=3D SADB_X_CALG_NONE) {
> +               netdev_err(netdev, "Cannot offload compressed xfrm states=
\n");
> +               return -EINVAL;
> +       }
> +       if (x->props.flags & XFRM_STATE_ESN) {
> +               netdev_err(netdev, "Cannot offload ESN xfrm states\n");
> +               return -EINVAL;
> +       }
> +       if (x->props.family !=3D AF_INET && x->props.family !=3D AF_INET6=
) {
> +               netdev_err(netdev, "Only IPv4/v6 xfrm states may be offlo=
aded\n");
> +               return -EINVAL;
> +       }
> +       if (x->props.mode !=3D XFRM_MODE_TRANSPORT &&
> +           x->props.mode !=3D XFRM_MODE_TUNNEL) {
> +               dev_info(&netdev->dev, "Only tunnel/transport xfrm states=
 may be offloaded\n");
> +               return -EINVAL;
> +       }
> +       if (x->id.proto !=3D IPPROTO_ESP) {
> +               netdev_err(netdev, "Only ESP xfrm state may be offloaded\=
n");
> +               return -EINVAL;
> +       }
> +       if (x->encap) {
> +               netdev_err(netdev, "Encapsulated xfrm state may not be of=
floaded\n");
> +               return -EINVAL;
> +       }
> +       if (!x->aead) {
> +               netdev_err(netdev, "Cannot offload xfrm states without ae=
ad\n");
> +               return -EINVAL;
> +       }
> +
> +       if (x->aead->alg_icv_len !=3D 128) {
> +               netdev_err(netdev, "Cannot offload xfrm states with AEAD =
ICV length other than 128bit\n");
> +               return -EINVAL;
> +       }
> +       if (x->aead->alg_key_len !=3D 128 + 32 &&
> +           x->aead->alg_key_len !=3D 192 + 32 &&
> +           x->aead->alg_key_len !=3D 256 + 32) {
> +               netdev_err(netdev, "Cannot offload xfrm states with AEAD =
key length other than 128/192/256bit\n");
> +               return -EINVAL;
> +       }
> +       if (x->tfcpad) {
> +               netdev_err(netdev, "Cannot offload xfrm states with tfc p=
adding\n");
> +               return -EINVAL;
> +       }
> +       if (!x->geniv) {
> +               netdev_err(netdev, "Cannot offload xfrm states without ge=
niv\n");
> +               return -EINVAL;
> +       }
> +       if (strcmp(x->geniv, "seqiv")) {
> +               netdev_err(netdev, "Cannot offload xfrm states with geniv=
 other than seqiv\n");
> +               return -EINVAL;
> +       }
> +       return 0;
> +}
> +
> +static int cn10k_ipsec_add_state(struct xfrm_state *x,
> +                                struct netlink_ext_ack *extack)
> +{
> +       struct net_device *netdev =3D x->xso.dev;
> +       struct cn10k_tx_sa_s *sa_entry;
> +       struct cpt_ctx_info_s *sa_info;
> +       struct otx2_nic *pf;
> +       int err;
> +
> +       err =3D cn10k_ipsec_validate_state(x);
> +       if (err)
> +               return err;
> +
> +       if (x->xso.dir =3D=3D XFRM_DEV_OFFLOAD_IN) {
> +               netdev_err(netdev, "xfrm inbound offload not supported\n"=
);
> +               err =3D -ENODEV;
[Kalesh] You should return directly from here as there is no need to unlock=
.
> +       } else {
> +               pf =3D netdev_priv(netdev);
> +               if (!mutex_trylock(&pf->ipsec.lock)) {
> +                       netdev_err(netdev, "IPSEC device is busy\n");
> +                       return -EBUSY;
> +               }
> +
> +               if (!(pf->flags & OTX2_FLAG_INLINE_IPSEC_ENABLED)) {
> +                       netdev_err(netdev, "IPSEC not enabled/supported o=
n device\n");
> +                       err =3D -ENODEV;
[Kalesh] -ENOTSUPP would be the better error code here?
> +                       goto unlock;
> +               }
> +
> +               sa_entry =3D cn10k_outb_alloc_sa(pf);
> +               if (!sa_entry) {
> +                       netdev_err(netdev, "SA maximum limit %x reached\n=
",
> +                                  CN10K_IPSEC_OUTB_MAX_SA);
> +                       err =3D -EBUSY;
> +                       goto unlock;
> +               }
> +
> +               cn10k_outb_prepare_sa(x, sa_entry);
> +
> +               err =3D cn10k_outb_write_sa(pf, sa_entry);
> +               if (err) {
> +                       netdev_err(netdev, "Error writing outbound SA\n")=
;
> +                       cn10k_outb_free_sa(pf, sa_entry);
> +                       goto unlock;
> +               }
> +
> +               sa_info =3D kmalloc(sizeof(*sa_info), GFP_KERNEL);
> +               sa_info->sa_entry =3D sa_entry;
> +               sa_info->sa_iova =3D cn10k_outb_get_sa_iova(pf, sa_entry)=
;
> +               x->xso.offload_handle =3D (unsigned long)sa_info;
> +       }
> +
> +unlock:
> +       mutex_unlock(&pf->ipsec.lock);
> +       return err;
> +}
> +
> +static void cn10k_ipsec_del_state(struct xfrm_state *x)
> +{
> +       struct net_device *netdev =3D x->xso.dev;
> +       struct cn10k_tx_sa_s *sa_entry;
> +       struct cpt_ctx_info_s *sa_info;
> +       struct otx2_nic *pf;
> +       u32 sa_index;
> +
> +       if (x->xso.dir =3D=3D XFRM_DEV_OFFLOAD_IN)
> +               return;
> +
> +       pf =3D netdev_priv(netdev);
> +       if (!mutex_trylock(&pf->ipsec.lock)) {
> +               netdev_err(netdev, "IPSEC device is busy\n");
> +               return;
> +       }
> +
> +       sa_info =3D (struct cpt_ctx_info_s *)x->xso.offload_handle;
> +       sa_entry =3D sa_info->sa_entry;
> +       sa_index =3D cn10k_outb_get_sa_index(pf, sa_entry);
> +       if (sa_index < 0 || !test_bit(sa_index, pf->ipsec.sa_bitmap)) {
> +               netdev_err(netdev, "Invalid SA (sa-index %d)\n", sa_index=
);
> +               goto error;
[Kalesh] better rename the label as "unlock"

> +       }
> +
> +       memset(sa_entry, 0, sizeof(struct cn10k_tx_sa_s));
> +
> +       /* Disable SA in CPT h/w */
> +       sa_entry->ctx_push_size =3D cn10k_ipsec_get_ctx_push_size();
> +       sa_entry->ctx_size =3D (pf->ipsec.sa_size / OTX2_ALIGN)  & 0xF;
> +       sa_entry->aop_valid =3D 1;
> +
> +       if (cn10k_outb_write_sa(pf, sa_entry)) {
> +               netdev_err(netdev, "Failed to delete sa index %d\n", sa_i=
ndex);
> +               goto error;
> +       }
> +       x->xso.offload_handle =3D 0;
> +       clear_bit(sa_index, pf->ipsec.sa_bitmap);
> +       kfree(sa_info);
> +error:
> +       mutex_unlock(&pf->ipsec.lock);
> +}
> +
> +static const struct xfrmdev_ops cn10k_ipsec_xfrmdev_ops =3D {
> +       .xdo_dev_state_add      =3D cn10k_ipsec_add_state,
> +       .xdo_dev_state_delete   =3D cn10k_ipsec_del_state,
> +};
> +
>  int cn10k_ipsec_ethtool_init(struct net_device *netdev, bool enable)
>  {
>         struct otx2_nic *pf =3D netdev_priv(netdev);
> @@ -374,10 +788,25 @@ int cn10k_ipsec_ethtool_init(struct net_device *net=
dev, bool enable)
>  int cn10k_ipsec_init(struct net_device *netdev)
>  {
>         struct otx2_nic *pf =3D netdev_priv(netdev);
> +       u32 sa_size;
> +       int err;
>
>         if (!is_dev_support_inline_ipsec(pf->pdev))
>                 return 0;
>
> +       /* Each SA entry size is 128 Byte round up in size */
> +       sa_size =3D sizeof(struct cn10k_tx_sa_s) % OTX2_ALIGN ?
> +                        (sizeof(struct cn10k_tx_sa_s) / OTX2_ALIGN + 1) =
*
> +                        OTX2_ALIGN : sizeof(struct cn10k_tx_sa_s);
> +       err =3D qmem_alloc(pf->dev, &pf->ipsec.outb_sa, CN10K_IPSEC_OUTB_=
MAX_SA,
> +                        sa_size);
> +       if (err)
> +               return err;
> +
> +       pf->ipsec.sa_size =3D sa_size;
> +       memset(pf->ipsec.outb_sa->base, 0, sa_size * CN10K_IPSEC_OUTB_MAX=
_SA);
> +       bitmap_zero(pf->ipsec.sa_bitmap, CN10K_IPSEC_OUTB_MAX_SA);
> +
>         mutex_init(&pf->ipsec.lock);
>         return 0;
>  }
> @@ -387,5 +816,7 @@ void cn10k_ipsec_clean(struct otx2_nic *pf)
>         if (!is_dev_support_inline_ipsec(pf->pdev))
>                 return;
>
> +       bitmap_zero(pf->ipsec.sa_bitmap, CN10K_IPSEC_OUTB_MAX_SA);
> +       qmem_free(pf->dev, pf->ipsec.outb_sa);
>         cn10k_outb_cpt_clean(pf);
>  }
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h b/d=
rivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
> index f7c9f4339cb2..00c0cfd9b698 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
> @@ -50,6 +50,22 @@
>  #define CN10K_CPT_LF_NQX(a)            (CPT_LFBASE | 0x400 | (a) << 3)
>  #define CN10K_CPT_LF_CTX_FLUSH         (CPT_LFBASE | 0x510)
>
> +/* Outbound SA */
> +#define CN10K_IPSEC_OUTB_MAX_SA 64
> +
> +/* IPSEC Instruction opcodes */
> +#define CN10K_IPSEC_MAJOR_OP_WRITE_SA 0x01UL
> +#define CN10K_IPSEC_MINOR_OP_WRITE_SA 0x09UL
> +
> +enum cn10k_cpt_comp_e {
> +       CN10K_CPT_COMP_E_NOTDONE =3D 0x00,
> +       CN10K_CPT_COMP_E_GOOD =3D 0x01,
> +       CN10K_CPT_COMP_E_FAULT =3D 0x02,
> +       CN10K_CPT_COMP_E_HWERR =3D 0x04,
> +       CN10K_CPT_COMP_E_INSTERR =3D 0x05,
> +       CN10K_CPT_COMP_E_WARN =3D 0x06
> +};
> +
>  struct cn10k_cpt_inst_queue {
>         u8 *vaddr;
>         u8 *real_vaddr;
> @@ -64,6 +80,101 @@ struct cn10k_ipsec {
>         /* Lock to protect SA management */
>         struct mutex lock;
>         struct cn10k_cpt_inst_queue iq;
> +       /* SA info */
> +       struct qmem *outb_sa;
> +       u32 sa_size;
> +       DECLARE_BITMAP(sa_bitmap, CN10K_IPSEC_OUTB_MAX_SA);
> +};
> +
> +/* CN10K IPSEC Security Association (SA) */
> +/* SA direction */
> +#define CN10K_IPSEC_SA_DIR_INB                 0
> +#define CN10K_IPSEC_SA_DIR_OUTB                        1
> +/* SA protocol */
> +#define CN10K_IPSEC_SA_IPSEC_PROTO_AH          0
> +#define CN10K_IPSEC_SA_IPSEC_PROTO_ESP         1
> +/* SA Encryption Type */
> +#define CN10K_IPSEC_SA_ENCAP_TYPE_AES_GCM      5
> +/* SA IPSEC mode Transport/Tunnel */
> +#define CN10K_IPSEC_SA_IPSEC_MODE_TRANSPORT    0
> +#define CN10K_IPSEC_SA_IPSEC_MODE_TUNNEL       1
> +/* SA AES Key Length */
> +#define CN10K_IPSEC_SA_AES_KEY_LEN_128 1
> +#define CN10K_IPSEC_SA_AES_KEY_LEN_192 2
> +#define CN10K_IPSEC_SA_AES_KEY_LEN_256 3
> +
> +struct cn10k_tx_sa_s {
> +       u64 esn_en              : 1; /* W0 */
> +       u64 rsvd_w0_1_8         : 8;
> +       u64 hw_ctx_off          : 7;
> +       u64 ctx_id              : 16;
> +       u64 rsvd_w0_32_47       : 16;
> +       u64 ctx_push_size       : 7;
> +       u64 rsvd_w0_55          : 1;
> +       u64 ctx_hdr_size        : 2;
> +       u64 aop_valid           : 1;
> +       u64 rsvd_w0_59          : 1;
> +       u64 ctx_size            : 4;
> +       u64 w1;                 /* W1 */
> +       u64 sa_valid            : 1; /* W2 */
> +       u64 sa_dir              : 1;
> +       u64 rsvd_w2_2_3         : 2;
> +       u64 ipsec_mode          : 1;
> +       u64 ipsec_protocol      : 1;
> +       u64 aes_key_len         : 2;
> +       u64 enc_type            : 3;
> +       u64 rsvd_w2_11_31       : 21;
> +       u64 spi                 : 32;
> +       u64 w3;                 /* W3 */
> +       u8 cipher_key[32];      /* W4 - W7 */
> +       u32 rsvd_w8_0_31;       /* W8 : IV */
> +       u32 iv_gcm_salt;
> +       u64 rsvd_w9_w30[22];    /* W9 - W30 */
> +       u64 hw_ctx[6];          /* W31 - W36 */
> +};
> +
> +/* CPT Instruction Structure */
> +struct cpt_inst_s {
> +       u64 nixtxl              : 3; /* W0 */
> +       u64 doneint             : 1;
> +       u64 rsvd_w0_4_15        : 12;
> +       u64 dat_offset          : 8;
> +       u64 ext_param1          : 8;
> +       u64 nixtx_offset        : 20;
> +       u64 rsvd_w0_52_63       : 12;
> +       u64 res_addr;           /* W1 */
> +       u64 tag                 : 32; /* W2 */
> +       u64 tt                  : 2;
> +       u64 grp                 : 10;
> +       u64 rsvd_w2_44_47       : 4;
> +       u64 rvu_pf_func         : 16;
> +       u64 qord                : 1; /* W3 */
> +       u64 rsvd_w3_1_2         : 2;
> +       u64 wqe_ptr             : 61;
> +       u64 dlen                : 16; /* W4 */
> +       u64 param2              : 16;
> +       u64 param1              : 16;
> +       u64 opcode_major        : 8;
> +       u64 opcode_minor        : 8;
> +       u64 dptr;               /* W5 */
> +       u64 rptr;               /* W6 */
> +       u64 cptr                : 60; /* W7 */
> +       u64 ctx_val             : 1;
> +       u64 egrp                : 3;
> +};
> +
> +/* CPT Instruction Result Structure */
> +struct cpt_res_s {
> +       u64 compcode            : 7; /* W0 */
> +       u64 doneint             : 1;
> +       u64 uc_compcode         : 8;
> +       u64 uc_info             : 48;
> +       u64 esn;                /* W1 */
> +};
> +
> +struct cpt_ctx_info_s {
> +       struct cn10k_tx_sa_s *sa_entry;
> +       dma_addr_t sa_iova;
>  };
>
>  /* CPT LF_INPROG Register */
> @@ -81,6 +192,9 @@ struct cn10k_ipsec {
>  /* CPT LF_Q_SIZE Register */
>  #define CPT_LF_Q_SIZE_DIV40 GENMASK_ULL(14, 0)
>
> +/* CPT LF CTX Flush Register */
> +#define CPT_LF_CTX_FLUSH GENMASK_ULL(45, 0)
> +
>  #ifdef CONFIG_XFRM_OFFLOAD
>  int cn10k_ipsec_init(struct net_device *netdev);
>  void cn10k_ipsec_clean(struct otx2_nic *pf);
> --
> 2.34.1
>
>


--
Regards,
Kalesh A P

--00000000000086bbb80618517bb5
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
AQkEMSIEIAvpILqChm0CZwjEmUeUEuDoaTv0UeVLzBIJ6FFu84DGMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUxMzA4MTUwNFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCg8CBDKW6G
zLJ3MTKhkc9SsDTlvCztF2gz7/mso+HqdGdNBdb3WDYCT3DpbHnPP2cuycI4kSw9tSiRX/sG67KV
TgRC7bdMhDVtAdcIoqa4vuLYnulJucoLxI2wKScMqxHjBBRszzST75GawZozEnoLNk3arMiCRVYM
ctk/j9NUoMyjEx1+6lyeVIHtBZOJYVhZd5jN3DL85sGnZPoKgIc/o/q44QVUD7Cn6eIx811rVk+a
YDafqIbf3sShkYGNTiLxcmhI0NE42Y2WchpOSdkR2fs3K8/FFgFBIB2azb1P+MYeJnGs5JBfog+0
ccya2rdzBfqsBe0+SH7SJQSyRvMy
--00000000000086bbb80618517bb5--

