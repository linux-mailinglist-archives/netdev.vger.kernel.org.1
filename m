Return-Path: <netdev+bounces-223729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BF2B5A3ED
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D590582494
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32322F9DAD;
	Tue, 16 Sep 2025 21:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dplU8l7L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1652F0689
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058096; cv=none; b=ucymviUiSQ2rXb65lqCb+9ALcTKyG/eino2gNfyPE/kHCWA3+mGKLMpDVt6c4fQe7DfxQXV1tQGvybEBBx40gRL7R9RGof8eFGc8/LnlY1d57881SJ4DO5ooLmNOzQGuukjsSbMQQ8pvHt9OPhHEcmouohhfAAP30NwPd2s4MJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058096; c=relaxed/simple;
	bh=G5Ro/tTwEz/32uIV9sojWYSBXPZLxnHIoSL3Gqg2Ekw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miu3pIcVvByQ5ZR/DHmrI7II1krcqrZ+bbmOc1hMcK/K/5U2S01fqI1uH0oEE5JOffKBpqW54rNuLE3afvo3SYONWnn7nWFIhI+08UO5S17gQCOXAzNNwFnC6+yWHo6R2ch8u6vp7JMk+y2LFrasKVYsMA/TqD8NX/x9DxdWYSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dplU8l7L; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758058095; x=1789594095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G5Ro/tTwEz/32uIV9sojWYSBXPZLxnHIoSL3Gqg2Ekw=;
  b=dplU8l7LHsAIqNbVbJfBQgQbOQNyBo7yaGXYBls/Fyl7rfbV5QZX2nXg
   niOv76iFOUXCnvik8Cru62cYYFoUM1bP8V4OwQNqc+xDMaFd8eyuyzQCm
   7eC4GcyuCZy2lAPqZQk0jDTPS8QDrTo4Us96KcAtK7RIywRLIZ2yxAOse
   PLjmLDqKseABcvSbk40B2bA0Ztqtt042IDDYkLyPqEhr1dMEMcX4QSx4s
   iRMg9KYeCh+AUV9+gA/vXvyFugej9BiEBH5KdeawufD+jXnfu1VMa8imd
   3UfOBAmt1jBTYRZV0SFqjGSu9WVjIHBQofxLdDttaasFBEhYhvy6xtUFn
   w==;
X-CSE-ConnectionGUID: 7aRwK8dtR8WUMX39MX3SAQ==
X-CSE-MsgGUID: dn4sJiLDTTCCrm0B2F/vLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60410786"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60410786"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 14:28:14 -0700
X-CSE-ConnectionGUID: 13wuMgfgSGOAN5+2c4o9Gw==
X-CSE-MsgGUID: jgNkKl0fRT+11JR7tz7ttA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,270,1751266800"; 
   d="scan'208";a="180316944"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 16 Sep 2025 14:28:13 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <enjuk@amazon.com>,
	anthony.l.nguyen@intel.com,
	kohei.enju@gmail.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net 5/5] igc: don't fail igc_probe() on LED setup error
Date: Tue, 16 Sep 2025 14:28:00 -0700
Message-ID: <20250916212801.2818440-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250916212801.2818440-1-anthony.l.nguyen@intel.com>
References: <20250916212801.2818440-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kohei Enju <enjuk@amazon.com>

When igc_led_setup() fails, igc_probe() fails and triggers kernel panic
in free_netdev() since unregister_netdev() is not called. [1]
This behavior can be tested using fault-injection framework, especially
the failslab feature. [2]

Since LED support is not mandatory, treat LED setup failures as
non-fatal and continue probe with a warning message, consequently
avoiding the kernel panic.

[1]
 kernel BUG at net/core/dev.c:12047!
 Oops: invalid opcode: 0000 [#1] SMP NOPTI
 CPU: 0 UID: 0 PID: 937 Comm: repro-igc-led-e Not tainted 6.17.0-rc4-enjuk-tnguy-00865-gc4940196ab02 #64 PREEMPT(voluntary)
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 RIP: 0010:free_netdev+0x278/0x2b0
 [...]
 Call Trace:
  <TASK>
  igc_probe+0x370/0x910
  local_pci_probe+0x3a/0x80
  pci_device_probe+0xd1/0x200
 [...]

[2]
 #!/bin/bash -ex

 FAILSLAB_PATH=/sys/kernel/debug/failslab/
 DEVICE=0000:00:05.0
 START_ADDR=$(grep " igc_led_setup" /proc/kallsyms \
         | awk '{printf("0x%s", $1)}')
 END_ADDR=$(printf "0x%x" $((START_ADDR + 0x100)))

 echo $START_ADDR > $FAILSLAB_PATH/require-start
 echo $END_ADDR > $FAILSLAB_PATH/require-end
 echo 1 > $FAILSLAB_PATH/times
 echo 100 > $FAILSLAB_PATH/probability
 echo N > $FAILSLAB_PATH/ignore-gfp-wait

 echo $DEVICE > /sys/bus/pci/drivers/igc/bind

Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 266bfcf2a28f..a427f05814c1 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -345,6 +345,7 @@ struct igc_adapter {
 	/* LEDs */
 	struct mutex led_mutex;
 	struct igc_led_classdev *leds;
+	bool leds_available;
 };
 
 void igc_up(struct igc_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e79b14d50b24..728d7ca5338b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7335,8 +7335,14 @@ static int igc_probe(struct pci_dev *pdev,
 
 	if (IS_ENABLED(CONFIG_IGC_LEDS)) {
 		err = igc_led_setup(adapter);
-		if (err)
-			goto err_register;
+		if (err) {
+			netdev_warn_once(netdev,
+					 "LED init failed (%d); continuing without LED support\n",
+					 err);
+			adapter->leds_available = false;
+		} else {
+			adapter->leds_available = true;
+		}
 	}
 
 	return 0;
@@ -7392,7 +7398,7 @@ static void igc_remove(struct pci_dev *pdev)
 	cancel_work_sync(&adapter->watchdog_task);
 	hrtimer_cancel(&adapter->hrtimer);
 
-	if (IS_ENABLED(CONFIG_IGC_LEDS))
+	if (IS_ENABLED(CONFIG_IGC_LEDS) && adapter->leds_available)
 		igc_led_free(adapter);
 
 	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
-- 
2.47.1


