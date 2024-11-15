Return-Path: <netdev+bounces-145227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1779CDC36
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 11:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D51282DDD
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 10:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA171B2196;
	Fri, 15 Nov 2024 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lto9BliJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD018192B9D;
	Fri, 15 Nov 2024 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665619; cv=none; b=W7kXwXs3HM/QJKokaOJ04FKs23/cW88vDIxhMk45VKkJYuNS2w3/G0G93goL0LHBLXf7u+WIgIRFN0s6Y5qgjWCV41v0xXBmk5SZbx9hbJzwED2qEBr79gZ1P4Rkn2TS8bS8Ezct4C6S6wOp4Lln0Ma0wAEfdulZ/HNKMqVh/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665619; c=relaxed/simple;
	bh=jUbTIlkCzmo5KKHRBlfepsmaQjfE8LdrKYImc8KptKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=au9APYV3j8T8DnZTIQCIQSHAOijUft51Ngou5y7KCUbHkLruTkbya4LdG1nQGv/xodehERFJ6IIKPDPSTE3wSzMUKOYPbxVAhmv0EtaaHM9ecDg2xWgvYbrIB+dI2g3hhNQy6Br23wkYjEH60NB7pRLiPl5nPz4GRQr40n94XeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lto9BliJ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e9ed5e57a7so4662397b3.1;
        Fri, 15 Nov 2024 02:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731665617; x=1732270417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+U+dq6OUTE0HG7x+OItAD0ZxlO51jPaHioMYFAas8o0=;
        b=Lto9BliJeFUf9vLq90rNYeeBuXJ9s6lh1S0ydSxWn05+JCGxHgxbeJn7FQxDZFZgzs
         j+/XsYKlKqLLrkn52swLnKfDULky7w2FaQnAkQUS0GgygY+HYJ/c+3ZS0WqhksBCP/Nd
         YWySCJ70oD2xG6nOBG/HwOBwvYXwBNX5GXwdjRmcjZZnoHTLy4e/MYOc6b3K0VqHO8TA
         Mf5ieSsa2L4syjGFDZeiam9lcxY4M/gEL7nhPuHGx0C0WP365MyD0UaEcUVsxA/Qw83G
         skwAItEUevUBlxlAHCvfmdNgs3rqCLwnuW6SDyOQz2RUsyV3fDj2jqsvSL/S1OPYmIFu
         9zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731665617; x=1732270417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+U+dq6OUTE0HG7x+OItAD0ZxlO51jPaHioMYFAas8o0=;
        b=XtCbphgmWVoe5EvGTKTmV5ICIeacP1llb5CYmr2sI6Ja8ZspVyM8hNh+UzK5jm1ITz
         HIXYnmrZWrWgPxYLfgUZQ2WTCFGOpCsGehiKMwBlscLbXxPPo+Nh4FTRw+0CneIssE4e
         bdowosavZ/Mu+HixcOQ66HaPBd8CGJepBy+jOAptoSWALlpHI6RlFVTO6yJYMTQxjio0
         B7FCb42zu2bAlhwXTthN7lidsRx7UZu+fXCSoVDSyA/qZqqJAeoULg4W09Z9wkF4ISXm
         5fPLKjmb4GXE3vSFU2iG5hUXa6HZQl+fuYJyWC2pPCVXEQi0zlRyacmt0CPECbcOmMfE
         5S1w==
X-Forwarded-Encrypted: i=1; AJvYcCVfeka3DkItnwPdhgyPjjc9eiQXjSw8ZVJwy0EnPZUsVn4Je5O/Z5cmBVBjDM3jr/X6R9eOWYU+@vger.kernel.org, AJvYcCWbY4UQHA4IrDQLW6YyfoYRe0T1El1V+E8ehKE26cPP1RMPl/ksXtqZv23XNyi5i1g1uulzmGEgiJZ3oPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+pKmrQvIclV1IgzLNH+vVT4gvfpdm2qZtJxWcOpAgkV3wzHKF
	i+PqSzAqL43Lb9pySqu8GDYpcizCG61Y3oMqsXdaCLMvEHm7EKiR7vqfjLKe7sxVjq70m6YAPAi
	Ksml23ff0SSaKXA5o5UQi/4gB9Vc=
X-Google-Smtp-Source: AGHT+IGqmvr95G027gF3uGOLUnYUbtXyVf2lbc3sIS4tS1Ei936TelfD9+5LJk5wwPR8uBSApD/ZtNeJkld1P4Gd050=
X-Received: by 2002:a05:690c:6384:b0:6ee:3f5e:1c18 with SMTP id
 00721157ae682-6ee55a2abddmr23515347b3.4.1731665616629; Fri, 15 Nov 2024
 02:13:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108045708.1205994-1-bbhushan2@marvell.com>
 <20241108045708.1205994-6-bbhushan2@marvell.com> <c9d61267-4bc8-4c1e-a3a2-ff1cbd46f7a5@redhat.com>
In-Reply-To: <c9d61267-4bc8-4c1e-a3a2-ff1cbd46f7a5@redhat.com>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Fri, 15 Nov 2024 15:43:25 +0530
Message-ID: <CAAeCc_kxyxNj47biCf=r2vZQXuC2g7XO524YHfKJQcqpfObpDw@mail.gmail.com>
Subject: Re: [net-next PATCH v9 5/8] cn10k-ipsec: Add SA add/del support for
 outb ipsec crypto offload
To: Paolo Abeni <pabeni@redhat.com>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, jerinj@marvell.com, 
	lcherian@marvell.com, ndabilpuram@marvell.com, sd@queasysnail.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 7:14=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
>
>
> On 11/8/24 05:57, Bharat Bhushan wrote:
> > This patch adds support to add and delete Security Association
> > (SA) xfrm ops. Hardware maintains SA context in memory allocated
> > by software. Each SA context is 128 byte aligned and size of
> > each context is multiple of 128-byte. Add support for transport
> > and tunnel ipsec mode, ESP protocol, aead aes-gcm-icv16, key size
> > 128/192/256-bits with 32bit salt.
> >
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > ---
> > v8->v9:
> >  - Previous versions were supporting only 64 SAs and a bitmap was
> >    used for same. That limitation is removed from this version.
> >  - Replaced netdev_err with NL_SET_ERR_MSG_MOD in state add flow
> >    as per comment in previous version
> >  - Changes related to mutex lock removal
> >
> > v5->v6:
> >  - In ethtool flow, so not cleanup cptlf if SA are installed and
> >    call netdev_update_features() when all SA's are un-installed.
> >  - Description and comment re-word to replace "inline ipsec"
> >    with "ipsec crypto offload"
> >
> > v3->v4:
> >  - Added check for crypto offload (XFRM_DEV_OFFLOAD_CRYPTO)
> >    Thanks "Leon Romanovsky" for pointing out
> >
> > v2->v3:
> >  - Removed memset to zero wherever possible
> >   (comment from Kalesh Anakkur Purayil)
> >  - Corrected error handling when setting SA for inbound
> >    (comment from Kalesh Anakkur Purayil)
> >  - Move "netdev->xfrmdev_ops =3D &cn10k_ipsec_xfrmdev_ops;" to this pat=
ch
> >    This fix build error with W=3D1
> >
> >  .../marvell/octeontx2/nic/cn10k_ipsec.c       | 415 ++++++++++++++++++
> >  .../marvell/octeontx2/nic/cn10k_ipsec.h       | 113 +++++
> >  2 files changed, 528 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b=
/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> > index e09ce42075c7..ccbcc5001431 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> > @@ -375,6 +375,391 @@ static int cn10k_outb_cpt_clean(struct otx2_nic *=
pf)
> >       return ret;
> >  }
> >
> > +static void cn10k_cpt_inst_flush(struct otx2_nic *pf, struct cpt_inst_=
s *inst,
> > +                              u64 size)
> > +{
> > +     struct otx2_lmt_info *lmt_info;
> > +     u64 val =3D 0, tar_addr =3D 0;
> > +
> > +     lmt_info =3D per_cpu_ptr(pf->hw.lmt_info, smp_processor_id());
> > +     /* FIXME: val[0:10] LMT_ID.
> > +      * [12:15] no of LMTST - 1 in the burst.
> > +      * [19:63] data size of each LMTST in the burst except first.
> > +      */
> > +     val =3D (lmt_info->lmt_id & 0x7FF);
> > +     /* Target address for LMTST flush tells HW how many 128bit
> > +      * words are present.
> > +      * tar_addr[6:4] size of first LMTST - 1 in units of 128b.
> > +      */
> > +     tar_addr |=3D pf->ipsec.io_addr | (((size / 16) - 1) & 0x7) << 4;
> > +     dma_wmb();
> > +     memcpy((u64 *)lmt_info->lmt_addr, inst, size);
> > +     cn10k_lmt_flush(val, tar_addr);
> > +}
> > +
> > +static int cn10k_wait_for_cpt_respose(struct otx2_nic *pf,
> > +                                   struct cpt_res_s *res)
> > +{
> > +     unsigned long timeout =3D jiffies + msecs_to_jiffies(10000);
> > +
> > +     do {
> > +             if (time_after(jiffies, timeout)) {
> > +                     netdev_err(pf->netdev, "CPT response timeout\n");
> > +                     return -EBUSY;
> > +             }
> > +     } while (res->compcode =3D=3D CN10K_CPT_COMP_E_NOTDONE);
>
> Why a READ_ONCE() annotation is not needed around the 'res->compcode'
> access?

Yes READ_ONCE() is required, thanks for pointing.
res->compcode is 7bit bit-field, so cannot  use
READ_ONCE((res->compcode). Will add below change:

Add bit-mask for compcode (CN10K_CPT_COMP_E_MASK 0x3F)

+       u64 *completion_ptr =3D (u64 *)res;

        do {
                if (time_after(jiffies, timeout)) {
                        netdev_err(pf->netdev, "CPT response timeout\n");
                        return -EBUSY;
                }
-       } while (res->compcode =3D=3D CN10K_CPT_COMP_E_NOTDONE);
+       } while ((READ_ONCE(*completion_ptr) & CN10K_CPT_COMP_E_MASK) =3D=
=3D
+                CN10K_CPT_COMP_E_NOTDONE);


>
> Possibly more relevant: it looks like this code is busy polling the H/W
> for at most 10s, is that correct? If so that timeout is way too high my
> several order of magnitude. You should likely use usleep_range() or
> sleep_interruptible()

This is called from the atomic context (xdo_dev_state_delete()), so I
can't sleep.
Polling for 10 sec was added for some experimentation, Will change
polling time to 100ms. Is that okay?

Thanks
-Bharat

>
> [...]
> > +static int cn10k_ipsec_validate_state(struct xfrm_state *x,
> > +                                   struct netlink_ext_ack *extack)
> > +{
> > +     if (x->props.aalgo !=3D SADB_AALG_NONE) {
> > +             NL_SET_ERR_MSG_MOD(extack,
> > +                                "Cannot offload authenticated xfrm sta=
tes\n");
>
> No '\n' at the end of extack messages.
>
> (many cases below)
>
> Thanks,
>
> Paolo
>
>

