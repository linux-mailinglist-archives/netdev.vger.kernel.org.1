Return-Path: <netdev+bounces-225800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446FEB985F5
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC1F37AABB9
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 06:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDB521D3C9;
	Wed, 24 Sep 2025 06:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhquH9Zd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D521A9F99
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 06:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758694934; cv=none; b=iAmmJ9IeqolcJAbJS+IAnLCbt4pSXZmCF4ajygj8rw2Ty2e6FyNZjijKnL1INhN6MTfgDnSLcHf6Rjoyg8PyBAVr4mjySZhuw3GyX9+3ZTh4AeaXo7RgBQrscPwn4gpNs2FFuRtcbKZXnguzg6yzbKCm9mab9lPNP9k9c3ll1zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758694934; c=relaxed/simple;
	bh=KobvBwKpwlasQmO06dps3c9fBIk1snJFTlVWMf2AOuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m96/otlU0CxebStGnFYJVcAtyZ/WcuuYv6db5QapZDw7JTmyuNlpSdL94IcN5QgMNjwFTxA6CbH31LPcmKZPFrZ6xSJQ3triFMZLzfqhMPseqlPL+FLTJMx53ZyQy6KGKaDp2MGoeT0OVsx7m7mmTF2DobI5jAXdxKMb4oN56lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IhquH9Zd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758694931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sk0+GMIf3cxkQMH5R3gUej1/otxyElKG3UC5gT8XNy8=;
	b=IhquH9ZdDfZjwcVcDPVedsYCDckSarq8YYJTToR2LAhPc4MA3FxGtVPu+HEoIx2X1PWmtJ
	1z8+6LF2h9ds1nDn1poEdR2IW9/rDVoG5rYKKASO2EqTnltKVf/lGyngdsJ8ntvYNpEhiy
	VJOr7e3patsvfoWm+aAM+3t3AvgqqAc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-g8OGZgOjPxecaRsPHlTgfg-1; Wed, 24 Sep 2025 02:22:10 -0400
X-MC-Unique: g8OGZgOjPxecaRsPHlTgfg-1
X-Mimecast-MFC-AGG-ID: g8OGZgOjPxecaRsPHlTgfg_1758694929
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45de27bf706so35442015e9.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 23:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758694929; x=1759299729;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk0+GMIf3cxkQMH5R3gUej1/otxyElKG3UC5gT8XNy8=;
        b=GT9IpjNgT13NDdJdSTfYpoFs3Ze6f8A8456bc+R4QLe92d4y/s/ErIBoN6zG9a8JfZ
         PIIV2QzI4pOvrqfsqQE+qhgKrku5a1YK/SSEke3aFGTzxr+Ophf4+kcMt+o0wsLD2G86
         5qbjOhdkjltc8gAdBguDGiiKjPgi8HEmztk+Hu95VWyjH+3EPrAHaBIBsstZ1hvtbkDH
         R70njAPV+oXRlPrxcp+RVpps7HzohevMYwm4YhNSHN/EvDeplbSXBu1F06OPPbqhtL6a
         qJtaMRp8YtQL11UCSSuXuFAyVZMUkVk6XzXtdBjOCB4xzMMMdhIQHyUlqUMlXIRUE9i9
         mZSA==
X-Forwarded-Encrypted: i=1; AJvYcCUAqh3dfv1i1iKS9x1dqZSLQxDuNAkza9AzpLdp4zsMhod1aQHNgWt5j/lOM/qD2fEASIzzuuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBJV98n4uYs2hcTktlw+mlfA1kudAdh/dHDa/LUCAOBPB41VUT
	ZUuKWuREFNYBtGANY6JaF6VDHrt2dLnstIWYd7ncA8pWgzwnOoBePTC1ZuKr9cj0SYJ0MEfnTcA
	9zRiCNrr6+bmVTBcpLYl7VBpSaFePJSHYHalXUDIZQZEeVFym3+NqfFI+pQ==
X-Gm-Gg: ASbGnct/WnmM8Ae2eAOVBZVH08BIfimlxe/5EdNDPIBaljgTGWx5H7cCvhpifghV3fB
	pf+5dp9l3GpJuS5RIX14r+a2/4sZIXWEkHfmuQdxKu+ZwgsG7YE4dbzDVbW4U6fUqLJA0xBFg+v
	XGw82eoXwRYcufCM+8Op77mD0ThMEaXuOExvg/TOf9IG0zAzTNa58Z6swUfWgvww5N18XOzKN/b
	xBEZXp51Bcl1a9R8jAi7rx2G32FAoEwopa1cZPpMB8bWaLpvpBwPuzHGxo0uRXAn9HCYtMLTZ7N
	FTph12CsJE9gYXCC50ZztDGaIw74tgeMD3I=
X-Received: by 2002:a05:600c:b8d:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-46e1d989005mr44960125e9.13.1758694928766;
        Tue, 23 Sep 2025 23:22:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHli0MPmSJHEHAtFFVAt/x+EZyqa+2JYMMUF1JFPFhBXHjcg6KBY7OZBD4HKYiN1xNl0pGnxw==
X-Received: by 2002:a05:600c:b8d:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-46e1d989005mr44959855e9.13.1758694928319;
        Tue, 23 Sep 2025 23:22:08 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e1dc48378sm23591255e9.8.2025.09.23.23.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 23:22:06 -0700 (PDT)
Date: Wed, 24 Sep 2025 02:22:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	alex.williamson@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
Message-ID: <20250924021637-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-2-danielj@nvidia.com>
 <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com>

On Wed, Sep 24, 2025 at 09:16:32AM +0800, Jason Wang wrote:
> On Tue, Sep 23, 2025 at 10:20 PM Daniel Jurgens <danielj@nvidia.com> wrote:
> >
> > Currently querying and setting capabilities is restricted to a single
> > capability and contained within the virtio PCI driver. However, each
> > device type has generic and device specific capabilities, that may be
> > queried and set. In subsequent patches virtio_net will query and set
> > flow filter capabilities.
> >
> > Move the admin related definitions to a new header file. It needs to be
> > abstracted away from the PCI specifics to be used by upper layer
> > drivers.
> >
> > Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> > Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> > ---
> 
> [...]
> 
> >
> >  size_t virtio_max_dma_size(const struct virtio_device *vdev);
> >
> > diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
> > new file mode 100644
> > index 000000000000..bbf543d20be4
> > --- /dev/null
> > +++ b/include/linux/virtio_admin.h
> > @@ -0,0 +1,68 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only
> > + *
> > + * Header file for virtio admin operations
> > + */
> > +#include <uapi/linux/virtio_pci.h>
> > +
> > +#ifndef _LINUX_VIRTIO_ADMIN_H
> > +#define _LINUX_VIRTIO_ADMIN_H
> > +
> > +struct virtio_device;
> > +
> > +/**
> > + * VIRTIO_CAP_IN_LIST - Check if a capability is supported in the capability list
> > + * @cap_list: Pointer to capability list structure containing supported_caps array
> > + * @cap: Capability ID to check
> > + *
> > + * The cap_list contains a supported_caps array of little-endian 64-bit integers
> > + * where each bit represents a capability. Bit 0 of the first element represents
> > + * capability ID 0, bit 1 represents capability ID 1, and so on.
> > + *
> > + * Return: 1 if capability is supported, 0 otherwise
> > + */
> > +#define VIRTIO_CAP_IN_LIST(cap_list, cap) \
> > +       (!!(1 & (le64_to_cpu(cap_list->supported_caps[cap / 64]) >> cap % 64)))
> > +
> > +/**
> > + * struct virtio_admin_ops - Operations for virtio admin functionality
> > + *
> > + * This structure contains function pointers for performing administrative
> > + * operations on virtio devices. All data and caps pointers must be allocated
> > + * on the heap by the caller.
> > + */
> > +struct virtio_admin_ops {
> > +       /**
> > +        * @cap_id_list_query: Query the list of supported capability IDs
> > +        * @vdev: The virtio device to query
> > +        * @data: Pointer to result structure (must be heap allocated)
> > +        * Return: 0 on success, negative error code on failure
> > +        */
> > +       int (*cap_id_list_query)(struct virtio_device *vdev,
> > +                                struct virtio_admin_cmd_query_cap_id_result *data);
> > +       /**
> > +        * @cap_get: Get capability data for a specific capability ID
> > +        * @vdev: The virtio device
> > +        * @id: Capability ID to retrieve
> > +        * @caps: Pointer to capability data structure (must be heap allocated)
> > +        * @cap_size: Size of the capability data structure
> > +        * Return: 0 on success, negative error code on failure
> > +        */
> > +       int (*cap_get)(struct virtio_device *vdev,
> > +                      u16 id,
> > +                      void *caps,
> > +                      size_t cap_size);
> > +       /**
> > +        * @cap_set: Set capability data for a specific capability ID
> > +        * @vdev: The virtio device
> > +        * @id: Capability ID to set
> > +        * @caps: Pointer to capability data structure (must be heap allocated)
> > +        * @cap_size: Size of the capability data structure
> > +        * Return: 0 on success, negative error code on failure
> > +        */
> > +       int (*cap_set)(struct virtio_device *vdev,
> > +                      u16 id,
> > +                      const void *caps,
> > +                      size_t cap_size);
> > +};
> 
> Looking at this, it's nothing admin virtqueue specific, I wonder why
> it is not part of virtio_config_ops.
> 
> Thanks

cap things are admin commands. But what I do not get is why they
need to be callbacks.

The only thing about admin commands that is pci specific is finding
the admin vq.

I'd expect an API for that in config then, and the rest of code can
be completely transport independent.


-- 
MST


