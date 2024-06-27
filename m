Return-Path: <netdev+bounces-107107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C42E1919DAB
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 05:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1192852A0
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 03:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F94617550;
	Thu, 27 Jun 2024 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Bx4X0UfJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ECA8814
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 03:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719457336; cv=none; b=o9tjoweNBpeZJ71Mwez9xZeGy4VrkQzZdGOzmWNIQgBNWVRSSzLfMmF2fnTsIJf9GAG93pezBcN7IWNQ6nthR/JE0bvbJ5bOF4YwRp/qn+xcvYtCKKua01IuUrtY333/QLtql/HC/b/LqMuzOuAliG0oFoyZ1d+RLsfNu8MmDOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719457336; c=relaxed/simple;
	bh=Ri3gwW84s9wVKaCLM3zQwwfrxSlC5ht8h/hZe/9T0Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2vmIe6/XGV3drnVlwHpCM3YeT/j0eqcubeXkHNkZrdIQZEjhioEAtiF4gRrzQM/pVrSySoHloabxEKD/VrlHDiI+zxY21t/ggtIt0gfVzSQ1xYnT39KagefJbRjUIZuX71LjqImmrAVkk8dsSWocCFLsqWbc++I7wdoMZum6FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Bx4X0UfJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7066a4a611dso3556448b3a.3
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 20:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1719457334; x=1720062134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ds92XtLfVyAziOBJ6DrlOp7NWpu8h2BwGdkFjXNkYg=;
        b=Bx4X0UfJOj7cEqeHjhgeRKnvivcuVT+4dekyhDiEGCwxgsgjftJJLoihkdfyYCZlgf
         ydESGr1kEujhmG1yByuTcWKcA6Q0q76Z7+vHjkS5aBmiMuk4kJL9xsGLuM/B8Y6BQc/G
         M1NKM53NivSDEpwELaESz3rZJ1r9up58LLgOPIPPjA6NaqetY0oZ0oCHGbaTWpbWzQA5
         lGQnxp99hL7IUM2z11HkKRu0jz6RGsZXjIfjtoTlf4vhrl/4E+/U2gn/hLH8T0KAQzhJ
         wMPg+T6UHt/ftRXzAKJCFGQFvK8ldKUCvcHr73urgM0EdGv4i8BZXbYNYnauHasLIO4b
         J8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719457334; x=1720062134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ds92XtLfVyAziOBJ6DrlOp7NWpu8h2BwGdkFjXNkYg=;
        b=b6mAPHlIagQJq+8AZ7VFY5Ui+aDg4so1QeGx02shRi2dSV8EZsGVKe9iGfq9gPgG+e
         6eLANacnK7Qj9vq9w+fLU7PQiwknsSDQGq5gp1uIAxP/t6tNuq2eyFFHGs0+aE4gA1Bz
         xaYX8FJtNHy8x6l8k7KngTXi1wG/NY+JJZpKW/eZqSdw5L8L1w4lZRGwEguXc06LZWZ9
         karTWw3wEWsWoq1KN02bWEhccDSgaVY6PcbPv1NP6VK0y7/NgHoFn74i2GUhrFVpdKhe
         hLCxPmE4ryilS7fFZaiSIrYjWAcR11LuQSPGUXxvtPFKFVt1nnvP/sLE6AEKI1C5B+aw
         0EBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpOPZwWa4SRQXNF6k7HSVUGyYAyUH18oxNbo/uvMcGw3qQ3zYU2yMMfBjWt2toaml7v1IyI6LOeA2xC4zLPbwEnRnKX+Ev
X-Gm-Message-State: AOJu0YxQzzDDsvSyBmxIL7xDZmNPS+FPWby3huwRH+bO9fE59ZZSQik7
	rGmBNDQZVJOcPD+szxK8ZAykMhLBZGixtzFSjzq/cWylTuHcjenL7dQCsbcw5WY=
X-Google-Smtp-Source: AGHT+IGeFb6W1kU4rXCBb/534IFVieLQNt+6ZsIZcj7KQUVs4I26/oSHYtaXMOFml4QQe3AW7QnGdw==
X-Received: by 2002:aa7:870e:0:b0:706:6f82:7e0c with SMTP id d2e1a72fcca58-706746b5896mr10379652b3a.32.1719457334492;
        Wed, 26 Jun 2024 20:02:14 -0700 (PDT)
Received: from localhost (fwdproxy-prn-036.fbsv.net. [2a03:2880:ff:24::face:b00c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72748e868e4sm206291a12.71.2024.06.26.20.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 20:02:14 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 1/2] page_pool: export page_pool_disable_direct_recycling()
Date: Wed, 26 Jun 2024 20:01:59 -0700
Message-ID: <20240627030200.3647145-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627030200.3647145-1-dw@davidwei.uk>
References: <20240627030200.3647145-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

56ef27e3 unexported page_pool_unlink_napi() and renamed it to
page_pool_disable_direct_recycling(). This is because there was no
in-tree user of page_pool_unlink_napi().

Since then Rx queue API and an implementation in bnxt got merged. In the
bnxt implementation, it broadly follows the following steps: allocate
new queue memory + page pool, stop old rx queue, swap, then destroy old
queue memory + page pool.

The existing NAPI instance is re-used so when the old page pool that is
no longer used but still linked to this shared NAPI instance is
destroyed, it will trigger warnings.

In my initial patches I unlinked a page pool from a NAPI instance
directly. Instead, export page_pool_disable_direct_recycling() and call
that instead to avoid having a driver touch a core struct.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/types.h | 1 +
 net/core/page_pool.c          | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 7e8477057f3d..9093a964fc33 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -229,6 +229,7 @@ struct page_pool *page_pool_create_percpu(const struct page_pool_params *params,
 struct xdp_mem_info;
 
 #ifdef CONFIG_PAGE_POOL
+void page_pool_disable_direct_recycling(struct page_pool *pool);
 void page_pool_destroy(struct page_pool *pool);
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
 			   const struct xdp_mem_info *mem);
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 3927a0a7fa9a..5f1ed6f2ca8f 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1014,7 +1014,7 @@ void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
 	pool->xdp_mem_id = mem->id;
 }
 
-static void page_pool_disable_direct_recycling(struct page_pool *pool)
+void page_pool_disable_direct_recycling(struct page_pool *pool)
 {
 	/* Disable direct recycling based on pool->cpuid.
 	 * Paired with READ_ONCE() in page_pool_napi_local().
@@ -1032,6 +1032,7 @@ static void page_pool_disable_direct_recycling(struct page_pool *pool)
 
 	WRITE_ONCE(pool->p.napi, NULL);
 }
+EXPORT_SYMBOL(page_pool_disable_direct_recycling);
 
 void page_pool_destroy(struct page_pool *pool)
 {
-- 
2.43.0


