Return-Path: <netdev+bounces-60279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882BD81E6F7
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 11:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE6A1C21EAE
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 10:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051A24CE1F;
	Tue, 26 Dec 2023 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFerebL9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A84E1A1
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703587753; x=1735123753;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=633pHdQbE69gzbvLRHJH9ISmMg75na5iFxxZDuaNerI=;
  b=UFerebL9GLKLvZHs11gxi93Q6bJlksYAYRiyOoYURwejgmA/nX+1x3nU
   ec1n1YNtt8TTj4oqKHf0KJSFg/Lzd3aDWUNOIcjVHQlLr9PGw3gGo21fi
   6CT+IAXymFEuah+UidobBi5gKls57kl/kGDahd7AzyOgS6NL//ms8+9jo
   vDw0uGiwK1nlcmg0bc0qgh/sTI+zYEFJimvQqI5vIcPF0pzOI7K8oHTOZ
   gQYikDpuz9S7g9Gc9aJgcsVUXZev6z6qCO01ACwbvKX4+QiUiG1RxTIsA
   44o4tUUofV3wMi550CcbrvW705Zci1LTRzgZmRFZWFG8wpcCiK18rwEuj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="376481339"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="376481339"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 02:49:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="771144233"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="771144233"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.245.129.131]) ([10.245.129.131])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 02:49:08 -0800
Message-ID: <96e4933c-a2aa-4401-a440-c11f1e95b891@linux.intel.com>
Date: Tue, 26 Dec 2023 12:49:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 2/2] igc: Check VLAN TCI mask
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
References: <20231201075043.7822-1-kurt@linutronix.de>
 <20231201075043.7822-3-kurt@linutronix.de>
Content-Language: en-US
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20231201075043.7822-3-kurt@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/2023 09:50, Kurt Kanzenbach wrote:
> Currently the driver accepts VLAN TCI steering rules regardless of the
> configured mask. And things might fail silently or with confusing error
> messages to the user.
> 
> There are two ways to handle the VLAN TCI mask:
> 
>   1. Match on the PCP field using a VLAN prio filter
>   2. Match on complete TCI field using a flex filter
> 
> Therefore, add checks and code for that.
> 
> For instance the following rule is invalid and will be converted into a
> VLAN prio rule which is not correct:
> |root@host:~# ethtool -N enp3s0 flow-type ether vlan 0x0001 m 0xf000 \
> |             action 1
> |Added rule with ID 61
> |root@host:~# ethtool --show-ntuple enp3s0
> |4 RX rings available
> |Total 1 rules
> |
> |Filter: 61
> |        Flow Type: Raw Ethernet
> |        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Ethertype: 0x0 mask: 0xFFFF
> |        VLAN EtherType: 0x0 mask: 0xffff
> |        VLAN: 0x1 mask: 0x1fff
> |        User-defined: 0x0 mask: 0xffffffffffffffff
> |        Action: Direct to queue 1
> 
> After:
> |root@host:~# ethtool -N enp3s0 flow-type ether vlan 0x0001 m 0xf000 \
> |             action 1
> |rmgr: Cannot insert RX class rule: Operation not supported
> 
> Fixes: 7991487ecb2d ("igc: Allow for Flex Filters to be installed")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h         |  1 +
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 28 +++++++++++++++++---
>   2 files changed, 26 insertions(+), 3 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

