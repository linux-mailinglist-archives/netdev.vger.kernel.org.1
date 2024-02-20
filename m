Return-Path: <netdev+bounces-73445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8120A85CA2B
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 22:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43898282BAD
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 21:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C850A152E09;
	Tue, 20 Feb 2024 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJSWdt/N"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBFC152DEB
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465498; cv=none; b=lPR2eFaD7LO6GArf/oGLndgScEKccwL2AjaMeCLeW4i2mfyawCfT2PYPVjv397Xu0DTQYKr5wJr4zww19w6Qhio9DJIrPjMR956jM/+sA7uBFQiLiaT+WMFtytecu1+3V9JyzqIWSPsEgdt5mZINvQBRAHKyi7sn7KEVh4OHkTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465498; c=relaxed/simple;
	bh=PT2kuh5Ru1NBVEFaVphnDRt5XPf4PR0gKzTCDxqUE20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i60AkhLHXm0UuWVn/aD0kt3ZQRRWpJjPvDFZCvDlqMUxtzbbCp3rKcdWGu55pm7bIYRIn4Qct3jIgN0jtQceMinbNYivnPHzFF7GNTcxhnXrvebNcAolXiUAbu3XnxiuwZ4Eows8MgXDHjzZClnsJJW3o+xwlf/3EZRigjqgs2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJSWdt/N; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708465498; x=1740001498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PT2kuh5Ru1NBVEFaVphnDRt5XPf4PR0gKzTCDxqUE20=;
  b=aJSWdt/NYstVbDK3/IEAjKfHeob9ynQ4FK1Tjal0WztiqWxTPZEBxFsR
   gMJOnI/74zAnwXIpmF1s7kc1agN3tWjSNpV34NdoWFGNmX9d0CsP8t1pS
   UNJD3uXLwNiFdeEfbmvDnv6trd+P6QNWu/vf6MqFdEYVue8WGFufHC9Ez
   3SPGhDVbFltDshqwGViKMyK6ONXlMesKWgu+TThp3S16M3M2nlLJDpJfQ
   pDtBQN8LkGcoIXUtB1PPdHZJFRWJ9BhS4IH8SGD5VFsy+wurQZcWqAhc8
   DcvviWevahOijHEt3TY93S9i07tZHG3uspQ6HBOQMIa9XUG8OMVlRNC19
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2472732"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2472732"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 13:44:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9614943"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 20 Feb 2024 13:44:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	anthony.l.nguyen@intel.com,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	Igor Bagnucki <igor.bagnucki@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 4/6] ice: fix dpll periodic work data updates on PF reset
Date: Tue, 20 Feb 2024 13:44:40 -0800
Message-ID: <20240220214444.1039759-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240220214444.1039759-1-anthony.l.nguyen@intel.com>
References: <20240220214444.1039759-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Do not allow dpll periodic work function to acquire data from firmware
if PF reset is in progress. Acquiring data will cause dmesg errors as the
firmware cannot respond or process the request properly during the reset
time.

Test by looping execution of below step until dmesg error appears:
- perform PF reset
$ echo 1 > /sys/class/net/<ice PF>/device/reset

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 343b2a668959..395e10c246f7 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1364,8 +1364,10 @@ static void ice_dpll_periodic_work(struct kthread_work *work)
 	struct ice_pf *pf = container_of(d, struct ice_pf, dplls);
 	struct ice_dpll *de = &pf->dplls.eec;
 	struct ice_dpll *dp = &pf->dplls.pps;
-	int ret;
+	int ret = 0;
 
+	if (ice_is_reset_in_progress(pf->state))
+		goto resched;
 	mutex_lock(&pf->dplls.lock);
 	ret = ice_dpll_update_state(pf, de, false);
 	if (!ret)
@@ -1385,6 +1387,7 @@ static void ice_dpll_periodic_work(struct kthread_work *work)
 	ice_dpll_notify_changes(de);
 	ice_dpll_notify_changes(dp);
 
+resched:
 	/* Run twice a second or reschedule if update failed */
 	kthread_queue_delayed_work(d->kworker, &d->work,
 				   ret ? msecs_to_jiffies(10) :
-- 
2.41.0


