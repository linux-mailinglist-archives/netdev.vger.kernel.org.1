Return-Path: <netdev+bounces-269787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFX3DfPVvGkk3gIAu9opvQ
	(envelope-from <netdev+bounces-269787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:06:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C732D5E72
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99F40306A50D
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 05:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED0A2F3C37;
	Fri, 20 Mar 2026 05:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cnQem81J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65026201004
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 05:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773983149; cv=none; b=gmrra1POIVnoll5U2AS9eZjIVjRAmphfecSnsFZuKqKIBF3P/WTq0O8v9XicbKOjLbk37aXmeZPF4agPZ0htFc+7QJRnkT45yZqwTYHvJwcwK4gbwtcwfYIxhrXGpvJFEulUO8g/UzPaFc/vAvTAWQIb9kBgjA5ZhFNug4AyY6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773983149; c=relaxed/simple;
	bh=QtubdldAllXyG0emmWV/zJMO0HuQ0Y0WQHq1vT6skuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xxkc0UbFLSexC/8b9vj2R3RN146Vhd7ygKcXbOiit+HxBkxLc+Vu+CTTHeE14siwj/kC8xGT4gZkNiYNHlQY/oTdEfwoYdqnlXfKglE8xU6cUg7jqhMZAEfs878q/w/bWaatZiiexICZtDS/dOOKw7pkO7GwPksJKBjxtYS/QIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cnQem81J; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773983148; x=1805519148;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QtubdldAllXyG0emmWV/zJMO0HuQ0Y0WQHq1vT6skuQ=;
  b=cnQem81JCxtXC6rGVuxLk5/+8Nncl82X9yaovggTnNKCFYtPGlz0n+tP
   ossTqhXXS24QZBpRf3mQ3qEu+LMyj1x60/Kei7grQ05CC25jMWBtuKrer
   WHsgbeCuAzQoWmqnchkJ2QnW2SAh11bFeGUyKlu5U0HkeA4hbp/hTAJgJ
   42SDX4X9I6xtOLEbLc3QUTrCGCUiXEP/kd0n4pM7Rh9PS64IX9YuVt0RY
   6lfHMACm0uXHEnicktMb5UMkN2tVTz3H2dbZEVrfc7bphQcRIkbW/xQjO
   7k1Wypb7U8YQDrlboF3BxwT7s7Ymj7MKM136j1ic/gfzTVTiqoNGVNhb2
   g==;
X-CSE-ConnectionGUID: cVGpj+HSR5qTB/Pdadn6Sg==
X-CSE-MsgGUID: OC+he0y6Q1WhkevTWFu0Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75251812"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75251812"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 22:05:47 -0700
X-CSE-ConnectionGUID: GhOkh8fsRsy7umJCDo+W2A==
X-CSE-MsgGUID: YqqaZk+oSm2reQOSuI4i/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222399163"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa010.jf.intel.com with ESMTP; 19 Mar 2026 22:05:46 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: [PATCH iwl-next] ice: prevent integer overflow
Date: Fri, 20 Mar 2026 06:05:44 +0100
Message-ID: <20260320050544.422640-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269787-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9C732D5E72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

In ice_sched_bw_to_rl_profile(), the loop over 64 bits computes the
scheduler timestamp rate as:

  ts_rate = div64_long((s64)hw->psm_clk_freq,
                       pow_result * ICE_RL_PROF_TS_MULTIPLIER);

where pow_result = BIT_ULL(i). For large values of i, the product
pow_result * ICE_RL_PROF_TS_MULTIPLIER overflows u64 before being used
as the divisor, producing incorrect ts_rate values and potentially
undefined behaviour.

Fix this by pre-computing ts_freq = hw->psm_clk_freq /
ICE_RL_PROF_TS_MULTIPLIER once before the loop and then dividing only
by pow_result inside the loop. The division order avoids the overflow
while preserving the same mathematical result. Declare ts_freq as s64
to match the type domain of the surrounding arithmetic and avoid a
redundant cast at the use site.

While at it, scope the loop variable i to the for statement itself.

Fixes: 1ddef455f4a8 ("ice: Add NDO callback to set the maximum per-queue bitrate")
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index fff0c1a..edea262c 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -3237,12 +3237,12 @@ static int
 ice_sched_bw_to_rl_profile(struct ice_hw *hw, u32 bw,
 			   struct ice_aqc_rl_profile_elem *profile)
 {
+	s64 ts_freq = hw->psm_clk_freq / ICE_RL_PROF_TS_MULTIPLIER;
 	s64 bytes_per_sec, ts_rate, mv_tmp;
 	int status = -EINVAL;
 	bool found = false;
 	s32 encode = 0;
 	s64 mv = 0;
-	s32 i;
 
 	/* Bw settings range is from 0.5Mb/sec to 100Gb/sec */
 	if (bw < ICE_SCHED_MIN_BW || bw > ICE_SCHED_MAX_BW)
@@ -3255,8 +3255,7 @@ ice_sched_bw_to_rl_profile(struct ice_hw *hw, u32 bw,
-	for (i = 0; i < 64; i++) {
+	for (int i = 0; i < 64; i++) {
 		u64 pow_result = BIT_ULL(i);
 
-		ts_rate = div64_long((s64)hw->psm_clk_freq,
-				     pow_result * ICE_RL_PROF_TS_MULTIPLIER);
+		ts_rate = div64_long(ts_freq, pow_result);
 		if (ts_rate <= 0)
 			continue;
 
-- 
2.52.0


