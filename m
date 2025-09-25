Return-Path: <netdev+bounces-226521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48671BA1711
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 22:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86C13B2716
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 20:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8316A32142F;
	Thu, 25 Sep 2025 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0VMdbxL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E06321296
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833644; cv=none; b=XA3dpypJhy1DzoYJM1cFFIYp5w/OpLeW2bApy3U6Q9oS+a5wOz566qX2x5evSHpQKyo4Fb6EBg2IxNaytjPGAlHru0uqUYyrHgPrw+Jt5VhNyKhV4ed8YW+7ny9uhYrAHbQw7kJG1FBP/YUe/KKw17txbD4VrgLRr53tsbN/Wjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833644; c=relaxed/simple;
	bh=SSXxA/ov/JyorNZtlUeGUL46kNcV39OOXqs/vOEm0mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjiotA8ND6nAPNo+5mlU+hqVGmuHfTWvlHQxAn+hbTa90R/YThcqmUh161xRYLkOY1yFjeCT3x7yriu7Zo8OaL5OEW8m35d1f705fp5uSv9UBEaIxqLZFvG04d33wp3XfST1MJWeakYRibXm/CYFC1unPeD/+ageGel1Q0azDYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0VMdbxL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758833641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9fhr54yCqYhL+KcvkOw0Wms1g0q65DbsfJhR6f884U=;
	b=b0VMdbxLIESSE/lUtQ9zbuun6hewuHkWa6q3INy56/bNixFpWTOUepDSupUuEcOuKYs8Dx
	1xFpbYJvOA7i0RqiVLTYqCTOQc1PXpdH9KSomFGrw26iBtdYEP30KyKPtSKZDDze6470zZ
	Bfylof0RdiFMoXNH7Ju2c4iJ+6z0WZ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-S3XE5rQ0N5WftAIK0ztgHQ-1; Thu, 25 Sep 2025 16:53:59 -0400
X-MC-Unique: S3XE5rQ0N5WftAIK0ztgHQ-1
X-Mimecast-MFC-AGG-ID: S3XE5rQ0N5WftAIK0ztgHQ_1758833638
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e35baddc1so9026035e9.2
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 13:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758833638; x=1759438438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9fhr54yCqYhL+KcvkOw0Wms1g0q65DbsfJhR6f884U=;
        b=IfsgNaV3fII7ySs+tkshO4BXpGgcfF1BjrUHK1GDBOPJ69/FbIkmsIxth79jDBOg0f
         MfQkPXZ4qkDogZ0DbydhsFAI1bOKxVK9dly5dmylLIzaErfzAgAhVPCHqUX3pVc06Vel
         1/vXKzGtfH2bTBy/6WztoPkQOAfU0cPWxXoDc4LVb53R9zJHpvkDGL/pot7WD1n4W2lf
         9Zn7gges3XtFDbN8BNE9m18iB9sEjhIiIkmyhQUFgDZwYhqirjXacTSUQum/03CrFzDw
         ZR7N315VqeUverK9USX6d9cl19DuHEgAbeelsEEJTHsslBQ40uo1aFk6dcUndOenUw91
         Cw+g==
X-Gm-Message-State: AOJu0YzXKFEjBka3Y/hwPSReHqLVjT4n0cnlOfQJdwWYic/kn4h3d8F5
	gZoqRx9plcyPf2mYTCP2Zs6qPCpDzdeQA9v0vD3JIA8wznctc8RIIjwOxGKEOP96SN3XsB9t2YF
	QY/h5swYf6i49U3IqRmaCPkyLnu1ovt8YangqD+m98epG1RFRDTz3Y4VwfuA4bcbERg==
X-Gm-Gg: ASbGncsBURrxpnigQA+lQBfehGB4S4qHhwzJbkj+tTkuXPQKxt760zZBQSWUODZal30
	0nvm0F17alwkdnuRV5nEyQzOoKoMXP3fxspC/Lj2NauW4UrydzrE8HBAOW1QRbnH/OG/35IukoM
	Q6BrgHlGwxjz5BnA0NviV70qEFXWbnTsP+9L8PyldidiWH2TvMOP106mM+nkdHmyhbeGaQyDx6H
	FwlXZhVejaqvTpk5g0c2ssJprkr4vUxiOITIs6Uu0q5e63k1dbAgjzP2UqRXnFxxHHF/pHdavEe
	BvyZMEQ0fNSIQPmhTdKXhdCO0t4GMURv/g==
X-Received: by 2002:a05:600c:4e90:b0:468:6049:95da with SMTP id 5b1f17b1804b1-46e329fac2amr51788695e9.24.1758833638300;
        Thu, 25 Sep 2025 13:53:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNU7+GhGL7b1X4/jV2DcudjXddD1vM81m2Dvfhm0YSo3L7EwN/2uO1L/7MssC9Fp4MbxXZCw==
X-Received: by 2002:a05:600c:4e90:b0:468:6049:95da with SMTP id 5b1f17b1804b1-46e329fac2amr51788555e9.24.1758833637874;
        Thu, 25 Sep 2025 13:53:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bef4b4sm46416235e9.20.2025.09.25.13.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:53:57 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:53:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 07/11] virtio_net: Use existing classifier if
 possible
Message-ID: <20250925165331-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-8-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923141920.283862-8-danielj@nvidia.com>

On Tue, Sep 23, 2025 at 09:19:16AM -0500, Daniel Jurgens wrote:
> Classifiers can be used by more than one rule. If there is an exisitng

existing

> classifier, use it instead of creating a new one.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/net/virtio_net/virtio_net_ff.c | 39 ++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
> index e3c34bfd1d55..30c5ded57ab5 100644
> --- a/drivers/net/virtio_net/virtio_net_ff.c
> +++ b/drivers/net/virtio_net/virtio_net_ff.c
> @@ -17,6 +17,7 @@ struct virtnet_ethtool_rule {
>  /* New fields must be added before the classifier struct */
>  struct virtnet_classifier {
>  	size_t size;
> +	refcount_t refcount;
>  	u32 id;
>  	struct virtio_net_resource_obj_ff_classifier classifier;
>  };
> @@ -105,11 +106,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
> @@ -117,27 +131,28 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
>  
>  	err = virtio_device_object_create(ff->vdev,
>  					  VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
> -					  c->id,
> -					  &c->classifier,
> -					  c->size);
> +					  (*c)->id,
> +					  &(*c)->classifier,
> +					  (*c)->size);
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
>  		virtio_device_object_destroy(ff->vdev,
>  					     VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
>  					     c->id);
> @@ -157,7 +172,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
>  				     eth_rule->flow_spec.location);
>  
>  	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> -	destroy_classifier(ff, eth_rule->classifier_id);
> +	try_destroy_classifier(ff, eth_rule->classifier_id);
>  	kfree(eth_rule);
>  }
>  
> @@ -340,13 +355,13 @@ static int build_and_insert(struct virtnet_ff *ff,
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
> -		destroy_classifier(ff, c->id);
> +		try_destroy_classifier(ff, c->id);
>  		goto err_key;
>  	}
>  
> -- 
> 2.45.0


