Return-Path: <netdev+bounces-96080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B1B8C43C8
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 213D7B23AE1
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F7657C90;
	Mon, 13 May 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GVsoPJyZ"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F331DA20;
	Mon, 13 May 2024 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612813; cv=none; b=jNdv42ldzFOgtHA+B9bCxYJrPa0UKUuMKRdeRNcMNGiMsw7tk65Zs9MzTXq8JcoNZCKGq7bh4g5p+xGJXhDO/w4D1Pf2X4TAskQLDknwS4UCt8Q72OrmHTmQdkiLKp1NKcZACHJBxXFKhKZgH77x3/XYtDqZx+pqAFu8sKQvwPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612813; c=relaxed/simple;
	bh=y609Cc4cYkc6pEsR0kIAiOhx1xZxh+tw/aoYwkH85eA=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=dWoz/ZYlILZzGZpw8Hc7OFDROANjSUlPxMgFnE3dO1p+W5CkQTi8ZPZ6VD4BifKv+38Oxf7oqECok9mczN3uuPyTFtt7x01GCYp+trNgTKcBe2s2EEXxWiVex94jqVuXNEqGralOsNcmT//YZsOe0OnCoa+0uOGLu/UNPN6gXHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GVsoPJyZ; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715612807; h=Message-ID:Subject:Date:From:To;
	bh=7MLM12E9blsRkdX77DqwhU+UpqcO9mhaNTsXw3y52Tg=;
	b=GVsoPJyZU3B2Qm29UOkY+c4bj3bTNuNIQATHBg/apPbgDaRfmqjs3JSNywvvRGz6O4vW9WyGIm25nODVa3i1Rt/kQhxTg0yRqvEjHu5znM4NmJmH8qJ+WTfeJs8Fgwd6ZPZt3o4eSTjtwkribgm5Nv1Cc3Xe4Gy1kl7EJzeAiGI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0W6SIWe7_1715612804;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W6SIWe7_1715612804)
          by smtp.aliyun-inc.com;
          Mon, 13 May 2024 23:06:45 +0800
Message-ID: <1715611933.2264705-1-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v13 2/4] ethtool: provide customized dim profile management
Date: Mon, 13 May 2024 22:52:13 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kernel test robot <lkp@intel.com>,
 llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev,
 "David S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Jason  Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Brett  Creeley <bcreeley@amd.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tal Gilboa <talgi@nvidia.com>,
 Jonathan  Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Paul  Greenwalt <paul.greenwalt@intel.com>,
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
In-Reply-To: <20240513072249.7b0513b0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 13 May 2024 07:22:49 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Mon, 13 May 2024 00:36:58 +0800 Heng Qi wrote:
> > This failed use case seems to come from this series triggering a problem that
> > has not been triggered historically, namely lockdep_rtnl_is_held() is not called
> > in an environment where CONFIG_NET is not configured and CONFIG_PROVE_LOCKING is
> > configured:
> >   If CONFIG_PROVE_LOCKING is configured as Y and CONFIG_NET is n, then
> >   lockdep_rtnl_is_held is in an undefined state at this time.
> > 
> > So I think we should declare "CONFIG_PROVE_LOCKING depends on CONFIG_NET".
> > How do you think?
> 
> Doesn't sound right, `can we instead make building lib/dim/net_dim.c

Why? IIUC, the reason is that if CONFIG_NET is not set to Y, the net/core
directory will not be compiled, so the lockdep_rtnl_is_held symbol is not
present.

> dependent on CONFIG_NET? Untested but I'm thinking something like:
> 
> diff --git a/lib/dim/Makefile b/lib/dim/Makefile
> index c4cc4026c451..c02c306e2975 100644
> --- a/lib/dim/Makefile
> +++ b/lib/dim/Makefile
> @@ -4,4 +4,8 @@
>  
>  obj-$(CONFIG_DIMLIB) += dimlib.o
>  
> -dimlib-objs := dim.o net_dim.o rdma_dim.o
> +dimlib-objs := dim.o rdma_dim.o
> +
> +ifeq ($(CONFIG_NET),y)
> +dimlib-objs += net_dim.o
> +endif

1. This is unlikely to work if the kernel is configured as[1]:

[1] kernel configuration
CONFIG_NET=n, CONFIG_ETHTOOL_NETLINK=n, CONFIG_PROVE_LOCKING=y,
(CONFIG_FSL_MC_DPIO=y && CONFIG_FSL_MC_BUS=y) select CONFIG_DIMLIB=y.


Then, because CONFIG_NET is not enabled, so there is no net_dim.o,
the following warning appears:

ld.lld: error: undefined symbol: net_dim_get_rx_moderation
referenced by dpio-service.c
drivers/soc/fsl/dpio/dpio-service.o:(dpaa2_io_dim_work) in archive vmlinux.a

ld.lld: error: undefined symbol: net_dim
referenced by dpio-service.c
drivers/soc/fsl/dpio/dpio-service.o:(dpaa2_io_update_net_dim) in archive vmlinux.a

2. If we declare "CONFIG_DIMLIB depends on CONFIG_NET",
if the configuration is still [1]:
Then the result is:
CONFIG_DIMLIB=Y (selected by CONFIG_FSL_MC_DPIO=y && CONFIG_FSL_MC_BUS=y),
CONFIG_NET=n, but we declared "CONFIG_DIMLIB depends on CONFIG_NET",
there is still a compilation error because the lockdep_rtnl_is_held symbol
cannot be found.

3. If we declare "CONFIG_DIMLIB select CONFIG_NET" and kernel configuration is [1],
then a circular dependency warning will appear:

CONFIG_DIMLIB select CONFIG_NET, ETHTOOL_NETLINK=Y(depends on CONFIG_NET)
selects CONFIG_DIMLIB. CONFIG_DIMLIB will select CONFIG_NET...

> 
> 

