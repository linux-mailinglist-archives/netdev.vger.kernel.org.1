Return-Path: <netdev+bounces-241328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D844C82B29
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 23:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7395B4E8780
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70772690E7;
	Mon, 24 Nov 2025 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTl3wzjn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbpH9l1b"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36621419A9
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023895; cv=none; b=s1Bt7LR8hbq6QwHmMohf5KMKKUOFhhYo/G8nfnLmsw3a33D//AsyzhUYohbOFZnsq1ZBy49TgcZtYK4fMpDpa6ZRSzR4MhStTILtyP1VNHxmVpZlIWFlbQ0TnZmBh96dkN/jnx5Ku4cHyyySiqxh4RaFwBrxqOfTtwoHRmBPhtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023895; c=relaxed/simple;
	bh=MlVlvpsNZWXaqH1VbhW24JCjPkB+3j33oQrLeC90GJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dS+liXORhwh9gPk4MgFu+ipSk0lNSoLhNgAVl3w/Kh3gEJUjIGnQahe2bIdlPwESDmJcD4DgJDYtz+EOQZD1QGQCOFEbFmZLr2j0wushnSb+tPPlzI1bHtWFCnGVO+6Rr1jEo/PD3wWZLzX3ttBgkAy10eygIIYtNLEF7ogbHq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTl3wzjn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XbpH9l1b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764023892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msUF1V1H5YwxkxUBqlExWjc40jwM55YDfoB0wV7R5Oc=;
	b=gTl3wzjnoli0b/n7uxscNe6fRQnkL992ShRKxFOzlQq0xAOanZzofrfqSPIl24tdqGf4uw
	qA8bDy167pJtIlhz0nwgtlxdVxLoDhbUXkGl7vBYEviyQm8Tv9UidldFAkQFdlkiMAf1xH
	f03CpfKLMBJO40ngWqi6ksOO/JPXnYk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-9hsq1NMMPryQpg6-pAv8VQ-1; Mon, 24 Nov 2025 17:38:10 -0500
X-MC-Unique: 9hsq1NMMPryQpg6-pAv8VQ-1
X-Mimecast-MFC-AGG-ID: 9hsq1NMMPryQpg6-pAv8VQ_1764023889
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477563e531cso41039875e9.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 14:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764023889; x=1764628689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=msUF1V1H5YwxkxUBqlExWjc40jwM55YDfoB0wV7R5Oc=;
        b=XbpH9l1bW+WlUh79Cdt4nv26SZoH+dLR2EGHVYh4n/Eb5XqcCymluElYJgNpb+H7Op
         pToggwHIWnQZO9k5WpqjRotXLjyTc1+LI8p/YJEtNXsLhr6FyWciomGE9VDSuBS/tOg4
         TQtgsCYzvFomYqn0p7vnJeo2s5oTvMlbY3ZEvqGBFn2lbq9enqnhdzR3fZd10n6W56h/
         tvm8XglUhW7xTjhMbACrg9VxYCx4NKemXAtrimkRObFMRmkQWfvwOXHZq/J48RXaUOd7
         qFiMVZATnQAmXQvnEPr9l4ySV0iGBLH26dvrmPfEzsxsCEg2vhO3OvCc8fyuBAk6vmMR
         Ktvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764023889; x=1764628689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msUF1V1H5YwxkxUBqlExWjc40jwM55YDfoB0wV7R5Oc=;
        b=KR0IiJCeWhVQ23VbhEeAEzvHnHTXBk8nSTlhxRFgqG3N/AE+bOYmv1N/5DpHDwAenS
         7GI/ZTCMctaOiG3+CV9hLDg789FT5gFkCb45uEaDfoTkeJSVbtzQnOBXFAc+jKhEZlLC
         +E+a2zCLFiAM514xyPtUzgSvzXC/Xl9jxuw4BDaS9ZjYJfYUK/qE6Ppvrfr4jn9jELgc
         sU8D1Z356qzK1p42GFqv1ialuPOVlu3Mybx+7HVJ1vMm+GecuQIG+FGkqq34lCAdvgFz
         C8WWWZ0KPvQsbPahAPMUcy41VsUq/cxWXELhNeCqc7e7GuXy55nH9hgMVnbPDIzNvjCR
         2rqA==
X-Gm-Message-State: AOJu0YxTeu9Qg57IXUUknqg7hbyFH4j5XjyKxvwOFW0kukBuXbz8n0zL
	df9Z0/HkPRyDiNc9WWLvRWulp3Pf10LL2MshgTxJjHaZL/pbESHobFzAbEXx9uXAcIfPksRsRMq
	Sw6k8QwlPhjYAlnL0UDDToDpVWA60Y+Ljhrp8eFODk75KsLltNa5pb0N+IQ==
X-Gm-Gg: ASbGnct4py9ABp2LbNRQ4VvQufl5TsIT815BzzvLAE5ZmsJKIZyZQoA9Idwz3TgymQf
	Lqp0DXZ5exHw/rt5yHSJWJb0Owc1A1y6hLgnrRk2AT4H3EaEIbNueGiDT2gNhT5ic3SAH5iBFrY
	fbuRPq7votKFsUdFrPfxS9V1A/BKqbZsEcWF4805k+T3w9zoHhKO9Qwh21Efq/G8EULZnR05NfU
	1AI3YSxKaR8ICifaQr65n3R50dXy/coLtIjHoPdc68reHBPJPRoPKV7nTAGIn9E8Wr5zUW0zOj/
	Da2dE8wiICskPBb2/CEvQbKrNZnhkrPUyzXsqWQ42zoC9Aeu31ZrfhnRmjW0tWP41VgdnkyF2wh
	HwZIQPn1gCTmRSmDy69Vxjj+Al7SwKQ==
X-Received: by 2002:a05:600c:3108:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-477c110d83fmr98088975e9.9.1764023888955;
        Mon, 24 Nov 2025 14:38:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAlWhBMnkWCfhAIqp5gaAq+iu2thveVYcfwmW9pG3VyiuYtKkTzJJsZMCM6pVko1WeiMyr9A==
X-Received: by 2002:a05:600c:3108:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-477c110d83fmr98088895e9.9.1764023888505;
        Mon, 24 Nov 2025 14:38:08 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa35c2sm29492381f8f.25.2025.11.24.14.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 14:38:07 -0800 (PST)
Date: Mon, 24 Nov 2025 17:38:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 08/12] virtio_net: Use existing classifier
 if possible
Message-ID: <20251124173322-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-9-danielj@nvidia.com>
 <20251124170321-mutt-send-email-mst@kernel.org>
 <d793f3da-17f8-489c-b48e-d1917412b87f@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d793f3da-17f8-489c-b48e-d1917412b87f@nvidia.com>

On Mon, Nov 24, 2025 at 04:31:54PM -0600, Dan Jurgens wrote:
> On 11/24/25 4:04 PM, Michael S. Tsirkin wrote:
> > On Wed, Nov 19, 2025 at 01:15:19PM -0600, Daniel Jurgens wrote:
> >> Classifiers can be used by more than one rule. If there is an existing
> >> classifier, use it instead of creating a new one. If duplicate
> >> classifiers are created it would artifically limit the number of rules
> >> to the classifier limit, which is likely less than the rules limit.
> >>
> >> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> >> Reviewed-by: Parav Pandit <parav@nvidia.com>
> >> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >> ---
> >> v4:
> >>     - Fixed typo in commit message
> >>     - for (int -> for (
> >>
> >> v8:
> >>     - Removed unused num_classifiers. Jason Wang
> >>
> >> v12:
> >>     - Clarified comment about destroy_classifier freeing. MST
> >>     - Renamed the classifier field of virtnet_classifier to obj. MST
> >>     - Explained why in commit message. MST
> >> ---
> >> ---
> >>  drivers/net/virtio_net.c | 51 ++++++++++++++++++++++++++--------------
> >>  1 file changed, 34 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index 7600e2383a72..5e49cd78904f 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -32,6 +32,7 @@
> >>  #include <uapi/linux/virtio_pci.h>
> >>  #include <uapi/linux/virtio_net_ff.h>
> >>  #include <linux/xarray.h>
> >> +#include <linux/refcount.h>
> >>  
> >>  static int napi_weight = NAPI_POLL_WEIGHT;
> >>  module_param(napi_weight, int, 0444);
> >> @@ -302,7 +303,6 @@ struct virtnet_ff {
> >>  	struct virtio_net_ff_cap_mask_data *ff_mask;
> >>  	struct virtio_net_ff_actions *ff_actions;
> >>  	struct xarray classifiers;
> >> -	int num_classifiers;
> >>  	struct virtnet_ethtool_ff ethtool;
> >>  };
> >>  
> >> @@ -5816,12 +5816,13 @@ struct virtnet_ethtool_rule {
> >>  /* The classifier struct must be the last field in this struct */
> >>  struct virtnet_classifier {
> >>  	size_t size;
> >> +	refcount_t refcount;
> >>  	u32 id;
> >> -	struct virtio_net_resource_obj_ff_classifier classifier;
> >> +	struct virtio_net_resource_obj_ff_classifier obj;
> >>  };
> >>  
> >>  static_assert(sizeof(struct virtnet_classifier) ==
> >> -	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
> >> +	      ALIGN(offsetofend(struct virtnet_classifier, obj),
> >>  		    __alignof__(struct virtnet_classifier)),
> >>  	      "virtnet_classifier: classifier must be the last member");
> >>  
> >> @@ -5909,11 +5910,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
> >>  	return false;
> >>  }
> >>  
> >> -static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
> >> +static int setup_classifier(struct virtnet_ff *ff,
> >> +			    struct virtnet_classifier **c)
> >>  {
> >> +	struct virtnet_classifier *tmp;
> >> +	unsigned long i;
> >>  	int err;
> >>  
> >> -	err = xa_alloc(&ff->classifiers, &c->id, c,
> >> +	xa_for_each(&ff->classifiers, i, tmp) {
> >> +		if ((*c)->size == tmp->size &&
> >> +		    !memcmp(&tmp->obj, &(*c)->obj, tmp->size)) {
> >> +			refcount_inc(&tmp->refcount);
> >> +			kfree(*c);
> >> +			*c = tmp;
> >> +			goto out;
> >> +		}
> >> +	}
> >> +
> >> +	err = xa_alloc(&ff->classifiers, &(*c)->id, *c,
> >>  		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
> >>  		       GFP_KERNEL);
> >>  	if (err)
> >> @@ -5921,29 +5935,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
> >>  
> >>  	err = virtio_admin_obj_create(ff->vdev,
> >>  				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
> >> -				      c->id,
> >> +				      (*c)->id,
> >>  				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
> >>  				      0,
> >> -				      &c->classifier,
> >> -				      c->size);
> >> +				      &(*c)->obj,
> >> +				      (*c)->size);
> >>  	if (err)
> >>  		goto err_xarray;
> >>  
> >> +	refcount_set(&(*c)->refcount, 1);
> >> +out:
> >>  	return 0;
> >>  
> >>  err_xarray:
> >> -	xa_erase(&ff->classifiers, c->id);
> >> +	xa_erase(&ff->classifiers, (*c)->id);
> >>  
> >>  	return err;
> >>  }
> >>  
> >> -static void destroy_classifier(struct virtnet_ff *ff,
> >> -			       u32 classifier_id)
> >> +static void try_destroy_classifier(struct virtnet_ff *ff, u32 classifier_id)
> >>  {
> >>  	struct virtnet_classifier *c;
> >>  
> >>  	c = xa_load(&ff->classifiers, classifier_id);
> >> -	if (c) {
> >> +	if (c && refcount_dec_and_test(&c->refcount)) {
> >>  		virtio_admin_obj_destroy(ff->vdev,
> >>  					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
> >>  					 c->id,
> >> @@ -5967,7 +5982,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
> >>  				 0);
> >>  
> >>  	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> >> -	destroy_classifier(ff, eth_rule->classifier_id);
> >> +	try_destroy_classifier(ff, eth_rule->classifier_id);
> >>  	kfree(eth_rule);
> >>  }
> >>  
> >> @@ -6139,7 +6154,7 @@ static int build_and_insert(struct virtnet_ff *ff,
> >>  	}
> >>  
> >>  	c->size = classifier_size;
> >> -	classifier = &c->classifier;
> >> +	classifier = &c->obj;
> >>  	classifier->count = num_hdrs;
> >>  	selector = (void *)&classifier->selectors[0];
> >>  
> >> @@ -6149,14 +6164,16 @@ static int build_and_insert(struct virtnet_ff *ff,
> >>  	if (err)
> >>  		goto err_key;
> >>  
> >> -	err = setup_classifier(ff, c);
> >> +	err = setup_classifier(ff, &c);
> >>  	if (err)
> >>  		goto err_classifier;
> >>  
> >>  	err = insert_rule(ff, eth_rule, c->id, key, key_size);
> >>  	if (err) {
> >> -		/* destroy_classifier will free the classifier */
> >> -		destroy_classifier(ff, c->id);
> >> +		/* destroy_classifier release the reference on the classifier
> > 
> > 
> > try_destroy_classifier ? and I think you mean *will* release and free.
> > 
> > and what is "the reference"
> 
> I see the comment is munged. But classifiers are reference counted,
> try_destroy_classifier will release the reference. And free if the
> refcount is now 0.
> 
> See setup_classifier above.


ah I got it.
you mean refcount - the reference count - not "the reference".
And in the context of refcount_t there's decrement and
increment, not "release". acquire/release in fact refer to memory ordering.

> > 
> >> +		 * and free it if needed.
> >> +		 */
> >> +		try_destroy_classifier(ff, c->id);
> >>  		goto err_key;
> >>  	}
> >>  
> >> -- 
> >> 2.50.1
> > 


