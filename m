Return-Path: <netdev+bounces-178206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80409A7578D
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 19:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9712C7A3749
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 18:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472E21DEFD9;
	Sat, 29 Mar 2025 18:57:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9891DFE0B
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743274642; cv=none; b=tiq2LQ18b7jKbo/PMC4JXY8LAbfcpHybruuAP6Jkb6mLTV4BdbCDIU15tI3B5InOhTcGpzOuqsGFHIhjGOR6o/XrkfeKnQhYxpE0oNNRANgiMy37szEr37PoLUhgknmOZMrO2F2+Ej+Vtlrrpv6KnMzmggnkrUcO/JMRN9BkraU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743274642; c=relaxed/simple;
	bh=vfxSILg7Dt9/kKWbl0XzVC6ljAEF+FnMQQXqxT5C4e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VB75FRz9rms21nGBu1oA8yVS6zl/WHT4lDs3211FnIfe3y96+YIGIXmfyjn7ewvP7g6J+siz7251nUAZzOPKTW3x/7LkuPuJW+KTvK3BYrwKMpRKCu0sgyQuZXL/96og31aBQJhCx+3ILweNFgG8k1hkmGB4z1w2n0IYtrxeGXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-226185948ffso66617355ad.0
        for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 11:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743274639; x=1743879439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Os/U7o5A7vY4zqbL9CfE3FsiEugWyA5SJaeZg8deXM0=;
        b=uidc+HKQg1FZLjq3Ar60d/Dzlp8CfqvCnTpntLRsrBSlfOifl8qIgyUjoczw5M1Y2f
         Tq362aDZvScUM2UHt6KBDnzbwrs4z+yPFiDiY9qlUO1auVrrRfO06TA9D+DJ23GUA8DS
         8eSfQ2+5aA2T1zT0Y1FaPYIM7a2SOTzVaIY3xqPR4tIJynhp4ji33n5n5iz3Z9hT5c0f
         Md9kwHw7S8A7WBZpBwrcYHj+9phokFonGSH61+mu8YlX39XpHsXagQme7vGBy33d9SYN
         B/l+CW57arvo12cqAbmWv1kb8rPmc5WYk1O3oR9C3Gy2ZbVBdYcHeSZfLivwTImnO0ak
         B76Q==
X-Gm-Message-State: AOJu0YwduzhtGEFdrhZb351O3cbklw0f2jYkqKcgUbdRiS7GaQCJaTOP
	Xt/ohDlpk81jxAuqXmi0S1BpepQ5KAeCDjaTADgCQXrrrphJDRJQRv+KT64=
X-Gm-Gg: ASbGncuWBL9QYeJXWareKKRej6653ppelQEVBlk5DySi2LdCeoxxjDcq129NxG3iyJe
	b4vo6tpNJEGWaa7F7/QkXiB7g5PAMwBPLp+W2uSQhodVkBg8h4l3pH3ZA2LyGT8B78jmgs2sStT
	QlaY52s2vgX3FZh6Xql1Lo80EmBvbiasLNMb1H0Q4zqVw0i787GkB/i8ZzstbYRTarg8ENPtGVu
	p+doXgUfMmhcK7eMxdbvNLmQDwvU+YMmhSgKivq1jQRkNUGIPO5jY5o14Bl1NW/neQ2dGzrh0yq
	mgeM3TLLmoAgJxP6CivcZl5iDY9nebe2cEaws0BCp4c7
X-Google-Smtp-Source: AGHT+IEJkRowgtjJrozf5x2QeK1AXF1mRh2cFhF4jDRzFLt4LHMZzjgWMuqxAx6E9/mYs7gkYj3mLw==
X-Received: by 2002:a05:6a00:2e18:b0:736:51a6:78b1 with SMTP id d2e1a72fcca58-739803ab862mr5293657b3a.11.1743274639322;
        Sat, 29 Mar 2025 11:57:19 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73970e2243esm4069147b3a.60.2025.03.29.11.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 11:57:18 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v3 09/11] net: designate XSK pool pointers in queues as "ops protected"
Date: Sat, 29 Mar 2025 11:57:02 -0700
Message-ID: <20250329185704.676589-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250329185704.676589-1-sdf@fomichev.me>
References: <20250329185704.676589-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Read accesses go via xsk_get_pool_from_qid(), the call coming
from the core and gve look safe (other "ops locked" drivers
don't support XSK).

Write accesses go via xsk_reg_pool_at_qid() and xsk_clear_pool_at_qid().
Former is already under the ops lock, latter needs to be locked when
coming from the workqueue via xp_clear_dev().

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h     | 1 +
 include/net/netdev_rx_queue.h | 6 +++---
 net/xdp/xsk.c                 | 2 ++
 net/xdp/xsk_buff_pool.c       | 7 ++++++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cf3b6445817b..9fb03a292817 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -688,6 +688,7 @@ struct netdev_queue {
 	/* Subordinate device that the queue has been assigned to */
 	struct net_device	*sb_dev;
 #ifdef CONFIG_XDP_SOCKETS
+	/* "ops protected", see comment about net_device::lock */
 	struct xsk_buff_pool    *pool;
 #endif
 
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index b2238b551dce..8cdcd138b33f 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -20,12 +20,12 @@ struct netdev_rx_queue {
 	struct net_device		*dev;
 	netdevice_tracker		dev_tracker;
 
+	/* All fields below are "ops protected",
+	 * see comment about net_device::lock
+	 */
 #ifdef CONFIG_XDP_SOCKETS
 	struct xsk_buff_pool            *pool;
 #endif
-	/* NAPI instance for the queue
-	 * "ops protected", see comment about net_device::lock
-	 */
 	struct napi_struct		*napi;
 	struct pp_memory_provider_params mp_params;
 } ____cacheline_aligned_in_smp;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index e5d104ce7b82..98a38d21b9b7 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1651,7 +1651,9 @@ static int xsk_notifier(struct notifier_block *this,
 				xsk_unbind_dev(xs);
 
 				/* Clear device references. */
+				netdev_lock_ops(dev);
 				xp_clear_dev(xs->pool);
+				netdev_unlock_ops(dev);
 			}
 			mutex_unlock(&xs->mutex);
 		}
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 25a76c5ce0f1..c7e50fd86c6a 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -279,9 +279,14 @@ static void xp_release_deferred(struct work_struct *work)
 {
 	struct xsk_buff_pool *pool = container_of(work, struct xsk_buff_pool,
 						  work);
+	struct net_device *netdev = pool->netdev;
 
 	rtnl_lock();
-	xp_clear_dev(pool);
+	if (netdev) {
+		netdev_lock_ops(netdev);
+		xp_clear_dev(pool);
+		netdev_unlock_ops(netdev);
+	}
 	rtnl_unlock();
 
 	if (pool->fq) {
-- 
2.48.1


