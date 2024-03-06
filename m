Return-Path: <netdev+bounces-78099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AD48740E7
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 20:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A921C22403
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8556140E5B;
	Wed,  6 Mar 2024 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEEna/8n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45BB140E46
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754919; cv=none; b=d//ypY+H0PLC6oLrGkZiQ9thxDN6P94/wKsEE3h+h0gBzulXpXxWtAOSMq+FnJxlZeDW/RXSCt6Pmk1FW85spvrpCe+MLpRt3/vBak/31joDipUAQgJzb2WagrXGXTK7yOj9bGztvZq3qcKXasQvzla2GBOFITIXeauMf0+1ONc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754919; c=relaxed/simple;
	bh=9n7hN0POyJkedQTkNpnUtjeSusjndqfiJaKm27PBkOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AG1h05bjNLQIP/mi+Cvi3wteYEK1/q8+iydC5gpqB+em+yCTv0oeQbUHU3J+xzlHxioKYNd8YnEv08zXKOHvABXDGUP6C5Z25TPM6WJFZIU8zeaHNdu3vioZQxxJOTprfOw3OX6FTHliTiXFsi3y1G0yADIFSrQQ5YsNXz8B624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEEna/8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EECC43390;
	Wed,  6 Mar 2024 19:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709754919;
	bh=9n7hN0POyJkedQTkNpnUtjeSusjndqfiJaKm27PBkOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OEEna/8nuGUA09EPMzveTJfVeWb427oHh8BpPgQJO7yJjnnWPvsufH6IBZ54fVMxi
	 //yrgisKBJ9pWIfZv37YktzorB7UPOMEBrfjhsRoNUlAmRv8YS4l9WMiLsOLoTtqyW
	 mS/pfAo+XkZXRvLoEpm6Q7QaLPpPIgMhYvj18HBEMtes8Yvz4LS8o5eR2VD8pPsDtV
	 L6EfP6jLogec/FLvYKEALVwxd0tYpvQpnA2fSVq1mPNiu/B+LT625MHBm9DH4wBkyb
	 jFM5lOKLMLmezjMT1C8hrMpYe4Azkg0CEuFkomT8sbRHSqWAi6rJa1ORXOTkHBk41U
	 IKlkVoHR8xycQ==
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
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 2/3] netdev: add queue stat for alloc failures
Date: Wed,  6 Mar 2024 11:55:08 -0800
Message-ID: <20240306195509.1502746-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306195509.1502746-1-kuba@kernel.org>
References: <20240306195509.1502746-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rx alloc failures are commonly counted by drivers.
Support reporting those via netdev-genl queue stats.

Acked-by: Stanislav Fomichev <sdf@google.com>
Reviewed-by: Amritha Nambiar <amritha.nambiar@intel.com>
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
index 7fa75e13dc6d..7004b3399c2b 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -488,7 +488,8 @@ static int
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
2.44.0


