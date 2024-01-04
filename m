Return-Path: <netdev+bounces-61457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C405823D5F
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 09:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDAC2864F7
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 08:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE99A20307;
	Thu,  4 Jan 2024 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWOwIsdY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318C8200CD
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704356722; x=1735892722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AA/i/nVvhUEbDGfHDiH8TdEVLAaokLPd8OHXHJDwfSM=;
  b=XWOwIsdYkSNvYzPdhJZ4mjUKFEPD8O/JSuNc3bAPMu1vFdU1zFGKZsOF
   5N5WtUtvUFHieBWdykjCwfcPzbG/dQHoC7IJOMNw5OCD2DjfWRfSzxvf4
   nk+JIKB/3dsu436E1etvEzRGgiDwZmBqHjoRJ+X+j/j3dt0OgG4aKLpka
   FwMcQwmayXAH6tyCf0pN3EnT0HupUs8NWaW0iV3/X5qeecRcDMVJFKufk
   yZdyEhkaHRtiFqFn6oEDWwh5nCDImsCgAvB1/0sDsGG9JQnF5pFagEDvb
   Mk5OaiPl0Lg1OWJ6OxpC5+6N0/pbEFHItMgAg/EMgjhoOnQrKXkEhMJTb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="382130684"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="382130684"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 00:25:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="22395457"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 00:25:19 -0800
Date: Thu, 4 Jan 2024 09:25:17 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Marc MERLIN <marc@merlins.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
Message-ID: <ZZZrbUPUCTtDcUFU@linux.intel.com>
References: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
 <20231206084448.53b48c49@kernel.org>
 <ZZU3OaybyLfrAa/0@linux.intel.com>
 <20240103153405.6b19492a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103153405.6b19492a@kernel.org>

On Wed, Jan 03, 2024 at 03:34:05PM -0800, Jakub Kicinski wrote:
> On Wed, 3 Jan 2024 11:30:17 +0100 Stanislaw Gruszka wrote:
> > > I was really, really hoping that this would serve as a motivation
> > > for Intel to sort out the igb/igc implementation. The flow AFAICT
> > > is ndo_open() starts the NIC, the calls pm_sus, which shuts the NIC
> > > back down immediately (!?) then it schedules a link check from a work  
> > 
> > It's not like that. pm_runtime_put() in igc_open() does not disable device.
> > It calls runtime_idle callback which check if there is link and if is
> > not, schedule device suspend in 5 second, otherwise device stays running.
> 
> Hm, I missed the 5 sec delay there. Next question for me is - how does
> it not deadlock in the open?
> 
> igc_open()
>   __igc_open(resuming=false)
>     if (!resuming)
>       pm_runtime_get_sync(&pdev->dev);
> 
> igc_resume()
>   rtnl_lock()

If device was not suspended, pm_runtime_get_sync() will increase
dev->power.usage_count counter and cancel pending rpm suspend
request if any. There is race condition though, more about that
below.

If device was suspended, we could not get to igc_open() since it
was marked as detached and fail netif_device_present() check in
__dev_open(). That was the behaviour before bd869245a3dc.

There is small race window between with igc_open() and scheduled
runtime suspend, if at the same time dev_open() is done and
dev->power.suspend_timer expire:

open:					pm_suspend_timer_fh:

rtnl_lock()
					rpm_suspend()
					  igc_runtime_suspend()
					   __igc_shutdown()
					     rtnl_lock()

__igc_open()
  pm_runtime_get_sync():
    waits for rpm suspend callback done

This needs to be addressed, but it's not that this can happen
all the time. To trigger this someone has to remove the
cable and exactly after 5 seconds do ip link set up. 

Regards
Stanislaw

