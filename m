Return-Path: <netdev+bounces-80947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C91881C62
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 07:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81881F22172
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 06:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1155F38F99;
	Thu, 21 Mar 2024 06:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsdy1iMi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616C9883C
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 06:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711001490; cv=none; b=p69LmLOiBY/yu+85kirMULLvN824RIxtTBUcIFXHoGiyRRpuGqmqECbggAQjP4JagVRLoTAu0a/+pPP+eB/yGHP8BPJjEiQa7pzWG0dLb5OwgnJEK2gQwi8kPg634Um9dgInJFMj1QmtVJ86SbiW8SyX8Jh7W8nPXDHimQpCn7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711001490; c=relaxed/simple;
	bh=nS3ZtkcmRWYQhNRSA+8PL8l9Y6ENrB3adeY74KvxwmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DA21OKHgBfo/OLSpIoHQzBjZRjIUippcyLw2znzywWEUTSGZrBolkTEzJIfKYQCPj8ZBSv8ZxKsbni32XCPw1H+nqnojpWQm+rkdSj7bEWPsBy5qbJmUl4hBzyg6dOzsjVBV93aIBH4GnDC54pK0XJW3HsQqYKvDf9l5f/TUWNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsdy1iMi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711001487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRr6w2hmwgDNs0vVbChBiZJi7/+SS06endfvm4wx2Qo=;
	b=gsdy1iMimCz1El2RBlf7BpXJDpxPDJDA0IzveM0Kp1GEm1eIbx5Vr11o0Glt8KACuBGxcL
	fDYWaPIx/LIAZ/AlT6Jjk5ip7e9EqupxsRjmTRp5WYMDhBj5G1zPgcDFFif/bIL5waCzZg
	oa+Ai32Z3WyNEmX8beKxRNNueqGTVoQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-4SLgwePeN7OBv1IWXyQq5g-1; Thu, 21 Mar 2024 02:11:25 -0400
X-MC-Unique: 4SLgwePeN7OBv1IWXyQq5g-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29de982f09aso527129a91.1
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 23:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711001484; x=1711606284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRr6w2hmwgDNs0vVbChBiZJi7/+SS06endfvm4wx2Qo=;
        b=EmdDiSr9U+vXx5uRbqPLPBqcJ2Mlr38+BSURK2AOeQTTmHv7D1JhzwPeKuD0repkCo
         EOs4Zi/k85Rb1xjAgLQ67SCvqfN/b628c8Vew3hIuVjLKyFGKtKZYawk3tmQFe++jK+E
         n9W/gam39EVhJ45X+TJBYRt0qN7x3HSaJPGfTVLs4VmE8XzPpcQK7LSPqzxVrJGw8wRV
         AqKc1Du75QRG0VCUeZ0P9dJ4kOc4QfSe/f+tO7kcQ2tHtgPzQ/yNqnBiLiGB7rodG6l0
         xrbgfVVwn/SLImFcPx1J7uNhnVLIjM7n9XpK3mmssOvR1ZOTLB5qPglQZ6DVYYMeb4K4
         hwSw==
X-Forwarded-Encrypted: i=1; AJvYcCXh4FgIP1kcl7oHi8XZuRjcmvaNRVlAHmzOJB3DC6JG6niwSL9EDb5pnTDwBh6TY/lmfP68802oKxf0G3voWl5UU9TtuvAo
X-Gm-Message-State: AOJu0YwrYmHjaR2od76MNlaockxslx1Z7TGBfWbpKur8a1w3o7XB9KuC
	R0g0zJf6sUmmagHy74EOIy4Nm1dHD20NT6sOCRfHeY31FOUDidpRyBQhBsuHccpBbee6zV+fZVe
	st3asueTlHz7iv8BDC59n9TTYLrDvpZH9DpAqXsbnyUx1Mv3mFtSSsrdPdE5/xf0uxMsEInmybF
	1IskKKJASfpB2GDDCGzZ30nSBTBCXC
X-Received: by 2002:a17:90a:ee94:b0:29d:dd93:5865 with SMTP id i20-20020a17090aee9400b0029ddd935865mr6337690pjz.46.1711001484416;
        Wed, 20 Mar 2024 23:11:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMJs5m8yPCol1xvp4yJO6WcRnRdD98Sx8BFnN7+XFFZjVg6pV1bOfqeO7BXwqMn4EG2HGLFM86gzFGtPZgAf4=
X-Received: by 2002:a17:90a:ee94:b0:29d:dd93:5865 with SMTP id
 i20-20020a17090aee9400b0029ddd935865mr6337683pjz.46.1711001484139; Wed, 20
 Mar 2024 23:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320101912.28210-1-w_angrong@163.com>
In-Reply-To: <20240320101912.28210-1-w_angrong@163.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Mar 2024 14:11:13 +0800
Message-ID: <CACGkMEst2ixZrtBUEWArQT+CkDqzSr9E3V7qMyVU6xX+FnBChA@mail.gmail.com>
Subject: Re: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To: Wang Rong <w_angrong@163.com>
Cc: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 6:20=E2=80=AFPM Wang Rong <w_angrong@163.com> wrote=
:
>
> From: Rong Wang <w_angrong@163.com>
>
> Once enable iommu domain for one device, the MSI
> translation tables have to be there for software-managed MSI.
> Otherwise, platform with software-managed MSI without an
> irq bypass function, can not get a correct memory write event
> from pcie, will not get irqs.
> The solution is to obtain the MSI phy base address from
> iommu reserved region, and set it to iommu MSI cookie,
> then translation tables will be created while request irq.
>
> Change log
> ----------
>
> v1->v2:
> - add resv iotlb to avoid overlap mapping.
> v2->v3:
> - there is no need to export the iommu symbol anymore.
>
> Signed-off-by: Rong Wang <w_angrong@163.com>
> ---
>  drivers/vhost/vdpa.c | 59 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 56 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ba52d128aeb7..28b56b10372b 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -49,6 +49,7 @@ struct vhost_vdpa {
>         struct completion completion;
>         struct vdpa_device *vdpa;
>         struct hlist_head as[VHOST_VDPA_IOTLB_BUCKETS];
> +       struct vhost_iotlb resv_iotlb;

Is it better to introduce a reserved flag like VHOST_MAP_RESERVED,
which means it can't be modified by the userspace but the kernel.

So we don't need to have two IOTLB. But I guess the reason you have
this is because we may have multiple address spaces where the MSI
routing should work for all of them?

Another note, vhost-vDPA support virtual address mapping, so this
should only work for physicall address mapping. E.g in the case of
SVA, MSI iova is a valid IOVA for the driver/usrespace.

>         struct device dev;
>         struct cdev cdev;
>         atomic_t opened;
> @@ -247,6 +248,7 @@ static int _compat_vdpa_reset(struct vhost_vdpa *v)
>  static int vhost_vdpa_reset(struct vhost_vdpa *v)
>  {
>         v->in_batch =3D 0;
> +       vhost_iotlb_reset(&v->resv_iotlb);

We try hard to avoid this for performance, see this commit:

commit 4398776f7a6d532c466f9e41f601c9a291fac5ef
Author: Si-Wei Liu <si-wei.liu@oracle.com>
Date:   Sat Oct 21 02:25:15 2023 -0700

    vhost-vdpa: introduce IOTLB_PERSIST backend feature bit

Any reason you need to do this?

>         return _compat_vdpa_reset(v);
>  }
>
> @@ -1219,10 +1221,15 @@ static int vhost_vdpa_process_iotlb_update(struct=
 vhost_vdpa *v,
>             msg->iova + msg->size - 1 > v->range.last)
>                 return -EINVAL;
>
> +       if (vhost_iotlb_itree_first(&v->resv_iotlb, msg->iova,
> +                                       msg->iova + msg->size - 1))
> +               return -EINVAL;
> +
>         if (vhost_iotlb_itree_first(iotlb, msg->iova,
>                                     msg->iova + msg->size - 1))
>                 return -EEXIST;
>
> +
>         if (vdpa->use_va)
>                 return vhost_vdpa_va_map(v, iotlb, msg->iova, msg->size,
>                                          msg->uaddr, msg->perm);
> @@ -1307,6 +1314,45 @@ static ssize_t vhost_vdpa_chr_write_iter(struct ki=
ocb *iocb,
>         return vhost_chr_write_iter(dev, from);
>  }
>
> +static int vhost_vdpa_resv_iommu_region(struct iommu_domain *domain, str=
uct device *dma_dev,
> +       struct vhost_iotlb *resv_iotlb)
> +{
> +       struct list_head dev_resv_regions;
> +       phys_addr_t resv_msi_base =3D 0;
> +       struct iommu_resv_region *region;
> +       int ret =3D 0;
> +       bool with_sw_msi =3D false;
> +       bool with_hw_msi =3D false;
> +
> +       INIT_LIST_HEAD(&dev_resv_regions);
> +       iommu_get_resv_regions(dma_dev, &dev_resv_regions);
> +
> +       list_for_each_entry(region, &dev_resv_regions, list) {
> +               ret =3D vhost_iotlb_add_range_ctx(resv_iotlb, region->sta=
rt,
> +                               region->start + region->length - 1,
> +                               0, 0, NULL);

I think MSI should be write-only?

> +               if (ret) {
> +                       vhost_iotlb_reset(resv_iotlb);

Need to report an error here.

Thanks


