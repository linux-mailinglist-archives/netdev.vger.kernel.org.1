Return-Path: <netdev+bounces-61870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5C5825227
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 11:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A376B25161
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 10:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0281D286B9;
	Fri,  5 Jan 2024 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JljOLJUq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926DE2CCBA
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704450874; x=1735986874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LLDtt76V232VapZ/fdm7XRRxre7XTEWqKTMjt5hWs8s=;
  b=JljOLJUqaXoC0DQFAxxNmt6p/HM+HZsrXlUuc9hFly1SGtu09gejOMRC
   5KjqTi7ejV4OwLdMR6q4MFMwcdDUAjpWoo1ZoOH1uKKZIsdRcajBnxRhS
   YyYDZpPtoa0wFo9ZLcFnrT/reIY0LYb3UD963TtFp8/v7bJqXKS3Na/3u
   NU9mMS/qaE/YkWLryOLsTQlJcTC1ZeQxMHgoWBDczRCqwcCV2TaULpNxP
   ANHQkjdo9mpHWrjeRyXT9C/X+NBdZI+ftDeV32tBICKKFec5gBk8XWCMh
   eQlQxtMm5BzOlbJkWUcZd6rmnKC6YQ8qFv11qJxKqvIzUlulCWCG5Ca/b
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="394654270"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="394654270"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 02:34:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="756908530"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="756908530"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.107])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 02:34:31 -0800
Date: Fri, 5 Jan 2024 11:34:28 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Marc MERLIN <marc@merlins.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
Message-ID: <ZZfbNIuyEiS+m7Ih@linux.intel.com>
References: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
 <20231206084448.53b48c49@kernel.org>
 <ZZU3OaybyLfrAa/0@linux.intel.com>
 <20240103153405.6b19492a@kernel.org>
 <ZZZrbUPUCTtDcUFU@linux.intel.com>
 <9bcfb259-1249-4efc-b581-056fb0a1c144@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bcfb259-1249-4efc-b581-056fb0a1c144@gmail.com>

On Thu, Jan 04, 2024 at 10:05:12AM +0100, Heiner Kallweit wrote:
> On 04.01.2024 09:25, Stanislaw Gruszka wrote:
> For me the main question is the following. In igc_resume() you have
> 
> 	rtnl_lock();
> 	if (!err && netif_running(netdev))
> 		err = __igc_open(netdev, true);
> 
> 	if (!err)
> 		netif_device_attach(netdev);
> 	rtnl_unlock();
> 
> Why is the global rtnl_lock() needed here? The netdev is in detached
> state what protects from e.g. userspace activity, see all the
> netif_device_present() checks in net core.

Good question. Initially I thought that the lock can be removed
for the exact reason you wrote. I.e. the analogus change as you
did for igb could de done ( ac8c58f5b535 ).

But after more detailed examination I can see the need for lock.

__igc_open() calls at least one function that require rtnl_lock:
netif_set_real_num_rx_queues().

Despite using netif_device_attach() without the rtnl_lock at
various places it's not safe. After:

        if (!test_and_set_bit(__LINK_STATE_PRESENT, &dev->state) &&
            netif_running(dev)) {

the full link down can be performed without rtnl_lock, so we can do

                netif_tx_wake_all_queues(dev);
                __netdev_watchdog_up(dev);

during closing or after device is closed.

Just found those two. I think there could be more reasons.

Regards
Stanislaw


