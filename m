Return-Path: <netdev+bounces-61152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3FE822B68
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 11:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E407CB21F7F
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 10:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC84318B1C;
	Wed,  3 Jan 2024 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tpyc2rho"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131F01805D
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704277823; x=1735813823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PMvuKteFKvaXCE4IPrvC+0bug0A5A+UMk6iTqWSs050=;
  b=Tpyc2rhoFvxa/KfoYFKOUN6peXxLScjk18ZA2OhsaaI+X3xNwA/8hFX6
   2edUm2IfPGstUf7cT6KBEuHwjhOlRTlh1xin64zyXHCHfJQJw9deqAFDn
   6E2hEAYI6gg/HULDvGzkdNY4HRgxwCXDsBGHsCBIJeTjRkbDqIV6itRVH
   gU9bfj1LVwHmNqJw2xJTlD1tcvs6MfDG0XG98v9lUv4bOfhxE9Q3Z4qwM
   I+BMajhVFuBLwqNyX6LEuYcvVM1cizEkrreKA4gfM06lwEqCpaR7pOlrN
   1X3uk/mn+ICUywWDsIMF2RqWHguW5UQBRNqSWetzC6S2CPrQ59jTArtLd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="3793799"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="3793799"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 02:30:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="773109698"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="773109698"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.51.153])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 02:30:19 -0800
Date: Wed, 3 Jan 2024 11:30:17 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Marc MERLIN <marc@merlins.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
Message-ID: <ZZU3OaybyLfrAa/0@linux.intel.com>
References: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
 <20231206084448.53b48c49@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206084448.53b48c49@kernel.org>

On Wed, Dec 06, 2023 at 08:44:48AM -0800, Jakub Kicinski wrote:
> On Wed,  6 Dec 2023 11:39:32 +0100 Johannes Berg wrote:
> > As reported by Marc MERLIN, at least one driver (igc) wants or
> > needs to acquire the RTNL inside suspend/resume ops, which can
> > be called from here in ethtool if runtime PM is enabled.
> > 
> > Allow this by doing runtime PM transitions without the RTNL
> > held. For the ioctl to have the same operations order, this
> > required reworking the code to separately check validity and
> > do the operation. For the netlink code, this now has to do
> > the runtime_pm_put a bit later.
> 
> I was really, really hoping that this would serve as a motivation
> for Intel to sort out the igb/igc implementation. The flow AFAICT
> is ndo_open() starts the NIC, the calls pm_sus, which shuts the NIC
> back down immediately (!?) then it schedules a link check from a work

It's not like that. pm_runtime_put() in igc_open() does not disable device.
It calls runtime_idle callback which check if there is link and if is
not, schedule device suspend in 5 second, otherwise device stays running.

Work watchdog_task runs periodically and also check for link changes.

> queue, which opens it again (!?). It's a source of never ending bugs.

Maybe there are issues there and igc pm runtime implementation needs
improvements, with lockings or otherwise. Some folks are looking at this. 
But I think for this particular deadlock problem reverting of below commits
should be considered:

bd869245a3dc net: core: try to runtime-resume detached device in __dev_open
f32a21376573 ethtool: runtime-resume netdev parent before ethtool ioctl ops

First, the deadlock should be addressed also in older kernels and
refactoring is not really backportable fix.

Second, I don't think network stack should do any calls to pm_runtime* .
This should be fully device driver specific, as this depends on device
driver implementation of power saving. IMHO if it's desirable to 
resume disabled device on requests from user space, then
netif_device_detach() should not be used in runtime suspend.

Thoughts ?

Regards
Stanislaw 


