Return-Path: <netdev+bounces-175862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05F7A67CBC
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC9019C4786
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 19:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD6E2144D3;
	Tue, 18 Mar 2025 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="p2LZ7SgU"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905011CAA8E;
	Tue, 18 Mar 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324822; cv=pass; b=XlrRZax7mzJwUEFMEGV56zApn3RKnQNb1LiBEWHYh4J/OzFG0kI8dcJCaxLXwx0F8vD0a/LOfE3eeCisqcxxXCWvXR3WnA4qxFEBegX7/vGrZyH8OHVMpiAJ6CWVSaLC8k9YfgQg3YOzBI2fAF7E2ouiRS3IJto4ORAvtwfN8Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324822; c=relaxed/simple;
	bh=v3y5dI7BtBi1w62/UgiO9CUw0uysv/kzIgIveillzKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foEQ8QZDF+Wdawl+NGyYps7r30HbBIadQsIoRhTbV0WvrDKqvU55LNnHGwUEkI3bi3zaoS1FBQ66LatQN0/Z5E2nsGma4EGNkQipsFeJdLqwTeHyWNfjbK8klSsRptZBfeoc2mmZKil4DR1/EBBZ5B6G0Ci9XZonVgQgmgW53jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=p2LZ7SgU; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZHLtN6yBfz49Q5Y;
	Tue, 18 Mar 2025 21:06:52 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1742324813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0grLmEiudzP5GX3KfndoJzwLtwa3uwDF9BQiiSoHv3o=;
	b=p2LZ7SgUczuxsWvLAALXxH9tc1/NTXy6DyK0G0vFTe9HAMXD9z3UKP+Q1lUW/oF3oMtL7G
	CC+Or6uROUYqbdF7oLwTy4SGf3RJmVuEzB+YtNZ4HEpjxeLjH9RQjJDgUxczZrsqX7iFTR
	3RswwFbcLpAl3bB5pvoRkhUWtYQbiFcIQJoUm0ofs9h8p+ZNB4dqLB6Bad8yppXjJ9Sk1+
	gh89EwhWsmiHuXp8on0g6WC10T91M8uvhmbS3FngIKVYDnpqeEMd+x3vZTHQCPj8j69VCc
	weHP3421be52ZkEbTLCqkF8u9Fm/anPCs85WXJKJFfemMVP6L8RR5TDxFd9nOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1742324813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0grLmEiudzP5GX3KfndoJzwLtwa3uwDF9BQiiSoHv3o=;
	b=OclIOAjFDF4V/q/jPRRi71pjLEWoYbAj50us51VpTmxM18MQHUt/BZUvIZWShQqVR8vqlw
	mqu/pgoPId5+WQCX4v5BKGDFflyXYTTucvP0zryJYzG0MCB3ZlT14GGtFjCzFJLYDVo2Az
	lYZWxPAHRbOraMHxEh1DAnGhfM6gjbLNpDJUwHKxf2bmUtV2opwlAcnusjlzTqXyKtUA95
	bEYaQuNWIxGf3DRrddTC6F8Ja6lZ+ypnQVq0DEoAmNKENKOWxnl09DpahNezCfIkGnpnsp
	2R+zahXMB4O3Uf84zlKlTkBioWy0X1G031fTmSwgAcahGKk5XVGHmQ0wv2mJYA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1742324813; a=rsa-sha256;
	cv=none;
	b=PLOZ+1ryL8NZcuKRqzWDV9c9NaPSva0ve9JS8kOOSL5u3SJji9svlnA64CxD8JakwTeT/j
	44aTMCLmJH/XMxJTj/rdcPKKvUQvRTCkTQtykjiNL+HY/N2bXK2IrujhuORSimzx6IXFFN
	QTyQm1suW4tD4UWTPltP+B1e9DnVQ3i1dDlt2h4cP5Ui88KEZulrINRI7SheVyt15bMLIv
	x5q167/fqAE24Gr8qDAHh6+6kYISJ0RuvC2RiUrRb1YrWT8uh7PCC9TDU8WxVp/x2/m14Q
	NSQZKPbhFoLTYqBFAqFHXjtifGn2K8UQI4MUoQzhWieA/n975+LB2I/ZXwq7Og==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH v5 1/5] net-timestamp: COMPLETION timestamp on packet tx completion
Date: Tue, 18 Mar 2025 21:06:42 +0200
Message-ID: <0dfb22ec3c9d9ed796ba8edc919a690ca2fb1fdd.1742324341.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742324341.git.pav@iki.fi>
References: <cover.1742324341.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software timestamp
when hardware reports a packet completed.

Completion tstamp is useful for Bluetooth, as hardware timestamps do not
exist in the HCI specification except for ISO packets, and the hardware
has a queue where packets may wait.  In this case the software SND
timestamp only reflects the kernel-side part of the total latency
(usually small) and queue length (usually 0 unless HW buffers
congested), whereas the completion report time is more informative of
the true latency.

It may also be useful in other cases where HW TX timestamps cannot be
obtained and user wants to estimate an upper bound to when the TX
probably happened.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v5:
    - back to decoupled COMPLETION & SND, like in v3
    - BPF reporting not implemented here

 Documentation/networking/timestamping.rst | 8 ++++++++
 include/linux/skbuff.h                    | 7 ++++---
 include/uapi/linux/errqueue.h             | 1 +
 include/uapi/linux/net_tstamp.h           | 6 ++++--
 net/core/skbuff.c                         | 2 ++
 net/ethtool/common.c                      | 1 +
 net/socket.c                              | 3 +++
 7 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index 61ef9da10e28..b8fef8101176 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -140,6 +140,14 @@ SOF_TIMESTAMPING_TX_ACK:
   cumulative acknowledgment. The mechanism ignores SACK and FACK.
   This flag can be enabled via both socket options and control messages.
 
+SOF_TIMESTAMPING_TX_COMPLETION:
+  Request tx timestamps on packet tx completion.  The completion
+  timestamp is generated by the kernel when it receives packet a
+  completion report from the hardware. Hardware may report multiple
+  packets at once, and completion timestamps reflect the timing of the
+  report and not actual tx time. This flag can be enabled via both
+  socket options and control messages.
+
 
 1.3.2 Timestamp Reporting
 ^^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index cd8294cdc249..b974a277975a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -478,8 +478,8 @@ enum {
 	/* device driver is going to provide hardware time stamp */
 	SKBTX_IN_PROGRESS = 1 << 2,
 
-	/* reserved */
-	SKBTX_RESERVED = 1 << 3,
+	/* generate software time stamp on packet tx completion */
+	SKBTX_COMPLETION_TSTAMP = 1 << 3,
 
 	/* generate wifi status information (where possible) */
 	SKBTX_WIFI_STATUS = 1 << 4,
@@ -498,7 +498,8 @@ enum {
 
 #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
 				 SKBTX_SCHED_TSTAMP | \
-				 SKBTX_BPF)
+				 SKBTX_BPF          | \
+				 SKBTX_COMPLETION_TSTAMP)
 #define SKBTX_ANY_TSTAMP	(SKBTX_HW_TSTAMP | \
 				 SKBTX_ANY_SW_TSTAMP)
 
diff --git a/include/uapi/linux/errqueue.h b/include/uapi/linux/errqueue.h
index 3c70e8ac14b8..1ea47309d772 100644
--- a/include/uapi/linux/errqueue.h
+++ b/include/uapi/linux/errqueue.h
@@ -73,6 +73,7 @@ enum {
 	SCM_TSTAMP_SND,		/* driver passed skb to NIC, or HW */
 	SCM_TSTAMP_SCHED,	/* data entered the packet scheduler */
 	SCM_TSTAMP_ACK,		/* data acknowledged by peer */
+	SCM_TSTAMP_COMPLETION,	/* packet tx completion */
 };
 
 #endif /* _UAPI_LINUX_ERRQUEUE_H */
diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
index 55b0ab51096c..383213de612a 100644
--- a/include/uapi/linux/net_tstamp.h
+++ b/include/uapi/linux/net_tstamp.h
@@ -44,8 +44,9 @@ enum {
 	SOF_TIMESTAMPING_BIND_PHC = (1 << 15),
 	SOF_TIMESTAMPING_OPT_ID_TCP = (1 << 16),
 	SOF_TIMESTAMPING_OPT_RX_FILTER = (1 << 17),
+	SOF_TIMESTAMPING_TX_COMPLETION = (1 << 18),
 
-	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_OPT_RX_FILTER,
+	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_TX_COMPLETION,
 	SOF_TIMESTAMPING_MASK = (SOF_TIMESTAMPING_LAST - 1) |
 				 SOF_TIMESTAMPING_LAST
 };
@@ -58,7 +59,8 @@ enum {
 #define SOF_TIMESTAMPING_TX_RECORD_MASK	(SOF_TIMESTAMPING_TX_HARDWARE | \
 					 SOF_TIMESTAMPING_TX_SOFTWARE | \
 					 SOF_TIMESTAMPING_TX_SCHED | \
-					 SOF_TIMESTAMPING_TX_ACK)
+					 SOF_TIMESTAMPING_TX_ACK | \
+					 SOF_TIMESTAMPING_TX_COMPLETION)
 
 /**
  * struct so_timestamping - SO_TIMESTAMPING parameter
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ab8acb737b93..6cbf77bc61fc 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5523,6 +5523,8 @@ static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
 						    SKBTX_SW_TSTAMP);
 	case SCM_TSTAMP_ACK:
 		return TCP_SKB_CB(skb)->txstamp_ack & TSTAMP_ACK_SK;
+	case SCM_TSTAMP_COMPLETION:
+		return skb_shinfo(skb)->tx_flags & SKBTX_COMPLETION_TSTAMP;
 	}
 
 	return false;
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 7e3c16856c1a..0cb6da1f692a 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -476,6 +476,7 @@ const char sof_timestamping_names[][ETH_GSTRING_LEN] = {
 	[const_ilog2(SOF_TIMESTAMPING_BIND_PHC)]     = "bind-phc",
 	[const_ilog2(SOF_TIMESTAMPING_OPT_ID_TCP)]   = "option-id-tcp",
 	[const_ilog2(SOF_TIMESTAMPING_OPT_RX_FILTER)] = "option-rx-filter",
+	[const_ilog2(SOF_TIMESTAMPING_TX_COMPLETION)] = "tx-completion",
 };
 static_assert(ARRAY_SIZE(sof_timestamping_names) == __SOF_TIMESTAMPING_CNT);
 
diff --git a/net/socket.c b/net/socket.c
index b64ecf2722e7..e3d879b53278 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -689,6 +689,9 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags)
 	if (tsflags & SOF_TIMESTAMPING_TX_SCHED)
 		flags |= SKBTX_SCHED_TSTAMP;
 
+	if (tsflags & SOF_TIMESTAMPING_TX_COMPLETION)
+		flags |= SKBTX_COMPLETION_TSTAMP;
+
 	*tx_flags = flags;
 }
 EXPORT_SYMBOL(__sock_tx_timestamp);
-- 
2.48.1


