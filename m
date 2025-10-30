Return-Path: <netdev+bounces-234363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDECC1FC8E
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 12:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF90A3BC7D4
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535662E62CE;
	Thu, 30 Oct 2025 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGWaO0vW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB97A13FEE
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 11:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823151; cv=none; b=ZDnor9CAY82joFTgnSiNXB1K+qhOS113Fo1TzQ3JpOkI7qTcsamXikO7sPlQPh7b6p2uTzAK/JtcXDTG8dvVIoXSeYeKvjX1F9iKoAJKoA+gI9HT1Pm1iUIAiz9B4K0KPA7iX0hXQ3JENHdPCAhDiZX3MIsjfzbGHnC1T4Q6EwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823151; c=relaxed/simple;
	bh=SqGP57j1BFjvp7wUYmK415ErWkC3oNsnubQ4R58rroM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDD4V3NFZWgln2UB5mWZxAGsLmYICyT+n/WeNAfyc+NdecrTKOFmKAtEpO94GowCA9azpg7lDvwTaXrBE3nANEew2HKrLLqf2F4qgl/tyER+wrmAujE1UlKn/VySLPFn0whcwPA2gSh0awQLyEi9/BauLNHdabKo6iv6FjjHS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGWaO0vW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761823147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMwKC3+0iiuTfiX2G4lkWZWPjWZGvGY/CWCvsFc2T7A=;
	b=XGWaO0vWDEB9yLLLZ3BLXSoAqZmHaBHJOxneu7qQSWr9bWGFGp6vg7mSp06j+dXwEws90T
	cfJRUHVPqWNUY/rY+eKRsJTVkKeLTR148tBzeYQCjcVVDu+LcloKZVRQhlp0NOU8fj0T9r
	sDeRgvu7W9+PRzWcMY1Vd5LADyMIY5w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-ioOnkRqyPp6Q4qf0FThmBA-1; Thu, 30 Oct 2025 07:19:06 -0400
X-MC-Unique: ioOnkRqyPp6Q4qf0FThmBA-1
X-Mimecast-MFC-AGG-ID: ioOnkRqyPp6Q4qf0FThmBA_1761823145
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-475de0566adso6452945e9.0
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 04:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761823145; x=1762427945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMwKC3+0iiuTfiX2G4lkWZWPjWZGvGY/CWCvsFc2T7A=;
        b=MrXMOqRXNQf8+tFcfD08ZTkeQgpBgClAhusjJXk30cztEA1gAatYHmXAyIWZVe3A0k
         wApbPAkYNQw2ZtWe+a19273prMtYsxz2xyc93XN+27hKsniBvDL478aOgILBexY6rGZF
         K+sRziWJxVmO454pm4otwNga5j3CNc+twSaFG6cu3OeMCdxjAH/YyWJxu5ydPOvcV75R
         jyOaHy6ab0ppgAXilZDwzn1508bO1ohWVlHbiPdEKjAVNIbAS809cGT6LJoZx77y8Mf9
         QmEQaKO+p7lmPp+M7PPr04+3lKjb0nc1eECm4srXIhMdvgqYs19UrPhiD0+MA/dKzEZI
         d1bw==
X-Forwarded-Encrypted: i=1; AJvYcCXY9iyr2PTUhc5RI0doIK6bl9EuYxzM210t3Z7d5ifcddpxCCHeShemzbvc7LlqTVcZwhwEmRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVKbc+k8rvTtbXK8MDtfpcziXxCq0x7u+4ZiGwBYHFIP8pQEGJ
	uyE9iQUt0nE6o2IghOA+hx0kzLCmkYbb7/rwMhNxF3OAKDpw17dfHLCeYLU1D0BjsQiHxi4Fl6/
	O097+jiqUJh6D19g5mM60PxvnK9gIIZB5FHsZSNE4JUwALEtRi54HrAn4mA==
X-Gm-Gg: ASbGncsWW127nPodnJ9amFXrk4ZL4rOyDw40vXAowW7TAfOeZRYaTRb9LnK8vvchaFY
	m2XFotbXv0Xt1oZHzTfv2Vhf8ORJPdKr1jVvU42i0V0VGUh7RdgPkiz+FYnFezbz3+KWl7PxLgf
	OOj8cawz0gju6iSKHW6nJFeKZsHT021ki++Z/E44DWlCJcI4AhERkMsnWXc8IoxtTYlJnwgPtti
	pfEpwyAMuonBP/ILwIQ1BRM3IOl+4jZWijq+Pz3W3gXKh/XZW9blp5R3JnLz/V6+bM1qLEqf2wG
	XjTvbiLInAs1HeZa6CPmoa+hZf4VqRoGSXtxZf6iYiLQ7oseqkeSamrlDH0iJPSxuzn5EX/wGYP
	68mt4ZSzMKucZ8N1sTYBZsxneBDkVzHlhSagby9itAFbv
X-Received: by 2002:a05:600d:8389:b0:475:da13:256b with SMTP id 5b1f17b1804b1-4771e3cb77cmr32176605e9.38.1761823145298;
        Thu, 30 Oct 2025 04:19:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFReuX3rLd07pv/+w9iCs0nl/ibXlBBJ1rbE7rMVq6o7uKjPrhhDCpdnOglyD29qJXrGhGaNA==
X-Received: by 2002:a05:600d:8389:b0:475:da13:256b with SMTP id 5b1f17b1804b1-4771e3cb77cmr32176325e9.38.1761823144846;
        Thu, 30 Oct 2025 04:19:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6? ([2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289e7cf5sm36534505e9.14.2025.10.30.04.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 04:19:04 -0700 (PDT)
Message-ID: <b55d868c-7bc1-4e25-aef4-cdf385208400@redhat.com>
Date: Thu, 30 Oct 2025 12:19:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 05/12] virtio_net: Query and set flow filter
 caps
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251027173957.2334-1-danielj@nvidia.com>
 <20251027173957.2334-6-danielj@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251027173957.2334-6-danielj@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 6:39 PM, Daniel Jurgens wrote:
> When probing a virtnet device, attempt to read the flow filter
> capabilities. In order to use the feature the caps must also
> be set. For now setting what was read is sufficient.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
> v4:
>     - Validate the length in the selector caps
>     - Removed __free usage.
>     - Removed for(int.
> v5:
>     - Remove unneed () after MAX_SEL_LEN macro (test bot)
> v6:
>     - Fix sparse warning "array of flexible structures" Jakub K/Simon H
>     - Use new variable and validate ff_mask_size before set_cap. MST
> ---
>  drivers/net/virtio_net.c           | 171 +++++++++++++++++++++++++++++
>  include/linux/virtio_admin.h       |   1 +
>  include/uapi/linux/virtio_net_ff.h |  91 +++++++++++++++
>  3 files changed, 263 insertions(+)
>  create mode 100644 include/uapi/linux/virtio_net_ff.h
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a757cbcab87f..a9fde879fdbf 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -26,6 +26,9 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
>  #include <net/xdp_sock_drv.h>
> +#include <linux/virtio_admin.h>
> +#include <net/ipv6.h>
> +#include <net/ip.h>
>  
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -281,6 +284,14 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
>  	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
>  };
>  
> +struct virtnet_ff {
> +	struct virtio_device *vdev;
> +	bool ff_supported;
> +	struct virtio_net_ff_cap_data *ff_caps;
> +	struct virtio_net_ff_cap_mask_data *ff_mask;
> +	struct virtio_net_ff_actions *ff_actions;
> +};
> +
>  #define VIRTNET_Q_TYPE_RX 0
>  #define VIRTNET_Q_TYPE_TX 1
>  #define VIRTNET_Q_TYPE_CQ 2
> @@ -493,6 +504,8 @@ struct virtnet_info {
>  	struct failover *failover;
>  
>  	u64 device_stats_cap;
> +
> +	struct virtnet_ff ff;
>  };
>  
>  struct padded_vnet_hdr {
> @@ -6753,6 +6766,160 @@ static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
>  	.xmo_rx_hash			= virtnet_xdp_rx_hash,
>  };
>  
> +static size_t get_mask_size(u16 type)
> +{
> +	switch (type) {
> +	case VIRTIO_NET_FF_MASK_TYPE_ETH:
> +		return sizeof(struct ethhdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
> +		return sizeof(struct iphdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
> +		return sizeof(struct ipv6hdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_TCP:
> +		return sizeof(struct tcphdr);
> +	case VIRTIO_NET_FF_MASK_TYPE_UDP:
> +		return sizeof(struct udphdr);
> +	}
> +
> +	return 0;
> +}
> +
> +#define MAX_SEL_LEN (sizeof(struct ipv6hdr))
> +
> +static void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
> +{
> +	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
> +			      sizeof(struct virtio_net_ff_selector) *
> +			      VIRTIO_NET_FF_MASK_TYPE_MAX;
> +	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
> +	struct virtio_net_ff_selector *sel;
> +	size_t real_ff_mask_size;
> +	int err;
> +	int i;
> +
> +	cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
> +	if (!cap_id_list)
> +		return;
> +
> +	err = virtio_admin_cap_id_list_query(vdev, cap_id_list);
> +	if (err)
> +		goto err_cap_list;
> +
> +	if (!(VIRTIO_CAP_IN_LIST(cap_id_list,
> +				 VIRTIO_NET_FF_RESOURCE_CAP) &&
> +	      VIRTIO_CAP_IN_LIST(cap_id_list,
> +				 VIRTIO_NET_FF_SELECTOR_CAP) &&
> +	      VIRTIO_CAP_IN_LIST(cap_id_list,
> +				 VIRTIO_NET_FF_ACTION_CAP)))
> +		goto err_cap_list;
> +
> +	ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
> +	if (!ff->ff_caps)
> +		goto err_cap_list;
> +
> +	err = virtio_admin_cap_get(vdev,
> +				   VIRTIO_NET_FF_RESOURCE_CAP,
> +				   ff->ff_caps,
> +				   sizeof(*ff->ff_caps));
> +
> +	if (err)
> +		goto err_ff;
> +
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
> +	real_ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
> +	sel = (void *)&ff->ff_mask->selectors[0];
> +
> +	for (i = 0; i < ff->ff_mask->count; i++) {
> +		if (sel->length > MAX_SEL_LEN) {
> +			err = -EINVAL;
> +			goto err_ff_action;
> +		}
> +		real_ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
> +		sel = (void *)sel + sizeof(*sel) + sel->length;
> +	}
> +
> +	if (real_ff_mask_size > ff_mask_size) {
> +		err = -EINVAL;
> +		goto err_ff_action;
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

Minor nit: AFAICS the ff->ff_{caps,mask,actions} pointers can be left !=
NULL even after free. That should not cause issue at cleanup time, as
double free is protected by/avoided with 'ff_supported'.

Still it could foul kmemleak check. I think it would be better to either
clear such fields here or set such fields only on success (and work with
local variable up to that point).

Not a blocker anyway.

/P


