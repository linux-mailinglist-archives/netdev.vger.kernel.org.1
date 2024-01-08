Return-Path: <netdev+bounces-62364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642A1826C70
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 12:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6FB6B20B21
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 11:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE12014A9F;
	Mon,  8 Jan 2024 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NBL10dFD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78814AB0
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704712714; x=1736248714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Yv6nVbKHnRf+VuivFbkx8+znZLcrl78e/gpLyusyHY=;
  b=NBL10dFDIiZTRNVPi9toZdRRWaXpKvq5xxCBKSl8u1r5KKJBWQnsJunv
   iXS0vJ+f9RXhcSzpC40rRCDHX6BrmZ8drVfMKTtgxQ1e5+cTgFoVW8Y3o
   BQFphzfTh+XIEqq6l4a0dJQq7tTjU7fjfIZj86qXf79MzutDVFMZKQqV5
   OswsTPV/bXWHC9emPG5yMxTA009Frv0D2q+5XIEpa6Xke7IDOvzjPWYhZ
   gZ+i48aWZFWrNCtXHG/wiwxOlJRWaayNFcdE0YPn7PFOc4qCfDi1ZjiDu
   xULB2DT3qx3e1tpgiJpsnPO0tBfuZWv8T9NBdWnvR4urQppcWYVIkQZdX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="429036666"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="429036666"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 03:18:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="871846221"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="871846221"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.10])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 03:18:31 -0800
Date: Mon, 8 Jan 2024 12:18:29 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Marc MERLIN <marc@merlins.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
Message-ID: <ZZvaBWbmC9X8pgbq@linux.intel.com>
References: <20231206084448.53b48c49@kernel.org>
 <ZZU3OaybyLfrAa/0@linux.intel.com>
 <20240103153405.6b19492a@kernel.org>
 <ZZZrbUPUCTtDcUFU@linux.intel.com>
 <9bcfb259-1249-4efc-b581-056fb0a1c144@gmail.com>
 <20240104081656.67c6030c@kernel.org>
 <ZZftxhXzQykx8j6b@linux.intel.com>
 <20240105073001.15f2f3cb@kernel.org>
 <ZZguXLO3DAX/2Y0/@linux.intel.com>
 <20240105190218.5b69b9f5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105190218.5b69b9f5@kernel.org>

On Fri, Jan 05, 2024 at 07:02:18PM -0800, Jakub Kicinski wrote:
> On Fri, 5 Jan 2024 17:29:16 +0100 Stanislaw Gruszka wrote:
> > > Removing the rpm calls from the core is just going to lead to a
> > > whack-a-mole of bugs in the drivers themselves.
> > >
> > > IOW I look at the RPM calls in the core as a canary for people
> > > doing the wrong thing :(  
> > 
> > Hmm, this one I don't understand, what other bugs could pop up
> > after reverting bd869245a3dcc and others that added rpm calls
> > for the net core?
> 
> IDK what igc powers down,

From what I can tell basically everything, it's full shutdown.

> but if there's any ndo or ethtool
> callback which needs to access a register that requires power 
> to be resumed - it will deadlock on rtnl exactly the same.
> 
> Looking at igc_ethtool I see:
> 
> static int igc_ethtool_begin(struct net_device *netdev)
> {
> 	struct igc_adapter *adapter = netdev_priv(netdev);
> 
> 	pm_runtime_get_sync(&adapter->pdev->dev);
> 	return 0;
> }
> 
> static void igc_ethtool_complete(struct net_device *netdev)
> {
> 	struct igc_adapter *adapter = netdev_priv(netdev);
> 
> 	pm_runtime_put(&adapter->pdev->dev);
> }
> 
> so unless we think that returning -ENODEV from all ethtool calls
> when cable is not plugged in is okay - removing the PM resume
> from the core doesn't buy us much :(

It would address the regression in simple fix that can be send
to -stable. Event if -ENODEV for all ethtool ops and open is
not good, it's still better than deadlocking whole system.

I agree RPM for igc is not perfect and has issues that need
to be fix. People are working on it inspired by e1000e
implementation. Is should address the main requirement:
no rtnl_lock on resume path - waking up device when needed
on ndo/ethtool.

But that would not be simple fix AFICT, more likely it
will be reimplementation of the whole thing.

Additionally, in context of ethtool, previously each driver 
that implement RPM, woke up the device for actual HW access,
and don't when only memory was used. For example e1000e has
fine tuned ethtool ops. Some others like cadence/macb or 
renesas/sh_eth went event further and have their 
pm_runtime_resume_get_sync() in register access functions.

Now a hardware is powered up on every ethtool op regardless
of actual need.

So I think that the calls are only needed for some drivers, but
for others are detrimental. Would adding new netdev->priv_flags
for calling them be acceptable ?

Regards
Stanislaw

