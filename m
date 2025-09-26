Return-Path: <netdev+bounces-226592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D6EBA26A1
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 06:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85178168E6A
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8AA2737EA;
	Fri, 26 Sep 2025 04:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="huXFQuat"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA47072633
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 04:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758862531; cv=none; b=tPRQ2w0kyruX31ude29TdR4HCBe/kE70lYt5fzdupPdVKcQDuVARB2Lz8e4dm/ld+QUUuIuAo8VtvOy21TqeVa+VPg7znf0Ze3EBwMZ0C5vMzwHJrCx2vdNfkkX1SEj5+LJHyQBtOtB+KSFnNkskSfw/0YXFEDB3hCJwpbY8LHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758862531; c=relaxed/simple;
	bh=Nej2v9PMt/WcbamJ+FX4ohIqCRqaL0Mql+6Jr/x2r7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/EEldkTrz0jPiTjP5dh+h3bz/ftrPCC9yA0GybXkNMSWXcNk3JoRa45xt4si8MNhoB2dHXtCL11/pFZUyNKuYhqFUxLgFula7bAbrFccrFsVyBtBWSh7I+N5XZHu1wK0bZ0Y84n+8w7KQwooQr+/cBRihi9wmvEuS6a4JfgFQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=huXFQuat; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758862527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXIPhhw4tWLJ9v89faJ+PM4VIR9L03wMvBqNbKspOp8=;
	b=huXFQuatLzatF17uX8jmZOBnRgD8BRKzFG548r5yhSwBsiHwxdnSwmBItSoVdUWf77oaZ0
	diNLYP9B976ihr/REdUYUxTTdx81zlD+J+nR92nTp4yF3zDumhtV1Fvbkw7cuLfwFDm1QV
	URGa+qtNbig6xVJg503XzUxoC28zxjk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-FrEE7bACNfOngOs5ZZSWbg-1; Fri, 26 Sep 2025 00:55:26 -0400
X-MC-Unique: FrEE7bACNfOngOs5ZZSWbg-1
X-Mimecast-MFC-AGG-ID: FrEE7bACNfOngOs5ZZSWbg_1758862525
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33428befc08so3580748a91.2
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 21:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758862525; x=1759467325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXIPhhw4tWLJ9v89faJ+PM4VIR9L03wMvBqNbKspOp8=;
        b=w4gM9wSbvGJV7+CN7TTkAoM53RYZDlNEOSB0nbv38AdCiDrjrARUTdN2i0eWSeXqLI
         Pm3ftZ/XbtSND3Hod1JkURC7TkZl8UDFxGmrRjNQAusaOJzQzr5tOXPweAKa0WJZHQ6j
         7qKnyqwrlOv0tRq5KvD79Zkm2ObBQCiHVIZFDN1ENX2zgHmwCJxpovf4hY+LU6JYODeP
         gXCqk+EdS1hjz7BxwqqFrTxmIK1NDB7B1uhIcq5e6w6NbDVdFAZAD+SlA72O/viPaJKX
         46XTAIaaLhjaKhBrl/z2FhwqPx0BQtlVGGf9FlkXf7WidzVG7MTJuDo2b8uhdzE9Wtdk
         zuhg==
X-Forwarded-Encrypted: i=1; AJvYcCU/HsUcZi6M9gMOcs8y6zheKv1xymt2/C6noXyUrg7rY7ooBj8nDZpZMQDulLFu9zlURZ4devA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU158Ne/Sp3YSUCBVL7ry/7NDCBuq37p/ipvtdekembqwyHtgD
	iQcUpr8E7BWeWBN2Bfl818OJSvPKNweeIoby2jCefmY0D5OIXvWGny58EuBUozMFL8JAq1Njqnf
	Ksd14pDtDTC5dOUfIpJxRLe9eiSNSbgiVxOtCqgkD3G897gGkDv/qackiVdQZU5z9G6FvVrOzrY
	xfzNLU0E9EBuH/It4Rx1/f92nwR7pw2VYh
X-Gm-Gg: ASbGnctnzQPcBd00mMnw+0kf7gIUPglDFtReJjiiHfz5oT3mGbUb4dr6uAH5y55Hf/S
	SVuNRP/ZLrAfjuxSNp5ggdjvdLQvBAwp0suWolrK1WBxPSULvxaGFgV3G0wfqodd4cnzz40HW5s
	kfB9QYnFBKJUyfpzDxhA==
X-Received: by 2002:a17:90b:3a8b:b0:330:4604:3ab6 with SMTP id 98e67ed59e1d1-3342a2b119emr6309519a91.18.1758862524855;
        Thu, 25 Sep 2025 21:55:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhepOtBGMOoRmGAMGYvLYEEoIZzIxWPaI1wxI6nM9zltZDzQ31wVU9ghnTwZpyBnsfgfU1312VbBySpCVKrvw=
X-Received: by 2002:a17:90b:3a8b:b0:330:4604:3ab6 with SMTP id
 98e67ed59e1d1-3342a2b119emr6309485a91.18.1758862524392; Thu, 25 Sep 2025
 21:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923141920.283862-1-danielj@nvidia.com> <20250923141920.283862-2-danielj@nvidia.com>
 <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com> <20250924021637-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250924021637-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Sep 2025 12:55:11 +0800
X-Gm-Features: AS18NWAP5nE5bSzUngmD74vhSZHIuWlJH1On-rHDVx-a53FiiQzgeN7bupN4ojc
Message-ID: <CACGkMEuWRUANBCkeE5r+7+wob3nr-Mrnce_kLRHbpeF0OT_45Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org, alex.williamson@redhat.com, 
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com, 
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, 
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch, 
	edumazet@google.com, Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 2:22=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Sep 24, 2025 at 09:16:32AM +0800, Jason Wang wrote:
> > On Tue, Sep 23, 2025 at 10:20=E2=80=AFPM Daniel Jurgens <danielj@nvidia=
.com> wrote:
> > >
> > > Currently querying and setting capabilities is restricted to a single
> > > capability and contained within the virtio PCI driver. However, each
> > > device type has generic and device specific capabilities, that may be
> > > queried and set. In subsequent patches virtio_net will query and set
> > > flow filter capabilities.
> > >
> > > Move the admin related definitions to a new header file. It needs to =
be
> > > abstracted away from the PCI specifics to be used by upper layer
> > > drivers.
> > >
> > > Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> > > Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> > > ---
> >
> > [...]
> >
> > >
> > >  size_t virtio_max_dma_size(const struct virtio_device *vdev);
> > >
> > > diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admi=
n.h
> > > new file mode 100644
> > > index 000000000000..bbf543d20be4
> > > --- /dev/null
> > > +++ b/include/linux/virtio_admin.h
> > > @@ -0,0 +1,68 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only
> > > + *
> > > + * Header file for virtio admin operations
> > > + */
> > > +#include <uapi/linux/virtio_pci.h>
> > > +
> > > +#ifndef _LINUX_VIRTIO_ADMIN_H
> > > +#define _LINUX_VIRTIO_ADMIN_H
> > > +
> > > +struct virtio_device;
> > > +
> > > +/**
> > > + * VIRTIO_CAP_IN_LIST - Check if a capability is supported in the ca=
pability list
> > > + * @cap_list: Pointer to capability list structure containing suppor=
ted_caps array
> > > + * @cap: Capability ID to check
> > > + *
> > > + * The cap_list contains a supported_caps array of little-endian 64-=
bit integers
> > > + * where each bit represents a capability. Bit 0 of the first elemen=
t represents
> > > + * capability ID 0, bit 1 represents capability ID 1, and so on.
> > > + *
> > > + * Return: 1 if capability is supported, 0 otherwise
> > > + */
> > > +#define VIRTIO_CAP_IN_LIST(cap_list, cap) \
> > > +       (!!(1 & (le64_to_cpu(cap_list->supported_caps[cap / 64]) >> c=
ap % 64)))
> > > +
> > > +/**
> > > + * struct virtio_admin_ops - Operations for virtio admin functionali=
ty
> > > + *
> > > + * This structure contains function pointers for performing administ=
rative
> > > + * operations on virtio devices. All data and caps pointers must be =
allocated
> > > + * on the heap by the caller.
> > > + */
> > > +struct virtio_admin_ops {
> > > +       /**
> > > +        * @cap_id_list_query: Query the list of supported capability=
 IDs
> > > +        * @vdev: The virtio device to query
> > > +        * @data: Pointer to result structure (must be heap allocated=
)
> > > +        * Return: 0 on success, negative error code on failure
> > > +        */
> > > +       int (*cap_id_list_query)(struct virtio_device *vdev,
> > > +                                struct virtio_admin_cmd_query_cap_id=
_result *data);
> > > +       /**
> > > +        * @cap_get: Get capability data for a specific capability ID
> > > +        * @vdev: The virtio device
> > > +        * @id: Capability ID to retrieve
> > > +        * @caps: Pointer to capability data structure (must be heap =
allocated)
> > > +        * @cap_size: Size of the capability data structure
> > > +        * Return: 0 on success, negative error code on failure
> > > +        */
> > > +       int (*cap_get)(struct virtio_device *vdev,
> > > +                      u16 id,
> > > +                      void *caps,
> > > +                      size_t cap_size);
> > > +       /**
> > > +        * @cap_set: Set capability data for a specific capability ID
> > > +        * @vdev: The virtio device
> > > +        * @id: Capability ID to set
> > > +        * @caps: Pointer to capability data structure (must be heap =
allocated)
> > > +        * @cap_size: Size of the capability data structure
> > > +        * Return: 0 on success, negative error code on failure
> > > +        */
> > > +       int (*cap_set)(struct virtio_device *vdev,
> > > +                      u16 id,
> > > +                      const void *caps,
> > > +                      size_t cap_size);
> > > +};
> >
> > Looking at this, it's nothing admin virtqueue specific, I wonder why
> > it is not part of virtio_config_ops.
> >
> > Thanks
>
> cap things are admin commands. But what I do not get is why they
> need to be callbacks.
>
> The only thing about admin commands that is pci specific is finding
> the admin vq.

I think we had a discussion to decide to separate admin commands from
the admin vq.

Thanks


