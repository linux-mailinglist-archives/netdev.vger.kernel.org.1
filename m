Return-Path: <netdev+bounces-56229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF7380E373
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 05:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB04282383
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 04:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC8FD510;
	Tue, 12 Dec 2023 04:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fixjunTy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517A99B
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 20:46:48 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d05e4a94c3so46003825ad.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 20:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702356408; x=1702961208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QOHMCE8SbYViYKM+gAXWxTdAxXP0rvaIbcht/d8n6Hg=;
        b=fixjunTypsAIObn8CkkU6ABwaxLljNhHDtZ0oqmnM8pBY6drnxf7+XZdXLH6xUZecV
         R8gYB4oAfGIFoprfapCLumt0f+rwH2mlnnH5otiuTQI5nmZY6PQALlMZhYK2SgLyr9Xk
         y0G6wUiJ8gJIjSiMqZgJHXTcpc1j8TIOllMto5jzhvUh/lsMpxUoO7ejtjP2yVpbhhHY
         U7F24NrK5aoOm6eIbbTG96ketuHNV4TGE2fcm1CpH+bNbL+n8QG6QgxOZf8dG1IC/0S/
         cr8hFS2gEZlUK6TkdA5O2Qz7XZyVHmG6FxMdrMan/x0nQgM7gojRaqHsH1NC/BB2Lxx4
         J/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702356408; x=1702961208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOHMCE8SbYViYKM+gAXWxTdAxXP0rvaIbcht/d8n6Hg=;
        b=RU+HOYksC8R8+ePwjaHXZAKNQdcr1F/3QfRfmbCEtG7fkaxAtxW8CY5l+vz+E7umRj
         1nFiUbQYkZu3s3lFqzQViELFt5rXmPoSLKBhw83ze+YNP/w/fXnWNkmQjw/XEMcUpzCs
         Ho+Za6ghSYxbUm8O/8jNo/ZiM1rG+j4lmixVqYUxJHepLpetszBgHALlRSN91cS5OWMw
         H8XZENMpHXVg1dsSh+B3jSj2d9LqfCcdPRHMs0OlLPxorI/3QbNfP9q/b1iMtZl+sqDg
         fTgzI7TCAbKMZvKmuVqOIaGlDItofBiwI9ZAfeSjNtca/98sF3/IAyDNcCzLU2rD7W4U
         7ezA==
X-Gm-Message-State: AOJu0Yy/E75Vy4v+TYTivigzYgJFLkLyul747SdKlfJli7po50MLAT//
	TT58TV9jaXv7pv2yE/gGveA=
X-Google-Smtp-Source: AGHT+IFAHSN00lNacpLH640iju74Vcrj+ZbS0ULyrmsYtiKQNU7egtiasm4kkDNaA6Rcc0GRFD+WIA==
X-Received: by 2002:a17:903:32c8:b0:1d0:5806:f45d with SMTP id i8-20020a17090332c800b001d05806f45dmr5882500plr.42.1702356407670;
        Mon, 11 Dec 2023 20:46:47 -0800 (PST)
Received: from localhost.localdomain ([89.187.161.180])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902848300b001d33e6521b9sm36143plo.14.2023.12.11.20.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 20:46:46 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com
Cc: netdev@vger.kernel.org,
	linux-mm@kvack.org,
	jasowang@redhat.com,
	almasrymina@google.com,
	liangchen.linux@gmail.com
Subject: [PATCH net-next v9 0/4] skbuff: Optimize SKB coalescing for page pool
Date: Tue, 12 Dec 2023 12:46:10 +0800
Message-Id: <20231212044614.42733-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The combination of the following condition was excluded from skb coalescing:

from->pp_recycle = 1
from->cloned = 1
to->pp_recycle = 1

With page pool in use, this combination can be quite common(ex.
NetworkMananger may lead to the additional packet_type being registered,
thus the cloning). In scenarios with a higher number of small packets, it
can significantly affect the success rate of coalescing.

This patchset aims to optimize this scenario and enable coalescing of this
particular combination. That also involves supporting multiple users
referencing the same fragment of a pp page to accomondate the need to
increment the "from" SKB page's pp page reference count.

Changes from v8:
- improve kdoc for skb_pp_frag_ref

Liang Chen (4):
  page_pool: transition to reference count management after page
    draining
  page_pool: halve BIAS_MAX for multiple user references of a fragment
  skbuff: Add a function to check if a page belongs to page_pool
  skbuff: Optimization of SKB coalescing for page pool

 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 +-
 include/linux/mm_types.h                      |  2 +-
 include/net/page_pool/helpers.h               | 65 +++++++++++--------
 include/net/page_pool/types.h                 |  6 +-
 net/core/page_pool.c                          | 14 ++--
 net/core/skbuff.c                             | 50 ++++++++++----
 6 files changed, 89 insertions(+), 52 deletions(-)

-- 
2.31.1


