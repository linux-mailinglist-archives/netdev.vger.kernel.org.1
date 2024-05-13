Return-Path: <netdev+bounces-96089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 340248C448A
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6EB1B2308D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AB215444B;
	Mon, 13 May 2024 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tEddfsGU"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A2157CA7;
	Mon, 13 May 2024 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715615320; cv=none; b=EIaa7LbFphOadAPMWK4LtRVhxzHdqW4JwlmsUZSbxR/6EsBRzOyxyIGvV1xt+K6cl+yFHXCYTVoRjoDonORsZU9Ju5GmzJoBL66lsP/82Apo2+8h6pUgwETvE79I1ctKjru0+pSJ2X2NzdtbjPCRximSV8ekHmkJjUonscIbm+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715615320; c=relaxed/simple;
	bh=gh8KA2KzWI8NxNVRWgimB6DI6N3c8EurLnFVYb7mDwk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=SGS0qkS7+BUwY0YDkGSKVE0CyIP3BoZfusukPluMkSKYWy5X2myEw2OOr6YlSiyaO1xb2vxE1p1vWlDEigfpQYp73sGg8QT+IRD7DABxYrGPX2qm+6+7r4TUBxfzvjrkEyThCIvMfGt+0dalmqaJlv71uqdHktIIw9BbtdS77Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tEddfsGU; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715615313; h=Message-ID:Subject:Date:From:To;
	bh=7TO5SBq3O+tJBEl71UG4O3nzKZttyUTlMkzqET0RB8M=;
	b=tEddfsGULuYAKdGAWQoVy1QS8oNGKMZpFSKt6YkRxMINmILav5QVO9QHQ1kH+iqgvVmgaBrJIyPDFbAulh0CKq47UuK5UXARHHENq4c0lypfzUTTaGbFrai+0AbBrkYRBqNCgw6yC73HgVthzad4e98AG0cErLv3PprsbMlc2lc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0W6SNQzg_1715615309;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W6SNQzg_1715615309)
          by smtp.aliyun-inc.com;
          Mon, 13 May 2024 23:48:31 +0800
Message-ID: <1715614744.0497134-3-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v13 2/4] ethtool: provide customized dim profile management
Date: Mon, 13 May 2024 23:39:04 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kernel test robot <lkp@intel.com>,
 llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev,
 "David S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Jason   Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Brett   Creeley <bcreeley@amd.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tal Gilboa <talgi@nvidia.com>,
 Jonathan   Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Paul   Greenwalt <paul.greenwalt@intel.com>,
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
 <1715531818.6973832-3-hengqi@linux.alibaba.com>
 <20240513072249.7b0513b0@kernel.org>
 <1715611933.2264705-1-hengqi@linux.alibaba.com>
 <20240513082412.2a27f965@kernel.org>
In-Reply-To: <20240513082412.2a27f965@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 13 May 2024 08:24:12 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Mon, 13 May 2024 22:52:13 +0800 Heng Qi wrote:
> > > > So I think we should declare "CONFIG_PROVE_LOCKING depends on CONFIG_NET".
> > > > How do you think?  
> > > 
> > > Doesn't sound right, `can we instead make building lib/dim/net_dim.c  
> > 
> > Why? IIUC, the reason is that if CONFIG_NET is not set to Y, the net/core
> > directory will not be compiled, so the lockdep_rtnl_is_held symbol is not
> > present.
> 
> Maybe I don't understand what you;re proposing. 
> Show an actual diff please.

Like this:

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 291185f54ee4..fbb20d0d08c1 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1299,7 +1299,7 @@ config LOCK_DEBUGGING_SUPPORT

 config PROVE_LOCKING
        bool "Lock debugging: prove locking correctness"
-       depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
+       depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && NET
        select LOCKDEP
        select DEBUG_SPINLOCK
        select DEBUG_MUTEXES if !PREEMPT_RT


And there is:

In include/linux/rtnetlink.h:

#ifdef CONFIG_PROVE_LOCKING
extern bool lockdep_rtnl_is_held(void);
#else
static inline bool lockdep_rtnl_is_held(void)
{
        return true;
}
#endif /* #ifdef CONFIG_PROVE_LOCKING */


In net/core/rtnetlink.c:

#ifdef CONFIG_PROVE_LOCKING
bool lockdep_rtnl_is_held(void)
{
        return lockdep_is_held(&rtnl_mutex);
}
EXPORT_SYMBOL(lockdep_rtnl_is_held);
#endif /* #ifdef CONFIG_PROVE_LOCKING */

Thanks.

> 
> > > dependent on CONFIG_NET? Untested but I'm thinking something like:
> > > 
> > > diff --git a/lib/dim/Makefile b/lib/dim/Makefile
> > > index c4cc4026c451..c02c306e2975 100644
> > > --- a/lib/dim/Makefile
> > > +++ b/lib/dim/Makefile
> > > @@ -4,4 +4,8 @@
> > >  
> > >  obj-$(CONFIG_DIMLIB) += dimlib.o
> > >  
> > > -dimlib-objs := dim.o net_dim.o rdma_dim.o
> > > +dimlib-objs := dim.o rdma_dim.o
> > > +
> > > +ifeq ($(CONFIG_NET),y)
> > > +dimlib-objs += net_dim.o
> > > +endif  
> > 
> > 1. This is unlikely to work if the kernel is configured as[1]:
> > 
> > [1] kernel configuration
> > CONFIG_NET=n, CONFIG_ETHTOOL_NETLINK=n, CONFIG_PROVE_LOCKING=y,
> > (CONFIG_FSL_MC_DPIO=y && CONFIG_FSL_MC_BUS=y) select CONFIG_DIMLIB=y.
> > 
> > 
> > Then, because CONFIG_NET is not enabled, so there is no net_dim.o,
> > the following warning appears:
> > 
> > ld.lld: error: undefined symbol: net_dim_get_rx_moderation
> > referenced by dpio-service.c
> > drivers/soc/fsl/dpio/dpio-service.o:(dpaa2_io_dim_work) in archive vmlinux.a
> > 
> > ld.lld: error: undefined symbol: net_dim
> > referenced by dpio-service.c
> > drivers/soc/fsl/dpio/dpio-service.o:(dpaa2_io_update_net_dim) in archive vmlinux.a
> 
> Simple, dpio-service should depend on NET if it wants NET_DIM

