Return-Path: <netdev+bounces-39511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB1E7BF910
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BD12821AD
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6053114A8B;
	Tue, 10 Oct 2023 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eV9EeBvE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FFCFBFC
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:53:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E361BA4
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 03:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696935184; x=1728471184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZTOZ2W8snJyyTtAm5Au0VWGIGrwmgMZ/z6bbmV4BFww=;
  b=eV9EeBvEh+mI7kEpBzCVF8k8sVcWQBtMclpTBH3RGaaCcl8fkM3MjNmL
   TDhobIromNutzQL5xKvgg84GOtTUQ/VPbzdbiLHC3Z8EbNNDfUeVrSlIl
   rVM7sQt0SqekpfvaWQdsFVjBs1sgkLEqS1//pHTrega8VxSTqmY3LlEfn
   ge41OKFU3qDsrpfUMsWNYjLz63U0831GPkhAIXwjwKtpV5iNgN2YE0mtQ
   Cf5l8HTg2i6adoIJa05+IZETGwB5KhBLWDmrfGhSaa6D7OBbU797h/26V
   7DH/yh2KQmYWakG7L2oifuj52NfeZM8BOF3p0xqkCk4pUBzL+ftJH01IL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="381624243"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="381624243"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:51:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="877182921"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="877182921"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 10 Oct 2023 03:51:07 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1C13C397C2;
	Tue, 10 Oct 2023 11:51:05 +0100 (IST)
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
Subject: [PATCH net-next v1 7/8] mlxsw: core: devlink health: use retained error fmsg API
Date: Tue, 10 Oct 2023 12:43:17 +0200
Message-Id: <20231010104318.3571791-8-przemyslaw.kitszel@intel.com>
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
add/remove: 0/8 grow/shrink: 0/3 up/down: 0/-694 (-694)
---
 drivers/net/ethernet/mellanox/mlxsw/core.c | 140 +++++----------------
 1 file changed, 34 insertions(+), 106 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 1ccf3b73ed72..f4d928cc591a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -1801,113 +1801,75 @@ mlxsw_core_health_fw_fatal_dump_fatal_cause(const char *mfde_pl,
 
 	val = mlxsw_reg_mfde_fatal_cause_id_get(mfde_pl);
 	err = devlink_fmsg_u32_pair_put(fmsg, "cause_id", val);
-	if (err)
-		return err;
 	tile_v = mlxsw_reg_mfde_fatal_cause_tile_v_get(mfde_pl);
 	if (tile_v) {
 		val = mlxsw_reg_mfde_fatal_cause_tile_index_get(mfde_pl);
 		err = devlink_fmsg_u8_pair_put(fmsg, "tile_index", val);
-		if (err)
-			return err;
 	}
 
-	return 0;
+	return err;
 }
 
 static int
 mlxsw_core_health_fw_fatal_dump_fw_assert(const char *mfde_pl,
 					  struct devlink_fmsg *fmsg)
 {
 	u32 val, tile_v;
-	int err;
 
 	val = mlxsw_reg_mfde_fw_assert_var0_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "var0", val);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "var0", val);
 	val = mlxsw_reg_mfde_fw_assert_var1_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "var1", val);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "var1", val);
 	val = mlxsw_reg_mfde_fw_assert_var2_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "var2", val);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "var2", val);
 	val = mlxsw_reg_mfde_fw_assert_var3_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "var3", val);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "var3", val);
 	val = mlxsw_reg_mfde_fw_assert_var4_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "var4", val);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "var4", val);
 	val = mlxsw_reg_mfde_fw_assert_existptr_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "existptr", val);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "existptr", val);
 	val = mlxsw_reg_mfde_fw_assert_callra_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "callra", val);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "callra", val);
 	val = mlxsw_reg_mfde_fw_assert_oe_get(mfde_pl);
-	err = devlink_fmsg_bool_pair_put(fmsg, "old_event", val);
-	if (err)
-		return err;
+	devlink_fmsg_bool_pair_put(fmsg, "old_event", val);
 	tile_v = mlxsw_reg_mfde_fw_assert_tile_v_get(mfde_pl);
 	if (tile_v) {
 		val = mlxsw_reg_mfde_fw_assert_tile_index_get(mfde_pl);
-		err = devlink_fmsg_u8_pair_put(fmsg, "tile_index", val);
-		if (err)
-			return err;
+		devlink_fmsg_u8_pair_put(fmsg, "tile_index", val);
 	}
 	val = mlxsw_reg_mfde_fw_assert_ext_synd_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "ext_synd", val);
-	if (err)
-		return err;
+	return devlink_fmsg_u32_pair_put(fmsg, "ext_synd", val);
 
-	return 0;
 }
 
 static int
 mlxsw_core_health_fw_fatal_dump_kvd_im_stop(const char *mfde_pl,
 					    struct devlink_fmsg *fmsg)
 {
 	u32 val;
-	int err;
 
 	val = mlxsw_reg_mfde_kvd_im_stop_oe_get(mfde_pl);
-	err = devlink_fmsg_bool_pair_put(fmsg, "old_event", val);
-	if (err)
-		return err;
+	devlink_fmsg_bool_pair_put(fmsg, "old_event", val);
 	val = mlxsw_reg_mfde_kvd_im_stop_pipes_mask_get(mfde_pl);
 	return devlink_fmsg_u32_pair_put(fmsg, "pipes_mask", val);
+
 }
 
 static int
 mlxsw_core_health_fw_fatal_dump_crspace_to(const char *mfde_pl,
 					   struct devlink_fmsg *fmsg)
 {
 	u32 val;
-	int err;
 
 	val = mlxsw_reg_mfde_crspace_to_log_address_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "log_address", val);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "log_address", val);
 	val = mlxsw_reg_mfde_crspace_to_oe_get(mfde_pl);
-	err = devlink_fmsg_bool_pair_put(fmsg, "old_event", val);
-	if (err)
-		return err;
+	devlink_fmsg_bool_pair_put(fmsg, "old_event", val);
 	val = mlxsw_reg_mfde_crspace_to_log_id_get(mfde_pl);
-	err = devlink_fmsg_u8_pair_put(fmsg, "log_irisc_id", val);
-	if (err)
-		return err;
+	devlink_fmsg_u8_pair_put(fmsg, "log_irisc_id", val);
 	val = mlxsw_reg_mfde_crspace_to_log_ip_get(mfde_pl);
-	err = devlink_fmsg_u64_pair_put(fmsg, "log_ip", val);
-	if (err)
-		return err;
+	return devlink_fmsg_u64_pair_put(fmsg, "log_ip", val);
 
-	return 0;
 }
 
 static int mlxsw_core_health_fw_fatal_dump(struct devlink_health_reporter *reporter,
@@ -1918,24 +1880,17 @@ static int mlxsw_core_health_fw_fatal_dump(struct devlink_health_reporter *repor
 	char *val_str;
 	u8 event_id;
 	u32 val;
-	int err;
 
 	if (!priv_ctx)
 		/* User-triggered dumps are not possible */
 		return -EOPNOTSUPP;
 
 	val = mlxsw_reg_mfde_irisc_id_get(mfde_pl);
-	err = devlink_fmsg_u8_pair_put(fmsg, "irisc_id", val);
-	if (err)
-		return err;
-	err = devlink_fmsg_arr_pair_nest_start(fmsg, "event");
-	if (err)
-		return err;
+	devlink_fmsg_u8_pair_put(fmsg, "irisc_id", val);
 
+	devlink_fmsg_arr_pair_nest_start(fmsg, "event");
 	event_id = mlxsw_reg_mfde_event_id_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "id", event_id);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "id", event_id);
 	switch (event_id) {
 	case MLXSW_REG_MFDE_EVENT_ID_CRSPACE_TO:
 		val_str = "CR space timeout";
@@ -1955,24 +1910,13 @@ static int mlxsw_core_health_fw_fatal_dump(struct devlink_health_reporter *repor
 	default:
 		val_str = NULL;
 	}
-	if (val_str) {
-		err = devlink_fmsg_string_pair_put(fmsg, "desc", val_str);
-		if (err)
-			return err;
-	}
-
-	err = devlink_fmsg_arr_pair_nest_end(fmsg);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_arr_pair_nest_start(fmsg, "severity");
-	if (err)
-		return err;
+	if (val_str)
+		devlink_fmsg_string_pair_put(fmsg, "desc", val_str);
+	devlink_fmsg_arr_pair_nest_end(fmsg);
 
+	devlink_fmsg_arr_pair_nest_start(fmsg, "severity");
 	val = mlxsw_reg_mfde_severity_get(mfde_pl);
-	err = devlink_fmsg_u8_pair_put(fmsg, "id", val);
-	if (err)
-		return err;
+	devlink_fmsg_u8_pair_put(fmsg, "id", val);
 	switch (val) {
 	case MLXSW_REG_MFDE_SEVERITY_FATL:
 		val_str = "Fatal";
@@ -1986,15 +1930,9 @@ static int mlxsw_core_health_fw_fatal_dump(struct devlink_health_reporter *repor
 	default:
 		val_str = NULL;
 	}
-	if (val_str) {
-		err = devlink_fmsg_string_pair_put(fmsg, "desc", val_str);
-		if (err)
-			return err;
-	}
-
-	err = devlink_fmsg_arr_pair_nest_end(fmsg);
-	if (err)
-		return err;
+	if (val_str)
+		devlink_fmsg_string_pair_put(fmsg, "desc", val_str);
+	devlink_fmsg_arr_pair_nest_end(fmsg);
 
 	val = mlxsw_reg_mfde_method_get(mfde_pl);
 	switch (val) {
@@ -2007,16 +1945,11 @@ static int mlxsw_core_health_fw_fatal_dump(struct devlink_health_reporter *repor
 	default:
 		val_str = NULL;
 	}
-	if (val_str) {
-		err = devlink_fmsg_string_pair_put(fmsg, "method", val_str);
-		if (err)
-			return err;
-	}
+	if (val_str)
+		devlink_fmsg_string_pair_put(fmsg, "method", val_str);
 
 	val = mlxsw_reg_mfde_long_process_get(mfde_pl);
-	err = devlink_fmsg_bool_pair_put(fmsg, "long_process", val);
-	if (err)
-		return err;
+	devlink_fmsg_bool_pair_put(fmsg, "long_process", val);
 
 	val = mlxsw_reg_mfde_command_type_get(mfde_pl);
 	switch (val) {
@@ -2032,16 +1965,11 @@ static int mlxsw_core_health_fw_fatal_dump(struct devlink_health_reporter *repor
 	default:
 		val_str = NULL;
 	}
-	if (val_str) {
-		err = devlink_fmsg_string_pair_put(fmsg, "command_type", val_str);
-		if (err)
-			return err;
-	}
+	if (val_str)
+		devlink_fmsg_string_pair_put(fmsg, "command_type", val_str);
 
 	val = mlxsw_reg_mfde_reg_attr_id_get(mfde_pl);
-	err = devlink_fmsg_u32_pair_put(fmsg, "reg_attr_id", val);
-	if (err)
-		return err;
+	devlink_fmsg_u32_pair_put(fmsg, "reg_attr_id", val);
 
 	switch (event_id) {
 	case MLXSW_REG_MFDE_EVENT_ID_CRSPACE_TO:
-- 
2.40.1


