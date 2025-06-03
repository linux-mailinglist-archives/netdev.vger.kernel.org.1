Return-Path: <netdev+bounces-194810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A8BACCBDB
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 19:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAAB57A8939
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 17:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD691DED6D;
	Tue,  3 Jun 2025 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XgR1mCIn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDC61D07BA
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971042; cv=none; b=asTO7L23Qs4GMI+D6H56NrIAFfx7jeAOE3B+1AQn8KVspXL8gdJB3pI5ybc5nOE6PNSxQNu0xD34jFzSCD4UISxwjsaRwWoOKexoOSWWXMNZrPULiax586+ntYDru/zr5j5fpx/UTAD5WVx7haR4ENstjAk/6lEhNDnM8BCZU/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971042; c=relaxed/simple;
	bh=KOmLKjug8EtUWZjs0xVgB6YVpNQvPWr19/kG4jY71wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUn/hTZnFLZraER7kwZHXtfxSgMAkH6Na+FtXYpDL2Rj28l7lKCIWUFrxyR/HdbU2pSz0qVoMtpRYv1vsYUizGd6b3TvN82XpvIBoSDkpCNWi13F2QfxZGgYIVNgB+98QZ/yLRArdATiVDsneHU3b9LFC0QlIsWfjaBFFTMo0pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XgR1mCIn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748971041; x=1780507041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KOmLKjug8EtUWZjs0xVgB6YVpNQvPWr19/kG4jY71wY=;
  b=XgR1mCInxTfErikj7i8dF7/DdkmnSIXzjDMFpOUSiUCJVr1/+9PXNi4g
   6Wox4pHxGPdbWj1/wMWcCp5nloMs5D+lbFSRYTjGkxDuO5LDkxVW1In8K
   V6lzx5Fk1kRTdidheqkVf09fnGscGgmrvQGn8AY0aY7bkNyCTPt7wnYwZ
   QKRSjfZkYUN6CayrcvnAnmiBlLDPJp+SNGoy3tx/ibaiFEZTaPf0g788i
   s7Q4HQ3nki/78DSZHi5drXfQlpHBBu35VZzxJakdXQH8Dd/ZiB6IpLlMc
   Jg/ng8ddYrIzreXfGHFn5KGMzObOxO8emUQAM2MNsKae0rwMUE4JgG16T
   A==;
X-CSE-ConnectionGUID: WIhXhLRHROe0Xm6DXXZY+w==
X-CSE-MsgGUID: 3IZQGATtRwGzkttNUjrvCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="73556776"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="73556776"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 10:17:17 -0700
X-CSE-ConnectionGUID: Py9u0isXSUaE3X3Qx3+VhA==
X-CSE-MsgGUID: rpsBlZYyTwWYvh2DQad9xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="145546421"
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
Subject: [PATCH net 3/6] iavf: simplify watchdog_task in terms of adminq task scheduling
Date: Tue,  3 Jun 2025 10:17:04 -0700
Message-ID: <20250603171710.2336151-4-anthony.l.nguyen@intel.com>
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

Simplify the decision whether to schedule adminq task. The condition is
the same, but it is executed in more scenarios.

Note that movement of watchdog_done label makes this commit a bit
surprising. (Hence not squashing it to anything bigger).

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2c6e033c7341..5efe44724d11 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2934,6 +2934,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 			return;
 		}
 
+		msec_delay = 20;
 		goto restart_watchdog;
 	}
 
@@ -3053,10 +3054,13 @@ static void iavf_watchdog_task(struct work_struct *work)
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		dev_err(&adapter->pdev->dev, "Hardware reset detected\n");
 		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_PENDING);
-		msec_delay = 2000;
-		goto watchdog_done;
 	}
+	if (adapter->aq_required)
+		msec_delay = 20;
+	else
+		msec_delay = 2000;
 
+watchdog_done:
 	mutex_unlock(&adapter->crit_lock);
 restart_watchdog:
 	netdev_unlock(netdev);
@@ -3064,15 +3068,6 @@ static void iavf_watchdog_task(struct work_struct *work)
 	/* note that we schedule a different task */
 	if (adapter->state >= __IAVF_DOWN)
 		queue_work(adapter->wq, &adapter->adminq_task);
-	if (adapter->aq_required)
-		msec_delay = 20;
-	else
-		msec_delay = 2000;
-	goto skip_unlock;
-watchdog_done:
-	mutex_unlock(&adapter->crit_lock);
-	netdev_unlock(netdev);
-skip_unlock:
 
 	if (msec_delay != IAVF_NO_RESCHED)
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-- 
2.47.1


