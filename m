Return-Path: <netdev+bounces-43915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 305D57D573B
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616561C20A96
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40F538DFA;
	Tue, 24 Oct 2023 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjN/Gs+W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D3D1D68B
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6EDC433C9;
	Tue, 24 Oct 2023 16:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698163361;
	bh=HQb24SvxOs7vKt5G/O/gxcgeGyBy2E9aRbeySxt4ftY=;
	h=From:To:Cc:Subject:Date:From;
	b=tjN/Gs+Wv3djqDOFKmzrmAximw4t8Upxw4T0hMUY6uwyHVetfc4KISQcK/kXdLx33
	 n2QxrWagKkqC23Wku4Ibq2DrHw1ACkt6TeOooS5tfRc55E14Bl+Vbnu9+GX7aAYnZi
	 1Cg2fOUdbkLcuWqno4gfuwmXIn8o0ATUESk1TYD3a3ox1AlG02GeKRY7qhcm/Xa0ip
	 MUAD9wT0vFtxEK8v9Z8B/t6UjHRRbTEtfWemDxBhXyIJmmWNx+4p2ngSSJKLKsHEg2
	 Yqyt2n9dsh3JnEP5MlsIg6OceiF9R63ii/ER/jxiuLnpWB69j6XLl3mPF2Wc4F3neU
	 G4v2JByzbY1vA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 00/15] net: page_pool: add netlink-based introspection
Date: Tue, 24 Oct 2023 09:02:05 -0700
Message-ID: <20231024160220.3973311-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a new revision of the RFC posted in August:
https://lore.kernel.org/all/20230816234303.3786178-1-kuba@kernel.org/
There's been a handful of fixes and tweaks but the overall
architecture is unchanged.

As a reminder the RFC was posted as the first step towards
an API which could configure the page pools (GET API as a stepping
stone for a SET API to come later). I wasn't sure whether we should
commit to the GET API before the SET takes shape, hence the large
delay between versions.

Unfortunately, real deployment experience made this series much more
urgent. We recently started to deploy newer kernels / drivers
at Meta, making significant use of page pools for the first time.
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

The main change compared to the RFC is that the API now exposes
outstanding references and byte counts even for "live" page pools.
The warning is no longer printed if page pool is accessible via netlink.

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

 Documentation/netlink/specs/netdev.yaml       | 161 +++++++
 Documentation/networking/page_pool.rst        |  10 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c |   1 +
 include/linux/list.h                          |  20 +
 include/linux/netdevice.h                     |   4 +
 include/linux/poison.h                        |   2 +
 include/net/page_pool/helpers.h               |   8 +-
 include/net/page_pool/types.h                 |  43 +-
 include/uapi/linux/netdev.h                   |  36 ++
 net/core/Makefile                             |   2 +-
 net/core/netdev-genl-gen.c                    |  52 +++
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
 24 files changed, 1586 insertions(+), 48 deletions(-)
 create mode 100644 net/core/page_pool_priv.h
 create mode 100644 net/core/page_pool_user.c
 create mode 100644 tools/net/ynl/samples/page-pool.c

-- 
2.41.0


