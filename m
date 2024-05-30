Return-Path: <netdev+bounces-99529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE478D529E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 21:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B85B2460A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AAE4D8B4;
	Thu, 30 May 2024 19:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bmvq8Sgg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D08433CA;
	Thu, 30 May 2024 19:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717098578; cv=none; b=nCEt6q0U6ZltiTpKIBiCtEFfVc+nx/EF8R/X7cZm+Akntdd6LQYAyjmGZ+OX63tY5I1r/q3YXZ8PeGyeMgHxr5XtKcSFkwzsSXusy93V0xmwAfhjsYzppzupH14yjW4IiWNIJbUTo4uBUiyDrgRYn8AEvaPozI/WZpl+7+LVnVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717098578; c=relaxed/simple;
	bh=dw6PHAUiKNZynTrJW/bQdeGSnY0/fN0GNkW1qwkTAPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHbvm/EpsXN9yzpFgHEYzhIk7KoALQZUx63UzDhHW6F/qU+oJHkHcdj7cgr8dwjOeKLwDK/HLJqN2Uueb4pQG3J3nv9JF55vHUSBtdldSDx8fyGpRMcigLPOEiBAco1i7LRTPR4m0OZZToqDHIUOiEdt/HGocfgveT+UY0+dgOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bmvq8Sgg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717098577; x=1748634577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dw6PHAUiKNZynTrJW/bQdeGSnY0/fN0GNkW1qwkTAPU=;
  b=Bmvq8SggsjX22zAb3RqmjnhQb9dMwMfchVW6dT7tKiGNfY+Ja45zrJXB
   5G7vZKJg74LlGrMIZyBHJnfa5wrn76b1DRzEY+EFHiuMEsCDSnsdMj0L7
   cywmyWLWTlFkQDz7arHu1u6fb7d6HT6pKQ0L+d1Cim2BuR4dpA02CGn/V
   hSuIivsJhf22bAbgNNJNgHyt5sEDRC74GFhbB99hhOnt2HgulDLxAZUVA
   QlUyAZ8pWwyjr51WEMi598Eui9GdgmS4mlnkYUQ6KG6VTFCgxlgvhT7Ch
   i2XIDNu0b2A28xLwCu47g58ZJd2d+P7DeVF8GMmYUDFeocF/lCP04fKJE
   w==;
X-CSE-ConnectionGUID: 9bvpDVfUSrWh3YIxR128cQ==
X-CSE-MsgGUID: HkkLzIBtRdWMzhJTFWtyvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31107727"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="31107727"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 12:49:36 -0700
X-CSE-ConnectionGUID: Jh/LxzXKTK+r0DCwXZWcWQ==
X-CSE-MsgGUID: FP8yERaSS/2g2CbiwJf7JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="35850528"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 30 May 2024 12:49:33 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sClmE-000FuR-2y;
	Thu, 30 May 2024 19:49:30 +0000
Date: Fri, 31 May 2024 03:48:51 +0800
From: kernel test robot <lkp@intel.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [net-next PATCH] octeontx2: Improve mailbox tracepoints for
 debugging
Message-ID: <202405310351.9HtVnVJ5-lkp@intel.com>
References: <1717070038-18381-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717070038-18381-1-git-send-email-sbhatta@marvell.com>

Hi Subbaraya,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Subbaraya-Sundeep/octeontx2-Improve-mailbox-tracepoints-for-debugging/20240530-195537
base:   net-next/main
patch link:    https://lore.kernel.org/r/1717070038-18381-1-git-send-email-sbhatta%40marvell.com
patch subject: [net-next PATCH] octeontx2: Improve mailbox tracepoints for debugging
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240531/202405310351.9HtVnVJ5-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240531/202405310351.9HtVnVJ5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405310351.9HtVnVJ5-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/marvell/octeontx2/af/mbox.c: In function '__otx2_mbox_reset':
>> drivers/net/ethernet/marvell/octeontx2/af/mbox.c:23:29: warning: unused variable 'msg' [-Wunused-variable]
      23 |         struct mbox_msghdr *msg;
         |                             ^~~
   drivers/net/ethernet/marvell/octeontx2/af/mbox.c: In function 'otx2_mbox_msg_send_data':
>> drivers/net/ethernet/marvell/octeontx2/af/mbox.c:254:9: error: 'msg' undeclared (first use in this function); did you mean 'ndmsg'?
     254 |         msg = (struct mbox_msghdr *)(hw_mbase + mbox->tx_start + msgs_offset);
         |         ^~~
         |         ndmsg
   drivers/net/ethernet/marvell/octeontx2/af/mbox.c:254:9: note: each undeclared identifier is reported only once for each function it appears in


vim +254 drivers/net/ethernet/marvell/octeontx2/af/mbox.c

   216	
   217	static void otx2_mbox_msg_send_data(struct otx2_mbox *mbox, int devid, u64 data)
   218	{
   219		struct otx2_mbox_dev *mdev = &mbox->dev[devid];
   220		struct mbox_hdr *tx_hdr, *rx_hdr;
   221		void *hw_mbase = mdev->hwbase;
   222		u64 intr_val;
   223	
   224		tx_hdr = hw_mbase + mbox->tx_start;
   225		rx_hdr = hw_mbase + mbox->rx_start;
   226	
   227		/* If bounce buffer is implemented copy mbox messages from
   228		 * bounce buffer to hw mbox memory.
   229		 */
   230		if (mdev->mbase != hw_mbase)
   231			memcpy(hw_mbase + mbox->tx_start + msgs_offset,
   232			       mdev->mbase + mbox->tx_start + msgs_offset,
   233			       mdev->msg_size);
   234	
   235		spin_lock(&mdev->mbox_lock);
   236	
   237		tx_hdr->msg_size = mdev->msg_size;
   238	
   239		/* Reset header for next messages */
   240		mdev->msg_size = 0;
   241		mdev->rsp_size = 0;
   242		mdev->msgs_acked = 0;
   243	
   244		/* Sync mbox data into memory */
   245		smp_wmb();
   246	
   247		/* num_msgs != 0 signals to the peer that the buffer has a number of
   248		 * messages.  So this should be written after writing all the messages
   249		 * to the shared memory.
   250		 */
   251		tx_hdr->num_msgs = mdev->num_msgs;
   252		rx_hdr->num_msgs = 0;
   253	
 > 254		msg = (struct mbox_msghdr *)(hw_mbase + mbox->tx_start + msgs_offset);
   255	
   256		trace_otx2_msg_send(mbox->pdev, tx_hdr->num_msgs, tx_hdr->msg_size,
   257				    msg->id, msg->pcifunc);
   258	
   259		spin_unlock(&mdev->mbox_lock);
   260	
   261		/* Check if interrupt pending */
   262		intr_val = readq((void __iomem *)mbox->reg_base +
   263			     (mbox->trigger | (devid << mbox->tr_shift)));
   264	
   265		intr_val |= data;
   266		/* The interrupt should be fired after num_msgs is written
   267		 * to the shared memory
   268		 */
   269		writeq(intr_val, (void __iomem *)mbox->reg_base +
   270		       (mbox->trigger | (devid << mbox->tr_shift)));
   271	}
   272	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

