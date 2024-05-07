Return-Path: <netdev+bounces-93992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B028BDD9C
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3501F2575A
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 09:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0177D14D447;
	Tue,  7 May 2024 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cynQuoKj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED9914D2B6
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715072444; cv=none; b=SeSIGAmc0XAz5zn3ei9xucmZWfinhPjzEQpqAI8F/xv0C/BAsTuj881+8kGQYquPB0RHtsFTMN1jahYui6yCuN/q+X1uRfLB21vCVzbuYnZAEAR/5f4R06M61poGZKiTVoQMbIDfjMwVhB9Hspda8BZXY35telp6Kudvbh9ytUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715072444; c=relaxed/simple;
	bh=78js/oaZPgoEdOv7Zevn7pvGNo4LG46YG696Wq2pEfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pjVJx5tOjEF7Onkgv/6zbF+ccyOU4p0MKiOIhj73bTrg5YmGk42dZ86emJmiXLD3Buu0NzWqx0gwen5SbIH5iQ61q+pws3MqOxRh9W01uZZoeHUmmcTcuq9MYes/1e3zEs+d7i6+VHA2fCCI23gPlu2WF4C9PSxSSDeWQagYrBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cynQuoKj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715072444; x=1746608444;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=78js/oaZPgoEdOv7Zevn7pvGNo4LG46YG696Wq2pEfM=;
  b=cynQuoKjYhxPh5REeBlOoaQWEWamSznKUgKpIqvxiFIvJ1bP+p2oGDGE
   KhrjRfRoFoMiGAWNlTQXz7zhSOtfbkssv3q+Q40yn3FZ3xl8KKpFJd/yJ
   yPHw4g8jpNOxs38MuBWK+nZNpLBYEcq0HbFv5Nlb2Nxw4DE1tDO526Evj
   eov0efrOkJ8lWHeVLT4wSu5BCtxxxDFk7byFzD5jkATlPqyM43+VnMJoJ
   JKzfp6tRPzbWKPvTSrXsx2H0qKldNbplDvqdP1Y19ax0L93bqoabbYNcb
   TjO2h+35LZP8HUGoyBYLBkvFVcOr0CxcxGgzY6vhZms0qkKAr2StswBOl
   w==;
X-CSE-ConnectionGUID: PQdkxNWSRsiflQE6wVx9Gw==
X-CSE-MsgGUID: aMe0AKOOQvyi7futoFnl/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10973172"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="10973172"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 02:00:43 -0700
X-CSE-ConnectionGUID: BIXzcgyNQGqdZ4Tfhf9/QA==
X-CSE-MsgGUID: ZqoA2/rkQrq2U0+3M26r8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="33123988"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.12.48.215]) ([10.12.48.215])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 02:00:41 -0700
Message-ID: <3d224a03-094d-4ae3-a471-cca7218bd732@linux.intel.com>
Date: Tue, 7 May 2024 12:00:38 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] igc: fix a log entry using
 uninitialized netdev
To: Corinna Vinschen <vinschen@redhat.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
References: <20240423102455.901469-1-vinschen@redhat.com>
Content-Language: en-US
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20240423102455.901469-1-vinschen@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/2024 13:24, Corinna Vinschen wrote:
> During successful probe, igc logs this:
> 
> [    5.133667] igc 0000:01:00.0 (unnamed net_device) (uninitialized): PHC added
>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> The reason is that igc_ptp_init() is called very early, even before
> register_netdev() has been called. So the netdev_info() call works
> on a partially uninitialized netdev.
> 
> Fix this by calling igc_ptp_init() after register_netdev(), right
> after the media autosense check, just as in igb.  Add a comment,
> just as in igb.
> 
> Now the log message is fine:
> 
> [    5.200987] igc 0000:01:00.0 eth0: PHC added
> 
> Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

