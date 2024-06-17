Return-Path: <netdev+bounces-103897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9AB90A18B
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 03:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD7E1C20F61
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 01:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51573522A;
	Mon, 17 Jun 2024 01:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ke/ofuJo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1BE33DD;
	Mon, 17 Jun 2024 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718586330; cv=none; b=QSnWRGAgppcTW1Ty//BOCOyqwoX1p/fJSXr3PQOF5ERAlj6vwu22DUOKQMC19slH4TCJ0C8o03TztZAiy64d3zBEZZX4tNDoAcD1Do7cnQ6lx9xkBpqQ08XDccaQJeZIuG28wY94f57Vcylrw/WmiVdnDsfvOof9moRH5m6v83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718586330; c=relaxed/simple;
	bh=qnCn82ABjmEXbcVD/7sbHxm944K/zrwaklVSgYdy8GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKe9PTZvxMvltCcdlhPWk2X3t3PFrt1VAAiK55KMNv33tznheRvHV3LnfmBb7Y+04G+ZaIMCrNkRVSfsnBzN5HbapP74nHI4rCwpTXSZRvYkjdg4xjTVrcdyjcL4ufaofT1ckShyThOWdU5KkIzD6szevAKFECWWUck9p62rVB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ke/ofuJo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718586329; x=1750122329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qnCn82ABjmEXbcVD/7sbHxm944K/zrwaklVSgYdy8GA=;
  b=Ke/ofuJoDzmVtx1KYFJDUT6TVv5bWHRQ7WZNxEEQzbo1TIr5LbeXQvgy
   462llbmpZsuqzWiOYZFsFSEaeVkHFb05NTx2bfrnFxSatoZqibepvPmor
   3qAShqicKJxRn0BNgyzoDpxQ3tA86YgktfUqwThwSO8CkJdjbv81Ngy2g
   2oGR5ywR5GQXAfXKv98rDSDEr4Fz5v/HrP/Re90e2s5r5VRpn52/MP4yC
   ZMYJevE0pDcfWnRXbMn1eZr7A6JMg99MREKguYrQcQhsy6awiv/eBdAGL
   dROzj9nWpGT6Okh/0apnZSB5ZFjhbWCD/n1aIcnQGOV0bYRBy6QFVyM6z
   w==;
X-CSE-ConnectionGUID: mT3+L60PSLaVsw5Ic792qg==
X-CSE-MsgGUID: D3nnOCjpQ8eTXG6IKdwiHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="12100298"
X-IronPort-AV: E=Sophos;i="6.08,243,1712646000"; 
   d="scan'208";a="12100298"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 18:05:28 -0700
X-CSE-ConnectionGUID: A63o/OJYSIW+malhA+HpBQ==
X-CSE-MsgGUID: Q5RBf2xVQieMKj4HVDC7+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,243,1712646000"; 
   d="scan'208";a="41155848"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 16 Jun 2024 18:05:24 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJ0oD-0003ZS-2x;
	Mon, 17 Jun 2024 01:05:21 +0000
Date: Mon, 17 Jun 2024 09:04:38 +0800
From: kernel test robot <lkp@intel.com>
To: Vanillan Wang <songjinjian@hotmail.com>,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Jinjian Song <jinjian.song@fibocom.com>
Subject: Re: [net-next v1] net: wwan: t7xx: Add debug port
Message-ID: <202406170854.MYWoYsla-lkp@intel.com>
References: <MEYP282MB269762C5070B97CD769C8CD5BBC22@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB269762C5070B97CD769C8CD5BBC22@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>

Hi Vanillan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vanillan-Wang/net-wwan-t7xx-Add-debug-port/20240614-175858
base:   net-next/main
patch link:    https://lore.kernel.org/r/MEYP282MB269762C5070B97CD769C8CD5BBC22%40MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
patch subject: [net-next v1] net: wwan: t7xx: Add debug port
config: x86_64-randconfig-161-20240617 (https://download.01.org/0day-ci/archive/20240617/202406170854.MYWoYsla-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406170854.MYWoYsla-lkp@intel.com/

smatch warnings:
drivers/net/wwan/t7xx/t7xx_port_debug.c:153 port_char_write() warn: unsigned 'txq_mtu' is never less than zero.

vim +/txq_mtu +153 drivers/net/wwan/t7xx/t7xx_port_debug.c

   132	
   133	static ssize_t port_char_write(struct file *file, const char __user *buf,
   134				       size_t count, loff_t *ppos)
   135	{
   136		unsigned int header_len = sizeof(struct ccci_header);
   137		size_t  offset, txq_mtu, chunk_len = 0;
   138		struct t7xx_port *port;
   139		struct sk_buff *skb;
   140		bool blocking;
   141		int ret;
   142	
   143		port = file->private_data;
   144	
   145		blocking = !(file->f_flags & O_NONBLOCK);
   146		if (!blocking)
   147			return -EAGAIN;
   148	
   149		if (!port->chan_enable)
   150			return -EINVAL;
   151	
   152		txq_mtu = t7xx_get_port_mtu(port);
 > 153		if (txq_mtu < 0)
   154			return -EINVAL;
   155	
   156		for (offset = 0; offset < count; offset += chunk_len) {
   157			chunk_len = min(count - offset, txq_mtu - header_len);
   158	
   159			skb = __dev_alloc_skb(chunk_len + header_len, GFP_KERNEL);
   160			if (!skb)
   161				return -ENOMEM;
   162	
   163			ret = copy_from_user(skb_put(skb, chunk_len), buf + offset, chunk_len);
   164	
   165			if (ret) {
   166				dev_kfree_skb(skb);
   167				return -EFAULT;
   168			}
   169	
   170			ret = t7xx_port_send_skb(port, skb, 0, 0);
   171			if (ret) {
   172				if (ret == -EBUSY && !blocking)
   173					ret = -EAGAIN;
   174				dev_kfree_skb_any(skb);
   175				return ret;
   176			}
   177		}
   178	
   179		return count;
   180	}
   181	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

