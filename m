Return-Path: <netdev+bounces-196860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82056AD6B80
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453CA16EF99
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8395A221F3E;
	Thu, 12 Jun 2025 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQgIVbzA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA70B21B918
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718610; cv=none; b=rTFtxQSuRoADWVyN/1DrR/2RADD9+pH7AbJg/oNjMHlk46tVT4FVgyBGadkpB6YpZQze48AM37Gr0Hfbb//X0RPH8eS2Wl/Lqp/2dMwRetJf9jdaA938dDAaBQKFa6vzL4WlR2zOm5CEyI9URi2VeT9DhlSGktmrgs4L+ajXzd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718610; c=relaxed/simple;
	bh=QUqmWhIOPeOaCfPk0J82P3o3C74RBvP6ZXmQgcB1aLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr7GTkYGcVtlJSuJULZYzAC+ulcTsB4Jsh4gm+28Yk5IKrWcX1YDU7B0HCzEHpE6H06fKrNaOf5AgwE1oIz+OCA6ni1fO9h51r09+PKGA5pEr+PS46kLVueJzyYsENrPDqHjnSXECQfJ7jmgm8ibt0paooYkpX4GCCoLUt4YTU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQgIVbzA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749718609; x=1781254609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QUqmWhIOPeOaCfPk0J82P3o3C74RBvP6ZXmQgcB1aLg=;
  b=GQgIVbzALAZsB+qhexr1it0ZqZ+o4p3uVNjHl6OKjpxzBCHrAZkmEgkn
   nVdhQ0IYCreDwUOMG2m2lvlh3gM7hl+oAQZQr7cCCnqQzi38fmiQGLWj8
   2SkMtdWQUI/Ig+4/TxQ7cfAZpZG/0zGGItyeB4bdXqkUB2HWQ9KaaafPh
   ndaHbhTSvHAWgDFpnLHDxK/1h9MnkPyA2Jx8XJYBMWoZXXSv8oAjtUISt
   FeGjsm6wiGmM8MPZE0uci3QaoIGHw20mRWt+CzxACGMOLyeK58AqO+CjV
   QueSYoBqm4yIaYId0RjjfLNqkX0lK3hHxmRGRxSxn9TnJ4z5HL1Knkx9g
   w==;
X-CSE-ConnectionGUID: 2+ZdponrRL67yqpk8KZtqA==
X-CSE-MsgGUID: cQI4CQmiRbW2Or8Tl8Ui7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="50996354"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="50996354"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 01:56:48 -0700
X-CSE-ConnectionGUID: hft+gJgKStipLfMBbHTDUg==
X-CSE-MsgGUID: wpC+Oj5gRyeOKAUeuyN0/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147442929"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 12 Jun 2025 01:56:46 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uPdjn-000BLK-1y;
	Thu, 12 Jun 2025 08:56:43 +0000
Date: Thu, 12 Jun 2025 16:56:14 +0800
From: kernel test robot <lkp@intel.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 13/13] net: mctp: test: Add tests for gateway
 routes
Message-ID: <202506121602.RLO9kgkY-lkp@intel.com>
References: <20250611-dev-forwarding-v1-13-6b69b1feb37f@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-dev-forwarding-v1-13-6b69b1feb37f@codeconstruct.com.au>

Hi Jeremy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0097c4195b1d0ca57d15979626c769c74747b5a0]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Kerr/net-mctp-don-t-use-source-cb-data-when-forwarding-ensure-pkt_type-is-set/20250611-143319
base:   0097c4195b1d0ca57d15979626c769c74747b5a0
patch link:    https://lore.kernel.org/r/20250611-dev-forwarding-v1-13-6b69b1feb37f%40codeconstruct.com.au
patch subject: [PATCH net-next 13/13] net: mctp: test: Add tests for gateway routes
config: hexagon-randconfig-r133-20250612 (https://download.01.org/0day-ci/archive/20250612/202506121602.RLO9kgkY-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce: (https://download.01.org/0day-ci/archive/20250612/202506121602.RLO9kgkY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506121602.RLO9kgkY-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/mctp/route.c: note: in included file:
>> net/mctp/test/route-test.c:1256:37: sparse: sparse: symbol 'mctp_route_gw_mtu_tests' was not declared. Should it be static?
   net/mctp/route.c:162:9: sparse: sparse: context imbalance in 'mctp_lookup_key' - different lock contexts for basic block
   net/mctp/route.c:554:39: sparse: sparse: context imbalance in 'mctp_dst_input' - unexpected unlock

vim +/mctp_route_gw_mtu_tests +1256 net/mctp/test/route-test.c

  1255	
> 1256	const struct mctp_route_gw_mtu_test mctp_route_gw_mtu_tests[] = {
  1257		/* no route-specific MTUs */
  1258		{ 68, 0, 0, 0, 68 },
  1259		{ 100, 0, 0, 0, 100 },
  1260		/* one route MTU (smaller than dev mtu), others unrestricted */
  1261		{ 100, 68, 0, 0, 68 },
  1262		{ 100, 0, 68, 0, 68 },
  1263		{ 100, 0, 0, 68, 68 },
  1264		/* smallest applied, regardless of order */
  1265		{ 100, 99, 98, 68, 68 },
  1266		{ 99, 100, 98, 68, 68 },
  1267		{ 98, 99, 100, 68, 68 },
  1268		{ 68, 98, 99, 100, 68 },
  1269	};
  1270	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

