Return-Path: <netdev+bounces-95341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8470C8C1EF3
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 09:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCF31F21D5E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 07:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9969C15E81F;
	Fri, 10 May 2024 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avSFiaf/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8981311B9
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715325970; cv=none; b=EcDV7sXJVRYWGBt0ljUJVRvJ+zzUyiFU9iBwZ6mYWU3d6s8uOZv6Bcu5zn0ehVJjtOlHfjlT6XUNxROZ5GJT3BV5Y6sPD0lF0J7DI1bidhAWyajKblDt52ZQx495xX8VfmDfvG+V5G31SBrXBh+Jsggf8+phM4exCWleAPwf3tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715325970; c=relaxed/simple;
	bh=kQuDlQOkjGq3UOSia59o9rtO2trqv2Mqen/C63S1Sa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSp2+7efO6rdzlCusazThJDiFdqQeGCSnbhRxk6lvhFt6i5gVRP9deJQk7V/95LLn6JQB1E5nfQ4VFBw/stwfMp/H1GVdsxda+wYQpfU+NzYfZTyCEVxFfsemm2eYxqjjvSZZ1ygAuiXr4FjJh2EGf5VEyG2ozYcTEN1ShNOQcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avSFiaf/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715325969; x=1746861969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kQuDlQOkjGq3UOSia59o9rtO2trqv2Mqen/C63S1Sa0=;
  b=avSFiaf/wPZoFTzO/uydM5NdyGN/oLTQTkJvA34TuHPk0WE0kJ0CIedg
   fZxGqCrztb1sytYgcdTFznNrr9XFYJYbaBxRmLBujEMNfjVK4/g6zAWtZ
   3BiLzr2ImHTSgTmMwERbdo+FzzCkgwnX/S9U+QFhPsc5vfh3p3mIas5OH
   0xrb3g2LwGeO4YOLyylNViJjUZly7eCbGd7lpAKnCHlhp3mWEJBOfstDc
   JGnivKBpA3fHKCritCRoNgqJ2bGDbQAD/4r78eVrppY0m0hQU4z4Y0QRV
   9zh2nlVYakDQ1SJLO9FOQI0L5hjHwtxhiWhZ4ytd24Aq1xKU7CDMmE24R
   g==;
X-CSE-ConnectionGUID: 0MJHg+fKSnGO3zPXb6FVng==
X-CSE-MsgGUID: SqdpEMOYTimAAoTHOVcVFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15102630"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="15102630"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 00:26:08 -0700
X-CSE-ConnectionGUID: P4sNyDgwQ4WS+STFY9mLIA==
X-CSE-MsgGUID: +nZN5YGtTOq1j5bfDhDwVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29385599"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 00:26:05 -0700
Date: Fri, 10 May 2024 09:25:33 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v1 11/14] ice: netdevice ops for SF representor
Message-ID: <Zj3L7SMM01cRpNu8@mev-dev>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
 <20240507114516.9765-12-michal.swiatkowski@linux.intel.com>
 <ZjywxuhjwvIlWXt2@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjywxuhjwvIlWXt2@nanopsycho.orion>

On Thu, May 09, 2024 at 01:17:26PM +0200, Jiri Pirko wrote:
> Subject does not have verb. Please add it.
> 
> Otherwise, the patch looks ok.

Thanks, will add sth like "implement".

> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> 
> 
> 
> Tue, May 07, 2024 at 01:45:12PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >Subfunction port representor needs the basic netdevice ops to work
> >correctly. Create them.
> >
> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >---
> > drivers/net/ethernet/intel/ice/ice_repr.c | 57 +++++++++++++++++------
> > 1 file changed, 43 insertions(+), 14 deletions(-)
> >
> >diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
> >index 3cb3fc5f52ea..ec4f5b8b46e6 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_repr.c
> >+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
> >@@ -59,12 +59,13 @@ static void
> > ice_repr_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
> > {
> > 	struct ice_netdev_priv *np = netdev_priv(netdev);
> >+	struct ice_repr *repr = np->repr;
> > 	struct ice_eth_stats *eth_stats;
> > 	struct ice_vsi *vsi;
> > 
> >-	if (ice_is_vf_disabled(np->repr->vf))
> >+	if (repr->ops.ready(repr))
> > 		return;
> >-	vsi = np->repr->src_vsi;
> >+	vsi = repr->src_vsi;
> > 
> > 	ice_update_vsi_stats(vsi);
> > 	eth_stats = &vsi->eth_stats;
> >@@ -93,7 +94,7 @@ struct ice_repr *ice_netdev_to_repr(const struct net_device *netdev)
> > }
> > 
> > /**
> >- * ice_repr_open - Enable port representor's network interface
> >+ * ice_repr_vf_open - Enable port representor's network interface
> >  * @netdev: network interface device structure
> >  *
> >  * The open entry point is called when a port representor's network
> >@@ -102,7 +103,7 @@ struct ice_repr *ice_netdev_to_repr(const struct net_device *netdev)
> >  *
> >  * Returns 0 on success
> >  */
> >-static int ice_repr_open(struct net_device *netdev)
> >+static int ice_repr_vf_open(struct net_device *netdev)
> > {
> > 	struct ice_repr *repr = ice_netdev_to_repr(netdev);
> > 	struct ice_vf *vf;
> >@@ -118,8 +119,16 @@ static int ice_repr_open(struct net_device *netdev)
> > 	return 0;
> > }
> > 
> >+static int ice_repr_sf_open(struct net_device *netdev)
> >+{
> >+	netif_carrier_on(netdev);
> >+	netif_tx_start_all_queues(netdev);
> >+
> >+	return 0;
> >+}
> >+
> > /**
> >- * ice_repr_stop - Disable port representor's network interface
> >+ * ice_repr_vf_stop - Disable port representor's network interface
> >  * @netdev: network interface device structure
> >  *
> >  * The stop entry point is called when a port representor's network
> >@@ -128,7 +137,7 @@ static int ice_repr_open(struct net_device *netdev)
> >  *
> >  * Returns 0 on success
> >  */
> >-static int ice_repr_stop(struct net_device *netdev)
> >+static int ice_repr_vf_stop(struct net_device *netdev)
> > {
> > 	struct ice_repr *repr = ice_netdev_to_repr(netdev);
> > 	struct ice_vf *vf;
> >@@ -144,6 +153,14 @@ static int ice_repr_stop(struct net_device *netdev)
> > 	return 0;
> > }
> > 
> >+static int ice_repr_sf_stop(struct net_device *netdev)
> >+{
> >+	netif_carrier_off(netdev);
> >+	netif_tx_stop_all_queues(netdev);
> >+
> >+	return 0;
> >+}
> >+
> > /**
> >  * ice_repr_sp_stats64 - get slow path stats for port representor
> >  * @dev: network interface device structure
> >@@ -245,10 +262,20 @@ ice_repr_setup_tc(struct net_device *netdev, enum tc_setup_type type,
> > 	}
> > }
> > 
> >-static const struct net_device_ops ice_repr_netdev_ops = {
> >+static const struct net_device_ops ice_repr_vf_netdev_ops = {
> >+	.ndo_get_stats64 = ice_repr_get_stats64,
> >+	.ndo_open = ice_repr_vf_open,
> >+	.ndo_stop = ice_repr_vf_stop,
> >+	.ndo_start_xmit = ice_eswitch_port_start_xmit,
> >+	.ndo_setup_tc = ice_repr_setup_tc,
> >+	.ndo_has_offload_stats = ice_repr_ndo_has_offload_stats,
> >+	.ndo_get_offload_stats = ice_repr_ndo_get_offload_stats,
> >+};
> >+
> >+static const struct net_device_ops ice_repr_sf_netdev_ops = {
> > 	.ndo_get_stats64 = ice_repr_get_stats64,
> >-	.ndo_open = ice_repr_open,
> >-	.ndo_stop = ice_repr_stop,
> >+	.ndo_open = ice_repr_sf_open,
> >+	.ndo_stop = ice_repr_sf_stop,
> > 	.ndo_start_xmit = ice_eswitch_port_start_xmit,
> > 	.ndo_setup_tc = ice_repr_setup_tc,
> > 	.ndo_has_offload_stats = ice_repr_ndo_has_offload_stats,
> >@@ -261,18 +288,20 @@ static const struct net_device_ops ice_repr_netdev_ops = {
> >  */
> > bool ice_is_port_repr_netdev(const struct net_device *netdev)
> > {
> >-	return netdev && (netdev->netdev_ops == &ice_repr_netdev_ops);
> >+	return netdev && (netdev->netdev_ops == &ice_repr_vf_netdev_ops ||
> >+			  netdev->netdev_ops == &ice_repr_sf_netdev_ops);
> > }
> > 
> > /**
> >  * ice_repr_reg_netdev - register port representor netdev
> >  * @netdev: pointer to port representor netdev
> >+ * @ops: new ops for netdev
> >  */
> > static int
> >-ice_repr_reg_netdev(struct net_device *netdev)
> >+ice_repr_reg_netdev(struct net_device *netdev, const struct net_device_ops *ops)
> > {
> > 	eth_hw_addr_random(netdev);
> >-	netdev->netdev_ops = &ice_repr_netdev_ops;
> >+	netdev->netdev_ops = ops;
> > 	ice_set_ethtool_repr_ops(netdev);
> > 
> > 	netdev->hw_features |= NETIF_F_HW_TC;
> >@@ -386,7 +415,7 @@ static int ice_repr_add_vf(struct ice_repr *repr)
> > 		return err;
> > 
> > 	SET_NETDEV_DEVLINK_PORT(repr->netdev, &vf->devlink_port);
> >-	err = ice_repr_reg_netdev(repr->netdev);
> >+	err = ice_repr_reg_netdev(repr->netdev, &ice_repr_vf_netdev_ops);
> > 	if (err)
> > 		goto err_netdev;
> > 
> >@@ -439,7 +468,7 @@ static int ice_repr_add_sf(struct ice_repr *repr)
> > 		return err;
> > 
> > 	SET_NETDEV_DEVLINK_PORT(repr->netdev, &sf->devlink_port);
> >-	err = ice_repr_reg_netdev(repr->netdev);
> >+	err = ice_repr_reg_netdev(repr->netdev, &ice_repr_sf_netdev_ops);
> > 	if (err)
> > 		goto err_netdev;
> > 
> >-- 
> >2.42.0
> >
> >

