Return-Path: <netdev+bounces-80779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A55C8810C1
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 12:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A70F1C208ED
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 11:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AF73B293;
	Wed, 20 Mar 2024 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBccpgTB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19F61171D
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933567; cv=none; b=PKsfQX6D/oFt71UgBgkbBDWaJH+PrlES6gEm3ohMh3PTBQVPR5aqiTFDaQ5B3ErW1vlfBvJxaBEzM+ixrVyk9A2HFOSVWrVejyYs4HDOYDkfGijvauvV3GujS+P6sOBuTQlvMAS1v2TXz7WXsBMi1iPrxuilfj+IRGlKWsmXC2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933567; c=relaxed/simple;
	bh=Eu7nYVscXC39tfc6LJY++Jbgjhiajxn8v2rKaoxHAQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IclrygAsW8QeUtUgapftv/Nv1bRdR4fbe9KCERAvc9HkqNrPjDyGH4oMoOEF0BlhL4hlaLfHFwYCn74qL99JnBXJ7VmmzWxr/g6fmwDGvxf8EMA73aCOCD2l8XYy7nqJhD5BAC5z4gprF5hQboUIgyfeyYhf3mvrmHg1PeI1alM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBccpgTB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710933566; x=1742469566;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Eu7nYVscXC39tfc6LJY++Jbgjhiajxn8v2rKaoxHAQY=;
  b=DBccpgTBsF2CxK8etMYbBYAyqJAFrnEBvPnCcwOsvZRmax1Kinhrruop
   4/hrwvVti463hsLPQVhEFkzP49cZXIN2LWt+YNcjvPsJzR/WFCS5YNhie
   xMGIkqFBjb7l0KtcL/tNwq4aWZzydRmxXCMUOWqNA4r6uWf5SI6kSccq1
   zoPW/VZiD39zpDW5pM9NYbeirtxQYPjfikUNsymcTBrfAfSxQHBnfHijI
   2Gwk19d3wwsN7v0dPmLEvV3xdaFrTFe04/h4Dv3/MFDuGdEuMRZfnBeka
   k8L6TbyTO/VuabHnOHDhiYF+WCjOIWFe5QfiUb2xnGQWDcnGHS3lvFzlB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="31287535"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="31287535"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="37248776"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.245.176.78]) ([10.245.176.78])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:19:19 -0700
Message-ID: <422a27dd-8d0a-45f9-a832-8ce7b21f4bd6@linux.intel.com>
Date: Wed, 20 Mar 2024 13:19:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] igc: Remove stale comment about
 Tx timestamping
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Cc: netdev@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, intel-wired-lan@lists.osuosl.org
References: <20240313-igc_txts_comment-v1-1-4e8438739323@linutronix.de>
Content-Language: en-US
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20240313-igc_txts_comment-v1-1-4e8438739323@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/2024 15:03, Kurt Kanzenbach wrote:
> The initial igc Tx timestamping implementation used only one register for
> retrieving Tx timestamps. Commit 3ed247e78911 ("igc: Add support for
> multiple in-flight TX timestamps") added support for utilizing all four of
> them e.g., for multiple domain support. Remove the stale comment/FIXME.
> 
> Fixes: 3ed247e78911 ("igc: Add support for multiple in-flight TX timestamps")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 4 ----
>   1 file changed, 4 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

