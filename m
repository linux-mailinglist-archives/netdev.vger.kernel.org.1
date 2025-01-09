Return-Path: <netdev+bounces-156718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C0AA07955
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4533A2396
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7952921A457;
	Thu,  9 Jan 2025 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNZaB8jj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B403621A431
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736433369; cv=none; b=cbbjBOY1TuksYAkaEkImMMBbgj28fta/6pbHvN+2hC+D58vrK0chc8dWBsC/0ZJq83bMxzgsfgZX+GpbDQd2557p6Pe/Ou8mliauLTXH4ZCM3JDZex0h0fF7JPIqtALT86N0RhRt0ElQLZKgqZYkjyGy3uDYnSpBjU4B5Lg461k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736433369; c=relaxed/simple;
	bh=VITV59GbUxGVZi+9c8e4gHb8aUcyhWoobrnDe90KlgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6JKG79s1rdo3CRH0FSTWww7dWaV9t5FiM2grFFn2XFu7y0c0jCTOL9EFtmz/D9VoQg0PL+0TJaFbucW4dOd98IRxjN63//CFXgllO5cbPGEgUze++AfKvBq+K/06RAniDzptqQZNKW9B0MRqqJQSTfbcstJEIhXXZ5PzJqGTO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNZaB8jj; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736433368; x=1767969368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VITV59GbUxGVZi+9c8e4gHb8aUcyhWoobrnDe90KlgY=;
  b=KNZaB8jjEhcbvVTjg+NMi6WhCbmMJy7ONgK4N/Q7goz+1qvaR1JK7cAV
   +GDHOdYE0ym0qSJ1R5S6wmppZM8gxev0SIc2ltcbHoL8JIXYHpGEzTmlj
   Ix1eH9ehCdIhWg1elIetwfXGaWVLsBnLP40kNEStiU2Zh7LUfDEZYrnZd
   EEJS9QplSnNbWkolMAfX7WogoMv04bBGBQDiyoRw3wdGPgQrrTj7Lh5GY
   im9cMjtlBjy1lUR/PM1IKdpMuZ9uhGCTSLYorAVazNEenBUpLSwP0Tf6V
   4dB2vEkFBIZHmygxErZ0E1P2N62+sYvD+h23s4cBijY7aP5sr989zWhjp
   A==;
X-CSE-ConnectionGUID: kVFZ+UIvQfKJ7mhzRMES+A==
X-CSE-MsgGUID: yVcmwkbITaiUtkl8OF1vpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36581999"
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="36581999"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 06:36:07 -0800
X-CSE-ConnectionGUID: H2rdLzUDRvajJxqUL5bk0w==
X-CSE-MsgGUID: FLepIv0rTdOwWtsD13HO0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="108413991"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 09 Jan 2025 06:36:05 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVtdj-000HgB-0n;
	Thu, 09 Jan 2025 14:36:03 +0000
Date: Thu, 9 Jan 2025 22:35:51 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 net-next 1/4] net: expedite synchronize_net() for
 cleanup_net()
Message-ID: <202501092210.1YCfipFl-lkp@intel.com>
References: <20250108162255.1306392-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108162255.1306392-2-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-expedite-synchronize_net-for-cleanup_net/20250109-002516
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250108162255.1306392-2-edumazet%40google.com
patch subject: [PATCH v2 net-next 1/4] net: expedite synchronize_net() for cleanup_net()
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20250109/202501092210.1YCfipFl-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250109/202501092210.1YCfipFl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501092210.1YCfipFl-lkp@intel.com/

All errors (new ones prefixed by >>):

   or1k-linux-ld: net/core/dev.o: in function `synchronize_net':
>> dev.c:(.text+0x22c8): undefined reference to `cleanup_net_task'
>> or1k-linux-ld: dev.c:(.text+0x22d0): undefined reference to `cleanup_net_task'
   or1k-linux-ld: net/core/dev.o: in function `dev_remove_pack':
   dev.c:(.text+0x7058): undefined reference to `cleanup_net_task'
   or1k-linux-ld: dev.c:(.text+0x7060): undefined reference to `cleanup_net_task'
   or1k-linux-ld: net/core/dev.o: in function `free_netdev':
   dev.c:(.text+0x7130): undefined reference to `cleanup_net_task'
   or1k-linux-ld: net/core/dev.o:dev.c:(.text+0x713c): more undefined references to `cleanup_net_task' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

