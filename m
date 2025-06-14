Return-Path: <netdev+bounces-197767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0071AD9D58
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 16:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67775178864
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E012D8DB1;
	Sat, 14 Jun 2025 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRvTsOBW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18822741A6;
	Sat, 14 Jun 2025 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749910561; cv=none; b=f66ZuZ3SQ8UcGK5sS8cHIPILJZ2QtD1okGNhH5JU7HLsgLtOrSO/3opJJgY+iYK0stYzvhKfzGnwYYoK+OAgzZM1Ev3mHs2ldjaZaMgbLOiP8ZkOKORT2KFcBYvaMIkYqq0kYQ2JvM2H+kP9vXc+gPuGS+7ZtYwjJRcXr4WOEAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749910561; c=relaxed/simple;
	bh=GC9tpkFfno9ZmAS5i81de4jLhUq5fwK+uGips45OJ5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+Ij2nsYRLLPnfWr1psMtOzHU/3C+BZQa5gAmfiFIgx8UR7lvH0aKjcLzV1MUGr6Xs7oSQV8XLxtQ5ORui6lSA/ruk1dBpLpVe9XkzblDfhx/SR1SfNhCKXmb34NgBE/vZmGW/4Ie0vqhpAd4OidtPpuaKhbCSZzWY5ohenan5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRvTsOBW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749910559; x=1781446559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GC9tpkFfno9ZmAS5i81de4jLhUq5fwK+uGips45OJ5o=;
  b=KRvTsOBWG+dUyLMJ9PdTY6LjSvNwN/ZUunDc9UOaF25h6ZLOobOyW5Fy
   UbfSFaK48/oo6BM7de7ytG4LEWsdhhheTP0HX5pzkYIhAeZpTNCVIcKhI
   Q80KrHJPF1CeHRYN8Ix4ztJtS9OayKpfRLDGyGAk9ggqLIiTZeelbPl6F
   xHai1ETscCDf3dv5Vs3dbR/rl/pm1BufJjti7OYZemzNIBiJFuC5bkTeU
   Pnz1NkFPCoRwG1QeZrTNMZ5kviiDTC6+vg3uoSj8C0EpN2ZOxog9aNmBx
   Mq8IiSOD6mK6V0bk7EtVd8x2txqS84g2EkkzyNYhzw1veMIzBI3SRurfb
   g==;
X-CSE-ConnectionGUID: KWo4rfgRSq2p/C6lxJ9jTA==
X-CSE-MsgGUID: VbFYmJuXT+W7EVpZr+0snQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11464"; a="69688554"
X-IronPort-AV: E=Sophos;i="6.16,236,1744095600"; 
   d="scan'208";a="69688554"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2025 07:15:58 -0700
X-CSE-ConnectionGUID: 8LEP3H+cTOytWMQIGoZRJg==
X-CSE-MsgGUID: 0Js0oOpcTFqf1Z8IG88u5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,236,1744095600"; 
   d="scan'208";a="147964324"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 14 Jun 2025 07:15:55 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQRfl-000DZW-03;
	Sat, 14 Jun 2025 14:15:53 +0000
Date: Sat, 14 Jun 2025 22:15:18 +0800
From: kernel test robot <lkp@intel.com>
To: Jun Miao <jun.miao@intel.com>, sbhatta@marvell.com, kuba@kernel.org,
	oneukum@suse.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev, jun.miao@intel.com
Subject: Re: [PATCH v2] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
Message-ID: <202506142111.KG4EupOI-lkp@intel.com>
References: <20250614111414.2502195-1-jun.miao@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614111414.2502195-1-jun.miao@intel.com>

Hi Jun,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus net/main net-next/main linus/master v6.16-rc1 next-20250613]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jun-Miao/net-usb-Convert-tasklet-API-to-new-bottom-half-workqueue-mechanism/20250614-191339
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20250614111414.2502195-1-jun.miao%40intel.com
patch subject: [PATCH v2] net: usb: Convert tasklet API to new bottom half workqueue mechanism
config: nios2-randconfig-001-20250614 (https://download.01.org/0day-ci/archive/20250614/202506142111.KG4EupOI-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250614/202506142111.KG4EupOI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506142111.KG4EupOI-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/usb/usbnet.c: In function 'usbnet_resume':
>> drivers/net/usb/usbnet.c:1974:47: error: 'struct usbnet' has no member named 'bh'
    1974 |                         tasklet_schedule (&dev->bh);
         |                                               ^~


vim +1974 drivers/net/usb/usbnet.c

^1da177e4c3f41 drivers/usb/net/usbnet.c Linus Torvalds   2005-04-16  1931  
38bde1d4699af4 drivers/usb/net/usbnet.c David Brownell   2005-08-31  1932  int usbnet_resume (struct usb_interface *intf)
^1da177e4c3f41 drivers/usb/net/usbnet.c Linus Torvalds   2005-04-16  1933  {
^1da177e4c3f41 drivers/usb/net/usbnet.c Linus Torvalds   2005-04-16  1934  	struct usbnet		*dev = usb_get_intfdata(intf);
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1935  	struct sk_buff          *skb;
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1936  	struct urb              *res;
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1937  	int                     retval;
^1da177e4c3f41 drivers/usb/net/usbnet.c Linus Torvalds   2005-04-16  1938  
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1939  	if (!--dev->suspend_count) {
6eecdc5f95a393 drivers/net/usb/usbnet.c Dan Williams     2013-05-06  1940  		/* resume interrupt URB if it was previously submitted */
6eecdc5f95a393 drivers/net/usb/usbnet.c Dan Williams     2013-05-06  1941  		__usbnet_status_start_force(dev, GFP_NOIO);
68972efa657040 drivers/net/usb/usbnet.c Paul Stewart     2011-04-28  1942  
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1943  		spin_lock_irq(&dev->txq.lock);
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1944  		while ((res = usb_get_from_anchor(&dev->deferred))) {
a11a6544c0bf6c drivers/net/usb/usbnet.c Oliver Neukum    2007-08-03  1945  
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1946  			skb = (struct sk_buff *)res->context;
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1947  			retval = usb_submit_urb(res, GFP_ATOMIC);
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1948  			if (retval < 0) {
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1949  				dev_kfree_skb_any(skb);
638c5115a79498 drivers/net/usb/usbnet.c Ming Lei         2013-08-08  1950  				kfree(res->sg);
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1951  				usb_free_urb(res);
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1952  				usb_autopm_put_interface_async(dev->intf);
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1953  			} else {
860e9538a9482b drivers/net/usb/usbnet.c Florian Westphal 2016-05-03  1954  				netif_trans_update(dev->net);
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1955  				__skb_queue_tail(&dev->txq, skb);
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1956  			}
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1957  		}
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1958  
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1959  		smp_mb();
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1960  		clear_bit(EVENT_DEV_ASLEEP, &dev->flags);
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1961  		spin_unlock_irq(&dev->txq.lock);
75bd0cbdc21d80 drivers/net/usb/usbnet.c Ming Lei         2011-04-28  1962  
75bd0cbdc21d80 drivers/net/usb/usbnet.c Ming Lei         2011-04-28  1963  		if (test_bit(EVENT_DEV_OPEN, &dev->flags)) {
14a0d635d18d0f drivers/net/usb/usbnet.c Oliver Neukum    2014-03-26  1964  			/* handle remote wakeup ASAP
14a0d635d18d0f drivers/net/usb/usbnet.c Oliver Neukum    2014-03-26  1965  			 * we cannot race against stop
14a0d635d18d0f drivers/net/usb/usbnet.c Oliver Neukum    2014-03-26  1966  			 */
14a0d635d18d0f drivers/net/usb/usbnet.c Oliver Neukum    2014-03-26  1967  			if (netif_device_present(dev->net) &&
65841fd5132c39 drivers/net/usb/usbnet.c Ming Lei         2012-06-19  1968  				!timer_pending(&dev->delay) &&
65841fd5132c39 drivers/net/usb/usbnet.c Ming Lei         2012-06-19  1969  				!test_bit(EVENT_RX_HALT, &dev->flags))
ab6f148de28261 drivers/net/usb/usbnet.c Oliver Neukum    2012-08-26  1970  					rx_alloc_submit(dev, GFP_NOIO);
65841fd5132c39 drivers/net/usb/usbnet.c Ming Lei         2012-06-19  1971  
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1972  			if (!(dev->txq.qlen >= TX_QLEN(dev)))
1aa9bc5b2f4cf8 drivers/net/usb/usbnet.c Alexey Orishko   2012-03-14  1973  				netif_tx_wake_all_queues(dev->net);
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03 @1974  			tasklet_schedule (&dev->bh);
69ee472f270637 drivers/net/usb/usbnet.c Oliver Neukum    2009-12-03  1975  		}
75bd0cbdc21d80 drivers/net/usb/usbnet.c Ming Lei         2011-04-28  1976  	}
5d9d01a30204c9 drivers/net/usb/usbnet.c Oliver Neukum    2012-10-11  1977  
5d9d01a30204c9 drivers/net/usb/usbnet.c Oliver Neukum    2012-10-11  1978  	if (test_and_clear_bit(EVENT_DEVICE_REPORT_IDLE, &dev->flags))
5d9d01a30204c9 drivers/net/usb/usbnet.c Oliver Neukum    2012-10-11  1979  		usb_autopm_get_interface_no_resume(intf);
5d9d01a30204c9 drivers/net/usb/usbnet.c Oliver Neukum    2012-10-11  1980  
^1da177e4c3f41 drivers/usb/net/usbnet.c Linus Torvalds   2005-04-16  1981  	return 0;
^1da177e4c3f41 drivers/usb/net/usbnet.c Linus Torvalds   2005-04-16  1982  }
38bde1d4699af4 drivers/usb/net/usbnet.c David Brownell   2005-08-31  1983  EXPORT_SYMBOL_GPL(usbnet_resume);
^1da177e4c3f41 drivers/usb/net/usbnet.c Linus Torvalds   2005-04-16  1984  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

