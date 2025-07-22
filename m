Return-Path: <netdev+bounces-208755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7072B0CF4B
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 03:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D5A27A4A91
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 01:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CD41B87F2;
	Tue, 22 Jul 2025 01:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRZLzTAo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED071ADC7E
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148973; cv=none; b=gAjEKgKSPZr2ZJDfp5gZ9y4VI/3/HwlDNqRxur3dEsqIH4xlDABk8zRnltiYuHm9/madKXdXpdSkPN/tIa4+jvWfXq1QNu0NQ9F6wj/rE3us5uW/Hh/8yYRy5lZT2gVQkxqZ2Vlnn6g//NKe8r4uuRGa0a/ZLnl0EOAEsRSRmFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148973; c=relaxed/simple;
	bh=l1chimkoqp3Srh+nhVAWn94lWr3o/3XyHfrcSVaBM3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ba5mrPUDGudQoP41qaV4mi6AxQxrklgKRRffXmsLoDgdSts/8Ixq+kZuNx700SDORfMVXHYSyLHwcDdn3B21FjueLLHhviIDamtHQ+7Lmw9usfdujB+wB5rynHIwf3mxGVgh8n3+jdBsWhCAPk0oVWJLMO7EqOwJ0NU4UjJFvLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRZLzTAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC50C4CEF8;
	Tue, 22 Jul 2025 01:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753148972;
	bh=l1chimkoqp3Srh+nhVAWn94lWr3o/3XyHfrcSVaBM3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RRZLzTAoc6CYBD/Aww5O4nwtUZyfqKV5huUDjRDVBXcuCjHJKEIOVl7xsNk/8NBfV
	 3c5F0zzTb1FJvAZUODWArTKfB0U6mJuoqyqI5NoUjV3fcg9oZ0qVCr5ySfT8a3x771
	 gDtQ8IO9gdhpvrEuuC2+vtYM8c+2O2/cBTxXmFhoS9ABz9pe7Z3LRXDnN8v77XM4aC
	 IqObzoqw6Z5e3oV+CdNs48JxJadpJfoxbDliz3C00Ndc2pQ6KG8wHT8EKa1v0yae/U
	 5RrgE0GeGOQ1ECaCKYPTJkvJWEzxO2RBt2cSZmCi7A4Dhk6JZi9j317809zZzSx9x+
	 QaslnZpzgQAKw==
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
	gal@nvidia.com,
	andrew@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	ecree.xilinx@gmail.com
Subject: [PATCH net-next v2 1/4] net: ethtool: support including Flow Label in the flow hash for RSS
Date: Mon, 21 Jul 2025 18:49:12 -0700
Message-ID: <20250722014915.3365370-2-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722014915.3365370-1-kuba@kernel.org>
References: <20250722014915.3365370-1-kuba@kernel.org>
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
index 1063d5d32fea..e635cfe9780b 100644
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


