Return-Path: <netdev+bounces-231267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7E9BF6B8D
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC69189A9EF
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D12337113;
	Tue, 21 Oct 2025 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpqWPr9T"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F3337106
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052748; cv=none; b=eACrq8z2xfMUlwOfEthUxsg5oaXoZda2GUzGqjfWuf8nDFNUVngUd8zVGlzRNKvRJrdBi8XHcVTcK2oofptzykcwrNH+jFfn2Qqtn8cVCZbxNyzLsKBB8QKNZnNBY9HmoSbOJsbCfFKALAmsv6NZcXyBIA21+2aLH2FhIHbtHRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052748; c=relaxed/simple;
	bh=sdLmUEH26XowGBrTWRXJMGQrGAqJ47/hyyiAmDOyQhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFhFBBBm3nUszqsy6wF1Zkdt2+gF2sM9VIHxLY1MC9W7oU9Je2KC9eNAi1u5j7gmUXxN7GZfPNEQVNc+AVyBaxalQV6cTQ70+nLOiXNeq9iv6F4fPM/RjMll8qm+AzS74Vj1KP8cXRaNovLje93r9QujMEC9YskgnC5nhfRqQms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EpqWPr9T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761052745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1lds4wyZVZiggRHaZgmaEbJR6xg3S5j6QKIFJyJiO04=;
	b=EpqWPr9TzHRPgnKW1/qIU57FUAfWdsPqz48esIE+DbOEwLoFF2Vu0r1JDKYlcqzgfflB4r
	awA0VKMAq7APvjyZNx5U/wh54ZJF943eFklKC3cKAVjRae9R2ED6TXgLdLXFs/zCSwjuTf
	1qhnTp8u+8PzJ4Ynekuu/pluUS5UvW8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-wOyhX8nZMJO5fCXsxv9ffw-1; Tue, 21 Oct 2025 09:19:04 -0400
X-MC-Unique: wOyhX8nZMJO5fCXsxv9ffw-1
X-Mimecast-MFC-AGG-ID: wOyhX8nZMJO5fCXsxv9ffw_1761052743
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47111dc7c35so38932655e9.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 06:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052743; x=1761657543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lds4wyZVZiggRHaZgmaEbJR6xg3S5j6QKIFJyJiO04=;
        b=WRXq1iz/hez8Mu2hOKV5jDorkYm6B/laTvEHEdZkH6mwPZnIbSBZKFn491g0HmzyXN
         ED9nbAiqKWGl7EDt+ufaUijia3xKxQAKWNgjMUIv39V2X0wi3FRi+S5a+de7tETLSkjE
         kWZ33mfHsipHsN6iyz/1+wWdFUuUCnZeSNnt4kwvUtc0KKSzf0QBO9h7yf4s5thpn2Mu
         6YQUL8d6bPXpodkBtVBu0AAQ9qd8+U/reHEfYJifbc9Pom9oKesi1HIKQq2FKC1+ALCa
         67nUR8tbuKBEd8f/JQLIFImTOI/UIWEtOPeatBkoW3he5pZf1h9/FnHn7Qg8WNaZ0pbR
         oGlw==
X-Gm-Message-State: AOJu0YxVHNvljCginwKvCW/xpN7TuBAXUrKYbo9g29Z7v7cBwQCGqgZC
	SvoEWhlhxf7bh5TjyfHkCNze/yG+vdQiCucq0cHoeEFDo67Oc2tpg6TREBK5XLbAmMOH6eENsDy
	ZBbbYdTYaDsUl7wJ80GrYVvkSEsLost5zJM3AWmMioFzY1AliwZym0BI8zg==
X-Gm-Gg: ASbGncvj4lCqWQiqlYA/aXD25OTrFVojVfNIpL32sgwVhpcYf+2VJv3Tk61PUNbbNtQ
	zpayrBy159w8W3y5nLA7rVi1MhcuIT7su7MLAopIOB4FbD0qrqH9PjBC+eUpYOlSPcvVkNeDVFJ
	GA2lF3m7AliTudvimilv471VaydRkv0fzCTFnCVEbvGc1Hrvi6yFg23rn1lqHhLmd25mUSfBoH3
	7Hv1mqjE4t8GebOP2qL/+JMN4mKsZjZCfHoKmN+VrKX2lq1ksVkXlFDkPAqJzUizYW5e3dycfpc
	GM7NqI1rRRsAwq7Ud1IgHqMuxpHGlGr++MWmQALv9cN29OuyB8lgk/3xJliKk3dVSAA9
X-Received: by 2002:a05:600c:190b:b0:471:a24:497c with SMTP id 5b1f17b1804b1-47117919b54mr131020575e9.33.1761052742555;
        Tue, 21 Oct 2025 06:19:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlVliBDv6bkYNLgUySEiFeNI5oLnjZJGQfSlr71PAh+0V3Zs2SF8F9wwVfCbXkwfFMgOJ3nw==
X-Received: by 2002:a05:600c:190b:b0:471:a24:497c with SMTP id 5b1f17b1804b1-47117919b54mr131020295e9.33.1761052741969;
        Tue, 21 Oct 2025 06:19:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496d23237sm16153635e9.10.2025.10.21.06.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:19:01 -0700 (PDT)
Date: Tue, 21 Oct 2025 09:18:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v5 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <20251021091259-mutt-send-email-mst@kernel.org>
References: <20251016050055.2301-1-danielj@nvidia.com>
 <20251016050055.2301-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016050055.2301-6-danielj@nvidia.com>

On Thu, Oct 16, 2025 at 12:00:48AM -0500, Daniel Jurgens wrote:
> +	/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
> +	for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
> +		ff_mask_size += get_mask_size(i);
> +
> +	ff->ff_mask = kzalloc(ff_mask_size, GFP_KERNEL);
> +	if (!ff->ff_mask)
> +		goto err_ff;
> +
> +	err = virtio_admin_cap_get(vdev,
> +				   VIRTIO_NET_FF_SELECTOR_CAP,
> +				   ff->ff_mask,
> +				   ff_mask_size);
> +
> +	if (err)
> +		goto err_ff_mask;
> +
> +	ff->ff_actions = kzalloc(sizeof(*ff->ff_actions) +
> +					VIRTIO_NET_FF_ACTION_MAX,
> +					GFP_KERNEL);
> +	if (!ff->ff_actions)
> +		goto err_ff_mask;
> +
> +	err = virtio_admin_cap_get(vdev,
> +				   VIRTIO_NET_FF_ACTION_CAP,
> +				   ff->ff_actions,
> +				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
> +
> +	if (err)
> +		goto err_ff_action;
> +
> +	err = virtio_admin_cap_set(vdev,
> +				   VIRTIO_NET_FF_RESOURCE_CAP,
> +				   ff->ff_caps,
> +				   sizeof(*ff->ff_caps));
> +	if (err)
> +		goto err_ff_action;
> +
> +	ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);

overriding ff_mask_size seems unncessarily funky.
use a variable reflecting what this is?


> +	sel = &ff->ff_mask->selectors[0];
> +
> +	for (i = 0; i < ff->ff_mask->count; i++) {
> +		if (sel->length > MAX_SEL_LEN) {
> +			err = -EINVAL;
> +			goto err_ff_action;
> +		}

You also need to validate this is all within allocated size.

> +		ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
> +		sel = (void *)sel + sizeof(*sel) + sel->length;

> +	}
> +
> +	err = virtio_admin_cap_set(vdev,
> +				   VIRTIO_NET_FF_SELECTOR_CAP,
> +				   ff->ff_mask,
> +				   ff_mask_size);
> +	if (err)
> +		goto err_ff_action;
> +
> +	err = virtio_admin_cap_set(vdev,
> +				   VIRTIO_NET_FF_ACTION_CAP,
> +				   ff->ff_actions,
> +				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
> +	if (err)
> +		goto err_ff_action;
> +
> +	ff->vdev = vdev;
> +	ff->ff_supported = true;
> +
> +	kfree(cap_id_list);
> +
> +	return;
> +
> +err_ff_action:
> +	kfree(ff->ff_actions);
> +err_ff_mask:
> +	kfree(ff->ff_mask);
> +err_ff:
> +	kfree(ff->ff_caps);
> +err_cap_list:
> +	kfree(cap_id_list);
> +}
> +
> +static void virtnet_ff_cleanup(struct virtnet_ff *ff)
> +{
> +	if (!ff->ff_supported)
> +		return;
> +
> +	kfree(ff->ff_actions);
> +	kfree(ff->ff_mask);
> +	kfree(ff->ff_caps);
> +}
> +
>  static int virtnet_probe(struct virtio_device *vdev)
>  {
>  	int i, err = -ENOMEM;
> @@ -7116,6 +7277,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	}
>  	vi->guest_offloads_capable = vi->guest_offloads;
>  
> +	virtnet_ff_init(&vi->ff, vi->vdev);
> +
>  	rtnl_unlock();
>  
>  	err = virtnet_cpu_notif_add(vi);
> @@ -7131,6 +7294,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  free_unregister_netdev:
>  	unregister_netdev(dev);
> +	virtnet_ff_cleanup(&vi->ff);
>  free_failover:
>  	net_failover_destroy(vi->failover);
>  free_vqs:
> @@ -7180,6 +7344,7 @@ static void virtnet_remove(struct virtio_device *vdev)
>  	virtnet_free_irq_moder(vi);
>  
>  	unregister_netdev(vi->dev);
> +	virtnet_ff_cleanup(&vi->ff);
>  
>  	net_failover_destroy(vi->failover);
>  
> diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
> index 039b996f73ec..db0f42346ca9 100644
> --- a/include/linux/virtio_admin.h
> +++ b/include/linux/virtio_admin.h
> @@ -3,6 +3,7 @@
>   * Header file for virtio admin operations
>   */
>  #include <uapi/linux/virtio_pci.h>
> +#include <uapi/linux/virtio_net_ff.h>
>  
>  #ifndef _LINUX_VIRTIO_ADMIN_H
>  #define _LINUX_VIRTIO_ADMIN_H
> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
> new file mode 100644
> index 000000000000..1a4738889403
> --- /dev/null
> +++ b/include/uapi/linux/virtio_net_ff.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
> + *
> + * Header file for virtio_net flow filters
> + */
> +#ifndef _LINUX_VIRTIO_NET_FF_H
> +#define _LINUX_VIRTIO_NET_FF_H
> +
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +
> +#define VIRTIO_NET_FF_RESOURCE_CAP 0x800
> +#define VIRTIO_NET_FF_SELECTOR_CAP 0x801
> +#define VIRTIO_NET_FF_ACTION_CAP 0x802
> +
> +/**
> + * struct virtio_net_ff_cap_data - Flow filter resource capability limits
> + * @groups_limit: maximum number of flow filter groups supported by the device
> + * @classifiers_limit: maximum number of classifiers supported by the device
> + * @rules_limit: maximum number of rules supported device-wide across all groups
> + * @rules_per_group_limit: maximum number of rules allowed in a single group
> + * @last_rule_priority: priority value associated with the lowest-priority rule
> + * @selectors_per_classifier_limit: maximum selectors allowed in one classifier
> + *
> + * The limits are reported by the device and describe resource capacities for
> + * flow filters. Multi-byte fields are little-endian.
> + */
> +struct virtio_net_ff_cap_data {
> +	__le32 groups_limit;
> +	__le32 classifiers_limit;
> +	__le32 rules_limit;
> +	__le32 rules_per_group_limit;
> +	__u8 last_rule_priority;
> +	__u8 selectors_per_classifier_limit;
> +};
> +
> +/**
> + * struct virtio_net_ff_selector - Selector mask descriptor
> + * @type: selector type, one of VIRTIO_NET_FF_MASK_TYPE_* constants
> + * @flags: selector flags, see VIRTIO_NET_FF_MASK_F_* constants
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @length: size in bytes of @mask
> + * @reserved1: must be set to 0 by the driver and ignored by the device
> + * @mask: variable-length mask payload for @type, length given by @length
> + *
> + * A selector describes a header mask that a classifier can apply. The format
> + * of @mask depends on @type.
> + */
> +struct virtio_net_ff_selector {
> +	__u8 type;
> +	__u8 flags;
> +	__u8 reserved[2];
> +	__u8 length;
> +	__u8 reserved1[3];
> +	__u8 mask[];
> +};
> +
> +#define VIRTIO_NET_FF_MASK_TYPE_ETH  1
> +#define VIRTIO_NET_FF_MASK_TYPE_IPV4 2
> +#define VIRTIO_NET_FF_MASK_TYPE_IPV6 3
> +#define VIRTIO_NET_FF_MASK_TYPE_TCP  4
> +#define VIRTIO_NET_FF_MASK_TYPE_UDP  5
> +#define VIRTIO_NET_FF_MASK_TYPE_MAX  VIRTIO_NET_FF_MASK_TYPE_UDP
> +
> +/**
> + * struct virtio_net_ff_cap_mask_data - Supported selector mask formats
> + * @count: number of entries in @selectors
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @selectors: array of supported selector descriptors
> + */
> +struct virtio_net_ff_cap_mask_data {
> +	__u8 count;
> +	__u8 reserved[7];
> +	struct virtio_net_ff_selector selectors[];
> +};
> +#define VIRTIO_NET_FF_MASK_F_PARTIAL_MASK (1 << 0)
> +
> +#define VIRTIO_NET_FF_ACTION_DROP 1
> +#define VIRTIO_NET_FF_ACTION_RX_VQ 2
> +#define VIRTIO_NET_FF_ACTION_MAX  VIRTIO_NET_FF_ACTION_RX_VQ
> +/**
> + * struct virtio_net_ff_actions - Supported flow actions
> + * @count: number of supported actions in @actions
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @actions: array of action identifiers (VIRTIO_NET_FF_ACTION_*)
> + */
> +struct virtio_net_ff_actions {
> +	__u8 count;
> +	__u8 reserved[7];
> +	__u8 actions[];
> +};
> +#endif
> -- 
> 2.50.1


