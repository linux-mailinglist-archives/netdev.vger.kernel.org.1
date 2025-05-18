Return-Path: <netdev+bounces-191348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9CFABB12D
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 20:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C850F3B015D
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 18:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9307721D599;
	Sun, 18 May 2025 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MBSQVE7X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9246E21D583;
	Sun, 18 May 2025 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747591622; cv=none; b=bznDTprcoYLOIjWthaFOAMBRE7MGoUNEaLRr99uu0j5ddM4qQuFbsV0gRXkY46SfIThqHd1bz+eeFAprxPNB25IFrNnYL48ctEaaagbF/U16hFJiTUtV8oc/1aAj2RLYzFzDw+WNsbpdjRB3Q6DDHFyY6BIJlcmjSbkifVXakRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747591622; c=relaxed/simple;
	bh=pskOUvGEBKAl0vNeYYdPWPN8DH4UBURr9gH4uXhAoYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pc6SW3p8u/p/aTfZ7ol4aVjmH0Cy1zHHhcQpAhwgmrKKimmd3wRpGCuWB5STuy9c0tgUmy2X99PnWjyNjr0W2tHw3Qy/fW4BdURlYnBOyGBNQhR/PKhW6R+V550MLWCHKY0nZ/Q1aYPGqWPhwgkXthAD5ptiISl9avkqpi7dS1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MBSQVE7X; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747591620; x=1779127620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pskOUvGEBKAl0vNeYYdPWPN8DH4UBURr9gH4uXhAoYQ=;
  b=MBSQVE7XEbY3dosgWk7RLmpzlmu0us6B8FAfg6mDHlMKAP2oF6wrpsgq
   5FaY3/koUgZ46Sm5efXC2D45QwFvV1fT7qh4ajJg51rUkoADbKyo/r5uw
   9sKES/FefPivJrZv7u7hLaZ7xz/GyGIpK9DvkDPIclTj8xP4CZw3Iv9zQ
   ZuUuOufrNE6SixehDJdCCr4DD8ZREGxeI4JLiumSazgin63+glD/nqZeV
   k3nL+0RXz2y3Y1zQJS/wyp+Ym/koMZ2EhkR6WmZrBWvv5HgVUeKjurovH
   mgeOta2vFBRi1rG9uvhNuPwNV2mOyOhDlpwgS7TEq1n+lfJoDdHIEW/Kz
   w==;
X-CSE-ConnectionGUID: X73GSG06SFKRfK7gJesJyw==
X-CSE-MsgGUID: 7qcqoqFGS/mA+4Fkv5vDkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="53296878"
X-IronPort-AV: E=Sophos;i="6.15,299,1739865600"; 
   d="scan'208";a="53296878"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 11:06:59 -0700
X-CSE-ConnectionGUID: n6mz+/FWR1CZPevGq+cRjg==
X-CSE-MsgGUID: KxbogY7STF6fUxxxWpNfvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,299,1739865600"; 
   d="scan'208";a="138910479"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 18 May 2025 11:06:55 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uGiPT-000Ky3-2r;
	Sun, 18 May 2025 18:06:51 +0000
Date: Mon, 19 May 2025 02:06:38 +0800
From: kernel test robot <lkp@intel.com>
To: Gur Stavi <gur.stavi@huawei.com>, Fan Gong <gongfan1@huawei.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Meny Yossefi <meny.yossefi@huawei.com>, Lee Trager <lee@trager.us>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Suman Ghosh <sumang@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v15 1/1] hinic3: module initialization and tx/rx
 logic
Message-ID: <202505190148.x7llMRfr-lkp@intel.com>
References: <b5e005d0f8255df11f052b17a8deb856f8a7bdc2.1747556339.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5e005d0f8255df11f052b17a8deb856f8a7bdc2.1747556339.git.gur.stavi@huawei.com>

Hi Gur,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 67fa756408a5359941bea2c021740da5e9ed490d]

url:    https://github.com/intel-lab-lkp/linux/commits/Gur-Stavi/hinic3-module-initialization-and-tx-rx-logic/20250518-160845
base:   67fa756408a5359941bea2c021740da5e9ed490d
patch link:    https://lore.kernel.org/r/b5e005d0f8255df11f052b17a8deb856f8a7bdc2.1747556339.git.gur.stavi%40huawei.com
patch subject: [PATCH net-next v15 1/1] hinic3: module initialization and tx/rx logic
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20250519/202505190148.x7llMRfr-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250519/202505190148.x7llMRfr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505190148.x7llMRfr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/huawei/hinic3/hinic3_tx.c: In function 'hinic3_tx_poll':
>> drivers/net/ethernet/huawei/hinic3/hinic3_tx.c:633:32: warning: variable 'nic_dev' set but not used [-Wunused-but-set-variable]
     633 |         struct hinic3_nic_dev *nic_dev;
         |                                ^~~~~~~


vim +/nic_dev +633 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c

   625	
   626	#define HINIC3_BDS_PER_SQ_WQEBB \
   627		(HINIC3_SQ_WQEBB_SIZE / sizeof(struct hinic3_sq_bufdesc))
   628	
   629	bool hinic3_tx_poll(struct hinic3_txq *txq, int budget)
   630	{
   631		struct net_device *netdev = txq->netdev;
   632		u16 hw_ci, sw_ci, q_id = txq->sq->q_id;
 > 633		struct hinic3_nic_dev *nic_dev;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

