Return-Path: <netdev+bounces-95815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBDC8C3797
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 18:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BAD28123C
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 16:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ABD2F873;
	Sun, 12 May 2024 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ugrDOLiA"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0B042A8E;
	Sun, 12 May 2024 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715531945; cv=none; b=EgjOZNW5TKk6+jYww1SNtYna73nzM3haheVN6OukuY6luuje2T+fZBqmqz+gMUvyPU+4cTsnbXVBDPIClCuYOjJGBPVF2LdD1xA+qwo8Mh14BZSihbUH9Ga5KzH7t6SVEykxeNAin6umSBh/J45cOeQW38q/Ryt1xDbheGdvLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715531945; c=relaxed/simple;
	bh=IWReFbWnSG11vlPQ92I5R2T/g5Ucy9dLLkzpOWm7rMs=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=KKSFqEMpSEbinLNtwUN8AHN0TOCtQslN1KISUrIaWCuAT5ay2g0WtCJoTXjWFEmwg6FsUiNZhPrGFfRZPVsfDSbeV21FWiF1oKtDUYy8ecl/X3juZc1ZimVfwEBpd/E4rFZf1POka34dA5KMI29FREDtwxlbTPzGxZ9A+Szk0s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ugrDOLiA; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715531935; h=Message-ID:Subject:Date:From:To;
	bh=o40wkv9PATkuaNIfkNpU6m7tz6qpatklvvAUQQFo1aM=;
	b=ugrDOLiA2noYnrbZyOf7Y7XDMv7zW358TJQqBvpcVOSDgbpqZXvfK78KvlcoPLrk7ON+pEeNvqvN2Hjn/39ybMtsl03cEFMuY7MGtmTh2KWQPCues5OdirTMSPSLI8hUbRN/W/OJ2koZrBINIq9vz9q2Of0QX9+EHA3Jpq3kZO0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0W6FsCq4_1715531932;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W6FsCq4_1715531932)
          by smtp.aliyun-inc.com;
          Mon, 13 May 2024 00:38:53 +0800
Message-ID: <1715531818.6973832-3-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v13 2/4] ethtool: provide customized dim profile management
Date: Mon, 13 May 2024 00:36:58 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tal Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com,
 donald.hunter@gmail.com,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240509044747.101237-1-hengqi@linux.alibaba.com>
 <20240509044747.101237-3-hengqi@linux.alibaba.com>
 <202405100654.5PbLQXnL-lkp@intel.com>
In-Reply-To: <202405100654.5PbLQXnL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 10 May 2024 07:09:52 +0800, kernel test robot <lkp@intel.com> wrote:
> Hi Heng,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/linux-dim-move-useful-macros-to-h-file/20240509-125007
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20240509044747.101237-3-hengqi%40linux.alibaba.com
> patch subject: [PATCH net-next v13 2/4] ethtool: provide customized dim profile management
> config: arm-randconfig-002-20240510 (https://download.01.org/0day-ci/archive/20240510/202405100654.5PbLQXnL-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project b910bebc300dafb30569cecc3017b446ea8eafa0)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240510/202405100654.5PbLQXnL-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405100654.5PbLQXnL-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> ld.lld: error: undefined symbol: lockdep_rtnl_is_held

This failed use case seems to come from this series triggering a problem that
has not been triggered historically, namely lockdep_rtnl_is_held() is not called
in an environment where CONFIG_NET is not configured and CONFIG_PROVE_LOCKING is
configured:
  If CONFIG_PROVE_LOCKING is configured as Y and CONFIG_NET is n, then
  lockdep_rtnl_is_held is in an undefined state at this time.

So I think we should declare "CONFIG_PROVE_LOCKING depends on CONFIG_NET".
How do you think?

Thanks!

>    >>> referenced by net_dim.c
>    >>>               lib/dim/net_dim.o:(net_dim_free_irq_moder) in archive vmlinux.a
>    >>> referenced by net_dim.c
>    >>>               lib/dim/net_dim.o:(net_dim_free_irq_moder) in archive vmlinux.a
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

