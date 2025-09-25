Return-Path: <netdev+bounces-226517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ADCBA1675
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 22:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B231C01B64
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 20:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05C5271A9A;
	Thu, 25 Sep 2025 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHkNnS6c"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66C9158545
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833083; cv=none; b=lN7P9zlyXX6VJg63f7NrEdefmveLblssecGtpNzbV7jjuRRPVvd/SgYx0LmBRlQETbPp2gFbg2zGXnCIOiZeINIT/YHeZLGzwPdmYrgJQpbD1jmA/pZZ0g1cbGk/mp/XcYxueN7FaA5nK9dTYdOYwX3GZ2VEHhjqqGyao6aB2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833083; c=relaxed/simple;
	bh=jpzz5KKu7mVLg8N2FkfRyC/LAAPNrS5m9LzOSfk036w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6tw7gWtUJ/E1WhjKbHTcVIWXULDSfW1izvq7lJUDW6ykpUSriYD+NAkkp7QyHZjI7qADA6o1OwNDePIJGIdr5RqLh3ZZ6c4d/971rinhzn7O5ILcW4JNjoGpZKfxM6tyrXDnmglPJ2U42qIyD4pnPJvr32SugpOjMmYwsFhbxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHkNnS6c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758833080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ShBc3sADi99pflzPAl7XYjx/t5NLl7U3ArESHdv2cJs=;
	b=UHkNnS6cWNscB+XL1ElnghLWHCg6aXEki3uwmc2BzZjNbeedqRZ7KhMzPCcpzzmA6UVAYE
	akZgfX6rXlW70xNViyakbCxau4fq0xn98xJrzToMhovh7LgAUqa2GUP4lJkfwdSHihG0Z3
	+qPckF6zGRG5qijXOftKK6noU9Bxzl8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-qKxCWf57PLGkzyVvgZKPcA-1; Thu, 25 Sep 2025 16:44:39 -0400
X-MC-Unique: qKxCWf57PLGkzyVvgZKPcA-1
X-Mimecast-MFC-AGG-ID: qKxCWf57PLGkzyVvgZKPcA_1758833078
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ef9218daf5so1066663f8f.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 13:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758833078; x=1759437878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShBc3sADi99pflzPAl7XYjx/t5NLl7U3ArESHdv2cJs=;
        b=M0wZUFv56HMK0f5CsBCwcGs2y98GCDMb9fTivkDVMJMGulouNU0qVzf5Upiv6DtTUk
         81ZbopGWrYF41yW9GAdDouwnQQn34RKpGsgpv4csqoTlamS0wTLNIPRxR7EnigOPwZA3
         AN3+S/WMOdSWTHaY6on0gwruVy3qwr80tcIIdrW9RDtBpXsks4SFo6DkFz0ntN8cmq0A
         3PgVw2fj1WFsKe6iEH+wMEKcc+Y9lpcxRYMiso2a3Yro1Q3KZnjYPLwWo4jFwEOa21sT
         YH4yrLhK5eBT0SkVaVxcWy6ClOYJmlmn5M0IFUEL1s8cyhlclk6erU16cE++3nuPShKt
         9VLQ==
X-Gm-Message-State: AOJu0Yy0GGAwjnKGe4U+XXEC62iZt9tC4U7cch5NBixBP7kC/35z/6D/
	shLH3tREzZNIe0X7zcR1FTrYCHdaRnwv/rgetPqiK0k+e2C9oCLF5+M1LE17E7857F4BHYefXta
	8rXnOQ9GfuCktJhXbgcO1p7rBZ1ZGKCJ3xVAqLDCBo0O6SaWrP32Ydnx9hw==
X-Gm-Gg: ASbGncu/gmNeHiYOFKVLr12802mC+GCVnjaa3FmJP3bOqK6fmEmH5HuolwQmYH5Xw9h
	36+WFdOEc8ek0IV2+GGYRxTpf6AJnPpG8GplPKvY90mYlhUl+MgYqv/VPACzgA64S7UQrvdho6o
	1zajn8/jjKo5IkWv0WRcowRTGDC6VtVqKIshuRMmTrvyjwMfPfGyokwMjv7BDBoIX7KV2Q6JyNS
	MtdoLuz8WV7ieplt8nyqS3LFEdwxKrojS3emx2ZB7ofF/xjLYZQEIfA8QIze1IoByxgUBjfj0VM
	HDiZ7EBn3BDNN55ncd9IJSwfJYzBZ2g7Ig==
X-Received: by 2002:a05:6000:22c2:b0:3d0:b3cc:c1ff with SMTP id ffacd0b85a97d-40e4b85109emr4402966f8f.39.1758833077594;
        Thu, 25 Sep 2025 13:44:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9H4pXgEJYp/mY+SLqo5SFM1q5iomjIiFq9veLNl2Kz6otc8g9RCutwaptKIXiHBawbLcNtg==
X-Received: by 2002:a05:6000:22c2:b0:3d0:b3cc:c1ff with SMTP id ffacd0b85a97d-40e4b85109emr4402936f8f.39.1758833077095;
        Thu, 25 Sep 2025 13:44:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602df0sm4230912f8f.36.2025.09.25.13.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:44:36 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:44:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 11/11] virtio_net: Add get ethtool flow rules
 ops
Message-ID: <20250925164053-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-12-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923141920.283862-12-danielj@nvidia.com>

On Tue, Sep 23, 2025 at 09:19:20AM -0500, Daniel Jurgens wrote:
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
> ---
>  drivers/net/virtio_net/virtio_net_ff.c   | 48 ++++++++++++++++++++++++
>  drivers/net/virtio_net/virtio_net_ff.h   |  6 +++
>  drivers/net/virtio_net/virtio_net_main.c | 23 ++++++++++++
>  3 files changed, 77 insertions(+)
> 
> diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
> index d4a34958cc42..5488300a4fc3 100644
> --- a/drivers/net/virtio_net/virtio_net_ff.c
> +++ b/drivers/net/virtio_net/virtio_net_ff.c
> @@ -809,6 +809,54 @@ int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
>  	return err;
>  }
>  
> +int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
> +				   struct ethtool_rxnfc *info)
> +{
> +	if (!ff->ff_supported)
> +		return -EOPNOTSUPP;
> +
> +	info->rule_cnt = ff->ethtool.num_rules;
> +	info->data = le32_to_cpu(ff->ff_caps->rules_limit) | RX_CLS_LOC_SPECIAL;

hmm. what if rules_limit has the high bit set?
or matches any of
#define RX_CLS_LOC_ANY          0xffffffff
#define RX_CLS_LOC_FIRST        0xfffffffe
#define RX_CLS_LOC_LAST         0xfffffffd
by chance?


> +
> +	return 0;
> +}
> +
> +int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
> +			     struct ethtool_rxnfc *info)
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
> +int
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

same question

> +
> +	return 0;
> +}
> +
>  static size_t get_mask_size(u16 type)
>  {
>  	switch (type) {
> diff --git a/drivers/net/virtio_net/virtio_net_ff.h b/drivers/net/virtio_net/virtio_net_ff.h
> index 94b575fbd9ed..4bb41e64cc59 100644
> --- a/drivers/net/virtio_net/virtio_net_ff.h
> +++ b/drivers/net/virtio_net/virtio_net_ff.h
> @@ -28,6 +28,12 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev);
>  
>  void virtnet_ff_cleanup(struct virtnet_ff *ff);
>  
> +int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
> +				   struct ethtool_rxnfc *info);
> +int virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
> +				  struct ethtool_rxnfc *info, u32 *rule_locs);
> +int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
> +			     struct ethtool_rxnfc *info);
>  int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
>  				struct ethtool_rx_flow_spec *fs,
>  				u16 curr_queue_pairs);
> diff --git a/drivers/net/virtio_net/virtio_net_main.c b/drivers/net/virtio_net/virtio_net_main.c
> index 808988cdf265..e8336925c912 100644
> --- a/drivers/net/virtio_net/virtio_net_main.c
> +++ b/drivers/net/virtio_net/virtio_net_main.c
> @@ -5619,6 +5619,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
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
> @@ -5660,6 +5682,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>  	.get_rxfh_fields = virtnet_get_hashflow,
>  	.set_rxfh_fields = virtnet_set_hashflow,
>  	.get_rx_ring_count = virtnet_get_rx_ring_count,
> +	.get_rxnfc = virtnet_get_rxnfc,
>  	.set_rxnfc = virtnet_set_rxnfc,
>  };
>  
> -- 
> 2.45.0


