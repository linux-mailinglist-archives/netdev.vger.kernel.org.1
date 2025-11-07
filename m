Return-Path: <netdev+bounces-236651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3A6C3E8D0
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 06:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EEF04E02FD
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 05:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350972777E4;
	Fri,  7 Nov 2025 05:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uibyylCJ"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BA6212566
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 05:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762494728; cv=none; b=CMkC2ymvKurSi7SyUMHGCWKjh/alS0mwWfiOlGuxtoC/5dewVG8S0+vveRbAuD5rwjZrBKyHaSW13FqN20qZOcBjbQp6DxXm0hy957BQY8UUQN2wmd6du1CrKmG2IqA6zA5V6LNjbcDE5OjCRVc9sQGBuUhQq2qFI0VxRYLz3tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762494728; c=relaxed/simple;
	bh=zATTh3007jZ3WUY606XE6nGdSSubeK/weZPqPmy/J6w=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=qLSJkja0mq444+W3jlHKQgBiq6XFKCvkwg1Ih7fXkdDrlWdn3LahCcKosSpiW+1M0gIbKu8tGgrA9B1/FO41KeTRCGorU/YXdvwgmZaJJDX3KkmwK55/2Qzz0gg2PPZprz9Nb4kVH5q1JAt+cHTgVk4u1lp22lJnFTNyq4IlU70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uibyylCJ; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762494723; h=Message-ID:Subject:Date:From:To;
	bh=BQ3A90KJM5qOnd5K7/1M5rGjSmpJTnc62ffLuFtr498=;
	b=uibyylCJ+xHj7peolJ2L7ZHdeUfvbOrWOjBjUovqDzxm20G7VLqtI/b5WdoLhHS3H6HGRA4pi1IXqifSKBEmA4+MsaIK7GBBm0FaKX8IAabNktbM8ISpmNRCX7UzdPpJq5uFHDmKktF/FbxgjinRBPKhKztO+WNJ8JxgEKZXnsY=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrroMT8_1762494721 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Nov 2025 13:52:02 +0800
Message-ID: <1762494610.3233118-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v11 0/5] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Fri, 7 Nov 2025 13:50:10 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Dust Li <dust.li@linux.alibaba.com>,
 netdev@vger.kernel.org
References: <20251107054650.11532-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20251107054650.11532-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Please ignore this.

On Fri,  7 Nov 2025 13:46:45 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> Add a driver framework for EEA that will be available in the future.
>
> This driver is currently quite minimal, implementing only fundamental
> core functionalities. Key features include: I/O queue management via
> adminq, basic PCI-layer operations, and essential RX/TX data
> communication capabilities. It also supports the creation,
> initialization, and management of network devices (netdev). Furthermore,
> the ring structures for both I/O queues and adminq have been abstracted
> into a simple, unified, and reusable library implementation,
> facilitating future extension and maintenance.
>
> v11:
>     1. remove auto clean __free(kfree)
>     2. some tiny fixes
>
> v10:
>     1. name the jump labels after the target @Jakub
>     2. rm __GFP_ZERO from dma_alloc_coherent @Jakub
> v9:
>     1. some fixes for ethtool from http://lore.kernel.org/all/20251027183754.52fe2a2c@kernel.org
> v8: 1. rename eea_net_tmp to eea_net_init_ctx
>     2. rm code that allocs memory to destroy queues
>     3. some other minor changes
> v7: 1. remove the irrelative code from ethtool commit
>     2. build every commits with W12
> v6: Split the big one commit to five commits
> v5: Thanks for the comments from Kalesh Anakkur Purayil, ALOK TIWARI
> v4: Thanks for the comments from Troy Mitchell, Przemek Kitszel, Andrew Lunn, Kalesh Anakkur Purayil
> v3: Thanks for the comments from Paolo Abenchi
> v2: Thanks for the comments from Simon Horman and Andrew Lunn
> v1: Thanks for the comments from Simon Horman and Andrew Lunn
>
>
>
>
>
>
> Xuan Zhuo (5):
>   eea: introduce PCI framework
>   eea: introduce ring and descriptor structures
>   eea: probe the netdevice and create adminq
>   eea: create/destroy rx,tx queues for netdevice open and stop
>   eea: introduce ethtool support
>
>  MAINTAINERS                                   |   8 +
>  drivers/net/ethernet/Kconfig                  |   1 +
>  drivers/net/ethernet/Makefile                 |   1 +
>  drivers/net/ethernet/alibaba/Kconfig          |  29 +
>  drivers/net/ethernet/alibaba/Makefile         |   5 +
>  drivers/net/ethernet/alibaba/eea/Makefile     |   9 +
>  drivers/net/ethernet/alibaba/eea/eea_adminq.c | 421 ++++++++++
>  drivers/net/ethernet/alibaba/eea/eea_adminq.h |  70 ++
>  drivers/net/ethernet/alibaba/eea/eea_desc.h   | 156 ++++
>  .../net/ethernet/alibaba/eea/eea_ethtool.c    | 276 ++++++
>  .../net/ethernet/alibaba/eea/eea_ethtool.h    |  50 ++
>  drivers/net/ethernet/alibaba/eea/eea_net.c    | 577 +++++++++++++
>  drivers/net/ethernet/alibaba/eea/eea_net.h    | 196 +++++
>  drivers/net/ethernet/alibaba/eea/eea_pci.c    | 589 +++++++++++++
>  drivers/net/ethernet/alibaba/eea/eea_pci.h    |  67 ++
>  drivers/net/ethernet/alibaba/eea/eea_ring.c   | 260 ++++++
>  drivers/net/ethernet/alibaba/eea/eea_ring.h   |  91 ++
>  drivers/net/ethernet/alibaba/eea/eea_rx.c     | 787 ++++++++++++++++++
>  drivers/net/ethernet/alibaba/eea/eea_tx.c     | 402 +++++++++
>  19 files changed, 3995 insertions(+)
>  create mode 100644 drivers/net/ethernet/alibaba/Kconfig
>  create mode 100644 drivers/net/ethernet/alibaba/Makefile
>  create mode 100644 drivers/net/ethernet/alibaba/eea/Makefile
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.c
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.h
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_desc.h
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.c
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.h
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.c
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.h
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.c
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.h
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.c
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.h
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_rx.c
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_tx.c
>
> --
> 2.32.0.3.g01195cf9f
>

