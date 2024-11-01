Return-Path: <netdev+bounces-140922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 557DF9B8A17
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 04:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9DE7B21F16
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 03:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020631459F7;
	Fri,  1 Nov 2024 03:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HCs9zHau"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096CF13BC18
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 03:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730432934; cv=none; b=b/DymTBZjQpHUBOQ8jt8pFoNEJOAx1KiaFULH3D7QtgdSjqaH5zreEdv93CJyr5xsowKQHzdcskjcMIN9pz2bCIBiD4Esl23CMgIqfOIQVTUXdUSv/rvP4Wgni9GEtDqS1Ce0uIdc5z0dF6JOlpk+RKz9VnnJGHwctP4pr3p8bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730432934; c=relaxed/simple;
	bh=MZxHaEa7buDfvPC/4WE/aTVuUcf+xHReOo835eWZAUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PnFmt5b/C7S0cBZ3PhxZB/NOpz3DBn4qdAeyZLpr2morI815Iiu5tnPzN0Fts0aULt+1wX+T30f4J8YRspfE614Da5S1YXPMRa+kNF6MWWvdSrUl1YEoUmBc5W/RZs0llbVOXGihBW/IptW+DmaWDGmzp4TNpBelc3roMU29lBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HCs9zHau; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-83aa2188c2aso5829239f.3
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 20:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730432931; x=1731037731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iFtIYGNmdHvtGkRyGJ94EvP76ryCIg69gweJeFB48t0=;
        b=HCs9zHauggqjpYWcYjPW0xyxkRycf0hDSS39kyc0zHdFnydwppplgrE1wdeQ5NzVRe
         2UL+kZaSW0UlRFBaozlQ9QGRevlzr+YOgQ51qygXXOakv7lC1ga+Bqga7JWwRXQY+643
         AQq9+dpD8d0AyGWAWxH93XJYCQ8VQgEc3BTgmy3bKmdJKGgjOS8UGbC3L6nVO1B7dySE
         XHBr7ShVirOqWTMv8bzzHIXE7quxivyMA9NAmTszaZz4wKBGu+rkxI2atTOwnAbjh4yO
         TV1L0//awQova1WwEsJc0z6ZoIMswU1k1vHzkcfGP/PmP2lTcxWg+fiXfwoed5RjwdNY
         lR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730432931; x=1731037731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFtIYGNmdHvtGkRyGJ94EvP76ryCIg69gweJeFB48t0=;
        b=lkcgN8MuhBwh+z6Z506WdOmJK24TmBBA2YnwNuUDxVeLHEMlWrW9hGj8r/WU50BFXH
         iXUhpH5e+1kKUjrkdO0GQVfh3CJrUxqUkSnhPN8z6kcIQVrCgdjXnmHOy3sM1TVOQVA0
         mPbN5fnKt/NG5D714USEfr6sQcVJYiihST4D19jQeo/5f2ALPjERJvl2mNV8ruYzq9Fv
         Ch/no7RPZQYlDp4vAtPC8mRUke38pZMJzikprEms9FoQVnJjvKmp5o1RadDB4dq2tBC2
         nuGTk/7p8EAXRh/SLfx4DKmrwlyxqo8Cuq/rfJvJOrIemG+xttCdWsLwpbgdcsHX3lI3
         MnwA==
X-Forwarded-Encrypted: i=1; AJvYcCUnuwu02EPrX3Q/2WXM9h/zYmi2BEVEkO1PJQ90g5C2jOJsAlT2Bu3BACinhivkXwWZqa0Cb1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOvKKl7RNhOaaQhVIMwW06Sfs7XSqJgQWro0uRBT2cFICif4DK
	teKxGP4gUNcW/pAOOPDW7o4+5aCThOArnRv10I8UflGkbYXwWv/mMyiySEJF1nRCJ95RHeaHUyi
	lwSMqAVnnh9TY5ddaiXKNZuwOEeW+WrbC6cTGN78QHpjP6ntx
X-Google-Smtp-Source: AGHT+IGeAIngWc5LMAF4LFYsaT5zMsZvEQP0mtRiGlcTjVrfrCa0VFOydr5yNiWCR5zgfn9ud1jX8qtLZ/w6
X-Received: by 2002:a6b:d90c:0:b0:82a:a4f0:c95e with SMTP id ca18e2360f4ac-83b1c60c9e0mr536930939f.5.1730432931086;
        Thu, 31 Oct 2024 20:48:51 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-83b67cde42esm10054639f.35.2024.10.31.20.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 20:48:51 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D22243406A8;
	Thu, 31 Oct 2024 21:48:49 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BD92DE41EB6; Thu, 31 Oct 2024 21:48:19 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] mlx5/core: avoid memory barrier in eq_update_ci()
Date: Thu, 31 Oct 2024 21:46:39 -0600
Message-ID: <20241101034647.51590-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory barrier in eq_update_ci() after the doorbell write is a
significant hot spot in mlx5_eq_comp_int(). Under heavy TCP load, we see
3% of CPU time spent on the mfence. As explained in [1], this barrier is
only needed to preserve the ordering of writes to the doorbell register.

Use writel() instead of __raw_writel() for the doorbell write to provide
this ordering without the need for a full memory barrier.
memory-barriers.txt guarantees MMIO writes using writel() appear to the
device in the same order they were made. On strongly-ordered
architectures like x86, writel() adds no overhead to __raw_writel();
both translate into a single store instruction. Removing the mb() avoids
the costly mfence instruction.

[1]: https://lore.kernel.org/netdev/CALzJLG8af0SMfA1C8U8r_Fddb_ZQhvEZd6=2a97dOoBcgLA0xg@mail.gmail.com/

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
index 4b7f7131c560..f03736711343 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
@@ -68,13 +68,12 @@ static inline struct mlx5_eqe *next_eqe_sw(struct mlx5_eq *eq)
 static inline void eq_update_ci(struct mlx5_eq *eq, int arm)
 {
 	__be32 __iomem *addr = eq->doorbell + (arm ? 0 : 2);
 	u32 val = (eq->cons_index & 0xffffff) | (eq->eqn << 24);
 
-	__raw_writel((__force u32)cpu_to_be32(val), addr);
-	/* We still want ordering, just not swabbing, so add a barrier */
-	mb();
+	/* Ensure ordering of consecutive doorbell writes */
+	writel((__force u32)cpu_to_be32(val), addr);
 }
 
 int mlx5_eq_table_init(struct mlx5_core_dev *dev);
 void mlx5_eq_table_cleanup(struct mlx5_core_dev *dev);
 int mlx5_eq_table_create(struct mlx5_core_dev *dev);
-- 
2.45.2


