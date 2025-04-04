Return-Path: <netdev+bounces-179273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036FCA7BADA
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 12:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFBC189FF7B
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BDE1EE7A7;
	Fri,  4 Apr 2025 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/VrM/Cz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860671EB5D4
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762587; cv=none; b=YLDSY4oDXi/7K7Z982E+6/nl3+fV9rmC7ARpzFvs+PfQ0vDHKZ1Iy2ib8TRvAG4uHhFVmBAv/DL5qaCaYej3vnB6qmx8TVaERrlBCQSzhuYZuaaA/zkSAMOAf7SfsIWulawiMtF23I2I0SYzm84EH8Qjwms9UUbbMDurS8B4STQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762587; c=relaxed/simple;
	bh=VkEEqZoT+jeMa9GotZTRzDkqWqwz9IyyHoKvT76o4CE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ltbdY6cTOnvQ/rTJHBtIYdt2qqZEx80iNUuKjxK7rtK7+rHvdjqtw65qzLyWdN0SWEyEqNiiK2XCgPRxwO95RIzS1JhPHQNoP/E4mHOT11RxUANHD32Pndk0CwMRxLK5YCoFmh0/FyrwhXk+eEYQZ9Ldbf1bLeaKuhyzN5Qm4zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/VrM/Cz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743762585; x=1775298585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VkEEqZoT+jeMa9GotZTRzDkqWqwz9IyyHoKvT76o4CE=;
  b=c/VrM/CzbA2qzZI+id+cqDzl60JeBm18UokkGpFKx0BBNU5Dwfr3kh4g
   szy2tckwCA7EhOLL4yL3f/Q52GNZatqcz5A8Wf8p1HUAnCf/5XlQYwgVs
   hsMHg+mr/wPnu9fjwDIwK86IJxcUdd/1VrBrDBEnZ5r2Zh0v+ASZktKEJ
   2NGzahKIO3mJsUaiJ3YdFjhLmRPowlRVQombbsrxYgsB2zqsjrJ33iw20
   LPWjrslF2G57iNivTmpp2FVGmWtlvx2PDSX9DajUVVCv++EjDnGU+BiPl
   ptaWzZBha9twmrM4cyqFjPp57LcSZeMUmvsbVWCBrkkJOBEnWUlUeWSdK
   g==;
X-CSE-ConnectionGUID: nXOqBt45RauoVIj4nKNG9Q==
X-CSE-MsgGUID: eCtbsS9vToaM/ySv93OeCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="48992437"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="48992437"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 03:29:44 -0700
X-CSE-ConnectionGUID: l3xjuoMqR52Tsf9q/CJhDw==
X-CSE-MsgGUID: 77+ilO6ySjWh290+btyAUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="164485296"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 04 Apr 2025 03:29:42 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 563E633EA6;
	Fri,  4 Apr 2025 11:29:41 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-net 3/6] iavf: simplify watchdog_task in terms of adminq task scheduling
Date: Fri,  4 Apr 2025 12:23:18 +0200
Message-Id: <20250404102321.25846-4-przemyslaw.kitszel@intel.com>
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

Simplify the decision whether to schedule adminq task. The condition is
the same, but it is executed in more scenarios.

Note that movement of watchdog_done label makes this commit a bit
surprising. (Hence not squashing it to anything bigger).

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
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
 
@@ -3053,26 +3054,20 @@ static void iavf_watchdog_task(struct work_struct *work)
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
2.39.3


