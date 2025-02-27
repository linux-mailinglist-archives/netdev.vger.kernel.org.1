Return-Path: <netdev+bounces-170453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 388C9A48D04
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 00:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403DA16CF8D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 23:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DEA272913;
	Thu, 27 Feb 2025 23:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XaFGytgA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28FA23E341
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740700773; cv=none; b=tgkuQim2d4KMMUJmpvSEqKKB9yzd0YTZ2qOgfarF5QpkwMQhkU0C8YMo0r3By2yuB9l3l5vojdTqVu48JWVbhlNuXLT/FGYBOic3IOd5QwgOZKIdLsXNqo++XeIDzXWaC9SG/Yaqbfbkmw78JTDLIvo5E1G4KYBpq4IMZYwsAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740700773; c=relaxed/simple;
	bh=ITy8k5jUfknq+Y5v4tUBpidCS7oTrz86FIfjVJcACKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQKOS67Mkal3MBma1ccIYiYnea/Bc7U4ETGKu7USkVV6tlGwmwcMboZ3LJpmBJotI+MbSTSpWu2drKuOnPHDAjbknUiwOaXFcxXXqgwzFJW4D0kbY/6cdGwvFspQ5N/xfKDHQGyzyWNIsEfNlA0wzXKcMPdBNKfpD7Dmb5ETAi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XaFGytgA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740700772; x=1772236772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ITy8k5jUfknq+Y5v4tUBpidCS7oTrz86FIfjVJcACKU=;
  b=XaFGytgA/48qWXO0SM8c/F87B2t12jjCYvWu/LgWEeVdGTCvQWdhsrPZ
   oSPBYHnf7THtFIwUT/GLLpUidBT8x3gcIypWTb1OHPwcrjJvGrOCUf6ye
   6sKo6mBLyWnGKw/PJPZPfrTlid9a9Wt/wMr4LH5mvX1a2rU5ezRZYXxQO
   JaOsg7A7slM81jPBoF3FzwS9Sb40VaEOCdobD7PnRc5evww1t5utrUgRz
   lUGhlFPEwtchQbAM9WCj3cDZqcBCyDwXXBoXHVjGD7l9Wu/33grUnVBXn
   f5xUnCUSYnHCxQYhiA97frl5xeWRJ4Plz6kC11TrNYLrSEp7Bfq2gceOd
   Q==;
X-CSE-ConnectionGUID: 4J60YAQqRtyqtYc0X7SiEQ==
X-CSE-MsgGUID: VG/HU85cTJ6WaJ5R3mBvTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45398268"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="45398268"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 15:59:32 -0800
X-CSE-ConnectionGUID: +Ahx6WEjSRaEDcBG/RNCiQ==
X-CSE-MsgGUID: GY0i+d0FSDeSq2ehKcH3mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="140399641"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 27 Feb 2025 15:59:29 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnnmo-000ECs-38;
	Thu, 27 Feb 2025 23:59:26 +0000
Date: Fri, 28 Feb 2025 07:59:01 +0800
From: kernel test robot <lkp@intel.com>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] idpf: assign extracted
 ptype to struct libeth_rqe_info field
Message-ID: <202502280724.aEP7VGSr-lkp@intel.com>
References: <20250227123837.547053-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227123837.547053-1-mateusz.polchlopek@intel.com>

Hi Mateusz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tnguy-next-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Polchlopek/idpf-assign-extracted-ptype-to-struct-libeth_rqe_info-field/20250227-214755
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20250227123837.547053-1-mateusz.polchlopek%40intel.com
patch subject: [Intel-wired-lan] [PATCH iwl-next v1] idpf: assign extracted ptype to struct libeth_rqe_info field
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250228/202502280724.aEP7VGSr-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502280724.aEP7VGSr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502280724.aEP7VGSr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c:946: warning: Excess function parameter 'ptype' description in 'idpf_rx_singleq_extract_fields'


vim +946 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c

a5ab9ee0df0be8 Joshua Hay         2023-08-07  933  
a5ab9ee0df0be8 Joshua Hay         2023-08-07  934  /**
a5ab9ee0df0be8 Joshua Hay         2023-08-07  935   * idpf_rx_singleq_extract_fields - Extract fields from the Rx descriptor
a5ab9ee0df0be8 Joshua Hay         2023-08-07  936   * @rx_q: Rx descriptor queue
a5ab9ee0df0be8 Joshua Hay         2023-08-07  937   * @rx_desc: the descriptor to process
a5ab9ee0df0be8 Joshua Hay         2023-08-07  938   * @fields: storage for extracted values
ce5cf4af7ceb6c Mateusz Polchlopek 2024-11-06  939   * @ptype: pointer that will store packet type
a5ab9ee0df0be8 Joshua Hay         2023-08-07  940   *
a5ab9ee0df0be8 Joshua Hay         2023-08-07  941   */
e4891e4687c8dd Alexander Lobakin  2024-06-20  942  static void
e4891e4687c8dd Alexander Lobakin  2024-06-20  943  idpf_rx_singleq_extract_fields(const struct idpf_rx_queue *rx_q,
e4891e4687c8dd Alexander Lobakin  2024-06-20  944  			       const union virtchnl2_rx_desc *rx_desc,
45cbbcb40f4efc Mateusz Polchlopek 2025-02-27  945  			       struct libeth_rqe_info *fields)
a5ab9ee0df0be8 Joshua Hay         2023-08-07 @946  {
a5ab9ee0df0be8 Joshua Hay         2023-08-07  947  	if (rx_q->rxdids == VIRTCHNL2_RXDID_1_32B_BASE_M)
45cbbcb40f4efc Mateusz Polchlopek 2025-02-27  948  		idpf_rx_singleq_extract_base_fields(rx_desc, fields);
a5ab9ee0df0be8 Joshua Hay         2023-08-07  949  	else
45cbbcb40f4efc Mateusz Polchlopek 2025-02-27  950  		idpf_rx_singleq_extract_flex_fields(rx_desc, fields);
a5ab9ee0df0be8 Joshua Hay         2023-08-07  951  }
a5ab9ee0df0be8 Joshua Hay         2023-08-07  952  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

