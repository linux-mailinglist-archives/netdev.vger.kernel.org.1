Return-Path: <netdev+bounces-155322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A071DA01DF4
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 04:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F7C3A2847
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 03:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BED01922F6;
	Mon,  6 Jan 2025 03:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGAcRdBt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D8ADDBC;
	Mon,  6 Jan 2025 03:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736132562; cv=none; b=YO79D89XnrZHXnHvZwvnXoQzlPmF1SiWJrMnIvhR8GQt+VrWPKc8VXGDm8NhLheiv5qV2j8rn0knPIoosRi1TFf9VJnMyGyRzKBHvnvftBZbR915lAf65+FmVtR12OPbH8J22dgMZ5cg2AMYLX34eBzfN5H7tR4YQXZE72h/L0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736132562; c=relaxed/simple;
	bh=JKyfSyzXC5mcqUHgk5ZkOYyziGIDu0bln831P0tfNxY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qVRM9kxd6k4/MNbAXOngUHI5BSfEqxh0nKkuae74SGqBjQlTlwJoEr70WdRhXUAq+hNIbVDEqxpuKfs8w6aPtQsdT9JkRWJ6QMdRRCtK43/0te5Mi//QFo5Yuo4lczZlCgzPqQRJTu6l3eoAPQ4tOsMRZb2tohNijvkSxCNcBSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGAcRdBt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2166651f752so231627235ad.3;
        Sun, 05 Jan 2025 19:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736132559; x=1736737359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AxiEEtlY4lpZJREfhv1oIjPVrgHpaoqRpg2Wpc2BfMQ=;
        b=gGAcRdBtbhOlOT8SwAbjsPuaaa+Vw9J4QiGIbcVMKDURqRlnFTC8zw8aWoX1C3ncXQ
         LRssl4sLAl+6+nzoVSYzaab7w+y1wwFd3vvSHUnbqsEUcyDjMgB3eVs5r7IoWzBrB5pO
         1UvQbb0WhsKpgzguOdeM44yKPahlZMdrnM4Xocv6NG/nP9h1OL2NijtSqi+sp6mv3X9z
         1wsGejKcmHJNp6YjXBSpzFuBhCPhALvubH6BZsUhk0w94bqFQYlbHtyEGCNTL9UQhZhm
         hA6ibs6pzai29VWi8qRPqegNhVF1G9Wm70c+xsQyD2H34PpBX+SdkS2wwSJWpgJGnwvC
         DaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736132559; x=1736737359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxiEEtlY4lpZJREfhv1oIjPVrgHpaoqRpg2Wpc2BfMQ=;
        b=vGx0R6IjX1TnOrnEqYdVIokcExFnkcTCU8H2WqTG73nWQvsbp2sapyg/CIMEtBL4yO
         ofN/MyuQMSjOucf3/J7Sc4ZbYdDzTTVocS37lAMwz+dGagnrNXLPi2HafrZAb4od3aRR
         LjlZjc97FhTkIE5vNvThrKCR32hCk/IWQsudepQ/CUO6kbdlwP3lCDJwc4RSAEoIVqGS
         h96yVpePtfJe3izRHqJiZAJuCZqgxRHt/ZND6bTHEAhdw+kt9gZgVRY8YEVKxaIyKe3y
         Yy4CwTzXp8vuexv+d2gqsqKoNqYtOYzrnRJCYW56zagisujf5hVXBaPi5UfQqhOOd1Lh
         3JIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBxTWorPPQ+9oBC7mNUPhddOBDdG5dzdGWn/zc7Cka6lyXrRFVoUtwycelPBvo1cdxoiRFqY203zWU5OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB3D+S1ZLsiPdPlKOvu/aiRhs7v2ACuPUYREzW+OvhuNEOWQUe
	6uDP+snhVCyHZAtiQULh3ejb+e0OQrRMf875TLt4fYzaBvwC/bHb7CjtPA==
X-Gm-Gg: ASbGncsuYEox43/i0sVnzoMGs6rqOo70OWWjS8fFQd12x6qR4O/4wxdkT0N2X3VGuiV
	Ii4v8O9CVLodSD5WEmOT/pT+jAP6Fpi9gPt64egL8yNHh8Vpyy2FZIRV/wSR9NQtnKGWfnA3WXu
	GR2luMDM5UD4AU57t0DttP6B68E1Tkh4dQeS7EmiqheFQ1cDwxNQIfe7ACyGZVg/AODFQQOyIez
	Mk0vihc7Ud/XkUehCpYUm94pUvzysgVdsKAggcluzDsx7CrPkZV7RT56ZZwbGj04kIPjw==
X-Google-Smtp-Source: AGHT+IHeNwDjkn/4y7dMABu4WpVf0nniRmUIrtT0soeUrzWjFIQbjlXmqzCm/jMD6LrmoEHSpm+etQ==
X-Received: by 2002:a17:902:fc84:b0:216:356b:2685 with SMTP id d9443c01a7336-219e6e8bb95mr890166565ad.11.1736132558903;
        Sun, 05 Jan 2025 19:02:38 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-219dc970c84sm281981745ad.58.2025.01.05.19.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 19:02:38 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v3] page_pool: check for dma_sync_size earlier
Date: Mon,  6 Jan 2025 11:02:25 +0800
Message-Id: <20250106030225.3901305-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting dma_sync_size to 0 is not illegal, fec_main.c and ravb_main.c
already did.
We can save a couple of function calls if check for dma_sync_size earlier.

This is a micro optimization, about 0.6% PPS performance improvement
has been observed on a single Cortex-A53 CPU core with 64 bytes UDP RX
traffic test.

Before this patch:
The average of packets per second is 234026 in one minute.

After this patch:
The average of packets per second is 235537 in one minute.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
V2 -> V3: Add more details about measurement in commit message
V2: https://lore.kernel.org/r/20250103082814.3850096-1-0x1207@gmail.com

V1 -> V2: Add measurement data about performance improvement in commit message
V1: https://lore.kernel.org/r/20241010114019.1734573-1-0x1207@gmail.com
---
 net/core/page_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 9733206d6406..9bb2d2300d0b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -458,7 +458,7 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 			      netmem_ref netmem,
 			      u32 dma_sync_size)
 {
-	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
+	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev) && dma_sync_size)
 		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
 }
 
-- 
2.34.1


