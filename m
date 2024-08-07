Return-Path: <netdev+bounces-116627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F82594B36E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 01:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35A41C20C78
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F38155A59;
	Wed,  7 Aug 2024 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oD6psJ8D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A581553BC
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 23:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072418; cv=none; b=PgFtUXbI75aAZx5FV0BHMXrPTtQb3evC/3LdgPoHgz2rFebLE98DCbee6+w0VMrv4pk/dutjqwmj38p3znnGlscaPOol3g+OeBi7sknccevLQAtshVyFyTVVaafvLzTptvWLSGtYH2YYajylfIIPAHxk5RSVCWaBnB2c3zyNVCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072418; c=relaxed/simple;
	bh=gYW1Mz/N9tELiFPT0gvgddfr/2nTZcI9aC+jVh1t2Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PviUCe5S4rE33SKd2OgDg39Udplckh0fEmZVZAVxK6TS7sk5a3X+Y9LSLXNlGIY0dX0eyWkCY5bl7XbozuvWhQhialnMel2sMff0vuEno7DuoHKyEdUsRJTdFCbrwBTRq5fucKofW9Q9Z2twuaXb8bvivjjTPuQ9Id+0Jehpn38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oD6psJ8D; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723072416; x=1754608416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gYW1Mz/N9tELiFPT0gvgddfr/2nTZcI9aC+jVh1t2Mk=;
  b=oD6psJ8DX1s5yM4H8+OR9fFbYT1GubVZaLDfFHltMhkCWIlIe9lJBrSu
   jfXyJaqEYKmfjl9S43qKzeNhsRSwdhCzzL31QuwTPk7zi9zBIOBT69co9
   4RnxTH8bVigVBsd8fwyyHh79Zb9N0RGY6t7QG+UAfR88V1DWY3l+AxTjc
   f3fdG7KNB1l2sxBfrxgxwBnrl2aFri/+xCjD6NzZwn/NvyUWyPG/GuwYD
   IrbaTEf6fCYK6rApIaleCPoa9+iqBKOP9HWncV13PnePK7rdHhASD7VGV
   CB1xqkKf0QAt97etjaMcCFKrSmdL356LWcoBJgJCnPSxHwj6VCdvZC0sc
   w==;
X-CSE-ConnectionGUID: Bc7B/8OZTxeV3I46+cOj0Q==
X-CSE-MsgGUID: YMNs4VhyRFKp2/h/qS39AA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32577308"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="32577308"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:13:34 -0700
X-CSE-ConnectionGUID: 3bCYnsRVSiWur9MlCXyXvw==
X-CSE-MsgGUID: 52YMflCxRUW7mmEgrNHAug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="61956622"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 07 Aug 2024 16:13:34 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	vinicius.gomes@intel.com,
	sasha.neftin@intel.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	rodrigo.cadore@l-acoustics.com,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net 2/4] igc: Fix qbv_config_change_errors logics
Date: Wed,  7 Aug 2024 16:13:26 -0700
Message-ID: <20240807231329.3827092-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240807231329.3827092-1-anthony.l.nguyen@intel.com>
References: <20240807231329.3827092-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

When user issues these cmds:
1. Either a) or b)
   a) mqprio with hardware offload disabled
   b) taprio with txtime-assist feature enabled
2. etf
3. tc qdisc delete
4. taprio with base time in the past

At step 4, qbv_config_change_errors wrongly increased by 1.

Excerpt from IEEE 802.1Q-2018 8.6.9.3.1:
"If AdminBaseTime specifies a time in the past, and the current schedule
is running, then: Increment ConfigChangeError counter"

qbv_config_change_errors should only increase if base time is in the past
and no taprio is active. In user perspective, taprio was not active when
first triggered at step 4. However, i225/6 reuses qbv for etf, so qbv is
enabled with a dummy schedule at step 2 where it enters
igc_tsn_enable_offload() and qbv_count got incremented to 1. At step 4, it
enters igc_tsn_enable_offload() again, qbv_count is incremented to 2.
Because taprio is running, tc_setup_type is TC_SETUP_QDISC_ETF and
qbv_count > 1, qbv_config_change_errors value got incremented.

This issue happens due to reliance on qbv_count field where a non-zero
value indicates that taprio is running. But qbv_count increases
regardless if taprio is triggered by user or by other tsn feature. It does
not align with qbv_config_change_errors expectation where it is only
concerned with taprio triggered by user.

Fixing this by relocating the qbv_config_change_errors logic to
igc_save_qbv_schedule(), eliminating reliance on qbv_count and its
inaccuracies from i225/6's multiple uses of qbv feature for other TSN
features.

The new function created: igc_tsn_is_taprio_activated_by_user() uses
taprio_offload_enable field to indicate that the current running taprio
was triggered by user, instead of triggered by non-qbv feature like etf.

Fixes: ae4fe4698300 ("igc: Add qbv_config_change_errors counter")
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c |  8 ++++++--
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 16 ++++++++--------
 drivers/net/ethernet/intel/igc/igc_tsn.h  |  1 +
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 8daf938afc36..dfd6c00b4205 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6315,12 +6315,16 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	if (!validate_schedule(adapter, qopt))
 		return -EINVAL;
 
+	igc_ptp_read(adapter, &now);
+
+	if (igc_tsn_is_taprio_activated_by_user(adapter) &&
+	    is_base_time_past(qopt->base_time, &now))
+		adapter->qbv_config_change_errors++;
+
 	adapter->cycle_time = qopt->cycle_time;
 	adapter->base_time = qopt->base_time;
 	adapter->taprio_offload_enable = true;
 
-	igc_ptp_read(adapter, &now);
-
 	for (n = 0; n < qopt->num_entries; n++) {
 		struct tc_taprio_sched_entry *e = &qopt->entries[n];
 
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 46d4c3275bbb..8ed7b965484d 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -87,6 +87,14 @@ static void igc_tsn_restore_retx_default(struct igc_adapter *adapter)
 	wr32(IGC_RETX_CTL, retxctl);
 }
 
+bool igc_tsn_is_taprio_activated_by_user(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+
+	return (rd32(IGC_BASET_H) || rd32(IGC_BASET_L)) &&
+		adapter->taprio_offload_enable;
+}
+
 /* Returns the TSN specific registers to their default values after
  * the adapter is reset.
  */
@@ -296,14 +304,6 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 		s64 n = div64_s64(ktime_sub_ns(systim, base_time), cycle);
 
 		base_time = ktime_add_ns(base_time, (n + 1) * cycle);
-
-		/* Increase the counter if scheduling into the past while
-		 * Gate Control List (GCL) is running.
-		 */
-		if ((rd32(IGC_BASET_H) || rd32(IGC_BASET_L)) &&
-		    (adapter->tc_setup_type == TC_SETUP_QDISC_TAPRIO) &&
-		    (adapter->qbv_count > 1))
-			adapter->qbv_config_change_errors++;
 	} else {
 		if (igc_is_device_id_i226(hw)) {
 			ktime_t adjust_time, expires_time;
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ethernet/intel/igc/igc_tsn.h
index b53e6af560b7..98ec845a86bf 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.h
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
@@ -7,5 +7,6 @@
 int igc_tsn_offload_apply(struct igc_adapter *adapter);
 int igc_tsn_reset(struct igc_adapter *adapter);
 void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter);
+bool igc_tsn_is_taprio_activated_by_user(struct igc_adapter *adapter);
 
 #endif /* _IGC_BASE_H */
-- 
2.42.0


