Return-Path: <netdev+bounces-71249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7FD852D1C
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024051F2109E
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 09:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00CD224FD;
	Tue, 13 Feb 2024 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwlrBfyK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0582231C
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818038; cv=none; b=T1/GID9K5vRUInv9z/xC2nhg922mmPgndIXcjpvO8t9zyUiHNfzpjxa9cmkO8zhKOxwO0gczMtpgLb9Ao6zkJAitsgGOXHG+7o7K894wbzTNprli+0hTnlBcbXs2DEnS2Du6UHoByT6wYJiKE15hVCuFY6MBVG/e4Tclxa3kpe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818038; c=relaxed/simple;
	bh=G3J+psM6c+if//SWVR9B/xHysGrRRo83SuDOBtEKND0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgvhK3oPl+FH2Nek3g3ZBe8zvu6T+5YHco9Z0Zd08B+MFx6mtKqJ6TtSWftT+5ll3hvehx3MWEME2y6khhpBZipyv7ASXYuxDuO5lfBQHRcDJGlSJeupLKY8gWil9Nj2jaR2mCotDdOsZrZthQ6au4nzvfi8rhAfwU50xetyMUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwlrBfyK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707818037; x=1739354037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G3J+psM6c+if//SWVR9B/xHysGrRRo83SuDOBtEKND0=;
  b=GwlrBfyK/Ta9+0OwkuKZEaPtFGgdMBVE+gUbKxQX2VJZhswEo9B0d/6R
   CLTEEiQIF8ocrF/pGouIzj9b19iYDs52Cj7tH5q+mCYLC7MtG+mj3xlpW
   sEDTDq48y0R6m30MxohLPArKymQDcyvfOgPeQ4Pka9UcA+1KDyNxN+KyV
   ipTLGorw+sv6OqFvU2yp5CbQjwGwRSSlfuVnrVommuCor7Dw+sydgGvW1
   yyStvll3N7TRzriVBBv7UxvlOcqyrzxvBOVvIgnTRPRKwktwDwJ5yDOqn
   bIl7st7tMwmMb5Mzkzjrq5qN2OvGMLoco0MeIYepglknFp91J7g5ZgFyb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1670487"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="1670487"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 01:53:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="26023731"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 01:53:53 -0800
Date: Tue, 13 Feb 2024 10:53:50 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	Piotr Raczynski <piotr.raczynski@intel.com>
Subject: Re: [iwl-next v1 07/15] ice: add auxiliary device sfnum attribute
Message-ID: <Zcs8LsRrbOfUdIL7@mev-dev>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
 <20240213072724.77275-8-michal.swiatkowski@linux.intel.com>
 <ZcsvYt4-f_MHT3QC@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcsvYt4-f_MHT3QC@nanopsycho>

On Tue, Feb 13, 2024 at 09:59:14AM +0100, Jiri Pirko wrote:
> Tue, Feb 13, 2024 at 08:27:16AM CET, michal.swiatkowski@linux.intel.com wrote:
> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> >
> >Add read only sysfs attribute for each auxiliary subfunction
> >device. This attribute is needed for orchestration layer
> >to distinguish SF devices from each other since there is no
> >native devlink mechanism to represent the connection between
> >devlink instance and the devlink port created for the port
> >representor.
> >
> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >---
> > drivers/net/ethernet/intel/ice/ice_sf_eth.c | 31 +++++++++++++++++++++
> > 1 file changed, 31 insertions(+)
> >
> >diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> >index ab90db52a8fc..abee733710a5 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> >+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> >@@ -224,6 +224,36 @@ static void ice_sf_dev_release(struct device *device)
> > 	kfree(sf_dev);
> > }
> > 
> >+static ssize_t
> >+sfnum_show(struct device *dev, struct device_attribute *attr, char *buf)
> >+{
> >+	struct devlink_port_attrs *attrs;
> >+	struct auxiliary_device *adev;
> >+	struct ice_sf_dev *sf_dev;
> >+
> >+	adev = to_auxiliary_dev(dev);
> >+	sf_dev = ice_adev_to_sf_dev(adev);
> >+	attrs = &sf_dev->dyn_port->devlink_port.attrs;
> >+
> >+	return sysfs_emit(buf, "%u\n", attrs->pci_sf.sf);
> >+}
> >+
> >+static DEVICE_ATTR_RO(sfnum);
> >+
> >+static struct attribute *ice_sf_device_attrs[] = {
> >+	&dev_attr_sfnum.attr,
> >+	NULL,
> >+};
> >+
> >+static const struct attribute_group ice_sf_attr_group = {
> >+	.attrs = ice_sf_device_attrs,
> >+};
> >+
> >+static const struct attribute_group *ice_sf_attr_groups[2] = {
> >+	&ice_sf_attr_group,
> >+	NULL
> >+};
> >+
> > /**
> >  * ice_sf_eth_activate - Activate Ethernet subfunction port
> >  * @dyn_port: the dynamic port instance for this subfunction
> >@@ -262,6 +292,7 @@ ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
> > 	sf_dev->dyn_port = dyn_port;
> > 	sf_dev->adev.id = id;
> > 	sf_dev->adev.name = "sf";
> >+	sf_dev->adev.dev.groups = ice_sf_attr_groups;
> 
> Ugh. Custom driver sysfs files like this are always very questionable.
> Don't do that please. If you need to expose sfnum, please think about
> some common way. Why exactly you need to expose it?

Uh, hard question. I will drop it and check if it still needed to expose
the sfnum, probably no, as I have never used this sysfs during testing.

Should devlink be used for it?

Thanks

> 
> pw-bot: cr
> 
> 
> > 	sf_dev->adev.dev.release = ice_sf_dev_release;
> > 	sf_dev->adev.dev.parent = &pdev->dev;
> > 
> >-- 
> >2.42.0
> >
> >

