Return-Path: <netdev+bounces-195806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E58BAD2508
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 19:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD713AE4F2
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA83221C19A;
	Mon,  9 Jun 2025 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7Scy5Rj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80C821C18A
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490495; cv=none; b=fm6OT5mVjUWsN43mPEcoNYcTZYJ+pj/ZF90S1wTXoMPoz9UKMQdzS+YnbS2lbKD78wrev65BLuASwBgfNy3qkMFPq0vTAByhUFYRrcGc7ZwbqogjNVY0lY1ylP2bAaGV86RlBhsIouCZocmJ4b+1KGmSAg9p5gu6boThM3T/cFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490495; c=relaxed/simple;
	bh=7/MOCe5lFayOqlhjzkblAExehqK0NnWk8KcXVuVHtcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGJzSgBfluftMzShpXxAnKeBeYa3hlDYL0L6v87Q2EDxfsGPipMKC+RRDVD11/n8PzV5wmnCqka0ImyHAW056/MEexVhWChX0PspclDCbLaIz+ES5RvUHljkSMLV0H6n/qvf4fcnqqN7IxJoNq1jo0CDfEL7CZ9fcL9jx9LfncY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7Scy5Rj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46983C4CEF0;
	Mon,  9 Jun 2025 17:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749490495;
	bh=7/MOCe5lFayOqlhjzkblAExehqK0NnWk8KcXVuVHtcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7Scy5RjD4J0mu8wisHeSdKnxjMRtXb2x+4g36ddovSXaFnyMV57d+4iSGAB0tBVD
	 wTuzGz+dCSxvsMh3fPFf9N0kDgCqAdVYP9oX2A8vdutaR2vwgPfikR/PoRtuOuGxRt
	 eGJ9S26Bx0f/SJN9CUH+rjbd5qO3RfT3D4MBgF4ljeTnxp0R/U3PbCt4pBFG6/rikF
	 Ndli3s1bXFJvBd6AEiVesoMn/axKdRea4r3QHlmXFXskeiet6H1riGtQeGT/gKVPmT
	 h6xjrzDMEOL/GXdfnVfl3NDJ8ebBpOSK6qwZGk4ahQPoiaRTWsIW4SiBQm4lzznjCl
	 uAKsKgZmxaCUA==
From: Jakub Kicinski <kuba@kernel.org>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com
Cc: willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	ecree.xilinx@gmail.com
Subject: [RFC net-next 2/6] net: ethtool: support including Flow Label in the flow hash for RSS
Date: Mon,  9 Jun 2025 10:34:38 -0700
Message-ID: <20250609173442.1745856-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609173442.1745856-1-kuba@kernel.org>
References: <20250609173442.1745856-1-kuba@kernel.org>
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

https://www.opencompute.org/documents/ocp-server-nic-core-features-specification-ocp-spec-format-1-1-pdf

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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: ecree.xilinx@gmail.com
---
 include/uapi/linux/ethtool.h |  1 +
 net/ethtool/ioctl.c          | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 707c1844010c..fed36644eb1d 100644
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
index e8ca70554b2e..181ec2347547 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1013,6 +1013,28 @@ static bool flow_type_hashable(u32 flow_type)
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
@@ -1066,6 +1088,9 @@ ethtool_srxfh_check(struct net_device *dev, const struct ethtool_rxnfc *info)
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	int rc;
 
+	if (info->data & RXH_IP6_FL && !flow_type_v6(info->flow_type))
+		return -EINVAL;
+
 	if (ops->get_rxfh) {
 		struct ethtool_rxfh_param rxfh = {};
 
-- 
2.49.0


