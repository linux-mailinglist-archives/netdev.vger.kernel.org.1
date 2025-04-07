Return-Path: <netdev+bounces-179764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A09FFA7E7A6
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750AD1884B83
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A37821771B;
	Mon,  7 Apr 2025 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2rswZQw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B951A8F60
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044929; cv=none; b=sOGCFjxNbksIirLKWkEKMOi2uVHPSGLQUq1FARzFukeIMQfWrAN3Gr9Jml/VMUdJ5YXfw8NviJlKtXZvO90nAT+7eahqIV2Frkl7nxEENcpQ/8e988yNlM/JKRiwo3Co6cyxjL7g1nILMWIhPfVKFnPzaawgNQReRSs92VDK8oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044929; c=relaxed/simple;
	bh=jcM1KJ+oTG6JfJgmjgcHeZbwHhXSOTSj3tWy8VIS6b4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AuwqKnai/QZfzJrM5I33X74Umb2nNs5CSt3enLc3J+LHqTd2rTaKXkwLovG58wsI7zwWOZQ56My40ckeqElGk3XS03ocgfshbFfc3An/F+1Xv1fSINLkNyPAkWcXzM4XjyeWl4OB8mZ8AuO/FfYjM8EHCz4c46YnSkanovG4KZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2rswZQw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744044926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qYhbBJcaD1ygP+VeRMfirZ7ESTAhBwWp2EEunASyCrc=;
	b=X2rswZQwqEcj0tmmbL3yspqo5EJBX/NeDHEwYnuaNC0AYyGJj/+f11KqYFAxnrYUNj6QO6
	n8E0SBFbtUf7wBa4qqS6WZIKMgAGhpIhwvqLNmAmJVDbUdapR+UrFmZ9wI/UpY8m628kwN
	Chh3CE2sfEwY90hq45VWEf1yNLoB+9s=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-8CT4TjsUNK2CnFUgvoBRZA-1; Mon, 07 Apr 2025 12:55:24 -0400
X-MC-Unique: 8CT4TjsUNK2CnFUgvoBRZA-1
X-Mimecast-MFC-AGG-ID: 8CT4TjsUNK2CnFUgvoBRZA_1744044922
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5498b25aae9so2295855e87.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 09:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744044922; x=1744649722;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYhbBJcaD1ygP+VeRMfirZ7ESTAhBwWp2EEunASyCrc=;
        b=RM8ngy4m/4f+V8LVMu3281QIM35SlGaDTnhI6Lz9y3anPgivUxYZasx1C4e/me7XQ0
         GlmD76LGHJxHlLiV0jlRST8SDSuzdM3L6sJywQBe1JvoT/O2Uu09CNOsdsAkiqu0z0Y+
         lJZE/0xSDdtpN+573sF3J+eo++2NxeUTGrM0jf01hFTTMnhjZ4CWHO+O3//Y0GyxM3Td
         PL6nq0kDob1UTIXeXxtdY+jrblBqxWOZHsv2UAtZBt7u2D5u624SnFK42b7AeEKtTmEp
         NaLEwurPLYo+SK5rpPq6ObpC3YEXHVabVjSCY85cK28K9E59+MeaKFQcB/LmPli5JLc4
         Qeuw==
X-Gm-Message-State: AOJu0Yye+vVje4FxmQcim5fu+k5Ya+qaavZpFmUQo27LMAJj0cEQGr8T
	lHfAKDU5qX5waQ/0kmDKznZWkMsZyy/JOYMegikSMBzFPHWixmLoJAWkeU4jqF2gP1J+3a76YFd
	3RAsj8KV/4wLVekNChgVD+WwI8ArTCAnEzrLmVEy9j6r1UaT32hDRYA==
X-Gm-Gg: ASbGncujrXaF40/YLSH8c9oZC5EKDTc4y/w1vfsM3LV7NsaqK2BuA6u+VjdMY5xIiAO
	xFAwSL608Ytd0xNVC5Gzj6B7IaSMmf3IZx8iO8uiEnFwu2OIUq45yFJW3wZhGXRVNYr9/KqywLE
	3ju1i0Wh44SutH5pmdJXpWfp6ojd2rN7g1mkAOMNseNfndcS66AwFAJ7AWjpx8QAhMIMTCW8Wyn
	NvTIeSoibHVixclmaMO6rrt+lqP2/+XheothtNijY98cmq8Y9hyTvWrEiyi5uIBGvoTcF5r17hV
	wrPkARIP3p9f
X-Received: by 2002:a05:6512:108a:b0:549:8ed4:fb4c with SMTP id 2adb3069b0e04-54c297d170cmr2857127e87.24.1744044921939;
        Mon, 07 Apr 2025 09:55:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvNfOjhckEBLi3/as3JzwcR8acC1aLA6tON5wKoCSB+e2g7g/r0YG+F8AMVZXdzdvP+sGGxQ==
X-Received: by 2002:a05:6512:108a:b0:549:8ed4:fb4c with SMTP id 2adb3069b0e04-54c297d170cmr2857106e87.24.1744044921502;
        Mon, 07 Apr 2025 09:55:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e5ab48bsm1342106e87.33.2025.04.07.09.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:55:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 49D3119918D8; Mon, 07 Apr 2025 18:55:19 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v8 0/2] Fix late DMA unmap crash for page pool
Date: Mon, 07 Apr 2025 18:53:27 +0200
Message-Id: <20250407-page-pool-track-dma-v8-0-da9500d4ba21@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAgD9GcC/3XRzU7EIBAH8FfZcBYzMMPHevI9jAcKU7fRbRvaN
 Gs2fXexMbGmePwzmR8McxcT544n8XS6i8xLN3VDX4J/OIl4Cf0byy6VLDRoA6hAjqGcjcPwIec
 c4rtM1yABUSNhIAssSueYue1um/oiep5lz7dZvJbKpZvmIX9u1y1qq//IVJUXJUFGrTQbFxxF/
 Zw5XcL8GIfrBi56h2hTR3RBlEJuojqTbfGA4B6xdQQL4pksgbIMIR4Q2iOujlBBGvSQonVgExw
 Qs0d8HTEFMQZAh9Z6DOmA2F+kvLaO2O9xGo/kyDtIdEDcHvlnO64gISG1YM/lc/0fZF3XL52Y9
 KpfAgAA
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
submitted by Yunsheng Lin, most recently in [1]. The first commit just
wraps some tests in a helper function, in preparation of the main change
in patch 2. See the commit message of patch 2 for the details.

-Toke

[0] https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
[1] https://lore.kernel.org/r/20250307092356.638242-1-linyunsheng@huawei.com

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
Changes in v8:
- Move defines to mm.h
- Keep pp->dma_sync as 1-bit wide
- Unset pp->dma_addr on id alloc failure
- Rebase on -rc1
- Link to v7: https://lore.kernel.org/r/20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com

Changes in v7:
- Change WARN_ON logic if xarray alloc fails
- Don't leak xarray ID if page_pool_set_dma_addr_netmem() fails
- Unconditionally init xarray in page_pool_init()
- Rebase on current net-next
- Link to v6: https://lore.kernel.org/r/20250401-page-pool-track-dma-v6-0-8b83474870d4@redhat.com

Changes in v6:
- Add READ_ONCE() around both reads of pp->dma_sync
- Link to v5: https://lore.kernel.org/r/20250328-page-pool-track-dma-v5-0-55002af683ad@redhat.com

Changes in v5:
- Dereferencing pp->p.dev if pp->pma_sync is unset could lead to a
  crash, so make sure we don't do that.
- With the change above, patch 2 was just changing a single field, so
  squash it into patch 3
- Link to v4: https://lore.kernel.org/r/20250327-page-pool-track-dma-v4-0-b380dc6706d0@redhat.com

Changes in v4:
- Rebase on net-next
- Collect tags
- Link to v3: https://lore.kernel.org/r/20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com

Changes in v3:
- Use a full-width bool for pp->dma_sync instead of a full unsigned
  long (in patch 2), and leave pp->dma_sync_cpu alone.

- Link to v2: https://lore.kernel.org/r/20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com

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
Toke Høiland-Jørgensen (2):
      page_pool: Move pp_magic check into helper functions
      page_pool: Track DMA-mapped pages and unmap them when destroying the pool

 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 +-
 include/linux/mm.h                               | 59 +++++++++++++++++
 include/linux/poison.h                           |  4 ++
 include/net/page_pool/types.h                    |  7 ++
 mm/page_alloc.c                                  |  8 +--
 net/core/netmem_priv.h                           | 33 +++++++++-
 net/core/page_pool.c                             | 81 ++++++++++++++++++++----
 net/core/skbuff.c                                | 16 +----
 net/core/xdp.c                                   |  4 +-
 9 files changed, 178 insertions(+), 38 deletions(-)
---
base-commit: 61f96e684edd28ca40555ec49ea1555df31ba619
change-id: 20250310-page-pool-track-dma-0332343a460e


