Return-Path: <netdev+bounces-177499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FACA70570
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0470916888E
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EDA8635E;
	Tue, 25 Mar 2025 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mc/TSHJG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6570319D071
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917605; cv=none; b=GrWd2Lt3CqyKl2DWMJAEBFnWsGnSsRXBe1BnDvPaQEfvkI0x0oUvaFqCEoi+wP8koYmOXgjZPTBBgj2gZrWfzFpyVonJB3hmhqulAzkg2g2gSsPB5TP/2kzphRh1+3DXG918Mw2HnMzqxF8SDoLGP6Is85AMUN781A42Mm+mRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917605; c=relaxed/simple;
	bh=IuMa+liBH/B2Yu1mDpSq4nCTE5d0LpHwv/uosWgfnFk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cpQkheK5R6HrN1Z7JNRBJUq2L/kt3IOubHUv44G3rvRIyzKJkENkO1vhpJcMZ5Mbo8Q63Gb6sslKd+yPTpx4zXPpDu7W7Xu+y70r+o329owvy8YBJ7PPNaTj1msfDsej2yumjKnf8j8JJEVvCbFbhoL99uWIxsaaGUYStsuTX34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mc/TSHJG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742917602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y52BZ141xP1cmy6URJL9RkKym6Xlq7n0vZ3Uzut8xhY=;
	b=Mc/TSHJGZUVN0nusB1tzvIHf1gH32vtvjev00svzOOvyBIv7BK2AJyeND/qMw7obq6Mu0b
	yQhq6Bp6fc/N9ffXLPX3zX3NFgJ8Ir3s8Y6OXN+tGn+SCsW0Px4EOydeuezHmu6YOVFyzy
	YoNNZ9Ra7XlYibViJwKCmHG/HHjiDm8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-9dn5OO9wNvqmOn5QUvbEWg-1; Tue, 25 Mar 2025 11:46:40 -0400
X-MC-Unique: 9dn5OO9wNvqmOn5QUvbEWg-1
X-Mimecast-MFC-AGG-ID: 9dn5OO9wNvqmOn5QUvbEWg_1742917599
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-30bfb9619b9so23973511fa.2
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 08:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742917599; x=1743522399;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y52BZ141xP1cmy6URJL9RkKym6Xlq7n0vZ3Uzut8xhY=;
        b=QEhuu0xQEsUQDxuJQcP3panH5XRVDV63NSzYsRNcYIalYihQ/zJDfHcGRykdhgKaqP
         WGkhW1YnJgqPu3+02o22JLnCsIXeHMPD+t6kr52Vj0EwmQ0SW7HFz1vlUofxnxvOUxyK
         9L+wpgOonK75lHR9RRalQ1R2TVKEf+MyPHEN1LqK0SvPz2WUgW91ni0+eDVP8MKv/ZqM
         l39rzT0icxiHUyGzT8NH2pyAzFMA2ekhzM0woXoWzL4puLNXyGVabhk/57Lj3lV8ysGt
         LwJo4N2vdO25yDyJKImAfO9ERgfZrv+yIeQJPvXLxU1NAeTMmu1ldK5+UpuQ1dkJcAze
         EH5A==
X-Gm-Message-State: AOJu0YysSIKemDkMey3SIxhDVfpJZHyedUNCtHq+2UcvProWMbkxkpMu
	RAxNDjjhk5cPM0QkQkm9zhsJrmVd+WemAZTaziXJWsB41diiSG4+rM9r+VHZeRdFBcx3iyUOP9C
	NJRketSyiHusT8p63mw+tE3h8WwevCvIyN1nmKmUx8NRtaGBg5Caj4Q==
X-Gm-Gg: ASbGncvI+96UAX6R0sQszewsYtJTDPM/2nX6tVssQmyhy1pa0LuR4mjyuDJ+gY4ieAe
	nzqWcBpYi1Pyuk2EsiTMuTrf4T09HTNfcgl6otNrzNZHaAqOa/oPM1oX92JGkjyd/gZ5ZjYAVB2
	0rPKiwukSCPpoiMR4q4JFJdG9SPpa/gl2n0HLxOKkOE4sDrGwv1KUc/pIL7O5z69Y+pfNTi/Zty
	1JCNhoGvBwFHWpihQ4Wq3sx3RDANlRtlKxZ+jOsHJ0fC2d9mAkc7YFEqcbFXLN3QszgQjtvOvuw
	gL8pnArTGywr
X-Received: by 2002:a2e:be8b:0:b0:308:ec50:e841 with SMTP id 38308e7fff4ca-30d7e313eedmr83894551fa.25.1742917599219;
        Tue, 25 Mar 2025 08:46:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFauRbSf+Z/aowK4ZvQrhLjDffXRTAIj3FvuTlcqi0ZO3sYX1PyxjhMIclDBh2byTqy+7m2fw==
X-Received: by 2002:a2e:be8b:0:b0:308:ec50:e841 with SMTP id 38308e7fff4ca-30d7e313eedmr83894191fa.25.1742917598512;
        Tue, 25 Mar 2025 08:46:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7fe7b4sm18543751fa.53.2025.03.25.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 08:46:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C415A18FC8B6; Tue, 25 Mar 2025 16:46:36 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v2 0/3] Fix late DMA unmap crash for page pool
Date: Tue, 25 Mar 2025 16:45:41 +0100
Message-Id: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKXP4mcC/22NwQrCMBBEf6Xs2ZVkk1rw5H9ID0u62qBNShJKp
 fTfDcWjx5nHvNkgS/KS4dpskGTx2cdQA50acCOHp6AfagZS1CqjFc5cuznGN5bE7oXDxKiMIWM
 N24sSqMs5ycOvh/UOQQoGWQv0lYw+l5g+x92iD/4z27/mRaNCR5qk7bizjm5JhpHL2cUJ+n3fv
 1Iu057BAAAA
X-Change-ID: 20250310-page-pool-track-dma-0332343a460e
To: "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Mina Almasry <almasrymina@google.com>, 
 Yonglong Liu <liuyonglong@huawei.com>, 
 Yunsheng Lin <linyunsheng@huawei.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>
X-Mailer: b4 0.14.2

This series fixes the late dma_unmap crash for page pool first reported
by Yonglong Liu in [0]. It is an alternative approach to the one
submitted by Yunsheng Lin, most recently in [1]. The first two commits
are small refactors of the page pool code, in preparation of the main
change in patch 3. See the commit message of patch 3 for the details.

-Toke

[0] https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
[1] https://lore.kernel.org/r/20250307092356.638242-1-linyunsheng@huawei.com

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
Changes in v2:
- Always leave two bits at the top of pp_magic as zero, instead of one

- Add an rcu_read_lock() around __page_pool_dma_sync_for_device()

- Add a comment in poison.h with a reference to the bitmask definition

- Add a longer description of the logic of the bitmask definitions to
  the comment in types.h, and a summary of the security implications of
  using the pp_magic field to the commit message of patch 3

- Collect Mina's Reviewed-by and Yonglong's Tested-by tags

- Link to v1: https://lore.kernel.org/r/20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com

---
Toke Høiland-Jørgensen (3):
      page_pool: Move pp_magic check into helper functions
      page_pool: Turn dma_sync and dma_sync_cpu fields into a bitmap
      page_pool: Track DMA-mapped pages and unmap them when destroying the pool

 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 +-
 include/linux/poison.h                           |  4 ++
 include/net/page_pool/helpers.h                  |  6 +-
 include/net/page_pool/types.h                    | 67 +++++++++++++++++-
 mm/page_alloc.c                                  |  9 +--
 net/core/devmem.c                                |  3 +-
 net/core/netmem_priv.h                           | 33 ++++++++-
 net/core/page_pool.c                             | 87 ++++++++++++++++++++----
 net/core/skbuff.c                                | 16 +----
 net/core/xdp.c                                   |  4 +-
 10 files changed, 186 insertions(+), 47 deletions(-)
---
base-commit: 45e36a8e3c17c4d50ecbc863893f253fb46ac070
change-id: 20250310-page-pool-track-dma-0332343a460e


