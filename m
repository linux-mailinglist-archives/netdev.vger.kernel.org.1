Return-Path: <netdev+bounces-218185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9F3B3B6F7
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 11:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4676A047B5
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698C22EFD96;
	Fri, 29 Aug 2025 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFBtV8z0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5A42F0680;
	Fri, 29 Aug 2025 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459116; cv=none; b=Dc7JIqxr4AOr4x1dv3V8HBMOG56D76RgUUx51M6PTCgtveXyRxIYMDO5q/QRRmdDj8hPh2w3z+m+Pzkn7OSGs5VKfQ1y2FO/B9H4uuA0Xmpx3sIH4pc6VYDIm910xzbEehA24Xf9bM9aPU8KnMJGwsjkIkod+fvE1mt+vtygcYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459116; c=relaxed/simple;
	bh=NBlAl/fkZniarUxoV8DY/7IVwSEbyoIoJhWl8W7043o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpA5aCQ18vKBPBTRckFalcWlB8I7Lp66oseF9WKgc4T1Vs+MYs2faSy8pJJaQ+qrs8KdaKS7eSP+i/QwwfgavuVitrCIgF8WoCMZlLsORg+FON9bVrO7kNcYINvMaWMckhe6W+JH/cZDwR9b1/GzxkAYTtOlYgzM0J58GJADQBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cFBtV8z0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756459115; x=1787995115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NBlAl/fkZniarUxoV8DY/7IVwSEbyoIoJhWl8W7043o=;
  b=cFBtV8z0O+qjR+OprRl3c29hcYq8gn0dYeVRw+4rSKnnS8oFETPRAWA0
   M+/gn8fUrfxcSovd2XltKdBDX2oL1mMG9BybkgW4I3BVLI0Cpzo7ADzFY
   /SleNcaQGTRv3YdJhLodREDa+RepLwQOOlPSjo7zGg04k9tmuXjIvLHZj
   fEedFRv+p5ohuG9Kp4wA/VxumStq4A4VMPsw66uClnCLox1NLy5w6Q0mW
   0PFe788h1g1/ztMtYaUTle9sQqeGTK28JLQ8eHaRQcQDqIu+9a6HpVcJt
   1vBvhpjn4zTu/WrvMEXvQJp+zCwOFe0sPsxWU8Q8qkw4/v/9JO9aPkxFV
   w==;
X-CSE-ConnectionGUID: eYfcQHd5SFGa2+I2XsEVxQ==
X-CSE-MsgGUID: jPECHWV7R5i9ZnbpjLgLkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58684631"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58684631"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 02:18:34 -0700
X-CSE-ConnectionGUID: 5WNrupYfRqyf4qHQhFjQGg==
X-CSE-MsgGUID: KVYl1vhwQPG5QC7t1wwYzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="175623668"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 29 Aug 2025 02:18:30 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urvF5-000Ual-2t;
	Fri, 29 Aug 2025 09:18:06 +0000
Date: Fri, 29 Aug 2025 17:17:41 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH net-next v25 1/1] mctp pcc: Implement MCTP over PCC
 Transport
Message-ID: <202508291628.CPVGma07-lkp@intel.com>
References: <20250827044810.152775-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827044810.152775-2-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Implement-MCTP-over-PCC-Transport/20250827-124953
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250827044810.152775-2-admiyo%40os.amperecomputing.com
patch subject: [PATCH net-next v25 1/1] mctp pcc: Implement MCTP over PCC Transport
config: i386-randconfig-015-20250829 (https://download.01.org/0day-ci/archive/20250829/202508291628.CPVGma07-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250829/202508291628.CPVGma07-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508291628.CPVGma07-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/net/mctp/mctp-pcc.o: in function `mctp_pcc_tx':
>> drivers/net/mctp/mctp-pcc.c:153: undefined reference to `mbox_send_message'


vim +153 drivers/net/mctp/mctp-pcc.c

   130	
   131	static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
   132	{
   133		struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
   134		struct pcc_header *pcc_header;
   135		int len = skb->len;
   136		int rc;
   137	
   138		rc = skb_cow_head(skb, sizeof(*pcc_header));
   139		if (rc) {
   140			dev_dstats_tx_dropped(ndev);
   141			kfree_skb(skb);
   142			return NETDEV_TX_OK;
   143		}
   144	
   145		pcc_header = skb_push(skb, sizeof(*pcc_header));
   146		pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
   147		pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
   148		memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
   149		pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
   150	
   151		skb_queue_head(&mpnd->outbox.packets, skb);
   152	
 > 153		rc = mbox_send_message(mpnd->outbox.chan->mchan, skb->data);
   154	
   155		if (rc < 0) {
   156			skb_unlink(skb, &mpnd->outbox.packets);
   157			return NETDEV_TX_BUSY;
   158		}
   159	
   160		dev_dstats_tx_add(ndev, len);
   161		return NETDEV_TX_OK;
   162	}
   163	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

