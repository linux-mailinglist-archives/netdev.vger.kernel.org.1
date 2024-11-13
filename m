Return-Path: <netdev+bounces-144550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AEB9C7C00
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7189B36C2E
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA902071EC;
	Wed, 13 Nov 2024 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdJGFZSm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0AA206959
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524087; cv=none; b=N+VUKMmjnaUim+HKE/l7eWglvETbe4rl/6oOPTk1KqUQmaPA1NMsLCHqYdLiF42iZp5z3bgAFWT3OFDeFy64F8c1mPjTN0uGsgX/g4lkzX6JesYNtiT907KZA432XK76a7GZt8WZ6/dd2AiiAA1wXzpmPAaxHDn0NPpAZBoRNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524087; c=relaxed/simple;
	bh=zQ0iotFVz+YV9+SneoYSpAEeQ2v22cN1qtJoss8Sduc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ppuf6Bc4oqHCWLu0Np/GYyVAorPLkyDFYkZ+eBb4E0WITey85oVlF2VAJBRkHd1unv19vD+429nzTC0hrE8eAMRXU4dkoNCOBf0lC3b2p6XCJKsyoHQBsUnM37r8Kvqqa4tmYhZAHLHoZD9NtTNlsJnhsI/79cxwlcpUvBvSxDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdJGFZSm; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731524086; x=1763060086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zQ0iotFVz+YV9+SneoYSpAEeQ2v22cN1qtJoss8Sduc=;
  b=ZdJGFZSm+TYwgvIKvb31Ktlpp/fW8SB9QSGy4mEO+aGl3sU6V433jngb
   0TpGu/EraTk5N6G1S/p3Rf1+TXl7FTSbmTuC5GFU/UYsBt9cY3pWr+mDQ
   TtIAOWhfOW9ypVI9fEHjFnY5aO7RNeEPDaBJIn23AeAlAMfaPOCdJnBY7
   YuzhHqL9ify+3wuJxrB4y6yBstOIKZi/EJnQ5irSCL1FmJ+kwon35CHeL
   FtiuzFA3DMPRMGjial8WHqZPhouAJYd+KktVu2GSWzJxc7SxmAK69dMdR
   N5Wy2xzfBaR2asTCrbF0tjYUty15tncRK51cAJd6THQlHn6ttrbMeTiqU
   g==;
X-CSE-ConnectionGUID: SiqJHU6FTuiw3vx0T5MtKQ==
X-CSE-MsgGUID: Tos9bghsSTmRF6IfKV5Hsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31589525"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31589525"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 10:54:42 -0800
X-CSE-ConnectionGUID: JYeVUEviROKGGwYyDxjP0Q==
X-CSE-MsgGUID: 2/fU/q0yQ8aXFTmXK+J9qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="87520757"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Nov 2024 10:54:41 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Diomidis Spinellis <dds@aueb.gr>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next v2 10/14] ixgbe: Break include dependency cycle
Date: Wed, 13 Nov 2024 10:54:25 -0800
Message-ID: <20241113185431.1289708-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241113185431.1289708-1-anthony.l.nguyen@intel.com>
References: <20241113185431.1289708-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Diomidis Spinellis <dds@aueb.gr>

Header ixgbe_type.h includes ixgbe_mbx.h.  Also, header
ixgbe_mbx.h included ixgbe_type.h, thus introducing a circular
dependency.

- Remove ixgbe_mbx.h inclusion from ixgbe_type.h.

- ixgbe_mbx.h requires the definition of struct ixgbe_mbx_operations
  so move its definition there. While at it, add missing argument
  identifier names.

- Add required forward structure declarations.

- Include ixgbe_mbx.h in the .c files that need it, for the
  following reasons:

  ixgbe_sriov.c uses ixgbe_check_for_msg
  ixgbe_main.c uses ixgbe_init_mbx_params_pf
  ixgbe_82599.c uses mbx_ops_generic
  ixgbe_x540.c uses mbx_ops_generic
  ixgbe_x550.c uses mbx_ops_generic

Signed-off-by: Diomidis Spinellis <dds@aueb.gr>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h   | 16 +++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h  | 15 ++-------------
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c  |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c  |  1 +
 7 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
index 283a23150a4d..4aaaea3b5f8f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
@@ -6,6 +6,7 @@
 #include <linux/sched.h>
 
 #include "ixgbe.h"
+#include "ixgbe_mbx.h"
 #include "ixgbe_phy.h"
 
 #define IXGBE_82598_MAX_TX_QUEUES 32
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 8b8404d8c946..c229a26fbbb7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -43,6 +43,7 @@
 #include "ixgbe.h"
 #include "ixgbe_common.h"
 #include "ixgbe_dcb_82599.h"
+#include "ixgbe_mbx.h"
 #include "ixgbe_phy.h"
 #include "ixgbe_sriov.h"
 #include "ixgbe_model.h"
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
index bd205306934b..bf65e82b4c61 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
@@ -4,7 +4,7 @@
 #ifndef _IXGBE_MBX_H_
 #define _IXGBE_MBX_H_
 
-#include "ixgbe_type.h"
+#include <linux/types.h>
 
 #define IXGBE_VFMAILBOX_SIZE        16 /* 16 32 bit words - 64 bytes */
 
@@ -96,6 +96,8 @@ enum ixgbe_pfvf_api_rev {
 #define IXGBE_VF_MBX_INIT_TIMEOUT 2000 /* number of retries on mailbox */
 #define IXGBE_VF_MBX_INIT_DELAY   500  /* microseconds between retries */
 
+struct ixgbe_hw;
+
 int ixgbe_read_mbx(struct ixgbe_hw *, u32 *, u16, u16);
 int ixgbe_write_mbx(struct ixgbe_hw *, u32 *, u16, u16);
 int ixgbe_check_for_msg(struct ixgbe_hw *, u16);
@@ -105,6 +107,18 @@ int ixgbe_check_for_rst(struct ixgbe_hw *, u16);
 void ixgbe_init_mbx_params_pf(struct ixgbe_hw *);
 #endif /* CONFIG_PCI_IOV */
 
+struct ixgbe_mbx_operations {
+	int (*init_params)(struct ixgbe_hw *hw);
+	int (*read)(struct ixgbe_hw *hw, u32 *msg, u16 size, u16 vf_number);
+	int (*write)(struct ixgbe_hw *hw, u32 *msg, u16 size, u16 vf_number);
+	int (*read_posted)(struct ixgbe_hw *hw, u32 *msg, u16 size, u16 mbx_id);
+	int (*write_posted)(struct ixgbe_hw *hw, u32 *msg, u16 size,
+			    u16 mbx_id);
+	int (*check_for_msg)(struct ixgbe_hw *hw, u16 vf_number);
+	int (*check_for_ack)(struct ixgbe_hw *hw, u16 vf_number);
+	int (*check_for_rst)(struct ixgbe_hw *hw, u16 vf_number);
+};
+
 extern const struct ixgbe_mbx_operations mbx_ops_generic;
 
 #endif /* _IXGBE_MBX_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index e71715f5da22..9631559a5aea 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -18,6 +18,7 @@
 
 #include "ixgbe.h"
 #include "ixgbe_type.h"
+#include "ixgbe_mbx.h"
 #include "ixgbe_sriov.h"
 
 #ifdef CONFIG_PCI_IOV
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 346e3d9114a8..9baccacd02a1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3601,19 +3601,6 @@ struct ixgbe_phy_info {
 	u32				nw_mng_if_sel;
 };
 
-#include "ixgbe_mbx.h"
-
-struct ixgbe_mbx_operations {
-	int (*init_params)(struct ixgbe_hw *hw);
-	int (*read)(struct ixgbe_hw *, u32 *, u16,  u16);
-	int (*write)(struct ixgbe_hw *, u32 *, u16, u16);
-	int (*read_posted)(struct ixgbe_hw *, u32 *, u16,  u16);
-	int (*write_posted)(struct ixgbe_hw *, u32 *, u16, u16);
-	int (*check_for_msg)(struct ixgbe_hw *, u16);
-	int (*check_for_ack)(struct ixgbe_hw *, u16);
-	int (*check_for_rst)(struct ixgbe_hw *, u16);
-};
-
 struct ixgbe_mbx_stats {
 	u32 msgs_tx;
 	u32 msgs_rx;
@@ -3623,6 +3610,8 @@ struct ixgbe_mbx_stats {
 	u32 rsts;
 };
 
+struct ixgbe_mbx_operations;
+
 struct ixgbe_mbx_info {
 	const struct ixgbe_mbx_operations *ops;
 	struct ixgbe_mbx_stats stats;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index f1ffa398f6df..81e1df83f136 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -6,6 +6,7 @@
 #include <linux/sched.h>
 
 #include "ixgbe.h"
+#include "ixgbe_mbx.h"
 #include "ixgbe_phy.h"
 #include "ixgbe_x540.h"
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index a5f644934445..d9a8cf018d3b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -4,6 +4,7 @@
 #include "ixgbe_x540.h"
 #include "ixgbe_type.h"
 #include "ixgbe_common.h"
+#include "ixgbe_mbx.h"
 #include "ixgbe_phy.h"
 
 static int ixgbe_setup_kr_speed_x550em(struct ixgbe_hw *, ixgbe_link_speed);
-- 
2.42.0


