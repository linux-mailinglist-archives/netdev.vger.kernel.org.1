Return-Path: <netdev+bounces-177627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1938A70C0E
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175E4840925
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE2625EFB9;
	Tue, 25 Mar 2025 21:31:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18E9269CE5
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938270; cv=none; b=GEW1Ivm8E1FAHupK7LxtYpfPZGNB+pJwyL7F899UL0q+6IhjZcQmBsyHpE8ltdc3rYjOH19jGoXUV5bWgm8l3qEkV3Wzb/nqOiyW7V6fpNsQlRRpzQRdrRFwKRR1OLb2nQTMDwd/wFltLMLOODWT2GIZ4KB+EI+wgd4ozhS7HYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938270; c=relaxed/simple;
	bh=rycKGXFoqAeC5tPx/73rvy9De8EwBoLt/+IT2SfEVXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcMuFNdw0/2dixNfd7meWtqM8nIVMRufAjUXNSBqopA/IKLtlTJJK1zHrxzfKV9CDhN78bRRn3tj4L44BF1ZhZ7OMn3amUoYSh2fXuBMGsgrn5fGjDNG5CsqMXLUP2uaiUaHd/DO9hA3vVC8RbXhzhNdsXnFwewhKgFIoZMouEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2240b4de12bso58100395ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 14:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742938267; x=1743543067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aE5CppWR6I6v1fz3Mt2HH1HdiF5SrnQoNwkZhPjynWg=;
        b=BaIahJ/OHkL8cpXSmzaWHswKP7Zmr5DMtULZ/oR7kyfmPZ7dx0Tnti0KzsTSsr09Vu
         7Q3+MqNoo+VFLEHyku05+MsK1RRsu08zSvRAbECE2VyCs8TzgE5xcbuHBZVh5m93Apyh
         NWkNevXb7CvKwMMaC1LBqDlxAGTYaSKHa4Gc0tJJwO0nfyiMVJoLH5EZgvmmnVcsYT9c
         BSv3QBfrrMfW6HbPTQgyUzrbzYNqmTvdk05yuZQxjghI9iJawyPm9cWJT4RDM6wg91di
         DjK+TsadsUvzkNOxrO+QGv2Ia5lsBqiv3SiLShbcW5DE15U2kNqNHF6ogJEVDgTOtxJs
         8KLA==
X-Gm-Message-State: AOJu0Yy3dnoxofEVgIR9j8F7207w6xjuwRzg2rXyUXYagtsZeFQVWCEg
	WHez7zc6Qgk0fn6Ba8ld8Lnj3jt0mdtZtPhRW5s+5CfPTTjo182IDgFHxcOpqg==
X-Gm-Gg: ASbGncvDlIV7J9kwh+YfUBny94d8xt0ULIlUNwVk4X5ghTBwojAT1cKmxeSgPJx4Mw6
	Alq/sLSa3OeTol2RaktaJ88wNIDfy5q3Dh28GauuoGpsMfw4ZSFsnKxqb7Vw4LXguXpGu4dMhmb
	eA1bdZuCtCGP6djgLCOq+/90OvspEaU5A45H0FjFCTq+TStSabXG8+Iv+rHjCwAoIzGBgAGH7Rr
	7hvD4Gk9FnO+40rWdsy6S7udrwGLNrPhp3+Mc4Hy/Iej1yR9LqUFV2NE/57NtW9pihj3MzTdKDP
	NQNiFJSndlvpYbZPLPF2Uk7mGK+PnrLpePlMosy2eGyn
X-Google-Smtp-Source: AGHT+IHZf3Mp0naRThMQomdyYw1aEdk1eMLcZBPlOtxqcR801njRpKTtZkAbuqRTPWLShDqy+LhXHA==
X-Received: by 2002:a17:902:e54a:b0:21f:85ee:f2df with SMTP id d9443c01a7336-22780c79888mr270957775ad.15.1742938267261;
        Tue, 25 Mar 2025 14:31:07 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227811da2eesm95631605ad.172.2025.03.25.14.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:31:06 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 7/9] net: designate XSK pool pointers in queues as "ops protected"
Date: Tue, 25 Mar 2025 14:30:54 -0700
Message-ID: <20250325213056.332902-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325213056.332902-1-sdf@fomichev.me>
References: <20250325213056.332902-1-sdf@fomichev.me>
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
 net/xdp/xsk_buff_pool.c       | 7 ++++++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b2b4e31806d5..b3d1c1922ec0 100644
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


