Return-Path: <netdev+bounces-178658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6315FA78096
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F44188AEA8
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C03C20F078;
	Tue,  1 Apr 2025 16:35:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52720F063
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525309; cv=none; b=RjXvlswti3Qc5ytdH8mk/xKY5t1L3GSmoFgjoPaQHSblicLXc8HY5e4cGF1TvILO5/suftlbgoSnvrC7qQrPSnGCue5lANW3J1cKNaQu1F/rPx5k/xazrq9o+HKSBbpKNIh0xT03py36tFQ3RjiZDgkgjxeibH2j34Qcw7eNo/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525309; c=relaxed/simple;
	bh=tf/CChIRlAkfC+Vo8oKSHhJyTpfdaovsvldGu0jbXEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQUynFhUsYRNu9ZgZrZGZAVcpo0ge86Srn3qQpWpCrofE9qXMreDoRfxznBPMSpy5i+wi3lYr1i+nCz8ZqWPomSKyjwJ7zn9AqDqbAjKIMFr+D81L+6iEvmfc/ovelwpA91wPp0Y9K0F8ClWIPtl5rTpKwu5GFS4L24C4MCT7x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-301c4850194so8064791a91.2
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 09:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743525307; x=1744130107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6p3CjK1FzhuhSc0mPtP8gefXfwAJuXaqGhkba69pwL0=;
        b=Cl/wSChZ1Xrlt86ANjRvigxDPM/Tg4LPdOvBNUT0mLBHch37Qb1rKOfk21lfjA5KOs
         UWiaS+6JNT1hETTmDLC0MsW0kvykbmtauNkPem7avlg5LpvYvGr7+ZXUTmytVvGFhSJH
         35TVFom9/HvBVCj33vfiL+rcmQNzk1qzEnNV/6TAeLSTigBJNC6OygaXXiMQo6jsWxDs
         XxM1PM6osL8HBTyPA9EXH/U5sAstiUj5rUBnKsOVtkG55oFAukRbpw2p8AE77T7ezaVY
         oBiWcCfxcQfPbE6z/3ZhzvJc3aX6ilMQXz/U8BjSZiayloDgJsCGBC3/XaQlc1gGhscm
         bbCA==
X-Gm-Message-State: AOJu0Yw8l1lyEIh3W6iEKnPJpTweeIUCxO4zECLazTWLWLThbdTjgNHu
	VlaqT5NWVh3LEYpHi0/BSMfVONGSTZUhQSNY84aP6QWfxQFitXkKuT59T60jMw==
X-Gm-Gg: ASbGncsIMXkpBesZaKOuBcG/nZBaO6cjp+JdKtjx8AL70bxZdMumVxm8tWAfwIOojn5
	dWjVnb57J0AuLfqAfmoe32YWjCZxqyttg14YI0n+PYx36BzvmppCGbVywr95MvbezSiRxeSmxo0
	ZrNHg0R2E5UwMwewWsMgqoln64NgNNU8XQg5ungbfmDDknWjc33ve7uYG9GG09R3fGN9Z12q6jD
	wjeyECzKgFNgD2dUebUVYOrEPS3f4tllhXCjSw+W5fp213THoQIVA9tReVcSiTRDZVT3qtJ9Qlp
	11eiiqAtoLLRuUHFSKsrqXSchgZCtOIM6FnUzz88OM9y
X-Google-Smtp-Source: AGHT+IHkb6fll9FtZ8OBF2fS7+hDr23ynKzxNGZCtKyjfTv9c8AzQNFIiT6EKC0qn7NXB/tZTP/Vbw==
X-Received: by 2002:a17:90a:c88c:b0:2ee:8e75:4aeb with SMTP id 98e67ed59e1d1-305320af2b4mr24545193a91.17.1743525306885;
        Tue, 01 Apr 2025 09:35:06 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-305175c99a6sm9543642a91.40.2025.04.01.09.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:35:06 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v5 09/11] net: designate XSK pool pointers in queues as "ops protected"
Date: Tue,  1 Apr 2025 09:34:50 -0700
Message-ID: <20250401163452.622454-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401163452.622454-1-sdf@fomichev.me>
References: <20250401163452.622454-1-sdf@fomichev.me>
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
2.49.0


