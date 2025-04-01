Return-Path: <netdev+bounces-178484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E9AA77270
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 03:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8620D3A8633
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 01:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6637313635E;
	Tue,  1 Apr 2025 01:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0lemj78U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2139EEDE
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 01:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743472408; cv=none; b=mw+FHl84RB6pdAunlDRPPDClhBMYEoCP88gdAF2b8h7yUspDbJ9d/Xdzp5Z+CuMkTL9VgOPJOh/r5m9OSU9IS/fFoJV8ylMRMbEPXNndPHx1KOD0GMrEQxxEGMT56crE2BvXlKMFdnYBtH5yUjZitqiYbDKBgjSd+efDZsByYsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743472408; c=relaxed/simple;
	bh=khj3I8hr8oDzUh0PLOjj1KDH/DL6+fu/siTxOHYY9bk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=u2mRznxYDWp1i6DO3e0eKUsMSQCvva2mf3e3vFLhxgadkke0J9O7hTkycZAC6JWscvTRKlJGMTlyotJw3fFlah19za3qQ73P1VVLd8DVwGuQufFeckvkxXMMhvQh7fqrc2caX2LbxqjC/6EhHv+3/CHxw7Fa5QGLKcZCao8gWr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0lemj78U; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso14395277a91.0
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 18:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743472406; x=1744077206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bkNNQdpSk9bbcKCM99d0+en1tupRsaQZtQor4WU6i8s=;
        b=0lemj78UX6L8bVTeTcAQ011f78/5q/1OJ5fGsF6YVLL+rkIaFERticD7b+6rbtCtEU
         IJkpkn2oe86aAmx5wBaA9kTE+ZSXr/duwtcnkXio7fAAmZH7Mq7eZQ2iFHq/60+JCciM
         ky5LpqnF5/slfs+5gthm4deHRrcZtJyNXaYCFxp+FZ74XRgU0CXS+kn/WJARnrfl1EAb
         RfJf4+xNllBxANYHaj3176avsGSAgrx/fqf4O00vpBkrVa1cHpQW16p93mTi2Gjhbt4o
         AKcxSHpCcQLx6tljkoh/aEUzb4x282mpSX2QllOVu1vC9x8KjJwQM/3qJbNi3oz8tVL9
         ejmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743472406; x=1744077206;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkNNQdpSk9bbcKCM99d0+en1tupRsaQZtQor4WU6i8s=;
        b=qeLX9EQv0VokxjFdGoBbQu+tSHechFjP2OUZyhxVhk5G2V6kNRyh9yRL9V2MW2UeB2
         MzUMFdXH6Msux1FktD1HJ5lvwhF5kMOQFnHJ1urikpYUvi7X5j0Brn7YghBKSwj1KIbd
         p5S7V51ZTfu+hrAjisDyagNn5vfXPxf2ECWGTLzf7cfTDFJqvYhYpyq5vRUL+2lku+26
         uL2YaltRNUro89DpS3jAzFHFTyZrz5YyUC4HrYSDKVaHisdzjWQKmCsxGpGBneCYxuvQ
         UOU9bJGo5Ryv2G74ZgnNZYBfL+wyd67KHjLSPJxqR3T3m+H/TdCNsddM7uj7rRLE3Y4P
         XxVA==
X-Gm-Message-State: AOJu0YxjJFq/CHtZyEGTPF185g3kbwivTYXU+dd5yWm2jYkL0Okr+kL1
	/9+aDJHI2WXH5t2A4wXffE9C/SmIJ6w/4YeHfng5tzlcdvdBIYfEB4PHl+lJ4o983RtEAbWHg4k
	KCg3Bfw==
X-Google-Smtp-Source: AGHT+IEnK8LH0fg0laboEMWyVSOSyKeffrJ8PKEqxYzH2W6ofzvPImjNul10lI3H7St49aRK2fEenZVHUU9L
X-Received: from pjyd14.prod.google.com ([2002:a17:90a:dfce:b0:2ee:3128:390f])
 (user=gthelen job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d2ce:b0:2ee:aed6:9ec2
 with SMTP id 98e67ed59e1d1-30531fa153emr20864641a91.14.1743472406332; Mon, 31
 Mar 2025 18:53:26 -0700 (PDT)
Date: Mon, 31 Mar 2025 18:53:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250401015315.2306092-1-gthelen@google.com>
Subject: [PATCH] eth: mlx4: select PAGE_POOL
From: Greg Thelen <gthelen@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"

With commit 8533b14b3d65 ("eth: mlx4: create a page pool for Rx") mlx4
started using functions guarded by PAGE_POOL. This change introduced
build errors when CONFIG_MLX4_EN is set but CONFIG_PAGE_POOL is not:

  ld: vmlinux.o: in function `mlx4_en_alloc_frags':
  en_rx.c:(.text+0xa5eaf9): undefined reference to `page_pool_alloc_pages'
  ld: vmlinux.o: in function `mlx4_en_create_rx_ring':
  (.text+0xa5ee91): undefined reference to `page_pool_create'

Make MLX4_EN select PAGE_POOL to fix the ml;x4 build errors.

Fixes: 8533b14b3d65 ("eth: mlx4: create a page pool for Rx")
Signed-off-by: Greg Thelen <gthelen@google.com>
---
 drivers/net/ethernet/mellanox/mlx4/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/Kconfig b/drivers/net/ethernet/mellanox/mlx4/Kconfig
index 825e05fb8607..0b1cb340206f 100644
--- a/drivers/net/ethernet/mellanox/mlx4/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx4/Kconfig
@@ -7,6 +7,7 @@ config MLX4_EN
 	tristate "Mellanox Technologies 1/10/40Gbit Ethernet support"
 	depends on PCI && NETDEVICES && ETHERNET && INET
 	depends on PTP_1588_CLOCK_OPTIONAL
+	select PAGE_POOL
 	select MLX4_CORE
 	help
 	  This driver supports Mellanox Technologies ConnectX Ethernet
-- 
2.49.0.472.ge94155a9ec-goog


