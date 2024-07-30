Return-Path: <netdev+bounces-114246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EE7941EDB
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 19:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49448B24890
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8E61A76B3;
	Tue, 30 Jul 2024 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/45S37j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E218455C
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360810; cv=none; b=iN2JMJHhnBAvkDbveQwDRtjH4fZwyIval8VU298we4kVSbfXHAIJuS2X+lSFMpuYvK/dm3kjN2gJ8fMeQvZQ6Xj5xeNhcJw4WpsLKuYjxJ1WO3fY/V5WAc9vhqaMDbhXfe8DqA2qA69Kzd7QD0zj5a388Hj8i+dmEaBI485sWFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360810; c=relaxed/simple;
	bh=SwfbSGpI7FNzN0Vo2IJ2/hDtvmzt/T8ttGUAXHS63l8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nbA8fqZx8d17FlBkgCADn3wxEJtkSeIMMb6pldAPyNKTcF24MoJvJ0wQbwZD91EgjI6ihRi+qnlR3sRDnLGdRs54XP0foW4GmDIfOuB0gC2uJr61SVLc7acgmqIg9NKZrs7u7yJemWPHCcOkKlaaX3qX+dbOYyEGvDaHnmsLbAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/45S37j; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722360808; x=1753896808;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SwfbSGpI7FNzN0Vo2IJ2/hDtvmzt/T8ttGUAXHS63l8=;
  b=W/45S37jdbsJbjBY9lUj5joCK4vN0Rj7585+WqLQXcYol4dHqjtabHFA
   cCYWL7oanYrjr2oINF7NQ/vrE6t/wK78vKr2N6RsYG6PaK5ecbolwbRxt
   HDhKwNjo1qw5A5Ci0g/JMQkou+P60WLLcESYvnVCK23ELuEfpKbouRPR4
   cpLB0JC1/a5cnZkTL2MQiBKlhKjV3qWY3T85nFo+97iFbh8Q9fei59fpz
   pkhcbQiBfIlPwWdMMIwGOt6IC2UWpsDihJtfp6eu/Bx//yhJFz0dvCHGK
   v1yHtERnEs3VfK4zdNdJ80/R27uhCcYgEMPYyy5TGdwylGN6u+Rb4mpVk
   Q==;
X-CSE-ConnectionGUID: 2JdlGFw8TFuJb3UgT/5VkQ==
X-CSE-MsgGUID: NJdXrfOhTiKQjXNQ+iFWYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20144816"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="20144816"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 10:33:27 -0700
X-CSE-ConnectionGUID: RZpSYGbWQzmhR4TrY6Brwg==
X-CSE-MsgGUID: f48OZafeS2atWpFsBo4tpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="85054732"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 30 Jul 2024 10:33:13 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net] igc: Fix double reset adapter triggered from a single taprio cmd
Date: Tue, 30 Jul 2024 10:33:02 -0700
Message-ID: <20240730173304.865479-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Following the implementation of "igc: Add TransmissionOverrun counter"
patch, when a taprio command is triggered by user, igc processes two
commands: TAPRIO_CMD_REPLACE followed by TAPRIO_CMD_STATS. However, both
commands unconditionally pass through igc_tsn_offload_apply() which
evaluates and triggers reset adapter. The double reset causes issues in
the calculation of adapter->qbv_count in igc.

TAPRIO_CMD_REPLACE command is expected to reset the adapter since it
activates qbv. It's unexpected for TAPRIO_CMD_STATS to do the same
because it doesn't configure any driver-specific TSN settings. So, the
evaluation in igc_tsn_offload_apply() isn't needed for TAPRIO_CMD_STATS.

To address this, commands parsing are relocated to
igc_tsn_enable_qbv_scheduling(). Commands that don't require an adapter
reset will exit after processing, thus avoiding igc_tsn_offload_apply().

Fixes: d3750076d464 ("igc: Add TransmissionOverrun counter")
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 33 ++++++++++++-----------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index cb5c7b09e8a0..8daf938afc36 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6306,21 +6306,6 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	size_t n;
 	int i;
 
-	switch (qopt->cmd) {
-	case TAPRIO_CMD_REPLACE:
-		break;
-	case TAPRIO_CMD_DESTROY:
-		return igc_tsn_clear_schedule(adapter);
-	case TAPRIO_CMD_STATS:
-		igc_taprio_stats(adapter->netdev, &qopt->stats);
-		return 0;
-	case TAPRIO_CMD_QUEUE_STATS:
-		igc_taprio_queue_stats(adapter->netdev, &qopt->queue_stats);
-		return 0;
-	default:
-		return -EOPNOTSUPP;
-	}
-
 	if (qopt->base_time < 0)
 		return -ERANGE;
 
@@ -6429,7 +6414,23 @@ static int igc_tsn_enable_qbv_scheduling(struct igc_adapter *adapter,
 	if (hw->mac.type != igc_i225)
 		return -EOPNOTSUPP;
 
-	err = igc_save_qbv_schedule(adapter, qopt);
+	switch (qopt->cmd) {
+	case TAPRIO_CMD_REPLACE:
+		err = igc_save_qbv_schedule(adapter, qopt);
+		break;
+	case TAPRIO_CMD_DESTROY:
+		err = igc_tsn_clear_schedule(adapter);
+		break;
+	case TAPRIO_CMD_STATS:
+		igc_taprio_stats(adapter->netdev, &qopt->stats);
+		return 0;
+	case TAPRIO_CMD_QUEUE_STATS:
+		igc_taprio_queue_stats(adapter->netdev, &qopt->queue_stats);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+
 	if (err)
 		return err;
 
-- 
2.42.0


