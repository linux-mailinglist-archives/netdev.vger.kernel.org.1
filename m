Return-Path: <netdev+bounces-60310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E839E81E896
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 18:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4EDD2826FF
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 17:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4AA4F887;
	Tue, 26 Dec 2023 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="md5eqe3X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8304F885
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703610122; x=1735146122;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zJ7CtVcCDygQofHMrkLBKx6IYn9hgp47oohYPYfHX9Q=;
  b=md5eqe3XUQQNxDcCyMX0fvasnaV+Wq0o37owGdn8t1bYZPUna50dwl2u
   yifLCxPtNgwFoueddvodp8zXb2RgzMBvjBfFkIlG4Ega0Y0YiUy2ScH3U
   jtsXVl/oEnVwOhPHwngymKS5jKfoLr112C+B3gBr4kzbgGfc048/3JtCs
   W6r726MinEOaZpJkzsmDBJqPGahfm3isxfEiq8MK4zKzwlOAB76UYZ5Uw
   i3sAGEIf2BGvNJUDQFnU7IAgAAVv9ezi5oSNoq7dZfx4FbsrrYQ85asJL
   5+dLBSyOjxK8HtO1iz0yf0QCZ3MA2hEGp5/vSNjs5/TZVnBBKQx6pC9W2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="375857452"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="375857452"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 09:02:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="12481701"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.245.129.131]) ([10.245.129.131])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 09:01:58 -0800
Message-ID: <c01c2d39-0196-477e-b7cd-110a0d0862de@linux.intel.com>
Date: Tue, 26 Dec 2023 19:01:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] igc: Check VLAN EtherType mask
Content-Language: en-US
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Suman Ghosh <sumang@marvell.com>
References: <20231206140718.57433-1-kurt@linutronix.de>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20231206140718.57433-1-kurt@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/6/2023 16:07, Kurt Kanzenbach wrote:
> Currently the driver accepts VLAN EtherType steering rules regardless of
> the configured mask. And things might fail silently or with confusing error
> messages to the user. The VLAN EtherType can only be matched by full
> mask. Therefore, add a check for that.
> 
> For instance the following rule is invalid, but the driver accepts it and
> ignores the user specified mask:
> |root@host:~# ethtool -N enp3s0 flow-type ether vlan-etype 0x8100 \
> |             m 0x00ff action 0
> |Added rule with ID 63
> |root@host:~# ethtool --show-ntuple enp3s0
> |4 RX rings available
> |Total 1 rules
> |
> |Filter: 63
> |        Flow Type: Raw Ethernet
> |        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Ethertype: 0x0 mask: 0xFFFF
> |        VLAN EtherType: 0x8100 mask: 0x0
> |        VLAN: 0x0 mask: 0xffff
> |        User-defined: 0x0 mask: 0xffffffffffffffff
> |        Action: Direct to queue 0
> 
> After:
> |root@host:~# ethtool -N enp3s0 flow-type ether vlan-etype 0x8100 \
> |             m 0x00ff action 0
> |rmgr: Cannot insert RX class rule: Operation not supported
> 
> Fixes: 2b477d057e33 ("igc: Integrate flex filter into ethtool ops")
> Suggested-by: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
> 
> Note: This is a follow up of
> 
>   https://lore.kernel.org/netdev/20231201075043.7822-1-kurt@linutronix.de/
> 
> and should apply to net-queue tree.
> 
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

