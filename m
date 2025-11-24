Return-Path: <netdev+bounces-241308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B75EC829F0
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 23:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F453AE2E8
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED03334C36;
	Mon, 24 Nov 2025 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McguKAH7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaTZd1MG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B19E2D6E66
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 22:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021891; cv=none; b=h7NOI6F0PsYmESq8xsb2cNROltWEdquUpLhgN7kN6KWDjVHyx22xFdmqSjUuToGCUZdNfrqgorfPWWbUG2xWuI1ODkqvZxEagAexCwqvzK4/N2odaBjFhT/KxQqct7uCRL6gQQH9Gpl/CgNaCWM/NjHpO8OLQ5K9qGqEwh3zQt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021891; c=relaxed/simple;
	bh=NFi4G2n1uMZYEwXBWV6BO8y08SlAW726DN8RLbyNzaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpGJqXJBTGpwPixja1kFaaz5V3whx3xmN/Rb/wvdNtJ5AJ2kMnrOEbZ4NEYsk5SNHVGyMMF0nvZWkZfgn56ORFE/2imKFzfkHNdWmcx7H7aWDyAamPefSc38do8ZQ0mK2sirNpiAV9Xdrn1KPDCxNQ3rmdTGTXHVr8Y+PbiNDxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=McguKAH7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aaTZd1MG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764021887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+O629B+qMO5boWUleDiLjisQSZzyD9d8ug/NcHfs/FQ=;
	b=McguKAH78opMP7kB/R+Gx2tHprKCUgyWKvPDN0ZV9V19NosOo5pPURl6pw99y+QWPSgtL/
	FuIVG9yP4+/Rjfg03OP5Joq77RsMjK0oFAWkr3st7dDYc/bW5uBv9KJ4/FMDtLAyLzfCcO
	IF0so/BPrwQUHKkME5PN0xkgY2matFs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-S5mEv3Q9OdSeLjUiNnBdOQ-1; Mon, 24 Nov 2025 17:04:44 -0500
X-MC-Unique: S5mEv3Q9OdSeLjUiNnBdOQ-1
X-Mimecast-MFC-AGG-ID: S5mEv3Q9OdSeLjUiNnBdOQ_1764021884
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477cf25ceccso12384105e9.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 14:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764021883; x=1764626683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+O629B+qMO5boWUleDiLjisQSZzyD9d8ug/NcHfs/FQ=;
        b=aaTZd1MGa8ZNMzrXmtM0gdbKcPMNn/wkU1QsWmDiWkUoe5HUB2ZcRxiyitMnaM6vF7
         A2ilf/hRI/Fy4EzTRB3/jGpK4RJo92hRDMc920vXneI2YhmVt0Nt/5lyDA+DRU/+kr58
         hbODwQCtVYsRa/2HO81wWfKnS55g301ZfOD725xshvTd5AquUrz23N2v8eUgFJdZxhf3
         1pWn//PB6SYP7wT6Z4LDoFRi5XUxZsWE/g1hThe4+8Fzva+ne++DSC79YtqHQZNEW8h7
         MpQVrqLQCtfAeNUlJ6YTO4TVwwjjrKtv7QGE/+Y+CLMi5xf6Ad3b/jnAq912mhmszdtY
         H3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764021883; x=1764626683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+O629B+qMO5boWUleDiLjisQSZzyD9d8ug/NcHfs/FQ=;
        b=R+88YGkX2v8ouJAG2RfNyXj05c4UHZuzIWgiDr4JjXNp9GRZkAXVCLn8tXkcx5OC54
         8HmBSuLHZwBQ2cOruOtrpKLtkbemFaNFSIP3u6BMVsEOWZsBX2Bzrnm9ywJziMcC76Q+
         Jn49yxXoofCl1+sJecn3+6J+gxMcP+xAtEiRqvD9gNEWjEltoEbZAvTQjWrsJ8+As7cS
         2IE2qbQs9eV/lEGTW1sByC7ejcDtmXrdzgATHMOPTDtR5zYSpvynFbV7OgWsLrHjlDQE
         bYULdSec2UhmJ8eYqvdUdyKstH8gFcAwZwsmysoLOFK4yAX8yRphwZMVMXj6C1czu2/Z
         sQAA==
X-Gm-Message-State: AOJu0YzHrDS28cYtfKrc6ponqWD1pS2pRIQrqBB4TOKheyO/M7q5mYMU
	T3aa9ormWjiRko2fh+wqu4NmE+vHa+yhXMgXpAKnDogbOjy8DfT7JIhEqyk55tQ28tTcLQ1ymEi
	jBPa+IfvspOL9E9r6BZYKGq0y5ZBJmNLPV2cV3fyJUN/mDHeIZfQUoIih3A==
X-Gm-Gg: ASbGncscX0/KGjK4kma59pDSNRB85iPsXgeaoPU4BhahnLgIIKCX48HLe7yr/5spvtY
	vkui68QloDf4zukoKNMuGWM9jw1uLasOZhJ6flA39V6k3Ws2s/oGUy9BbiS6uJIrMzY/CP4B+yw
	f6X7/r1bqQOH/zlYcXIiOnvGjVsHctJAxcTkhPDPxieQwDA4k+ZdYE05DwJoFoPCYinL3GWzH7Q
	SROW//CiAG9CwcSqHICV5LFgv/hGwECt0jiIMeIeJmJE49uTj3Y8wpIKv2l1LeNjF5+JO0fe7UI
	oVOm+GJ8CZXSccBvA7RogM5C+p0snfyOTjdypo6PH7ync5eJFfD7xatrGbmiqaHQ/+aE+ZhBkXc
	f6JwglOwjvpQXf8AzSvDKxm92Cxodgg==
X-Received: by 2002:a05:600c:1d23:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-47904b12ddbmr2879745e9.20.1764021883387;
        Mon, 24 Nov 2025 14:04:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLWolPoz1Gtb3rKgis0WwBvpWfkB0SGuJ04SkFbKQYhj+AuNKQCmj4OzGv7gPeYEILDTcnQA==
X-Received: by 2002:a05:600c:1d23:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-47904b12ddbmr2879555e9.20.1764021882937;
        Mon, 24 Nov 2025 14:04:42 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf355933sm223044435e9.2.2025.11.24.14.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 14:04:41 -0800 (PST)
Date: Mon, 24 Nov 2025 17:04:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 08/12] virtio_net: Use existing classifier
 if possible
Message-ID: <20251124170321-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-9-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119191524.4572-9-danielj@nvidia.com>

On Wed, Nov 19, 2025 at 01:15:19PM -0600, Daniel Jurgens wrote:
> Classifiers can be used by more than one rule. If there is an existing
> classifier, use it instead of creating a new one. If duplicate
> classifiers are created it would artifically limit the number of rules
> to the classifier limit, which is likely less than the rules limit.
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
> 
> v12:
>     - Clarified comment about destroy_classifier freeing. MST
>     - Renamed the classifier field of virtnet_classifier to obj. MST
>     - Explained why in commit message. MST
> ---
> ---
>  drivers/net/virtio_net.c | 51 ++++++++++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7600e2383a72..5e49cd78904f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -32,6 +32,7 @@
>  #include <uapi/linux/virtio_pci.h>
>  #include <uapi/linux/virtio_net_ff.h>
>  #include <linux/xarray.h>
> +#include <linux/refcount.h>
>  
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -302,7 +303,6 @@ struct virtnet_ff {
>  	struct virtio_net_ff_cap_mask_data *ff_mask;
>  	struct virtio_net_ff_actions *ff_actions;
>  	struct xarray classifiers;
> -	int num_classifiers;
>  	struct virtnet_ethtool_ff ethtool;
>  };
>  
> @@ -5816,12 +5816,13 @@ struct virtnet_ethtool_rule {
>  /* The classifier struct must be the last field in this struct */
>  struct virtnet_classifier {
>  	size_t size;
> +	refcount_t refcount;
>  	u32 id;
> -	struct virtio_net_resource_obj_ff_classifier classifier;
> +	struct virtio_net_resource_obj_ff_classifier obj;
>  };
>  
>  static_assert(sizeof(struct virtnet_classifier) ==
> -	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
> +	      ALIGN(offsetofend(struct virtnet_classifier, obj),
>  		    __alignof__(struct virtnet_classifier)),
>  	      "virtnet_classifier: classifier must be the last member");
>  
> @@ -5909,11 +5910,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
> +		    !memcmp(&tmp->obj, &(*c)->obj, tmp->size)) {
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
> @@ -5921,29 +5935,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
>  
>  	err = virtio_admin_obj_create(ff->vdev,
>  				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
> -				      c->id,
> +				      (*c)->id,
>  				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
>  				      0,
> -				      &c->classifier,
> -				      c->size);
> +				      &(*c)->obj,
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
> @@ -5967,7 +5982,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
>  				 0);
>  
>  	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> -	destroy_classifier(ff, eth_rule->classifier_id);
> +	try_destroy_classifier(ff, eth_rule->classifier_id);
>  	kfree(eth_rule);
>  }
>  
> @@ -6139,7 +6154,7 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	}
>  
>  	c->size = classifier_size;
> -	classifier = &c->classifier;
> +	classifier = &c->obj;
>  	classifier->count = num_hdrs;
>  	selector = (void *)&classifier->selectors[0];
>  
> @@ -6149,14 +6164,16 @@ static int build_and_insert(struct virtnet_ff *ff,
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
> -		/* destroy_classifier will free the classifier */
> -		destroy_classifier(ff, c->id);
> +		/* destroy_classifier release the reference on the classifier


try_destroy_classifier ? and I think you mean *will* release and free.

and what is "the reference"

> +		 * and free it if needed.
> +		 */
> +		try_destroy_classifier(ff, c->id);
>  		goto err_key;
>  	}
>  
> -- 
> 2.50.1


