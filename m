Return-Path: <netdev+bounces-226522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954E7BA171A
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 22:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E7F62789E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 20:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6885321278;
	Thu, 25 Sep 2025 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+xmqDHK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC7531D726
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 20:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833947; cv=none; b=ifBMWW3JDh5h/X96JqHZHBbxbbNT9bhP+Ak65Ut50useItuPJbmYUQ5ht1oHmhbmQFqQCYVKfw3SoJA/C1HSssNGfiSmH49AQed6GNMDczP/fEihx+a6sY3wlDqEYGiqNfqVG0yddJvyz6vKnUSweNLOE6+XrgdaaXaET9TAKB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833947; c=relaxed/simple;
	bh=DtmEksuN1Ci/n853yGLsRemZIsy2spxLUI/c97VeSbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syBl8BfPTAXucAUL/1BJ4DbUX46p2gfs61CEEnQKPDJCxftvsGvgIXar5OmMeqjiXOFn4yfg3pBgFiDqMr757BJQ+gpBqfH9BXKhpPFPTedo5T8+f/Cn5memIdm0TTb3LsYphWZ/+hjn7TURdcyLnER3nwDybwnBmsunmpPu3mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+xmqDHK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758833944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IbbaDUgKqAvvAfMSG8datc+32QOmSQ6I0+wSFJlGPXo=;
	b=V+xmqDHK2ZNpgZnltSsyFi4G99X88htKVQ9FIde4hjeFO1bEK9NuX2X6YnGBWETkemEACK
	mFNaJIW2139aLuCiTNmMmJBYi55V/to0gsZCcbgThWhnnHQfGhtjsEMlaXBeyy1oyko0Z6
	Om/fFn6NlKDkgkE9ji9kaeNumV8ZCeE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-P7rtwy9jNe62AO95ABEZlw-1; Thu, 25 Sep 2025 16:59:02 -0400
X-MC-Unique: P7rtwy9jNe62AO95ABEZlw-1
X-Mimecast-MFC-AGG-ID: P7rtwy9jNe62AO95ABEZlw_1758833942
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e38bd6680so3138955e9.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 13:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758833941; x=1759438741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbbaDUgKqAvvAfMSG8datc+32QOmSQ6I0+wSFJlGPXo=;
        b=Zl4VDvWIaj64Xukh1+dEne3njTLrZpbWi/ojTerVKhYGpBh1IOh43xm5adl+vthdpZ
         eTC8sY4+rjUQolaEGw9p0NPAAqRutT4bk33UnzTTGFSjn7n7L6oBtAaQeG1NCAx+oGGH
         mTJWo2QcA96eewLW1CzDd/nfy9lfx5Jpnqo1RICOuFrOTx5tBjTL/f6gtZ4OCQ3BlK2e
         AYPAifvPhPs0cKJkbIg3ZYKWE0vQeDGC/LARjsu/ZCntPieLQdQalB3cFdVjuK4eqiD4
         ZU4CFXsP5buOgzdYrSF9+5fvPty/eiUU8cvlN4xI7pIF5+1wTH6XLq5fXAq9gYqeAamZ
         PdMg==
X-Gm-Message-State: AOJu0YyyoRUnZm327To0Iq3f4Gy2pQIPdAOqA0gtkyuWzHP0JCAk6RaO
	byXS8giFqNjvxnplvlLo5kqOWgDT+4gAi3PQ4vECZ7xzKM9fOSOJpq8omQ52GqbGTnRfOflazkL
	R4HO6UeGA1DsTf6R4vc5g8sNaVkINn8l1nuINt+s3Z4Js7R8b5pQLhiHkag/Z8l5XBw==
X-Gm-Gg: ASbGncvzs1F6qlB7ZYIZUDdvm3LHbb31VAQVulI90+Tx1H42RDpv67J/+rxvatbrQJZ
	5lDaPg6Tq3/2pV/SxKBj1TKZEMB/KK8VYm94SDGh7NIUzSUywadq0HwXGL+LG1TC6EFYmBjZsER
	kIY87hsJwFkIIQOMeJnIBpj6wbHBg2DaNIs3oUeZL1LP5ugHlk41QX7zm1AitKISyH8FsgEaTD6
	Y336UHHMzf96pdsaGWkXaxfUn2M1HXywFI0vP+rVR5hAsbd9i6+mdjn/CuWcehfItoRZPRlNnHr
	4OOmgy0kne1VSIsoF/mwg9KRF0h1IZJLpA==
X-Received: by 2002:a05:600c:4743:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-46e33b2ca06mr40304005e9.32.1758833941014;
        Thu, 25 Sep 2025 13:59:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcDbVCXya6KhNiqDf5OQF6qVKhJ/2xfk0bXFfaJkypTkHbzKP8peRxgKnj8LEpD/G3tMxFXg==
X-Received: by 2002:a05:600c:4743:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-46e33b2ca06mr40303715e9.32.1758833940352;
        Thu, 25 Sep 2025 13:59:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31bdesm88150415e9.11.2025.09.25.13.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:58:59 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:58:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 06/11] virtio_net: Implement layer 2 ethtool
 flow rules
Message-ID: <20250925165406-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-7-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923141920.283862-7-danielj@nvidia.com>

On Tue, Sep 23, 2025 at 09:19:15AM -0500, Daniel Jurgens wrote:
> Filtering a flow requires a classifier to match the packets, and a rule
> to filter on the matches.
> 
> A classifier consists of one or more selectors. There is one selector
> per header type. A selector must only use fields set in the selector
> capabality.


capability

> If partial matching is supported, the classifier mask for a
> particular field can be a subset of the mask for that field in the
> capability.
> 
> The rule consists of a priority, an action and a key. The key is a byte
> array containing headers corresponding to the selectors in the
> classifier.
> 
> This patch implements ethtool rules for ethernet headers.
> 
> Example:
> $ ethtool -U ens9 flow-type ether dst 08:11:22:33:44:54 action 30
> Added rule with ID 1
> 
> The rule in the example directs received packets with the specified
> destination MAC address to rq 30.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>


overall pls use void* not u8* then you will not need so
many casts, just assignments

> ---
>  drivers/net/virtio_net/virtio_net_ff.c   | 423 +++++++++++++++++++++++
>  drivers/net/virtio_net/virtio_net_ff.h   |  14 +
>  drivers/net/virtio_net/virtio_net_main.c |  16 +
>  include/uapi/linux/virtio_net_ff.h       |  20 ++
>  4 files changed, 473 insertions(+)
> 
> diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
> index 0036c2db9f77..e3c34bfd1d55 100644
> --- a/drivers/net/virtio_net/virtio_net_ff.c
> +++ b/drivers/net/virtio_net/virtio_net_ff.c
> @@ -9,6 +9,418 @@
>  #define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
>  #define VIRTNET_FF_MAX_GROUPS 1
>  
> +struct virtnet_ethtool_rule {
> +	struct ethtool_rx_flow_spec flow_spec;
> +	u32 classifier_id;
> +};
> +
> +/* New fields must be added before the classifier struct */

meaning classifier must be last? then pls say so.
maybe add BUILD_BUG_ON to test this, too.

> +struct virtnet_classifier {
> +	size_t size;
> +	u32 id;
> +	struct virtio_net_resource_obj_ff_classifier classifier;
> +};
> +
> +static bool check_mask_vs_cap(const void *m, const void *c,
> +			      u16 len, bool partial)
> +{
> +	const u8 *mask = m;
> +	const u8 *cap = c;
> +	int i;
> +
> +	for (i = 0; i < len; i++) {
> +		if (partial && ((mask[i] & cap[i]) != mask[i]))
> +			return false;
> +		if (!partial && mask[i] != cap[i])
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +static
> +struct virtio_net_ff_selector *get_selector_cap(const struct virtnet_ff *ff,
> +						u8 selector_type)
> +{
> +	struct virtio_net_ff_selector *sel;
> +	u8 *buf;

make it void * you will not need casts

and assignment is cleaner with the declaration.

> +	int i;
> +
> +	buf = (u8 *)&ff->ff_mask->selectors;
> +	sel = (struct virtio_net_ff_selector *)buf;
> +
> +	for (i = 0; i < ff->ff_mask->count; i++) {
> +		if (sel->type == selector_type)
> +			return sel;
> +
> +		buf += sizeof(struct virtio_net_ff_selector) + sel->length;
> +		sel = (struct virtio_net_ff_selector *)buf;
> +	}
> +
> +	return NULL;
> +}
> +
> +static bool validate_eth_mask(const struct virtnet_ff *ff,
> +			      const struct virtio_net_ff_selector *sel,
> +			      const struct virtio_net_ff_selector *sel_cap)
> +{
> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
> +	struct ethhdr *cap, *mask;
> +	struct ethhdr zeros = {0};

just {} is the same.

> +
> +	cap = (struct ethhdr *)&sel_cap->mask;
> +	mask = (struct ethhdr *)&sel->mask;

do we know they are big enough?


> +
> +	if (memcmp(&zeros.h_dest, mask->h_dest, sizeof(zeros.h_dest)) &&
> +	    !check_mask_vs_cap(mask->h_dest, cap->h_dest,
> +			       sizeof(mask->h_dest), partial_mask))
> +		return false;
> +
> +	if (memcmp(&zeros.h_source, mask->h_source, sizeof(zeros.h_source)) &&
> +	    !check_mask_vs_cap(mask->h_source, cap->h_source,
> +			       sizeof(mask->h_source), partial_mask))
> +		return false;
> +
> +	if (mask->h_proto &&
> +	    !check_mask_vs_cap(&mask->h_proto, &cap->h_proto,
> +			       sizeof(__be16), partial_mask))
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool validate_mask(const struct virtnet_ff *ff,
> +			  const struct virtio_net_ff_selector *sel)
> +{
> +	struct virtio_net_ff_selector *sel_cap = get_selector_cap(ff, sel->type);
> +
> +	if (!sel_cap)
> +		return false;
> +
> +	switch (sel->type) {
> +	case VIRTIO_NET_FF_MASK_TYPE_ETH:
> +		return validate_eth_mask(ff, sel, sel_cap);
> +	}
> +
> +	return false;
> +}
> +
> +static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
> +{
> +	int err;
> +
> +	err = xa_alloc(&ff->classifiers, &c->id, c,
> +		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
> +		       GFP_KERNEL);
> +	if (err)
> +		return err;
> +
> +	err = virtio_device_object_create(ff->vdev,
> +					  VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
> +					  c->id,
> +					  &c->classifier,
> +					  c->size);
> +	if (err)
> +		goto err_xarray;
> +
> +	return 0;
> +
> +err_xarray:
> +	xa_erase(&ff->classifiers, c->id);
> +
> +	return err;
> +}
> +
> +static void destroy_classifier(struct virtnet_ff *ff,
> +			       u32 classifier_id)
> +{
> +	struct virtnet_classifier *c;
> +
> +	c = xa_load(&ff->classifiers, classifier_id);
> +	if (c) {
> +		virtio_device_object_destroy(ff->vdev,
> +					     VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
> +					     c->id);
> +
> +		xa_erase(&ff->classifiers, c->id);
> +		kfree(c);
> +	}
> +}
> +
> +static void destroy_ethtool_rule(struct virtnet_ff *ff,
> +				 struct virtnet_ethtool_rule *eth_rule)
> +{
> +	ff->ethtool.num_rules--;
> +
> +	virtio_device_object_destroy(ff->vdev,
> +				     VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
> +				     eth_rule->flow_spec.location);
> +
> +	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> +	destroy_classifier(ff, eth_rule->classifier_id);
> +	kfree(eth_rule);
> +}
> +
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
> +	if (!ff_rule) {
> +		err = -ENOMEM;
> +		goto err_eth_rule;
> +	}
> +	/*
> +	 * Intentionally leave the priority as 0. All rules have the same
> +	 * priority.
> +	 */


Not the right style of comment for net.

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
> +	err = virtio_device_object_create(ff->vdev,
> +					  VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
> +					  fs->location,
> +					  ff_rule,
> +					  sizeof(*ff_rule) + key_size);
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
> +err_eth_rule:
> +	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> +	kfree(eth_rule);
> +
> +	return err;
> +}
> +
> +static u32 flow_type_mask(u32 flow_type)
> +{
> +	return flow_type & ~(FLOW_EXT | FLOW_MAC_EXT | FLOW_RSS);
> +}
> +
> +static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
> +{
> +	switch (fs->flow_type) {
> +	case ETHER_FLOW:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int validate_flow_input(struct virtnet_ff *ff,
> +			       const struct ethtool_rx_flow_spec *fs,
> +			       u16 curr_queue_pairs)
> +{
> +	/* Force users to use RX_CLS_LOC_ANY - don't allow specific locations */
> +	if (fs->location != RX_CLS_LOC_ANY)
> +		return -EOPNOTSUPP;
> +
> +	if (fs->ring_cookie != RX_CLS_FLOW_DISC &&
> +	    fs->ring_cookie >= curr_queue_pairs)
> +		return -EINVAL;
> +
> +	if (fs->flow_type != flow_type_mask(fs->flow_type))
> +		return -EOPNOTSUPP;
> +
> +	if (!supported_flow_type(fs))
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
> +static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
> +				 size_t *key_size, size_t *classifier_size,
> +				 int *num_hdrs)
> +{
> +	*num_hdrs = 1;
> +	*key_size = sizeof(struct ethhdr);
> +	/*
> +	 * The classifier size is the size of the classifier header, a selector
> +	 * header for each type of header in the match criteria, and each header
> +	 * providing the mask for matching against.
> +	 */
> +	*classifier_size = *key_size +
> +			   sizeof(struct virtio_net_resource_obj_ff_classifier) +
> +			   sizeof(struct virtio_net_ff_selector) * (*num_hdrs);
> +}
> +
> +static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
> +				   u8 *key,
> +				   const struct ethtool_rx_flow_spec *fs)
> +{
> +	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
> +	struct ethhdr *eth_k = (struct ethhdr *)key;
> +
> +	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
> +	selector->length = sizeof(struct ethhdr);
> +
> +	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
> +	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
> +}
> +
> +static int
> +validate_classifier_selectors(struct virtnet_ff *ff,
> +			      struct virtio_net_resource_obj_ff_classifier *classifier,
> +			      int num_hdrs)
> +{
> +	struct virtio_net_ff_selector *selector = classifier->selectors;
> +
> +	for (int i = 0; i < num_hdrs; i++) {
> +		if (!validate_mask(ff, selector))
> +			return -EINVAL;
> +
> +		selector = (struct virtio_net_ff_selector *)(((u8 *)selector) +
> +			    sizeof(*selector) + selector->length);
> +	}
> +
> +	return 0;
> +}
> +
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
> +	selector = &classifier->selectors[0];
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
> +	if (err) {
> +		destroy_classifier(ff, c->id);
> +		goto err_key;
> +	}
> +
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
> +int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
> +				struct ethtool_rx_flow_spec *fs,
> +				u16 curr_queue_pairs)
> +{
> +	struct virtnet_ethtool_rule *eth_rule;
> +	int err;
> +
> +	if (!ff->ff_supported)
> +		return -EOPNOTSUPP;
> +
> +	err = validate_flow_input(ff, fs, curr_queue_pairs);
> +	if (err)
> +		return err;
> +
> +	eth_rule = kzalloc(sizeof(*eth_rule), GFP_KERNEL);
> +	if (!eth_rule)
> +		return -ENOMEM;
> +
> +	err = xa_alloc(&ff->ethtool.rules, &fs->location, eth_rule,
> +		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->rules_limit) - 1),
> +		       GFP_KERNEL);
> +	if (err)
> +		goto err_rule;
> +
> +	eth_rule->flow_spec = *fs;
> +
> +	err = build_and_insert(ff, eth_rule);
> +	if (err)
> +		goto err_xa;
> +
> +	return err;
> +
> +err_xa:
> +	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> +
> +err_rule:
> +	fs->location = RX_CLS_LOC_ANY;
> +	kfree(eth_rule);
> +
> +	return err;
> +}
> +
> +int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
> +{
> +	struct virtnet_ethtool_rule *eth_rule;
> +	int err = 0;
> +
> +	if (!ff->ff_supported)
> +		return -EOPNOTSUPP;
> +
> +	eth_rule = xa_load(&ff->ethtool.rules, location);
> +	if (!eth_rule) {
> +		err = -ENOENT;
> +		goto out;
> +	}
> +
> +	destroy_ethtool_rule(ff, eth_rule);
> +out:
> +	return err;
> +}
> +
>  static size_t get_mask_size(u16 type)
>  {
>  	switch (type) {
> @@ -142,6 +554,8 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	if (err)
>  		goto err_ff_action;
>  
> +	xa_init_flags(&ff->classifiers, XA_FLAGS_ALLOC);
> +	xa_init_flags(&ff->ethtool.rules, XA_FLAGS_ALLOC);
>  	ff->vdev = vdev;
>  	ff->ff_supported = true;
>  
> @@ -157,9 +571,18 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  
>  void virtnet_ff_cleanup(struct virtnet_ff *ff)
>  {
> +	struct virtnet_ethtool_rule *eth_rule;
> +	unsigned long i;
> +
>  	if (!ff->ff_supported)
>  		return;
>  
> +	xa_for_each(&ff->ethtool.rules, i, eth_rule)
> +		destroy_ethtool_rule(ff, eth_rule);
> +
> +	xa_destroy(&ff->ethtool.rules);
> +	xa_destroy(&ff->classifiers);
> +
>  	virtio_device_object_destroy(ff->vdev,
>  				     VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
>  				     VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
> diff --git a/drivers/net/virtio_net/virtio_net_ff.h b/drivers/net/virtio_net/virtio_net_ff.h
> index 4aac0bd08b63..94b575fbd9ed 100644
> --- a/drivers/net/virtio_net/virtio_net_ff.h
> +++ b/drivers/net/virtio_net/virtio_net_ff.h
> @@ -3,20 +3,34 @@
>   * Header file for virtio_net flow filters
>   */
>  #include <linux/virtio_admin.h>
> +#include <uapi/linux/ethtool.h>
>  
>  #ifndef _VIRTIO_NET_FF_H
>  #define _VIRTIO_NET_FF_H
>  
> +struct virtnet_ethtool_ff {
> +	struct xarray rules;
> +	int    num_rules;
> +};
> +
>  struct virtnet_ff {
>  	struct virtio_device *vdev;
>  	bool ff_supported;
>  	struct virtio_net_ff_cap_data *ff_caps;
>  	struct virtio_net_ff_cap_mask_data *ff_mask;
>  	struct virtio_net_ff_actions *ff_actions;
> +	struct xarray classifiers;
> +	int num_classifiers;
> +	struct virtnet_ethtool_ff ethtool;
>  };
>  
>  void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev);
>  
>  void virtnet_ff_cleanup(struct virtnet_ff *ff);
>  
> +int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
> +				struct ethtool_rx_flow_spec *fs,
> +				u16 curr_queue_pairs);
> +int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
> +
>  #endif /* _VIRTIO_NET_FF_H */
> diff --git a/drivers/net/virtio_net/virtio_net_main.c b/drivers/net/virtio_net/virtio_net_main.c
> index ebf3e5db0d64..808988cdf265 100644
> --- a/drivers/net/virtio_net/virtio_net_main.c
> +++ b/drivers/net/virtio_net/virtio_net_main.c
> @@ -5619,6 +5619,21 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
>  	return vi->curr_queue_pairs;
>  }
>  
> +static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +
> +	switch (info->cmd) {
> +	case ETHTOOL_SRXCLSRLINS:
> +		return virtnet_ethtool_flow_insert(&vi->ff, &info->fs,
> +						   vi->curr_queue_pairs);
> +	case ETHTOOL_SRXCLSRLDEL:
> +		return virtnet_ethtool_flow_remove(&vi->ff, info->fs.location);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
>  static const struct ethtool_ops virtnet_ethtool_ops = {
>  	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
>  		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
> @@ -5645,6 +5660,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>  	.get_rxfh_fields = virtnet_get_hashflow,
>  	.set_rxfh_fields = virtnet_set_hashflow,
>  	.get_rx_ring_count = virtnet_get_rx_ring_count,
> +	.set_rxnfc = virtnet_set_rxnfc,
>  };
>  
>  static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,
> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
> index 662693e1fefd..f258964322f4 100644
> --- a/include/uapi/linux/virtio_net_ff.h
> +++ b/include/uapi/linux/virtio_net_ff.h
> @@ -13,6 +13,8 @@
>  #define VIRTIO_NET_FF_ACTION_CAP 0x802
>  
>  #define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
> +#define VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER 0x0201
> +#define VIRTIO_NET_RESOURCE_OBJ_FF_RULE 0x0202
>  
>  struct virtio_net_ff_cap_data {
>  	__le32 groups_limit;
> @@ -59,4 +61,22 @@ struct virtio_net_resource_obj_ff_group {
>  	__le16 group_priority;
>  };
>  
> +struct virtio_net_resource_obj_ff_classifier {
> +	__u8 count;
> +	__u8 reserved[7];
> +	struct virtio_net_ff_selector selectors[];
> +};
> +
> +struct virtio_net_resource_obj_ff_rule {
> +	__le32 group_id;
> +	__le32 classifier_id;
> +	__u8 rule_priority;
> +	__u8 key_length; /* length of key in bytes */
> +	__u8 action;
> +	__u8 reserved;
> +	__le16 vq_index;
> +	__u8 reserved1[2];
> +	__u8 keys[];
> +};
> +
>  #endif
> -- 
> 2.45.0


