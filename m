Return-Path: <netdev+bounces-42116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E169D7CD2AC
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 05:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83A06B20FCB
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 03:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66F05246;
	Wed, 18 Oct 2023 03:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0+9ydww"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38FF3D90
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 03:29:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC66FA;
	Tue, 17 Oct 2023 20:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697599780; x=1729135780;
  h=from:to:cc:subject:date:message-id;
  bh=phDj3684tOP+B+d0MXIvzoUnOpESFYXdBSU3w4+mZTY=;
  b=G0+9ydww8G/DnoWz214Myyx537j0v5vB3I78BHAE09KFFd6Ki1QIrT/N
   1zBfRqLv3H8VhqkPaIjDf5EcR+ykpjbI4pxGh1F6gK/DQYEMlkMM1RjOs
   oTNQbRCVIje32mdE/qbEgwhSuxsVvhAzBF3Iy5CHJVekEynBvhiolw0iH
   WiVI/j+u4AtJf+GajLrMrUHSyv1xAk6lzGqkGGv21x42giGdYlHcs3tL9
   qzjs+CQ6DpRYYVM+h04WBhouxlJPxIDb8BZ/EF6B9RVmkGLHJochucOE9
   Ky9MH8LuUCHaRx/zkhNa/jaEfRdEsaK7I/GbLfoyi1cVFwHcLEkDlOZDk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="370990644"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="370990644"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 20:29:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="847066898"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="847066898"
Received: from ssid-ilbpg3.png.intel.com ([10.88.227.111])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Oct 2023 20:29:37 -0700
From: Lai Peter Jun Ann <jun.ann.lai@intel.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: [PATCH net-next v2 1/1] taprio: Add boundary check for sched-entry values
Date: Wed, 18 Oct 2023 11:28:27 +0800
Message-Id: <1697599707-3546-1-git-send-email-jun.ann.lai@intel.com>
X-Mailer: git-send-email 1.9.1
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Adds boundary checks for the gatemask provided against the number of
traffic class defined for each sched-entry.

Without this check, the user would not know that the gatemask provided is
invalid and the driver has already truncated the gatemask provided to
match the number of traffic class defined.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
---
 net/sched/sch_taprio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 1cb5e41..44b9e21 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -102,6 +102,7 @@ struct taprio_sched {
 	u32 max_sdu[TC_MAX_QUEUE]; /* save info from the user */
 	u32 fp[TC_QOPT_MAX_QUEUE]; /* only for dump and offloading */
 	u32 txtime_delay;
+	u8 num_tc;
 };
 
 struct __tc_taprio_qopt_offload {
@@ -1063,6 +1064,11 @@ static int fill_sched_entry(struct taprio_sched *q, struct nlattr **tb,
 		return -EINVAL;
 	}
 
+	if (entry->gate_mask >= q->num_tc) {
+		NL_SET_ERR_MSG(extack, "Traffic Class defined less than gatemask");
+		return -EINVAL;
+	}
+
 	entry->interval = interval;
 
 	return 0;
@@ -1913,6 +1919,8 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 		for (i = 0; i <= TC_BITMASK; i++)
 			netdev_set_prio_tc_map(dev, i,
 					       mqprio->prio_tc_map[i]);
+
+		q->num_tc = mqprio->num_tc;
 	}
 
 	err = parse_taprio_schedule(q, tb, new_admin, extack);
-- 
1.9.1


