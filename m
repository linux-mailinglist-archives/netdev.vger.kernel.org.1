Return-Path: <netdev+bounces-189205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6704FAB1290
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D464A60D8
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB2A291166;
	Fri,  9 May 2025 11:51:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9927E28ECD8;
	Fri,  9 May 2025 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791504; cv=none; b=lx579mM2O8vJbEKZALHEvp6bR9yabhugpvjlCuLnHxyLYsW5+JNcXFtYapwuzLvAwZV1KBjD6XO5wGvCdCoSfnW6c1HC2k618MmIT8XSqncvz4PzEotJeKtj8qNhn5Yj5oGrO5zTV8+d9zu616bwM6350SRQxrXFfA+ATdXd9rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791504; c=relaxed/simple;
	bh=ahRvGyDp/0glVQdyyjcRPGs0TtGVJN5Yys2SjqBdLGg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jYStlKyFw3AllEGuA6J21WWMU7scTqCGlFbkyMc1g8y16MbbfUf7pkA2S1hOHxLrOPTyBTceoDn5PYHuFp9xJAEAa4B7InwmiwsKGFY22O2H1d+iM2FvRKIHmkU2S2yEYognZ5jDchjS7vjnZONHMFH0XSjcIVFRGiGzuxdmHw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-26-681dec488b68
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	vishal.moola@gmail.com
Subject: [RFC 00/19] Split netmem from struct page
Date: Fri,  9 May 2025 20:51:07 +0900
Message-Id: <20250509115126.63190-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnoa7nG9kMgzfPWCzmrF/DZrH6R4XF
	8gc7WC2+/LzNbrF44TdmiznnW1gsnh57xG5xfxlQ2Z727cwWvS2/mS2adqxgsriwrY/V4vKu
	OWwW99b8Z7U4tkDM4tvpN4wW6/fdYLX4/WMOm4OQx5aVN5k8ds66y+6xYFOpx+YVWh5dNy4x
	e2xa1cnmsenTJHaPO9f2sHmcmPGbxWPnjs9MHh+f3mLxeL/vKpvH501yAbxRXDYpqTmZZalF
	+nYJXBnPFjxnKrgmW3F+TQtrA+MKsS5GDg4JAROJu6dkuhg5wcxFS7+zg9hsAuoSN278ZAax
	RQQMJT4/Os7SxcjFwSywkFniyuKfYEXCAkYSl2Y1MoLYLAKqEtcmzwWL8wqYSqzvPMAMMVRe
	YvUGEJsLyH7OJrFo+h5WiISkxMEVN1gmMHIvYGRYxSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREY
	1Mtq/0TvYPx0IfgQowAHoxIPr8Vz2Qwh1sSy4srcQ4wSHMxKIrzPO2UyhHhTEiurUovy44tK
	c1KLDzFKc7AoifMafStPERJITyxJzU5NLUgtgskycXBKNTC2fZr8+MCl43p2HluFon31V26z
	31j13pA9J9owrEM7vynmxYW7B/bI6Qv+25J2VnKVjWOGb6yi8lnz2cnn7GZVvRNqKJlcc2K5
	0O1GnxczbiTyznKImfJ7Dn+9RcGZXb1uSq/2S0XcUlb1ZufhPb+CV7BvOctip1d8xfIyV5WS
	jrCujXcKvKLEUpyRaKjFXFScCACqmHYCZgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsXC5WfdrOvxRjbDYPpfE4s569ewWaz+UWGx
	/MEOVosvP2+zWyxe+I3ZYs75FhaLp8cesVvcX/aMxWJP+3Zmi96W38wWTTtWMFkcnnuS1eLC
	tj5Wi8u75rBZ3Fvzn9Xi2AIxi2+n3zBarN93g9Xi9485bA7CHltW3mTy2DnrLrvHgk2lHptX
	aHl03bjE7LFpVSebx6ZPk9g97lzbw+ZxYsZvFo+dOz4zeXx8eovF4/2+q2wei198YPL4vEku
	gC+KyyYlNSezLLVI3y6BK+PZgudMBddkK86vaWFtYFwh1sXIySEhYCKxaOl3dhCbTUBd4saN
	n8wgtoiAocTnR8dZuhi5OJgFFjJLXFn8E6xIWMBI4tKsRkYQm0VAVeLa5LlgcV4BU4n1nQeY
	IYbKS6zecIB5AiPHAkaGVYwimXlluYmZOaZ6xdkZlXmZFXrJ+bmbGIFBuqz2z8QdjF8uux9i
	FOBgVOLhtXgumyHEmlhWXJl7iFGCg1lJhPd5p0yGEG9KYmVValF+fFFpTmrxIUZpDhYlcV6v
	8NQEIYH0xJLU7NTUgtQimCwTB6dUA2PRj46qU44VK5mOLPNqucitmi+kce6fqtIVoTPbhDat
	qH4qsc412FRw6fRdHiUSdxrV9QKmz9fOevNgosyKnldteRXTaw8Xrf4fP08gbr4A8/f7Sws5
	W2UqOc+cibTe+zO0R+g4b0HhvM/szmb6x810+fROJxXI5TZ/ffh/M/8FoZO1xy9bzVFiKc5I
	NNRiLipOBABTo7tITgIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The MM subsystem is trying to reduce struct page to a single pointer.
The first step towards that is splitting struct page by its individual
users, as has already been done with folio and slab.  This patchset does
that for netmem which is used for page pools.

Matthew Wilcox tried and stopped the same work, you can see in:

   https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infradead.org/

Mina Almasry already has done a lot fo prerequisite works by luck, he
said :).  I stacked my patches on the top of his work e.i. netmem.

I focused on removing the page pool members in struct page this time,
not moving the allocation code of page pool from net to mm.  It can be
done later if needed.

There are still a lot of works to do, to remove the dependency on struct
page in the network subsystem.  I will continue to work on this after
this base patchset is merged.

This patchset is based on mm tree's mm-unstable branch.

Byungchul Park (19):
  netmem: rename struct net_iov to struct netmem_desc
  netmem: introduce netmem alloc/put API to wrap page alloc/put API
  page_pool: use netmem alloc/put API in __page_pool_alloc_page_order()
  page_pool: rename __page_pool_alloc_page_order() to
    __page_pool_alloc_large_netmem()
  page_pool: use netmem alloc/put API in __page_pool_alloc_pages_slow()
  page_pool: rename page_pool_return_page() to page_pool_return_netmem()
  page_pool: use netmem alloc/put API in page_pool_return_netmem()
  page_pool: rename __page_pool_release_page_dma() to
    __page_pool_release_netmem_dma()
  page_pool: rename __page_pool_put_page() to __page_pool_put_netmem()
  page_pool: rename __page_pool_alloc_pages_slow() to
    __page_pool_alloc_netmems_slow()
  mlx4: use netmem descriptor and API for page pool
  netmem: introduce page_pool_recycle_direct_netmem()
  page_pool: expand scope of is_pp_{netmem,page}() to global
  mm: page_alloc: do not directly access page->pp_magic but use
    is_pp_page()
  mlx5: use netmem descriptor and API for page pool
  netmem: use _Generic to cover const casting for page_to_netmem()
  netmem: remove __netmem_get_pp()
  page_pool: make page_pool_get_dma_addr() just wrap
    page_pool_get_dma_addr_netmem()
  mm, netmem: remove the page pool members in struct page

 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  46 ++++----
 drivers/net/ethernet/mellanox/mlx4/en_tx.c    |   8 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  18 +--
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  15 ++-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  66 +++++------
 include/linux/mm_types.h                      |  13 +--
 include/linux/skbuff.h                        |  18 ++-
 include/net/netmem.h                          |  88 +++++----------
 include/net/netmem_type.h                     |  22 ++++
 include/net/page_pool/helpers.h               |  17 ++-
 include/net/page_pool/memory_provider.h       |   6 +-
 include/net/page_pool/types.h                 |   2 +
 io_uring/zcrx.c                               |  42 +++----
 mm/page_alloc.c                               |   5 +-
 net/core/devmem.c                             |  14 +--
 net/core/devmem.h                             |  24 ++--
 net/core/page_pool.c                          | 106 ++++++++++--------
 net/core/skbuff.c                             |   5 -
 net/ipv4/tcp.c                                |   2 +-
 22 files changed, 272 insertions(+), 255 deletions(-)
 create mode 100644 include/net/netmem_type.h


base-commit: fd93b3350b4314eebd8fbf0fea3ca7fe48d777e3
-- 
2.17.1


