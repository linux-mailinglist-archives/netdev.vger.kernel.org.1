Return-Path: <netdev+bounces-191337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DF5ABAF0E
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 11:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2F33B700B
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 09:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EE2207DEE;
	Sun, 18 May 2025 09:44:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A130E1DB34C;
	Sun, 18 May 2025 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747561459; cv=none; b=nCDA+rKgPoCjmj6uXLrUzZCEQN4TQjEZgEt8V6KDStQFmTLCyaqvc79/26zsxkYdAPoXXbHDeaZNQeOub10SDnP5UrnAFpKUPv0F3yBRG7B7D50ediHiiAz1rR77onhI72Mgub1p6ZZGLYQi28DLxNahXp2+5LW4ukov2Vnfdgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747561459; c=relaxed/simple;
	bh=qQZGVyrQHu1q7OAzBul9jHFJs677FLpnum3Dq8gwdh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSf6p1JVGKK3uceIcIhrke8l2BDpvv2yq5uush9LEQb1nDuxm/uDXimQeYgsFX4cgmaTGtH5lJX3OCrxE0tVRu3EiCnm8AOnaL+r+5uwemYtxSgIj7FfjX9qXNrTr0MAhyOU0iZDelzYw/IWLbTGV1QPnyWrcfrFEzu221szlDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b0bRX6YfHz6L574;
	Sun, 18 May 2025 17:41:12 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 5319914050C;
	Sun, 18 May 2025 17:44:14 +0800 (CST)
Received: from china (10.220.118.114) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 18 May
 2025 11:44:09 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Subject: [PATCH net-next v1 1/1] queue_api: reduce risk of name collision over txq
Date: Sun, 18 May 2025 13:00:54 +0300
Message-ID: <95b60d218f004308486d92ed17c8cc6f28bac09d.1747559621.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1747559621.git.gur.stavi@huawei.com>
References: <cover.1747559621.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 frapeml500005.china.huawei.com (7.182.85.13)

Rename local variable in macros from txq to _txq.
When macro parameter get_desc is expended it is likely to have a txq
token that refers to a different txq variable at the caller's site.

Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
---
 include/net/netdev_queues.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 069ff35a72de..ba2eaf39089b 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -288,27 +288,27 @@ netdev_txq_completed_mb(struct netdev_queue *dev_queue,
 
 #define netif_subqueue_try_stop(dev, idx, get_desc, start_thrs)		\
 	({								\
-		struct netdev_queue *txq;				\
+		struct netdev_queue *_txq;				\
 									\
-		txq = netdev_get_tx_queue(dev, idx);			\
-		netif_txq_try_stop(txq, get_desc, start_thrs);		\
+		_txq = netdev_get_tx_queue(dev, idx);			\
+		netif_txq_try_stop(_txq, get_desc, start_thrs);		\
 	})
 
 #define netif_subqueue_maybe_stop(dev, idx, get_desc, stop_thrs, start_thrs) \
 	({								\
-		struct netdev_queue *txq;				\
+		struct netdev_queue *_txq;				\
 									\
-		txq = netdev_get_tx_queue(dev, idx);			\
-		netif_txq_maybe_stop(txq, get_desc, stop_thrs, start_thrs); \
+		_txq = netdev_get_tx_queue(dev, idx);			\
+		netif_txq_maybe_stop(_txq, get_desc, stop_thrs, start_thrs); \
 	})
 
 #define netif_subqueue_completed_wake(dev, idx, pkts, bytes,		\
 				      get_desc, start_thrs)		\
 	({								\
-		struct netdev_queue *txq;				\
+		struct netdev_queue *_txq;				\
 									\
-		txq = netdev_get_tx_queue(dev, idx);			\
-		netif_txq_completed_wake(txq, pkts, bytes,		\
+		_txq = netdev_get_tx_queue(dev, idx);			\
+		netif_txq_completed_wake(_txq, pkts, bytes,		\
 					 get_desc, start_thrs);		\
 	})
 
-- 
2.45.2


