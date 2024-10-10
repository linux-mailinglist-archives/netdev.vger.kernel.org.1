Return-Path: <netdev+bounces-134187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6BA998536
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C7828828C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC431C32EC;
	Thu, 10 Oct 2024 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mojZMIJG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1DF1C2335;
	Thu, 10 Oct 2024 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560443; cv=none; b=uCwtbCekngdx1OxTrXs1Fb92JNxjvr7cQXO5sK00tLEEteA/CqdnLryIV3X953eEl7D+4s4YCZzcqalGZMebxERgOrj3GQO9k6UlqtWawlxSjeD1DDo2BXpBnctuBl29sgdJAqPVMBmA/sJRb2PhOnQkAna0DNVUG3HPwcT5fV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560443; c=relaxed/simple;
	bh=0nhrCr2PZs8ONEkaN8aHwqAMQ0ewXcVDmuq5hAdI4Ao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ep10/ouSPrKNlHIMaA09spXbz0bdm4oECsVYTqQp64HbJc0h+d7+QXR0+csLap/b9noEnjSKzKWak4HHmqpSKlIgXyBB1I+Q0YX5JKtYMgaIHsJkMprRhqQe//rw+8gNuT1pdZohtY2+8emT8tiXlk/1V7ZTFsrtmupPOLbE70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mojZMIJG; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2916a92ffso810241a91.1;
        Thu, 10 Oct 2024 04:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728560441; x=1729165241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0kfw5SfshTy6Jgglhl1DNAUC4ZZIqSCCMDDYRxuV0D0=;
        b=mojZMIJGGkyLpWyKftoK6gXjPeFO8x6QOk3M15HjQy8UCtcKxz0RgyOqD2Ba/AfgxP
         /HVLzl4w/RlrlqYXTSJTTDDLYEEufnWRUmyDG+KPjWfZpn/ngDyQp7v8BaNQHTdDhYlL
         YJ2xb///AVOJXqFXFWpZMl+GxszroXLRKhtdbCPGosnT7kjwfi5FfKGQuUVJ3PpMjoxq
         DXl4JGBUInwVAJGDcCGKLL8wVGFlj2siEjA9gAlbqe1VEqzd8EVyT5parzWf2WuXyV7f
         GuyFvG2SY34ctoWvs1ijfm98iKLN7n1eTj4tPJqEiJwPbI/RvnTD6k8bssh8/3/xjsB8
         0/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560441; x=1729165241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kfw5SfshTy6Jgglhl1DNAUC4ZZIqSCCMDDYRxuV0D0=;
        b=TWxQpzYIz/SFSQtFcToytQyQK79i3UR/KRKAN/VyX+MMSGM676+yPSZnDxhGlmi6S1
         44SimxjaOJLD2dRtUc6TyOwlqop3iNsdU5tdsxuPqGSsXqKkeYvwB8tpvKLN1d4rBAD7
         Rg907qKN7rZc1YZQ8C1dVK5KuN7bD7ZCIrR+hqjNFWX1zARidtjATreSyzqzhsI9VOOg
         tPk1J8Gq7pLHof+UZ12UHe/1pDAuqYD8FNl6RGQKvCTi3JakoyAz22lG21auFji2yoii
         5nOayFwMXHkccjVy1+EWTdQWvKeEZCQzVgZ/Okm1j86Esr1kSmZETKWrjJlrSjDs8AEv
         0uDA==
X-Forwarded-Encrypted: i=1; AJvYcCVVusYpj4gwXvSV8ZBX2mCWKMlq7D8AHb4AZgS4tW0ltqfRy+B8m4RkkHf7ezS/98A2lDEQiBRwtzmj1Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymw0wDX/eI5ee9opBI8+V5ePF5hpvX6Ar3FWX3QZrffeFttriX
	NUWSH6dXeVv8VHXBMR27MHTtuXmjFVMffc0C0/QpZHll/AsZNflErFLBiQ==
X-Google-Smtp-Source: AGHT+IEDxQ3iGYqIDhPytQarvl0jfe/KjMrCR6KtdwERdxwXsGade04JshGu0DnkUF57NPQiJSoLQw==
X-Received: by 2002:a17:90a:ce94:b0:2e2:8995:dd10 with SMTP id 98e67ed59e1d1-2e2a21eeab7mr7340102a91.4.1728560440899;
        Thu, 10 Oct 2024 04:40:40 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e2a5aaada6sm3396483a91.37.2024.10.10.04.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:40:40 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1] page_pool: check for dma_sync_size earlier
Date: Thu, 10 Oct 2024 19:40:19 +0800
Message-Id: <20241010114019.1734573-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting dma_sync_size to 0 is not illegal, and several drivers already did.
We can save a couple of function calls if check for dma_sync_size earlier.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 net/core/page_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a813d30d2135..fac52ba3f7c4 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -454,7 +454,7 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 			      netmem_ref netmem,
 			      u32 dma_sync_size)
 {
-	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
+	if (dma_sync_size && pool->dma_sync && dma_dev_need_sync(pool->p.dev))
 		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
 }
 
-- 
2.34.1


