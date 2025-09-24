Return-Path: <netdev+bounces-225757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23664B97FD6
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 03:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02A01AE26B8
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 01:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACC21F8908;
	Wed, 24 Sep 2025 01:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JU1Ajycz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5451DB95E
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 01:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676610; cv=none; b=IWJ7RMQGaWYg8zP3gP+DMyjGOzwxVhfY+2jnqZlXr//YS11YctC4xJ9pGgSdznQ63G6LA3A1hLPTO26JM5b4VzTIeW9yWj6OCnuvSkRJ9CamsusYGM6wgg9wFV7fAa77wGXzz/LmdfmHT4SSkb7Jk1rnUhWLfASgOFnpctvRNVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676610; c=relaxed/simple;
	bh=A37mvEVaESR9ERs99IPcDOLra8qkZubx6sUnWAZs6gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNhgzvVvDFbattb4VfV5TfeIpGQz9IGcJRZaiQdw7cTb/PyHHobJsEZyy83a8OtlILAYVmJzOeiSn0LfYAZFycj4LbN0Nt7YfON392kwq//5JZu1V+rkCFxBZBo19mfXKRhpRix5AuLiaCGS7+DyKe8pPi9+AgZzQBjEn8Kt0c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JU1Ajycz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758676607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OyDZ+fFvNiHT1HqmIdQBeq5LnfgvaLlQ7Rr3LfU20CE=;
	b=JU1AjyczNdKjEQCz91yQxIu6pslkU4iIJeSA9HIdWzHRXKbjbrg7dLI8TkVVssSKea0w9J
	N4fgmn7Rap8eUGr5IizaXHXyML3wOAPIldJ+4AUscYvYbmZWFdJlWPTo2haMOWCPQ9e9vW
	tQ+TMaCk/89vLhnUQ60p3xoCLtMLFsU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-VCXIJq3gMeOPIsQxym02rw-1; Tue, 23 Sep 2025 21:16:45 -0400
X-MC-Unique: VCXIJq3gMeOPIsQxym02rw-1
X-Mimecast-MFC-AGG-ID: VCXIJq3gMeOPIsQxym02rw_1758676605
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3307af9b595so4328736a91.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 18:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758676605; x=1759281405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyDZ+fFvNiHT1HqmIdQBeq5LnfgvaLlQ7Rr3LfU20CE=;
        b=i4R7MoO5qrOli6icsqj8828evzZ1gCdi9dRPv3Eczt9m8VmU1Al6TiIfUcPTZeTIl2
         ZtD4B8CT6LHEqsWjRWMKdtMRVsk5bqAQ0N4GowDfxv76deB301J03YPua7XIUL/pUEA9
         oMLSye1KzAEutHPTO3EbeP1fl9TVw5WEVnPICCkiW7ot6emX8Tg2XZO0+4KtPIUD//Ik
         Lp6duyk3vIszQRqO448WuIX33CZvZZnSd+ynTrpNsaZO6L0wRf8m7CBpDbItBzUrfgs9
         IsXc6KygcqRAWUYranvbl+TFKwX6A5/ZTc8SM8jTFaThZ0VC6MZa18JYtWBzEhwdD7CM
         /bLA==
X-Gm-Message-State: AOJu0YxF0p8bWZ9ej+kUYxCMyyKnWth/iXjzLbrDgU6BCqXQ4L699kGf
	ODd2H+/FHD+vkz2C8reyEot6ycq9IgeqolXTfD7Z2gr2Q7RFeUHe07QILbxweipxIu1DEJ3KsMj
	WMRvRHQvioj3UPSQmm0ukqMStgshbmDC8dhaf8EBMZdg1qUqF5J+va3M4+Z5U+XlBkbBKv55KoY
	zKs/12TupZs2x6+4YrJDyVIhex4ddpqE1S
X-Gm-Gg: ASbGncuDCP5Qr9/LQq2LhSLFgJLZNgJ0jJDeSniZ9xI3B/jk0Tn2pqKh4St/iYo2GWR
	mdfKeZwGZoV3OnO9HrZRaYYXr9Entq+fz/+UQUP9zxCwaJ9TBS59aZFZUnwZQdIGbEOknGrTLlq
	LtGMumKAS3Zj6bqaZRng==
X-Received: by 2002:a17:90b:2787:b0:32e:9daa:7347 with SMTP id 98e67ed59e1d1-332a92c9d80mr5114666a91.7.1758676604630;
        Tue, 23 Sep 2025 18:16:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs73M9j2BtC1//YXJzQkXNW+3YPImYGOnyy6pQKBAcyQFPHjntIsqG+Q8iHg4YeF4Q32lErt4BqBZ2IoYHWWs=
X-Received: by 2002:a17:90b:2787:b0:32e:9daa:7347 with SMTP id
 98e67ed59e1d1-332a92c9d80mr5114636a91.7.1758676604146; Tue, 23 Sep 2025
 18:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923141920.283862-1-danielj@nvidia.com> <20250923141920.283862-2-danielj@nvidia.com>
In-Reply-To: <20250923141920.283862-2-danielj@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 09:16:32 +0800
X-Gm-Features: AS18NWDhGgiNINZrLH8_-LM_Y57n9a7onhAJNax7urmMViSZxqMJ6y0IOuE6oz8
Message-ID: <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, alex.williamson@redhat.com, 
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com, 
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, 
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch, 
	edumazet@google.com, Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 10:20=E2=80=AFPM Daniel Jurgens <danielj@nvidia.com=
> wrote:
>
> Currently querying and setting capabilities is restricted to a single
> capability and contained within the virtio PCI driver. However, each
> device type has generic and device specific capabilities, that may be
> queried and set. In subsequent patches virtio_net will query and set
> flow filter capabilities.
>
> Move the admin related definitions to a new header file. It needs to be
> abstracted away from the PCI specifics to be used by upper layer
> drivers.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> ---

[...]

>
>  size_t virtio_max_dma_size(const struct virtio_device *vdev);
>
> diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
> new file mode 100644
> index 000000000000..bbf543d20be4
> --- /dev/null
> +++ b/include/linux/virtio_admin.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
> + * Header file for virtio admin operations
> + */
> +#include <uapi/linux/virtio_pci.h>
> +
> +#ifndef _LINUX_VIRTIO_ADMIN_H
> +#define _LINUX_VIRTIO_ADMIN_H
> +
> +struct virtio_device;
> +
> +/**
> + * VIRTIO_CAP_IN_LIST - Check if a capability is supported in the capabi=
lity list
> + * @cap_list: Pointer to capability list structure containing supported_=
caps array
> + * @cap: Capability ID to check
> + *
> + * The cap_list contains a supported_caps array of little-endian 64-bit =
integers
> + * where each bit represents a capability. Bit 0 of the first element re=
presents
> + * capability ID 0, bit 1 represents capability ID 1, and so on.
> + *
> + * Return: 1 if capability is supported, 0 otherwise
> + */
> +#define VIRTIO_CAP_IN_LIST(cap_list, cap) \
> +       (!!(1 & (le64_to_cpu(cap_list->supported_caps[cap / 64]) >> cap %=
 64)))
> +
> +/**
> + * struct virtio_admin_ops - Operations for virtio admin functionality
> + *
> + * This structure contains function pointers for performing administrati=
ve
> + * operations on virtio devices. All data and caps pointers must be allo=
cated
> + * on the heap by the caller.
> + */
> +struct virtio_admin_ops {
> +       /**
> +        * @cap_id_list_query: Query the list of supported capability IDs
> +        * @vdev: The virtio device to query
> +        * @data: Pointer to result structure (must be heap allocated)
> +        * Return: 0 on success, negative error code on failure
> +        */
> +       int (*cap_id_list_query)(struct virtio_device *vdev,
> +                                struct virtio_admin_cmd_query_cap_id_res=
ult *data);
> +       /**
> +        * @cap_get: Get capability data for a specific capability ID
> +        * @vdev: The virtio device
> +        * @id: Capability ID to retrieve
> +        * @caps: Pointer to capability data structure (must be heap allo=
cated)
> +        * @cap_size: Size of the capability data structure
> +        * Return: 0 on success, negative error code on failure
> +        */
> +       int (*cap_get)(struct virtio_device *vdev,
> +                      u16 id,
> +                      void *caps,
> +                      size_t cap_size);
> +       /**
> +        * @cap_set: Set capability data for a specific capability ID
> +        * @vdev: The virtio device
> +        * @id: Capability ID to set
> +        * @caps: Pointer to capability data structure (must be heap allo=
cated)
> +        * @cap_size: Size of the capability data structure
> +        * Return: 0 on success, negative error code on failure
> +        */
> +       int (*cap_set)(struct virtio_device *vdev,
> +                      u16 id,
> +                      const void *caps,
> +                      size_t cap_size);
> +};

Looking at this, it's nothing admin virtqueue specific, I wonder why
it is not part of virtio_config_ops.

Thanks


