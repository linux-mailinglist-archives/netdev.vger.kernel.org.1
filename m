Return-Path: <netdev+bounces-83206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A898789158B
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 10:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0AD1C21964
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 09:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603D43A1B6;
	Fri, 29 Mar 2024 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blqDfH/M"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E46E39FCE
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703618; cv=none; b=Y3ilS7zlRP71L3TkLFrVM+MTnUnNLeeHKJarnPIaBmH/oxa2AJYn6emh6kyu1nm3uqrqHRgMqlGas2RmyKQ+qa7H1hMasWj0KfP0MLLY7zdXl3g3i2tFF6Da1TFqdKfjkjMexK6M6yGrehnxdrZzivVreZT5RC+SIwcldwu/4Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703618; c=relaxed/simple;
	bh=ZzOyyShpi+BiQtFAim7d9NqPxf08YSqXbBroJ+fc20s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRXNoA2zbo7br6ebEdfCNrzlOTNWecnOW9Y3D/TCeMb4ZDnWswObbMFqT/OSgRezB6ebjO1xQphPwDewW8bdK/Jwj2t+MW+Yb4pF9tQLqLjRRwSCxE8mtgXWg1ohGnvpw4ML1bE8fmGfd8ZbtIM5NCRvjD+XAf9j2CGoELdaSao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blqDfH/M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711703615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M29eATaMP812c87lcBCnQpGGf3JpvPt6m4mFibtAKn0=;
	b=blqDfH/Ma+dP0DjyNnvkXNDG9Ved7hWRvXiKbscYZbBUPjP5cDCDLT+hvOhe/YLlNJAbsM
	ZSLhpBYTVvgp2/cgOhWlC1SY9Fckz6fu0uWCkVMQImO1mKeuEgtforrWLVss2huXsaltqX
	zexBV1kxjTtRIcAeBVnGO+W15IdNG0k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-IBkVm6wgP9aBBrfE6R31JA-1; Fri, 29 Mar 2024 05:13:32 -0400
X-MC-Unique: IBkVm6wgP9aBBrfE6R31JA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4147e733d20so8788255e9.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 02:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711703612; x=1712308412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M29eATaMP812c87lcBCnQpGGf3JpvPt6m4mFibtAKn0=;
        b=s7dtZJRQnw8N1wRQfjW0KE771kWpp0Pok+2w44HNMhwgH8+QV2eyX5++9F79P/YmTb
         YpUvWlbXRRWKZsZOe8RPY6buEU0eGKrGyxCXNduHHP1AYbek+WOG1CeUGdkbcnZMop6I
         uzwUsIITXLK71Q0mIzyCMZmOTVLFBefXsDHJqiJElGFIyZw46l+k8R+srZ3ilsgGCA0q
         EUFmjLKad7b4tC1hX0keJvIQIa9FsjuJDY9XKSTH7dqympUlvB6Q8Uc9gEzUfAFgGmzh
         qs65qV+IZs6EU6WYtURkX6QYWSGsxqQXRk9MHtH93y2kJwbsGVIMZnhQ7QaoUaKUgXlr
         0KOg==
X-Forwarded-Encrypted: i=1; AJvYcCW3302BZZiQozUAg2aKx+FtalYU1jtfykryDJ4pE4CyPHgGDFnJ+na1AHsAXtkZ4G7n+l5pM/wZlugNQcNIqpUuIlvy6McL
X-Gm-Message-State: AOJu0Yw0Dou6BXeJT4vy0DSqnoY1QkSrbRyYPBSPIPhhItKY9u9u69Yg
	kL2vXmwgfwfNqbv49NWjvHmQwBnZzFwvB/MrTgM0X/8vBPptM/wJHYAvLjheI0pD7fwxBXlH+/y
	bLoru+skPJauqyvGtGaGjvUDLPt7fZsMR1SVS328FdslvEVnHGEQXBQ==
X-Received: by 2002:a05:600c:5253:b0:413:f3f0:c591 with SMTP id fc19-20020a05600c525300b00413f3f0c591mr1643228wmb.41.1711703611686;
        Fri, 29 Mar 2024 02:13:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaT97DmM3XHKaPJzW87s7ILZ0Tic5EcrjSdHB6wE1GOPhFxPAb4mZrXHL6ciaT1JEf0Tu2eg==
X-Received: by 2002:a05:600c:5253:b0:413:f3f0:c591 with SMTP id fc19-20020a05600c525300b00413f3f0c591mr1643199wmb.41.1711703611093;
        Fri, 29 Mar 2024 02:13:31 -0700 (PDT)
Received: from redhat.com ([2.52.20.36])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c314900b004147b824b08sm4832088wmo.7.2024.03.29.02.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:13:30 -0700 (PDT)
Date: Fri, 29 Mar 2024 05:13:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Wang Rong <w_angrong@163.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
Message-ID: <20240329051117-mutt-send-email-mst@kernel.org>
References: <20240320101912.28210-1-w_angrong@163.com>
 <20240321025920-mutt-send-email-mst@kernel.org>
 <CACGkMEuHRf0ZfBiAYxyNHB3pxuzz=QCWt5VyHPLz-+-+LM=+bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuHRf0ZfBiAYxyNHB3pxuzz=QCWt5VyHPLz-+-+LM=+bg@mail.gmail.com>

On Wed, Mar 27, 2024 at 05:08:57PM +0800, Jason Wang wrote:
> On Thu, Mar 21, 2024 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Mar 20, 2024 at 06:19:12PM +0800, Wang Rong wrote:
> > > From: Rong Wang <w_angrong@163.com>
> > >
> > > Once enable iommu domain for one device, the MSI
> > > translation tables have to be there for software-managed MSI.
> > > Otherwise, platform with software-managed MSI without an
> > > irq bypass function, can not get a correct memory write event
> > > from pcie, will not get irqs.
> > > The solution is to obtain the MSI phy base address from
> > > iommu reserved region, and set it to iommu MSI cookie,
> > > then translation tables will be created while request irq.
> > >
> > > Change log
> > > ----------
> > >
> > > v1->v2:
> > > - add resv iotlb to avoid overlap mapping.
> > > v2->v3:
> > > - there is no need to export the iommu symbol anymore.
> > >
> > > Signed-off-by: Rong Wang <w_angrong@163.com>
> >
> > There's in interest to keep extending vhost iotlb -
> > we should just switch over to iommufd which supports
> > this already.
> 
> IOMMUFD is good but VFIO supports this before IOMMUFD.

You mean VFIO migrated to IOMMUFD but of course they keep supporting
their old UAPI? OK and point being?

> This patch
> makes vDPA run without a backporting of full IOMMUFD in the production
> environment. I think it's worth.

Where do we stop? saying no to features is the only tool maintainers
have to make cleanups happen, otherwise people will just keep piling
stuff up.

> If you worry about the extension, we can just use the vhost iotlb
> existing facility to do this.
> 
> Thanks
> 
> >
> > > ---
> > >  drivers/vhost/vdpa.c | 59 +++++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 56 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index ba52d128aeb7..28b56b10372b 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -49,6 +49,7 @@ struct vhost_vdpa {
> > >       struct completion completion;
> > >       struct vdpa_device *vdpa;
> > >       struct hlist_head as[VHOST_VDPA_IOTLB_BUCKETS];
> > > +     struct vhost_iotlb resv_iotlb;
> > >       struct device dev;
> > >       struct cdev cdev;
> > >       atomic_t opened;
> > > @@ -247,6 +248,7 @@ static int _compat_vdpa_reset(struct vhost_vdpa *v)
> > >  static int vhost_vdpa_reset(struct vhost_vdpa *v)
> > >  {
> > >       v->in_batch = 0;
> > > +     vhost_iotlb_reset(&v->resv_iotlb);
> > >       return _compat_vdpa_reset(v);
> > >  }
> > >
> > > @@ -1219,10 +1221,15 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
> > >           msg->iova + msg->size - 1 > v->range.last)
> > >               return -EINVAL;
> > >
> > > +     if (vhost_iotlb_itree_first(&v->resv_iotlb, msg->iova,
> > > +                                     msg->iova + msg->size - 1))
> > > +             return -EINVAL;
> > > +
> > >       if (vhost_iotlb_itree_first(iotlb, msg->iova,
> > >                                   msg->iova + msg->size - 1))
> > >               return -EEXIST;
> > >
> > > +
> > >       if (vdpa->use_va)
> > >               return vhost_vdpa_va_map(v, iotlb, msg->iova, msg->size,
> > >                                        msg->uaddr, msg->perm);
> > > @@ -1307,6 +1314,45 @@ static ssize_t vhost_vdpa_chr_write_iter(struct kiocb *iocb,
> > >       return vhost_chr_write_iter(dev, from);
> > >  }
> > >
> > > +static int vhost_vdpa_resv_iommu_region(struct iommu_domain *domain, struct device *dma_dev,
> > > +     struct vhost_iotlb *resv_iotlb)
> > > +{
> > > +     struct list_head dev_resv_regions;
> > > +     phys_addr_t resv_msi_base = 0;
> > > +     struct iommu_resv_region *region;
> > > +     int ret = 0;
> > > +     bool with_sw_msi = false;
> > > +     bool with_hw_msi = false;
> > > +
> > > +     INIT_LIST_HEAD(&dev_resv_regions);
> > > +     iommu_get_resv_regions(dma_dev, &dev_resv_regions);
> > > +
> > > +     list_for_each_entry(region, &dev_resv_regions, list) {
> > > +             ret = vhost_iotlb_add_range_ctx(resv_iotlb, region->start,
> > > +                             region->start + region->length - 1,
> > > +                             0, 0, NULL);
> > > +             if (ret) {
> > > +                     vhost_iotlb_reset(resv_iotlb);
> > > +                     break;
> > > +             }
> > > +
> > > +             if (region->type == IOMMU_RESV_MSI)
> > > +                     with_hw_msi = true;
> > > +
> > > +             if (region->type == IOMMU_RESV_SW_MSI) {
> > > +                     resv_msi_base = region->start;
> > > +                     with_sw_msi = true;
> > > +             }
> > > +     }
> > > +
> > > +     if (!ret && !with_hw_msi && with_sw_msi)
> > > +             ret = iommu_get_msi_cookie(domain, resv_msi_base);
> > > +
> > > +     iommu_put_resv_regions(dma_dev, &dev_resv_regions);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > >  static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
> > >  {
> > >       struct vdpa_device *vdpa = v->vdpa;
> > > @@ -1335,11 +1381,16 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
> > >
> > >       ret = iommu_attach_device(v->domain, dma_dev);
> > >       if (ret)
> > > -             goto err_attach;
> > > +             goto err_alloc_domain;
> > >
> > > -     return 0;
> > > +     ret = vhost_vdpa_resv_iommu_region(v->domain, dma_dev, &v->resv_iotlb);
> > > +     if (ret)
> > > +             goto err_attach_device;
> > >
> > > -err_attach:
> > > +     return 0;
> > > +err_attach_device:
> > > +     iommu_detach_device(v->domain, dma_dev);
> > > +err_alloc_domain:
> > >       iommu_domain_free(v->domain);
> > >       v->domain = NULL;
> > >       return ret;
> > > @@ -1595,6 +1646,8 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
> > >               goto err;
> > >       }
> > >
> > > +     vhost_iotlb_init(&v->resv_iotlb, 0, 0);
> > > +
> > >       r = dev_set_name(&v->dev, "vhost-vdpa-%u", minor);
> > >       if (r)
> > >               goto err;
> > > --
> > > 2.27.0
> > >
> >


