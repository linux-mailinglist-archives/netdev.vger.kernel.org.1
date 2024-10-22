Return-Path: <netdev+bounces-137700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E099A9628
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 04:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEFD0B21427
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 02:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F91012FF9C;
	Tue, 22 Oct 2024 02:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fp+WX3h3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1E61EB31;
	Tue, 22 Oct 2024 02:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729563552; cv=none; b=WgK+fggWWw7UFfcZcmj8Tjaze/9Rgta890SexOgh18gtarN3X/6nj0iVwi6fJortu7vOMNFTvd34d3Q6MUS0+iVLtj4i6KW7F6ihTBq+LNCtQd22ZstN+8MRKtx7UYVeqilQP3Wad5Qh3DF+9h97SiEjaR7gPR7OlEXg3uCFbJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729563552; c=relaxed/simple;
	bh=kuiaS1pD3f/ZDS7KrE8bkSfwA54/4xI1cHqQYECjNaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpDichY8sTknNXIvWETKF5YGdAG/7ZN4yhrPtp6NNvJZQDPB6dB/q0MO+vie0pwfLKw6U7yMrY11TFWPp1psHC4Mqlt2NjmBEcKsPlyv1SJekNtK1aIQ4WFaokk027L90oo7GN/Sw0sh8qaYYDIuQRVg44zgd/j5wrx/miw1DKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fp+WX3h3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729563550; x=1761099550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kuiaS1pD3f/ZDS7KrE8bkSfwA54/4xI1cHqQYECjNaI=;
  b=fp+WX3h3pgAObOiRMFOYxdVVnhORmxwpRzS/e0SubjXtx51PlOKAddsu
   GTpc2vx+xp0tPzMOc2EfRfsnvZd7CQ5yqpf5Hu25kvLSzD/t6otSb1MTf
   AC3l7NHXw5YowzjtuR3T/+JIuXijIukP8hUUflPG1kvkDRDsn0/VvJFhU
   /0xJsKJMoDomyOOA1lzV9NKfgHwZRbYoKS4qNUuqvHeb/+dLJ/ZNwz9bP
   UyuJ+iQ4tzsM06nC9b+Ac2hz27jJye9LLi19mjcs7tFsGSmHpfGEJT9Y/
   OH+FgcFTwi31QJSA1LqBGQwCMx7dkRIBslh3NZe3jVyP07/3DX4J8gWEd
   A==;
X-CSE-ConnectionGUID: Fh3iweLOTTK7yyHOiOrhyg==
X-CSE-MsgGUID: 4RsLLM7JQrWGvMLDHEMD4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="39660256"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="39660256"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 19:19:10 -0700
X-CSE-ConnectionGUID: bhC2JcuDTJiODinbPQkcOw==
X-CSE-MsgGUID: BQ6ytSXfSH6ufQrG9CC42w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="84784626"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 21 Oct 2024 19:19:07 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t34UC-000Svi-1Y;
	Tue, 22 Oct 2024 02:19:04 +0000
Date: Tue, 22 Oct 2024 10:18:35 +0800
From: kernel test robot <lkp@intel.com>
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linus Walleij <linus.walleij@linaro.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: dsa: vsc73xx: implement packet
 reception via control interface
Message-ID: <202410220908.uFiUPMGy-lkp@intel.com>
References: <20241020205452.2660042-2-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020205452.2660042-2-paweldembicki@gmail.com>

Hi Pawel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Pawel-Dembicki/net-dsa-vsc73xx-implement-packet-reception-via-control-interface/20241021-050041
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241020205452.2660042-2-paweldembicki%40gmail.com
patch subject: [PATCH net-next 2/3] net: dsa: vsc73xx: implement packet reception via control interface
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241022/202410220908.uFiUPMGy-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241022/202410220908.uFiUPMGy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410220908.uFiUPMGy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/vitesse-vsc73xx-core.c:935:30: warning: variable 'len' is uninitialized when used here [-Wuninitialized]
     935 |         skb = netdev_alloc_skb(dev, len);
         |                                     ^~~
   drivers/net/dsa/vitesse-vsc73xx-core.c:885:23: note: initialize the variable 'len' to silence this warning
     885 |         int ret, buf_len, len, part;
         |                              ^
         |                               = 0
   1 warning generated.


vim +/len +935 drivers/net/dsa/vitesse-vsc73xx-core.c

   879	
   880	static void vsc73xx_polled_rcv(struct kthread_work *work)
   881	{
   882		struct vsc73xx *vsc = container_of(work, struct vsc73xx, dwork.work);
   883		u16 ptr = VSC73XX_CAPT_FRAME_DATA;
   884		struct dsa_switch *ds = vsc->ds;
   885		int ret, buf_len, len, part;
   886		struct vsc73xx_ifh ifh;
   887		struct net_device *dev;
   888		struct dsa_port *dp;
   889		struct sk_buff *skb;
   890		u32 val, *buf;
   891		u16 count;
   892	
   893		ret = vsc73xx_read(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_CAPCTRL, &val);
   894		if (ret)
   895			goto queue;
   896	
   897		if (!(val & VSC73XX_CAPCTRL_QUEUE0_READY))
   898			/* No frame to read */
   899			goto queue;
   900	
   901		/* Initialise reading */
   902		ret = vsc73xx_read(vsc, VSC73XX_BLOCK_CAPTURE, VSC73XX_BLOCK_CAPT_Q0,
   903				   VSC73XX_CAPT_CAPREADP, &val);
   904		if (ret)
   905			goto queue;
   906	
   907		/* Get internal frame header */
   908		ret = vsc73xx_read(vsc, VSC73XX_BLOCK_CAPTURE,
   909				   VSC73XX_BLOCK_CAPT_FRAME0, ptr++, &ifh.datah);
   910		if (ret)
   911			goto queue;
   912	
   913		ret = vsc73xx_read(vsc, VSC73XX_BLOCK_CAPTURE,
   914				   VSC73XX_BLOCK_CAPT_FRAME0, ptr++, &ifh.datal);
   915		if (ret)
   916			goto queue;
   917	
   918		if (ifh.magic != VSC73XX_IFH_MAGIC) {
   919			/* Something goes wrong with buffer. Reset capture block */
   920			vsc73xx_write(vsc, VSC73XX_BLOCK_CAPTURE,
   921				      VSC73XX_BLOCK_CAPT_RST, VSC73XX_CAPT_CAPRST, 1);
   922			goto queue;
   923		}
   924	
   925		if (!dsa_is_user_port(ds, ifh.port))
   926			goto release_frame;
   927	
   928		dp = dsa_to_port(ds, ifh.port);
   929		dev = dp->user;
   930		if (!dev)
   931			goto release_frame;
   932	
   933		count = (ifh.frame_length + 7 + VSC73XX_IFH_SIZE - ETH_FCS_LEN) >> 2;
   934	
 > 935		skb = netdev_alloc_skb(dev, len);
   936		if (unlikely(!skb)) {
   937			netdev_err(dev, "Unable to allocate sk_buff\n");
   938			goto release_frame;
   939		}
   940	
   941		buf_len = ifh.frame_length - ETH_FCS_LEN;
   942		buf = (u32 *)skb_put(skb, buf_len);
   943		len = 0;
   944		part = 0;
   945	
   946		while (ptr < count) {
   947			ret = vsc73xx_read(vsc, VSC73XX_BLOCK_CAPTURE,
   948					   VSC73XX_BLOCK_CAPT_FRAME0 + part, ptr++,
   949					   buf + len);
   950			if (ret)
   951				goto free_skb;
   952			len++;
   953			if (ptr > VSC73XX_CAPT_FRAME_DATA_MAX &&
   954			    count != VSC73XX_CAPT_FRAME_DATA_MAX) {
   955				ptr = VSC73XX_CAPT_FRAME_DATA;
   956				part++;
   957				count -= VSC73XX_CAPT_FRAME_DATA_MAX;
   958			}
   959		}
   960	
   961		/* Get FCS */
   962		ret = vsc73xx_read(vsc, VSC73XX_BLOCK_CAPTURE,
   963				   VSC73XX_BLOCK_CAPT_FRAME0, ptr++, &val);
   964		if (ret)
   965			goto free_skb;
   966	
   967		/* Everything we see on an interface that is in the HW bridge
   968		 * has already been forwarded.
   969		 */
   970		if (dp->bridge)
   971			skb->offload_fwd_mark = 1;
   972	
   973		skb->protocol = eth_type_trans(skb, dev);
   974	
   975		netif_rx(skb);
   976		goto release_frame;
   977	
   978	free_skb:
   979		kfree_skb(skb);
   980	release_frame:
   981		/* Release the frame from internal buffer */
   982		vsc73xx_write(vsc, VSC73XX_BLOCK_CAPTURE, VSC73XX_BLOCK_CAPT_Q0,
   983			      VSC73XX_CAPT_CAPREADP, 0);
   984	queue:
   985		kthread_queue_delayed_work(vsc->rcv_worker, &vsc->dwork,
   986					   msecs_to_jiffies(VSC73XX_RCV_POLL_INTERVAL));
   987	}
   988	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

