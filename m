Return-Path: <netdev+bounces-12730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4541A738BEE
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 18:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762F31C20EEB
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4064A18C2D;
	Wed, 21 Jun 2023 16:46:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3301317722
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 16:46:21 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AE419AF;
	Wed, 21 Jun 2023 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=gPF8zQQSIHiKU2e2Ly4ej0SDtpoejzkFWwWEYtBtv+s=; b=R6XCM2zV5SdOXGzdC4zN24TUJT
	M4veWjCAPq0VNUMCOXwK50bgiMz71O8YN/hsbWICKjaGBn0L/hOi6O3vzf8WibWLHu9fl3oQnQsny
	VGKEA7Ik15shC5pM7bj5sOsWEZqfwMVm1w/UApf/gyrXm2EOIwgAe4VVVX5iq6/R6BNzAkxe/vJHh
	XJoF4JmL38Rj6+7jZjgWTJ1XxMEElaDGBPXE4ET31k0NcLCnoFJ3RJwwdIo3TnQpnX9h+isSLIe6j
	JkTmNrRbvZfY6wvO0Tfw3qOS6OftxBxHLANWzL3TPle2V4DyHE+CsN5B7LgFifpOLmUjM6a7p9apc
	NtFA7iFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qC0y1-00EjDe-6y; Wed, 21 Jun 2023 16:46:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 00/13] Remove pagevecs
Date: Wed, 21 Jun 2023 17:45:44 +0100
Message-Id: <20230621164557.3510324-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We're almost done with the pagevec -> folio_batch conversion.  Finish
the job.

Matthew Wilcox (Oracle) (13):
  afs: Convert pagevec to folio_batch in afs_extend_writeback()
  mm: Add __folio_batch_release()
  scatterlist: Add sg_set_folio()
  i915: Convert shmem_sg_free_table() to use a folio_batch
  drm: Convert drm_gem_put_pages() to use a folio_batch
  mm: Remove check_move_unevictable_pages()
  pagevec: Rename fbatch_count()
  i915: Convert i915_gpu_error to use a folio_batch
  net: Convert sunrpc from pagevec to folio_batch
  mm: Remove struct pagevec
  mm: Rename invalidate_mapping_pagevec to mapping_try_invalidate
  mm: Remove references to pagevec
  mm: Remove unnecessary pagevec includes

 drivers/gpu/drm/drm_gem.c                 | 68 +++++++++++++----------
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 55 ++++++++++--------
 drivers/gpu/drm/i915/i915_gpu_error.c     | 50 ++++++++---------
 fs/afs/write.c                            | 16 +++---
 include/linux/pagevec.h                   | 67 +++-------------------
 include/linux/scatterlist.h               | 24 ++++++++
 include/linux/sunrpc/svc.h                |  2 +-
 include/linux/swap.h                      |  1 -
 mm/fadvise.c                              | 17 +++---
 mm/huge_memory.c                          |  2 +-
 mm/internal.h                             |  4 +-
 mm/khugepaged.c                           |  6 +-
 mm/ksm.c                                  |  6 +-
 mm/memory.c                               |  6 +-
 mm/memory_hotplug.c                       |  1 -
 mm/migrate.c                              |  1 -
 mm/migrate_device.c                       |  2 +-
 mm/readahead.c                            |  1 -
 mm/swap.c                                 | 20 +++----
 mm/swap_state.c                           |  1 -
 mm/truncate.c                             | 27 +++++----
 mm/vmscan.c                               | 17 ------
 net/sunrpc/svc.c                          | 10 ++--
 23 files changed, 185 insertions(+), 219 deletions(-)

-- 
2.39.2


