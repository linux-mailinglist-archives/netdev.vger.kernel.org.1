Return-Path: <netdev+bounces-61121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA0682296F
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 09:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEEE2B2207A
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 08:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AB018053;
	Wed,  3 Jan 2024 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FDRUBsCK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5350182A3
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704270028; x=1735806028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Ul4OlGMi2BplcTsZp5Kk6kGh3sCmw9tmO1+Lmr7FJM=;
  b=FDRUBsCKhDMTybReWXmttXSqdzqlfeUwscNBw9dOgizvQoZSPp34Akag
   hiQyaEiYQvOvc5GYTqqQ5NK0omuai2U9bFGRrdHWz+MvCMrav13iijf24
   1vq1lu/2kRRwE0KmaHzyvdYq7DkPj5hLa387qswA6u8e1cccP6YdVzlTP
   BRYJDK4h6UNiMPHzLiUe5YNFcuMJzCj//WUiaGXt+Jt7LiTnZiY29PdnH
   ee+tIujiOh6wHNCvJVrqbccmh7qzh/hHxCUwWJRdT/rjOAPnt1ygLOKBs
   bqKT1Sjhg53m3DQBBcI+5v0654ZpoC5D+Gi1CsnTnKmfX11ad6QoP5YhF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="400789293"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="400789293"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 00:20:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="779928866"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="779928866"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.51.153])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 00:20:25 -0800
Date: Wed, 3 Jan 2024 09:20:23 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org, Marc MERLIN <marc@merlins.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [RFC PATCH] net: ethtool: do runtime PM outside RTNL
Message-ID: <ZZUYx9hhdVD+wAnG@linux.intel.com>
References: <20231204200710.40c291e60cea.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
 <d0fc7d04-e3c9-47c0-487e-666cb2a4e3bc@intel.com>
 <709eff7500f2da223df9905ce49c026a881cb0e0.camel@sipsolutions.net>
 <3e7ae1f5-77e3-a561-2d6b-377026b1fd26@intel.com>
 <c1189a1982630f71dd106c3963e0fa71fa6c8a76.camel@sipsolutions.net>
 <64684afc-3dbb-453e-9c90-bf2a86e70c50@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64684afc-3dbb-453e-9c90-bf2a86e70c50@gmail.com>

On Wed, Dec 06, 2023 at 12:59:09PM +0100, Heiner Kallweit wrote:
> On 06.12.2023 10:37, Johannes Berg wrote:
> > On Wed, 2023-12-06 at 09:46 +0100, Przemek Kitszel wrote:
> >>
> >> That sounds right too; one could argue if your fix is orthogonal to that
> >> or not. I would say that your fix makes core net code more robust
> >> against drivers from past millennia. :)
> >> igc folks are notified, no idea how much time it would take to propose
> >> a fix.
> > 
> > Maybe it should be on whoever added runtime pm to ethtool ;-)
> > 
> > Heiner, the igc driver was already doing this when you added
> > pm_runtime_get_sync() ops, was there a discussion at the time, or just
> > missed?
> > 
> I think it went unnoticed at that time that igc is acquiring RTNL
> in runtime-resume. I'm just astonished that this pops up only now,
> considering that the change was done more than 2 yrs ago.

PM runtime is disabled by default for igc (driver do not call
pm_runtime_allow()). It has to be enabled explicitly by user write
to pci sysfs power/control file. And after that link up/down or
ethtool has to be used to trigger this deadlock, so quite unlikely
scenario.

Is possible though, that some power saving daemon start enabling
pm runtime for devices, so that why issue become visible.

Regards
Stanislaw

