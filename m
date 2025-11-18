Return-Path: <netdev+bounces-239672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A898C6B477
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2AB83589EE
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287AA2DEA87;
	Tue, 18 Nov 2025 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkMEW3V8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhXqi5pS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73D2DC332
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763491827; cv=none; b=Gy/jyMfZJ2Xyq9lbhiBi7XUiRlL1hiQcqN3Xw49h7rAth2Ces+M/Ppz+6rzQsGvorQlL8kRtH8kA2FshLYyA6pVuHL5FtIrOS00QqtwxIxWc9gUn9JiM2IJ5BgXMA5kDbKQVW/hbiXBGqvPijxoWYwwZ/dReOwt+45mqfCKvnLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763491827; c=relaxed/simple;
	bh=k/01VW6wSAnS5LXvMXlAe3a52i54rssBpJnkFEM6ttQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d62PS/93/Ze4iqjYrck4d84gEMaGr+X9OZFDi48f6AGtCyOWsfDRRtLoQP5iDaZsOp3IwPOdJy9Sy7dGo0LuP2RELVBFLveuwZBB4DsRYpATwK6wbYzEyegkfTQOLiGawNdLsTak5fBmAb4LuUJc3haGlaUixQ88EERGNh1B7xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkMEW3V8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VhXqi5pS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763491824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sm8E3EsTnKYcy8dOxUUvnQCar1Vy4//572axcWJFxJw=;
	b=dkMEW3V8t1Np/N/rH5zQp6ygO+Ax85Si+R0Gd6DLtK7OAE+EJAexlTHS0/pSlgpMrGPpSI
	bsnF9CUj49IlF+u4FzndP4j9Jeml+fi/E76743H4VWgDDez27a4TvY7bT4pfW1Dy6eiDca
	spN+a5+L1UluGcqCpk++MZGbQa6eqss=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-GTi-XH8tMwKtViHAXTtzNQ-1; Tue, 18 Nov 2025 13:49:44 -0500
X-MC-Unique: GTi-XH8tMwKtViHAXTtzNQ-1
X-Mimecast-MFC-AGG-ID: GTi-XH8tMwKtViHAXTtzNQ_1763491783
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-59427b2fe85so102305e87.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763491783; x=1764096583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sm8E3EsTnKYcy8dOxUUvnQCar1Vy4//572axcWJFxJw=;
        b=VhXqi5pSCu/YUmwTK5bEs8XhrnikyofPwERHfJ4BJx6Itc2W565m6VV1LDS1Kgo+Pj
         B9EiGd45RayJ5MrssSuKIn2tuf6bJ4w2hH7Rk/jK9sTFdB17N/59bhCTcSlqOOLtfOhR
         4CKDyFgL02qD0E/Tts6QtBQ+y90nLM2p4LZBWGdc+X+V+hcyp836y77axWty35e4Bd7Y
         /AgpYZ9RzU7WqjQIEJCAZy3DcVY+4QhdqXy3DPQsmzY0e1uCPDo8lbgMj4dKWwzR06MO
         lW9RxreqHWUmNp8xp3tM9lKtszLEV6haBT0RxPL2idi5eXCNzBIwhtD/JNtJ1Ag2bAVi
         csjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763491783; x=1764096583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sm8E3EsTnKYcy8dOxUUvnQCar1Vy4//572axcWJFxJw=;
        b=Gvm8KEwYn9irCW89Zr6JNhnK1M3Zpy3GVVeT/fuTFHzbta4SWMH9VNn2ngwpFwhv+Y
         v+GV8nsgRisHUpQ1Y5j4/JRqx0wHNJ4Ha7+4ep5NYspLfFX+6AiY6XTOAhCIjqhT7xg4
         syhdGE4yADOJlWlJewSMFaNdv5r0HwBeOtM3B6lgZkGaBJpw3YCq9VyTpfiXRjhC1USq
         qRNodRBChpauPhy0HPUFVqZfGbOwctUsDZPMoTKsgZ5CaQMdPOff+GnVb9bzvSsbG/hZ
         AtA3zRSXHEWpOBxhGqLY//27Tbt/Q/IoJXXr1K6DFMjhgqUlsxvXN52DG0pflHFGY/YE
         ZudQ==
X-Gm-Message-State: AOJu0YzwzRu90seeVePQM8Z5HCWjdXeq2PPuE+hTBzISzTfoMuW79ZtU
	2Jh+PyBymQIBC5zbD8DaKLW6HjTymVZbPTNnsNVzzeNd1VHactV43Qxm2OAmYIhmUCDqwlOabYG
	4P5sld0e4rFUfq3BVONXA5mOa9R3fZfnrbJJlYsb1c3lVTPQgrjUxkfWZ5g==
X-Gm-Gg: ASbGnctxqgwaWYw1so7PriiyGjZMNzfGSX3jsdgWkK7tTE88vxV4wks5MTSMCztAbHA
	VPT8gexb08eUIW4TJGIw0tWiJrEMr42wJquv4FMZ62/ehN2YpJ5HmW9Yffb2IaBF6s07xPAaQ/e
	C1f0lFAQhZwvLKsRAvWcjeAro0BsxRWlN9TSVPTF+FAdtkDkUqLoOKd2mrZs0hDX4Z+YZuvju7V
	Il8sABYgPYEWy2Mcl0P8JfIY6zlRgCxv5+SXviF567Gp2XNnyRH18H061MQHYs0W8PGeWUaDAkJ
	y2Ph4LcVNMvPkh3fIoMcoWueXDu8SEMmJbv9fB7ojS7l+DNvKuoA+cV2YZvs4vHKQS80Sw6fyM4
	HAZrsqx6IjSh4ZT+4guVFUC/878AI0Q==
X-Received: by 2002:ac2:51c7:0:b0:595:9923:6fda with SMTP id 2adb3069b0e04-5959da1dc38mr182695e87.25.1763491782931;
        Tue, 18 Nov 2025 10:49:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsrexO0cI8ZHsSH500aol8V/mcze8JmHQE6WbTYUxEzn8EY9TuDWhyJpecadlGPktlWo1TUw==
X-Received: by 2002:ac2:51c7:0:b0:595:9923:6fda with SMTP id 2adb3069b0e04-5959da1dc38mr182559e87.25.1763491777816;
        Tue, 18 Nov 2025 10:49:37 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-595803b305bsm4047096e87.28.2025.11.18.10.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:49:37 -0800 (PST)
Date: Tue, 18 Nov 2025 13:49:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 12/12] virtio_net: Add get ethtool flow
 rules ops
Message-ID: <20251118134544-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-13-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118143903.958844-13-danielj@nvidia.com>

On Tue, Nov 18, 2025 at 08:39:02AM -0600, Daniel Jurgens wrote:
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
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v4: Answered questions about rules_limit overflow with no changes.
> ---
>  drivers/net/virtio_net.c | 78 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 17e33927f434..5823ba12f1eb 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -306,6 +306,13 @@ static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
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
> @@ -5665,6 +5672,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
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
> @@ -5706,6 +5735,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>  	.get_rxfh_fields = virtnet_get_hashflow,
>  	.set_rxfh_fields = virtnet_set_hashflow,
>  	.get_rx_ring_count = virtnet_get_rx_ring_count,
> +	.get_rxnfc = virtnet_get_rxnfc,
>  	.set_rxnfc = virtnet_set_rxnfc,
>  };
>  
> @@ -7625,6 +7655,54 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
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

So I see


 * For %ETHTOOL_GRXCLSRLALL, @rule_cnt specifies the array size of the
 * user buffer for @rule_locs on entry.  On return, @data is the size
 * of the rule table, @rule_cnt is the number of defined rules, and
 * @rule_locs contains the locations of the defined rules.  Drivers
 * must use the second parameter to get_rxnfc() instead of @rule_locs.
 *


Should this set @rule_cnt?





> +
>  static size_t get_mask_size(u16 type)
>  {
>  	switch (type) {
> -- 
> 2.50.1


