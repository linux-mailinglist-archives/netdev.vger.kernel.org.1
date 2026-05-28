Return-Path: <netdev+bounces-292562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FjFKMPYF2pCTAgAu9opvQ
	(envelope-from <netdev+bounces-292562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 07:55:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FD35ED0D7
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 07:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 867B83008D33
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 05:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC963164B4;
	Thu, 28 May 2026 05:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="tbSbpLMQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6456313545
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 05:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779947710; cv=fail; b=luqqF/syBmR8c+i9d/bkTRKNOAGgc/qmUpigUEVZUqe2YrwiuEPaBeaBIC0AxA/t1Af+nrGu699JB7qD+T/ciT/r7+mzxuasfAYO21sof67b60dJNhK3CYxH9dIUSnGMxTBiP1FSdc5JkLkWtRLsKOTERAK5T/D0G7wchzwULGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779947710; c=relaxed/simple;
	bh=5iwsiCJ1qeiS0l/pE9qpH/G/kMlLOpTQJgijlOnz9I8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bO76WVGlxi6IyNlEYbF3/kZCcL2Df9BcGw0GCVvkFCJ21BYrKgpCnq+IV7Sg7Q24q2tkM+F4xRoCSHTwVkvhhFZddQ9gYs7dB4k0F3ybHdRYomESS8OT6AWo9XdTh4pOSw2hpAZ8MetK5AwQ8nQdR7rU5IQ4hl/8oW5fX8iZo9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=tbSbpLMQ; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKj1S81009720
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 22:55:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=fCWJk+yJSEw0QmMgTgm6c5hQ8WDFshVgdpTjabTs05U=; b=tbSbpLMQe9V1
	fRrJsZLmCEINOnKwTwP24JHLpfkIKwEepx/Dh3tfucJeXjyBmxUl4K+3pzS40lhe
	Vk0KGeyW3V3XwtowE8EShojrRZa6LzLLYzZHk0cQiurg9iLcff5bt/+GGIVjUhJg
	GS2yjzLlbBm1Fz4V9mfBh9ZrCRYNbh87Q2e58QbU0kZl0LslSz8HIGX1FN2WqmJn
	V6u86OtEtfnMzSmkk0ZLjfBzjM5sNOAWRA7g+AaUWdIpOcgd0eCkAao9PZ/W168l
	EQ62MMb9iFTIqzogr6WSS9W4iYEsdvQL/qDgcEewoSbDNuHTRvFxM9ZwvkmAy0OU
	GhfeODKKwA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x1jesj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 22:55:07 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e3a223b936so26998380a34.3
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 22:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779947707; cv=none;
        d=google.com; s=arc-20240605;
        b=NjtwKnYR8i9rte0tiKRbQesLhEQnsyjqCKaTd0P5PHzgMHR2Np5vDBSbVGHCePC53t
         VoD765lqlhFbp50SZ3KywlNKOZskqorlVQO/JQxWCrhkOvHDrKpONbLckh8WWrJ3fkrp
         aKBQOKBhBrQTmNpSO+7jgyz9R7vSraRQDwQ2PE6uNnjG/ND8ijU1k7myk3DKu7yGrKJT
         rDASga9yX4f7K3HZRASZNwF24j6hr6YauK9dpTQcKaOSAFDiCWB7nNnO6BqkbaHq4ZeH
         UY0re82DYNbpFwMeYrfWP/ipXJNHxgqLGIPQ1aQ6UZaa7RpDdhqEHu0vfAWphxlTAn7Q
         FbyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=7OjunUEtjbIoqlgaeDvI71z7AvyuDzMU0DogPcHFH+E=;
        fh=QRLRdUaCR58fkh8s2g0TUBXd6DktAVq1Uk89RjkEFb4=;
        b=RIRfcXlH+0XIe4B863WZdKhAqvO/Owx9Jr+LHL7dvxAcKxV6QiYCW1iTRmkkL5nDA9
         E1pDTsUQNqTNEhRkUMk0AqG0BbbpBcTXDblcD2NKHyYpb6pCwxZddfh2Y3LBLB/xGBkq
         Mvk3UixwDHQtUidxcgM5kE0LgWX6uASxk6nWpyC/2NxDpMwc+68ET7CoQfg/cxMagEZ6
         1giJp2T/ZyXevxlwxYm1mqkZCdbR2tWI95ANFeHTVBzab89bOFa4VkYA5GliG2vVucLU
         GKaLfAzJ+acP2uJ8XylhXjrR8oHMDseSoMP1NiorFPOd5yT/O4ZEWgyOjRFTV77JVNds
         SEjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779947707; x=1780552507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7OjunUEtjbIoqlgaeDvI71z7AvyuDzMU0DogPcHFH+E=;
        b=AjJWqXnrLw8WsINgLmtWPBhDelqVPXsHtbgQTrZCPqAj2B/D7j+wMRbJkn3UmYrCZE
         cuLas0tX4UAnv5tPPaRlkSrxV/vEQqx8xKaIWdXeIPJhN7Cs7c5l0VjcxlxgMxm+6fRP
         zo82fdmLx3ZbuydRqW5CUTFyOjGJWFKFgGznLRs6sDRJIfW3DnFXb1bAO9TxlL/6BOGS
         Yzbx6Rm0Hiy2FfHnJnEm9dcJZUTlMM/f6lAP5Sqi7KckT/BPeHqIwC9a8StGukGzn/Uy
         nIQwlfbolq5S68RImu89AByvfeOFfb5hYSH6PQhRrM5ur8bDSte22GJ3ky3hYvM8k4rK
         6NKA==
X-Forwarded-Encrypted: i=1; AFNElJ95AP7H6ZSTLE0ROAMcK+MFb4BeaFdzoxf8TQIuVktiQYpdFThBASHt/AThrHWYZBk6n1mCGxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9WcMqtKOk0qcMynOe6beyzVfBsip/zvuKHD5QzLIpVgSFcN+c
	f/T2OtNPe8OsiuUf0FHEqjDrLcHqTpwcR9ESFzRKt8GwX38AFcABrK7WGO56AwcASXHe6/Lwb8z
	hQzDrHNJUS8eDiVOalJYh5vNi94pjfy58+j9TIFlTI3x8qZ+YahesR74CdN97soPXNcNeTyWNAi
	IrLoIKlVYpM7eVGZ4zl4SjP3FXixSthFc=
X-Gm-Gg: Acq92OEX+Upy+FIJ90YfdmVuQbP4bNpYoL2fJTzBTru6/iRDYyTIS71p3UZAc7Vy/yl
	QYGDo0USgFb63MnoFXzzAf3hROzQoi1R/tmJHnN4E3EkWqIOfb7eNf4zuANUiFp8NxuwJZnHV4S
	pYi5UPiUZjv0lA1q8iQ8CIjRlyImcMxYpWkk/xYi3QK6v18xIdOGz22ScSxAvS5xS3BLACd+IZL
	nBFWu9N4FaLxLhx6Qc7rPthPRTH6qziVD0msWm0C2ixcZsRGgk=
X-Received: by 2002:a05:6830:6d4d:b0:7d7:f158:1f44 with SMTP id 46e09a7af769-7e5feef5d68mr16377931a34.21.1779947706903;
        Wed, 27 May 2026 22:55:06 -0700 (PDT)
X-Received: by 2002:a05:6830:6d4d:b0:7d7:f158:1f44 with SMTP id
 46e09a7af769-7e5feef5d68mr16377893a34.21.1779947706138; Wed, 27 May 2026
 22:55:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com> <20260526144401.1485788-5-zhipingz@meta.com>
 <20260527130045.704a4502@shazbot.org>
In-Reply-To: <20260527130045.704a4502@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 27 May 2026 22:54:54 -0700
X-Gm-Features: AVHnY4ICjE7MkEm4LXONvDpsmeBdG0UBYV3y_krDxSXZVAQVCJMknB8fJo9QBXs
Message-ID: <CAH3zFs2RuXC06tkg2gBNMLfBuL4FXzu+AV_axEh+ZnzdGCo1XQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA1NiBTYWx0ZWRfX4ylZY7moOaVi
 screnfpcCk/fbgZiQDnOZLnoIcIYm+I5Hneun6ZTPzaZmxkBt985N8d4jdQbCGUC1lfI0miZAdX
 b6mn3sSWxx4/rg/e0u3L6bLduxSZlxKzQiIVA9uEErs5VeNOfYX8Hbtht/oXRuJV4YfApQuvDRx
 sLvfZN8MYtboU0+pAP70FcpgVirfxcDpmjHrK1KoBuQx5xsfW41KexDJzrFhmGrtg9mO59khIus
 rGqRhmtSI0IKeP0RF+Zcsldxnj9j8/gwi+8Koy0HyQDhRe6jjkvhCff2sRhI+9fh+XVjGZVytFI
 4cakwqVLvwKfVdjIWkvSfKnlF41nENTK2wVTQMkpwkt1tVBNoG0Dw6PQgS+vN+KxolAbvcAjV9f
 XcymfzjtdLood/7tH+p6kRHtY5RQym/RI/tFrmfoC+mVQ7Vyq6vVdcQyrGKHYAzouhSBTQ29Fii
 +RUTwbjKVhISFZRqV7g==
X-Proofpoint-ORIG-GUID: IRV-UEW9vlueIi81tu4X3h3m2RZ9SkyX
X-Authority-Analysis: v=2.4 cv=M7h97Sws c=1 sm=1 tr=0 ts=6a17d8bb cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=25xbtWhBidXVKMBX-WEA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: IRV-UEW9vlueIi81tu4X3h3m2RZ9SkyX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292562-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shazbot.org:email,mail.gmail.com:mid,meta.com:email,meta.com:dkim]
X-Rspamd-Queue-Id: A1FD35ED0D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 12:00=E2=80=AFPM Alex Williamson <alex@shazbot.org>=
 wrote:
>
> >
> On Tue, 26 May 2026 07:43:56 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Query dma-buf TPH metadata when registering a dma-buf MR for peer-to-
> > peer access and translate the returned steering tag into an mlx5 ST
> > index. Keep the DMAH path as the first priority and only fall back to
> > DMA-buf metadata when no DMAH is supplied.
> >
> > Track per-MR ownership of the allocated ST index and release it on MR
> > setup failure, destroy, and FRMR-pool reuse. Release the ST index before
> > the MR is pushed back into the FRMR pool, and free mlx5_st_idx_data when
> > its refcount reaches zero so repeated allocation/deallocation does not
> > leak memory.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  6 ++
> >  drivers/infiniband/hw/mlx5/mr.c               | 86 ++++++++++++++++++-
> >  .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 28 ++++--
> >  include/linux/mlx5/driver.h                   |  7 ++
> >  4 files changed, 115 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/=
hw/mlx5/mlx5_ib.h
> > index e156dc4d7529..4ab867392267 100644
> > --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > @@ -721,6 +721,12 @@ struct mlx5_ib_mr {
> >                       u8 revoked :1;
> >                       /* Indicates previous dmabuf page fault occurred =
*/
> >                       u8 dmabuf_faulted:1;
> > +                     /* Set when the MR owns dmabuf_st_index and must
> > +                      * release it via mlx5_st_dealloc_index() once the
> > +                      * firmware mkey is no longer referencing it.
> > +                      */
> > +                     u8 dmabuf_st_owned:1;
> > +                     u16 dmabuf_st_index;
> >                       struct mlx5_ib_mkey null_mmkey;
> >               };
> >       };
> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/ml=
x5/mr.c
> > index 3b6da45061a5..8059b5e4da97 100644
> > --- a/drivers/infiniband/hw/mlx5/mr.c
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/dma-buf.h>
> >  #include <linux/dma-resv.h>
> > +#include <linux/pci-tph.h>
> >  #include <rdma/frmr_pools.h>
> >  #include <rdma/ib_umem_odp.h>
> >  #include "dm.h"
> > @@ -46,6 +47,8 @@
> >  #include "data_direct.h"
> >  #include "dmah.h"
> >
> > +MODULE_IMPORT_NS("DMA_BUF");
> > +
>
> This doesn't appear to add any dma-buf namespace dependencies.
>

sure let me check and drop if not necessary.

> >  static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
> >  {
> >       if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
> > @@ -899,6 +902,63 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_at=
tach_ops =3D {
> >       .invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
> >  };
> >
> > +/*
> > + * Query TPH metadata from @dmabuf and translate the raw steering tag =
into
> > + * an mlx5 ST index. On success, returns 0 and the caller becomes the
> > + * owner of *@st_index (must be released with mlx5_st_dealloc_index()
> > + * once the firmware mkey no longer references it). On any failure
> > + * *@st_index and *@ph are left as the no-TPH defaults set by the call=
er.
> > + *
> > + * @dmabuf must already be referenced by the caller (e.g. via the umem=
's
> > + * attachment) so we don't re-resolve the user's fd here and avoid a
> > + * dup2() TOCTOU between umem creation and TPH lookup.
> > + */
> > +static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, struct dma_buf =
*dmabuf,
> > +                           u16 *st_index, u8 *ph)
> > +{
> > +     u8 req_type;
> > +     u16 steering_tag;
> > +     u8 st_width;
> > +     int ret;
> > +
> > +     if (!dmabuf->ops->get_tph)
> > +             return;
> > +
> > +     req_type =3D pcie_tph_enabled_req_type(dev->mdev->pdev);
> > +     switch (req_type) {
> > +     case PCI_TPH_REQ_TPH_ONLY:
> > +             st_width =3D 8;
> > +             break;
> > +     case PCI_TPH_REQ_EXT_TPH:
> > +             st_width =3D 16;
> > +             break;
> > +     default:
> > +             return;
> > +     }
> > +
> > +     ret =3D dmabuf->ops->get_tph(dmabuf, &steering_tag, ph, st_width);
> > +     if (ret) {
> > +             mlx5_ib_dbg(dev, "get_tph failed (%d)\n", ret);
> > +             *ph =3D MLX5_IB_NO_PH;
> > +             return;
> > +     }
> > +
> > +     ret =3D mlx5_st_alloc_index_by_tag(dev->mdev, steering_tag, st_in=
dex);
> > +     if (ret) {
> > +             *ph =3D MLX5_IB_NO_PH;
> > +             mlx5_ib_dbg(dev, "st_alloc_index_by_tag failed (%d)\n", r=
et);
> > +     }
> > +}
>
> ph handling is inconsistent, why not use a local variable and only set
> the caller's pointer on success?
>

good point -- will do that.

> > +
> > +static void mlx5_ib_mr_put_dmabuf_st(struct mlx5_ib_mr *mr)
> > +{
> > +     if (mr->umem && mr->dmabuf_st_owned) {
> > +             mlx5_st_dealloc_index(mr_to_mdev(mr)->mdev,
> > +                                   mr->dmabuf_st_index);
> > +             mr->dmabuf_st_owned =3D 0;
> > +     }
> > +}
> > +
> >  static struct ib_mr *
> >  reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
> >                  u64 offset, u64 length, u64 virt_addr,
> > @@ -941,16 +1001,26 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct devi=
ce *dma_device,
> >               ph =3D dmah->ph;
> >               if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
> >                       st_index =3D mdmah->st_index;
> > +     } else {
> > +             get_tph_mr_dmabuf(dev, umem_dmabuf->attach->dmabuf,
> > +                               &st_index, &ph);
> >       }
> >
> >       mr =3D alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
> >                               access_flags, access_mode,
> >                               st_index, ph);
> >       if (IS_ERR(mr)) {
> > +             if (!dmah && st_index !=3D MLX5_MKC_PCIE_TPH_NO_STEERING_=
TAG_INDEX)
> > +                     mlx5_st_dealloc_index(dev->mdev, st_index);
> >               ib_umem_release(&umem_dmabuf->umem);
> >               return ERR_CAST(mr);
> >       }
> >
> > +     if (!dmah && st_index !=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDE=
X) {
> > +             mr->dmabuf_st_index =3D st_index;
> > +             mr->dmabuf_st_owned =3D 1;
> > +     }
> > +
> >       mlx5_ib_dbg(dev, "mkey 0x%x\n", mr->mmkey.key);
> >
> >       atomic_add(ib_umem_num_pages(mr->umem), &dev->mdev->priv.reg_page=
s);
> > @@ -1377,9 +1447,17 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5=
_ib_mr *mr)
> >       bool is_odp =3D is_odp_mr(mr);
> >       int ret;
> >
> > -     if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr) &&
> > -         !ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
> > -             return 0;
> > +     if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr)) {
> > +             /*
> > +              * The mkey has been revoked: firmware no longer referenc=
es
> > +              * dmabuf_st_index, so release it before this mr can re-e=
nter
> > +              * the FRMR cache for reuse by another registration.
> > +              */
> > +             mlx5_ib_mr_put_dmabuf_st(mr);
> > +
> > +             if (!ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
> > +                     return 0;
> > +     }
> >
> >       if (is_odp)
> >               mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
> > @@ -1400,6 +1478,8 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_=
ib_mr *mr)
> >               dma_resv_unlock(
> >                       to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv=
);
> >       }
> > +     if (!ret)
> > +             mlx5_ib_mr_put_dmabuf_st(mr);
> >       return ret;
> >  }
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers=
/net/ethernet/mellanox/mlx5/core/lib/st.c
> > index 997be91f0a13..8929c17c88bc 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> > @@ -29,7 +29,7 @@ struct mlx5_st *mlx5_st_create(struct mlx5_core_dev *=
dev)
> >       u8 direct_mode =3D 0;
> >       u16 num_entries;
> >       u32 tbl_loc;
> > -     int ret;
> > +     int ret =3D 0;
>
> Unnecessary change.
>

ack, will check and revert.

> >
> >       if (!MLX5_CAP_GEN(dev, mkey_pcie_tph))
> >               return NULL;
> > @@ -92,23 +92,18 @@ void mlx5_st_destroy(struct mlx5_core_dev *dev)
> >       kfree(st);
> >  }
> >
> > -int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type m=
em_type,
> > -                     unsigned int cpu_uid, u16 *st_index)
> > +int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
> > +                            u16 *st_index)
> >  {
> >       struct mlx5_st_idx_data *idx_data;
> >       struct mlx5_st *st =3D dev->st;
> >       unsigned long index;
> >       u32 xa_id;
> > -     u16 tag;
> > -     int ret;
> > +     int ret =3D 0;
> >
> >       if (!st)
> >               return -EOPNOTSUPP;
> >
> > -     ret =3D pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
> > -     if (ret)
> > -             return ret;
> > -
> >       if (st->direct_mode) {
> >               *st_index =3D tag;
> >               return 0;
> > @@ -152,6 +147,20 @@ int mlx5_st_alloc_index(struct mlx5_core_dev *dev,=
 enum tph_mem_type mem_type,
> >       mutex_unlock(&st->lock);
> >       return ret;
> >  }
> > +EXPORT_SYMBOL_GPL(mlx5_st_alloc_index_by_tag);
> > +
> > +int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type m=
em_type,
> > +                     unsigned int cpu_uid, u16 *st_index)
> > +{
> > +     u16 tag;
> > +     int ret;
> > +
> > +     ret =3D pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return mlx5_st_alloc_index_by_tag(dev, tag, st_index);
> > +}
> >  EXPORT_SYMBOL_GPL(mlx5_st_alloc_index);
> >
> >  int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
> > @@ -175,6 +184,7 @@ int mlx5_st_dealloc_index(struct mlx5_core_dev *dev=
, u16 st_index)
> >
> >       if (refcount_dec_and_test(&idx_data->usecount)) {
> >               xa_erase(&st->idx_xa, st_index);
> > +             kfree(idx_data);
> >               /* We leave PCI config space as was before, no mkey will =
refer to it */
> >       }
>
> Should this be pulled out as a fix separate from the feature added
> here?  Thanks,
>
> Alex
>

Yes, will split it out as its own patch.

Thanks,
Zhiping

