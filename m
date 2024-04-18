Return-Path: <netdev+bounces-89249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2387A8A9D80
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 16:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C4E1C2100A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D865B165FDD;
	Thu, 18 Apr 2024 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZFUHvnI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C995165FC7
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451650; cv=none; b=Hl093soy9zDJvm51XjJRzbX9OihczSqEf5B7Ga+yO+iTQLdleLoKqlBsJqkmEzxWZl1GYlvNoAXCN+jqUFYfaht9LRCaWoZ6lfIHi/2suZerVUpdWWXR2JPQELZzqRK5hygsKwHm7jOk1sQWT8WjZzzzqfGjwwVY3PIsqegwJNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451650; c=relaxed/simple;
	bh=/d6dxbkL6GZcVbZ63y+38DJcYWfKgIaEZOSTCyFAmxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHfuAP2rQvN1PP4CQes0CJtvNFaib9h/tvXrLwpwYtn3Ph7dzwuB9+0MZhTn8KIe9r3AGq6vy5qHwBvzJaCwdawaF31XvBeykPYAYAK7S75IJe/dlIuUvje/JcJEILoKOhCtJykO0+b733JMU766Foe2lEO34ebkOuxvPKLC2Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZFUHvnI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713451649; x=1744987649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/d6dxbkL6GZcVbZ63y+38DJcYWfKgIaEZOSTCyFAmxU=;
  b=KZFUHvnI+eRAtz1IHszoPbTRRK5Ftj/kkTHaocS/2pcuvbWTgT0rFRLj
   tuHtUJ9vX0F/nc7LsRxY1cuBl1AKPTRhSxo/1/EmgQGCvI3to+bQHVku9
   PFnEjCp3KBxh8xaJCOf3Ig4f789X+x0ASSc2oWvYXnciP8eh5aTJNb5HL
   ZHkIUfWBH2ZHCdk5nkVrwKiPHVl2ZuG+FgirX71z6NHQY0O5mS5Vld32v
   ugE3I5LdfThRX/RmrgnsM6uXcVC+c+aWBc2G9EdDd+LyZLPJAzNCxEebe
   4rAjdX+SS+IrTnEUkwMGv1Sib7t/hBbvDNFX1dqg66Y/EqJZmPuv2OlTG
   w==;
X-CSE-ConnectionGUID: Q3LESC3BT4Ob8iygtZ5o4Q==
X-CSE-MsgGUID: EQTS78IjRd+3qx4IzpnYjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9225791"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="9225791"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:47:29 -0700
X-CSE-ConnectionGUID: mxEutIMfTiOPX+UJGiYPpQ==
X-CSE-MsgGUID: ngEaRh4VRBCDW8J2XHyq9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27586454"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:47:26 -0700
Date: Thu, 18 Apr 2024 16:47:04 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com
Subject: Re: [iwl-next v4 6/8] ice: base subfunction aux driver
Message-ID: <ZiEyaF29+Vb1q1Vk@mev-dev>
References: <20240417142028.2171-1-michal.swiatkowski@linux.intel.com>
 <20240417142028.2171-7-michal.swiatkowski@linux.intel.com>
 <ZiEZ3c-aJ_i6vQ9F@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiEZ3c-aJ_i6vQ9F@nanopsycho>

On Thu, Apr 18, 2024 at 03:02:21PM +0200, Jiri Pirko wrote:
> Wed, Apr 17, 2024 at 04:20:26PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> 
> [...]
> 
> 
> >+static int ice_sf_dev_probe(struct auxiliary_device *adev,
> >+			    const struct auxiliary_device_id *id)
> >+{
> >+	struct ice_sf_dev *sf_dev = ice_adev_to_sf_dev(adev);
> >+	struct ice_dynamic_port *dyn_port = sf_dev->dyn_port;
> >+	struct ice_vsi_cfg_params params = {};
> >+	struct ice_vsi *vsi = dyn_port->vsi;
> >+	struct ice_pf *pf = dyn_port->pf;
> >+	struct device *dev = &adev->dev;
> >+	struct ice_sf_priv *priv;
> >+	struct devlink *devlink;
> >+	int err;
> >+
> >+	params.type = ICE_VSI_SF;
> >+	params.pi = pf->hw.port_info;
> >+	params.flags = ICE_VSI_FLAG_INIT;
> >+
> >+	priv = ice_allocate_sf(&adev->dev);
> >+	if (!priv) {
> >+		dev_err(dev, "Subfunction devlink alloc failed");
> >+		return -ENOMEM;
> >+	}
> >+
> >+	priv->dev = sf_dev;
> >+	sf_dev->priv = priv;
> >+	devlink = priv_to_devlink(priv);
> >+
> >+	devlink_register(devlink);
> 
> Do register at the very end. Btw, currently the error path seems to be
> broken, leaving devlink instance allocated and registered.
> 

Sure, I will fix it.

> 
> >+	devl_lock(devlink);
> >+
> >+	err = ice_vsi_cfg(vsi, &params);
> >+	if (err) {
> >+		dev_err(dev, "Subfunction vsi config failed");
> >+		goto err_devlink_unlock;
> >+	}
> >+
> >+	err = ice_devlink_create_sf_dev_port(sf_dev);
> >+	if (err) {
> >+		dev_err(dev, "Cannot add ice virtual devlink port for subfunction");
> >+		goto err_vsi_decfg;
> >+	}
> >+
> >+	err = ice_fltr_add_mac_and_broadcast(vsi, vsi->netdev->dev_addr,
> >+					     ICE_FWD_TO_VSI);
> >+	if (err) {
> >+		dev_err(dev, "can't add MAC filters %pM for VSI %d\n",
> >+			vsi->netdev->dev_addr, vsi->idx);
> >+		goto err_devlink_destroy;
> >+	}
> >+
> >+	ice_napi_add(vsi);
> >+	devl_unlock(devlink);
> >+
> >+	return 0;
> >+
> >+err_devlink_destroy:
> >+	ice_devlink_destroy_sf_dev_port(sf_dev);
> >+err_vsi_decfg:
> >+	ice_vsi_decfg(vsi);
> >+err_devlink_unlock:
> >+	devl_unlock(devlink);
> >+	return err;
> 
> [...]

