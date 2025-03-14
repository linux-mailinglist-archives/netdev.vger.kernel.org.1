Return-Path: <netdev+bounces-174836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF17A60E7E
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 11:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBBD8883006
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 10:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAB31F3BBC;
	Fri, 14 Mar 2025 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpVCqqfF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A081F3BB2
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947147; cv=none; b=Xrn4S6P+qfC5csPdWmMdSd7F1L2b1b93ZvL5URnySL0FYV4t2s0mQdBlJSBou8zU7wYcHQE2dKb9ujttj5hfaXk734zvaYQUhFTANT6JwnnSyp5WjE1e77R88Kn8JtqWbCusljFN313WNdc35fauroCjNg57fuIMdgGs81yAfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947147; c=relaxed/simple;
	bh=ZwQLt7Z4tHTJcWoA9ARFUEED+hl5/cCffTRlgZa7WQU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cyCEi+wMJgbX4oKAdmMc3e4ohj/GjMUc3e/m8MH2BDyr1gBeKMOv75UcQEkvBuA0zD6GCSVnfOUrmANei1Q8bh3uhBnV03dxaCFqYgxYT4DCteKqCNtdhhkVFeRY7ofv70IC2kg9l5yqlCbYcyW8g7XOJohPHTQYNATclbJGBo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VpVCqqfF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741947141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9gm2z62YPqNWN8yJwphL0g3OWPmFyfl9EtTC0QPQVIU=;
	b=VpVCqqfF73ZZSaIQJV5kFGtTMqdIhI+6uYvUmcMR+ergrLx4spkUJq2U12toySmInyr3pa
	/79e8MlIbpNVLy6t2ZXhEvEUfEPx3oRGDmXZWdQb9Xd3DY4e6MjFlg3P05kAqlKc2uwvlB
	3ifkaJ6g2l7jiM2iV0ejN+Yu1bpr6WA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-iOl9LxcWNCGo8FMvuFDO7w-1; Fri, 14 Mar 2025 06:12:19 -0400
X-MC-Unique: iOl9LxcWNCGo8FMvuFDO7w-1
X-Mimecast-MFC-AGG-ID: iOl9LxcWNCGo8FMvuFDO7w_1741947138
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-549979903c8so1029036e87.1
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 03:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947138; x=1742551938;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gm2z62YPqNWN8yJwphL0g3OWPmFyfl9EtTC0QPQVIU=;
        b=jaBUBGzSVri/lJRUEZ2lUHdLOnTeT3QpR1w7OqhPd1Q1cpSY4Caboe/Sq/1Ah9M5sx
         //aialcT5crPXTWy3jbNTdfPUF7R3fTp0t88oZs5Pj3/R6YNM0arc8TrOmUqYzMnVcol
         JJcPiDI4Bs4/Xs84FINVKP8/9amvvjjw3xEvtfR6VzWX4eFpZXtW5SGGy/fTHXRyA0yJ
         cFDZM/K/avlp2h7bZzT0ar20yngkaWPusAgo5H7/BMvg8THWX3yCBG9NYYCkfesC6Whf
         n/jhpQmdwEA7qpQCN+EerlOS44U5E7N7hUsnK7WCRzAdQmt8nd0U/dptneQDtdLiQwJA
         rAVw==
X-Gm-Message-State: AOJu0YwF2KJnMh71BEG/g8zSccIW8ICsPukbOybOqaG0b+N4isN2RU3/
	Z3FQyUfzlZBJhm+QYZWNVU7dbEWU8u1XHxFeCrOz52QvmNWPrNJBJ+TzYNae+p47wOit9wnF0BV
	hQmZgL/Buns0VpqFLv5nZhG3vI95qFAvRjeilfdPRKmkuwoRancUong==
X-Gm-Gg: ASbGnctfeOsMmQ7+FhMmvB2un624jXM8PeQW3R+RjYvM0rVeDVGxY8JGg0zu4YRTbMI
	ym60Pt4ZRJ/voLNrqyoVMLzUL+0FjD1nUyKNcB0tIo1NlhusBBeuuVpHcAayOWyxbCszRs9tD2E
	CB4AHlq2K7V4SJBUQw9cuAh2tlkt66Jfx68vxQxQzWdoolgzmkC8WBJIAH9aomw77trexJBO3tH
	BLLy/74wv7mWMykeCi0QcHjUuIHh5e6hVLMbBQ4yqdTfIvj6vu06+/L70YnJrV+Yeihb2VyV4+Q
	3MV/d8fQ/U0a
X-Received: by 2002:a05:6512:3ba4:b0:544:ca1:da41 with SMTP id 2adb3069b0e04-549c39897ddmr668063e87.44.1741947138256;
        Fri, 14 Mar 2025 03:12:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQUWKDrZlzJOt8qlYePG63LB20pTY5b0FHQCM+E2JqpqZhwzuf+fAjF8sgxJkwHe+V2bVHLw==
X-Received: by 2002:a05:6512:3ba4:b0:544:ca1:da41 with SMTP id 2adb3069b0e04-549c39897ddmr668037e87.44.1741947137761;
        Fri, 14 Mar 2025 03:12:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7c11f7sm477629e87.84.2025.03.14.03.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:12:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0737418FA92C; Fri, 14 Mar 2025 11:12:12 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next 0/3] Fix late DMA unmap crash for page pool
Date: Fri, 14 Mar 2025 11:10:18 +0100
Message-Id: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIoA1GcC/x2MQQqDMBAAvyJ77sKa1R78ivSw6KpL2yQkQQLi3
 xt6nIGZC7Im0wxTd0HS07IF36B/dLAc4ndFWxuDIzcS94RRmoshfLAkWd64fgWJ2fHAMjxJoZU
 x6Wb1f53Ba0GvtcDrvn+tpLJRbwAAAA==
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
Toke Høiland-Jørgensen (3):
      page_pool: Move pp_magic check into helper functions
      page_pool: Turn dma_sync and dma_sync_cpu fields into a bitmap
      page_pool: Track DMA-mapped pages and unmap them when destroying the pool

 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 +-
 include/net/page_pool/helpers.h                  |  6 +-
 include/net/page_pool/types.h                    | 54 +++++++++++++++-
 mm/page_alloc.c                                  |  9 +--
 net/core/devmem.c                                |  3 +-
 net/core/netmem_priv.h                           | 33 +++++++++-
 net/core/page_pool.c                             | 81 ++++++++++++++++++++----
 net/core/skbuff.c                                | 16 +----
 net/core/xdp.c                                   |  4 +-
 9 files changed, 164 insertions(+), 46 deletions(-)
---
base-commit: 8ef890df4031121a94407c84659125cbccd3fdbe
change-id: 20250310-page-pool-track-dma-0332343a460e


