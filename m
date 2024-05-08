Return-Path: <netdev+bounces-94359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B805E8BF461
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48CB284993
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F26D9449;
	Wed,  8 May 2024 02:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JACDCQsO"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BED1A2C28;
	Wed,  8 May 2024 02:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715134657; cv=none; b=PGglbCrMmXFTlPFrvaPgGpt8xS0Q2SgcOpQYw+urLCW4Dohkif8S9SVu1edqsqADBqwq/ggzlMe7/1LDJdpXoYI9xRqi5Dsvyzgjcv0oYBDl2AgpQVIqAx6j7Kp+4Rz5tkP3yyZIqb/3GxS/OOOdR8gD8vFj/7reVONggtNBASQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715134657; c=relaxed/simple;
	bh=e4Skb1zcazTmbd2ABCs+2c3geMZFVDrf2HyBtVbfMEk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=W/CoiH/do7tzAoNAUKtnca7MR3M8OwV6uPVOfi5u2uO1k4JaRQBt7FcwC2JqVjfVA/aYSFVL7SygUGk9ScRtPovAdZ1KoIG8QqLKus7mjPHnFay810oF7ZhzsvBzrmzNc2slzYXGO5f2Zgs45NjwLtYH9iIpyKZ+BtQjafA9+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JACDCQsO; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715134646; h=Message-ID:Subject:Date:From:To;
	bh=3Ho4GaPz2hVraaqdqkPV5F+6+sh2fpR1POxYAhY84QE=;
	b=JACDCQsOMiunlo6EDkiMa4Yr9Cm5C3NA191JtMQJ6xrfyX01ANEm6aFKOfOtTOXvrL30+YFa9GB4DAqomKxTt5Fn4JnDMrxc4kpd+qHP0ZOicRNEFd7JdkNwRh10UV64lvXFyHCt59cupFlnLvL3qgds6WTiCJZrnAgbNGl71p8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0W61qTti_1715134643;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W61qTti_1715134643)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 10:17:24 +0800
Message-ID: <1715134355.2261543-3-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v12 0/4] ethtool: provide the dim profile fine-tuning channel
Date: Wed, 8 May 2024 10:12:35 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
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
 Simon Horman <horms@kernel.org>,
 virtualization@lists.linux.dev
References: <20240504064447.129622-1-hengqi@linux.alibaba.com>
In-Reply-To: <20240504064447.129622-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Sat,  4 May 2024 14:44:43 +0800, Heng Qi <hengqi@linux.alibaba.com> wrote:
> The NetDIM library provides excellent acceleration for many modern
> network cards. However, the default profiles of DIM limits its maximum
> capabilities for different NICs, so providing a way which the NIC can
> be custom configured is necessary.
> 
> Currently, the way is based on the commonly used "ethtool -C".
> 
> Please review, thank you very much!

Hi,

I would like to confirm if there are still comments on the current version,
since the current series and the just merged "Remove RTNL lock protection of
CVQ" conflict with a line of code with the fourth patch, if I can collect
other comments or ack/review tags, then release the new version seems better.

Thank you very much!

> 
> Changelog
> =====
> v11->v12:
>   - Remove the use of IS_ENABLED(DIMLIB).
>   - Update Simon's htmldoc hint.
> 
> v10->v11:
>   - Fix and clean up some issues from Kuba, thanks.
>   - Rebase net-next/main
> 
> v9->v10:
>   - Collect dim related flags/mode/work into one place.
>   - Use rx_profile + tx_profile instead of four profiles.
>   - Add several helps.
>   - Update commit logs.
> 
> v8->v9:
>   - Fix the compilation error of conflicting names of rx_profile in
>     dim.h and ice driver: in dim.h, rx_profile is replaced with
>     dim_rx_profile. So does tx_profile.
> 
> v7->v8:
>   - Use kmemdup() instead of kzalloc()/memcpy() in dev_dim_profile_init().
> 
> v6->v7:
>   - A new wrapper struct pointer is used in struct net_device.
>   - Add IS_ENABLED(CONFIG_DIMLIB) to avoid compiler warnings.
>   - Profile fields changed from u16 to u32.
> 
> v5->v6:
>   - Place the profile in netdevice to bypass the driver.
>     The interaction code of ethtool <-> kernel has not changed at all,
>     only the interaction part of kernel <-> driver has changed.
> 
> v4->v5:
>   - Update some snippets from Kuba.
> 
> v3->v4:
>   - Some tiny updates and patch 1 only add a new comment.
> 
> v2->v3:
>   - Break up the attributes to avoid the use of raw c structs.
>   - Use per-device profile instead of global profile in the driver.
> 
> v1->v2:
>   - Use ethtool tool instead of net-sysfs.
> 
> Heng Qi (4):
>   linux/dim: move useful macros to .h file
>   ethtool: provide customized dim profile management
>   dim: add new interfaces for initialization and getting results
>   virtio-net: support dim profile fine-tuning
> 
>  Documentation/netlink/specs/ethtool.yaml     |  31 +++
>  Documentation/networking/ethtool-netlink.rst |   4 +
>  drivers/net/virtio_net.c                     |  47 +++-
>  include/linux/dim.h                          | 114 ++++++++
>  include/linux/ethtool.h                      |   4 +-
>  include/linux/netdevice.h                    |   3 +
>  include/uapi/linux/ethtool_netlink.h         |  22 ++
>  lib/dim/net_dim.c                            | 145 ++++++++++-
>  net/ethtool/coalesce.c                       | 259 ++++++++++++++++++-
>  9 files changed, 613 insertions(+), 16 deletions(-)
> 
> -- 
> 2.32.0.3.g01195cf9f
> 
> 

