Return-Path: <netdev+bounces-181442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEAAA85039
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 01:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248361755C1
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 23:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ACE1DED40;
	Thu, 10 Apr 2025 23:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPCuZW72"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA68D2144D5
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744328678; cv=none; b=Ee/EPPORcfifFw1CFP8OIw4Qz3UqOo5E/NtCZHGvu61M+KRLRCXkkTjH2dqFPcx+RQnf0l6+RQ+MQZMuWUIHODlWtscULmxB8H2XNcv/8xvYf1ls1eD1R43xbrDZWvKHubPYLinF0YTdUUXcovZdIT5WSaqhKvtWX84eKLZMqlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744328678; c=relaxed/simple;
	bh=i/KH7aPk7pQ0Wb/Co75kxU2dezWiH/Fz3PcyNabRYn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S0nP1JUrtUKA12y/hnHNyzVC7oGDJbldHv8xMCWQCAGg3S5XW76s54h8Z/WfIGXMNEqzGiVuQ5QHBojOo345vnPDgrIQQSCH5y+2NMWrJyLLZLnkYPmQ8gxHGEb3xiPoEj+9W4lf5/eGH5wkbmQswq0Cn4A4BweORrXiTq96dj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPCuZW72; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744328677; x=1775864677;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=i/KH7aPk7pQ0Wb/Co75kxU2dezWiH/Fz3PcyNabRYn4=;
  b=HPCuZW724Qed3Kaow71PWI+PAzw3jj7UWtrcjoPgWWPFqLpoyi1FeErc
   kzGm2sSBTGz1jztzZp1iKh0qAzYb2bThx/RvR+jDWaHffsaH4YfmAwhDK
   2rJXGRPJppweOw6iZ5nzphR2p2jSF9kM2wml1eOLupdxS54eGkoiSSEcK
   2a7OGJVlggwbIXA4WYzUeJCNRsS1uCb4zy14JzU3KnBOTuJKDXIfDDqAe
   EKyNv83IM03ebiTa3jJKIGq8j7raEXnXUmtMLh7JIyvhu6FsJFkqUj9d+
   /APY0rvCmBa7/829hVdRH7wluiuohQ6PAjB97Up6X9bqeUpTOTJwM2Q9P
   w==;
X-CSE-ConnectionGUID: iEFbfwX/Rc+IOqe+U1zDHA==
X-CSE-MsgGUID: bC8HAS6fRiqJE1TLTMUxdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45111311"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="45111311"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 16:44:36 -0700
X-CSE-ConnectionGUID: aXuBzH4PTtOmeVumBPKkXQ==
X-CSE-MsgGUID: EmLzFr8AR2K5b/rPAxFCVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="128913170"
Received: from iweiny-desk3.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.221.101])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 16:44:35 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, Anthony Nguyen
 <anthony.l.nguyen@intel.com>
Cc: david.zage@intel.com, rodrigo.cadore@l-acoustics.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, Christopher S M Hall
 <christopher.s.hall@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Mor Bar-Gabay
 <morx.bar.gabay@intel.com>, Avigail Dahan <avigailx.dahan@intel.com>,
 Corinna
 Vinschen <vinschen@redhat.com>
Subject: Re: [PATCH iwl-net v4 0/6] igc: Fix PTM timeout
In-Reply-To: <20250401-jk-igc-ptm-fixes-v4-v4-0-c0efb82bbf85@intel.com>
References: <20250401-jk-igc-ptm-fixes-v4-v4-0-c0efb82bbf85@intel.com>
Date: Thu, 10 Apr 2025 16:44:35 -0700
Message-ID: <87y0w74m58.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Jacob Keller <jacob.e.keller@intel.com> writes:

> There have been sporadic reports of PTM timeouts using i225/i226 devices
>
> These timeouts have been root caused to:
>
> 1) Manipulating the PTM status register while PTM is enabled and triggered
> 2) The hardware retrying too quickly when an inappropriate response is
>    received from the upstream device
>
> The issue can be reproduced with the following:
>
> $ sudo phc2sys -R 1000 -O 0 -i tsn0 -m
>
> Note: 1000 Hz (-R 1000) is unrealistically large, but provides a way to
> quickly reproduce the issue.
>
> PHC2SYS exits with:
>
> "ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
>   fails
>
> The first patch in this series also resolves an issue reported by Corinna
> Vinschen relating to kdump:
>
>   This patch also fixes a hang in igc_probe() when loading the igc
>   driver in the kdump kernel on systems supporting PTM.
>
>   The igc driver running in the base kernel enables PTM trigger in
>   igc_probe().  Therefore the driver is always in PTM trigger mode,
>   except in brief periods when manually triggering a PTM cycle.
>
>   When a crash occurs, the NIC is reset while PTM trigger is enabled.
>   Due to a hardware problem, the NIC is subsequently in a bad busmaster
>   state and doesn't handle register reads/writes.  When running
>   igc_probe() in the kdump kernel, the first register access to a NIC
>   register hangs driver probing and ultimately breaks kdump.
>
>   With this patch, igc has PTM trigger disabled most of the time,
>   and the trigger is only enabled for very brief (10 - 100 us) periods
>   when manually triggering a PTM cycle.  Chances that a crash occurs
>   during a PTM trigger are not zero, but extremly reduced.
>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Changes in v4:
> - Jacob taking over sending v4 due to lack of time on Chris's part.
> - Updated commit messages based on review feedback from v3
> - Updated commit titles to slightly more imperative wording
> - Link to v3: https://lore.kernel.org/r/20241106184722.17230-1-christopher.s.hall@intel.com
> Changes in v3:
> - Added mutex_destroy() to clean up PTM lock.
> - Added missing checks for PTP enabled flag called from igc_main.c.
> - Cleanup PTP module if probe fails.
> - Wrap all access to PTM registers with PTM lock/unlock.
> - Link to v2: https://lore.kernel.org/netdev/20241023023040.111429-1-christopher.s.hall@intel.com/
> Changes in v2:
> - Removed patch modifying PTM retry loop count.
> - Moved PTM mutex initialization from igc_reset() to igc_ptp_init(), called
>   once during igc_probe().
> - Link to v1: https://lore.kernel.org/netdev/20240807003032.10300-1-christopher.s.hall@intel.com/
>
> ---
> Christopher S M Hall (6):
>       igc: fix PTM cycle trigger logic
>       igc: increase wait time before retrying PTM
>       igc: move ktime snapshot into PTM retry loop
>       igc: handle the IGC_PTP_ENABLED flag correctly
>       igc: cleanup PTP module if probe fails
>       igc: add lock preventing multiple simultaneous PTM transactions
>

For the series:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

