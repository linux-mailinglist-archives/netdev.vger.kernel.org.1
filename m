Return-Path: <netdev+bounces-234940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFA5C29EFC
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 04:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DA044E47DB
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 03:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58491280025;
	Mon,  3 Nov 2025 03:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qzVPtegk"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68008221275
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 03:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139892; cv=none; b=WwdWXHSwofNYPXxN/aUnrnMcpRLw6dNl61Ha83NPXoIhz9JI6ZMDzzZZ7/oT2mlZfw9CZJnI0RNwmF/MAKF1X7OtMvTE3Z3uAihPVPCrl2VejNKQxA1cOKQiXy831z70d73nDEDD15FpyYcbGhmqv/VWSKGqvqo7bLzQa1lRrro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139892; c=relaxed/simple;
	bh=AFqPKiKYeflG3qycLFqVvJWo9iEpnS2vpmROtlPK5HQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=UvcA2tcqcRP7kS6lblvbD1geihJGrp5l1TXcMdFRE3p3tCfSYHcNZn0FU24er6SLsAjGgBeFn9/TRqn5jS4f/Cg3jrUSCIP/wV24u0qLfPeAWb3jYhKuc8clbP88hdGwKUMdnBwFO9i6d2aW1fs4CFRHAdegR4Y04wN0S9oyN6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qzVPtegk; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762139879; h=Message-ID:Subject:Date:From:To;
	bh=kYJXIqFb4TlJzit+iSeFvOg1zFTGkHzCb+ov6vRb4hU=;
	b=qzVPtegkwixj7FddartPDAZPMzcBJWap+2sL076jf3NMAEfQH0+jN8biB0mfsIBSfg3iIK1pxzGJjwX85jQHbvb9NV149ykMF8Ft3geOukQ0BVzt5aIX7FLOZ8fouykG3H6aCeGoFWaEpxzcUyIA5QsrWpLEFnVy25PRFbS1ZGs=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrVn66g_1762139878 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Nov 2025 11:17:58 +0800
Message-ID: <1762139870.9630344-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 12/12] virtio_net: Add get ethtool flow rules ops
Date: Mon, 3 Nov 2025 11:17:50 +0800
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
 <20251027173957.2334-13-danielj@nvidia.com>
In-Reply-To: <20251027173957.2334-13-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 27 Oct 2025 12:39:57 -0500, Daniel Jurgens <danielj@nvidia.com> wrote:
> - Get total number of rules. There's no user interface for this. It is
>   used to allocate an appropriately sized buffer for getting all the
>   rules.
>
> - Get specific rule
> $ ethtool -u ens9 rule 0
> 	Filter: 0
> 		Rule Type: UDP over IPv4
> 		Src IP addr: 0.0.0.0 mask: 255.255.255.255
> 		Dest IP addr: 192.168.5.2 mask: 0.0.0.0
> 		TOS: 0x0 mask: 0xff
> 		Src port: 0 mask: 0xffff
> 		Dest port: 4321 mask: 0x0
> 		Action: Direct to queue 16
>
> - Get all rules:
> $ ethtool -u ens9
> 31 RX rings available
> Total 2 rules
>
> Filter: 0
>         Rule Type: UDP over IPv4
>         Src IP addr: 0.0.0.0 mask: 255.255.255.255
>         Dest IP addr: 192.168.5.2 mask: 0.0.0.0
> ...
>
> Filter: 1
>         Flow Type: Raw Ethernet
>         Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
>         Dest MAC addr: 08:11:22:33:44:54 mask: 00:00:00:00:00:00
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
> v4: Answered questions about rules_limit overflow with no changes.
> ---
>  drivers/net/virtio_net.c | 78 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2a24fb601cc1..e01febca8b75 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -307,6 +307,13 @@ static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
>  				       struct ethtool_rx_flow_spec *fs,
>  				       u16 curr_queue_pairs);
>  static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
> +static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
> +					  struct ethtool_rxnfc *info);
> +static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
> +				    struct ethtool_rxnfc *info);
> +static int
> +virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
> +			      struct ethtool_rxnfc *info, u32 *rule_locs);
>
>  #define VIRTNET_Q_TYPE_RX 0
>  #define VIRTNET_Q_TYPE_TX 1
> @@ -5645,6 +5652,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
>  	return vi->curr_queue_pairs;
>  }
>
> +static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +	int rc = 0;
> +
> +	switch (info->cmd) {
> +	case ETHTOOL_GRXCLSRLCNT:
> +		rc = virtnet_ethtool_get_flow_count(&vi->ff, info);
> +		break;
> +	case ETHTOOL_GRXCLSRULE:
> +		rc = virtnet_ethtool_get_flow(&vi->ff, info);
> +		break;
> +	case ETHTOOL_GRXCLSRLALL:
> +		rc = virtnet_ethtool_get_all_flows(&vi->ff, info, rule_locs);
> +		break;
> +	default:
> +		rc = -EOPNOTSUPP;
> +	}
> +
> +	return rc;
> +}
> +
>  static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> @@ -5686,6 +5715,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>  	.get_rxfh_fields = virtnet_get_hashflow,
>  	.set_rxfh_fields = virtnet_set_hashflow,
>  	.get_rx_ring_count = virtnet_get_rx_ring_count,
> +	.get_rxnfc = virtnet_get_rxnfc,
>  	.set_rxnfc = virtnet_set_rxnfc,
>  };
>
> @@ -7605,6 +7635,54 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
>  	return err;
>  }
>
> +static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
> +					  struct ethtool_rxnfc *info)
> +{
> +	if (!ff->ff_supported)
> +		return -EOPNOTSUPP;
> +
> +	info->rule_cnt = ff->ethtool.num_rules;
> +	info->data = le32_to_cpu(ff->ff_caps->rules_limit) | RX_CLS_LOC_SPECIAL;
> +
> +	return 0;
> +}
> +
> +static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
> +				    struct ethtool_rxnfc *info)
> +{
> +	struct virtnet_ethtool_rule *eth_rule;
> +
> +	if (!ff->ff_supported)
> +		return -EOPNOTSUPP;
> +
> +	eth_rule = xa_load(&ff->ethtool.rules, info->fs.location);
> +	if (!eth_rule)
> +		return -ENOENT;
> +
> +	info->fs = eth_rule->flow_spec;
> +
> +	return 0;
> +}
> +
> +static int
> +virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
> +			      struct ethtool_rxnfc *info, u32 *rule_locs)
> +{
> +	struct virtnet_ethtool_rule *eth_rule;
> +	unsigned long i = 0;
> +	int idx = 0;
> +
> +	if (!ff->ff_supported)
> +		return -EOPNOTSUPP;
> +
> +	xa_for_each(&ff->ethtool.rules, i, eth_rule)
> +		rule_locs[idx++] = i;
> +
> +	info->data = le32_to_cpu(ff->ff_caps->rules_limit);
> +
> +	return 0;
> +}
> +
>  static size_t get_mask_size(u16 type)
>  {
>  	switch (type) {
> --
> 2.50.1
>

