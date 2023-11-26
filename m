Return-Path: <netdev+bounces-51161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6177F9642
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 00:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF0F280C9E
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 23:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAE015487;
	Sun, 26 Nov 2023 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRcotU4m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E05D51A
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 23:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269EEC433C8;
	Sun, 26 Nov 2023 23:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701040096;
	bh=sxW3nE0OFYnVrBcDyvPZeVDLSa+EGVEA0q4uRk8DikA=;
	h=From:To:Cc:Subject:Date:From;
	b=VRcotU4m2OJiGzE2FXY+uqxGsmykDq4gR5GYr+/+zT9Rg3sCsx5iNJ4TS/emHKK7e
	 JFIBNqjkulbRSMKXgrSeXMWBZWiH7+I1x8LGuXlNSxMB9E8xE9aK24y3jOe6ZZE6xu
	 bQeCQ69eMZnVgFKPtG0B7B1k7HAlXXaTXPzNQAMy3np05pXyXo7oOVUCfPHmYT7xCg
	 OoQ3ESmcjmlEh7dXsXD+Aywb35S60NAdw+XIFO7cr28JTN0+o381pVlRtrhV4fzBZj
	 doo8DOBtjn/+J6zlNVjLC7RCCA0eAK6nAtg4zZQOCfUWTLrbspP93Fqcpe6PMDVqlJ
	 D+KD54hwL2jig==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	dsahern@gmail.com,
	dtatulea@nvidia.com,
	willemb@google.com,
	almasrymina@google.com,
	shakeelb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v4 00/13] net: page_pool: add netlink-based introspection
Date: Sun, 26 Nov 2023 15:07:27 -0800
Message-ID: <20231126230740.2148636-1-kuba@kernel.org>
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

v4:
 - use dev_net(netdev)->loopback_dev
 - extend inflight doc
v3: https://lore.kernel.org/all/20231122034420.1158898-1-kuba@kernel.org/
 - ID is still here, can't decide if it matters
 - rename destroyed -> detach-time, good enough?
 - fix build for netsec
v2: https://lore.kernel.org/r/20231121000048.789613-1-kuba@kernel.org
 - hopefully fix build with PAGE_POOL=n
v1: https://lore.kernel.org/all/20231024160220.3973311-1-kuba@kernel.org/
 - The main change compared to the RFC is that the API now exposes
   outstanding references and byte counts even for "live" page pools.
   The warning is no longer printed if page pool is accessible via netlink.
RFC: https://lore.kernel.org/all/20230816234303.3786178-1-kuba@kernel.org/

Jakub Kicinski (13):
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

 Documentation/netlink/specs/netdev.yaml       | 172 +++++++
 Documentation/networking/page_pool.rst        |  10 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c |   1 +
 drivers/net/ethernet/socionext/netsec.c       |   2 +
 include/linux/list.h                          |  20 +
 include/linux/netdevice.h                     |   4 +
 include/linux/poison.h                        |   2 +
 include/net/page_pool/helpers.h               |   8 +-
 include/net/page_pool/types.h                 |  10 +
 include/uapi/linux/netdev.h                   |  36 ++
 net/core/Makefile                             |   2 +-
 net/core/netdev-genl-gen.c                    |  60 +++
 net/core/netdev-genl-gen.h                    |  11 +
 net/core/page_pool.c                          |  69 ++-
 net/core/page_pool_priv.h                     |  12 +
 net/core/page_pool_user.c                     | 408 +++++++++++++++++
 tools/include/uapi/linux/netdev.h             |  36 ++
 tools/net/ynl/generated/netdev-user.c         | 419 ++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h         | 171 +++++++
 tools/net/ynl/lib/ynl.h                       |   2 +-
 tools/net/ynl/samples/.gitignore              |   1 +
 tools/net/ynl/samples/Makefile                |   2 +-
 tools/net/ynl/samples/page-pool.c             | 147 ++++++
 25 files changed, 1574 insertions(+), 33 deletions(-)
 create mode 100644 net/core/page_pool_priv.h
 create mode 100644 net/core/page_pool_user.c
 create mode 100644 tools/net/ynl/samples/page-pool.c

-- 
2.42.0


