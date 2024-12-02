Return-Path: <netdev+bounces-148019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 898A29DFD04
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17699B22167
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 09:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC85C1FA252;
	Mon,  2 Dec 2024 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JTPur2Dv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343E91FA249
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131419; cv=none; b=FAMB5HmMZeI8M3bhn8qd1zw+X+oTYjEEkXtjzeVuvh/mIJ6DYvtvRWwS9ZXP4G9awr13lvBLG1HJKBMBAF9PkU1LuaTxBMFSthF0Gyeg0pYhSqvev3WTDqBjYTKWsUo3MFuDgOEyPPHQktwfPxYO+CLTLN28vEdiTfR3XzxEuro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131419; c=relaxed/simple;
	bh=I7RkWtt4z3d0ENZ+j2JKgjUG/MCG0Gqa1MJKSgg1BKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRunoRr+JyVlgGwnes4jYV/YnOOV+kdJSKqX+sMi8T9woQVYZiizKYpFrP8n8e9Mer1uXdY7ghFNHPRC13CkXsEYVvG0iXGyErWvJP97oUzItiA6P2NPcj6TO0kvLLAzWjv+sqgbTQ6i+VgokGfLdcYmhNnk8fG+4xdRz1ixQUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JTPur2Dv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733131418; x=1764667418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I7RkWtt4z3d0ENZ+j2JKgjUG/MCG0Gqa1MJKSgg1BKg=;
  b=JTPur2DvAT17xOdQajT6jsKlLOTtYDrXWUOeB899UIlGQ9KVyqfRQWA2
   HWeLdaz6zxf+6910qGpVcbYY2lS0kv91ZiSHh5OgKrxsdJ/wAL9xHoZ+B
   KCSaGk46M6D0D7LQGEeCBFDa4UD8egwoTsnS9ZuMuo6mEqpIHItI4wbtt
   MfmjYMoLqxHn0Kw1kb9pZjXF2WbL9jFDtjyx5JV33aZ/yxD30XYwJ/S3x
   wiksOh5GEYongh0JfqPfNA4ntcdAawNlteaDP9P6JGog6Alk9r8OqA0ay
   0wsiwCfyTmN3DN93AFT9ALos15T386tAUtvAX+RpYhV3nrZylOl3OXltt
   g==;
X-CSE-ConnectionGUID: D5cXITn+QR6fkaybDMv03w==
X-CSE-MsgGUID: B+0LwoX0RRCLYNHX1NGyXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11273"; a="32646279"
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="32646279"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 01:23:38 -0800
X-CSE-ConnectionGUID: a04rlHaSTQG6GTQUq5g/1w==
X-CSE-MsgGUID: aq0mliP9T8yRyf34HiyLRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="130533262"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 01:23:33 -0800
Date: Mon, 2 Dec 2024 10:20:41 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pawel.chmielewski@intel.com, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, pio.raczynski@gmail.com,
	konrad.knitter@intel.com, marcin.szycik@intel.com,
	wojciech.drewek@intel.com, nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com, jiri@resnulli.us, horms@kernel.org,
	David.Laight@aculab.com, pmenzel@molgen.mpg.de, mschmidt@redhat.com,
	rafal.romanowski@intel.com
Subject: Re: [iwl-next v8 0/9] ice: managing MSI-X in driver
Message-ID: <Z0176Qex/kdZ3JI8@mev-dev.igk.intel.com>
References: <20241114122009.97416-1-michal.swiatkowski@linux.intel.com>
 <062b57cf-7f5d-412f-9288-685c4c600d53@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <062b57cf-7f5d-412f-9288-685c4c600d53@intel.com>

On Mon, Nov 18, 2024 at 03:13:32PM -0800, Tony Nguyen wrote:
> 
> 
> On 11/14/2024 4:18 AM, Michal Swiatkowski wrote:
> 
> ...
> 
> > Note: previous patchset is on dev-queue. I will be unavailable some
> > time, so sending fixed next version basing it on Tony main.
> > 
> > Michal Swiatkowski (8):
> >    ice: devlink PF MSI-X max and min parameter
> >    ice: remove splitting MSI-X between features
> >    ice: get rid of num_lan_msix field
> >    ice, irdma: move interrupts code to irdma
> >    ice: treat dyn_allowed only as suggestion
> >    ice: enable_rdma devlink param
> >    ice: simplify VF MSI-X managing
> >    ice: init flow director before RDMA
> 
> It looks like something happened with your series/send. It's marked 0/9,
> however, there are 8 patches here. Patch 1 in the previous version [1] is
> not here and patch 8 is on the thread twice (as an 8/8 and a 9/9).
> Also, it doesn't apply either with or without the previous patch 1.
> 
> [1] https://lore.kernel.org/intel-wired-lan/20241104121337.129287-1-michal.swiatkowski@linux.intel.com/
> 

Sorry for that, I were in hurry :( .

Will send fixed v9, I can remove base-commit now as the previous
patchset isn't on next-queue.

Thanks

> > 
> >   Documentation/networking/devlink/ice.rst      |  11 +
> >   drivers/infiniband/hw/irdma/hw.c              |   2 -
> >   drivers/infiniband/hw/irdma/main.c            |  46 ++-
> >   drivers/infiniband/hw/irdma/main.h            |   3 +
> >   .../net/ethernet/intel/ice/devlink/devlink.c  | 109 +++++++
> >   drivers/net/ethernet/intel/ice/ice.h          |  21 +-
> >   drivers/net/ethernet/intel/ice/ice_base.c     |  10 +-
> >   drivers/net/ethernet/intel/ice/ice_ethtool.c  |   6 +-
> >   drivers/net/ethernet/intel/ice/ice_idc.c      |  64 +---
> >   drivers/net/ethernet/intel/ice/ice_irq.c      | 275 ++++++------------
> >   drivers/net/ethernet/intel/ice/ice_irq.h      |  13 +-
> >   drivers/net/ethernet/intel/ice/ice_lib.c      |  35 ++-
> >   drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
> >   drivers/net/ethernet/intel/ice/ice_sriov.c    | 154 +---------
> >   include/linux/net/intel/iidc.h                |   2 +
> >   15 files changed, 335 insertions(+), 422 deletions(-)
> > 
> > 
> > base-commit: 31a1f8752f7df7e3d8122054fbef02a9a8bff38f
> 

