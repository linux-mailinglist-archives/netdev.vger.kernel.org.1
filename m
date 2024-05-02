Return-Path: <netdev+bounces-92913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BE68B94F2
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 09:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5F71F21393
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 07:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0F91CAB7;
	Thu,  2 May 2024 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6Bwnlie"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15E1527BD
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714633226; cv=none; b=Kn79VwHsCCsDIcHjy4PpXUmt0Y9qjYqXwlPb6+wxv5wlUC2qSfUMmsU26yqbHKGnLOzwm/vPPquMA689pH0ri5pQuil1kZPgZgM3CcR2+eIgvaEikuHtrTV8qBcx1MBWr1cyj/3g7wf7mshT8rR3cjuZTvp1DOacsz3QBXBtQJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714633226; c=relaxed/simple;
	bh=XtdJpWx3DQWHhoNN2IO2/VKN26SpTdALv3eG+kmd9TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IDNHPSKEM5SgVSoNGyXIqzMuvEcfK0obfWntO2y7gAaMo6YHXfvhle3WA7Y6HuVrNeKhrptd8hU0cIWYrJlq4PwjOTf70uKrC9U/JpQpkApM0Icb4clRjxtAOZFbzrYYIdm57zYjVbKe0hCBfKCJ6PdzHVtKGDBA+ZPt8lS1xbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6Bwnlie; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714633225; x=1746169225;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=XtdJpWx3DQWHhoNN2IO2/VKN26SpTdALv3eG+kmd9TE=;
  b=h6Bwnliexw5bQJWsWydLIE3QrcKYnQLRfklutt9vC0d6Jv3hY9beZ9ch
   FwZMoGfhVfjE8a/PeFHb9ijDHNjdS4H7xniSIcibZRUdwQ+ocLvav4iTb
   NxB78aHV5bTNDUKxDLPXH7E3fXSA5o+g9/Mhooq959qRLjBePJEWn4yRK
   8M+Nur1kCqHizCw/wrii+S0lOWipTiaR4Nggz/f2D610kRF5mGma4EYoc
   XVFRQyYEymMKm7Efy6p3+m1ZEV+aGNUE+/gAoKMtzsWRbbvAAwyUDVrgf
   E7ru4GWdiB1ri73UtNFe6P3CYcdSNpcLtZpNWWH+3LXGL2/gah1fD4Xyq
   Q==;
X-CSE-ConnectionGUID: OPW/A8D3TVShExnavUGndQ==
X-CSE-MsgGUID: 1D4wazRvTDmtkUU+39qAAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14190997"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="14190997"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 00:00:24 -0700
X-CSE-ConnectionGUID: wbeC7JhYQ5eG/oN0tvO1iQ==
X-CSE-MsgGUID: ez3i0D7YSz2UmqxIYZcTnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27036344"
Received: from unknown (HELO [10.12.48.215]) ([10.12.48.215])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 00:00:21 -0700
Message-ID: <cb3e9c4b-a4eb-4ed5-b0aa-ec614076b6e6@linux.intel.com>
Date: Thu, 2 May 2024 10:00:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: move force SMBUS near the end
 of enable_ulp function
To: Hui Wang <hui.wang@canonical.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, vitaly.lifshits@intel.com,
 dima.ruinskiy@intel.com
References: <20240413092743.1548310-1-hui.wang@canonical.com>
Content-Language: en-US
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20240413092743.1548310-1-hui.wang@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/13/2024 12:27, Hui Wang wrote:
> The commit 861e8086029e ("e1000e: move force SMBUS from enable ulp
> function to avoid PHY loss issue") introduces a regression on
> CH_MTP_I219_LM18 (PCIID: 0x8086550A). Without this commit, the
> ethernet works well after suspend and resume, but after applying the
> commit, the ethernet couldn't work anymore after the resume and the
> dmesg shows that the NIC Link changes to 10Mbps (1000Mbps originally):
> [   43.305084] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 10 Mbps Full Duplex, Flow Control: Rx/Tx
> 
> Without the commit, the force SMBUS code will not be executed if
> "return 0" or "goto out" is executed in the enable_ulp(), and in my
> case, the "goto out" is executed since FWSM_FW_VALID is set. But after
> applying the commit, the force SMBUS code will be ran unconditionally.
> 
> Here move the force SMBUS code back to enable_ulp() and put it
> immediate ahead of hw->phy.ops.release(hw), this could allow the
> longest settling time as possible for interface in this function and
> doesn't change the original code logic.
> 
> Fixes: 861e8086029e ("e1000e: move force SMBUS from enable ulp function to avoid PHY loss issue")
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 19 +++++++++++++++++++
>   drivers/net/ethernet/intel/e1000e/netdev.c  | 18 ------------------
>   2 files changed, 19 insertions(+), 18 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

