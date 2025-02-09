Return-Path: <netdev+bounces-164421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3914A2DC8F
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 11:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CB21886F49
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 10:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E02F188596;
	Sun,  9 Feb 2025 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="YUKNwdDM"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC8013DBA0;
	Sun,  9 Feb 2025 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739097580; cv=pass; b=WjQWnqFrZMATXGHstGffNXD+HTr5vIG04UgsXcu6yTajabS02pvUpKxc3ABTx0/WkyA0Iq9gZeiGTl1bGLkCSyQIpU6hVst3FrqTrKeRNV07sjiTxOalxZjGHfQvDuXI5SMlj5Dg5g7FPI8YRwpGhtePfJdCyJUCrT2769tfiL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739097580; c=relaxed/simple;
	bh=GdmfCLxoBTTsWWhKlaVHIqC0kMSMOQIhQ7nns+Yvp3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmpwBtb2jjX7oFSKocGi3f+fRMycisRjyQyjIiEFOZqQHuFU7PvNLBHHRceRr7dxCqKvrMO9hfQ5vzSYp97Y27JRIEey6HXdKlhuucHTWgDXC3LC4Pt666W/UGnMSbL4lYosXunDQPx1BeAjXCX+aSlyPxUJ4MHdG0wJu11ZpzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=YUKNwdDM; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YrPN1551zz49Q6m;
	Sun,  9 Feb 2025 12:39:29 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739097571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljeP4J7Llgjb8lL8F5o81ZU31nRmmAf2Q3QTjVlg3bQ=;
	b=YUKNwdDM1WKMOZyRwoTBNSg3+ca9lTG9+McVqmJIGOg9rXH/s/PGzdMgylZubO416R4r0z
	RsRz+hhbVR9rSIe3Nfo8+osU8cvwR4HVimiAVKXAW78G4AWB8F9zjTYad78I7AekM2dZYj
	oP88fHbnj7uqAqg2Kz01NASOC76IgYZz4MqOs8iP5n4cpvMQs8DdG83pCfkbKMsGGfrL/s
	HEGQrgg8U+fAnC7TykR7yUBhH6IXmuuE0TAU4sY9h8ZkIJMYJUrW0RUnmDARWh94WTRiG6
	480n4/FgjFcjlB5O3Gx9doOu/akg1L2hUs9cw0rvuc5lthGMsb/l7PzazcY72A==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739097571; a=rsa-sha256;
	cv=none;
	b=fBwiOXG2T8IfxEmDA9lH6fOoNkw2dCN8Ja/BiYRXesCOKuc1wHAv/t1kklNUHC86p8kc6Y
	Xd/djGA027uxoKS7tNl6JoYoD3uNHuAFjFGpXHy3/dTK7Ht4mli4UJ4roUwKBH73z1aI4X
	I0D+NcFEewJwj7fx4yJa7PWHQdpqV99izZNRJhBV+EtJuWP+YpyKl5j3vG9gi8yq4xQknr
	YyRgwqEBP1Af8hFwg9VM+HHnPi2HZTb2FKuIZVEaj6AKvB+wxhQegBEzR2HV2uhUTzUVyy
	sqkfTN8cjUXVSMwanT0iuIA9fk7kRbRZN1a+sZUyCs1bxWD5xfwqmOZBfK1DIw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739097571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljeP4J7Llgjb8lL8F5o81ZU31nRmmAf2Q3QTjVlg3bQ=;
	b=qF60aO3nglYg28V0dXxpIePIWtBC/cEf70aaQfQqDbXL1Kg0sXajosCBzuozxK8N/KGWuv
	+nXac/JREBUzIsA152dXZJgh4SUQnwWKbyHFAui0OrjwrNXji29z6WcNSRUPlLlSSURmwU
	mGi08+tp35MPR5Jl1cBGRODew1xzUYUO+lnVnrsUw6KCn8eE8cZibmPknXjH9OzDkS01Cl
	OOjQSu7fSDAqNqTICe7AeaJdGc61z/0s6CAev8OyIcl7kcaOb7R86KLbKZkIC8nVNKCpRF
	QzIREW4uDNoGDZkHx2NB7TtJX8AU5G6swj11FwKPFijt8QdAKX/zSL5xtx9EPw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH v3 1/5] net-timestamp: COMPLETION timestamp on packet tx completion
Date: Sun,  9 Feb 2025 12:39:13 +0200
Message-ID: <71b88f509237bcce4139c152b3f624d7532047fd.1739097311.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739097311.git.pav@iki.fi>
References: <cover.1739097311.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software timestamp
when hardware reports a packet completed.

Completion tstamp is useful for Bluetooth, where hardware tx timestamps
cannot be obtained except for ISO packets, and the hardware has a queue
where packets may wait.  In this case the software SND timestamp only
reflects the kernel-side part of the total latency (usually small) and
queue length (usually 0 unless HW buffers congested), whereas the
completion report time is more informative of the true latency.

It may also be useful in other cases where HW TX timestamps cannot be
obtained and user wants to estimate an upper bound to when the TX
probably happened.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 Documentation/networking/timestamping.rst | 9 +++++++++
 include/linux/skbuff.h                    | 6 +++++-
 include/uapi/linux/errqueue.h             | 1 +
 include/uapi/linux/net_tstamp.h           | 6 ++++--
 net/ethtool/common.c                      | 1 +
 net/socket.c                              | 3 +++
 6 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index 61ef9da10e28..de2afed7a516 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -140,6 +140,15 @@ SOF_TIMESTAMPING_TX_ACK:
   cumulative acknowledgment. The mechanism ignores SACK and FACK.
   This flag can be enabled via both socket options and control messages.
 
+SOF_TIMESTAMPING_TX_COMPLETION:
+  Request tx timestamps on packet tx completion.  The completion
+  timestamp is generated by the kernel when it receives packet a
+  completion report from the hardware. Hardware may report multiple
+  packets at once, and completion timestamps reflect the timing of the
+  report and not actual tx time. The completion timestamps are
+  currently implemented only for: Bluetooth L2CAP and ISO.  This
+  flag can be enabled via both socket options and control messages.
+
 
 1.3.2 Timestamp Reporting
 ^^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index bb2b751d274a..3707c9075ae9 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -489,10 +489,14 @@ enum {
 
 	/* generate software time stamp when entering packet scheduling */
 	SKBTX_SCHED_TSTAMP = 1 << 6,
+
+	/* generate software time stamp on packet tx completion */
+	SKBTX_COMPLETION_TSTAMP = 1 << 7,
 };
 
 #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
-				 SKBTX_SCHED_TSTAMP)
+				 SKBTX_SCHED_TSTAMP | \
+				 SKBTX_COMPLETION_TSTAMP)
 #define SKBTX_ANY_TSTAMP	(SKBTX_HW_TSTAMP | \
 				 SKBTX_HW_TSTAMP_USE_CYCLES | \
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
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 2bd77c94f9f1..75e3b756012e 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -431,6 +431,7 @@ const char sof_timestamping_names[][ETH_GSTRING_LEN] = {
 	[const_ilog2(SOF_TIMESTAMPING_BIND_PHC)]     = "bind-phc",
 	[const_ilog2(SOF_TIMESTAMPING_OPT_ID_TCP)]   = "option-id-tcp",
 	[const_ilog2(SOF_TIMESTAMPING_OPT_RX_FILTER)] = "option-rx-filter",
+	[const_ilog2(SOF_TIMESTAMPING_TX_COMPLETION)] = "completion-transmit",
 };
 static_assert(ARRAY_SIZE(sof_timestamping_names) == __SOF_TIMESTAMPING_CNT);
 
diff --git a/net/socket.c b/net/socket.c
index 4afe31656a2b..22b7f6f50889 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -693,6 +693,9 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags)
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


