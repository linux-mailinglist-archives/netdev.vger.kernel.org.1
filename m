Return-Path: <netdev+bounces-39508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE8E7BF90D
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB556281CA2
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735B4FC15;
	Tue, 10 Oct 2023 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLpTEXhE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339FD16400
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:53:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFAAB9
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 03:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696935181; x=1728471181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IfGI9at/elbBapu0bIvPmGhM1sGMwdZs35D3l9S4wrk=;
  b=gLpTEXhEhlvO+L8m4DGQLGeM+fwO5czhZkFkoMqydQA1zrf2AUNJoEZK
   32cECXot3k/gIcY9nXG9XupdkzCmafC+pncQ791G6L9bl56o2v0Eh8A8H
   ohiBPG2AeYbr2eAWqALtTe2qvHuAE6IXhJwZzncurKJTLMnEstCuoNmBD
   U4kSf+xkRBT6/BIwEme176T9swWI4lBuV9V3OOOYCFotINJlohzv9BLoZ
   2q1eGrWPWe8M6X5CWL8G6VX1KhCe2Py7ghozizG8XGQSL0d3aP0yM0mdG
   z+hil/qY7apCoWhFGQztxaCxB65F4x5HeQ7aoFxRje0BwZmuMqHbgFA4J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="381624214"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="381624214"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:51:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="877182916"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="877182916"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 10 Oct 2023 03:51:02 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 66F8A386C3;
	Tue, 10 Oct 2023 11:50:59 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Edwin Peer <edwin.peer@broadcom.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Luo bin <luobin9@huawei.com>,
	George Cherian <george.cherian@marvell.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Cc: Brett Creeley <brett.creeley@amd.com>,
	Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Eran Ben Elisha <eranbe@nvidia.com>,
	Aya Levin <ayal@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH net-next v1 5/8] hinic: devlink health: use retained error fmsg API
Date: Tue, 10 Oct 2023 12:43:15 +0200
Message-Id: <20231010104318.3571791-6-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231010104318.3571791-1-przemyslaw.kitszel@intel.com>
References: <20231010104318.3571791-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Drop unneeded error checking.

devlink_fmsg_*() family of functions is now retaining errors,
so there is no need to check for them after each call.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-237 (-237)
---
 .../net/ethernet/huawei/hinic/hinic_devlink.c | 181 ++++--------------
 1 file changed, 41 insertions(+), 140 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
index 1749d26f4bef..2bd5a356c44b 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
@@ -321,40 +321,20 @@ static int chip_fault_show(struct devlink_fmsg *fmsg,
 	const char * const level_str[FAULT_LEVEL_MAX + 1] = {
 		"fatal", "reset", "flr", "general", "suggestion", "Unknown"};
 	u8 fault_level;
-	int err;
 
 	fault_level = (event->event.chip.err_level < FAULT_LEVEL_MAX) ?
 		event->event.chip.err_level : FAULT_LEVEL_MAX;
 	if (fault_level == FAULT_LEVEL_SERIOUS_FLR) {
-		err = devlink_fmsg_u32_pair_put(fmsg, "Function level err func_id",
-						(u32)event->event.chip.func_id);
-		if (err)
-			return err;
+		devlink_fmsg_u32_pair_put(fmsg, "Function level err func_id",
+					  (u32)event->event.chip.func_id);
 	}
-
-	err = devlink_fmsg_u8_pair_put(fmsg, "module_id", event->event.chip.node_id);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "err_type", (u32)event->event.chip.err_type);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_string_pair_put(fmsg, "err_level", level_str[fault_level]);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "err_csr_addr",
-					event->event.chip.err_csr_addr);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "err_csr_value",
-					event->event.chip.err_csr_value);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_u8_pair_put(fmsg, "module_id", event->event.chip.node_id);
+	devlink_fmsg_u32_pair_put(fmsg, "err_type", (u32)event->event.chip.err_type);
+	devlink_fmsg_string_pair_put(fmsg, "err_level", level_str[fault_level]);
+	devlink_fmsg_u32_pair_put(fmsg, "err_csr_addr",
+				  event->event.chip.err_csr_addr);
+	return devlink_fmsg_u32_pair_put(fmsg, "err_csr_value",
+					 event->event.chip.err_csr_value);
 }
 
 static int fault_report_show(struct devlink_fmsg *fmsg,
@@ -368,83 +348,49 @@ static int fault_report_show(struct devlink_fmsg *fmsg,
 
 	fault_type = (event->type < FAULT_TYPE_MAX) ? event->type : FAULT_TYPE_MAX;
 
-	err = devlink_fmsg_string_pair_put(fmsg, "Fault type", type_str[fault_type]);
-	if (err)
-		return err;
-
+	devlink_fmsg_string_pair_put(fmsg, "Fault type", type_str[fault_type]);
 	err = devlink_fmsg_binary_pair_put(fmsg, "Fault raw data",
 					   event->event.val, sizeof(event->event.val));
 	if (err)
 		return err;
 
 	switch (event->type) {
 	case FAULT_TYPE_CHIP:
 		err = chip_fault_show(fmsg, event);
-		if (err)
-			return err;
 		break;
 	case FAULT_TYPE_UCODE:
-		err = devlink_fmsg_u8_pair_put(fmsg, "Cause_id", event->event.ucode.cause_id);
-		if (err)
-			return err;
-		err = devlink_fmsg_u8_pair_put(fmsg, "core_id", event->event.ucode.core_id);
-		if (err)
-			return err;
-		err = devlink_fmsg_u8_pair_put(fmsg, "c_id", event->event.ucode.c_id);
-		if (err)
-			return err;
+		devlink_fmsg_u8_pair_put(fmsg, "Cause_id", event->event.ucode.cause_id);
+		devlink_fmsg_u8_pair_put(fmsg, "core_id", event->event.ucode.core_id);
+		devlink_fmsg_u8_pair_put(fmsg, "c_id", event->event.ucode.c_id);
 		err = devlink_fmsg_u8_pair_put(fmsg, "epc", event->event.ucode.epc);
-		if (err)
-			return err;
 		break;
 	case FAULT_TYPE_MEM_RD_TIMEOUT:
 	case FAULT_TYPE_MEM_WR_TIMEOUT:
-		err = devlink_fmsg_u32_pair_put(fmsg, "Err_csr_ctrl",
-						event->event.mem_timeout.err_csr_ctrl);
-		if (err)
-			return err;
-		err = devlink_fmsg_u32_pair_put(fmsg, "err_csr_data",
-						event->event.mem_timeout.err_csr_data);
-		if (err)
-			return err;
-		err = devlink_fmsg_u32_pair_put(fmsg, "ctrl_tab",
-						event->event.mem_timeout.ctrl_tab);
-		if (err)
-			return err;
+		devlink_fmsg_u32_pair_put(fmsg, "Err_csr_ctrl",
+					  event->event.mem_timeout.err_csr_ctrl);
+		devlink_fmsg_u32_pair_put(fmsg, "err_csr_data",
+					  event->event.mem_timeout.err_csr_data);
+		devlink_fmsg_u32_pair_put(fmsg, "ctrl_tab",
+					  event->event.mem_timeout.ctrl_tab);
 		err = devlink_fmsg_u32_pair_put(fmsg, "mem_index",
 						event->event.mem_timeout.mem_index);
-		if (err)
-			return err;
 		break;
 	case FAULT_TYPE_REG_RD_TIMEOUT:
 	case FAULT_TYPE_REG_WR_TIMEOUT:
 		err = devlink_fmsg_u32_pair_put(fmsg, "Err_csr", event->event.reg_timeout.err_csr);
-		if (err)
-			return err;
 		break;
 	case FAULT_TYPE_PHY_FAULT:
-		err = devlink_fmsg_u8_pair_put(fmsg, "Op_type", event->event.phy_fault.op_type);
-		if (err)
-			return err;
-		err = devlink_fmsg_u8_pair_put(fmsg, "port_id", event->event.phy_fault.port_id);
-		if (err)
-			return err;
-		err = devlink_fmsg_u8_pair_put(fmsg, "dev_ad", event->event.phy_fault.dev_ad);
-		if (err)
-			return err;
-
-		err = devlink_fmsg_u32_pair_put(fmsg, "csr_addr", event->event.phy_fault.csr_addr);
-		if (err)
-			return err;
+		devlink_fmsg_u8_pair_put(fmsg, "Op_type", event->event.phy_fault.op_type);
+		devlink_fmsg_u8_pair_put(fmsg, "port_id", event->event.phy_fault.port_id);
+		devlink_fmsg_u8_pair_put(fmsg, "dev_ad", event->event.phy_fault.dev_ad);
+		devlink_fmsg_u32_pair_put(fmsg, "csr_addr", event->event.phy_fault.csr_addr);
 		err = devlink_fmsg_u32_pair_put(fmsg, "op_data", event->event.phy_fault.op_data);
-		if (err)
-			return err;
 		break;
 	default:
 		break;
 	}
 
-	return 0;
+	return err;
 }
 
 static int hinic_hw_reporter_dump(struct devlink_health_reporter *reporter,
@@ -458,69 +404,24 @@ static int hinic_hw_reporter_dump(struct devlink_health_reporter *reporter,
 }
 
 static int mgmt_watchdog_report_show(struct devlink_fmsg *fmsg,
-				     struct hinic_mgmt_watchdog_info *watchdog_info)
+				     struct hinic_mgmt_watchdog_info *winfo)
 {
-	int err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "Mgmt deadloop time_h", watchdog_info->curr_time_h);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "time_l", watchdog_info->curr_time_l);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "task_id", watchdog_info->task_id);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "sp", watchdog_info->sp);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "stack_current_used", watchdog_info->curr_used);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "peak_used", watchdog_info->peak_used);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "\n Overflow_flag", watchdog_info->is_overflow);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "stack_top", watchdog_info->stack_top);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "stack_bottom", watchdog_info->stack_bottom);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "mgmt_pc", watchdog_info->pc);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "lr", watchdog_info->lr);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "cpsr", watchdog_info->cpsr);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_binary_pair_put(fmsg, "Mgmt register info",
-					   watchdog_info->reg, sizeof(watchdog_info->reg));
-	if (err)
-		return err;
-
-	err = devlink_fmsg_binary_pair_put(fmsg, "Mgmt dump stack(start from sp)",
-					   watchdog_info->data, sizeof(watchdog_info->data));
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_u32_pair_put(fmsg, "Mgmt deadloop time_h", winfo->curr_time_h);
+	devlink_fmsg_u32_pair_put(fmsg, "time_l", winfo->curr_time_l);
+	devlink_fmsg_u32_pair_put(fmsg, "task_id", winfo->task_id);
+	devlink_fmsg_u32_pair_put(fmsg, "sp", winfo->sp);
+	devlink_fmsg_u32_pair_put(fmsg, "stack_current_used", winfo->curr_used);
+	devlink_fmsg_u32_pair_put(fmsg, "peak_used", winfo->peak_used);
+	devlink_fmsg_u32_pair_put(fmsg, "\n Overflow_flag", winfo->is_overflow);
+	devlink_fmsg_u32_pair_put(fmsg, "stack_top", winfo->stack_top);
+	devlink_fmsg_u32_pair_put(fmsg, "stack_bottom", winfo->stack_bottom);
+	devlink_fmsg_u32_pair_put(fmsg, "mgmt_pc", winfo->pc);
+	devlink_fmsg_u32_pair_put(fmsg, "lr", winfo->lr);
+	devlink_fmsg_u32_pair_put(fmsg, "cpsr", winfo->cpsr);
+	devlink_fmsg_binary_pair_put(fmsg, "Mgmt register info", winfo->reg,
+				     sizeof(winfo->reg));
+	return devlink_fmsg_binary_pair_put(fmsg, "Mgmt dump stack(start from sp)",
+					    winfo->data, sizeof(winfo->data));
 }
 
 static int hinic_fw_reporter_dump(struct devlink_health_reporter *reporter,
-- 
2.40.1


