Return-Path: <netdev+bounces-38690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F00267BC266
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 00:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8029828189C
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 22:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1026F38F86;
	Fri,  6 Oct 2023 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZEqwDaNs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298E21CA82
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 22:47:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C45A6;
	Fri,  6 Oct 2023 15:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696632466; x=1728168466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=32akxHSYhb17D+XQtNXel6BwEp9EweKFmYRPZqxIveM=;
  b=ZEqwDaNsOutjV1XqFFzHvENYgerYgNubn0sOoORqGO+9W3rQfdXlPwUf
   aIKys78bnyt/o22DzMTh4N4V7Gu+wRUp7e1qNBjQqPFDQ9LAEy+P8H+Yo
   DfVaF8J4wkUoxsttak4FRntVrZfpUtH7f4fiqn5iOv/VOy52FqdyAL8cK
   0i++hL0J43mHmfQgymaVajGrffNKYGGrOXKGv7FMvcKRO+9h7VkGBJWpR
   34TW9Ycxl3/F556dCEzSzc9gwxRUBcJV+KSgZ6G72M3MWNm3GKeTKmfj4
   FP7zwPN4bNZGd2RhxC1Q/H+2hz2z4djM3NK/m85kdEzEv5Be1kDfpUYiD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="363201059"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="363201059"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 15:47:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="1083610304"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="1083610304"
Received: from dianaman-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.249.35.113])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 15:47:41 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	linux-doc@vger.kernel.org,
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
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH net-next v2 1/6] net: ethtool: allow symmetric RSS hash for any flow type
Date: Fri,  6 Oct 2023 16:47:21 -0600
Message-Id: <20231006224726.443836-2-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006224726.443836-1-ahmed.zaki@intel.com>
References: <20231006224726.443836-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Symmetric RSS hash functions are beneficial in applications that monitor
both Tx and Rx packets of the same flow (IDS, software firewalls, ..etc).
Getting all traffic of the same flow on the same RX queue results in
higher CPU cache efficiency.

Only fields that has counterparts in the other direction can be
accepted; IP src/dst and L4 src/dst ports.

The user may request RSS hash symmetry for a specific flow type, via:

    # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n symmetric

or turn symmetry off (asymmetric) by:

    # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 Documentation/networking/scaling.rst |  6 ++++++
 include/uapi/linux/ethtool.h         |  1 +
 net/ethtool/ioctl.c                  | 11 +++++++++++
 3 files changed, 18 insertions(+)

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
index f7fba0dc87e5..bf67c8094ae0 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2025,6 +2025,7 @@ static inline int ethtool_validate_duplex(__u8 duplex)
 #define	RXH_IP_DST	(1 << 5)
 #define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
 #define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
+#define	RXH_SYMMETRIC	(1 << 30)
 #define	RXH_DISCARD	(1 << 31)
 
 #define	RX_CLS_FLOW_DISC	0xffffffffffffffffULL
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b0ce4f81c01..44742653a4bd 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -980,6 +980,17 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	if (rc)
 		return rc;
 
+	/* If a symmetric hash is requested, then:
+	 * 1 - no other fields besides IP src/dst and/or L4 src/dst
+	 * 2 - If src is set, dst must also be set
+	 */
+	if ((info.data & RXH_SYMMETRIC) &&
+	    ((info.data & ~(RXH_SYMMETRIC | RXH_IP_SRC | RXH_IP_DST |
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


