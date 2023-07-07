Return-Path: <netdev+bounces-16100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5721D74B66D
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 20:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD422818BF
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 18:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C93915AC1;
	Fri,  7 Jul 2023 18:39:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E477F1852
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 18:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC4DC433C7;
	Fri,  7 Jul 2023 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688755183;
	bh=W+uxIvnlk5gJmqhAI2jml15L57OjIYxyYaYlLjH9cW8=;
	h=From:To:Cc:Subject:Date:From;
	b=jlN7xg+Gu+DXpfjIrka6BpGZSFVzSqZ1KVM3EbCbWJXvFRcVNoL0qz2VTW5KyIV81
	 MrotqEbyCFfgilVvC+M/N/RKhcbtVm6USwedlK2XAQzbuzA9mLtZgQcwyDPOK1jNej
	 /asL7bJABvcJHIL/vfx5vaTPnkdvejXSjRWGwWCajaWN0Y363BnKho18ZI3ppezwBU
	 KpfB+aMpUiTeckxiOuHVVEjJctkR7N4UlQ5/z1abUTiduikTWHwvlRb/T6I7EDJF6j
	 gfxr7nRlZKM40h6f5he2GBS0uzEz9pMTP4tfDUnzkoe9CAtU9M7LxIsQRagPEmDgPO
	 BvWsAEfBMg3QQ==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	edumazet@google.com,
	dsahern@gmail.com,
	michael.chan@broadcom.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 00/12] net: huge page backed page_pool
Date: Fri,  7 Jul 2023 11:39:23 -0700
Message-ID: <20230707183935.997267-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This is an "early PoC" at best. It seems to work for a basic
traffic test but there's no uAPI and a lot more general polish
is needed.

The problem we're seeing is that performance of some older NICs
degrades quite a bit when IOMMU is used (in non-passthru mode).
There is a long tail of old NICs deployed, especially in PoPs/
/on edge. From a conversation I had with Eric a few months
ago it sounded like others may have similar issues. So I thought
I'd take a swing at getting page pool to feed drivers huge pages.
1G pages require hooking into early init via CMA but it works
just fine.

I haven't tested this with a real workload, because I'm still
waiting to get my hands on the right machine. But the experiment
with bnxt shows a ~90% reduction in IOTLB misses (670k -> 70k).

In terms of the missing parts - uAPI is definitely needed.
The rough plan would be to add memory config via the netdev
genl family. Should fit nicely there. Have the config stored
in struct netdevice. When page pool is created get to the netdev
and automatically select the provider without the driver even
knowing. Two problems with that are - 1) if the driver follows
the recommended flow of allocating new queues before freeing
old ones we will have page pools created before the old ones
are gone, which means we'd need to reserve 2x the number of
1G pages; 2) there's no callback to the driver to say "I did
something behind your back, don't worry about it, but recreate
your queues, please" so the change will not take effect until
some unrelated change like installing XDP. Which may be fine
in practice but is a bit odd.

Then we get into hand-wavy stuff like - if we can link page
pools to netdevs, we should also be able to export the page pool
stats via the netdev family instead doing it the ethtool -S.. ekhm..
"way". And if we start storing configs behind driver's back why
don't we also store other params, like ring size and queue count...
A lot of potential improvements as we iron out a new API...

Live tree: https://github.com/kuba-moo/linux/tree/pp-providers

Jakub Kicinski (12):
  net: hack together some page sharing
  net: create a 1G-huge-page-backed allocator
  net: page_pool: hide page_pool_release_page()
  net: page_pool: merge page_pool_release_page() with
    page_pool_return_page()
  net: page_pool: factor out releasing DMA from releasing the page
  net: page_pool: create hooks for custom page providers
  net: page_pool: add huge page backed memory providers
  eth: bnxt: let the page pool manage the DMA mapping
  eth: bnxt: use the page pool for data pages
  eth: bnxt: make sure we make for recycle skbs before freeing them
  eth: bnxt: wrap coherent allocations into helpers
  eth: bnxt: hack in the use of MEP

 Documentation/networking/page_pool.rst        |  10 +-
 arch/x86/kernel/setup.c                       |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 154 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   5 +
 drivers/net/ethernet/engleder/tsnep_main.c    |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   4 +-
 include/net/dcalloc.h                         |  28 +
 include/net/page_pool.h                       |  36 +-
 net/core/Makefile                             |   2 +-
 net/core/dcalloc.c                            | 615 +++++++++++++++++
 net/core/dcalloc.h                            |  96 +++
 net/core/page_pool.c                          | 625 +++++++++++++++++-
 12 files changed, 1478 insertions(+), 105 deletions(-)
 create mode 100644 include/net/dcalloc.h
 create mode 100644 net/core/dcalloc.c
 create mode 100644 net/core/dcalloc.h

-- 
2.41.0


