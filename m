Return-Path: <netdev+bounces-239901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6D1C6DB92
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90EBF3872D2
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3252F33DEFF;
	Wed, 19 Nov 2025 09:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDYZmjeP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q34LyBg5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5146309DAB
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544375; cv=none; b=AjgTNbVe6npquEDrhUOkDNmynQBtcjksqXQcui7wIYPyyJahZhjsi3wJH4njC4+PkU3QBkxfM9VvHa8InsY+XJpciutkW5j4oBujPzEiNTaTOE8ObCoVraxiRIyL6UkrbZP8Zgt1/QJa5yIOepD4RXZWVN69GAzt0PPoj2Xyfgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544375; c=relaxed/simple;
	bh=JJcwz0bx1oxIm6FGLUg4rtPr6fl26Ggcd1mLYOQFhcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kT5lkRryfC7IyxiPiEDl9izeS4yfzuro2eGyoU+DOTD+kPA+/5KtAt8slRYffvRqxNW9nsFBOquenIo02yJUqA3SXg8f5M11C6umgq3qbnWllzFqfGK5UbHm6xLyjJoPDyqbKyYxtKFxemgwZH0AmqHLE/XJylfC1xErCfP7Ia0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDYZmjeP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q34LyBg5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763544371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kg6w3iuKZwh3LTVuqvZ2tolattLonAtduv2bEj/k2Dk=;
	b=gDYZmjeP5cxxkkcv6BTKC8IB0yqefAjS3klyPPwxXZhtQ9awQkGMrIdtGIgrOYSgW+p9Ka
	zKX+eY71heFf0SiUxeeQrgERFdmdmdOrQvFURUaGjUp7rt4zF3DhyRXno97yUjW9dfCdlX
	XquXgKz8fWQKn48RCt1+2UFCQ3uIbug=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-E-RpQPPvMX-n5Oh6nkZ_tw-1; Wed, 19 Nov 2025 04:26:10 -0500
X-MC-Unique: E-RpQPPvMX-n5Oh6nkZ_tw-1
X-Mimecast-MFC-AGG-ID: E-RpQPPvMX-n5Oh6nkZ_tw_1763544369
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477563e531cso59667225e9.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 01:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763544368; x=1764149168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kg6w3iuKZwh3LTVuqvZ2tolattLonAtduv2bEj/k2Dk=;
        b=q34LyBg5dNx+2ulyZUnYW7CIRcX2glMdyarG1lzC/wknvnWz2UTTWDb+o7E4UKlehC
         7h6jRN88CyEstZVteYIIHo2CwpOaQM5KYbtLmOafWVMo+QgqKhFndZITQMZmatzb9tQe
         kSTZWsKBfe9DN0UKX2Kx3kSxy3ngN3qPGecnWOKZxUQei0IoT/BX/QMiK7RpssSfoCXU
         rAd1rmZsXqkCP59azChozAnNdkMi0jDCMOpa1gXG67fK73oE7i1JLy46P+p9V3oyR/ZE
         Y/uy+66NOFa8/+Ck6NEcp7R+Un8rjlND5diW6961BLLPX1/kAUDBDZcQZ6LtLzhSHHuz
         nCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763544368; x=1764149168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kg6w3iuKZwh3LTVuqvZ2tolattLonAtduv2bEj/k2Dk=;
        b=fsKngt4WJBlqSSIYiJ00xqb0tQ8Sqm9OwyalHqBzwtn1NnQErJSogPiJJJ1xWfEJrq
         rV1xefLbLYT3hxgf85s6KJT7d8hIJ1ckyTX23Q9uwuzNqaP59HwW70vlPxcNU9w1j1PN
         COLhYbi8G/vVYiaeONCG4lC0+sQFti4/Gs5iIvm3AbXEGL1nBzqduV7MD71JIw0I9ZoU
         SszCOd1xrKMUuaSEag0W6FnY/eIncBv8f5iBOMcB5I7yf9iJwGF1BHHO0wLKyE+o6v4b
         2SzSACFnzAJQXPLqZ6FTCDkDNViav4RGihWdZQSNxUb//kLj/Nf1d2ajM/8P45yOp+vK
         +siA==
X-Gm-Message-State: AOJu0YyNqieqcQzl1i8IfqDr0r5lgsu5k8Ph7iINa757QttPhsIZPc4R
	w0KR/najF+Ex0yfsdVssotkdFrW6/h2ahSsFHzhExIXkery0I9d1+JMJQfFeBsZVodixG/bw+Jg
	u1PCNr7jiKB9mm+GJRPzAAye63Bou374I8RSwm+ealwUREFC3XN7+2V2ZTOTJ1elvGg==
X-Gm-Gg: ASbGnctWNb5URk0Jy00l8Cy1BB/uGHslBUvnkMZKzFzEvmu/WMg1K8HRTJddMXfxOnr
	2u71njVf/VDGvw7eyOm2SdsyZVxIKG2c5N6/88Ldu08Nj1J1Gyr4BwVqbD7vjnhIdtxbPUOTk+M
	f2NxXP/x+sgSxDXTvRlFX3nL4ACzqankSevsi9p0tpE5WwzEQjnJCvBUqpaeN71sJLEg1NTVS8k
	0M/+yw88W2TbTPS66aeUL+q+eBlYBYdG2m5JjlEfsV4CVhRHM6nO31bhDCF/11heeRF7m/vxBy6
	Ss2Uui6V6CtyxoiNXgxkoLc//3cpVyD1M6WGZBj4/dRAT0Ir9Q9/dDk7v01hcGcsNT+tTZDLDld
	kY/tVh10x7JHClPjuBeTF+1NPeX5vjQ==
X-Received: by 2002:a05:6000:1ace:b0:3eb:d906:e553 with SMTP id ffacd0b85a97d-42b595bb7f6mr19172433f8f.55.1763544368505;
        Wed, 19 Nov 2025 01:26:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVomqmKlWReLQMuWyS3MbD3ynvl2oZ2FTnd3twDk8bXDcAPeBlrnIcm3c30fp1inxoAhVROQ==
X-Received: by 2002:a05:6000:1ace:b0:3eb:d906:e553 with SMTP id ffacd0b85a97d-42b595bb7f6mr19172400f8f.55.1763544368034;
        Wed, 19 Nov 2025 01:26:08 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b12asm36639012f8f.10.2025.11.19.01.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 01:26:07 -0800 (PST)
Date: Wed, 19 Nov 2025 04:26:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
Message-ID: <20251119042245-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-8-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118143903.958844-8-danielj@nvidia.com>

On Tue, Nov 18, 2025 at 08:38:57AM -0600, Daniel Jurgens wrote:

...

> +static int insert_rule(struct virtnet_ff *ff,
> +		       struct virtnet_ethtool_rule *eth_rule,
> +		       u32 classifier_id,
> +		       const u8 *key,
> +		       size_t key_size)
> +{
> +	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
> +	struct virtio_net_resource_obj_ff_rule *ff_rule;
> +	int err;
> +
> +	ff_rule = kzalloc(sizeof(*ff_rule) + key_size, GFP_KERNEL);
> +	if (!ff_rule)
> +		return -ENOMEM;
> +
> +	/* Intentionally leave the priority as 0. All rules have the same
> +	 * priority.
> +	 */
> +	ff_rule->group_id = cpu_to_le32(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
> +	ff_rule->classifier_id = cpu_to_le32(classifier_id);
> +	ff_rule->key_length = (u8)key_size;
> +	ff_rule->action = fs->ring_cookie == RX_CLS_FLOW_DISC ?
> +					     VIRTIO_NET_FF_ACTION_DROP :
> +					     VIRTIO_NET_FF_ACTION_RX_VQ;
> +	ff_rule->vq_index = fs->ring_cookie != RX_CLS_FLOW_DISC ?
> +					       cpu_to_le16(fs->ring_cookie) : 0;
> +	memcpy(&ff_rule->keys, key, key_size);
> +
> +	err = virtio_admin_obj_create(ff->vdev,
> +				      VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
> +				      fs->location,
> +				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +				      0,
> +				      ff_rule,
> +				      sizeof(*ff_rule) + key_size);
> +	if (err)
> +		goto err_ff_rule;
> +
> +	eth_rule->classifier_id = classifier_id;
> +	ff->ethtool.num_rules++;
> +	kfree(ff_rule);
> +
> +	return 0;
> +
> +err_ff_rule:
> +	kfree(ff_rule);
> +
> +	return err;
> +}


...

> +static int build_and_insert(struct virtnet_ff *ff,
> +			    struct virtnet_ethtool_rule *eth_rule)
> +{
> +	struct virtio_net_resource_obj_ff_classifier *classifier;
> +	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
> +	struct virtio_net_ff_selector *selector;
> +	struct virtnet_classifier *c;
> +	size_t classifier_size;
> +	size_t key_size;
> +	int num_hdrs;
> +	u8 *key;
> +	int err;
> +
> +	calculate_flow_sizes(fs, &key_size, &classifier_size, &num_hdrs);
> +
> +	key = kzalloc(key_size, GFP_KERNEL);
> +	if (!key)
> +		return -ENOMEM;

So key is allocated here ...


> +
> +	/*
> +	 * virtio_net_ff_obj_ff_classifier is already included in the
> +	 * classifier_size.
> +	 */
> +	c = kzalloc(classifier_size +
> +		    sizeof(struct virtnet_classifier) -
> +		    sizeof(struct virtio_net_resource_obj_ff_classifier),
> +		    GFP_KERNEL);
> +	if (!c) {
> +		kfree(key);
> +		return -ENOMEM;
> +	}
> +
> +	c->size = classifier_size;
> +	classifier = &c->classifier;
> +	classifier->count = num_hdrs;
> +	selector = (void *)&classifier->selectors[0];
> +
> +	setup_eth_hdr_key_mask(selector, key, fs);
> +
> +	err = validate_classifier_selectors(ff, classifier, num_hdrs);
> +	if (err)
> +		goto err_key;
> +
> +	err = setup_classifier(ff, c);
> +	if (err)
> +		goto err_classifier;
> +
> +	err = insert_rule(ff, eth_rule, c->id, key, key_size);


... copied by insert_rule


> +	if (err) {
> +		/* destroy_classifier will free the classifier */
> +		destroy_classifier(ff, c->id);
> +		goto err_key;
> +	}
> +


... and apparently never freed?


I think it's because the API of insert_rule is confusing...

> +	return 0;
> +
> +err_classifier:
> +	kfree(c);
> +err_key:
> +	kfree(key);
> +
> +	return err;
> +}
> +

-- 
MST


