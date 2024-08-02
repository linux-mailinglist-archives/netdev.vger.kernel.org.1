Return-Path: <netdev+bounces-115433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CE09465E2
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 00:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD2F281516
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 22:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92790130A5C;
	Fri,  2 Aug 2024 22:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpoIgNLT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F7F1757D
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722637491; cv=none; b=PYpV7xq+rEr7GdMIgK/7BovOnL+7jDyQG+hESHr55pyI4C7kCRx39ckiUV1ik1NGQXqgipHA4o59CFR/y1gLgaZv2coG6oKgC0F1XdYG3TximAKB1jujvpTFVGC53mAjQsJpzBsvk1rZUVmaCfDkpc+DjK+8QpZT6zOQS4eZcX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722637491; c=relaxed/simple;
	bh=CwFj2BTTeV2viZrF++qumJ3j9hhSoclroxHUHO/9NIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iD5/pWwGqBADlkfavJDXFQrL5mRTJzhaeQE7UpKNUlFIxXd8ReadC2ZtMlK59KuwzY1lO50PQpKD2WfCWf+5uN/4kOTnopRTqSapFUQQF2/o+1lL9lweO3W66q0ZZ9MrrxjMWr1Ri/zpeZBmVEYyZoHerBiRV8rd92JkYBvb7uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gpoIgNLT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722637490; x=1754173490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CwFj2BTTeV2viZrF++qumJ3j9hhSoclroxHUHO/9NIE=;
  b=gpoIgNLT5uaUT4LWCP4f1uMw7CPcAKJv02yG4uhz6a4tgFrzkkjxYNYv
   G0xuATNqlpNYA0ODacJ82ucLAWCIiodTSMAjTW5dYllWbw9NbKH8Lasev
   Sz3fQVyVqEQw4e9M4WMRYFEk5xT+Yppw4ST7QzeqqSChpTnwH6F6xiS24
   2UHJA4E51dGvdERNIUPpqrEL2vunQ7QrSTqNaa0TGv9dRNf+2sA96Qzy5
   UpxBfG9n3iNpu8zGNf2514Ekz9UT8PwJ/m3n+dZxgjx99MfRruzvu3ppQ
   RWC/8pQtIJMho/16egEMvzwIkuiaHbvWWKt/XKoy1sLEMEKXTPkaKL1Aa
   w==;
X-CSE-ConnectionGUID: VhShy0j9S4+xuwX/7FnbeA==
X-CSE-MsgGUID: EV7vzW0VTSqKglJk+JBAzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20344464"
X-IronPort-AV: E=Sophos;i="6.09,259,1716274800"; 
   d="scan'208";a="20344464"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 15:24:49 -0700
X-CSE-ConnectionGUID: pG6BUJZ7Sc2R1qQoiEngRg==
X-CSE-MsgGUID: 7zSmFYD+SNi4BrTK1Ru0qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,259,1716274800"; 
   d="scan'208";a="55219901"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 02 Aug 2024 15:24:48 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sa0ha-000xVC-01;
	Fri, 02 Aug 2024 22:24:46 +0000
Date: Sat, 3 Aug 2024 06:24:05 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org
Cc: oe-kbuild-all@lists.linux.dev,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@chopps.org>
Subject: Re: [PATCH ipsec-next v7 08/16] xfrm: iptfs: add user packet (tunnel
 ingress) handling
Message-ID: <202408030653.77rcVK4C-lkp@intel.com>
References: <20240801080314.169715-9-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801080314.169715-9-chopps@chopps.org>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on klassert-ipsec-next/master]
[also build test WARNING on netfilter-nf/main linus/master v6.11-rc1 next-20240802]
[cannot apply to klassert-ipsec/master nf-next/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Hopps/xfrm-config-add-CONFIG_XFRM_IPTFS/20240802-185628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/20240801080314.169715-9-chopps%40chopps.org
patch subject: [PATCH ipsec-next v7 08/16] xfrm: iptfs: add user packet (tunnel ingress) handling
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240803/202408030653.77rcVK4C-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240803/202408030653.77rcVK4C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408030653.77rcVK4C-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/xfrm/xfrm_iptfs.c:32: warning: bad line: 
>> net/xfrm/xfrm_iptfs.c:41: warning: expecting prototype for IP(). Prototype was for IPTFS_DEFAULT_INIT_DELAY_USECS() instead


vim +41 net/xfrm/xfrm_iptfs.c

    21	
    22	/**
    23	 * IP-TFS default SA values (tunnel ingress/dir-out)
    24	 *
    25	 * IPTFS_DEFAULT_INIT_DELAY_USECS
    26	 *        The default IPTFS initial output delay in microseconds. The initial
    27	 *        output delay is the amount of time prior to servicing the output queue
    28	 *        after queueing the first packet on said queue. This applies anytime
    29	 *        the output queue was previously empty.
    30	 *
    31	 *        Default 0.
    32	
    33	 * IPTFS_DEFAULT_MAX_QUEUE_SIZE
    34	 *        The default IPTFS max output queue size in octets. The output queue is
    35	 *        where received packets destined for output over an IPTFS tunnel are
    36	 *        stored prior to being output in aggregated/fragmented form over the
    37	 *        IPTFS tunnel.
    38	 *
    39	 *        Default 1M.
    40	 */
  > 41	#define IPTFS_DEFAULT_INIT_DELAY_USECS	(0ull) /* no initial delay */
    42	#define IPTFS_DEFAULT_MAX_QUEUE_SIZE	(1024 * 10240) /* 1MB */
    43	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

