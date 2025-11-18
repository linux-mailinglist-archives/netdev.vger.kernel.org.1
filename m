Return-Path: <netdev+bounces-239728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A33E9C6BC94
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E8744E03B8
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 21:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011783093AD;
	Tue, 18 Nov 2025 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdacWRCH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMvSzBh0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ADA2FC862
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502964; cv=none; b=hb5se3ul/7yLS1HauonjeD37rd3HMsiyziWZieTvgjLMA6zMNa7WpvIHDxb4Yyb6xlHro+i8YLs26dB/6v6A3WU2yd54YBSBCnjTddrvFrpH2ZD3gfDKEZSaExQ+U3b3oKzSC5aD8LNii5Mu9hIvGWwCFpSGjjPh0Rf+eYm7Kc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502964; c=relaxed/simple;
	bh=j+E0byoRvaORafNm6GmHS5qiC5HA9/iH79KXIlY3vcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdwoBCCP1UBIN5wG8mN/TUYXxLWe7gV+CY4s58EBUvXQxGcaDehH6UH98PGGIyvB57XPi2HEN0xkvDQXNVEWtzl+RpqOpprK14M1U+q8dSPr6YHxgClhtVqonYVDBItrJKPZ7lgHrCGcBSRZ3HSATocgtKLAuuNer84ucNQp0tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DdacWRCH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMvSzBh0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763502962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RFZp+qcXN9gzuUdOxOz0uxVXwf1f1BfhlVSxFFzrPP4=;
	b=DdacWRCHUgOTMrKZ73NGoWIb2YvTUEXJZK2mxhbUJRFMsekRt99O55WF6T65xjZ2diMsGM
	gutlAb1Gab5VN2uZG74uFSYyuN1Wlh8z4dkW4G4Qeip15NeJ8Kc8K2M3RwQLdTEnMgBkOY
	mwVlzobxyOddc8Q6KOB6TOGCktrUhIU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-cnF_oOGeNmad63o2V8117g-1; Tue, 18 Nov 2025 16:56:00 -0500
X-MC-Unique: cnF_oOGeNmad63o2V8117g-1
X-Mimecast-MFC-AGG-ID: cnF_oOGeNmad63o2V8117g_1763502959
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779393221aso10287725e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 13:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763502959; x=1764107759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RFZp+qcXN9gzuUdOxOz0uxVXwf1f1BfhlVSxFFzrPP4=;
        b=fMvSzBh0bl4VKUr0itBFipOLJ7uCPNa9J36IA7aGDPlUwNNwvRnETpGjZUMrSxwCIj
         m4u2jWDvG0qjWNFCzmSlfYt5d9Lx3TlSZuYiU+Rd6t6rZUqJuseHMQu5N/HUczEasVv/
         VZQ2gt2VFzgM9MFJcmwBHpaogb9BTX9HS13X4L9OnJRL4i1I31FQmlFalLlr0aHx4czn
         ysn1TYpArCeVJyatbcByiMaKUztyhJm2XmmeKy6uIopwfv82oMiBH4Yp10x11c1+229B
         QwV/ynbhSSi8qTgTheL8TZOSxzeYZRai9Xhzo2QRb5IYpJRWQJw/l6MuRFV1RRaxwbV8
         NJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763502959; x=1764107759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFZp+qcXN9gzuUdOxOz0uxVXwf1f1BfhlVSxFFzrPP4=;
        b=DTeBHzjt2FPjJQNLoT+2h7btxy/131JyH2KSXnQKKC6Ymr+Ums2KxNazECwTe7KC+f
         cAExWwk4GPLP1chEnW2sV7MAEUhW9N7sJxgMDWhEGQQ23+Pzc6zFm4BraLbK6Se+dJa2
         sVsEm3gybIHDZs4hU6qG6mpoFN+MttqUaxf7L2bv+i50fBYys4zvpu6Db7H4d8ZBHh5E
         YSVFxqGbJYwQzGY2pxzg+CC9yv3ecZ6oTqH21Tni7CAUOxIx7CO3B1rsZbE0sSMzgAEu
         FzilNGtPNY1EogVpprWFpinlyobUmcXgVr94JQHH9204p/WxE9w3AqcJnAuHqWWyN8fs
         Aaog==
X-Gm-Message-State: AOJu0Yz2yeoRMbpdfScMt7RSLG4vtMTKRT+/w/1eurVdXMgsuBAr+QWq
	XQwYFsCWJFvoiKmwJJ5fbY7XxPyWKkKzFiZ3rstcyc71zVaUI9lC123VhK0rb25stbw2C1YTJvv
	qm2qOSRTz8L0+joDuunJIm0ntryNWTYaHW9BjLZCL/rPnd7/vhq8IR8XeNQ==
X-Gm-Gg: ASbGnct/Wa9b8CfzHC33WcsTRjmQgbEAbtydTIlKFg+gENOFKs+ROmDYu+Ipk/3goL6
	cayMiVv4gUFmcXk6pPhQTomko5ky8mj1AUxMjU5WlmNg1+hTHSBG6ovn89c7cRgcE21DVCT6TYB
	vqhZJltE/EwNXS+cr9fhEI3udeTeu7tCLTXehB0HMplRDMjzJaUMrU5mWGJvu+AiT0ZovfDHmoj
	wSJJbZNSRlbTSKcIuJA1JmIlBp5lxqHU2/mjTMqbd86STCK1U6nfPsB2KvLwJAMwelAffNwwAgm
	vcZ8qq9xtJATvaVt24Pqa2iEpAL6eQ4WUHqyOQR+XAevytsG4tVDhroXa/rNR1fNETryj6sIzKM
	h3dHdEE3oReifetfdk7QOGUF9hYvx7g==
X-Received: by 2002:a05:6000:290d:b0:429:c711:22d8 with SMTP id ffacd0b85a97d-42cb1f3857amr240117f8f.15.1763502959186;
        Tue, 18 Nov 2025 13:55:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYLG810iYRWSGhPkxUgtASRGajCK7Eg8R/pcfoMOkqI3MUEehaN5Oc5HCpmxPQ/ILKsOlzGQ==
X-Received: by 2002:a05:6000:290d:b0:429:c711:22d8 with SMTP id ffacd0b85a97d-42cb1f3857amr240101f8f.15.1763502958696;
        Tue, 18 Nov 2025 13:55:58 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae98sm33789800f8f.2.2025.11.18.13.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 13:55:58 -0800 (PST)
Date: Tue, 18 Nov 2025 16:55:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 08/12] virtio_net: Use existing classifier
 if possible
Message-ID: <20251118164952-mutt-send-email-mst@kernel.org>
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
> 
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

note that classifier has padding bytes.
comparing these with memcmp is not safe, is it?


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

what kind of locking prevents two threads racing in this code?


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


so you insert uninitialized refcount? can't another thread find it
meanwhile?

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


same questions about locking.


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

will free is no longer correct, is it?

> -		destroy_classifier(ff, c->id);
> +		try_destroy_classifier(ff, c->id);
>  		goto err_key;
>  	}
>  
> -- 
> 2.50.1


