Return-Path: <netdev+bounces-133751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D5D996F26
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA76B281FC
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EEF81AC8;
	Wed,  9 Oct 2024 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXg5ONS+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F5C196D98;
	Wed,  9 Oct 2024 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486173; cv=none; b=ODjpgtm98qM+B+ajF3zpqTEsNurLvsdLNn+bpaY3dWXQFkpYqaOnVkUb9O5K+kNTioJh9umhz8gAmD9L0PXD6lhN7jUDY+NLUqudpaYaToUR1X8obuOziY0Rdlpl/LVr7hiJexrQHaqhViVNWee2Wfi9D/tzxvMF2FkhYY88aZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486173; c=relaxed/simple;
	bh=Mk44DNlSMwHtbEg19mQvbg2/aNCmQ3rZ/LMVqCQ1yuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwtHph5v5vda8GuskdRY6Cg/dT54rcPfejDZIIfRxtmNiqVqvoG2KlWSAtwFXMAkZ8GiYf6uI1auiFDEHM2Hf1HM6awbN9VdJvxdp3SyPAbswHPdm+DyyIU4lMkjrWQI0paV5F+9VhVR3ij3JnUUWjIETowutjVaxVZw9Yo88gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXg5ONS+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e0946f9a8eso4829102a91.1;
        Wed, 09 Oct 2024 08:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728486171; x=1729090971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaKS53yTMSxp8Q9ePLUQ+BVB9n7Us0sPrHA8rLSAqgw=;
        b=EXg5ONS+DeD3G9jY+tiKFEAbvYy6AQPFeGyuvqf1vPPn2q/o7tRLyFGKS4fKwiaEW3
         8ltfAcjPR7EVN2x3tLJEVyxD2PlqDKXRZDTOp9M45mA8V5YbRisMC/3kNBKGcTyvzfMZ
         aw4/T/S/RWlzQgIVsUNvpzyt/cg/21NQsMHawJcHAjFDUP/ClO31Ov7T67HbNS+uCIdP
         +0itdz6v38sGYfBOulLD7Kh4ue+zOgu+tirwAdcwCtZEsbl4wyBNLOtdqNfv9WY0jY28
         fUOFpVXlAyJq9SKNVDjlo1G5b5Zq6+OG1FD/dwDI/VhFnVrOcM+LSb0d9rksvw8uMitQ
         QI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728486171; x=1729090971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaKS53yTMSxp8Q9ePLUQ+BVB9n7Us0sPrHA8rLSAqgw=;
        b=niMyBwvXSH3EdWRm+S7/ysusEra8RDlFT6JuzIRnWIhw1ecnavm9GHsYz3rzsnDanN
         MTqJlNbPfxiI+BkZvfvMVsNxuxZhTUuB5WLd1Ca+F3QFoBOy4lNbq0MszmYEEB8J3t1n
         TIZID1FYPFItax4OmeHyiPVkG0ZD/zhUjHNxn6rPSlt+xKuRzz7I1Jt6lgwPwTxmLCNX
         iDzOu7HgxQOWTIF5BaB5TFGHfjlpG4ETHQzsv2fJpGxkp53qbXw6sviNmjGIaMwDwhKG
         lbCawUmHWqzvDPcHvuR0cWF6II15btmwpCLdqWbrasko1DYb/7pb9vp4Y0Pk09PPtUKY
         A8CA==
X-Forwarded-Encrypted: i=1; AJvYcCUojJCCBgwZusE/65L+FyyWcsvNUH9EJeM39a+ZRUfO+bb+zmmUWFPa9EeaPPcR99wvJsOmUtTFCC0=@vger.kernel.org, AJvYcCVC/ExAQ9NE5vMglL16CWXqsVgJOABBgNb3IzsqSHStmQ713bOvhXlpQW2pOfx7aYeizkkAPvxR@vger.kernel.org
X-Gm-Message-State: AOJu0YyLNbGAfs08VEQ9hPXHNNEVzyn7W1jwPpmzqoLc0lIhu3aUWqq2
	dLcSjtuwiGst11fA03gH0SSacVW4Jkax6d2bBwz7q4wqViqJMfYMlHGUg25xCmIP5COlBD8T6n/
	Ho/zGgUNu3Z9uhmO3Ctqv8S3LGCM=
X-Google-Smtp-Source: AGHT+IFVFdWxe5akt6EZLNX/2yNuQeocWxGJr1YJen3l9LxlG0R8AHcZNtUGHY6e1V1bp6yreDU+mm1Mx70nAjtBHdU=
X-Received: by 2002:a17:90a:c2c5:b0:2e2:a650:3070 with SMTP id
 98e67ed59e1d1-2e2a6503305mr3042587a91.4.1728486170882; Wed, 09 Oct 2024
 08:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-8-ap420073@gmail.com>
 <CAHS8izO-7pPk7xyY4JdyaY4hZpd7zerbjhGanRvaTk+OOsvY0A@mail.gmail.com>
 <CAMArcTU61G=fexf-RJDSW_sGp9dZCkJsJKC=yjg79RS9Ugjuxw@mail.gmail.com> <18255eaf-a2ce-4cd1-b47b-2482b6c42e08@davidwei.uk>
In-Reply-To: <18255eaf-a2ce-4cd1-b47b-2482b6c42e08@davidwei.uk>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 10 Oct 2024 00:02:37 +0900
Message-ID: <CAMArcTWsa3Z2Y4Kj-kNia7MsiosW74w56DvaoCQ=9eK5GwC0_w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/7] bnxt_en: add support for device memory tcp
To: David Wei <dw@davidwei.uk>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, kory.maincent@bootlin.com, andrew@lunn.ch, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, paul.greenwalt@intel.com, rrameshbabu@nvidia.com, 
	idosch@nvidia.com, asml.silence@gmail.com, kaiyuanz@google.com, 
	willemb@google.com, aleksander.lobakin@intel.com, sridhar.samudrala@intel.com, 
	bcreeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 11:57=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-10-04 03:34, Taehee Yoo wrote:
> > On Fri, Oct 4, 2024 at 3:43=E2=80=AFAM Mina Almasry <almasrymina@google=
.com> wrote:
> >>> @@ -3608,9 +3629,11 @@ static void bnxt_free_rx_rings(struct bnxt *bp=
)
> >>>
> >>>  static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
> >>>                                    struct bnxt_rx_ring_info *rxr,
> >>> +                                  int queue_idx,
> >>>                                    int numa_node)
> >>>  {
> >>>         struct page_pool_params pp =3D { 0 };
> >>> +       struct netdev_rx_queue *rxq;
> >>>
> >>>         pp.pool_size =3D bp->rx_agg_ring_size;
> >>>         if (BNXT_RX_PAGE_MODE(bp))
> >>> @@ -3621,8 +3644,15 @@ static int bnxt_alloc_rx_page_pool(struct bnxt=
 *bp,
> >>>         pp.dev =3D &bp->pdev->dev;
> >>>         pp.dma_dir =3D bp->rx_dir;
> >>>         pp.max_len =3D PAGE_SIZE;
> >>> -       pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> >>> +       pp.order =3D 0;
> >>> +
> >>> +       rxq =3D __netif_get_rx_queue(bp->dev, queue_idx);
> >>> +       if (rxq->mp_params.mp_priv)
> >>> +               pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_ALLOW_UNREADAB=
LE_NETMEM;
> >>
> >> This is not the intended use of PP_FLAG_ALLOW_UNREADABLE_NETMEM.
> >>
> >> The driver should set PP_FLAG_ALLOW_UNREADABLE_NETMEM when it's able
> >> to handle unreadable netmem, it should not worry about whether
> >> rxq->mp_params.mp_priv is set or not.
> >>
> >> You should set PP_FLAG_ALLOW_UNREADABLE_NETMEM when HDS is enabled.
> >> Let core figure out if mp_params.mp_priv is enabled. All the driver
> >> needs to report is whether it's configured to be able to handle
> >> unreadable netmem (which practically means HDS is enabled).
> >
> > The reason why the branch exists here is the PP_FLAG_ALLOW_UNREADABLE_N=
ETMEM
> > flag can't be used with PP_FLAG_DMA_SYNC_DEV.
> >
> >  228         if (pool->slow.flags & PP_FLAG_DMA_SYNC_DEV) {
> >  229                 /* In order to request DMA-sync-for-device the pag=
e
> >  230                  * needs to be mapped
> >  231                  */
> >  232                 if (!(pool->slow.flags & PP_FLAG_DMA_MAP))
> >  233                         return -EINVAL;
> >  234
> >  235                 if (!pool->p.max_len)
> >  236                         return -EINVAL;
> >  237
> >  238                 pool->dma_sync =3D true;                //here
> >  239
> >  240                 /* pool->p.offset has to be set according to the a=
ddress
> >  241                  * offset used by the DMA engine to start copying =
rx data
> >  242                  */
> >  243         }
> >
> > If PP_FLAG_DMA_SYNC_DEV is set, page->dma_sync is set to true.
> >
> > 347 int mp_dmabuf_devmem_init(struct page_pool *pool)
> > 348 {
> > 349         struct net_devmem_dmabuf_binding *binding =3D pool->mp_priv=
;
> > 350
> > 351         if (!binding)
> > 352                 return -EINVAL;
> > 353
> > 354         if (!pool->dma_map)
> > 355                 return -EOPNOTSUPP;
> > 356
> > 357         if (pool->dma_sync)                      //here
> > 358                 return -EOPNOTSUPP;
> > 359
> > 360         if (pool->p.order !=3D 0)
> > 361                 return -E2BIG;
> > 362
> > 363         net_devmem_dmabuf_binding_get(binding);
> > 364         return 0;
> > 365 }
> >
> > In the mp_dmabuf_devmem_init(), it fails when pool->dma_sync is true.
>
> This won't work for io_uring zero copy into user memory. We need all
> PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | PP_FLAG_ALLOW_UNREADABLE_NETMEM
> set.
>
> I agree with Mina that the driver should not be poking at the mp_priv
> fields. How about setting all the flags and then letting the mp->init()
> figure it out? mp_dmabuf_devmem_init() is called within page_pool_init()
> so as long as it resets dma_sync if set I don't see any issues.
>

Ah, I haven't thought the failure of PP_FLAG_DMA_SYNC_DEV
for dmabuf may be wrong.
IIUC this flag indicates sync between device and CPU.
But device memory TCP is not related to sync between device and CPU.
So, I think we need to remove this condition check code in the core.
How do you think about it?

> >
> > tcp-data-split can be used for normal cases, not only devmem TCP case.
> > If we enable tcp-data-split and disable devmem TCP, page_pool doesn't
> > have PP_FLAG_DMA_SYNC_DEV.
> > So I think mp_params.mp_priv is still useful.
> >
> > Thanks a lot,
> > Taehee Yoo
> >
> >>
> >>
> >> --
> >> Thanks,
> >> Mina

