Return-Path: <netdev+bounces-49463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4997E7F21D7
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 01:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C96282350
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77C917D4;
	Tue, 21 Nov 2023 00:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxdBZqs8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DA98BF2
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 00:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C556DC433C7;
	Tue, 21 Nov 2023 00:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700524856;
	bh=sZhDjLK9ktGXdQtjtG0R43YbeCQvqXrWZHODWg3pO/8=;
	h=From:To:Cc:Subject:Date:From;
	b=AxdBZqs8Biy6X8OtWJWkBMC4nHR65Mzw7issvnxILzgBmCwH8SmNMspzsEg8sBlH1
	 A8E6hwJ+u/W8st/QIPPnDC+Oo8GeQXTrVoll5XiBtYZeQ8+spMjfTl/bHhRSXAzPpt
	 A9M3LTobQ04LWUAL0bFD2qu55VzdgjB8KntieJ/1ANU6Zv+mY0y+rOKF/GBKUzareE
	 EMTTRDdCJfaH3DTUI4ZiuS3i316W4GfhsmRJsCbSV9ZHDHrdTt4GYN2X7Mw4Y3hkes
	 rFhFxAI3+tCEp4bV4nnAoxP659oBWOTSOYSdxBfD35d/HJWjQ8OuhQbesAE02zzkhp
	 xAXmjpQ4xVbPQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	dsahern@gmail.com,
	dtatulea@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 00/15] net: page_pool: add netlink-based introspection
Date: Mon, 20 Nov 2023 16:00:33 -0800
Message-ID: <20231121000048.789613-1-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We recently started to deploy newer kernels / drivers at Meta,
making significant use of page pools for the first time.
We immediately run into page pool leaks both real and false positive
warnings. As Eric pointed out/predicted there's no guarantee that
applications will read / close their sockets so a page pool page
may be stuck in a socket (but not leaked) forever. This happens
a lot in our fleet. Most of these are obviously due to application
bugs but we should not be printing kernel warnings due to minor
application resource leaks.

Conversely the page pool memory may get leaked at runtime, and
we have no way to detect / track that, unless someone reconfigures
the NIC and destroys the page pools which leaked the pages.

The solution presented here is to expose the memory use of page
pools via netlink. This allows for continuous monitoring of memory
used by page pools, regardless if they were destroyed or not.
Sample in patch 15 can print the memory use and recycling
efficiency:

$ ./page-pool
    eth0[2]	page pools: 10 (zombies: 0)
		refs: 41984 bytes: 171966464 (refs: 0 bytes: 0)
		recycling: 90.3% (alloc: 656:397681 recycle: 89652:270201)

v2:
 - hopefully fix build with PAGE_POOL=n
v1:  https://lore.kernel.org/all/20231024160220.3973311-1-kuba@kernel.org/
 - The main change compared to the RFC is that the API now exposes
   outstanding references and byte counts even for "live" page pools.
   The warning is no longer printed if page pool is accessible via netlink.
RFC: https://lore.kernel.org/all/20230816234303.3786178-1-kuba@kernel.org/

Jakub Kicinski (15):
  net: page_pool: split the page_pool_params into fast and slow
  net: page_pool: avoid touching slow on the fastpath
  net: page_pool: factor out uninit
  net: page_pool: id the page pools
  net: page_pool: record pools per netdev
  net: page_pool: stash the NAPI ID for easier access
  eth: link netdev to page_pools in drivers
  net: page_pool: add nlspec for basic access to page pools
  net: page_pool: implement GET in the netlink API
  net: page_pool: add netlink notifications for state changes
  net: page_pool: report amount of memory held by page pools
  net: page_pool: report when page pool was destroyed
  net: page_pool: expose page pool stats via netlink
  net: page_pool: mute the periodic warning for visible page pools
  tools: ynl: add sample for getting page-pool information

 Documentation/netlink/specs/netdev.yaml       | 166 +++++++
 Documentation/networking/page_pool.rst        |  10 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c |   1 +
 drivers/net/ethernet/socionext/netsec.c       |   2 +
 include/linux/list.h                          |  20 +
 include/linux/netdevice.h                     |   4 +
 include/linux/poison.h                        |   2 +
 include/net/page_pool/helpers.h               |   8 +-
 include/net/page_pool/types.h                 |  43 +-
 include/uapi/linux/netdev.h                   |  36 ++
 net/core/Makefile                             |   2 +-
 net/core/netdev-genl-gen.c                    |  60 +++
 net/core/netdev-genl-gen.h                    |  11 +
 net/core/page_pool.c                          |  78 ++--
 net/core/page_pool_priv.h                     |  12 +
 net/core/page_pool_user.c                     | 414 +++++++++++++++++
 tools/include/uapi/linux/netdev.h             |  36 ++
 tools/net/ynl/generated/netdev-user.c         | 419 ++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h         | 171 +++++++
 tools/net/ynl/lib/ynl.h                       |   2 +-
 tools/net/ynl/samples/.gitignore              |   1 +
 tools/net/ynl/samples/Makefile                |   2 +-
 tools/net/ynl/samples/page-pool.c             | 147 ++++++
 25 files changed, 1601 insertions(+), 48 deletions(-)
 create mode 100644 net/core/page_pool_priv.h
 create mode 100644 net/core/page_pool_user.c
 create mode 100644 tools/net/ynl/samples/page-pool.c

-- 
2.42.0


