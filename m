Return-Path: <netdev+bounces-177672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49A1A71174
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 08:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834C93B5F95
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 07:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A0119CC28;
	Wed, 26 Mar 2025 07:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JdyNRsQe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5465C198E6F
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742974449; cv=none; b=TqmE/a2THHewDA/DA+269FIfgJIaoWrTruNFtNM0l/YFpI6OVXroo9yYfVRvBV2krlzvz6SxLN23a6Hc5GqSF6ormcBVlvatMRQih7yymexUoT3RFEoPnxZsTHTQNiDFU/glrDV9bdmyUOl9eVycoke4Dky24qxVTDlhfZxD2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742974449; c=relaxed/simple;
	bh=bRqt9ZnlRx0YBpR5AZgDSylOjRtHgF5GmwEwLJF1QQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRrt13Luy5PscdcxNsux6RLzYhHRHTM2qnI5Vxhu/mw0EPlYAl+sYWtZFzwuwzvkDpX8ux/078hTwBr7/qh/00AeE/hAA53QGXjVHuGW2UNoGFV7z/9v5vtvEeCRAvu4aBgC/OsLzHBOLMAnvFwVrEfeAGhd+N2p3ibr4pFzLAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JdyNRsQe; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742974449; x=1774510449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bRqt9ZnlRx0YBpR5AZgDSylOjRtHgF5GmwEwLJF1QQY=;
  b=JdyNRsQeP705rJoRwSe8osV43u62plQleeZuBcjaUkckEqHQytXjMICD
   XOGJt5iosGNnID4nNlK/6z9RK9sBoFrAcW7ebGhwRY8h2LZD+9Y+z6mCU
   qNLJHb4JpI38cu1M509nNXkyCUcP7yFQPbi/7QTTQURqsW+0CaJ2TpO/v
   xg+/uWp2+Whqqa+M1dzU2HI0i6MiXfzdHbtKOcGkh0ejFbcpShzKbNPFZ
   AEqr8NGGbybSgPBcpCS/KWDMev4dgOc4rLwMO3JAnju1cMj9Lu2yWC6+2
   1/a7ePGljfdVlzykQbZSP1xyOrGMWO3CX8jmFkSyMT5TwF3/32nBE3mlb
   w==;
X-CSE-ConnectionGUID: f7fvAMInTAGdT7Ln7h8P0Q==
X-CSE-MsgGUID: UHiFHkQJS4+xALnwc8H6sQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="54450366"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="54450366"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 00:34:08 -0700
X-CSE-ConnectionGUID: SBr8HkS9REGdiEITls17xg==
X-CSE-MsgGUID: ydURiyz+Rca4g691sY19pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="125600605"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 26 Mar 2025 00:34:05 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txLH1-0005Xf-1f;
	Wed, 26 Mar 2025 07:34:03 +0000
Date: Wed, 26 Mar 2025 15:33:18 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next 3/9] net: use netif_disable_lro in ipv6_add_dev
Message-ID: <202503261535.GURSr7ti-lkp@intel.com>
References: <20250325213056.332902-4-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325213056.332902-4-sdf@fomichev.me>

Hi Stanislav,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/net-switch-to-netif_disable_lro-in-inetdev_init/20250326-053539
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250325213056.332902-4-sdf%40fomichev.me
patch subject: [PATCH net-next 3/9] net: use netif_disable_lro in ipv6_add_dev
config: csky-randconfig-002-20250326 (https://download.01.org/0day-ci/archive/20250326/202503261535.GURSr7ti-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250326/202503261535.GURSr7ti-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503261535.GURSr7ti-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "netdev_get_by_index_lock" [net/ipv6/ipv6.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

