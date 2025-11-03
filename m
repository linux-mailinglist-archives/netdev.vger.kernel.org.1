Return-Path: <netdev+bounces-234949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2FBC2A16C
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 06:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707B11884037
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 05:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B439921ABC9;
	Mon,  3 Nov 2025 05:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fxJYBNIX"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC571A7AE3
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 05:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762148892; cv=none; b=shOMqU4o+KHZoquHEeV0kpNJ7UeGYEvw7k95Y9I1oF84K0mCj52CJO0xHVWVKI0f4ptwAr3YtuQiUH74nslvmyL9bdmKGHdiGg4FCCz13sHLP5ifB7PelWc+vs8RjYXZwlk+6/KhwBsoEc2Hvy9pkc1zU45LGuGtHl37FrSkIFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762148892; c=relaxed/simple;
	bh=cPU691+VTQgZYUexOBT7U1jFNfq9RsTI+4je1RxbcSU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=TKruTOiVhiIddjd3GGqirglp+/xtlw+gwBPFNnRilnITKDKUQCsqnuXUcOdSxOrAFq3kRno1323hPdexgPfeF07SaCx0gxrBib+9BXAduc+42IL/A0m/9fvEPIyzCOd06z7eXPjIgIEt5RUD3i0S3urj22lXeUpnGQlry7McWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fxJYBNIX; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762148877; h=Message-ID:Subject:Date:From:To;
	bh=nEZBrAbLGDaBuYUCjZhkgV8RQXFG3lzrZq2fYSwGLDE=;
	b=fxJYBNIXv+Qh5dTKvwvQH5i9zZUveMH5qxOz5qRJgHtEmm/nfjZe5KXCSCsRt3pngjUJMSigWchvpvolP+gFA2C/tXin9SdvKQNms79YLmS6xjRX44vOZ9IeZXK6w0ngTneCfktA9hcWU1CB0Dy+QtgU1+Beo2HzN4TSrQ0KngU=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrX8C31_1762148876 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Nov 2025 13:47:57 +0800
Message-ID: <1762148870.0754158-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 07/12] virtio_net: Implement layer 2 ethtool flow rules
Date: Mon, 3 Nov 2025 13:47:50 +0800
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
 <20251027173957.2334-8-danielj@nvidia.com>
In-Reply-To: <20251027173957.2334-8-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 27 Oct 2025 12:39:52 -0500, Daniel Jurgens <danielj@nvidia.com> wrote:
> Filtering a flow requires a classifier to match the packets, and a rule
> to filter on the matches.
>
> A classifier consists of one or more selectors. There is one selector
> per header type. A selector must only use fields set in the selector
> capability. If partial matching is supported, the classifier mask for a
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


Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


> ---
> v4:
>     - Fixed double free bug in error flows
>     - Build bug on for classifier struct ordering.
>     - (u8 *) to (void *) casting.
>     - Documentation in UAPI
>     - Answered questions about overflow with no changes.
> v6:
>     - Fix sparse warning "array of flexible structures" Jakub K/Simon H
> ---
>  drivers/net/virtio_net.c           | 461 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_net_ff.h |  50 ++++
>  2 files changed, 511 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 10700e447959..73194b51c318 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -284,6 +284,11 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
>  	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
>  };
>
> +struct virtnet_ethtool_ff {
> +	struct xarray rules;
> +	int    num_rules;
> +};
> +
>  #define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
>  #define VIRTNET_FF_MAX_GROUPS 1
>
> @@ -293,8 +298,16 @@ struct virtnet_ff {
>  	struct virtio_net_ff_cap_data *ff_caps;
>  	struct virtio_net_ff_cap_mask_data *ff_mask;
>  	struct virtio_net_ff_actions *ff_actions;
> +	struct xarray classifiers;
> +	int num_classifiers;
> +	struct virtnet_ethtool_ff ethtool;
>  };
>
> +static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
> +				       struct ethtool_rx_flow_spec *fs,
> +				       u16 curr_queue_pairs);
> +static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
> +
>  #define VIRTNET_Q_TYPE_RX 0
>  #define VIRTNET_Q_TYPE_TX 1
>  #define VIRTNET_Q_TYPE_CQ 2
> @@ -5632,6 +5645,21 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
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
> @@ -5658,6 +5686,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>  	.get_rxfh_fields = virtnet_get_hashflow,
>  	.set_rxfh_fields = virtnet_set_hashflow,
>  	.get_rx_ring_count = virtnet_get_rx_ring_count,
> +	.set_rxnfc = virtnet_set_rxnfc,
>  };
>
>  static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,
> @@ -6769,6 +6798,427 @@ static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
>  	.xmo_rx_hash			= virtnet_xdp_rx_hash,
>  };
>
> +struct virtnet_ethtool_rule {
> +	struct ethtool_rx_flow_spec flow_spec;
> +	u32 classifier_id;
> +};
> +
> +/* The classifier struct must be the last field in this struct */
> +struct virtnet_classifier {
> +	size_t size;
> +	u32 id;
> +	struct virtio_net_resource_obj_ff_classifier classifier;
> +};
> +
> +static_assert(sizeof(struct virtnet_classifier) ==
> +	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
> +		    __alignof__(struct virtnet_classifier)),
> +	      "virtnet_classifier: classifier must be the last member");
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
> +	void *buf;
> +	int i;
> +
> +	buf = &ff->ff_mask->selectors;
> +	sel = buf;
> +
> +	for (i = 0; i < ff->ff_mask->count; i++) {
> +		if (sel->type == selector_type)
> +			return sel;
> +
> +		buf += sizeof(struct virtio_net_ff_selector) + sel->length;
> +		sel = buf;
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
> +	struct ethhdr zeros = {};
> +
> +	cap = (struct ethhdr *)&sel_cap->mask;
> +	mask = (struct ethhdr *)&sel->mask;
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
> +	err = virtio_admin_obj_create(ff->vdev,
> +				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
> +				      c->id,
> +				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +				      0,
> +				      &c->classifier,
> +				      c->size);
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
> +		virtio_admin_obj_destroy(ff->vdev,
> +					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
> +					 c->id,
> +					 VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +					 0);
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
> +	virtio_admin_obj_destroy(ff->vdev,
> +				 VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
> +				 eth_rule->flow_spec.location,
> +				 VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +				 0);
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
> +	struct virtio_net_ff_selector *selector = (void *)classifier->selectors;
> +
> +	for (int i = 0; i < num_hdrs; i++) {
> +		if (!validate_mask(ff, selector))
> +			return -EINVAL;
> +
> +		selector = (((void *)selector) + sizeof(*selector) +
> +					selector->length);
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
> +	if (err) {
> +		/* destroy_classifier will free the classifier */
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
> +static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
> +				       struct ethtool_rx_flow_spec *fs,
> +				       u16 curr_queue_pairs)
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
> +static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
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
> @@ -6916,6 +7366,8 @@ static void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	if (err)
>  		goto err_ff_action;
>
> +	xa_init_flags(&ff->classifiers, XA_FLAGS_ALLOC);
> +	xa_init_flags(&ff->ethtool.rules, XA_FLAGS_ALLOC);
>  	ff->vdev = vdev;
>  	ff->ff_supported = true;
>
> @@ -6935,9 +7387,18 @@ static void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>
>  static void virtnet_ff_cleanup(struct virtnet_ff *ff)
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
>  	virtio_admin_obj_destroy(ff->vdev,
>  				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
>  				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
> index 6d1f953c2b46..c98aa4942bee 100644
> --- a/include/uapi/linux/virtio_net_ff.h
> +++ b/include/uapi/linux/virtio_net_ff.h
> @@ -13,6 +13,8 @@
>  #define VIRTIO_NET_FF_ACTION_CAP 0x802
>
>  #define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
> +#define VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER 0x0201
> +#define VIRTIO_NET_RESOURCE_OBJ_FF_RULE 0x0202
>
>  /**
>   * struct virtio_net_ff_cap_data - Flow filter resource capability limits
> @@ -103,4 +105,52 @@ struct virtio_net_resource_obj_ff_group {
>  	__le16 group_priority;
>  };
>
> +/**
> + * struct virtio_net_resource_obj_ff_classifier - Flow filter classifier object
> + * @count: number of selector entries in @selectors
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @selectors: array of selector descriptors that define match masks
> + *
> + * Payload for the VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER administrative object.
> + * Each selector describes a header mask used to match packets
> + * (see struct virtio_net_ff_selector). Selectors appear in the order they are
> + * to be applied.
> + */
> +struct virtio_net_resource_obj_ff_classifier {
> +	__u8 count;
> +	__u8 reserved[7];
> +	__u8 selectors[];
> +};
> +
> +/**
> + * struct virtio_net_resource_obj_ff_rule - Flow filter rule object
> + * @group_id: identifier of the target flow filter group
> + * @classifier_id: identifier of the classifier referenced by this rule
> + * @rule_priority: relative priority of this rule within the group
> + * @key_length: number of bytes in @keys
> + * @action: action to perform, one of VIRTIO_NET_FF_ACTION_*
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @vq_index: RX virtqueue index for VIRTIO_NET_FF_ACTION_RX_VQ, 0 otherwise
> + * @reserved1: must be set to 0 by the driver and ignored by the device
> + * @keys: concatenated key bytes matching the classifier's selectors order
> + *
> + * Payload for the VIRTIO_NET_RESOURCE_OBJ_FF_RULE administrative object.
> + * @group_id and @classifier_id refer to previously created objects of types
> + * VIRTIO_NET_RESOURCE_OBJ_FF_GROUP and VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER
> + * respectively. The key bytes are compared against packet headers using the
> + * masks provided by the classifier's selectors. Multi-byte fields are
> + * little-endian.
> + */
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
> 2.50.1
>

