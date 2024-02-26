Return-Path: <netdev+bounces-75096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B45868267
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 22:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1E128C367
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89092131746;
	Mon, 26 Feb 2024 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YP00assa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65737131733
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708981827; cv=none; b=H1XFK/ZLgGE9WYQ9ZMUiWUwlLXV+r+4j9O1uJYiNSKwLvKWFnXEZNSFrYEeB/k0PJbhDDg//pC20EYqb3NxTa0Wmle+oZA4XH7pJ1g85Ey+J8+wU/F0tacnIY7eZLdfm4Nbo2Pz87UEk2bBFazggHDfY6pT90AcC2HSwCb8RMbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708981827; c=relaxed/simple;
	bh=/k3vgcitaIfdEarelNeB+rPyZW3mzTeTJVuYh+7JYN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0koErzzEiZGUaV/CLXaKyJPR+Iu7GrkA7+CSdzMeu+oyz5Lif1liePe2IxC9C6jGFeeyBn6rO+xAW2gToyjjKmWlLlYTJXLt/PY603v1zBd+JD+EnNYP6sGNZzU46nHcbAyO7YyD+ZqJrtqaupUK4FzQDogmzT1AvBGW46ULU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YP00assa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8DEC433B1;
	Mon, 26 Feb 2024 21:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708981827;
	bh=/k3vgcitaIfdEarelNeB+rPyZW3mzTeTJVuYh+7JYN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YP00assase2CXuC5S9Zx97vuzJWsSashdv+7f0+R8biQl8KZIJocmIClpfTDOc3pf
	 9JsmeIAF2zJaku8+IcbcmoEyXy0hZIFxhuBAzyPh/Y7eR0ZVqyR+xPGZIeQDa7aKpS
	 Zilrbu+2qXRpfF1vBioptXVJKfPrb9Bb+VFdA01eaSKW/dVtR14J15NT3+uUUmYA0z
	 4rKgkyXH8yT/0DFsz1vPgyYzse8Ku9c/CWiqXox5Vq2+eD05kWhSU4i3qICfObW7Vx
	 FtM+JNqEfNJW51h/8E3pr9oJTGzmzt+AsR1nUro0eWtBTCLujrz9ZHHoAqdSoLg4GB
	 WQdo3mrS4hexw==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] netdev: add queue stat for alloc failures
Date: Mon, 26 Feb 2024 13:10:14 -0800
Message-ID: <20240226211015.1244807-3-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240226211015.1244807-1-kuba@kernel.org>
References: <20240226211015.1244807-1-kuba@kernel.org>
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
index 2570cc371fc8..382a98383b6e 100644
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
index f282634e031d..6e7a0e74ccd6 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -145,6 +145,7 @@ enum {
 	NETDEV_A_STATS_RX_BYTES,
 	NETDEV_A_STATS_TX_PACKETS,
 	NETDEV_A_STATS_TX_BYTES,
+	NETDEV_A_STATS_RX_ALLOC_FAIL,
 
 	__NETDEV_A_STATS_MAX,
 	NETDEV_A_STATS_MAX = (__NETDEV_A_STATS_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 0fbd666f2b79..db72c4801d5c 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -498,7 +498,8 @@ static int
 netdev_nl_stats_write_rx(struct sk_buff *rsp, struct netdev_queue_stats_rx *rx)
 {
 	if (netdev_stat_put(rsp, NETDEV_A_STATS_RX_PACKETS, rx->packets) ||
-	    netdev_stat_put(rsp, NETDEV_A_STATS_RX_BYTES, rx->bytes))
+	    netdev_stat_put(rsp, NETDEV_A_STATS_RX_BYTES, rx->bytes) ||
+	    netdev_stat_put(rsp, NETDEV_A_STATS_RX_ALLOC_FAIL, rx->alloc_fail))
 		return -EMSGSIZE;
 	return 0;
 }
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index f282634e031d..6e7a0e74ccd6 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -145,6 +145,7 @@ enum {
 	NETDEV_A_STATS_RX_BYTES,
 	NETDEV_A_STATS_TX_PACKETS,
 	NETDEV_A_STATS_TX_BYTES,
+	NETDEV_A_STATS_RX_ALLOC_FAIL,
 
 	__NETDEV_A_STATS_MAX,
 	NETDEV_A_STATS_MAX = (__NETDEV_A_STATS_MAX - 1)
-- 
2.43.2


