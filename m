Return-Path: <netdev+bounces-234943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8438DC29F14
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 04:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED74A188B8F5
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 03:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF712741B3;
	Mon,  3 Nov 2025 03:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H/xz4Wzt"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABEC9460
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 03:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762140042; cv=none; b=CURxsp7AIUcmbKVTic8HbA8UVEzUp8p9ojdgVtOSGBbOuM336vHzKu/MkKPLqComWr5Aape6YWgWAlOZOmIceJitZGJ7+/WQJ6q5QMLhGdygBUt+m9fyWs2DP/f7Tw3beZ1SZntyZj+FAamJm/MPxxl7/Nb17SYB88NT2TSkur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762140042; c=relaxed/simple;
	bh=4c/A7NNNK9QoaDFxZg6r47GxUbHOmq/oakDwXzHp40A=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=G7eUN7y32kCYI4ygviLYi2577zBCIrPRpAF7hijXOF9wnFy7DzII5Wy8c91GDze+qLazMo7RHAnm1N1ESHu0TsUkbuxWLC+cZTaWgyuZZ7Ecjz1jdK5netVS4HWZiMRhostV17lePUgZPTaYGMx4gjTq2hysBR+a6YgK2KnJc0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H/xz4Wzt; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762140032; h=Message-ID:Subject:Date:From:To;
	bh=XR3m05PCYe26NaEo7gSokKWSdIdeXNLE2m41pVXWW1E=;
	b=H/xz4Wzt1N36Hf6zP57XJXWMupPJ2P2P7E2ptmHneh0W6YGiB1RlWQcj8PqeVy2J/sx+5EC4qXNMjOjZCYx7WwZYJj27PE/WFILPg6AfdvVvPfq9faufYQeBFt3tPgXB7ur2NLxrT3lSfxdViNkJcDtJc2mkCefrEM+7p7fN2hA=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrVn7AG_1762140031 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Nov 2025 11:20:31 +0800
Message-ID: <1762140025.5593016-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 09/12] virtio_net: Implement IPv4 ethtool flow rules
Date: Mon, 3 Nov 2025 11:20:25 +0800
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
 <20251027173957.2334-10-danielj@nvidia.com>
In-Reply-To: <20251027173957.2334-10-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 27 Oct 2025 12:39:54 -0500, Daniel Jurgens <danielj@nvidia.com> wrote:
> Add support for IP_USER type rules from ethtool.
>
> Example:
> $ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
> Added rule with ID 1
>
> The example rule will drop packets with the source IP specified.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
> v4:
>     - Fixed bug in protocol check of parse_ip4
>     - (u8 *) to (void *) casting.
>     - Alignment issues.
> ---
>  drivers/net/virtio_net.c | 122 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 115 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d94ac72fc02c..79313627e1a5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6884,6 +6884,34 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
>  	return true;
>  }
>
> +static bool validate_ip4_mask(const struct virtnet_ff *ff,
> +			      const struct virtio_net_ff_selector *sel,
> +			      const struct virtio_net_ff_selector *sel_cap)
> +{
> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
> +	struct iphdr *cap, *mask;
> +
> +	cap = (struct iphdr *)&sel_cap->mask;
> +	mask = (struct iphdr *)&sel->mask;
> +
> +	if (mask->saddr &&
> +	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
> +			       sizeof(__be32), partial_mask))
> +		return false;
> +
> +	if (mask->daddr &&
> +	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
> +			       sizeof(__be32), partial_mask))
> +		return false;
> +
> +	if (mask->protocol &&
> +	    !check_mask_vs_cap(&mask->protocol, &cap->protocol,
> +			       sizeof(u8), partial_mask))
> +		return false;
> +
> +	return true;
> +}
> +
>  static bool validate_mask(const struct virtnet_ff *ff,
>  			  const struct virtio_net_ff_selector *sel)
>  {
> @@ -6895,11 +6923,36 @@ static bool validate_mask(const struct virtnet_ff *ff,
>  	switch (sel->type) {
>  	case VIRTIO_NET_FF_MASK_TYPE_ETH:
>  		return validate_eth_mask(ff, sel, sel_cap);
> +
> +	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
> +		return validate_ip4_mask(ff, sel, sel_cap);
>  	}
>
>  	return false;
>  }
>
> +static void parse_ip4(struct iphdr *mask, struct iphdr *key,
> +		      const struct ethtool_rx_flow_spec *fs)
> +{
> +	const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
> +	const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
> +
> +	mask->saddr = l3_mask->ip4src;
> +	mask->daddr = l3_mask->ip4dst;
> +	key->saddr = l3_val->ip4src;
> +	key->daddr = l3_val->ip4dst;
> +
> +	if (l3_mask->proto) {
> +		mask->protocol = l3_mask->proto;
> +		key->protocol = l3_val->proto;
> +	}
> +}
> +
> +static bool has_ipv4(u32 flow_type)
> +{
> +	return flow_type == IP_USER_FLOW;
> +}
> +
>  static int setup_classifier(struct virtnet_ff *ff,
>  			    struct virtnet_classifier **c)
>  {
> @@ -7034,6 +7087,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>  {
>  	switch (fs->flow_type) {
>  	case ETHER_FLOW:
> +	case IP_USER_FLOW:
>  		return true;
>  	}
>
> @@ -7062,11 +7116,23 @@ static int validate_flow_input(struct virtnet_ff *ff,
>  }
>
>  static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
> -				 size_t *key_size, size_t *classifier_size,
> -				 int *num_hdrs)
> +				size_t *key_size, size_t *classifier_size,
> +				int *num_hdrs)
>  {
> +	size_t size = sizeof(struct ethhdr);
> +
>  	*num_hdrs = 1;
>  	*key_size = sizeof(struct ethhdr);
> +
> +	if (fs->flow_type == ETHER_FLOW)
> +		goto done;
> +
> +	++(*num_hdrs);
> +	if (has_ipv4(fs->flow_type))
> +		size += sizeof(struct iphdr);
> +
> +done:
> +	*key_size = size;
>  	/*
>  	 * The classifier size is the size of the classifier header, a selector
>  	 * header for each type of header in the match criteria, and each header
> @@ -7078,8 +7144,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
>  }
>
>  static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
> -				   u8 *key,
> -				   const struct ethtool_rx_flow_spec *fs)
> +				  u8 *key,
> +				  const struct ethtool_rx_flow_spec *fs,
> +				  int num_hdrs)
>  {
>  	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
>  	struct ethhdr *eth_k = (struct ethhdr *)key;
> @@ -7087,8 +7154,33 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
>  	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
>  	selector->length = sizeof(struct ethhdr);
>
> -	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
> -	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
> +	if (num_hdrs > 1) {
> +		eth_m->h_proto = cpu_to_be16(0xffff);
> +		eth_k->h_proto = cpu_to_be16(ETH_P_IP);
> +	} else {
> +		memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
> +		memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
> +	}
> +}
> +
> +static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
> +			     u8 *key,
> +			     const struct ethtool_rx_flow_spec *fs)
> +{
> +	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
> +	struct iphdr *v4_k = (struct iphdr *)key;
> +
> +	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> +	selector->length = sizeof(struct iphdr);
> +
> +	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> +	    fs->h_u.usr_ip4_spec.tos ||
> +	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
> +		return -EOPNOTSUPP;
> +
> +	parse_ip4(v4_m, v4_k, fs);
> +
> +	return 0;
>  }
>
>  static int
> @@ -7110,6 +7202,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
>  	return 0;
>  }
>
> +static
> +struct virtio_net_ff_selector *next_selector(struct virtio_net_ff_selector *sel)
> +{
> +	return (void *)sel + sizeof(struct virtio_net_ff_selector) +
> +		sel->length;
> +}
> +
>  static int build_and_insert(struct virtnet_ff *ff,
>  			    struct virtnet_ethtool_rule *eth_rule)
>  {
> @@ -7147,8 +7246,17 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	classifier->count = num_hdrs;
>  	selector = (void *)&classifier->selectors[0];
>
> -	setup_eth_hdr_key_mask(selector, key, fs);
> +	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
> +	if (num_hdrs == 1)
> +		goto validate;
> +
> +	selector = next_selector(selector);
> +
> +	err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
> +	if (err)
> +		goto err_classifier;
>
> +validate:
>  	err = validate_classifier_selectors(ff, classifier, num_hdrs);
>  	if (err)
>  		goto err_key;
> --
> 2.50.1
>

