Return-Path: <netdev+bounces-156903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43609A0842B
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 01:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5C21651BD
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 00:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFC0208A0;
	Fri, 10 Jan 2025 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKiw7Kfi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545E417579
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736470177; cv=none; b=BwhIQoBws09x3W8nI6mmRZKsUpj5oYy9q22MLAVajwOk+F48LtC1zou4lJTIsU6P0pqXF/HleZllYR6TAJy6Pt7WDvdWa3PetcNIZHsRW6InQ0kp1V7WIUoJq46R2tOTgJnU78EIqc3Bp6TYWBsmOA8udRG/2eo6plNZNKOtDpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736470177; c=relaxed/simple;
	bh=o4UGSB+mCaX9DzfAW9xquF1SahTyeVBPpve/ihIS9IA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TEKf1/l7zrmiGOgs5khiBz+K5teNULfV5zo+onaC+HZJg9PPZ49Kc0EwVbtj7qPIDqQVU+BSeqSBy0vzyG2o/d6gKCkj70chAVdNcVpAfyyYzAlORG0pPjfZaMVOCjXkcRVeMTqUc4u9r6Pe968Dzfa29Ws7ELzwcUGrmkBDEWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKiw7Kfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC86C4CED2;
	Fri, 10 Jan 2025 00:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736470176;
	bh=o4UGSB+mCaX9DzfAW9xquF1SahTyeVBPpve/ihIS9IA=;
	h=From:To:Cc:Subject:Date:From;
	b=kKiw7KfibT/yEmfBbJLJvizf8Rmrx5YwTn9tRRDLGmYxQNCefuMotW6lfrxRKvcFi
	 f0kFpKGGu+fL2A8Glc2QoJqRwPbP5wV5O+w6lHgX+tNFJOJLX9MgszQgDPsrTveIBA
	 Mr3UCalAOsMlhvY/kFRGoBjnFS3HzYZ+zlJGIeaN7ABHibduqhQO2XGqsPuQdvIjYQ
	 rRuBo5OilNNiDMc4POlWNH3optgoBpPuWffSyPPa0+ldmPwxYfF7vMclQE30e6jkMA
	 F/4pdAZpoDJBf3F1e73rODcI6h2m1L2tqCcb0QerICB5725qUI801rVUW4+UgrPRlR
	 GZawUVIh3dopw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	jdamato@fastly.com
Subject: [PATCH net-next] net: hide the definition of dev_get_by_napi_id()
Date: Thu,  9 Jan 2025 16:49:24 -0800
Message-ID: <20250110004924.3212260-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no module callers of dev_get_by_napi_id(),
and commit d1cacd747768 ("netdev: prevent accessing NAPI instances
from another namespace") proves that getting NAPI by id
needs to be done with care. So hide dev_get_by_napi_id().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jdamato@fastly.com
---
 include/linux/netdevice.h | 1 -
 net/core/dev.c            | 2 --
 net/core/dev.h            | 1 +
 net/socket.c              | 2 ++
 4 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1812564b5204..aeb4a6cff171 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3252,7 +3252,6 @@ struct net_device *netdev_get_by_index(struct net *net, int ifindex,
 struct net_device *netdev_get_by_name(struct net *net, const char *name,
 				      netdevice_tracker *tracker, gfp_t gfp);
 struct net_device *dev_get_by_index_rcu(struct net *net, int ifindex);
-struct net_device *dev_get_by_napi_id(unsigned int napi_id);
 void netdev_copy_name(struct net_device *dev, char *name);
 
 static inline int dev_hard_header(struct sk_buff *skb, struct net_device *dev,
diff --git a/net/core/dev.c b/net/core/dev.c
index 4452ca2c91ea..1a90ed8cc6cc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -957,7 +957,6 @@ EXPORT_SYMBOL(netdev_get_by_index);
  *	its reference counter increased so the caller must be careful
  *	about locking. The caller must hold RCU lock.
  */
-
 struct net_device *dev_get_by_napi_id(unsigned int napi_id)
 {
 	struct napi_struct *napi;
@@ -971,7 +970,6 @@ struct net_device *dev_get_by_napi_id(unsigned int napi_id)
 
 	return napi ? napi->dev : NULL;
 }
-EXPORT_SYMBOL(dev_get_by_napi_id);
 
 static DEFINE_SEQLOCK(netdev_rename_lock);
 
diff --git a/net/core/dev.h b/net/core/dev.h
index 08812a025a9b..d8966847794c 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -23,6 +23,7 @@ struct sd_flow_limit {
 extern int netdev_flow_limit_table_len;
 
 struct napi_struct *netdev_napi_by_id(struct net *net, unsigned int napi_id);
+struct net_device *dev_get_by_napi_id(unsigned int napi_id);
 
 #ifdef CONFIG_PROC_FS
 int __init dev_proc_init(void);
diff --git a/net/socket.c b/net/socket.c
index 16402b8be5a7..4afe31656a2b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -110,6 +110,8 @@
 #include <linux/ptp_clock_kernel.h>
 #include <trace/events/sock.h>
 
+#include "core/dev.h"
+
 #ifdef CONFIG_NET_RX_BUSY_POLL
 unsigned int sysctl_net_busy_read __read_mostly;
 unsigned int sysctl_net_busy_poll __read_mostly;
-- 
2.47.1


