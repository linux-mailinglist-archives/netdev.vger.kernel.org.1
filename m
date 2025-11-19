Return-Path: <netdev+bounces-239858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 701CAC6D352
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 6D46E2CD05
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83DA2D73B4;
	Wed, 19 Nov 2025 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzYlQj0l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRSSML9X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D8B2DCF6C
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538164; cv=none; b=jSgK83YYP0vZsRIi0ETKRx7B0bGI2cegLWmFGWZF0cmheJ7lL5vuM9P58JS3jV2BKMTuPq9fdSqUFo8ub3vHXFAIQFdLEqstPVoptaphC3/EV+zNFDtdysrFVDgt9ZV7/vbevY403xVYHSU5M+59oxN8lVZ2YYpjU7vr9FbIdTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538164; c=relaxed/simple;
	bh=OLA8m9TLLbYqvmKHcPxq9ZrLCV5444ywLE3KMmGFc8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFLY51tn6LFWHvPq1sIhgw9Hht1Wa3wxp73b+EdwE02FTLkoHZ08gPtRLhTn22BR+4qVJRlLGUyJZ8UbjBRLpH+RwwTZn7n4TmsUXepr8zOaFpDxYJURugAx6Avp4PVLxZIpuYhuKr47dYc5XlL3gUcDPSKaxodTnpxLNPPjeXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzYlQj0l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRSSML9X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763538161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4JiHNk8Un1Ag1G9pjG84VBhPIzZqe9VuqqmjTYDWtM=;
	b=gzYlQj0lujhUwLkyi+SPB9Cqvb83Uv2cGbDhROmN1jW21tNEDtETann3WKIgdlCc4PYncE
	Ma1hUB4mWNTbudfynH5BaPvFeSIx7wXfyB5ytsxeXsvIofNTNhIhUZn8C+qbZNpVUCItKv
	olkEN7ougmpKfhbCBfl3hf4Pi7E2M38=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-KHa3E6lPPqGdSG4kjQphOw-1; Wed, 19 Nov 2025 02:42:33 -0500
X-MC-Unique: KHa3E6lPPqGdSG4kjQphOw-1
X-Mimecast-MFC-AGG-ID: KHa3E6lPPqGdSG4kjQphOw_1763538152
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b2f79759bso4473055f8f.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763538152; x=1764142952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A4JiHNk8Un1Ag1G9pjG84VBhPIzZqe9VuqqmjTYDWtM=;
        b=DRSSML9X36H0/1lwVH48ZGjAnFtmAxCg9ujj6KH2PnApHznTroCBCmdoPCxlnG5UIl
         Qkoxbqvtw1H1O4eKMRM5dXWWuRQu4ur7+b6/Wn6MJYBNmTpx5Pxd8GyWPO24gws0wvt2
         r9gcFJxySGle1ZyfCJ54i+MQCvL4ZWZ0ebPZHrKVktcdzlYwDbtxOJN9An1/7CdVd9rP
         ZnTke3rnTkrgLjYPCDb39s7j+MwyLx4ro0Ul91LmODyLr1pwWAd+VwiHy/lyGv7DFnnD
         00ew6xN9AjDasSbDYegLGLffTffGwPblHEJtHcu0YglqlEVlPXrdJcKI4hxhjBy7rurm
         KEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538152; x=1764142952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4JiHNk8Un1Ag1G9pjG84VBhPIzZqe9VuqqmjTYDWtM=;
        b=odXtckRGMwiugeGkf2/PMno3yoTmUCR1fmw9T8y9KTZHzhiAh1v2g5KMQTNNHQC7h4
         juz9FYrd/P4EATIS82EMwLUEoJD/SV5d+Ya7FN1f/YTsARhhh6KKXET8SIt4q5q6C8+F
         DhfbuWJVbqLRzeCJoGkESBIbmIwAJurLz8twMMFcj8Q2wMNPG+EnYW4pA17jKHWgtomB
         aymtinj66DRgnclJV0ziYDk2pNuH/+yfFc9x6WtrO8mbgLp33G30zVNZj5SV1hrs/RT7
         diPSIxyYHGddgmN0+fXr3rAnFMNEWCRAET3TigmwpUUncOUmdd95BGHZw19d5PQ0+MHC
         uMGA==
X-Gm-Message-State: AOJu0YxiYw1mBkxPAJOQ2t1KfpAG1kTLUWvhjrEq7rRWsF8y4ZUkDm4t
	zlYZSMmA6lT/mjvaFR/J4qwEbDz0oTdDSBtGgDvcLBAZ8NUhjGaZCjnNj1iFiGzv+3PqURoabtx
	ZZA5817YaflJ+ciEqmOrcZcftzWMwx28O7cohATW4H5WHLZX+ximbu2hiXQ==
X-Gm-Gg: ASbGncuy2EH2vAGPLy9EKBXXUTaEk2wHqL4iSLxU1okROfs3MRPYa/k3WqTa227s35U
	llrpCwI6m1dnQE8ZQdxP77HEYdXaPyYE7JpCffId6p3a6qdn+djUrQ8xq29YN8ymkXkdbNctZys
	l8I6BypV4jXMVH6uwGyt6r4TWI7mqSiND7uOK5IpjeyQpYf6YGxZgc8JKLIbM3Y6cQljzJuMz28
	//9EDLdNwO0lqULEw2b3ZAk8+RI/v9Q2J2b3Us1xTw8/1eCAsMPky75CwHQSguBxSwhEcP6uVWH
	9FEyDt779/L6JXMnIs0PFZWxddnCjIdkEh3/sAyzhjnOyMF/KNDRCz7t6lMDvZomBYfylaw2h2e
	s3pjNiLLwvu+U6ExOoHM8Y/XDePiGMw==
X-Received: by 2002:a05:6000:381:b0:429:c617:a32f with SMTP id ffacd0b85a97d-42b5938f44cmr18120190f8f.52.1763538152341;
        Tue, 18 Nov 2025 23:42:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVoKWTmCKGsdXq2+7eS8LR3Wv5tLzrt1q9s97tPznxCioRa2qIv0BW3ghrZRWPtDnT0sv9yQ==
X-Received: by 2002:a05:6000:381:b0:429:c617:a32f with SMTP id ffacd0b85a97d-42b5938f44cmr18120167f8f.52.1763538151805;
        Tue, 18 Nov 2025 23:42:31 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e846afsm35643837f8f.13.2025.11.18.23.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:42:31 -0800 (PST)
Date: Wed, 19 Nov 2025 02:42:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 08/12] virtio_net: Use existing classifier
 if possible
Message-ID: <20251119024151-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-9-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118143903.958844-9-danielj@nvidia.com>

On Tue, Nov 18, 2025 at 08:38:58AM -0600, Daniel Jurgens wrote:
> Classifiers can be used by more than one rule. If there is an existing
> classifier, use it instead of creating a new one.

explaining what's the point would be good. to save
device memory?

> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v4:
>     - Fixed typo in commit message
>     - for (int -> for (
> 
> v8:
>     - Removed unused num_classifiers. Jason Wang
> ---
>  drivers/net/virtio_net.c | 40 +++++++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index de1a23c71449..f392ea30f2c7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -299,7 +299,6 @@ struct virtnet_ff {
>  	struct virtio_net_ff_cap_mask_data *ff_mask;
>  	struct virtio_net_ff_actions *ff_actions;
>  	struct xarray classifiers;
> -	int num_classifiers;
>  	struct virtnet_ethtool_ff ethtool;
>  };
>  
> @@ -6827,6 +6826,7 @@ struct virtnet_ethtool_rule {
>  /* The classifier struct must be the last field in this struct */
>  struct virtnet_classifier {
>  	size_t size;
> +	refcount_t refcount;
>  	u32 id;
>  	struct virtio_net_resource_obj_ff_classifier classifier;
>  };
> @@ -6920,11 +6920,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
> @@ -6932,29 +6945,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
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
> @@ -6978,7 +6992,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
>  				 0);
>  
>  	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> -	destroy_classifier(ff, eth_rule->classifier_id);
> +	try_destroy_classifier(ff, eth_rule->classifier_id);
>  	kfree(eth_rule);
>  }
>  
> @@ -7159,14 +7173,14 @@ static int build_and_insert(struct virtnet_ff *ff,
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


