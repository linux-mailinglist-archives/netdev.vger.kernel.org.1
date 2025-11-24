Return-Path: <netdev+bounces-241296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FA4C8277E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB75D34AE80
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 21:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A842586C8;
	Mon, 24 Nov 2025 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4Fa7NOF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sc+ddTY0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABAE25393B
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764018096; cv=none; b=OPfTCLfVJG2crm2zEQPhFotJj0jQyUMgZRsHGK3AZFuaO0BBzBteURylGDhkIWLh9p6i8YLSnm1T3JCdKigUJCJsyq5J0nlySWne1DIvdBV1Tygc1wqktafscaU3WNUfp+wPfZegl5pu53uazXe77U6ETXfZusdlykGCXWAQh/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764018096; c=relaxed/simple;
	bh=j0MObbyK+FyNy0ZAFnKXwoyzj2Cwemyu2/nA6P+t7ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E22+KAprN3OhXw2DXeu8myS2nwM2DZ97zLurF2No/x4OYkYInMsQhKauWPlLvbGTf8f0o6fnAphuTNVhsPAbnow9PtV90m5IW3KVVarwQhpxgvSl0WfEqRDIYCXifG0hg977zzxlQPc2gS8tqZff32gZwONpikuLDLzk0Bduzg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W4Fa7NOF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sc+ddTY0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764018093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U5Mw/aMLaYte1U3mrEKAPizFP1nx7g/+kQvzP9d09Ew=;
	b=W4Fa7NOFEm/EaTjEgVryrcHe428dSW8bAqUbY1Nf9X4PSeipkkRSOdN6rjTh4FKn0PGc/K
	BnFlM3Qcqy38gY7nqnPCMDReHgFksxHDKjljGDXJ/bnJ4SGiEit5IO4Qu7AVsZgOn/UcyR
	AtWVnwbBTl+DiFcgwpYHlFVOdog5F4E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-66RxitLeNPa58jgG_R18rA-1; Mon, 24 Nov 2025 16:01:32 -0500
X-MC-Unique: 66RxitLeNPa58jgG_R18rA-1
X-Mimecast-MFC-AGG-ID: 66RxitLeNPa58jgG_R18rA_1764018091
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b3339cab7so3167388f8f.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 13:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764018090; x=1764622890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U5Mw/aMLaYte1U3mrEKAPizFP1nx7g/+kQvzP9d09Ew=;
        b=sc+ddTY02vJv9tutf8zB3oGb86UuCEQ2TNWJJ3HPs+Q9TIhFLW/sjTKnf37xPuuVhY
         aRYwuYKLNUwMqXK+8tniKUCB+nUptsRApvDYSRx4qVFfgyf3a15nfIPw2znm/Vc7CiAC
         Uqu+Knunyr2lGTGeP9TNAdo3F3Dc7noAJZ5bSWETcZw95AbdGMIwKpTwXetKtFmtuE4y
         SnYk/K0Qz/i8TbER7IcOhMg7CTpXrOBJCKtOABXOLRPzQ0m44IgF9tBkGtCZRH3vcogb
         NfovYeYSjDAqNCKr8QyAKuQx6L4TtX1O2KshcJGR3C/6q7Tubn+d/RIf1K5YXCMdhXIQ
         7ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764018090; x=1764622890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5Mw/aMLaYte1U3mrEKAPizFP1nx7g/+kQvzP9d09Ew=;
        b=t8YqIpbZosAGxZxzIkloNkCeUlz4UPwYRMg9pYyItzYFsYOOkknsU8rIWRqGMKu4W2
         a3+We6q8jADXZv+hIcVLweapVMKOo/hxzqgfoZk4YTJjhffQPnjqeQfpFk8G3FHDtNj+
         suJj4pTrwYnYpTCphyEYhlLIUV45rceK0UX/mkoToE/d8Vud4Lo0Nmlwyy9WzDxk2emc
         BEALMSNWbCdzCpbql7DIlHcSS4eKGG0/bWWFD530bg7OSwpxUKhUwBlU0hutbLt7i91h
         4lj5RJhajuRG5CtxFOhsW8jDYAskt1Lc5hLvSsbny6tEpLjUrmpEHh1JIyct8Y1jVAve
         AdBA==
X-Gm-Message-State: AOJu0YwEKgc17JzoiNmcXVEAVbsSms2eWGyukb979WaRMMM88t7S0AKE
	J68K6ifG2sb5RmYCVjzn/xxq+AcEIuVAZmy54dKQodeN/QfD092gmoIgkqfLBstiV39bdZoTIkU
	HDd2TkuCfjiZ64/k71BJqFxvsXvQbJh9EJdm8m0MsafeKeTQgoKqLAz0apF7NqSA9eg==
X-Gm-Gg: ASbGncshhbTjYA8miu6RjUi/34H67Xwl87jjiI+w6cyNeTg4taQAI7NEowxO8dvVHGt
	ql+cabol/1i7TFIvV0GI8ukyTZWQbiEW0csl2CuS7z1bH4bfKEnYDB/hjaafp98XUmnbc/sC9R9
	+wHnTyC3m3TfTSSyooUFpEwT4tSIvdfGEYKrN3HOdvyGnbcW5G/eZsIw0qgj9EPV6n+6TEOAY2R
	KC4k7LyNAkNE0GsTmik//y8YpyLJivUB+5uGZLgTMZglFMPUSuhU8Ejfa4g10ywEXwQoTckq5Sk
	n4f5qlTWh1osQx4TEYV1K0dOzur4OxjqpYcqK/KamWzl8GOT+bn8gJ5Fk45bk2OK7dQo8AX9TRp
	ryI0b3Va47MDYVLTrk3Ckn//dALajaw==
X-Received: by 2002:a05:600c:474d:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-47904b290bcmr1919525e9.32.1764018090368;
        Mon, 24 Nov 2025 13:01:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtEAzpeYww+y+LHm+cR1qP4PWDsaV/kYKPhpXCK7mFB/UfSZZo3HJt4ocp7b0DC2JNlxv5jA==
X-Received: by 2002:a05:600c:474d:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-47904b290bcmr1919235e9.32.1764018089906;
        Mon, 24 Nov 2025 13:01:29 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8d97sm29908017f8f.42.2025.11.24.13.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 13:01:29 -0800 (PST)
Date: Mon, 24 Nov 2025 16:01:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <20251124155823-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119191524.4572-6-danielj@nvidia.com>

On Wed, Nov 19, 2025 at 01:15:16PM -0600, Daniel Jurgens wrote:
> When probing a virtnet device, attempt to read the flow filter
> capabilities. In order to use the feature the caps must also
> be set. For now setting what was read is sufficient.
> 
> This patch adds uapi definitions virtio_net flow filters define in
> version 1.4 of the VirtIO spec.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> 
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
> v7:
>     - Set ff->ff_{caps, mask, actions} NULL in error path. Paolo Abeni
>     - Return errors from virtnet_ff_init, -ENOTSUPP is not fatal. Xuan
> 
> v8:
>     - Use real_ff_mask_size when setting the selector caps. Jason Wang
> 
> v9:
>     - Set err after failed memory allocations. Simon Horman
> 
> v10:
>     - Return -EOPNOTSUPP in virnet_ff_init before allocing any memory.
>       Jason/Paolo.
> 
> v11:
>     - Return -EINVAL if any resource limit is 0. Simon Horman
>     - Ensure we don't overrun alloced space of ff->ff_mask by moving the
>       real_ff_mask_size > ff_mask_size check into the loop. Simon Horman
> 
> v12:
>     - Move uapi includes to virtio_net.c vs header file. MST
>     - Remove kernel.h header in virtio_net_ff uapi. MST
>     - WARN_ON_ONCE in error paths validating selectors. MST
>     - Move includes from .h to .c files. MST
>     - Add WARN_ON_ONCE if obj_destroy fails. MST
>     - Comment cleanup in virito_net_ff.h uapi. MST
>     - Add 2 byte pad to the end of virtio_net_ff_cap_data.
>       https://lore.kernel.org/virtio-comment/20251119044029-mutt-send-email-mst@kernel.org/T/#m930988a5d3db316c68546d8b61f4b94f6ebda030
>     - Cleanup and reinit in the freeze/restore path. MST
> ---
>  drivers/net/virtio_net.c               | 221 +++++++++++++++++++++++++
>  drivers/virtio/virtio_admin_commands.c |   2 +
>  include/uapi/linux/virtio_net_ff.h     |  88 ++++++++++
>  3 files changed, 311 insertions(+)
>  create mode 100644 include/uapi/linux/virtio_net_ff.h
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index cfa006b88688..2d5c1bff879a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -26,6 +26,11 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
>  #include <net/xdp_sock_drv.h>
> +#include <linux/virtio_admin.h>
> +#include <net/ipv6.h>
> +#include <net/ip.h>
> +#include <uapi/linux/virtio_pci.h>
> +#include <uapi/linux/virtio_net_ff.h>
>  
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -281,6 +286,14 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
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
> @@ -493,6 +506,8 @@ struct virtnet_info {
>  	struct failover *failover;
>  
>  	u64 device_stats_cap;
> +
> +	struct virtnet_ff ff;
>  };
>  
>  struct padded_vnet_hdr {
> @@ -5760,6 +5775,186 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
>  	.get_base_stats		= virtnet_get_base_stats,
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
> +static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
> +	if (!vdev->config->admin_cmd_exec)
> +		return -EOPNOTSUPP;
> +
> +	cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
> +	if (!cap_id_list)
> +		return -ENOMEM;
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
> +				 VIRTIO_NET_FF_ACTION_CAP))) {
> +		err = -EOPNOTSUPP;
> +		goto err_cap_list;
> +	}
> +
> +	ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
> +	if (!ff->ff_caps) {
> +		err = -ENOMEM;
> +		goto err_cap_list;
> +	}
> +
> +	err = virtio_admin_cap_get(vdev,
> +				   VIRTIO_NET_FF_RESOURCE_CAP,
> +				   ff->ff_caps,
> +				   sizeof(*ff->ff_caps));
> +
> +	if (err)
> +		goto err_ff;
> +
> +	if (!ff->ff_caps->groups_limit ||
> +	    !ff->ff_caps->classifiers_limit ||
> +	    !ff->ff_caps->rules_limit ||
> +	    !ff->ff_caps->rules_per_group_limit) {
> +		err = -EINVAL;
> +		goto err_ff;
> +	}
> +
> +	/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
> +	for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
> +		ff_mask_size += get_mask_size(i);
> +
> +	ff->ff_mask = kzalloc(ff_mask_size, GFP_KERNEL);
> +	if (!ff->ff_mask) {
> +		err = -ENOMEM;
> +		goto err_ff;
> +	}
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
> +	if (!ff->ff_actions) {
> +		err = -ENOMEM;
> +		goto err_ff_mask;
> +	}
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
> +	sel = (void *)&ff->ff_mask->selectors;
> +
> +	for (i = 0; i < ff->ff_mask->count; i++) {
> +		if (sel->length > MAX_SEL_LEN) {
> +			WARN_ON_ONCE(true);
> +			err = -EINVAL;
> +			goto err_ff_action;
> +		}
> +		real_ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
> +		if (real_ff_mask_size > ff_mask_size) {
> +			WARN_ON_ONCE(true);
> +			err = -EINVAL;
> +			goto err_ff_action;
> +		}
> +		sel = (void *)sel + sizeof(*sel) + sel->length;
> +	}


I am trying to figure out whether this is safe with
a buggy/malicious device which passes count > VIRTIO_NET_FF_MASK_TYPE_MAX


In fact, what if a future device supports more types?
There does not need to be a negotiation about what driver
needs, right?


> +
> +	err = virtio_admin_cap_set(vdev,
> +				   VIRTIO_NET_FF_SELECTOR_CAP,
> +				   ff->ff_mask,
> +				   real_ff_mask_size);
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
> +	return 0;
> +
> +err_ff_action:
> +	kfree(ff->ff_actions);
> +	ff->ff_actions = NULL;
> +err_ff_mask:
> +	kfree(ff->ff_mask);
> +	ff->ff_mask = NULL;
> +err_ff:
> +	kfree(ff->ff_caps);
> +	ff->ff_caps = NULL;
> +err_cap_list:
> +	kfree(cap_id_list);
> +
> +	return err;
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
> +	ff->ff_supported = false;
> +}
> +
>  static void virtnet_freeze_down(struct virtio_device *vdev)
>  {
>  	struct virtnet_info *vi = vdev->priv;
> @@ -5778,6 +5973,10 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>  	netif_tx_lock_bh(vi->dev);
>  	netif_device_detach(vi->dev);
>  	netif_tx_unlock_bh(vi->dev);
> +
> +	rtnl_lock();
> +	virtnet_ff_cleanup(&vi->ff);
> +	rtnl_unlock();
>  }
>  
>  static int init_vqs(struct virtnet_info *vi);
> @@ -5804,6 +6003,17 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  			return err;
>  	}
>  
> +	/* Initialize flow filters. Not supported is an acceptable and common
> +	 * return code
> +	 */
> +	rtnl_lock();
> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
> +	if (err && err != -EOPNOTSUPP) {
> +		rtnl_unlock();
> +		return err;
> +	}
> +	rtnl_unlock();
> +
>  	netif_tx_lock_bh(vi->dev);
>  	netif_device_attach(vi->dev);
>  	netif_tx_unlock_bh(vi->dev);
> @@ -7137,6 +7347,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	}
>  	vi->guest_offloads_capable = vi->guest_offloads;
>  
> +	/* Initialize flow filters. Not supported is an acceptable and common
> +	 * return code
> +	 */
> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
> +	if (err && err != -EOPNOTSUPP) {
> +		rtnl_unlock();
> +		goto free_unregister_netdev;
> +	}
> +
>  	rtnl_unlock();
>  
>  	err = virtnet_cpu_notif_add(vi);
> @@ -7152,6 +7371,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  free_unregister_netdev:
>  	unregister_netdev(dev);
> +	virtnet_ff_cleanup(&vi->ff);
>  free_failover:
>  	net_failover_destroy(vi->failover);
>  free_vqs:
> @@ -7201,6 +7421,7 @@ static void virtnet_remove(struct virtio_device *vdev)
>  	virtnet_free_irq_moder(vi);
>  
>  	unregister_netdev(vi->dev);
> +	virtnet_ff_cleanup(&vi->ff);
>  
>  	net_failover_destroy(vi->failover);
>  
> diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
> index 4738ffe3b5c6..e84a305d2b2a 100644
> --- a/drivers/virtio/virtio_admin_commands.c
> +++ b/drivers/virtio/virtio_admin_commands.c
> @@ -161,6 +161,8 @@ int virtio_admin_obj_destroy(struct virtio_device *vdev,
>  	err = vdev->config->admin_cmd_exec(vdev, &cmd);
>  	kfree(data);
>  
> +	WARN_ON_ONCE(err);
> +
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(virtio_admin_obj_destroy);
> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
> new file mode 100644
> index 000000000000..1debcf595bdb
> --- /dev/null
> +++ b/include/uapi/linux/virtio_net_ff.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
> + *
> + * Header file for virtio_net flow filters
> + */
> +#ifndef _LINUX_VIRTIO_NET_FF_H
> +#define _LINUX_VIRTIO_NET_FF_H
> +
> +#include <linux/types.h>
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
> + */
> +struct virtio_net_ff_cap_data {
> +	__le32 groups_limit;
> +	__le32 classifiers_limit;
> +	__le32 rules_limit;
> +	__le32 rules_per_group_limit;
> +	__u8 last_rule_priority;
> +	__u8 selectors_per_classifier_limit;
> +	__u8 reserved[2];
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
> + * @selectors: packed array of struct virtio_net_ff_selectors.
> + */
> +struct virtio_net_ff_cap_mask_data {
> +	__u8 count;
> +	__u8 reserved[7];
> +	__u8 selectors[];
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


