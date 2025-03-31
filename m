Return-Path: <netdev+bounces-178345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8389FA76AE7
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F0A3AE985
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8942721CC70;
	Mon, 31 Mar 2025 15:06:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E13021CC62
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433580; cv=none; b=mZ0gJcKEa8zhlgy+QKmeib8sUmof6ZIwOv+bEgKfhUtDjKOD7CSte7a0LGSHOVKybfvIEj8tv0hCqZ1z2jOxjvPdmBVYwl5oK/zmxolPm+X35SE0wJMSi5LBK19B3QMfZfvKwXZq1zfUekFjVELTC4vqPQW2xjC3z667NcQ2RxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433580; c=relaxed/simple;
	bh=vfxSILg7Dt9/kKWbl0XzVC6ljAEF+FnMQQXqxT5C4e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVrAFoIpfHpc2Sf4HWcZkyIL64BRiMrDwwi34EXX/KGEU+n6G/6/abYXPHqXlz+/r/mGOSsxiLyG9x3WSAn8/WoK0hYRiWGeeLcFn7JpCYEsDFj0xn31ZqogcGzHVmXDYqb5MsKZCXcM5jJqEmPkpI61wuwRPkvWE2mppDCF4ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22423adf751so83422735ad.2
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 08:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743433578; x=1744038378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Os/U7o5A7vY4zqbL9CfE3FsiEugWyA5SJaeZg8deXM0=;
        b=wVhllAvPk6oKT3dcpud+f1Qs86qzNljknVp3Lp3WISKu4n2lJf6Fd1otqUGTDIqADI
         dZZAjHqpmXiE0IgX2DvUX3TNChuD1ZT6umU1uhI6ErQMGdZ4Hn0a1mbzLhnx/5h2hHQx
         cXKOx6qGeYqF4OHXAfKIi6Ulx/TIsZWG7smVZgZyVMj7C6cnid7brFy5wEyIuboSuSg+
         RYtolawM/jWALN9BFMdzd4mbI3s3gXfJdzqfZIaYBKnd5hbXdyrMiojZpUNmaxVR6x4V
         t6Xts4ergO5YVvL+BoMso6srkd7zAVIn2e+Hk2vDnBWsnMBx6qEYkov4IM/+1VjkfZ49
         69eg==
X-Gm-Message-State: AOJu0Ywm5968v3eSBWBIvviRq64fc3xmyjVRoXLf6tlpY/qxPibmx7Og
	DUYI1zJiWeY6QITlS8r3yBubYt8IkelXeTD6Qxdxl0jKJMM3f75XEs/6
X-Gm-Gg: ASbGnct2htg6a8V5JIvHK6QftFfDIUSbiCBbLIU/NiU4TY/qvNZDdsdGosqHib4REZg
	Wu+GgKwYpNXccpFI4jpAl4BXmnRUOFV24SWGEebu99mJjQ3ledTAonJC5+bXIpAd588BC74SaYK
	d2rimsbZDMdnZlz89T4FAn5y1qGiuPNRJh4W/XTdgx0l0Ft9X/GjbiQF++fje9Hej6zad6D2u05
	tfhDHbhK+Z5+cm8ljwOxNes26ZJNelpSuZ86YpJyNZgwWPRjZ4YnmS5oIV0lfj2jMskwWgPHZ8K
	D6c9hI6glbMbO1BYmlnGs3gZCNznkgmUja8KeBBCZJzI
X-Google-Smtp-Source: AGHT+IGZRFaWb8l+NUNSkFrLRMGOajOD6nHsetfeDCR1GXYWJvU1aFxiNDQsmb68m+lMeoPewSQI3A==
X-Received: by 2002:a17:903:24d:b0:220:fce7:d3a6 with SMTP id d9443c01a7336-2292f9753c3mr139161335ad.23.1743433578099;
        Mon, 31 Mar 2025 08:06:18 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73970def163sm7044109b3a.28.2025.03.31.08.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:06:17 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v4 09/11] net: designate XSK pool pointers in queues as "ops protected"
Date: Mon, 31 Mar 2025 08:06:01 -0700
Message-ID: <20250331150603.1906635-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331150603.1906635-1-sdf@fomichev.me>
References: <20250331150603.1906635-1-sdf@fomichev.me>
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


