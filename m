Return-Path: <netdev+bounces-126270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C96970476
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 01:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D84282D07
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 23:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A62616A396;
	Sat,  7 Sep 2024 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGjbi3Q6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD43E28FC;
	Sat,  7 Sep 2024 23:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725750757; cv=none; b=rNW9tlq6AjZGsI/6FU98dJVB8kI9VB3crv3xCkkLihYyuhwiJ1j52AF8rInnefU4QJk470G8PRxpWg6/+TUK+ifX7H2drkrJcOEKWWdclMjNpIgNeF18Flyprr5PDpbFYI1Xs/vCToU8TAqbQztEJ//qbwsFGCG3ySrAhExX0vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725750757; c=relaxed/simple;
	bh=mPOkmewzI96ZwXriUxfSfhdC1f9wh0KEnLvE32UZTzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0hqUsFt6liZtwEHFWmUHuJcEaX74QMg0PttkmrZRz4qua27NcIShG+mCfFKaMbI5pSrhMRiz8WuDCoTfMQfJxpySBtnnQcNbtLjjCk9qOwgWMpC1tz1SK6yiAStbRirOiUuTCHL9Bh/JNlcI6izM7dNsMQm03wmS6RIKI4z+UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGjbi3Q6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725750754; x=1757286754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mPOkmewzI96ZwXriUxfSfhdC1f9wh0KEnLvE32UZTzU=;
  b=kGjbi3Q6297vob9Xeh4UrtUa+rFYl67r6cf9O/dTxyz+iFS+XkscS5Rs
   7dCDlGII46XBxyhizMuDbm+UC4OyMMLoNj463vMTk0DCH8lggS0hMzFKQ
   W0isuDUFvmNeYpxqTcNBrTBMrt+sOVqa0T6iTDElwf96o+SVhAYBpik9v
   /rDIfN1XOG/Bst8Lyc31HUsQz1wSBEipB3W5gJG9OZMeTNY5ggaW/MICm
   1h/q/q9YjHXuTJimSnkUnxjhTGmPZ44nEq+eHt6KgOTDTYnzaiG/foEsY
   q8eZr5Zp4zMtwZ3m5+FA06/C8e+nO/uNnVnFYSj0lTOAKABtr02vUATdH
   Q==;
X-CSE-ConnectionGUID: ezth1XMUThCAuL7I35f+qA==
X-CSE-MsgGUID: oCMmqCvzSreqDzjhgFQbXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="24587915"
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="24587915"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 16:12:34 -0700
X-CSE-ConnectionGUID: YQgPQZ0NTp+1Hf6Ye4L2Cw==
X-CSE-MsgGUID: g0uaRQfjRSWHl3XtXJt/SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="65983802"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 07 Sep 2024 16:12:30 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sn4bU-000D5z-27;
	Sat, 07 Sep 2024 23:12:28 +0000
Date: Sun, 8 Sep 2024 07:11:40 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
	chunkeey@gmail.com
Subject: Re: [PATCHv3 net-next 9/9] net: ibm: emac: get rid of wol_irq
Message-ID: <202409080648.nbPtsrf6-lkp@intel.com>
References: <20240905201506.12679-10-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240905201506.12679-10-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-ibm-emac-use-devm-for-alloc_etherdev/20240906-042738
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240905201506.12679-10-rosenp%40gmail.com
patch subject: [PATCHv3 net-next 9/9] net: ibm: emac: get rid of wol_irq
config: powerpc-ebony_defconfig (https://download.01.org/0day-ci/archive/20240908/202409080648.nbPtsrf6-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 05f5a91d00b02f4369f46d076411c700755ae041)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240908/202409080648.nbPtsrf6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409080648.nbPtsrf6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/ibm/emac/core.c:28:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/powerpc/include/asm/io.h:24:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/net/ethernet/ibm/emac/core.c:3054:8: error: use of undeclared label 'err_irq_unmap'
    3054 |                 goto err_irq_unmap;
         |                      ^
   1 warning and 1 error generated.


vim +/err_irq_unmap +3054 drivers/net/ethernet/ibm/emac/core.c

15efc02b2625f1 drivers/net/ibm_newemac/core.c       Alexander Beregalov 2009-04-09  2988  
fe17dc1e2bae85 drivers/net/ethernet/ibm/emac/core.c Bill Pemberton      2012-12-03  2989  static int emac_probe(struct platform_device *ofdev)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2990  {
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2991  	struct net_device *ndev;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2992  	struct emac_instance *dev;
61c7a080a5a061 drivers/net/ibm_newemac/core.c       Grant Likely        2010-04-13  2993  	struct device_node *np = ofdev->dev.of_node;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2994  	struct device_node **blist = NULL;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2995  	int err, i;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2996  
be63c09afe9153 drivers/net/ibm_newemac/core.c       Josh Boyer          2008-04-22  2997  	/* Skip unused/unwired EMACS.  We leave the check for an unused
be63c09afe9153 drivers/net/ibm_newemac/core.c       Josh Boyer          2008-04-22  2998  	 * property here for now, but new flat device trees should set a
be63c09afe9153 drivers/net/ibm_newemac/core.c       Josh Boyer          2008-04-22  2999  	 * status property to "disabled" instead.
be63c09afe9153 drivers/net/ibm_newemac/core.c       Josh Boyer          2008-04-22  3000  	 */
1a87e641d8a50c drivers/net/ethernet/ibm/emac/core.c Rob Herring         2023-03-14  3001  	if (of_property_read_bool(np, "unused") || !of_device_is_available(np))
3d722562d73483 drivers/net/ibm_newemac/core.c       Hugh Blemings       2007-12-05  3002  		return -ENODEV;
3d722562d73483 drivers/net/ibm_newemac/core.c       Hugh Blemings       2007-12-05  3003  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3004  	/* Find ourselves in the bootlist if we are there */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3005  	for (i = 0; i < EMAC_BOOT_LIST_SIZE; i++)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3006  		if (emac_boot_list[i] == np)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3007  			blist = &emac_boot_list[i];
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3008  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3009  	/* Allocate our net_device structure */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3010  	err = -ENOMEM;
c7de481bca2013 drivers/net/ethernet/ibm/emac/core.c Rosen Penev         2024-09-05  3011  	ndev = devm_alloc_etherdev(&ofdev->dev, sizeof(struct emac_instance));
41de8d4cff21a2 drivers/net/ethernet/ibm/emac/core.c Joe Perches         2012-01-29  3012  	if (!ndev)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3013  		goto err_gone;
41de8d4cff21a2 drivers/net/ethernet/ibm/emac/core.c Joe Perches         2012-01-29  3014  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3015  	dev = netdev_priv(ndev);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3016  	dev->ndev = ndev;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3017  	dev->ofdev = ofdev;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3018  	dev->blist = blist;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3019  	SET_NETDEV_DEV(ndev, &ofdev->dev);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3020  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3021  	/* Initialize some embedded data structures */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3022  	mutex_init(&dev->mdio_lock);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3023  	mutex_init(&dev->link_lock);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3024  	spin_lock_init(&dev->lock);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3025  	INIT_WORK(&dev->reset_work, emac_reset_work);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3026  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3027  	/* Init various config data based on device-tree */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3028  	err = emac_init_config(dev);
138b57f0f89387 drivers/net/ethernet/ibm/emac/core.c Christophe Jaillet  2017-08-20  3029  	if (err)
c7de481bca2013 drivers/net/ethernet/ibm/emac/core.c Rosen Penev         2024-09-05  3030  		goto err_gone;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3031  
cabb2424d4d5d4 drivers/net/ethernet/ibm/emac/core.c Rosen Penev         2024-09-05  3032  	/* Get interrupts. EMAC irq is mandatory */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3033  	dev->emac_irq = irq_of_parse_and_map(np, 0);
99c1790e5bbd31 drivers/net/ethernet/ibm/emac/core.c Michael Ellerman    2016-09-10  3034  	if (!dev->emac_irq) {
f7ce91038d5278 drivers/net/ethernet/ibm/emac/core.c Rob Herring         2017-07-18  3035  		printk(KERN_ERR "%pOF: Can't map main interrupt\n", np);
138b57f0f89387 drivers/net/ethernet/ibm/emac/core.c Christophe Jaillet  2017-08-20  3036  		err = -ENODEV;
c7de481bca2013 drivers/net/ethernet/ibm/emac/core.c Rosen Penev         2024-09-05  3037  		goto err_gone;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3038  	}
55b3f1525a5443 drivers/net/ethernet/ibm/emac/core.c Rosen Penev         2024-09-05  3039  
55b3f1525a5443 drivers/net/ethernet/ibm/emac/core.c Rosen Penev         2024-09-05  3040  	/* Setup error IRQ handler */
55b3f1525a5443 drivers/net/ethernet/ibm/emac/core.c Rosen Penev         2024-09-05  3041  	err = devm_request_irq(&ofdev->dev, dev->emac_irq, emac_irq, 0, "EMAC", dev);
55b3f1525a5443 drivers/net/ethernet/ibm/emac/core.c Rosen Penev         2024-09-05  3042  	if (err) {
55b3f1525a5443 drivers/net/ethernet/ibm/emac/core.c Rosen Penev         2024-09-05  3043  		dev_err_probe(&ofdev->dev, err, "failed to request IRQ %d", dev->emac_irq);
55b3f1525a5443 drivers/net/ethernet/ibm/emac/core.c Rosen Penev         2024-09-05  3044  		goto err_gone;
55b3f1525a5443 drivers/net/ethernet/ibm/emac/core.c Rosen Penev         2024-09-05  3045  	}
55b3f1525a5443 drivers/net/ethernet/ibm/emac/core.c Rosen Penev         2024-09-05  3046  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3047  	ndev->irq = dev->emac_irq;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3048  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3049  	/* Map EMAC regs */
138b57f0f89387 drivers/net/ethernet/ibm/emac/core.c Christophe Jaillet  2017-08-20  3050  	// TODO : platform_get_resource() and devm_ioremap_resource()
154cc24d587dd8 drivers/net/ethernet/ibm/emac/core.c Rosen Penev         2024-09-05  3051  	dev->emacp = devm_of_iomap(&ofdev->dev, np, 0, NULL);
154cc24d587dd8 drivers/net/ethernet/ibm/emac/core.c Rosen Penev         2024-09-05  3052  	if (!dev->emacp) {
154cc24d587dd8 drivers/net/ethernet/ibm/emac/core.c Rosen Penev         2024-09-05  3053  		err = dev_err_probe(&ofdev->dev, -ENOMEM, "can't map device registers");
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23 @3054  		goto err_irq_unmap;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3055  	}
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3056  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3057  	/* Wait for dependent devices */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3058  	err = emac_wait_deps(dev);
b941327b6eb37f drivers/net/ethernet/ibm/emac/core.c Rosen Penev         2024-09-05  3059  	if (err)
154cc24d587dd8 drivers/net/ethernet/ibm/emac/core.c Rosen Penev         2024-09-05  3060  		goto err_irq_unmap;
bc353832565635 drivers/net/ethernet/ibm/emac/core.c Jingoo Han          2013-09-02  3061  	dev->mal = platform_get_drvdata(dev->mal_dev);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3062  	if (dev->mdio_dev != NULL)
bc353832565635 drivers/net/ethernet/ibm/emac/core.c Jingoo Han          2013-09-02  3063  		dev->mdio_instance = platform_get_drvdata(dev->mdio_dev);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3064  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3065  	/* Register with MAL */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3066  	dev->commac.ops = &emac_commac_ops;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3067  	dev->commac.dev = dev;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3068  	dev->commac.tx_chan_mask = MAL_CHAN_MASK(dev->mal_tx_chan);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3069  	dev->commac.rx_chan_mask = MAL_CHAN_MASK(dev->mal_rx_chan);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3070  	err = mal_register_commac(dev->mal, &dev->commac);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3071  	if (err) {
f7ce91038d5278 drivers/net/ethernet/ibm/emac/core.c Rob Herring         2017-07-18  3072  		printk(KERN_ERR "%pOF: failed to register with mal %pOF!\n",
f7ce91038d5278 drivers/net/ethernet/ibm/emac/core.c Rob Herring         2017-07-18  3073  		       np, dev->mal_dev->dev.of_node);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3074  		goto err_rel_deps;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3075  	}
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3076  	dev->rx_skb_size = emac_rx_skb_size(ndev->mtu);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3077  	dev->rx_sync_size = emac_rx_sync_size(ndev->mtu);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3078  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3079  	/* Get pointers to BD rings */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3080  	dev->tx_desc =
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3081  	    dev->mal->bd_virt + mal_tx_bd_offset(dev->mal, dev->mal_tx_chan);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3082  	dev->rx_desc =
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3083  	    dev->mal->bd_virt + mal_rx_bd_offset(dev->mal, dev->mal_rx_chan);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3084  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3085  	DBG(dev, "tx_desc %p" NL, dev->tx_desc);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3086  	DBG(dev, "rx_desc %p" NL, dev->rx_desc);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3087  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3088  	/* Clean rings */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3089  	memset(dev->tx_desc, 0, NUM_TX_BUFF * sizeof(struct mal_descriptor));
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3090  	memset(dev->rx_desc, 0, NUM_RX_BUFF * sizeof(struct mal_descriptor));
ab9b30cc3ec868 drivers/net/ibm_newemac/core.c       Sathya Narayanan    2008-07-01  3091  	memset(dev->tx_skb, 0, NUM_TX_BUFF * sizeof(struct sk_buff *));
ab9b30cc3ec868 drivers/net/ibm_newemac/core.c       Sathya Narayanan    2008-07-01  3092  	memset(dev->rx_skb, 0, NUM_RX_BUFF * sizeof(struct sk_buff *));
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3093  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3094  	/* Attach to ZMII, if needed */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3095  	if (emac_has_feature(dev, EMAC_FTR_HAS_ZMII) &&
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3096  	    (err = zmii_attach(dev->zmii_dev, dev->zmii_port, &dev->phy_mode)) != 0)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3097  		goto err_unreg_commac;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3098  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3099  	/* Attach to RGMII, if needed */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3100  	if (emac_has_feature(dev, EMAC_FTR_HAS_RGMII) &&
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3101  	    (err = rgmii_attach(dev->rgmii_dev, dev->rgmii_port, dev->phy_mode)) != 0)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3102  		goto err_detach_zmii;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3103  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3104  	/* Attach to TAH, if needed */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3105  	if (emac_has_feature(dev, EMAC_FTR_HAS_TAH) &&
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3106  	    (err = tah_attach(dev->tah_dev, dev->tah_port)) != 0)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3107  		goto err_detach_rgmii;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3108  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3109  	/* Set some link defaults before we can find out real parameters */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3110  	dev->phy.speed = SPEED_100;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3111  	dev->phy.duplex = DUPLEX_FULL;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3112  	dev->phy.autoneg = AUTONEG_DISABLE;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3113  	dev->phy.pause = dev->phy.asym_pause = 0;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3114  	dev->stop_timeout = STOP_TIMEOUT_100;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3115  	INIT_DELAYED_WORK(&dev->link_work, emac_link_timer);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3116  
ae5d33723e3253 drivers/net/ethernet/ibm/emac/core.c Duc Dang            2012-03-05  3117  	/* Some SoCs like APM821xx does not support Half Duplex mode. */
ae5d33723e3253 drivers/net/ethernet/ibm/emac/core.c Duc Dang            2012-03-05  3118  	if (emac_has_feature(dev, EMAC_FTR_APM821XX_NO_HALF_DUPLEX)) {
ae5d33723e3253 drivers/net/ethernet/ibm/emac/core.c Duc Dang            2012-03-05  3119  		dev->phy_feat_exc = (SUPPORTED_1000baseT_Half |
ae5d33723e3253 drivers/net/ethernet/ibm/emac/core.c Duc Dang            2012-03-05  3120  				     SUPPORTED_100baseT_Half |
ae5d33723e3253 drivers/net/ethernet/ibm/emac/core.c Duc Dang            2012-03-05  3121  				     SUPPORTED_10baseT_Half);
ae5d33723e3253 drivers/net/ethernet/ibm/emac/core.c Duc Dang            2012-03-05  3122  	}
ae5d33723e3253 drivers/net/ethernet/ibm/emac/core.c Duc Dang            2012-03-05  3123  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3124  	/* Find PHY if any */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3125  	err = emac_init_phy(dev);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3126  	if (err != 0)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3127  		goto err_detach_tah;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3128  
5e4011e2b8032c drivers/net/ibm_newemac/core.c       Michał Mirosław     2011-04-17  3129  	if (dev->tah_dev) {
5e4011e2b8032c drivers/net/ibm_newemac/core.c       Michał Mirosław     2011-04-17  3130  		ndev->hw_features = NETIF_F_IP_CSUM | NETIF_F_SG;
5e4011e2b8032c drivers/net/ibm_newemac/core.c       Michał Mirosław     2011-04-17  3131  		ndev->features |= ndev->hw_features | NETIF_F_RXCSUM;
5e4011e2b8032c drivers/net/ibm_newemac/core.c       Michał Mirosław     2011-04-17  3132  	}
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3133  	ndev->watchdog_timeo = 5 * HZ;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3134  	if (emac_phy_supports_gige(dev->phy_mode)) {
15efc02b2625f1 drivers/net/ibm_newemac/core.c       Alexander Beregalov 2009-04-09  3135  		ndev->netdev_ops = &emac_gige_netdev_ops;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3136  		dev->commac.ops = &emac_commac_sg_ops;
15efc02b2625f1 drivers/net/ibm_newemac/core.c       Alexander Beregalov 2009-04-09  3137  	} else
15efc02b2625f1 drivers/net/ibm_newemac/core.c       Alexander Beregalov 2009-04-09  3138  		ndev->netdev_ops = &emac_netdev_ops;
7ad24ea4bf620a drivers/net/ethernet/ibm/emac/core.c Wilfried Klaebe     2014-05-11  3139  	ndev->ethtool_ops = &emac_ethtool_ops;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3140  
3d5d96acfeb9dd drivers/net/ethernet/ibm/emac/core.c Jarod Wilson        2016-10-17  3141  	/* MTU range: 46 - 1500 or whatever is in OF */
3d5d96acfeb9dd drivers/net/ethernet/ibm/emac/core.c Jarod Wilson        2016-10-17  3142  	ndev->min_mtu = EMAC_MIN_MTU;
3d5d96acfeb9dd drivers/net/ethernet/ibm/emac/core.c Jarod Wilson        2016-10-17  3143  	ndev->max_mtu = dev->max_mtu;
3d5d96acfeb9dd drivers/net/ethernet/ibm/emac/core.c Jarod Wilson        2016-10-17  3144  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3145  	netif_carrier_off(ndev);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3146  
19245845d17958 drivers/net/ethernet/ibm/emac/core.c Rosen Penev         2024-09-05  3147  	err = devm_register_netdev(&ofdev->dev, ndev);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3148  	if (err) {
f7ce91038d5278 drivers/net/ethernet/ibm/emac/core.c Rob Herring         2017-07-18  3149  		printk(KERN_ERR "%pOF: failed to register net device (%d)!\n",
f7ce91038d5278 drivers/net/ethernet/ibm/emac/core.c Rob Herring         2017-07-18  3150  		       np, err);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3151  		goto err_detach_tah;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3152  	}
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3153  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3154  	/* Set our drvdata last as we don't want them visible until we are
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3155  	 * fully initialized
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3156  	 */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3157  	wmb();
bc353832565635 drivers/net/ethernet/ibm/emac/core.c Jingoo Han          2013-09-02  3158  	platform_set_drvdata(ofdev, dev);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3159  
f7ce91038d5278 drivers/net/ethernet/ibm/emac/core.c Rob Herring         2017-07-18  3160  	printk(KERN_INFO "%s: EMAC-%d %pOF, MAC %pM\n",
f7ce91038d5278 drivers/net/ethernet/ibm/emac/core.c Rob Herring         2017-07-18  3161  	       ndev->name, dev->cell_index, np, ndev->dev_addr);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3162  
78b69921a12568 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-12-20  3163  	if (dev->phy_mode == PHY_INTERFACE_MODE_SGMII)
9e3cb29497561c drivers/net/ibm_newemac/core.c       Victor Gallardo     2008-10-01  3164  		printk(KERN_NOTICE "%s: in SGMII mode\n", ndev->name);
9e3cb29497561c drivers/net/ibm_newemac/core.c       Victor Gallardo     2008-10-01  3165  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3166  	if (dev->phy.address >= 0)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3167  		printk("%s: found %s PHY (0x%02x)\n", ndev->name,
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3168  		       dev->phy.def->name, dev->phy.address);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3169  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3170  	/* Life is good */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3171  	return 0;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3172  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3173  	/* I have a bad feeling about this ... */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3174  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3175   err_detach_tah:
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3176  	if (emac_has_feature(dev, EMAC_FTR_HAS_TAH))
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3177  		tah_detach(dev->tah_dev, dev->tah_port);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3178   err_detach_rgmii:
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3179  	if (emac_has_feature(dev, EMAC_FTR_HAS_RGMII))
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3180  		rgmii_detach(dev->rgmii_dev, dev->rgmii_port);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3181   err_detach_zmii:
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3182  	if (emac_has_feature(dev, EMAC_FTR_HAS_ZMII))
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3183  		zmii_detach(dev->zmii_dev, dev->zmii_port);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3184   err_unreg_commac:
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3185  	mal_unregister_commac(dev->mal, &dev->commac);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3186   err_rel_deps:
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3187  	emac_put_deps(dev);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3188   err_gone:
b941327b6eb37f drivers/net/ethernet/ibm/emac/core.c Rosen Penev         2024-09-05  3189  	if (blist)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3190  		*blist = NULL;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3191  	return err;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3192  }
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  3193  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

