Return-Path: <netdev+bounces-46394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1DA7E3B07
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 12:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0732C1C20BF7
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 11:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AAF2D791;
	Tue,  7 Nov 2023 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="auywIVi2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893AE12E4F
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 11:22:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BB4ED;
	Tue,  7 Nov 2023 03:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699356134; x=1730892134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tTJNmm6maYeBIBNzxeaSXpjj2cPTvW1Qy7oFWpBrI8M=;
  b=auywIVi2HFm3cqYdNE/C9pvqVjocLzhsBptAiZwCVqYNEjbfgYNCPsG5
   md85ps8gCX8Fu5v8/XsN+XcBmcfk+2GCTvryrAoxxMPncvbvW9zTZXgqK
   INMA5KaKw1aXUspSrFn7e380L4b8DEaTuwVYHKHWveSz/djjiXjb19xxD
   xECseTfey3kfA0RNLVibWVNRylW+rPFJMMKUQVwsqowK6YRZoSZ1hCxf6
   ssVsx62t4NnsWtcmg3Pdsg0VRjWIUsyvg4sHnZ5kcXMZyllVtWFE4fsSR
   hfLm9QsuwlPfbYAgTzVyd5VcaXSiRIvFBP6v/P+kNyJW7VlNNuIht/8vb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="393382991"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="393382991"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:22:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="766285654"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="766285654"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:22:12 -0800
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
	by linux.intel.com (Postfix) with ESMTP id C8862580D61;
	Tue,  7 Nov 2023 03:22:09 -0800 (PST)
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 6/7] net/sched: taprio: fix q->current_entry is NULL before its expiry
Date: Tue,  7 Nov 2023 06:20:22 -0500
Message-Id: <20231107112023.676016-7-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the issue of prematurely setting q->current_entry to NULL in the
setup_first_end_time() function when a new admin schedule arrives
while the oper schedule is still running but hasn't transitioned yet.
This premature setting causes problems because any reference to
q->current_entry, such as in taprio_dequeue(), will result in NULL
during this period, which is incorrect. q->current_entry should remain
valid until the currently running entry expires.

To address this issue, only set q->current_entry to NULL when there is
no oper schedule currently running.

Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 net/sched/sch_taprio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 01b114edec30..c60e9e7ac193 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1375,7 +1375,8 @@ static void setup_first_end_time(struct taprio_sched *q,
 			first->gate_close_time[tc] = ktime_add_ns(base, first->gate_duration[tc]);
 	}
 
-	rcu_assign_pointer(q->current_entry, NULL);
+	if (!hrtimer_active(&q->advance_timer))
+		rcu_assign_pointer(q->current_entry, NULL);
 }
 
 static void taprio_start_sched(struct Qdisc *sch,
-- 
2.25.1


