Return-Path: <netdev+bounces-179276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C42A7BADD
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 12:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150D91B60580
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BAB1EFFAE;
	Fri,  4 Apr 2025 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTzrEui1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B377D1EE7BD
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762589; cv=none; b=mfhILAzlz//viAuTmiEp+7o0ega5y1On+kE/nNInwXBaA1PtVBG8q/K8DuIvALwSuf3g4R8khwxxHX1R0wzuXFtObJMW1QKop8Rsc3e71LjiVZ+C40/Yth5dj7oBmKqkrRHAlS5Rup4ITNY/wZ3BZwylFSnVx3gnV5Ha1/69oNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762589; c=relaxed/simple;
	bh=Wx+EMMZR5GdLlwsiIxp4lVeOb+0Ai/li5efqYtdtJp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CBk5W8G1joDv/WAJzf89UUV5IKFdeF23+iWILCQd5V3uR7xLuLxpr7HxLjjoJ+FmWESwv4pZjXy06PE+8aLQxGwPc579wjTy1VccCW/JVdYu5EDZz4sDjwx737IbYP0HiyaHBzDqEH2zmEf1yNmNoRAPzSQyMC0eGKNDs95PiVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTzrEui1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743762588; x=1775298588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wx+EMMZR5GdLlwsiIxp4lVeOb+0Ai/li5efqYtdtJp0=;
  b=cTzrEui1+nD8QpsSua1vA9Sec2uKQ6/O1xsDBx1Her3m4htNnGRIDLvM
   01+Q+z1x2KAs0T+q/0tan4Ry83MMYscxCNndTauuoMX0gO+8BshfdEYfx
   PNR8IayVaYBuc8OH+ODxgYzX6bLkaWQBU9SpJPJkbqSron9ktupBQxD9Z
   WY2lFFOTD9eRHfiJQPIAHsM2Nb6Q1lu2sRdqYBRsQBt+eQaCtAVIyWy9K
   UKhLM7DgMwQB6042n4mlJ02tYP8dv4uBUEKkHj7tRFcT7Df4zMr0zYKjs
   GdijBYJwlzQ/tWYsrsTMyQ6DlijGPeeVMQrWRnMeMFfC9ev/iNolNvjcv
   g==;
X-CSE-ConnectionGUID: lgF8Z+mCSGyLJiZ2rYfvxQ==
X-CSE-MsgGUID: XRni/ks0Qd2aqJqLNjtiJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="48992448"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="48992448"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 03:29:45 -0700
X-CSE-ConnectionGUID: rML+yVqVTgOJAsTaXa+o5w==
X-CSE-MsgGUID: j96FCP19TTmVImz1K2SSmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="164485308"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 04 Apr 2025 03:29:43 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5B65D33EA8;
	Fri,  4 Apr 2025 11:29:42 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-net 5/6] iavf: sprinkle netdev_assert_locked() annotations
Date: Fri,  4 Apr 2025 12:23:20 +0200
Message-Id: <20250404102321.25846-6-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250404102321.25846-1-przemyslaw.kitszel@intel.com>
References: <20250404102321.25846-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lockdep annotations help in general, but here it is extra good, as next
commit will remove crit lock.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  6 ++++++
 drivers/net/ethernet/intel/iavf/iavf_main.c    | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 288bb5b2e72e..03d86fe80ad9 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -4,6 +4,8 @@
 #include <linux/bitfield.h>
 #include <linux/uaccess.h>
 
+#include <net/netdev_lock.h>
+
 /* ethtool support for iavf */
 #include "iavf.h"
 
@@ -1259,6 +1261,8 @@ static int iavf_add_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	int count = 50;
 	int err;
 
+	netdev_assert_locked(adapter->netdev);
+
 	if (!(adapter->flags & IAVF_FLAG_FDIR_ENABLED))
 		return -EOPNOTSUPP;
 
@@ -1440,6 +1444,8 @@ iavf_set_adv_rss_hash_opt(struct iavf_adapter *adapter,
 	u64 hash_flds;
 	u32 hdrs;
 
+	netdev_assert_locked(adapter->netdev);
+
 	if (!ADV_RSS_SUPPORT(adapter))
 		return -EOPNOTSUPP;
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 4b6963ffaba5..bf8c7baf2ab8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1292,6 +1292,8 @@ static void iavf_configure(struct iavf_adapter *adapter)
  **/
 static void iavf_up_complete(struct iavf_adapter *adapter)
 {
+	netdev_assert_locked(adapter->netdev);
+
 	iavf_change_state(adapter, __IAVF_RUNNING);
 	clear_bit(__IAVF_VSI_DOWN, adapter->vsi.state);
 
@@ -1417,6 +1419,8 @@ void iavf_down(struct iavf_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 
+	netdev_assert_locked(netdev);
+
 	if (adapter->state <= __IAVF_DOWN_PENDING)
 		return;
 
@@ -3078,6 +3082,8 @@ static void iavf_disable_vf(struct iavf_adapter *adapter)
 	struct iavf_vlan_filter *fv, *fvtmp;
 	struct iavf_cloud_filter *cf, *cftmp;
 
+	netdev_assert_locked(adapter->netdev);
+
 	adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
 
 	/* We don't use netif_running() because it may be true prior to
@@ -5194,6 +5200,8 @@ iavf_shaper_set(struct net_shaper_binding *binding,
 	struct iavf_ring *tx_ring;
 	int ret = 0;
 
+	netdev_assert_locked(adapter->netdev);
+
 	mutex_lock(&adapter->crit_lock);
 	if (handle->id >= adapter->num_active_queues)
 		goto unlock;
@@ -5222,6 +5230,8 @@ static int iavf_shaper_del(struct net_shaper_binding *binding,
 	struct iavf_adapter *adapter = netdev_priv(binding->netdev);
 	struct iavf_ring *tx_ring;
 
+	netdev_assert_locked(adapter->netdev);
+
 	mutex_lock(&adapter->crit_lock);
 	if (handle->id >= adapter->num_active_queues)
 		goto unlock;
-- 
2.39.3


