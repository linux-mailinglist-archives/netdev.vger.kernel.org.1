Return-Path: <netdev+bounces-234944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 097C7C29F20
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 04:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B235A347DCB
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 03:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D41285CAE;
	Mon,  3 Nov 2025 03:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EU44aYuJ"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5373B2BA
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762140161; cv=none; b=VDps8SaawDIOqziTiQCk2I7cIUTjnYFMMc3Hr8bzEsIvUaHIjOe1tvk/W2r4jS0rb7yeM9n6YcGZzZyH6+WBbv5Zqc1osBs77wF92ZzbuAqfeFlMfl9x9hPSsJXshqylQEfbuZdjnJdbi5czTZfZ6kkgYqoXokI+fQ9Y1NZm0YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762140161; c=relaxed/simple;
	bh=sQbM1Usji7obZ4f7BiPWXDsuUHJYnmu/tNCvVzOW76I=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=gVKxP6Gvzz7ZV9QtVb8EJQA+0JXOixH1vGF6LHzAbeK7W2Z8nNWkiosKktwo4ue/+17hKnFnC0ZbXWm2HP7D8Gb2Q6wDHrL5Pmovk62bbJErZSZI63VcRPNDvNfAOWex1iKNqGAB/ApjYNeCJJ0dXQDpZxZ/Y37uht1pVh/tnpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EU44aYuJ; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762140151; h=Message-ID:Subject:Date:From:To;
	bh=XUPRiHrtMviqg9/C9XvShbkr/rv4ccn+d9IC2suGa4E=;
	b=EU44aYuJYfHE5a0FjPbEQo+5v3Pm2mmwTbViFqYzABLLs/igHtGM7qiAQUCjrfyWhtc76IdNUC8mw9BUDPCK63RqBy7uzJK0OaeL9jIMTq5xSMBTy7o8uOf04WsTebZlk6+sFpmaXLYl/Kk8QTFCpM/7E0Ma5qgVkdKIFzs7sho=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrVmmfD_1762140150 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Nov 2025 11:22:30 +0800
Message-ID: <1762140143.4049902-7-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 08/12] virtio_net: Use existing classifier if possible
Date: Mon, 3 Nov 2025 11:22:23 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <virtualization@lists.linux.dev>,
 <parav@nvidia.com>,
 <shshitrit@nvidia.com>,
 <yohadt@nvidia.com>,
 <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>,
 <shameerali.kolothum.thodi@huawei.com>,
 <jgg@ziepe.ca>,
 <kevin.tian@intel.com>,
 <kuba@kernel.org>,
 <andrew+netdev@lunn.ch>,
 <edumazet@google.com>,
 Daniel Jurgens <danielj@nvidia.com>,
 <netdev@vger.kernel.org>,
 <mst@redhat.com>,
 <jasowang@redhat.com>,
 <alex.williamson@redhat.com>,
 <pabeni@redhat.com>
References: <20251027173957.2334-1-danielj@nvidia.com>
 <20251027173957.2334-9-danielj@nvidia.com>
In-Reply-To: <20251027173957.2334-9-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 27 Oct 2025 12:39:53 -0500, Daniel Jurgens <danielj@nvidia.com> wrote:
> Classifiers can be used by more than one rule. If there is an existing
> classifier, use it instead of creating a new one.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
> v4:
>     - Fixed typo in commit message
>     - for (int -> for (
> ---
>  drivers/net/virtio_net.c | 42 +++++++++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 73194b51c318..d94ac72fc02c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6806,6 +6806,7 @@ struct virtnet_ethtool_rule {
>  /* The classifier struct must be the last field in this struct */
>  struct virtnet_classifier {
>  	size_t size;
> +	refcount_t refcount;
>  	u32 id;
>  	struct virtio_net_resource_obj_ff_classifier classifier;
>  };
> @@ -6899,11 +6900,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
>  	return false;
>  }
>
> -static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
> +static int setup_classifier(struct virtnet_ff *ff,
> +			    struct virtnet_classifier **c)
>  {
> +	struct virtnet_classifier *tmp;
> +	unsigned long i;
>  	int err;
>
> -	err = xa_alloc(&ff->classifiers, &c->id, c,
> +	xa_for_each(&ff->classifiers, i, tmp) {
> +		if ((*c)->size == tmp->size &&
> +		    !memcmp(&tmp->classifier, &(*c)->classifier, tmp->size)) {
> +			refcount_inc(&tmp->refcount);
> +			kfree(*c);
> +			*c = tmp;
> +			goto out;
> +		}
> +	}
> +
> +	err = xa_alloc(&ff->classifiers, &(*c)->id, *c,
>  		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
>  		       GFP_KERNEL);
>  	if (err)
> @@ -6911,29 +6925,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
>
>  	err = virtio_admin_obj_create(ff->vdev,
>  				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
> -				      c->id,
> +				      (*c)->id,
>  				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
>  				      0,
> -				      &c->classifier,
> -				      c->size);
> +				      &(*c)->classifier,
> +				      (*c)->size);
>  	if (err)
>  		goto err_xarray;
>
> +	refcount_set(&(*c)->refcount, 1);
> +out:
>  	return 0;
>
>  err_xarray:
> -	xa_erase(&ff->classifiers, c->id);
> +	xa_erase(&ff->classifiers, (*c)->id);
>
>  	return err;
>  }
>
> -static void destroy_classifier(struct virtnet_ff *ff,
> -			       u32 classifier_id)
> +static void try_destroy_classifier(struct virtnet_ff *ff, u32 classifier_id)
>  {
>  	struct virtnet_classifier *c;
>
>  	c = xa_load(&ff->classifiers, classifier_id);
> -	if (c) {
> +	if (c && refcount_dec_and_test(&c->refcount)) {
>  		virtio_admin_obj_destroy(ff->vdev,
>  					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
>  					 c->id,
> @@ -6957,7 +6972,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
>  				 0);
>
>  	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> -	destroy_classifier(ff, eth_rule->classifier_id);
> +	try_destroy_classifier(ff, eth_rule->classifier_id);
>  	kfree(eth_rule);
>  }
>
> @@ -7082,8 +7097,9 @@ validate_classifier_selectors(struct virtnet_ff *ff,
>  			      int num_hdrs)
>  {
>  	struct virtio_net_ff_selector *selector = (void *)classifier->selectors;
> +	int i;
>
> -	for (int i = 0; i < num_hdrs; i++) {
> +	for (i = 0; i < num_hdrs; i++) {
>  		if (!validate_mask(ff, selector))
>  			return -EINVAL;
>
> @@ -7137,14 +7153,14 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	if (err)
>  		goto err_key;
>
> -	err = setup_classifier(ff, c);
> +	err = setup_classifier(ff, &c);
>  	if (err)
>  		goto err_classifier;
>
>  	err = insert_rule(ff, eth_rule, c->id, key, key_size);
>  	if (err) {
>  		/* destroy_classifier will free the classifier */
> -		destroy_classifier(ff, c->id);
> +		try_destroy_classifier(ff, c->id);
>  		goto err_key;
>  	}
>
> --
> 2.50.1
>

