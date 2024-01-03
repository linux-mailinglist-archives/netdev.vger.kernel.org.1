Return-Path: <netdev+bounces-61190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD8D822CC6
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 13:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13DA1C22822
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 12:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6475C18EA7;
	Wed,  3 Jan 2024 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZx1MTL3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9073818EB0
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704284115; x=1735820115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g0iSlaQAYlaV9jZjD+qACj/JhNTicm8hRl2z75dQkns=;
  b=NZx1MTL3fft4w8mQKDlWEFqnMGkWpEsHUFPRevRlNrb+/keQ+EtujwIw
   Bp5NDSwkEUwC8NTZ2Oiilxqy31dnVcxsHNE90z8+7p8JoFOl7eEIXlkdt
   zw+U4xcWT6CM3sdDAJyXdVx/vR+Y1k2m+EiVXnAfXVktWY3xz2+pHYToW
   00GmZDoY/iJo5YbgUO32DKERKeo2DqZ1kf1YI9wqipxwsBhNO5lOlTSY2
   jEa6lIC443LqPOHT4yJLOTMzM904TWBg21TzljhxASriEyOHIajvqb6cM
   iTl2UvBJQlTJ33wzniRcJpEUiMANzFFoFPZXM0EBWbFbFpLT51dr+bcIa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="4353646"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="4353646"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 04:15:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="22076351"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.51.153])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 04:15:11 -0800
Date: Wed, 3 Jan 2024 13:15:09 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Marc MERLIN <marc@merlins.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
Message-ID: <ZZVPzRN9hUaPtPPh@linux.intel.com>
References: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
 <20231206084448.53b48c49@kernel.org>
 <ZZU3OaybyLfrAa/0@linux.intel.com>
 <615c97e9-0a43-4ae6-ae61-172fd64971ec@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <615c97e9-0a43-4ae6-ae61-172fd64971ec@gmail.com>

On Wed, Jan 03, 2024 at 12:24:18PM +0100, Heiner Kallweit wrote:
> On 03.01.2024 11:30, Stanislaw Gruszka wrote:
> > On Wed, Dec 06, 2023 at 08:44:48AM -0800, Jakub Kicinski wrote:
> >> On Wed,  6 Dec 2023 11:39:32 +0100 Johannes Berg wrote:
> >>> As reported by Marc MERLIN, at least one driver (igc) wants or
> >>> needs to acquire the RTNL inside suspend/resume ops, which can
> >>> be called from here in ethtool if runtime PM is enabled.
> >>>
> >>> Allow this by doing runtime PM transitions without the RTNL
> >>> held. For the ioctl to have the same operations order, this
> >>> required reworking the code to separately check validity and
> >>> do the operation. For the netlink code, this now has to do
> >>> the runtime_pm_put a bit later.
> >>
> >> I was really, really hoping that this would serve as a motivation
> >> for Intel to sort out the igb/igc implementation. The flow AFAICT
> >> is ndo_open() starts the NIC, the calls pm_sus, which shuts the NIC
> >> back down immediately (!?) then it schedules a link check from a work
> > 
> > It's not like that. pm_runtime_put() in igc_open() does not disable device.
> > It calls runtime_idle callback which check if there is link and if is
> > not, schedule device suspend in 5 second, otherwise device stays running.
> > 
> > Work watchdog_task runs periodically and also check for link changes.
> > 
> >> queue, which opens it again (!?). It's a source of never ending bugs.
> > 
> > Maybe there are issues there and igc pm runtime implementation needs
> > improvements, with lockings or otherwise. Some folks are looking at this. 
> > But I think for this particular deadlock problem reverting of below commits
> > should be considered:
> > 
> > bd869245a3dc net: core: try to runtime-resume detached device in __dev_open
> > f32a21376573 ethtool: runtime-resume netdev parent before ethtool ioctl ops
> > Reverting bd869245a3dc would break existing stuff.
> 
> > First, the deadlock should be addressed also in older kernels and
> > refactoring is not really backportable fix.
> > 
> You could simply disable igc runtime pm on older kernel versions
> if backporting a proper fix would be too cumbersome.

It would be better to have pm working on older kernels as it use to.

> > Second, I don't think network stack should do any calls to pm_runtime* .
> 
> It's not unusual that subsystem core code deals with runtime pm.
> E.g. see all the runtime pm calls in drivers/pci/pci.c
> IMO it's exactly the purpose of the RPM API to encapsulate the
> device-specific (r)pm features.

PCI is bus layer that control device probe/remove, suspend/resume, etc,
it has to do this. To make proper companion non-bus subsystem should be
used i.e. sound, drm,  bluetooth ...  all of those do not pm_runtime 
in core layer and leave that to drivers. One exception is block layer
with it's blk-pm.c , but that it's also more like library that is used
by the drivers.

Regards
Stanislaw


