Return-Path: <netdev+bounces-212659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2585FB2197C
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2635346403B
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DE42253E9;
	Mon, 11 Aug 2025 23:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD/IPwai"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763192153E7
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 23:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754955765; cv=none; b=XwDfR4yDBoUCT5Oyhu975LDvBvd7ZqBw7/e7+JJ+PCt4dDC1P/hKDfkLnFVsvItHRPe/k1MWQoNROT0lYIQzpCQ6eaiGSv1RuMU3KeyWh/k71R8U7AOVyLudPdxk2MdisBJ6bY4yFCUVVmz3aO2GEySi1g5OzgzB9IlC3oVXl+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754955765; c=relaxed/simple;
	bh=AVdBCWYfxRCU35Xwo/Y8u3Om5Zfek9Aru45p1N4wqXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNDGCENWJ3g7mug1PMiW2p5ExSix9b3pd3zrSL5k0sagVCsDxO833uzQd/3dhCH+zptsTTQ/AjEmRaERUqu2JuXEQ7Les5JH0vVi3Kfgvtn7AH1NhvhN8YE+RKFi+dAsMWBdCJ+tWtYApzk0ra5sM6m848XYqirfT3Wxou4sWrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jD/IPwai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E807EC4CEF8;
	Mon, 11 Aug 2025 23:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754955765;
	bh=AVdBCWYfxRCU35Xwo/Y8u3Om5Zfek9Aru45p1N4wqXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jD/IPwaiksPMC8Z6HnjoPfnn6nYKD2gKKa9g8aZ0PwHmQ4eDKV9ogE9+DN95kYVok
	 dyUJYA4iCICcfu2z1x3i4jBJZekYtP2h3gUwni65g/i+emoq29Ah0QIEYKPshF6MWO
	 NHdltwe4+FZtnaDeuR7SpCm2McNCNNdJnnfjwBstMGFcQjwoRn6E7hS7qV+I17wGnP
	 IhyQ964NPEuS1anrRVtlDn8gXnj1CKhy3iqh9cI9eMghPbI23ElbfkX1VR7j8ePbaw
	 SevD/FVDue65+cmK+9ClDu4nSnHckzkzPEcLqOz9qWqTwrPVDhkaeps0CYhLzzqrFB
	 ShbrpoPBhOCCQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch
Subject: [PATCH net-next v4 1/4] net: ethtool: support including Flow Label in the flow hash for RSS
Date: Mon, 11 Aug 2025 16:42:09 -0700
Message-ID: <20250811234212.580748-2-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811234212.580748-1-kuba@kernel.org>
References: <20250811234212.580748-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some modern NICs support including the IPv6 Flow Label in
the flow hash for RSS queue selection. This is outside
the old "Microsoft spec", but was included in the OCP NIC spec:

  [ ] RSS include ow label in the hash (configurable)

https://www.opencompute.org/w/index.php?title=Core_Offloads#Receive_Side_Scaling

RSS Flow Label hashing allows TCP Protective Load Balancing (PLB)
to recover from receiver congestion / overload.
Rx CPU/queue hotspots are relatively common for data ingest
workloads, and so far we had to try to detect the condition
at the RPC layer and reopen the connection. PLB lets us change
the Flow Label and therefore Rx CPU on RTO, with minimal packet
reordering. PLB reaction times are much faster, and can happen
at any point in the connection, not just at RPC boundaries.

Due to the nature of host processing (relatively long queues,
other kernel subsystems masking IRQs for 100s of msecs)
the risk of reordering within the host is higher than in
the network. But for applications which need it - it is far
preferable to potentially persistent overload of subset of
queues.

It is expected that the hash communicated to the host
may change if the Flow Label changes. This may be surprising
to some host software, but I don't expect the devices
can compute two Toeplitz hashes, one with the Flow Label
for queue selection and one without for the rx hash
communicated to the host. Besides, changing the hash
may potentially help to change the path thru host queues.
User can disable NETIF_F_RXHASH if they require a stable
flow hash.

The name RXH_IP6_FL was chosen based on what we call
Flow Label variables in IPv6 processing (fl). I prefer
fl_lbl but that appears to be an fbnic-only spelling.
We could spell out RXH_IP6_FLOW_LABEL but existing
RXH_ defines are a lot more terse.

Willem notes [1] that Flow Label is defined as identifying the flow
and therefore including both the flow label _and_ the L4 header
fields is not generally necessary. But it should not hurt so
it's not explicitly prevented if the driver supports hashing
on both at the same time.

Link: https://lore.kernel.org/68483433b45e2_3cd66f29440@willemb.c.googlers.com.notmuch [1]
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: ecree.xilinx@gmail.com
---
 Documentation/netlink/specs/ethtool.yaml |  3 +++
 include/uapi/linux/ethtool.h             |  1 +
 net/ethtool/ioctl.c                      | 25 ++++++++++++++++++++++
 net/ethtool/rss.c                        | 27 ++++++++++++------------
 4 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 1bc1bd7d33c2..7a7594713f1f 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -204,6 +204,9 @@ c-version-name: ethtool-genl-version
         doc: dst port in case of TCP/UDP/SCTP
       -
         name: gtp-teid
+      -
+        name: ip6-fl
+        doc: IPv6 Flow Label
       -
         name: discard
         value: 31
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 9e9afdd1238a..8bd5ea5469d9 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2380,6 +2380,7 @@ enum {
 #define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
 #define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
 #define	RXH_GTP_TEID	(1 << 8) /* teid in case of GTP */
+#define	RXH_IP6_FL	(1 << 9) /* IPv6 flow label */
 #define	RXH_DISCARD	(1 << 31)
 
 #define	RX_CLS_FLOW_DISC	0xffffffffffffffffULL
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 43a7854e784e..0b2a4d0573b3 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1014,6 +1014,28 @@ static bool flow_type_hashable(u32 flow_type)
 	return false;
 }
 
+static bool flow_type_v6(u32 flow_type)
+{
+	switch (flow_type) {
+	case TCP_V6_FLOW:
+	case UDP_V6_FLOW:
+	case SCTP_V6_FLOW:
+	case AH_ESP_V6_FLOW:
+	case AH_V6_FLOW:
+	case ESP_V6_FLOW:
+	case IPV6_FLOW:
+	case GTPU_V6_FLOW:
+	case GTPC_V6_FLOW:
+	case GTPC_TEID_V6_FLOW:
+	case GTPU_EH_V6_FLOW:
+	case GTPU_UL_V6_FLOW:
+	case GTPU_DL_V6_FLOW:
+		return true;
+	}
+
+	return false;
+}
+
 /* When adding a new type, update the assert and, if it's hashable, add it to
  * the flow_type_hashable switch case.
  */
@@ -1077,6 +1099,9 @@ ethtool_set_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 	if (rc)
 		return rc;
 
+	if (info.data & RXH_IP6_FL && !flow_type_v6(info.flow_type))
+		return -EINVAL;
+
 	if (info.flow_type & FLOW_RSS && info.rss_context &&
 	    !ops->rxfh_per_ctx_fields)
 		return -EINVAL;
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 992e98abe9dd..202d95e8bf3e 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -536,35 +536,36 @@ void ethtool_rss_notify(struct net_device *dev, u32 type, u32 rss_context)
 #define RFH_MASK (RXH_L2DA | RXH_VLAN | RXH_IP_SRC | RXH_IP_DST | \
 		  RXH_L3_PROTO | RXH_L4_B_0_1 | RXH_L4_B_2_3 |	  \
 		  RXH_GTP_TEID | RXH_DISCARD)
+#define RFH_MASKv6 (RFH_MASK | RXH_IP6_FL)
 
 static const struct nla_policy ethnl_rss_flows_policy[] = {
 	[ETHTOOL_A_FLOW_ETHER]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
 	[ETHTOOL_A_FLOW_IP4]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
-	[ETHTOOL_A_FLOW_IP6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_IP6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASKv6),
 	[ETHTOOL_A_FLOW_TCP4]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
 	[ETHTOOL_A_FLOW_UDP4]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
 	[ETHTOOL_A_FLOW_SCTP4]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
 	[ETHTOOL_A_FLOW_AH_ESP4]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
-	[ETHTOOL_A_FLOW_TCP6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
-	[ETHTOOL_A_FLOW_UDP6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
-	[ETHTOOL_A_FLOW_SCTP6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
-	[ETHTOOL_A_FLOW_AH_ESP6]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_TCP6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASKv6),
+	[ETHTOOL_A_FLOW_UDP6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASKv6),
+	[ETHTOOL_A_FLOW_SCTP6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASKv6),
+	[ETHTOOL_A_FLOW_AH_ESP6]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASKv6),
 	[ETHTOOL_A_FLOW_AH4]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
 	[ETHTOOL_A_FLOW_ESP4]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
-	[ETHTOOL_A_FLOW_AH6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
-	[ETHTOOL_A_FLOW_ESP6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_AH6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASKv6),
+	[ETHTOOL_A_FLOW_ESP6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASKv6),
 	[ETHTOOL_A_FLOW_GTPU4]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
-	[ETHTOOL_A_FLOW_GTPU6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_GTPU6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASKv6),
 	[ETHTOOL_A_FLOW_GTPC4]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
-	[ETHTOOL_A_FLOW_GTPC6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_GTPC6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASKv6),
 	[ETHTOOL_A_FLOW_GTPC_TEID4]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
-	[ETHTOOL_A_FLOW_GTPC_TEID6]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_GTPC_TEID6]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASKv6),
 	[ETHTOOL_A_FLOW_GTPU_EH4]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
-	[ETHTOOL_A_FLOW_GTPU_EH6]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_GTPU_EH6]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASKv6),
 	[ETHTOOL_A_FLOW_GTPU_UL4]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
-	[ETHTOOL_A_FLOW_GTPU_UL6]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_GTPU_UL6]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASKv6),
 	[ETHTOOL_A_FLOW_GTPU_DL4]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
-	[ETHTOOL_A_FLOW_GTPU_DL6]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_GTPU_DL6]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASKv6),
 };
 
 const struct nla_policy ethnl_rss_set_policy[ETHTOOL_A_RSS_FLOW_HASH + 1] = {
-- 
2.50.1


