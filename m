Return-Path: <netdev+bounces-71331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53608852FF4
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0589E1F22CDE
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3A938DD5;
	Tue, 13 Feb 2024 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USjvy1rd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D851B381A1
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825315; cv=none; b=fDWwwrFFJmVSSNUq1+eT+IU8+J7UihbPYv/adCQhXOdgzu6lQR/QyEx9zyH9v+MhBZshOL3V7MKiHPrU6EOmQQM/IDD3v4RVX48NXtJPtDqjcgrPzw630rrLvjMALxDmB7pO8t9ON+FRxwc70bx/XmSeH16M9MPPN4bz/7Fw/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825315; c=relaxed/simple;
	bh=qm1sw6jJok4ULz7jLovqLsgiQQmmvysBI3GV8CbBq64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Buol4czg+QgueQuuQjlui1yJyBe2lADPzJjJBRywd1tANFuiEGYTGL4AkU9PyrKWeVZRdLcuFuTxPZTH96coEEpZ5Ol2VRaXxeMAPfDlmf+Ee8gbOKH/hsksxAvJritlFgSOHxSrnUHUb2vl4wH9ESubHTr7ASrJPnDxQSVainQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USjvy1rd; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707825314; x=1739361314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qm1sw6jJok4ULz7jLovqLsgiQQmmvysBI3GV8CbBq64=;
  b=USjvy1rdpqHX94x6NVBBQc0gAO6HyR5N95Eo3w7jQFFqy9R8jWj23U4f
   XY1w5M8aq4MwUT0AtzY7CaSygWhTDj3jDu02OHu3fG2UJZ6ZzjlcEAjam
   zal0JWRugwUdTOlSkJhyRTk5dGpK1FpH4jPYDKpbSEwsn8MEaEKnGAtma
   yTtUCqkOJeCRKOgl5y/V9fsFqsA5TYZMNEd9R2w+LmThGzliOhDUkEiZT
   jWEu45degTIcJk1uHbESeViWgx1rh8J4TT5dE7UP4WkQzqsoZrE5N0UPL
   BWQcszOceP0aUWrdh0uU+yFVIVRRyRDtmhfmSTMIrByNkDHTwYJtGqtOZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1950195"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1950195"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 03:55:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="40333197"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 03:55:10 -0800
Date: Tue, 13 Feb 2024 12:55:07 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	Piotr Raczynski <piotr.raczynski@intel.com>
Subject: Re: [iwl-next v1 07/15] ice: add auxiliary device sfnum attribute
Message-ID: <ZctYm9CVJzV+uxip@mev-dev>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
 <20240213072724.77275-8-michal.swiatkowski@linux.intel.com>
 <ZcsvYt4-f_MHT3QC@nanopsycho>
 <Zcs8LsRrbOfUdIL7@mev-dev>
 <ZctSpPamhrlF4ILg@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZctSpPamhrlF4ILg@nanopsycho>

On Tue, Feb 13, 2024 at 12:29:40PM +0100, Jiri Pirko wrote:
> Tue, Feb 13, 2024 at 10:53:50AM CET, michal.swiatkowski@linux.intel.com wrote:
> >On Tue, Feb 13, 2024 at 09:59:14AM +0100, Jiri Pirko wrote:
> >> Tue, Feb 13, 2024 at 08:27:16AM CET, michal.swiatkowski@linux.intel.com wrote:
> >> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> >> >
> >> >Add read only sysfs attribute for each auxiliary subfunction
> >> >device. This attribute is needed for orchestration layer
> >> >to distinguish SF devices from each other since there is no
> >> >native devlink mechanism to represent the connection between
> >> >devlink instance and the devlink port created for the port
> >> >representor.
> >> >
> >> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >> >Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> >> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >> >---
> >> > drivers/net/ethernet/intel/ice/ice_sf_eth.c | 31 +++++++++++++++++++++
> >> > 1 file changed, 31 insertions(+)
> >> >
> >> >diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> >> >index ab90db52a8fc..abee733710a5 100644
> >> >--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> >> >+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> >> >@@ -224,6 +224,36 @@ static void ice_sf_dev_release(struct device *device)
> >> > 	kfree(sf_dev);
> >> > }
> >> > 
> >> >+static ssize_t
> >> >+sfnum_show(struct device *dev, struct device_attribute *attr, char *buf)
> >> >+{
> >> >+	struct devlink_port_attrs *attrs;
> >> >+	struct auxiliary_device *adev;
> >> >+	struct ice_sf_dev *sf_dev;
> >> >+
> >> >+	adev = to_auxiliary_dev(dev);
> >> >+	sf_dev = ice_adev_to_sf_dev(adev);
> >> >+	attrs = &sf_dev->dyn_port->devlink_port.attrs;
> >> >+
> >> >+	return sysfs_emit(buf, "%u\n", attrs->pci_sf.sf);
> >> >+}
> >> >+
> >> >+static DEVICE_ATTR_RO(sfnum);
> >> >+
> >> >+static struct attribute *ice_sf_device_attrs[] = {
> >> >+	&dev_attr_sfnum.attr,
> >> >+	NULL,
> >> >+};
> >> >+
> >> >+static const struct attribute_group ice_sf_attr_group = {
> >> >+	.attrs = ice_sf_device_attrs,
> >> >+};
> >> >+
> >> >+static const struct attribute_group *ice_sf_attr_groups[2] = {
> >> >+	&ice_sf_attr_group,
> >> >+	NULL
> >> >+};
> >> >+
> >> > /**
> >> >  * ice_sf_eth_activate - Activate Ethernet subfunction port
> >> >  * @dyn_port: the dynamic port instance for this subfunction
> >> >@@ -262,6 +292,7 @@ ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
> >> > 	sf_dev->dyn_port = dyn_port;
> >> > 	sf_dev->adev.id = id;
> >> > 	sf_dev->adev.name = "sf";
> >> >+	sf_dev->adev.dev.groups = ice_sf_attr_groups;
> >> 
> >> Ugh. Custom driver sysfs files like this are always very questionable.
> >> Don't do that please. If you need to expose sfnum, please think about
> >> some common way. Why exactly you need to expose it?
> >
> >Uh, hard question. I will drop it and check if it still needed to expose
> >the sfnum, probably no, as I have never used this sysfs during testing.
> >
> >Should devlink be used for it?
> 
> sfnum is exposed over devlink on the port representor. If you need to
> expose it on the actual SF, we have to figure it out. But again, why?
> 
> 

Only one argument why which I have in my mind is to support it in the legacy
mode. But probably subfunctions shouldn't be supported in legacy mode.
Thanks, I will remove it and use sfnum expose from representor.

> >
> >Thanks
> >
> >> 
> >> pw-bot: cr
> >> 
> >> 
> >> > 	sf_dev->adev.dev.release = ice_sf_dev_release;
> >> > 	sf_dev->adev.dev.parent = &pdev->dev;
> >> > 
> >> >-- 
> >> >2.42.0
> >> >
> >> >

