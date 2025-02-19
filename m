Return-Path: <netdev+bounces-167816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04549A3C71E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 19:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0D5189027F
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC44E215055;
	Wed, 19 Feb 2025 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vJcLURC4"
X-Original-To: netdev@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC86214A6C;
	Wed, 19 Feb 2025 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988837; cv=pass; b=tVOOrj8VFDquayzXVpdKwQqZM64J+86yWa3zj6kEEKJnzuZWuEGCN/H41xScOAMJ2gvJ85k/lJOBQjKyZlvNcZTXyJXQRHm9dcHvK7VVtHyrVXR+QoSs3QEjKn2LaOwbwjU/3HziuyUyJG03VDbgHYodWmlPUIFwAXPskLGThxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988837; c=relaxed/simple;
	bh=fBH3cSATHYhPx7BRa4zu2NRIg4TgtyMrqGlHSK76QP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/2eeT84bGN5M5+tsdVwjR4anRO5VZAgmaR4X/m34qG9yY3GMrtiycNhS6NqzLkhDcSKIVYkXldJD/SyRD+gwhhIfvsmMsrIAVO92RN/TAyJA6Mz/sbTHuSVI8eAhOhxLe0Nkp0ebMvqlfFBc2ndhVMigYIQhMDFMTVCr4LZKsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vJcLURC4; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4YykzZ5Stczyjk;
	Wed, 19 Feb 2025 20:13:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1739988827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ho47GDfQaMwA/8CXHC+qzYkRZzhYjCCD5t/I3hs642Q=;
	b=vJcLURC4BLSEnd8esHUbYUFAN3s1SQgg63pWtwGLk83xyDFOIYd5NdxftKzsltJ3cNTyQz
	gsVLpfY1vilnBGf/BF53Paqvz9d6k1edrIvf8YvqtCdaIO0G/z+eWPbvKTR9C9bWjpCInZ
	r+uuaePKz6JvLCWmoZsjsN94x8yTTss=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1739988827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ho47GDfQaMwA/8CXHC+qzYkRZzhYjCCD5t/I3hs642Q=;
	b=OncmBJNl6gKutnpgPjf6AYLLh8TGWKQe4NK9EXsYJvwI/snIKrjxyTk14Uhks/DwWuUxQ7
	azhj7REF51vtTij/mfc7dLLAUgqIxoAK+mA2HqGmFuY7ryktnIG+lXeFda2yJ0f5JMhoy9
	shPKof3fCigDu3pPbgy9NipSBmv+PRo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1739988827; a=rsa-sha256; cv=none;
	b=MPiLs7eOdEbpiFaxrQXnpd+gKspmRHpC9yvYeu0agglwAXkct1XaxynC5+NShl0eToTeme
	tv8a1GzzONM8O0Y8Khjp2XnG7QxCJ30UbEV/0EwItvAwR/06Z7B7lAggFYr9eot8Ta8kTG
	zE2p38ZvPl0VB39bCPg3hD5lCJHU3Ms=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH v4 1/5] net-timestamp: COMPLETION timestamp on packet tx completion
Date: Wed, 19 Feb 2025 20:13:33 +0200
Message-ID: <b278a4f39101282e2d920fed482b914d23ffaac3.1739988644.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739988644.git.pav@iki.fi>
References: <cover.1739988644.git.pav@iki.fi>
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
    v4: changed SOF_TIMESTAMPING_TX_COMPLETION to only emit COMPLETION
        together with SND, to save a bit in skb_shared_info.tx_flags
    
        As it then cannot be set per-skb, reject setting it via CMSG.

 Documentation/networking/timestamping.rst | 9 +++++++++
 include/uapi/linux/errqueue.h             | 1 +
 include/uapi/linux/net_tstamp.h           | 6 ++++--
 net/core/sock.c                           | 2 ++
 net/ethtool/common.c                      | 1 +
 5 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index 61ef9da10e28..5034dfe326c0 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -140,6 +140,15 @@ SOF_TIMESTAMPING_TX_ACK:
   cumulative acknowledgment. The mechanism ignores SACK and FACK.
   This flag can be enabled via both socket options and control messages.
 
+SOF_TIMESTAMPING_TX_COMPLETION:
+  Request tx timestamps on packet tx completion, for the packets that
+  also have SOF_TIMESTAMPING_TX_SOFTWARE enabled.  The completion
+  timestamp is generated by the kernel when it receives a packet
+  completion report from the hardware. Hardware may report multiple
+  packets at once, and completion timestamps reflect the timing of the
+  report and not actual tx time. This flag can be enabled *only*
+  via a socket option.
+
 
 1.3.2 Timestamp Reporting
 ^^^^^^^^^^^^^^^^^^^^^^^^^
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
diff --git a/net/core/sock.c b/net/core/sock.c
index a197f0a0b878..76a5d5cb1e56 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2933,6 +2933,8 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 		tsflags = *(u32 *)CMSG_DATA(cmsg);
 		if (tsflags & ~SOF_TIMESTAMPING_TX_RECORD_MASK)
 			return -EINVAL;
+		if (tsflags & SOF_TIMESTAMPING_TX_COMPLETION)
+			return -EINVAL;
 
 		sockc->tsflags &= ~SOF_TIMESTAMPING_TX_RECORD_MASK;
 		sockc->tsflags |= tsflags;
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 5489d0c9d13f..ed4d6a9f4d7e 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -473,6 +473,7 @@ const char sof_timestamping_names[][ETH_GSTRING_LEN] = {
 	[const_ilog2(SOF_TIMESTAMPING_BIND_PHC)]     = "bind-phc",
 	[const_ilog2(SOF_TIMESTAMPING_OPT_ID_TCP)]   = "option-id-tcp",
 	[const_ilog2(SOF_TIMESTAMPING_OPT_RX_FILTER)] = "option-rx-filter",
+	[const_ilog2(SOF_TIMESTAMPING_TX_COMPLETION)] = "tx-completion",
 };
 static_assert(ARRAY_SIZE(sof_timestamping_names) == __SOF_TIMESTAMPING_CNT);
 
-- 
2.48.1


