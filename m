Return-Path: <netdev+bounces-194812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A25ACCBDF
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 19:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E14C16290F
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 17:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C1B1E5B71;
	Tue,  3 Jun 2025 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G109TQFn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCFF1DA60D
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971044; cv=none; b=P+0ZMvVYkWbIGCCxK7U73xspOlkHQ18f7xLj+aAN4CLwIvwGIZeX9ajirwbC25D1fn9ENC1FsKahPDKnLM1J+9kBopNJ1h+JvreEwnipWOP7MOa7tx07s8+U+l9H74TrULhNXAqmoxPjJvPNB+Tr+yqbli6AGeBsLoEwTd3AnJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971044; c=relaxed/simple;
	bh=3VOEtf7C6Rmn5SMN/tomRo79IXsgWtBe/myHENn3lXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUtEkxt1WG9vUnV5VdwcrHbD5rb9H7xDjbvPXMHVvtmaleiv7sTNQXenGCfcfLr8qpT9ccBRUFxeLtbEdX51t0FE2uXf7WahUFEu5vWgT7bskN2IASkDPzxQ6hm5QlhDk0l/KkngHFIK00bVKoSNNawVOXKOCQqJAQzgtzFQdMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G109TQFn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748971041; x=1780507041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3VOEtf7C6Rmn5SMN/tomRo79IXsgWtBe/myHENn3lXE=;
  b=G109TQFntuzTtSE7a+kjSSjGW6ugXLmGfRhFzSHAyw/clYJOvpjfnFp2
   F8tVQQnI0PFx5m2R6ax18HB5ZPmiQsYMpKMaI+JscYoH16yetkNbkUskR
   46A0Lfov/0CFiIcBhs+qXi6JLsSBuuFj4sz0iwYLqADa+8i0HywFko8s3
   VVuegOKtkx2dZElfs0KCCoLrw5Wsjt+EOut06QEzGQvrBEhvPsGacjd9C
   draGLbDHajlwCsDr1GJ8LLzLzfK7izHWQly3hJeNEbWdTgFMrY5/z+6zJ
   SuldnUkAvWBiMtN4n7cF57Jlv2HcSpsv10QpIGJcu80CF2EF0Wq33Hm5a
   A==;
X-CSE-ConnectionGUID: /lrvy/10TBK04oP/0+hbtg==
X-CSE-MsgGUID: mEx1kXpuS0SeoTxC3QwBQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="73556791"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="73556791"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 10:17:18 -0700
X-CSE-ConnectionGUID: LRTHu172Remw9r6NgN/LZg==
X-CSE-MsgGUID: OJa4k5lhQLiKcOC0ldnCVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="145546441"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 03 Jun 2025 10:17:18 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	sdf@fomichev.me,
	Jacob Keller <jacob.e.keller@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 5/6] iavf: sprinkle netdev_assert_locked() annotations
Date: Tue,  3 Jun 2025 10:17:06 -0700
Message-ID: <20250603171710.2336151-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250603171710.2336151-1-anthony.l.nguyen@intel.com>
References: <20250603171710.2336151-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Lockdep annotations help in general, but here it is extra good, as next
commit will remove crit lock.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.47.1


