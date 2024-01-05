Return-Path: <netdev+bounces-61993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF892825823
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 17:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15F21C228CE
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 16:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3A92F50A;
	Fri,  5 Jan 2024 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yk8NChvN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676802E855
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704472161; x=1736008161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ap9ZiI0bbm23P7wDGvK1BQnDmWDGHwxY8dYZ6nV64KM=;
  b=Yk8NChvN+RWgKzh/9ijCoQ4kS5T+kdPmBEUd2g8jxBy17zrf89rYG6tQ
   xdBQ3aMKzKU8kPUJ2IrSwhheP1TbPPZ/ZHD51hwad43G9cXev6pA29kHP
   lTRsiC62opv6WYXEr1nixAw7dMevCC4fnMnrcCPaC45H7n11MRZ6QjRkT
   a+VtbFutmsU2G+5jbBz7o8Mf7xhfNMgmynUQVEJubLO5+qfVWZUdN2Gu4
   y+TKCIMxI5PAWBPrGSmV4I6QoceOWj8Ac+l1W5idcZS8IKL9cYzF7YzDJ
   V3e0+UwzHJnddsDAuNVssan8/9YjmH4AtltW6f+ofg1QVZWmT3SOizWdI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="463930308"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="463930308"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 08:29:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="899679537"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="899679537"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.107])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 08:29:18 -0800
Date: Fri, 5 Jan 2024 17:29:16 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Marc MERLIN <marc@merlins.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
Message-ID: <ZZguXLO3DAX/2Y0/@linux.intel.com>
References: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
 <20231206084448.53b48c49@kernel.org>
 <ZZU3OaybyLfrAa/0@linux.intel.com>
 <20240103153405.6b19492a@kernel.org>
 <ZZZrbUPUCTtDcUFU@linux.intel.com>
 <9bcfb259-1249-4efc-b581-056fb0a1c144@gmail.com>
 <20240104081656.67c6030c@kernel.org>
 <ZZftxhXzQykx8j6b@linux.intel.com>
 <20240105073001.15f2f3cb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105073001.15f2f3cb@kernel.org>

On Fri, Jan 05, 2024 at 07:30:01AM -0800, Jakub Kicinski wrote:
> On Fri, 5 Jan 2024 12:53:42 +0100 Stanislaw Gruszka wrote:
> > On Thu, Jan 04, 2024 at 08:16:56AM -0800, Jakub Kicinski wrote:
> > > __dev_open() tries to resume as well, and is also under rtnl_lock.  
> > 
> > This one is plain 100% deadlock for igc (and igb before ac8c58f5b535)
> > I'm opting for remove those rpm calls from __dev_open() and ethtool.
> 
> I don't know what gets powered down, exactly, in this device,
> so I can't give you a concrete example. But usually there's
> at least one ndo / ethtool callback which needs to resume
> the device (and already holds rtnl_lock). Taking rtnl_lock
> on the resume path is fundamentally broken.

I agree with that.

> Removing the
> rpm calls from the core is just going to lead to a whack-a-mole
> of bugs in the drivers themselves.
>
> IOW I look at the RPM calls in the core as a canary for people
> doing the wrong thing :(

Hmm, this one I don't understand, what other bugs could pop up
after reverting bd869245a3dcc and others that added rpm calls
for the net core?

> > > So that resume call somehow must never happen or users would see
> > > -ENODEV? Sorry for the basic questions, the flow is confusing :S  
> > 
> > If we talk about situation before rpm calls were added to net core
> > (i.e. < 5.9) there was open/ethtool -ENODEV error when igc/igb
> > was runtime suspend due to netif_device_present() check fail.
> > 
> > That was by design, what for open the device and loose
> > energy if there is no cable and device can not be used anyway ?
> 
> I think "link" means actual link up here, no? As opposed to no cable
> plugged in. If I understand that right - the device would have to train
> the link in DOWN state in order for the device to be opened?
> That would be quite wasteful in terms of power.

I ment no cable plugged. When igc device was runtime suspended, and
user connected the cable, user has to power device up via on > power/control
and then ip link set up.

> Regardless, returning -ENODEV is really not how netdevs should behave.
> That's what carrier reporting is for! :(

Ok, I can agrre with that. But I think this should be achived by not using
netif_device_detach() in rpm suspend, not by

        if (!netif_device_present(dev)) {
                /* may be detached because parent is runtime-suspended */
                if (dev->dev.parent)
                        pm_runtime_resume(dev->dev.parent);
                if (!netif_device_present(dev))
                        return -ENODEV;
        }

Regards
Stanislaw

