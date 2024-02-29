Return-Path: <netdev+bounces-75991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8238886BE09
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 02:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22D481F2AD1E
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 01:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA04C2E64F;
	Thu, 29 Feb 2024 01:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKGZjtzV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE552E413
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 01:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168569; cv=none; b=OPvI9nZ+Ok8AAJZjGCvlHt5Q2pRlVyxn589MmiDcljP8PVKzJjjHWd1443k8v6fSJVKnEWU7N8tYIzYSMDqqV1Y5UsZA3RU/tpC12su22/x9exyUAJSVLRAGRSitf5iAEYzUH55WUXh2NIEyVM+TO7QNp60lkx7KAX9iSfnidNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168569; c=relaxed/simple;
	bh=/qY1mU37e3g0zXbUtTCBrhSGyRuXAhnMGgzChkQ/jAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Au/z6cAZcmO+CLTzrr2eXLWZRYt+6cVDfg3zhOIq6NRBH/cigEOn0oCwomgNCcaxqlXQnyW3f77BZtO2M+U80dIQ121iyuHVA36zfo1IGAZuXrTfDwKrAVgZ5fZ8zlyGfF4Fhd5V6OyAWreLRnVS44phL5+7rLwOWfIZ9bc3Gq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKGZjtzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3DAC43394;
	Thu, 29 Feb 2024 01:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709168569;
	bh=/qY1mU37e3g0zXbUtTCBrhSGyRuXAhnMGgzChkQ/jAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pKGZjtzVnnt6Yi6ibT6Fz6oPzns+ZyV1VNF6eHmnbwTLGk7Caj08s0H5kiXuX8t+M
	 baLY2Kad6oajNmRxyoTSog9tGjKMmo4hkIfiDKDe6kQm/4QvMj5UdjFNaRgxS3uhZw
	 vYzxg9I/9Kk7UkogGD6mk4ebZwE2pjnZx5sRbGEZDzYj0rFn1xV1RC5K2pKaSei+Kb
	 aWs2V4cGA4Y+mOXBkDxauGNGJvPtsPvFYpVUXoPycqplv1qznD30EEUv5zv8zH4B5s
	 vk/edF5LXxo21/t2IwfzH+9C/bpt1yjgHAfrhXAJaPSjdUXJDERMSyG/6cellaiA5Q
	 X7dZtk/FAdByg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	amritha.nambiar@intel.com,
	danielj@nvidia.com,
	mst@redhat.com,
	michael.chan@broadcom.com,
	sdf@google.com,
	vadim.fedorenko@linux.dev,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/3] netdev: add queue stat for alloc failures
Date: Wed, 28 Feb 2024 17:02:20 -0800
Message-ID: <20240229010221.2408413-3-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229010221.2408413-1-kuba@kernel.org>
References: <20240229010221.2408413-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rx alloc failures are commonly counted by drivers.
Support reporting those via netdev-genl queue stats.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml | 7 +++++++
 include/net/netdev_queues.h             | 2 ++
 include/uapi/linux/netdev.h             | 1 +
 net/core/netdev-genl.c                  | 3 ++-
 tools/include/uapi/linux/netdev.h       | 1 +
 5 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index a1e48c3c84c9..76352dbd2be4 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -328,6 +328,13 @@ name: netdev
         name: tx-bytes
         doc: Successfully sent bytes, see `tx-packets`.
         type: uint
+      -
+        name: rx-alloc-fail
+        doc: |
+          Number of times skb or buffer allocation failed on the Rx datapath.
+          Allocation failure may, or may not result in a packet drop, depending
+          on driver implementation and whether system recovers quickly.
+        type: uint
 
 operations:
   list:
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index d633347eeda5..1ec408585373 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -4,9 +4,11 @@
 
 #include <linux/netdevice.h>
 
+/* See the netdev.yaml spec for definition of each statistic */
 struct netdev_queue_stats_rx {
 	u64 bytes;
 	u64 packets;
+	u64 alloc_fail;
 };
 
 struct netdev_queue_stats_tx {
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 639ffa04c172..bb65ee840cda 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -145,6 +145,7 @@ enum {
 	NETDEV_A_QSTATS_RX_BYTES,
 	NETDEV_A_QSTATS_TX_PACKETS,
 	NETDEV_A_QSTATS_TX_BYTES,
+	NETDEV_A_QSTATS_RX_ALLOC_FAIL,
 
 	__NETDEV_A_QSTATS_MAX,
 	NETDEV_A_QSTATS_MAX = (__NETDEV_A_QSTATS_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 9369ef54d172..2eb45b7f5030 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -497,7 +497,8 @@ static int
 netdev_nl_stats_write_rx(struct sk_buff *rsp, struct netdev_queue_stats_rx *rx)
 {
 	if (netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_PACKETS, rx->packets) ||
-	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_BYTES, rx->bytes))
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_BYTES, rx->bytes) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_ALLOC_FAIL, rx->alloc_fail))
 		return -EMSGSIZE;
 	return 0;
 }
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 639ffa04c172..bb65ee840cda 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -145,6 +145,7 @@ enum {
 	NETDEV_A_QSTATS_RX_BYTES,
 	NETDEV_A_QSTATS_TX_PACKETS,
 	NETDEV_A_QSTATS_TX_BYTES,
+	NETDEV_A_QSTATS_RX_ALLOC_FAIL,
 
 	__NETDEV_A_QSTATS_MAX,
 	NETDEV_A_QSTATS_MAX = (__NETDEV_A_QSTATS_MAX - 1)
-- 
2.43.2


