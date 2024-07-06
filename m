Return-Path: <netdev+bounces-109605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B98792915A
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 08:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9C71F21D5A
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 06:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975B814295;
	Sat,  6 Jul 2024 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKD6u5AJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104591B947
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720248266; cv=none; b=kQagfEgPYYgY6MNbDyFguzLCHO7JmP64rxufSSFGH/cr9nrAFzMmiQGh9WvOZoALbNcB4vwDAeG85Qt/FvK7HuXJpun15E2OuokvTVFcZlO5jh09ZE8Eywch+er+eq4rhyc4Uf1SqjBcJkRZqwk//iSx5mtGNlt/6G0Y8YEiX9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720248266; c=relaxed/simple;
	bh=IIUHxbJ6/zFuq/7O8BVmABEtbqQjVhOXQY5vgLP4ncE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JnVlnwwKd9DminTU305P8GLKo9hvo5T0P9wiKf5jbN1pbP1Sj3LAdKcrncoAeDICZLRh31/VUlexQAP4+JgzVgTaGJ8FVPhznAAjdizt3A5Ekpj3QkpwEYOewVRYL3CKJyf3Tv+BWk79FX/QFVuiefJ5rvcqRiYQCQzjZjD4xs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKD6u5AJ; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-25e23e0492dso337016fac.3
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 23:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720248264; x=1720853064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y3SO9Xvg0AqGBeSUxEy9cmt6J2jlhbj+RiF4QcMW8w0=;
        b=jKD6u5AJNb4sjsaMEI42Z0n3X9v4qtT14egbOEXIPjk4/ErsQVhV3VbYFgJ/pnXkUb
         r4XHx7gJCjxZl45Rd0fr5S1o/pRAljn/gtHDUfWF47tVcI25Uic5JgdMmZmayqeLZUsi
         ABlMqe0QHTx2bnx0lfT8kZKdIVp18WdMyCVaGwWCCe2viYpuZsNmd8YWaqJWlephjg2f
         r89K0Tl8Dp5hshcKGjgtflcZL5ehoqMsPpzWu/K38QdYou5mt7usVO6hrYRwaDrkPGFM
         UqfZtbEWlCFybpq5DVaj6K0Py3PDBA46eQoteZDYf2mZ3IN9vjVHFxQS/sPRlqHYzg/4
         8/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720248264; x=1720853064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3SO9Xvg0AqGBeSUxEy9cmt6J2jlhbj+RiF4QcMW8w0=;
        b=TzxkHCzp4FuFfVqh5tw1d99b5PkHlXB2tyq5CvcfT/ZrDWZji480m1WT21Khsb9oh1
         9v817BqskQSgNMbCdOr4xkQa6I+er/W5nF4tlj22OxwfkzQ3YAQLyTxl1EytcfzMGdX0
         9J5NYQfv433eB34GOS0cvmFsgsKoePSnXWZEGvZtnso9lLELcz2ncT/WfD2FE788/+1B
         UurUVWI/wzAO2FvuAHz54Tq63cXcUn8YSL0aP0qFx3gKfrNWWD2ttQHxVPjW8gIlPtna
         OIrdUbtbRdnOX0MUC6lm0wjVWogyYUtILhSPCDINIzzowcMuI6vnZTdO340Tyr+8z9if
         8tGA==
X-Gm-Message-State: AOJu0YzJOuLdc6s+fA0uQFQ0AZ5dc+LSvbI1i0FW2EXn0WrMCdMkQaGZ
	ss7+MJMkXARZBN1PFG+1/5GwiU0c6LivOLpPe/37UifHq9oxuutWu/Yi1R0r
X-Google-Smtp-Source: AGHT+IHpRqNnLHBGEofra/rm7FaPBetn4yQYh0YvBoMGfgEnmBJO6xnHE6feQrsZ3OhiC1/28Np9cg==
X-Received: by 2002:a05:6871:798e:b0:25e:15e1:35c6 with SMTP id 586e51a60fabf-25e2b5af44dmr6251391fac.0.1720248263578;
        Fri, 05 Jul 2024 23:44:23 -0700 (PDT)
Received: from rpi.. (p5199240-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.11.99.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b044bdac4sm3675046b3a.192.2024.07.05.23.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 23:44:23 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jdamato@fastly.com
Subject: [PATCH net-next] net: tn40xx: add per queue netdev-genl stats support
Date: Sat,  6 Jul 2024 15:43:24 +0900
Message-Id: <20240706064324.137574-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the netdev-genl per queue stats API.

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
--dump qstats-get --json '{"scope":"queue"}'
[{'ifindex': 4,
  'queue-id': 0,
  'queue-type': 'rx',
  'rx-alloc-fail': 0,
  'rx-bytes': 266613,
  'rx-packets': 3325},
 {'ifindex': 4,
  'queue-id': 0,
  'queue-type': 'tx',
  'tx-bytes': 142823367,
  'tx-packets': 2387}]

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/net/ethernet/tehuti/tn40.c | 54 ++++++++++++++++++++++++++++--
 drivers/net/ethernet/tehuti/tn40.h |  1 +
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
index 565b72537efa..259bdac24cf2 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -10,6 +10,7 @@
 #include <linux/pci.h>
 #include <linux/phylink.h>
 #include <linux/vmalloc.h>
+#include <net/netdev_queues.h>
 #include <net/page_pool/helpers.h>
 
 #include "tn40.h"
@@ -378,6 +379,7 @@ static int tn40_rx_receive(struct tn40_priv *priv, int budget)
 		if (!skb) {
 			u64_stats_update_begin(&priv->syncp);
 			priv->stats.rx_dropped++;
+			priv->alloc_fail++;
 			u64_stats_update_end(&priv->syncp);
 			tn40_recycle_rx_buffer(priv, rxdd);
 			break;
@@ -1580,8 +1582,55 @@ static int tn40_ethtool_get_link_ksettings(struct net_device *ndev,
 }
 
 static const struct ethtool_ops tn40_ethtool_ops = {
-	.get_link		= ethtool_op_get_link,
-	.get_link_ksettings	= tn40_ethtool_get_link_ksettings,
+	.get_link = ethtool_op_get_link,
+	.get_link_ksettings = tn40_ethtool_get_link_ksettings,
+};
+
+static void tn40_get_queue_stats_rx(struct net_device *ndev, int idx,
+				    struct netdev_queue_stats_rx *stats)
+{
+	struct tn40_priv *priv = netdev_priv(ndev);
+	unsigned int start;
+
+	do {
+		start = u64_stats_fetch_begin(&priv->syncp);
+
+		stats->packets = priv->stats.rx_packets;
+		stats->bytes = priv->stats.rx_bytes;
+		stats->alloc_fail = priv->alloc_fail;
+	} while (u64_stats_fetch_retry(&priv->syncp, start));
+}
+
+static void tn40_get_queue_stats_tx(struct net_device *ndev, int idx,
+				    struct netdev_queue_stats_tx *stats)
+{
+	struct tn40_priv *priv = netdev_priv(ndev);
+	unsigned int start;
+
+	do {
+		start = u64_stats_fetch_begin(&priv->syncp);
+
+		stats->packets = priv->stats.tx_packets;
+		stats->bytes = priv->stats.tx_bytes;
+	} while (u64_stats_fetch_retry(&priv->syncp, start));
+}
+
+static void tn40_get_base_stats(struct net_device *ndev,
+				struct netdev_queue_stats_rx *rx,
+				struct netdev_queue_stats_tx *tx)
+{
+	rx->packets = 0;
+	rx->bytes = 0;
+	rx->alloc_fail = 0;
+
+	tx->packets = 0;
+	tx->bytes = 0;
+}
+
+static const struct netdev_stat_ops tn40_stat_ops = {
+	.get_queue_stats_rx = tn40_get_queue_stats_rx,
+	.get_queue_stats_tx = tn40_get_queue_stats_tx,
+	.get_base_stats = tn40_get_base_stats,
 };
 
 static int tn40_priv_init(struct tn40_priv *priv)
@@ -1613,6 +1662,7 @@ static struct net_device *tn40_netdev_alloc(struct pci_dev *pdev)
 		return NULL;
 	ndev->netdev_ops = &tn40_netdev_ops;
 	ndev->ethtool_ops = &tn40_ethtool_ops;
+	ndev->stat_ops = &tn40_stat_ops;
 	ndev->tx_queue_len = TN40_NDEV_TXQ_LEN;
 	ndev->mem_start = pci_resource_start(pdev, 0);
 	ndev->mem_end = pci_resource_end(pdev, 0);
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index 10368264f7b7..490781fe5120 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -123,6 +123,7 @@ struct tn40_priv {
 
 	int stats_flag;
 	struct rtnl_link_stats64 stats;
+	u64 alloc_fail;
 	struct u64_stats_sync syncp;
 
 	u8 txd_size;

base-commit: 2f5e6395714d0ee53c150da38b25975fe37755c2
-- 
2.34.1


