Return-Path: <netdev+bounces-65270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7385E839D46
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 00:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156881F283A9
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 23:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5023B54BC8;
	Tue, 23 Jan 2024 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nar33ixm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983A43B78E
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706052729; cv=none; b=YIcq0eLm2IhI30+dzRXj20x43B0vRdk+33RAFdAwC6j1CXu7kNwyDZSqGlq6Jh0yZ/MVGYNI6MeSgI7UEUfN6fGFNRHopbiz0lIBy9Y84TOSI90rhkujnhv6Y6iRUdnlCIHUKN3w6X/IbpG/wfc6lyjVS0Av22a+8Sw7bKRzuyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706052729; c=relaxed/simple;
	bh=Qnk+CLXPsz3J+1HCOsUazVYd2TdrH4w8Yw3fWliKBk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XRUcwiPGFmYOpxopLC2OL2KDI5J12j1gJI0u7qQmI9lK4Tfe+f3d8nYKwrOtanNofz6cKTYPLZVRyy3BdbAgZpX8f5jjx0epofb4ex7pq3nJX9+h/jXdJNt2RtlqC3u7dKVkJwnirHKKqqNfCVd5HnAmefRvVSAQx99xc9STy1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nar33ixm; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706052727; x=1737588727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qnk+CLXPsz3J+1HCOsUazVYd2TdrH4w8Yw3fWliKBk4=;
  b=Nar33ixm+OAHbD0fUVL5xbVOk0aqpPLLJwuqPTlEMVahsVBpG2gEf0Nz
   tAKUtX0i5dfl7WPuFMUVNbWA0oUEUresiCaQb3GjuMkwbJbrxzdSYT4tF
   TI7M+024c9wy4W2mEM/yo2ngEKCZjVu5KkQJrvshWUTUKEaDufdVKkGos
   guzwzDwEInSWTFheRTBbqZeLzaWRzCrWvm7x2Omc6WEptTvrSEHo31EgZ
   eYEV+s2XIDi+twuBfmByHFuA4n9MFapAFLo+9G3QnuZiCdq1/UJRHl7WH
   tWJrc3+mtLfPHkIVFp7DAx8fTXq2tFRME4sXusvFyxASC787zrvyOWI4g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400552167"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="400552167"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 15:32:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="909469425"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="909469425"
Received: from gkon-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.252.41.99])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 15:32:01 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH iwl-net 1/2] iavf: fix reset in early states
Date: Tue, 23 Jan 2024 16:31:39 -0700
Message-Id: <20240123233140.309522-2-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123233140.309522-1-ahmed.zaki@intel.com>
References: <20240123233140.309522-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iavf_reset_task() assumes that the adapter has finished the
initialization cycle and is either in __IAVF_DOWN or __IAVF_RUNNING.

At the early states, no resources have been allocated. Allow an early reset
by simply shutting down the admin queue and reverting to the first state
__IAVF_STARTUP.

Fixes: 5eae00c57f5e ("i40evf: main driver core")
Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 335fd13e86f7..e1569035d5d0 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3037,6 +3037,17 @@ static void iavf_reset_task(struct work_struct *work)
 	}
 
 continue_reset:
+	/* If we are still early in the state machine, just restart. */
+	if (adapter->state <= __IAVF_INIT_FAILED) {
+		iavf_shutdown_adminq(hw);
+		iavf_change_state(adapter, __IAVF_STARTUP);
+		iavf_startup(adapter);
+		mutex_unlock(&adapter->crit_lock);
+		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
+				   msecs_to_jiffies(30));
+		return;
+	}
+
 	/* We don't use netif_running() because it may be true prior to
 	 * ndo_open() returning, so we can't assume it means all our open
 	 * tasks have finished, since we're not holding the rtnl_lock here.
-- 
2.34.1


