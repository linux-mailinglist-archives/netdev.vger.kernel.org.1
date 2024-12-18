Return-Path: <netdev+bounces-153129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F709F6EE8
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 21:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C9416BB33
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 20:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1D11448F2;
	Wed, 18 Dec 2024 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AxrXHLEO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B481FC0EB
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 20:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734553650; cv=none; b=iPVGEuwQ5tToXJkKFfIhMpib/qErtvx39ZE2LmHZ9aFKPCieiMyiyHxU89FPhh/OPlWy2PKbgwRpcWZbhfqJ8G9y5qCTeDWTQSj6z39wnNgdqwydwRM4g9ppCBSQRW6/oElO5Zf5Jdp+WrUIWzuB34F+VzBwx0z67NxyrpJ8HbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734553650; c=relaxed/simple;
	bh=seDFSGPkM0L4X+D2x5te//8MHP/bA4Pl6AT03WkU9ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJ+TCOa4IKkrCa1FGWShwI4QNyxGCSnFOsh4Ex3G/Ehj3bd3+kqGFBLYGaY4ajBRBoy6FdDvQEqP4jMHQDGhIw/WW82pRhpV4muJVBSdDqPEffrB2kXEYTFBdmpfJMN2ZqMGXOI9EhC5lhZ3+DmdzsgPEeGHWpBJL/AD/rwClzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AxrXHLEO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734553648; x=1766089648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=seDFSGPkM0L4X+D2x5te//8MHP/bA4Pl6AT03WkU9ZM=;
  b=AxrXHLEO8AgizBWlezLBpttNY6D6xrRoJKf9oOBfbIgPJL4lstrdX4b/
   tBxEHYSTGJ67SnHXs5CHfk9x/0vD+t3KjtAQUKxyKuH+sYogJDGd9mRmz
   hyQoDXxthRLz2KboPpc0IG6Yhuf2CzbTuz1/vfyxCVYT4AAoo0Qidx5Hb
   VoRqzwzfY5WkTfDl6iYt4s0j7SWf2jvl11BHZhdX0WKXqMBPuFxkC4hi+
   jV/pcWjiCVc1vArOK17C8N61+z0ljs5/1hlSeUOwVo8iIzoH+bLJ71hkD
   3ThJ6hG8EcMBlO0aeEiXYxx9ClDowxtjkkmSEVQ5SaZ5YUC79gVONU3m2
   w==;
X-CSE-ConnectionGUID: kevAd29XToSiP1ZL8LkIwg==
X-CSE-MsgGUID: DXUObtiFQNG0rX9LClZnZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34770570"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="34770570"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 12:27:28 -0800
X-CSE-ConnectionGUID: s5ZeKC7aQVeanR0AyDa2Tg==
X-CSE-MsgGUID: TbDhLILxRZaf9ieNIMCZGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="98371568"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 18 Dec 2024 12:27:24 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tO0dd-000GcE-2z;
	Wed, 18 Dec 2024 20:27:21 +0000
Date: Thu, 19 Dec 2024 04:27:17 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, michael.chan@broadcom.com, tariqt@nvidia.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	jdamato@fastly.com, shayd@nvidia.com, akpm@linux-foundation.org,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 4/8] net: napi: add CPU
 affinity to napi->config
Message-ID: <202412190454.nwvp3hU2-lkp@intel.com>
References: <20241218165843.744647-5-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218165843.744647-5-ahmed.zaki@intel.com>

Hi Ahmed,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Zaki/net-napi-add-irq_flags-to-napi-struct/20241219-010125
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241218165843.744647-5-ahmed.zaki%40intel.com
patch subject: [Intel-wired-lan] [PATCH net-next v2 4/8] net: napi: add CPU affinity to napi->config
config: riscv-randconfig-001-20241219 (https://download.01.org/0day-ci/archive/20241219/202412190454.nwvp3hU2-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241219/202412190454.nwvp3hU2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412190454.nwvp3hU2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/core/dev.c:6755:7: warning: variable 'glue_created' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
                   if (rc) {
                       ^~
   net/core/dev.c:6766:7: note: uninitialized use occurs here
           if (!glue_created && flags & NAPIF_IRQ_AFFINITY) {
                ^~~~~~~~~~~~
   net/core/dev.c:6755:3: note: remove the 'if' if its condition is always false
                   if (rc) {
                   ^~~~~~~~~
>> net/core/dev.c:6752:6: warning: variable 'glue_created' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (napi->dev->rx_cpu_rmap && flags & NAPIF_IRQ_ARFS_RMAP) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:6766:7: note: uninitialized use occurs here
           if (!glue_created && flags & NAPIF_IRQ_AFFINITY) {
                ^~~~~~~~~~~~
   net/core/dev.c:6752:2: note: remove the 'if' if its condition is always true
           if (napi->dev->rx_cpu_rmap && flags & NAPIF_IRQ_ARFS_RMAP) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/core/dev.c:6752:6: warning: variable 'glue_created' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
           if (napi->dev->rx_cpu_rmap && flags & NAPIF_IRQ_ARFS_RMAP) {
               ^~~~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:6766:7: note: uninitialized use occurs here
           if (!glue_created && flags & NAPIF_IRQ_AFFINITY) {
                ^~~~~~~~~~~~
   net/core/dev.c:6752:6: note: remove the '&&' if its condition is always true
           if (napi->dev->rx_cpu_rmap && flags & NAPIF_IRQ_ARFS_RMAP) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:6745:19: note: initialize the variable 'glue_created' to silence this warning
           bool glue_created;
                            ^
                             = 0
   net/core/dev.c:4176:1: warning: unused function 'sch_handle_ingress' [-Wunused-function]
   sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
   ^
   net/core/dev.c:4183:1: warning: unused function 'sch_handle_egress' [-Wunused-function]
   sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
   ^
   net/core/dev.c:5440:19: warning: unused function 'nf_ingress' [-Wunused-function]
   static inline int nf_ingress(struct sk_buff *skb, struct packet_type **pt_prev,
                     ^
   6 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for FB_IOMEM_HELPERS
   Depends on [n]: HAS_IOMEM [=y] && FB_CORE [=n]
   Selected by [m]:
   - DRM_XE_DISPLAY [=y] && HAS_IOMEM [=y] && DRM [=m] && DRM_XE [=m] && DRM_XE [=m]=m [=m] && HAS_IOPORT [=y]


vim +6755 net/core/dev.c

8e5191fb19bffce Ahmed Zaki 2024-12-18  6741  
001dc6db21f4bfe Ahmed Zaki 2024-12-18  6742  void netif_napi_set_irq(struct napi_struct *napi, int irq, unsigned long flags)
001dc6db21f4bfe Ahmed Zaki 2024-12-18  6743  {
8e5191fb19bffce Ahmed Zaki 2024-12-18  6744  	struct irq_glue *glue = NULL;
8e5191fb19bffce Ahmed Zaki 2024-12-18  6745  	bool glue_created;
a274d2669a73ef7 Ahmed Zaki 2024-12-18  6746  	int  rc;
a274d2669a73ef7 Ahmed Zaki 2024-12-18  6747  
001dc6db21f4bfe Ahmed Zaki 2024-12-18  6748  	napi->irq = irq;
001dc6db21f4bfe Ahmed Zaki 2024-12-18  6749  	napi->irq_flags = flags;
a274d2669a73ef7 Ahmed Zaki 2024-12-18  6750  
a274d2669a73ef7 Ahmed Zaki 2024-12-18  6751  #ifdef CONFIG_RFS_ACCEL
a274d2669a73ef7 Ahmed Zaki 2024-12-18 @6752  	if (napi->dev->rx_cpu_rmap && flags & NAPIF_IRQ_ARFS_RMAP) {
8e5191fb19bffce Ahmed Zaki 2024-12-18  6753  		rc = irq_cpu_rmap_add(napi->dev->rx_cpu_rmap, irq, napi,
8e5191fb19bffce Ahmed Zaki 2024-12-18  6754  				      netif_irq_cpu_rmap_notify);
a274d2669a73ef7 Ahmed Zaki 2024-12-18 @6755  		if (rc) {
a274d2669a73ef7 Ahmed Zaki 2024-12-18  6756  			netdev_warn(napi->dev, "Unable to update ARFS map (%d).\n",
a274d2669a73ef7 Ahmed Zaki 2024-12-18  6757  				    rc);
a274d2669a73ef7 Ahmed Zaki 2024-12-18  6758  			free_irq_cpu_rmap(napi->dev->rx_cpu_rmap);
a274d2669a73ef7 Ahmed Zaki 2024-12-18  6759  			napi->dev->rx_cpu_rmap = NULL;
8e5191fb19bffce Ahmed Zaki 2024-12-18  6760  		} else {
8e5191fb19bffce Ahmed Zaki 2024-12-18  6761  			glue_created = true;
a274d2669a73ef7 Ahmed Zaki 2024-12-18  6762  		}
a274d2669a73ef7 Ahmed Zaki 2024-12-18  6763  	}
a274d2669a73ef7 Ahmed Zaki 2024-12-18  6764  #endif
8e5191fb19bffce Ahmed Zaki 2024-12-18  6765  
8e5191fb19bffce Ahmed Zaki 2024-12-18  6766  	if (!glue_created && flags & NAPIF_IRQ_AFFINITY) {
8e5191fb19bffce Ahmed Zaki 2024-12-18  6767  		glue = kzalloc(sizeof(*glue), GFP_KERNEL);
8e5191fb19bffce Ahmed Zaki 2024-12-18  6768  		if (!glue)
8e5191fb19bffce Ahmed Zaki 2024-12-18  6769  			return;
8e5191fb19bffce Ahmed Zaki 2024-12-18  6770  		glue->notify.notify = netif_irq_cpu_rmap_notify;
8e5191fb19bffce Ahmed Zaki 2024-12-18  6771  		glue->notify.release = netif_napi_affinity_release;
8e5191fb19bffce Ahmed Zaki 2024-12-18  6772  		glue->data = napi;
8e5191fb19bffce Ahmed Zaki 2024-12-18  6773  		glue->rmap = NULL;
8e5191fb19bffce Ahmed Zaki 2024-12-18  6774  		napi->irq_flags |= NAPIF_IRQ_NORMAP;
8e5191fb19bffce Ahmed Zaki 2024-12-18  6775  	}
001dc6db21f4bfe Ahmed Zaki 2024-12-18  6776  }
001dc6db21f4bfe Ahmed Zaki 2024-12-18  6777  EXPORT_SYMBOL(netif_napi_set_irq);
001dc6db21f4bfe Ahmed Zaki 2024-12-18  6778  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

