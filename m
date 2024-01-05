Return-Path: <netdev+bounces-61914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B65825323
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 12:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E545A1C21A7B
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 11:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3924B2C865;
	Fri,  5 Jan 2024 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UMFLWQXU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791C82CCB8
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704455627; x=1735991627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JtuTZVT2SekCJMQ53p7xuwYFtocdksztkt/qIIGVMx8=;
  b=UMFLWQXUEIfO20Xft/wD1YQNIf+znKS9HY6F8W2UWp3GLlf4KTTReyqb
   jP3GkJ9HFhXKpR8OmnYhSOjZbXMi8678jXZcABoF5KCFJzTH0gxYFPziW
   3uZyddCxBMgOqJYadMFAJ4X1Uq3QsjFYcvfQvadc3/cXQjnAGR2SH3wgt
   wQSJhcaS80QsfLRMfTMtY8z/Zv0bNaNaXqwvFW08OwRFWPc7iLhKxOKrI
   OHMBDWQU3mmOX22p59O1U2LpuWt8emvFRJ9IyKaVpaYfTAJJGC6hT6sBu
   /YLAEWx5jlb3FircdnE277zJ/JPDd8iDgyeKG/5PAzuWy+8vSI+Is5JRk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="428667441"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="428667441"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 03:53:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="1112076394"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="1112076394"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.107])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 03:53:44 -0800
Date: Fri, 5 Jan 2024 12:53:42 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Marc MERLIN <marc@merlins.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
Message-ID: <ZZftxhXzQykx8j6b@linux.intel.com>
References: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
 <20231206084448.53b48c49@kernel.org>
 <ZZU3OaybyLfrAa/0@linux.intel.com>
 <20240103153405.6b19492a@kernel.org>
 <ZZZrbUPUCTtDcUFU@linux.intel.com>
 <9bcfb259-1249-4efc-b581-056fb0a1c144@gmail.com>
 <20240104081656.67c6030c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104081656.67c6030c@kernel.org>

On Thu, Jan 04, 2024 at 08:16:56AM -0800, Jakub Kicinski wrote:
> On Thu, 4 Jan 2024 10:05:12 +0100 Heiner Kallweit wrote:
> > > If device was not suspended, pm_runtime_get_sync() will increase
> > > dev->power.usage_count counter and cancel pending rpm suspend
> > > request if any. There is race condition though, more about that
> > > below.
> > > 
> > > If device was suspended, we could not get to igc_open() since it
> > > was marked as detached and fail netif_device_present() check in
> > > __dev_open(). That was the behaviour before bd869245a3dc.
> 
> __dev_open() tries to resume as well, and is also under rtnl_lock.

This one is plain 100% deadlock for igc (and igb before ac8c58f5b535)
I'm opting for remove those rpm calls from __dev_open() and ethtool.

The only thing that prevent that deadlock to happen all the time,
is that rpm is disabled by default (for PCI devices). When pci driver
want to rpm be default enabled, it has to call pm_runtime_allow().
Otherwise user has to enable it by:

echo auto > /sys/bus/pci/devices/PCI_ID/power/control 

But this could be also done by some power saving user-space
software. This is most probable reason way Marc reported
that he can not boot his laptop due to this deadlock. 
Other unlikely possibility that for some reason rpm was enabled
by default, but it should not be for PCI since:
bb910a7040e9 ("PCI/PM Runtime: Make runtime PM of PCI devices
inactive by default")

> So that resume call somehow must never happen or users would see
> -ENODEV? Sorry for the basic questions, the flow is confusing :S

If we talk about situation before rpm calls were added to net core
(i.e. < 5.9) there was open/ethtool -ENODEV error when igc/igb
was runtime suspend due to netif_device_present() check fail.

That was by design, what for open the device and loose
energy if there is no cable and device can not be used anyway ?

> > > There is small race window between with igc_open() and scheduled
> > > runtime suspend, if at the same time dev_open() is done and
> > > dev->power.suspend_timer expire:
> > > 
> > > open:					pm_suspend_timer_fh:
> > > 
> > > rtnl_lock()
> > > 					rpm_suspend()
> > > 					  igc_runtime_suspend()
> > > 					   __igc_shutdown()
> > > 					     rtnl_lock()
> > > 
> > > __igc_open()
> > >   pm_runtime_get_sync():
> > >     waits for rpm suspend callback done
> > > 
> > > This needs to be addressed, but it's not that this can happen
> > > all the time. To trigger this someone has to remove the
> > > cable and exactly after 5 seconds do ip link set up. 
> 
> Or tries to up exactly 5 sec after probe?

Just after probe rpm is disabled, so 5 sec after enabling rpm
(with cable removed) or 5 sec after cable remove (with rpm enabled).

> > For me the main question is the following. In igc_resume() you have
> > 
> > 	rtnl_lock();
> > 	if (!err && netif_running(netdev))
> > 		err = __igc_open(netdev, true);
> > 
> > 	if (!err)
> > 		netif_device_attach(netdev);
> > 	rtnl_unlock();
> > 
> > Why is the global rtnl_lock() needed here? The netdev is in detached
> > state what protects from e.g. userspace activity, see all the
> > netif_device_present() checks in net core.
> 
> That'd assume there are no RPM calls outside networking in this driver.
> Perhaps there aren't but that also sounds wobbly.

They are in PCI layer. For example when disabling rpm (reverting auto in
power/control) by:

echo on > /sys/bus/pci/devices/PCI_ID/power/control 

Regards
Stanislaw

