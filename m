Return-Path: <netdev+bounces-122466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E19E9616F8
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570102894FA
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC931D2795;
	Tue, 27 Aug 2024 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdFr4q/a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6AA1C688E
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724783233; cv=none; b=dCXp/jNKaaZmPnOY2zNZ9D6HixOOQBPRe3EBV5jM6pCKx0SHbngBxuWCk8LLd1BOxHuNxE7fOGYuuFjRbry2memH2P1cc0lu/Ri1KBTUb6qM98KBVmS3izt7dW1FH/QWyS4eUj4V5HBSnx0gRr6SMFtOQbZueg5pCFMAfArUgJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724783233; c=relaxed/simple;
	bh=U3S0NT5mAN5wdUNex9B7uZ/roVQlT/KDvNJFb560cvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiLIlO9P736Ox5cdpWxS5C2pek4ThXHLYca+oCxNBHBGNz8lMhMqoNpsyIzgWXgxBstCU+NgcXUHkPc46t3UxnYx3de+CPrdzonpsPqpuSBqOLlgS4/d8Y9Eae5U1onNGK9ZFZbZ/g/hOx5cqKSOMNZXa0j1B1O4f86Ri06AH3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdFr4q/a; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724783232; x=1756319232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U3S0NT5mAN5wdUNex9B7uZ/roVQlT/KDvNJFb560cvg=;
  b=HdFr4q/aQDWTxMqykAOTG42smxIBpHmfnJa1s03HMkGReSTQe/hUHpAt
   KWAhkVPmHd2VGCFq0E5nIbpfxG7UVQO72/dfZ1nZ/ZxvustKOafpumZ+X
   u7SPl1Vs71kURUeyqJXi87cMHBWKtSx34fyRjhK9481rs2215l7aQAYCC
   hs1M7m7yH5xl9rmUHEzD7HdfZvHShqAwQvJ1VVRAq6XZHhIlcj+/fSuOL
   WzCQZPDkx4NKL7arU+PBkbpBVju9HIxT/7220WM1PiEpsBShHJ8cYds3/
   EQpICsc1j0hXVxPyYFHPLdJ5PVVCdiTRsL4vKo+/YE67o2oEhKBlsHO2Q
   Q==;
X-CSE-ConnectionGUID: pj84zxQ/QyOcPN1grvIerg==
X-CSE-MsgGUID: JKWKmlRVQ4W9U65ktzEwqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="48665834"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="48665834"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 11:27:11 -0700
X-CSE-ConnectionGUID: M03qrS0KQNqGUNKHYCV7Pw==
X-CSE-MsgGUID: PQCa/K6lS8m6k3G9imHCJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="67306796"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 27 Aug 2024 11:27:10 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sj0uJ-000JwQ-0c;
	Tue, 27 Aug 2024 18:27:07 +0000
Date: Wed, 28 Aug 2024 02:26:42 +0800
From: kernel test robot <lkp@intel.com>
To: Hongbo Li <lihongbo22@huawei.com>, sam@mendozajonas.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lihongbo22@huawei.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net/ncsi: Use str_up_down to simplify
 the code
Message-ID: <202408280152.l51y5bcU-lkp@intel.com>
References: <20240827025246.963115-3-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827025246.963115-3-lihongbo22@huawei.com>

Hi Hongbo,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongbo-Li/net-ncsi-Use-str_up_down-to-simplify-the-code/20240827-104622
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240827025246.963115-3-lihongbo22%40huawei.com
patch subject: [PATCH net-next v2 2/2] net/ncsi: Use str_up_down to simplify the code
config: arc-randconfig-001-20240827 (https://download.01.org/0day-ci/archive/20240828/202408280152.l51y5bcU-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408280152.l51y5bcU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408280152.l51y5bcU-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/skbuff.h:38,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from net/ncsi/ncsi-aen.c:9:
   net/ncsi/ncsi-aen.c: In function 'ncsi_aen_handler_lsc':
>> net/ncsi/ncsi-aen.c:78:28: error: implicit declaration of function 'str_up_down' [-Werror=implicit-function-declaration]
      78 |                    nc->id, str_up_down(data & 0x1));
         |                            ^~~~~~~~~~~
   include/net/net_debug.h:66:60: note: in definition of macro 'netdev_dbg'
      66 |                 netdev_printk(KERN_DEBUG, __dev, format, ##args); \
         |                                                            ^~~~
>> net/ncsi/ncsi-aen.c:77:35: warning: format '%s' expects argument of type 'char *', but argument 5 has type 'int' [-Wformat=]
      77 |         netdev_dbg(ndp->ndev.dev, "NCSI: LSC AEN - channel %u state %s\n",
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      78 |                    nc->id, str_up_down(data & 0x1));
         |                            ~~~~~~~~~~~~~~~~~~~~~~~
         |                            |
         |                            int
   include/net/net_debug.h:66:50: note: in definition of macro 'netdev_dbg'
      66 |                 netdev_printk(KERN_DEBUG, __dev, format, ##args); \
         |                                                  ^~~~~~
   net/ncsi/ncsi-aen.c:77:70: note: format string is defined here
      77 |         netdev_dbg(ndp->ndev.dev, "NCSI: LSC AEN - channel %u state %s\n",
         |                                                                     ~^
         |                                                                      |
         |                                                                      char *
         |                                                                     %d
   cc1: some warnings being treated as errors


vim +/str_up_down +78 net/ncsi/ncsi-aen.c

   > 9	#include <linux/netdevice.h>
    10	#include <linux/skbuff.h>
    11	
    12	#include <net/ncsi.h>
    13	#include <net/net_namespace.h>
    14	#include <net/sock.h>
    15	
    16	#include "internal.h"
    17	#include "ncsi-pkt.h"
    18	
    19	static int ncsi_validate_aen_pkt(struct ncsi_aen_pkt_hdr *h,
    20					 const unsigned short payload)
    21	{
    22		u32 checksum;
    23		__be32 *pchecksum;
    24	
    25		if (h->common.revision != NCSI_PKT_REVISION)
    26			return -EINVAL;
    27		if (ntohs(h->common.length) != payload)
    28			return -EINVAL;
    29	
    30		/* Validate checksum, which might be zeroes if the
    31		 * sender doesn't support checksum according to NCSI
    32		 * specification.
    33		 */
    34		pchecksum = (__be32 *)((void *)(h + 1) + payload - 4);
    35		if (ntohl(*pchecksum) == 0)
    36			return 0;
    37	
    38		checksum = ncsi_calculate_checksum((unsigned char *)h,
    39						   sizeof(*h) + payload - 4);
    40		if (*pchecksum != htonl(checksum))
    41			return -EINVAL;
    42	
    43		return 0;
    44	}
    45	
    46	static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
    47					struct ncsi_aen_pkt_hdr *h)
    48	{
    49		struct ncsi_channel *nc, *tmp;
    50		struct ncsi_channel_mode *ncm;
    51		unsigned long old_data, data;
    52		struct ncsi_aen_lsc_pkt *lsc;
    53		struct ncsi_package *np;
    54		bool had_link, has_link;
    55		unsigned long flags;
    56		bool chained;
    57		int state;
    58	
    59		/* Find the NCSI channel */
    60		ncsi_find_package_and_channel(ndp, h->common.channel, NULL, &nc);
    61		if (!nc)
    62			return -ENODEV;
    63	
    64		/* Update the link status */
    65		lsc = (struct ncsi_aen_lsc_pkt *)h;
    66	
    67		spin_lock_irqsave(&nc->lock, flags);
    68		ncm = &nc->modes[NCSI_MODE_LINK];
    69		old_data = ncm->data[2];
    70		data = ntohl(lsc->status);
    71		ncm->data[2] = data;
    72		ncm->data[4] = ntohl(lsc->oem_status);
    73	
    74		had_link = !!(old_data & 0x1);
    75		has_link = !!(data & 0x1);
    76	
  > 77		netdev_dbg(ndp->ndev.dev, "NCSI: LSC AEN - channel %u state %s\n",
  > 78			   nc->id, str_up_down(data & 0x1));
    79	
    80		chained = !list_empty(&nc->link);
    81		state = nc->state;
    82		spin_unlock_irqrestore(&nc->lock, flags);
    83	
    84		if (state == NCSI_CHANNEL_INACTIVE)
    85			netdev_warn(ndp->ndev.dev,
    86				    "NCSI: Inactive channel %u received AEN!\n",
    87				    nc->id);
    88	
    89		if ((had_link == has_link) || chained)
    90			return 0;
    91	
    92		if (!ndp->multi_package && !nc->package->multi_channel) {
    93			if (had_link) {
    94				ndp->flags |= NCSI_DEV_RESHUFFLE;
    95				ncsi_stop_channel_monitor(nc);
    96				spin_lock_irqsave(&ndp->lock, flags);
    97				list_add_tail_rcu(&nc->link, &ndp->channel_queue);
    98				spin_unlock_irqrestore(&ndp->lock, flags);
    99				return ncsi_process_next_channel(ndp);
   100			}
   101			/* Configured channel came up */
   102			return 0;
   103		}
   104	
   105		if (had_link) {
   106			ncm = &nc->modes[NCSI_MODE_TX_ENABLE];
   107			if (ncsi_channel_is_last(ndp, nc)) {
   108				/* No channels left, reconfigure */
   109				return ncsi_reset_dev(&ndp->ndev);
   110			} else if (ncm->enable) {
   111				/* Need to failover Tx channel */
   112				ncsi_update_tx_channel(ndp, nc->package, nc, NULL);
   113			}
   114		} else if (has_link && nc->package->preferred_channel == nc) {
   115			/* Return Tx to preferred channel */
   116			ncsi_update_tx_channel(ndp, nc->package, NULL, nc);
   117		} else if (has_link) {
   118			NCSI_FOR_EACH_PACKAGE(ndp, np) {
   119				NCSI_FOR_EACH_CHANNEL(np, tmp) {
   120					/* Enable Tx on this channel if the current Tx
   121					 * channel is down.
   122					 */
   123					ncm = &tmp->modes[NCSI_MODE_TX_ENABLE];
   124					if (ncm->enable &&
   125					    !ncsi_channel_has_link(tmp)) {
   126						ncsi_update_tx_channel(ndp, nc->package,
   127								       tmp, nc);
   128						break;
   129					}
   130				}
   131			}
   132		}
   133	
   134		/* Leave configured channels active in a multi-channel scenario so
   135		 * AEN events are still received.
   136		 */
   137		return 0;
   138	}
   139	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

