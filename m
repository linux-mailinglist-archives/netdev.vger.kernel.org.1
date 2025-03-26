Return-Path: <netdev+bounces-177679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D665A7127E
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 09:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFAC3B444E
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 08:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B592A191F84;
	Wed, 26 Mar 2025 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdUk/oRJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D091A2C25
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742977148; cv=none; b=UH5eroPdsg/nfBNyrIlkaERefgC13cPOJS9sVvvEBarCQK9Ca9Uq2tlnvOpE+xW2e32srBkBQ0p/Qu9BMtMm7JWPK2XzgP9drW0rDQRIKIeOt468o+KMOTUHlI9Wr0iq1rDWrMrnhMrSNYe/Ukfk937mbiUOA1aJCrdllOwociQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742977148; c=relaxed/simple;
	bh=iofBJfRVG4BOlspccJuOxKZ8GN7yJUVTePwGTFtKji8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JgvB56suz5nl8c7ZWFgs8P7e++S6d7+8h8N7ChCA/WDBomC71lb2+IypDhC9wYYPL6kyVxdlXa5kctkaMWfXiq/Gfrhx4uF2bbHyuGloVuDNG/MBgIS66w2fZpLmINXKnhgk/OHYqsktaDTV7cd8yyFJIdveSG+gZCGK2ACf1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdUk/oRJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742977145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BJrq4mLJiJXWNMpizUXhY6u/aCQe+JkhHXm5jj4+P0s=;
	b=SdUk/oRJcafcxYMJSEKJTp87FSp1i6BHEJXKinqMpiCizWCtoQMEX6ZYjrWNNoMbxYIiQI
	lE2+c52DZkNRgQ6KvQfCre22Qun1vUoTrTaoQ3Cadv9/u7nkQ+hYQ4AlpFmYCJXhF82QkK
	kWTPsxbKT4F1UiSTuAlb3WYhHMg/KBo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-gqmEwktBMfS1gTJCd62_gg-1; Wed, 26 Mar 2025 04:19:03 -0400
X-MC-Unique: gqmEwktBMfS1gTJCd62_gg-1
X-Mimecast-MFC-AGG-ID: gqmEwktBMfS1gTJCd62_gg_1742977142
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac28a2c7c48so37704466b.3
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 01:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742977142; x=1743581942;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJrq4mLJiJXWNMpizUXhY6u/aCQe+JkhHXm5jj4+P0s=;
        b=kxWcgeMYYqRXN41SCtp9u/iECMdGthFNBaPNr3kbqaBhIM3dTp1eOEzQdhBoB50Ley
         1IyDW1KkZyLGrVsA3wdqYNhuRDgO6Vi80dEKRXTvZ7dxS4tnFXccTZcKJlEYaE5VN4CM
         zR5yPWbdL261ZIQrZ+5Ck2XNWdtQI+VLQIzaT+mGRfy/vQ5YxKZU5UuicP//3Czjzh6b
         L5zVicpQ5b2BgbaVgyBjI/Y+K9zMnF+a7VxBmDGw4cjFjXFgeK2bF+q7dSQohqxGEhCw
         +4Ti8AMTp012AG9eahHY3W25PMVW+nnTTWru6aBclH4qD9mkX24shkbcCabSEG+G+ITX
         66lg==
X-Gm-Message-State: AOJu0YzzRqvmuO0SJ6h9lZgVFZxVVKdx4pQk4SJyudukhANY65GcEAsV
	9mtpfdKlhqueOk8EGKxfMspuWJi7k4mgIrFtDxP7UBS3kP7vligrXorW7CXWCWHdni4aB0pw3Rc
	daRmsD+kANsVz5Fp6BjVBLXild5skLU1iQ4jV3sGHOPdp4QgDlxvsGw==
X-Gm-Gg: ASbGnctGsX2znZ7AKV1T95f1BjdO4X7JBliaAYlkPNAxkL+Kd7TaflVHuvYf36sT//o
	fB+b8W4DF0iY+eQYV39XmyttNzfrja2zQICMAFo7wcqq4j3Wyl8Qk7v80QqmBXPGd3MWSR9y+WQ
	LhAGp1UzrCIb+8UgdX5CLzwC0XlQS56gcQFXlzaOWWaxpNVjxGrb3alfWi1O6TWkhx3TPkbKTYR
	NYAcbaivezo31LFbP+BrtlUUNZ6TBJ35dhVrI5wkswFrnVu/W3wF6we/68iyOpLjuoyqcgivQzx
	72T9Dhu2gtRlxNYpNYwEd7QbsiRo1vdzsYzrermJ
X-Received: by 2002:a17:907:96a5:b0:ac3:5c8e:d3f5 with SMTP id a640c23a62f3a-ac3f2238ac9mr1964306266b.27.1742977141985;
        Wed, 26 Mar 2025 01:19:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAVihNCBcqrY7fTmWzpMKedPdAfC8xKs8i1WcBmyCG1SOQFnIZkqUTCro3SjnL+rAel5iZ/A==
X-Received: by 2002:a17:907:96a5:b0:ac3:5c8e:d3f5 with SMTP id a640c23a62f3a-ac3f2238ac9mr1964303566b.27.1742977141528;
        Wed, 26 Mar 2025 01:19:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbe0356sm1006017366b.144.2025.03.26.01.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 01:19:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4E36118FC9CA; Wed, 26 Mar 2025 09:18:54 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v3 0/3] Fix late DMA unmap crash for page pool
Date: Wed, 26 Mar 2025 09:18:37 +0100
Message-Id: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF2442cC/23NQQrCMBAF0KuUWRtJJmmLrryHuIjp1AZtU5IQK
 qV3NwQXCl3++fw3KwTylgKcqxU8JRusm3KQhwrMoKcHMdvlDMix5lJwNut8m517sei1ebJu1Ix
 LiVJJrRpOkJezp94uRb3CRJFNtES45WawITr/Lu+SKP1XVrtyEowzgwKpbnWrDF48dYOOR+PGA
 ib8QbDeRzAjQki6G3FSTS//kG3bPoiHBwcGAQAA
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
Toke Høiland-Jørgensen (3):
      page_pool: Move pp_magic check into helper functions
      page_pool: Turn dma_sync into a full-width bool field
      page_pool: Track DMA-mapped pages and unmap them when destroying the pool

 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 +-
 include/linux/poison.h                           |  4 ++
 include/net/page_pool/types.h                    | 65 ++++++++++++++++++-
 mm/page_alloc.c                                  |  9 +--
 net/core/netmem_priv.h                           | 33 +++++++++-
 net/core/page_pool.c                             | 81 ++++++++++++++++++++----
 net/core/skbuff.c                                | 16 +----
 net/core/xdp.c                                   |  4 +-
 8 files changed, 176 insertions(+), 40 deletions(-)
---
base-commit: 45e36a8e3c17c4d50ecbc863893f253fb46ac070
change-id: 20250310-page-pool-track-dma-0332343a460e


