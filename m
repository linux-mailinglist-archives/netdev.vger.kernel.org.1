Return-Path: <netdev+bounces-39678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 624B67C40B1
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 22:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD0F28200A
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C29B29D01;
	Tue, 10 Oct 2023 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACnmzq4C"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E2C29CF2
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:05:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12BC19AE;
	Tue, 10 Oct 2023 13:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696968315; x=1728504315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2pfiZ1iiQtm2Zf4jLMIwrRDukxJh6A084sAa/FTq25E=;
  b=ACnmzq4C9znTgRUTX3TlmLOIb2YQ4/Grr9Xm758GgmKqYGvOSq+P7C5j
   PgFJ0v9/qPwQH9c9LSTxUIzaWCmfaIVa/oCsTdz09yvTzXlEuXak9sjcY
   8jKLRjBQsGbi9iwE05gnaK0xHhLB2y1roIeB1g2cpAbR6CiYheI6MnKA2
   qBbQdUXHzbUsci/MZJktq8WgvdMsfm3d3hhfCUug4qzc5tRYTRJoajRFY
   QvRJAWW7pHaeABfEXSVxhSftkyuiYAuy+EqudrJLW3rdhz8riUcjxGrox
   5ygqSDsj9PE36nI/k/BzMLnpwvRSHeeNV+mKwf8tAUeVfX5oDxq7IHnW6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="374840013"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="374840013"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 13:04:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1000819900"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="1000819900"
Received: from rhaeussl-mobl.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.252.42.107])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 13:04:54 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	corbet@lwn.net,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com,
	andrew@lunn.ch,
	horms@kernel.org,
	mkubecek@suse.cz,
	willemdebruijn.kernel@gmail.com,
	linux-doc@vger.kernel.org,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH net-next v3 1/6] net: ethtool: allow symmetric-xor RSS hash for any flow type
Date: Tue, 10 Oct 2023 14:04:32 -0600
Message-Id: <20231010200437.9794-2-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010200437.9794-1-ahmed.zaki@intel.com>
References: <20231010200437.9794-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Symmetric RSS hash functions are beneficial in applications that monitor
both Tx and Rx packets of the same flow (IDS, software firewalls, ..etc).
Getting all traffic of the same flow on the same RX queue results in
higher CPU cache efficiency.

A NIC that supports "symmetric-xor" can achieve this RSS hash symmetry
by XORing the source and destination fields and pass the values to the
RSS hash algorithm.

Only fields that has counterparts in the other direction can be
accepted; IP src/dst and L4 src/dst ports.

The user may request RSS hash symmetry for a specific flow type, via:

    # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n symmetric-xor

or turn symmetry off (asymmetric) by:

    # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 Documentation/networking/scaling.rst |  6 ++++++
 include/uapi/linux/ethtool.h         | 17 +++++++++--------
 net/ethtool/ioctl.c                  | 11 +++++++++++
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/scaling.rst b/Documentation/networking/scaling.rst
index 92c9fb46d6a2..64f3d7566407 100644
--- a/Documentation/networking/scaling.rst
+++ b/Documentation/networking/scaling.rst
@@ -44,6 +44,12 @@ by masking out the low order seven bits of the computed hash for the
 packet (usually a Toeplitz hash), taking this number as a key into the
 indirection table and reading the corresponding value.
 
+Some NICs support symmetric RSS hashing where, if the IP (source address,
+destination address) and TCP/UDP (source port, destination port) tuples
+are swapped, the computed hash is the same. This is beneficial in some
+applications that monitor TCP/IP flows (IDS, firewalls, ...etc) and need
+both directions of the flow to land on the same Rx queue (and CPU).
+
 Some advanced NICs allow steering packets to queues based on
 programmable filters. For example, webserver bound TCP port 80 packets
 can be directed to their own receive queue. Such “n-tuple” filters can
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index f7fba0dc87e5..b9ee667ad7e5 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2018,14 +2018,15 @@ static inline int ethtool_validate_duplex(__u8 duplex)
 #define	FLOW_RSS	0x20000000
 
 /* L3-L4 network traffic flow hash options */
-#define	RXH_L2DA	(1 << 1)
-#define	RXH_VLAN	(1 << 2)
-#define	RXH_L3_PROTO	(1 << 3)
-#define	RXH_IP_SRC	(1 << 4)
-#define	RXH_IP_DST	(1 << 5)
-#define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
-#define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
-#define	RXH_DISCARD	(1 << 31)
+#define	RXH_L2DA		(1 << 1)
+#define	RXH_VLAN		(1 << 2)
+#define	RXH_L3_PROTO		(1 << 3)
+#define	RXH_IP_SRC		(1 << 4)
+#define	RXH_IP_DST		(1 << 5)
+#define	RXH_L4_B_0_1		(1 << 6) /* src port in case of TCP/UDP/SCTP */
+#define	RXH_L4_B_2_3		(1 << 7) /* dst port in case of TCP/UDP/SCTP */
+#define	RXH_SYMMETRIC_XOR	(1 << 30)
+#define	RXH_DISCARD		(1 << 31)
 
 #define	RX_CLS_FLOW_DISC	0xffffffffffffffffULL
 #define RX_CLS_FLOW_WAKE	0xfffffffffffffffeULL
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b0ce4f81c01..b1bd0d4b48e8 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -980,6 +980,17 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	if (rc)
 		return rc;
 
+	/* If a symmetric hash is requested, then:
+	 * 1 - no other fields besides IP src/dst and/or L4 src/dst
+	 * 2 - If src is set, dst must also be set
+	 */
+	if ((info.data & RXH_SYMMETRIC_XOR) &&
+	    ((info.data & ~(RXH_SYMMETRIC_XOR | RXH_IP_SRC | RXH_IP_DST |
+	      RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
+	     (!!(info.data & RXH_IP_SRC) ^ !!(info.data & RXH_IP_DST)) ||
+	     (!!(info.data & RXH_L4_B_0_1) ^ !!(info.data & RXH_L4_B_2_3))))
+		return -EINVAL;
+
 	rc = dev->ethtool_ops->set_rxnfc(dev, &info);
 	if (rc)
 		return rc;
-- 
2.34.1


