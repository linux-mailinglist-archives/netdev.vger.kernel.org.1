Return-Path: <netdev+bounces-140703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F679B7AE0
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D41128222E
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 12:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E551B5827;
	Thu, 31 Oct 2024 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDAx1V2Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F801AC456;
	Thu, 31 Oct 2024 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378360; cv=none; b=l/AJ5MK+BR+CEwNazGwNnOjrbFrZi+wFuGEZRXr4aeWn6wQ10f3a1etuvcn/UM9qfSqrTcjpYsFL2Iav2yx10TsUmWY2A0RGZk6aSas1VhX/11WeBEhT9lWjO0scBwliEcir8f1KoL+rK5FxqpyT2ZJrRFspYuosR0kh0sPw6m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378360; c=relaxed/simple;
	bh=iu68N23NzUdf3Fg/DJ9+sppAEqS00Ptnyod+avC9IQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXyMKIPkRkXVjzTid/SWuucFpz3c/jx88gbCQpF23EyX1BBpxw8w1vExu8ncilmJ47GaXyqBr7HHSrb0IDpAFWp8IYfpy2ZYoWEoy58uv6O0NiYobBsMAI4zSGlOgrgzLwNnO2krU1tl97N2bg6pTFeQpaJNypcnw39Uabf8Hqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDAx1V2Q; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730378358; x=1761914358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iu68N23NzUdf3Fg/DJ9+sppAEqS00Ptnyod+avC9IQs=;
  b=EDAx1V2Qp2PJqOFVex+6QPDumHHj17gm3Mo/jAeoxmMoZyZpdrup9fBR
   XgJNNwBjTn6HJB5aD6XVsf1vItTjY/yYtmxk8+ZFR9R1mgmWw4LTR3/RL
   Ljw06ja0Kyf83QU9YYgZUG3ivAjyF8GO1uptzOHoBLR1JLCS3q9BMD+Vy
   5fV1IJeHsYn88SV8n9zF047IPQPBzLMY0ArUzjDCH6acSXRi5epN/pIq/
   28Lcq2UkOZOWJdqdpP2Wd9iW1oiLVh188B1C51wRVb5NE5LOqdl9qPMLH
   Dpn+01yE6kuUWL9w568wZf++S5Zkb2ZOvcXAqcdPGbRnrnTIcYtLNgiTj
   w==;
X-CSE-ConnectionGUID: LGhpIDK+RvOCXZuFedJKQg==
X-CSE-MsgGUID: laDLKxhTQreTGa6+j2BM9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29970059"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29970059"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 05:39:18 -0700
X-CSE-ConnectionGUID: W+vvptvCRPWl5E7ce60jZA==
X-CSE-MsgGUID: Ja2+anJoRGucNQ4pbtw1Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="113462624"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 31 Oct 2024 05:39:15 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6USG-000g5q-1J;
	Thu, 31 Oct 2024 12:39:12 +0000
Date: Thu, 31 Oct 2024 20:38:52 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v6 2/2] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <202410312023.JZ5q2dNz-lkp@intel.com>
References: <20241029165414.58746-3-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029165414.58746-3-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.12-rc5 next-20241031]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Check-before-sending-MCTP-PCC-response-ACK/20241030-005644
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241029165414.58746-3-admiyo%40os.amperecomputing.com
patch subject: [PATCH v6 2/2] mctp pcc: Implement MCTP over PCC Transport
config: arm64-kismet-CONFIG_ACPI-CONFIG_MCTP_TRANSPORT_PCC-0-0 (https://download.01.org/0day-ci/archive/20241031/202410312023.JZ5q2dNz-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20241031/202410312023.JZ5q2dNz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410312023.JZ5q2dNz-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for ACPI when selected by MCTP_TRANSPORT_PCC
   WARNING: unmet direct dependencies detected for ACPI
     Depends on [n]: ARCH_SUPPORTS_ACPI [=n]
     Selected by [y]:
     - MCTP_TRANSPORT_PCC [=y] && NETDEVICES [=y] && MCTP [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

