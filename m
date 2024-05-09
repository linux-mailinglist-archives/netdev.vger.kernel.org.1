Return-Path: <netdev+bounces-94877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315158C0EC7
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6572815EE
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CCA130A4D;
	Thu,  9 May 2024 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="At4KkY6x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E8A14A90
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715253455; cv=none; b=koamaMxWYn+Uxa6hyFeCJzHY14RnNh2swXG0+12h6iz23LWnaqXlbHANk7zcFmFCV6Ot7fH+t7Co/PEP+u+h69uHvZicM51IohEJpAl/8dznioZYbPbg2zM3XbS4xpuBbv0okE4oRTktT3WTgW8tKSMc87rPiersXVARGWLKV8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715253455; c=relaxed/simple;
	bh=+Qx2jMyr/LRHtrlARCJHtUNxahPQhX+Mk4AsCMzN+7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5keeiKhOYylk8E8nsPCowcd60vYGAx8PJzLtRL67Rko3nAPXsmSVvESa8kGd49Y/aKLRDclArAPeuoGufqr7XSF4C5XmjkOPfZLFN82SO6Qv2fpodbfdeEiGmtyDHwYlVIQoYp0Sz7TbBJ9bWRl7ZrJ2xR3Xp1LCzwY/460d9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=At4KkY6x; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-346359c8785so535930f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 04:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715253450; x=1715858250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5u0jmRkHtJKOfSsyfOd5kVWwhDEg3RbxxuIltOo+KA=;
        b=At4KkY6xHh6JNVl7Xff+DQtNtwIn1f/ETL40ZSiYlpunqWPlskclOdn7xLa3I04XGY
         9R4ZfFqXsiQfPRT8w6W8GynWyv5G8XsbE8Zo5HH0Npda0peajTj6wTBQXKMQKHUlJlir
         4O+UoplhHVr1FG3K15y+lk1iYqAgkeTO71Gke25T9KXOTFLsYTxIa760bw/HqVF3gGMf
         cVPfz6SLvEFw04pRgV9UuQvFnj9ChNtqbnW5pRUGcsp4Uc/ELArX68WH5lPloGLqdU+T
         2cqwLddewirST0NABHpqkQf7LY2aIBXnTVrzb0bOF+IAoz7as8m0ExWnleiRecJk2J6z
         /dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715253450; x=1715858250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5u0jmRkHtJKOfSsyfOd5kVWwhDEg3RbxxuIltOo+KA=;
        b=DMrMLMXWxxRsPWhsxcV/g8mSxFaVdrfgp3YgTME72calADop4fU9HMdCQNpPcf1WNO
         Qhrzal0q8ynEXZcgs6KivsIjRO5U1oWf5jHtxf6Uk+SCKQVHRt8dBdAkmDgXcJA29ulT
         JbqU+2xX4022FDGsj8W5/ed7Xm+kjN6tYc+QAAHvrMEbUyrDc9BkTaYxXO//q5YUq71q
         D4AArx3uGpvPmYGhHSk1LWMwi4kWa2q/EitNok4rK39CNXxru8hZhQoNNBdAVolnRtnB
         ZuQSn4F0Wz2zTZXv2rYMypGKuLnf5N5l+cKn8EqxAvyFf2nY+KcrTftQWLUK6eZf/IXi
         Lzeg==
X-Forwarded-Encrypted: i=1; AJvYcCU1p8AgUrcukCVr/S8KYWydRP4wHk9QHA5uN03yPjvhUZYE5J0qTuJgV4HHXd7/MSaa1IDIY0OnUQB/+oZdRBO/zqG3s+FK
X-Gm-Message-State: AOJu0Yys+R29nKK3OxfuZFlq71/yttfoDo6mldoC/QleI4opShy6hUJF
	qlegM7siJAL/zDk6Pps+NPtaDrEb3b8xzjIa3m17kUtf1ZPWL7aRYs1QlYfofqo=
X-Google-Smtp-Source: AGHT+IGmsEGlB3X8thgNVWFJ2mUfyHKsMyTwnCHsQzYVffQlEgLnVo/Htki3hMP0gVA3hcR+U/Rk9Q==
X-Received: by 2002:a5d:6342:0:b0:349:cd18:abbd with SMTP id ffacd0b85a97d-34fcb3a9699mr3788018f8f.46.1715253450024;
        Thu, 09 May 2024 04:17:30 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad058sm1427055f8f.66.2024.05.09.04.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 04:17:29 -0700 (PDT)
Date: Thu, 9 May 2024 13:17:26 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v1 11/14] ice: netdevice ops for SF representor
Message-ID: <ZjywxuhjwvIlWXt2@nanopsycho.orion>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
 <20240507114516.9765-12-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507114516.9765-12-michal.swiatkowski@linux.intel.com>

Subject does not have verb. Please add it.

Otherwise, the patch looks ok.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>



Tue, May 07, 2024 at 01:45:12PM CEST, michal.swiatkowski@linux.intel.com wrote:
>Subfunction port representor needs the basic netdevice ops to work
>correctly. Create them.
>
>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_repr.c | 57 +++++++++++++++++------
> 1 file changed, 43 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
>index 3cb3fc5f52ea..ec4f5b8b46e6 100644
>--- a/drivers/net/ethernet/intel/ice/ice_repr.c
>+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
>@@ -59,12 +59,13 @@ static void
> ice_repr_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
> {
> 	struct ice_netdev_priv *np = netdev_priv(netdev);
>+	struct ice_repr *repr = np->repr;
> 	struct ice_eth_stats *eth_stats;
> 	struct ice_vsi *vsi;
> 
>-	if (ice_is_vf_disabled(np->repr->vf))
>+	if (repr->ops.ready(repr))
> 		return;
>-	vsi = np->repr->src_vsi;
>+	vsi = repr->src_vsi;
> 
> 	ice_update_vsi_stats(vsi);
> 	eth_stats = &vsi->eth_stats;
>@@ -93,7 +94,7 @@ struct ice_repr *ice_netdev_to_repr(const struct net_device *netdev)
> }
> 
> /**
>- * ice_repr_open - Enable port representor's network interface
>+ * ice_repr_vf_open - Enable port representor's network interface
>  * @netdev: network interface device structure
>  *
>  * The open entry point is called when a port representor's network
>@@ -102,7 +103,7 @@ struct ice_repr *ice_netdev_to_repr(const struct net_device *netdev)
>  *
>  * Returns 0 on success
>  */
>-static int ice_repr_open(struct net_device *netdev)
>+static int ice_repr_vf_open(struct net_device *netdev)
> {
> 	struct ice_repr *repr = ice_netdev_to_repr(netdev);
> 	struct ice_vf *vf;
>@@ -118,8 +119,16 @@ static int ice_repr_open(struct net_device *netdev)
> 	return 0;
> }
> 
>+static int ice_repr_sf_open(struct net_device *netdev)
>+{
>+	netif_carrier_on(netdev);
>+	netif_tx_start_all_queues(netdev);
>+
>+	return 0;
>+}
>+
> /**
>- * ice_repr_stop - Disable port representor's network interface
>+ * ice_repr_vf_stop - Disable port representor's network interface
>  * @netdev: network interface device structure
>  *
>  * The stop entry point is called when a port representor's network
>@@ -128,7 +137,7 @@ static int ice_repr_open(struct net_device *netdev)
>  *
>  * Returns 0 on success
>  */
>-static int ice_repr_stop(struct net_device *netdev)
>+static int ice_repr_vf_stop(struct net_device *netdev)
> {
> 	struct ice_repr *repr = ice_netdev_to_repr(netdev);
> 	struct ice_vf *vf;
>@@ -144,6 +153,14 @@ static int ice_repr_stop(struct net_device *netdev)
> 	return 0;
> }
> 
>+static int ice_repr_sf_stop(struct net_device *netdev)
>+{
>+	netif_carrier_off(netdev);
>+	netif_tx_stop_all_queues(netdev);
>+
>+	return 0;
>+}
>+
> /**
>  * ice_repr_sp_stats64 - get slow path stats for port representor
>  * @dev: network interface device structure
>@@ -245,10 +262,20 @@ ice_repr_setup_tc(struct net_device *netdev, enum tc_setup_type type,
> 	}
> }
> 
>-static const struct net_device_ops ice_repr_netdev_ops = {
>+static const struct net_device_ops ice_repr_vf_netdev_ops = {
>+	.ndo_get_stats64 = ice_repr_get_stats64,
>+	.ndo_open = ice_repr_vf_open,
>+	.ndo_stop = ice_repr_vf_stop,
>+	.ndo_start_xmit = ice_eswitch_port_start_xmit,
>+	.ndo_setup_tc = ice_repr_setup_tc,
>+	.ndo_has_offload_stats = ice_repr_ndo_has_offload_stats,
>+	.ndo_get_offload_stats = ice_repr_ndo_get_offload_stats,
>+};
>+
>+static const struct net_device_ops ice_repr_sf_netdev_ops = {
> 	.ndo_get_stats64 = ice_repr_get_stats64,
>-	.ndo_open = ice_repr_open,
>-	.ndo_stop = ice_repr_stop,
>+	.ndo_open = ice_repr_sf_open,
>+	.ndo_stop = ice_repr_sf_stop,
> 	.ndo_start_xmit = ice_eswitch_port_start_xmit,
> 	.ndo_setup_tc = ice_repr_setup_tc,
> 	.ndo_has_offload_stats = ice_repr_ndo_has_offload_stats,
>@@ -261,18 +288,20 @@ static const struct net_device_ops ice_repr_netdev_ops = {
>  */
> bool ice_is_port_repr_netdev(const struct net_device *netdev)
> {
>-	return netdev && (netdev->netdev_ops == &ice_repr_netdev_ops);
>+	return netdev && (netdev->netdev_ops == &ice_repr_vf_netdev_ops ||
>+			  netdev->netdev_ops == &ice_repr_sf_netdev_ops);
> }
> 
> /**
>  * ice_repr_reg_netdev - register port representor netdev
>  * @netdev: pointer to port representor netdev
>+ * @ops: new ops for netdev
>  */
> static int
>-ice_repr_reg_netdev(struct net_device *netdev)
>+ice_repr_reg_netdev(struct net_device *netdev, const struct net_device_ops *ops)
> {
> 	eth_hw_addr_random(netdev);
>-	netdev->netdev_ops = &ice_repr_netdev_ops;
>+	netdev->netdev_ops = ops;
> 	ice_set_ethtool_repr_ops(netdev);
> 
> 	netdev->hw_features |= NETIF_F_HW_TC;
>@@ -386,7 +415,7 @@ static int ice_repr_add_vf(struct ice_repr *repr)
> 		return err;
> 
> 	SET_NETDEV_DEVLINK_PORT(repr->netdev, &vf->devlink_port);
>-	err = ice_repr_reg_netdev(repr->netdev);
>+	err = ice_repr_reg_netdev(repr->netdev, &ice_repr_vf_netdev_ops);
> 	if (err)
> 		goto err_netdev;
> 
>@@ -439,7 +468,7 @@ static int ice_repr_add_sf(struct ice_repr *repr)
> 		return err;
> 
> 	SET_NETDEV_DEVLINK_PORT(repr->netdev, &sf->devlink_port);
>-	err = ice_repr_reg_netdev(repr->netdev);
>+	err = ice_repr_reg_netdev(repr->netdev, &ice_repr_sf_netdev_ops);
> 	if (err)
> 		goto err_netdev;
> 
>-- 
>2.42.0
>
>

