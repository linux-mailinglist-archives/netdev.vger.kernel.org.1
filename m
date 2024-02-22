Return-Path: <netdev+bounces-74180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D178605C7
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6486A1C212B6
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 22:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0E918049;
	Thu, 22 Feb 2024 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6+mV3wQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0509918032
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 22:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708641400; cv=none; b=BIYoosXadPEYzj/9czjnCvsOSn1VNm1XDQbJFvP62N+ZsJM/w8gdHpAWkeA9ZnhIl4Ef+gXAvrWPEtDOJbLtpxhJ2nfR2Azlg8BTDdhyzNNLtMjuVIUj5+t/n/WQijLiHsiAZAT706VcZ9yLH+JgkJb2iR2epVOZUNe/DB223A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708641400; c=relaxed/simple;
	bh=PAsewgxe8p9jwrNf40MGUi9jPDAjm+KAZBulolJLO4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIwtPUOSTFj5uIPY+pPTVE9KWKvrcMl1SSh40kHJlvoLUWT9gL+MSiy5p0oMpV2PogtFYE/XmZCsWHav89vmXXLkuBJhoOEWcSwnr5cUo/iGhK+2JQf0JCXRDb9ZYLTaHbyOH/z6ZYOyFioZEJmkf5fft1Mk4UOf2UGcb93hk10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6+mV3wQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEB9C433C7;
	Thu, 22 Feb 2024 22:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708641399;
	bh=PAsewgxe8p9jwrNf40MGUi9jPDAjm+KAZBulolJLO4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S6+mV3wQ/8Zw6/t9/oT/eVEi2ibRs3ZJnhRyECySf3U208ur14sknv3RgGMjZFuzf
	 0Uv1J3wlztLHmtb0zNbuU0V2wyWXSUHX6G+1lFSyhxLlIC4bKmChbH5OVXpOLrpMvD
	 9OCx7y6FsikL9cAztjv/HA8i2c84Iv869zHLUPP57cx0aprdRZ9C6uden/YBwC95pQ
	 kFnUQ6RQVnBYeuFGmeP2lleyuRODn/xVn8B4zhyXSw6784+r3VTJ+FO/mg3NwtZuIX
	 ldo3mHGSViQvL82Ir2aTdOWlY1/HXVGvb23fU4IIQ6NIcLzFp6C6XjGT0qG8k6NmmO
	 qab7PC/exLNFg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	danielj@nvidia.com,
	mst@redhat.com,
	amritha.nambiar@intel.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 2/3] netdev: add queue stat for alloc failures
Date: Thu, 22 Feb 2024 14:36:28 -0800
Message-ID: <20240222223629.158254-3-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222223629.158254-1-kuba@kernel.org>
References: <20240222223629.158254-1-kuba@kernel.org>
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
index eea41e9de98c..ea7b3b72b212 100644
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
index c6a5e4b03828..ec65790c2c6c 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -146,6 +146,7 @@ enum {
 	NETDEV_A_STATS_RX_BYTES,
 	NETDEV_A_STATS_TX_PACKETS,
 	NETDEV_A_STATS_TX_BYTES,
+	NETDEV_A_STATS_RX_ALLOC_FAIL,
 
 	__NETDEV_A_STATS_MAX,
 	NETDEV_A_STATS_MAX = (__NETDEV_A_STATS_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index fe4e9bc5436a..7976c112c447 100644
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
index c6a5e4b03828..ec65790c2c6c 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -146,6 +146,7 @@ enum {
 	NETDEV_A_STATS_RX_BYTES,
 	NETDEV_A_STATS_TX_PACKETS,
 	NETDEV_A_STATS_TX_BYTES,
+	NETDEV_A_STATS_RX_ALLOC_FAIL,
 
 	__NETDEV_A_STATS_MAX,
 	NETDEV_A_STATS_MAX = (__NETDEV_A_STATS_MAX - 1)
-- 
2.43.2


