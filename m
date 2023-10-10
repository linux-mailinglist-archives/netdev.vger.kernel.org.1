Return-Path: <netdev+bounces-39512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D64887BF911
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD5E1C20E61
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FD4FBFC;
	Tue, 10 Oct 2023 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tb3uuSNw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7E018AE1
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:53:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36946D3
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 03:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696935186; x=1728471186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wtF7/T/KIxpz0bBjdRmB0Mr+7W+6NfbYR0vjd664vJE=;
  b=Tb3uuSNwlA0+TnRUId3TV2LPZCrEv5X7HXz3PcvoYsLl9LARWc6ccBEi
   0aZZ1IvIAm1pInyguYJ/euPrzGWa1stcodsTDphyULl8Fuwdvx8fLRCfP
   O8XenaMdySijsaL+3EOdZTvy9tW9ZcT7Ifm6gRG0k9xmntXk3YLdoVzmi
   2o/rO++4pof2UeuYeewwyjecusxWmoU0WtYBF5O0N1w9qw/MdNkHqFRlI
   FkgG89FSkEJzE79bjfSTpVUJu/BIwxWfyiSDE3rIf2ki7uQNtAd84CqSZ
   bzLX/O0ojsYbq72Lj0hGeuUiohAs6V2Y7/ZwS4CJiPjuH4PDt+6XM6cJD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="381624270"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="381624270"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:51:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="877182928"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="877182928"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 10 Oct 2023 03:51:10 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 61C94386C1;
	Tue, 10 Oct 2023 11:51:07 +0100 (IST)
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
Subject: [PATCH net-next v1 8/8] net/mlx5: devlink health: use retained error fmsg API
Date: Tue, 10 Oct 2023 12:43:18 +0200
Message-Id: <20231010104318.3571791-9-przemyslaw.kitszel@intel.com>
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
add/remove: 8/8 grow/shrink: 0/17 up/down: 1589/-2880 (-1291)
---
 .../mellanox/mlx5/core/diag/fw_tracer.c       |  32 +-
 .../mellanox/mlx5/core/diag/reporter_vnic.c   | 108 ++----
 .../ethernet/mellanox/mlx5/core/en/health.c   | 144 ++-----
 .../mellanox/mlx5/core/en/reporter_rx.c       | 357 ++++--------------
 .../mellanox/mlx5/core/en/reporter_tx.c       | 275 +++-----------
 .../net/ethernet/mellanox/mlx5/core/health.c  |  85 ++---
 6 files changed, 219 insertions(+), 782 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
index 7c0f2adbea00..011d8aadbf28 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
@@ -893,32 +893,12 @@ static int
 mlx5_devlink_fmsg_fill_trace(struct devlink_fmsg *fmsg,
 			     struct mlx5_fw_trace_data *trace_data)
 {
-	int err;
-
-	err = devlink_fmsg_obj_nest_start(fmsg);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u64_pair_put(fmsg, "timestamp", trace_data->timestamp);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_bool_pair_put(fmsg, "lost", trace_data->lost);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u8_pair_put(fmsg, "event_id", trace_data->event_id);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_string_pair_put(fmsg, "msg", trace_data->msg);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_obj_nest_end(fmsg);
-	if (err)
-		return err;
-	return 0;
+	devlink_fmsg_obj_nest_start(fmsg);
+	devlink_fmsg_u64_pair_put(fmsg, "timestamp", trace_data->timestamp);
+	devlink_fmsg_bool_pair_put(fmsg, "lost", trace_data->lost);
+	devlink_fmsg_u8_pair_put(fmsg, "event_id", trace_data->event_id);
+	devlink_fmsg_string_pair_put(fmsg, "msg", trace_data->msg);
+	return devlink_fmsg_obj_nest_end(fmsg);
 }
 
 int mlx5_fw_tracer_get_saved_traces_objects(struct mlx5_fw_tracer *tracer,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
index e869c65d8e90..7d04ec45366d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
@@ -19,100 +19,50 @@ int mlx5_reporter_vnic_diagnose_counters(struct mlx5_core_dev *dev,
 {
 	u32 in[MLX5_ST_SZ_DW(query_vnic_env_in)] = {};
 	struct mlx5_vnic_diag_stats vnic;
-	int err;
 
 	MLX5_SET(query_vnic_env_in, in, opcode, MLX5_CMD_OP_QUERY_VNIC_ENV);
 	MLX5_SET(query_vnic_env_in, in, vport_number, vport_num);
 	MLX5_SET(query_vnic_env_in, in, other_vport, !!other_vport);
 
-	err = mlx5_cmd_exec_inout(dev, query_vnic_env, in, &vnic.query_vnic_env_out);
-	if (err)
-		return err;
+	mlx5_cmd_exec_inout(dev, query_vnic_env, in, &vnic.query_vnic_env_out);
 
-	err = devlink_fmsg_pair_nest_start(fmsg, "vNIC env counters");
-	if (err)
-		return err;
-
-	err = devlink_fmsg_obj_nest_start(fmsg);
-	if (err)
-		return err;
+	devlink_fmsg_pair_nest_start(fmsg, "vNIC env counters");
+	devlink_fmsg_obj_nest_start(fmsg);
 
 	if (MLX5_CAP_GEN(dev, vnic_env_queue_counters)) {
-		err = devlink_fmsg_u32_pair_put(fmsg, "total_error_queues",
-						VNIC_ENV_GET(&vnic, total_error_queues));
-		if (err)
-			return err;
-
-		err = devlink_fmsg_u32_pair_put(fmsg, "send_queue_priority_update_flow",
-						VNIC_ENV_GET(&vnic,
-							     send_queue_priority_update_flow));
-		if (err)
-			return err;
+		devlink_fmsg_u32_pair_put(fmsg, "total_error_queues",
+					  VNIC_ENV_GET(&vnic, total_error_queues));
+		devlink_fmsg_u32_pair_put(fmsg, "send_queue_priority_update_flow",
+					  VNIC_ENV_GET(&vnic, send_queue_priority_update_flow));
 	}
-
 	if (MLX5_CAP_GEN(dev, eq_overrun_count)) {
-		err = devlink_fmsg_u32_pair_put(fmsg, "comp_eq_overrun",
-						VNIC_ENV_GET(&vnic, comp_eq_overrun));
-		if (err)
-			return err;
-
-		err = devlink_fmsg_u32_pair_put(fmsg, "async_eq_overrun",
-						VNIC_ENV_GET(&vnic, async_eq_overrun));
-		if (err)
-			return err;
-	}
-
-	if (MLX5_CAP_GEN(dev, vnic_env_cq_overrun)) {
-		err = devlink_fmsg_u32_pair_put(fmsg, "cq_overrun",
-						VNIC_ENV_GET(&vnic, cq_overrun));
-		if (err)
-			return err;
-	}
-
-	if (MLX5_CAP_GEN(dev, invalid_command_count)) {
-		err = devlink_fmsg_u32_pair_put(fmsg, "invalid_command",
-						VNIC_ENV_GET(&vnic, invalid_command));
-		if (err)
-			return err;
+		devlink_fmsg_u32_pair_put(fmsg, "comp_eq_overrun",
+					  VNIC_ENV_GET(&vnic, comp_eq_overrun));
+		devlink_fmsg_u32_pair_put(fmsg, "async_eq_overrun",
+					  VNIC_ENV_GET(&vnic, async_eq_overrun));
 	}
-
-	if (MLX5_CAP_GEN(dev, quota_exceeded_count)) {
-		err = devlink_fmsg_u32_pair_put(fmsg, "quota_exceeded_command",
-						VNIC_ENV_GET(&vnic, quota_exceeded_command));
-		if (err)
-			return err;
-	}
-
-	if (MLX5_CAP_GEN(dev, nic_receive_steering_discard)) {
-		err = devlink_fmsg_u64_pair_put(fmsg, "nic_receive_steering_discard",
-						VNIC_ENV_GET64(&vnic,
-							       nic_receive_steering_discard));
-		if (err)
-			return err;
-	}
-
+	if (MLX5_CAP_GEN(dev, vnic_env_cq_overrun))
+		devlink_fmsg_u32_pair_put(fmsg, "cq_overrun",
+					  VNIC_ENV_GET(&vnic, cq_overrun));
+	if (MLX5_CAP_GEN(dev, invalid_command_count))
+		devlink_fmsg_u32_pair_put(fmsg, "invalid_command",
+					  VNIC_ENV_GET(&vnic, invalid_command));
+	if (MLX5_CAP_GEN(dev, quota_exceeded_count))
+		devlink_fmsg_u32_pair_put(fmsg, "quota_exceeded_command",
+					  VNIC_ENV_GET(&vnic, quota_exceeded_command));
+	if (MLX5_CAP_GEN(dev, nic_receive_steering_discard))
+		devlink_fmsg_u64_pair_put(fmsg, "nic_receive_steering_discard",
+					  VNIC_ENV_GET64(&vnic, nic_receive_steering_discard));
 	if (MLX5_CAP_GEN(dev, vnic_env_cnt_steering_fail)) {
-		err = devlink_fmsg_u64_pair_put(fmsg, "generated_pkt_steering_fail",
-						VNIC_ENV_GET64(&vnic,
-							       generated_pkt_steering_fail));
-		if (err)
-			return err;
-
-		err = devlink_fmsg_u64_pair_put(fmsg, "handled_pkt_steering_fail",
-						VNIC_ENV_GET64(&vnic, handled_pkt_steering_fail));
-		if (err)
-			return err;
+		devlink_fmsg_u64_pair_put(fmsg, "generated_pkt_steering_fail",
+					  VNIC_ENV_GET64(&vnic, generated_pkt_steering_fail));
+		devlink_fmsg_u64_pair_put(fmsg, "handled_pkt_steering_fail",
+					  VNIC_ENV_GET64(&vnic, handled_pkt_steering_fail));
 	}
 
-	err = devlink_fmsg_obj_nest_end(fmsg);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_pair_nest_end(fmsg);
-	if (err)
-		return err;
+	devlink_fmsg_obj_nest_end(fmsg);
+	return devlink_fmsg_pair_nest_end(fmsg);
 
-	return 0;
 }
 
 static int mlx5_reporter_vnic_diagnose(struct devlink_health_reporter *reporter,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/health.c b/drivers/net/ethernet/mellanox/mlx5/core/en/health.c
index 6f4e6c34b2a2..f3c7ff961778 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/health.c
@@ -7,131 +7,56 @@
 
 int mlx5e_health_fmsg_named_obj_nest_start(struct devlink_fmsg *fmsg, char *name)
 {
-	int err;
-
-	err = devlink_fmsg_pair_nest_start(fmsg, name);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_obj_nest_start(fmsg);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_pair_nest_start(fmsg, name);
+	return devlink_fmsg_obj_nest_start(fmsg);
 }
 
 int mlx5e_health_fmsg_named_obj_nest_end(struct devlink_fmsg *fmsg)
 {
-	int err;
-
-	err = devlink_fmsg_obj_nest_end(fmsg);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_pair_nest_end(fmsg);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_obj_nest_end(fmsg);
+	return devlink_fmsg_pair_nest_end(fmsg);
 }
 
 int mlx5e_health_cq_diag_fmsg(struct mlx5e_cq *cq, struct devlink_fmsg *fmsg)
 {
 	u32 out[MLX5_ST_SZ_DW(query_cq_out)] = {};
 	u8 hw_status;
 	void *cqc;
-	int err;
-
-	err = mlx5_core_query_cq(cq->mdev, &cq->mcq, out);
-	if (err)
-		return err;
 
+	mlx5_core_query_cq(cq->mdev, &cq->mcq, out);
 	cqc = MLX5_ADDR_OF(query_cq_out, out, cq_context);
 	hw_status = MLX5_GET(cqc, cqc, status);
 
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "CQ");
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "cqn", cq->mcq.cqn);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u8_pair_put(fmsg, "HW status", hw_status);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "ci", mlx5_cqwq_get_ci(&cq->wq));
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "size", mlx5_cqwq_get_size(&cq->wq));
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_end(fmsg);
-	if (err)
-		return err;
-
-	return 0;
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "CQ");
+	devlink_fmsg_u32_pair_put(fmsg, "cqn", cq->mcq.cqn);
+	devlink_fmsg_u8_pair_put(fmsg, "HW status", hw_status);
+	devlink_fmsg_u32_pair_put(fmsg, "ci", mlx5_cqwq_get_ci(&cq->wq));
+	devlink_fmsg_u32_pair_put(fmsg, "size", mlx5_cqwq_get_size(&cq->wq));
+	return mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 }
 
 int mlx5e_health_cq_common_diag_fmsg(struct mlx5e_cq *cq, struct devlink_fmsg *fmsg)
 {
 	u8 cq_log_stride;
 	u32 cq_sz;
-	int err;
 
 	cq_sz = mlx5_cqwq_get_size(&cq->wq);
 	cq_log_stride = mlx5_cqwq_get_log_stride_size(&cq->wq);
 
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "CQ");
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u64_pair_put(fmsg, "stride size", BIT(cq_log_stride));
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "size", cq_sz);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_end(fmsg);
-	if (err)
-		return err;
-
-	return 0;
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "CQ");
+	devlink_fmsg_u64_pair_put(fmsg, "stride size", BIT(cq_log_stride));
+	devlink_fmsg_u32_pair_put(fmsg, "size", cq_sz);
+	return mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 }
 
 int mlx5e_health_eq_diag_fmsg(struct mlx5_eq_comp *eq, struct devlink_fmsg *fmsg)
 {
-	int err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "EQ");
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u8_pair_put(fmsg, "eqn", eq->core.eqn);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "irqn", eq->core.irqn);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "vecidx", eq->core.vecidx);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "ci", eq->core.cons_index);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "size", eq_get_size(&eq->core));
-	if (err)
-		return err;
-
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "EQ");
+	devlink_fmsg_u8_pair_put(fmsg, "eqn", eq->core.eqn);
+	devlink_fmsg_u32_pair_put(fmsg, "irqn", eq->core.irqn);
+	devlink_fmsg_u32_pair_put(fmsg, "vecidx", eq->core.vecidx);
+	devlink_fmsg_u32_pair_put(fmsg, "ci", eq->core.cons_index);
+	devlink_fmsg_u32_pair_put(fmsg, "size", eq_get_size(&eq->core));
 	return mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 }
 
@@ -308,32 +233,17 @@ int mlx5e_health_queue_dump(struct mlx5e_priv *priv, struct devlink_fmsg *fmsg,
 			    int queue_idx, char *lbl)
 {
 	struct mlx5_rsc_key key = {};
-	int err;
 
 	key.rsc = MLX5_SGMT_TYPE_FULL_QPC;
 	key.index1 = queue_idx;
 	key.size = PAGE_SIZE;
 	key.num_of_obj1 = 1;
 
-	err = devlink_fmsg_obj_nest_start(fmsg);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, lbl);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "index", queue_idx);
-	if (err)
-		return err;
-
-	err = mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_end(fmsg);
-	if (err)
-		return err;
-
+	devlink_fmsg_obj_nest_start(fmsg);
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, lbl);
+	devlink_fmsg_u32_pair_put(fmsg, "index", queue_idx);
+	mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
+	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 	return devlink_fmsg_obj_nest_end(fmsg);
+
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index e8eea9ffd5eb..4020777acaeb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -202,54 +202,21 @@ static int mlx5e_rx_reporter_recover(struct devlink_health_reporter *reporter,
 static int mlx5e_reporter_icosq_diagnose(struct mlx5e_icosq *icosq, u8 hw_state,
 					 struct devlink_fmsg *fmsg)
 {
-	int err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "ICOSQ");
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "sqn", icosq->sqn);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u8_pair_put(fmsg, "HW state", hw_state);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "cc", icosq->cc);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "pc", icosq->pc);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "WQE size",
-					mlx5_wq_cyc_get_size(&icosq->wq));
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "CQ");
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "cqn", icosq->cq.mcq.cqn);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "cc", icosq->cq.wq.cc);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "size", mlx5_cqwq_get_size(&icosq->cq.wq));
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_end(fmsg);
-	if (err)
-		return err;
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "ICOSQ");
+	devlink_fmsg_u32_pair_put(fmsg, "sqn", icosq->sqn);
+	devlink_fmsg_u8_pair_put(fmsg, "HW state", hw_state);
+	devlink_fmsg_u32_pair_put(fmsg, "cc", icosq->cc);
+	devlink_fmsg_u32_pair_put(fmsg, "pc", icosq->pc);
+	devlink_fmsg_u32_pair_put(fmsg, "WQE size", mlx5_wq_cyc_get_size(&icosq->wq));
+
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "CQ");
+	devlink_fmsg_u32_pair_put(fmsg, "cqn", icosq->cq.mcq.cqn);
+	devlink_fmsg_u32_pair_put(fmsg, "cc", icosq->cq.wq.cc);
+	devlink_fmsg_u32_pair_put(fmsg, "size", mlx5_cqwq_get_size(&icosq->cq.wq));
+	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 
 	return mlx5e_health_fmsg_named_obj_nest_end(fmsg);
+
 }
 
 static int mlx5e_health_rq_put_sw_state(struct devlink_fmsg *fmsg, struct mlx5e_rq *rq)
@@ -291,71 +258,34 @@ mlx5e_rx_reporter_build_diagnose_output_rq_common(struct mlx5e_rq *rq,
 	wq_head = mlx5e_rqwq_get_head(rq);
 	wqe_counter = mlx5e_rqwq_get_wqe_counter(rq);
 
-	err = devlink_fmsg_u32_pair_put(fmsg, "rqn", rq->rqn);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u8_pair_put(fmsg, "HW state", hw_state);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "WQE counter", wqe_counter);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "posted WQEs", wqes_sz);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "cc", wq_head);
-	if (err)
-		return err;
-
-	err = mlx5e_health_rq_put_sw_state(fmsg, rq);
-	if (err)
-		return err;
-
-	err = mlx5e_health_cq_diag_fmsg(&rq->cq, fmsg);
-	if (err)
-		return err;
-
+	devlink_fmsg_u32_pair_put(fmsg, "rqn", rq->rqn);
+	devlink_fmsg_u8_pair_put(fmsg, "HW state", hw_state);
+	devlink_fmsg_u32_pair_put(fmsg, "WQE counter", wqe_counter);
+	devlink_fmsg_u32_pair_put(fmsg, "posted WQEs", wqes_sz);
+	devlink_fmsg_u32_pair_put(fmsg, "cc", wq_head);
+	mlx5e_health_rq_put_sw_state(fmsg, rq);
+	mlx5e_health_cq_diag_fmsg(&rq->cq, fmsg);
 	err = mlx5e_health_eq_diag_fmsg(rq->cq.mcq.eq, fmsg);
 	if (err)
 		return err;
 
 	if (rq->icosq) {
 		struct mlx5e_icosq *icosq = rq->icosq;
 		u8 icosq_hw_state;
 
-		err = mlx5_core_query_sq_state(rq->mdev, icosq->sqn, &icosq_hw_state);
-		if (err)
-			return err;
-
-		err = mlx5e_reporter_icosq_diagnose(icosq, icosq_hw_state, fmsg);
-		if (err)
-			return err;
+		mlx5_core_query_sq_state(rq->mdev, icosq->sqn, &icosq_hw_state);
+		return mlx5e_reporter_icosq_diagnose(icosq, icosq_hw_state, fmsg);
 	}
 
 	return 0;
 }
 
 static int mlx5e_rx_reporter_build_diagnose_output(struct mlx5e_rq *rq,
 						   struct devlink_fmsg *fmsg)
 {
-	int err;
-
-	err = devlink_fmsg_obj_nest_start(fmsg);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "channel ix", rq->ix);
-	if (err)
-		return err;
-
-	err = mlx5e_rx_reporter_build_diagnose_output_rq_common(rq, fmsg);
-	if (err)
-		return err;
-
+	devlink_fmsg_obj_nest_start(fmsg);
+	devlink_fmsg_u32_pair_put(fmsg, "channel ix", rq->ix);
+	mlx5e_rx_reporter_build_diagnose_output_rq_common(rq, fmsg);
 	return devlink_fmsg_obj_nest_end(fmsg);
 }
 
@@ -366,58 +296,29 @@ static int mlx5e_rx_reporter_diagnose_generic_rq(struct mlx5e_rq *rq,
 	struct mlx5e_params *params;
 	u32 rq_stride, rq_sz;
 	bool real_time;
-	int err;
 
 	params = &priv->channels.params;
 	rq_sz = mlx5e_rqwq_get_size(rq);
 	real_time =  mlx5_is_real_time_rq(priv->mdev);
 	rq_stride = BIT(mlx5e_mpwqe_get_log_stride_size(priv->mdev, params, NULL));
 
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "RQ");
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u8_pair_put(fmsg, "type", params->rq_wq_type);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u64_pair_put(fmsg, "stride size", rq_stride);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "size", rq_sz);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_string_pair_put(fmsg, "ts_format", real_time ? "RT" : "FRC");
-	if (err)
-		return err;
-
-	err = mlx5e_health_cq_common_diag_fmsg(&rq->cq, fmsg);
-	if (err)
-		return err;
-
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "RQ");
+	devlink_fmsg_u8_pair_put(fmsg, "type", params->rq_wq_type);
+	devlink_fmsg_u64_pair_put(fmsg, "stride size", rq_stride);
+	devlink_fmsg_u32_pair_put(fmsg, "size", rq_sz);
+	devlink_fmsg_string_pair_put(fmsg, "ts_format", real_time ? "RT" : "FRC");
+	mlx5e_health_cq_common_diag_fmsg(&rq->cq, fmsg);
 	return mlx5e_health_fmsg_named_obj_nest_end(fmsg);
+
 }
 
 static int
 mlx5e_rx_reporter_diagnose_common_ptp_config(struct mlx5e_priv *priv, struct mlx5e_ptp *ptp_ch,
 					     struct devlink_fmsg *fmsg)
 {
-	int err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "PTP");
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "filter_type", priv->tstamp.rx_filter);
-	if (err)
-		return err;
-
-	err = mlx5e_rx_reporter_diagnose_generic_rq(&ptp_ch->rq, fmsg);
-	if (err)
-		return err;
-
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "PTP");
+	devlink_fmsg_u32_pair_put(fmsg, "filter_type", priv->tstamp.rx_filter);
+	mlx5e_rx_reporter_diagnose_generic_rq(&ptp_ch->rq, fmsg);
 	return mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 }
 
@@ -428,47 +329,22 @@ mlx5e_rx_reporter_diagnose_common_config(struct devlink_health_reporter *reporte
 	struct mlx5e_priv *priv = devlink_health_reporter_priv(reporter);
 	struct mlx5e_rq *generic_rq = &priv->channels.c[0]->rq;
 	struct mlx5e_ptp *ptp_ch = priv->channels.ptp;
-	int err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "Common config");
-	if (err)
-		return err;
-
-	err = mlx5e_rx_reporter_diagnose_generic_rq(generic_rq, fmsg);
-	if (err)
-		return err;
-
-	if (ptp_ch && test_bit(MLX5E_PTP_STATE_RX, ptp_ch->state)) {
-		err = mlx5e_rx_reporter_diagnose_common_ptp_config(priv, ptp_ch, fmsg);
-		if (err)
-			return err;
-	}
 
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "Common config");
+	mlx5e_rx_reporter_diagnose_generic_rq(generic_rq, fmsg);
+	if (ptp_ch && test_bit(MLX5E_PTP_STATE_RX, ptp_ch->state))
+		mlx5e_rx_reporter_diagnose_common_ptp_config(priv, ptp_ch, fmsg);
 	return mlx5e_health_fmsg_named_obj_nest_end(fmsg);
+
 }
 
 static int mlx5e_rx_reporter_build_diagnose_output_ptp_rq(struct mlx5e_rq *rq,
 							  struct devlink_fmsg *fmsg)
 {
-	int err;
-
-	err = devlink_fmsg_obj_nest_start(fmsg);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_string_pair_put(fmsg, "channel", "ptp");
-	if (err)
-		return err;
-
-	err = mlx5e_rx_reporter_build_diagnose_output_rq_common(rq, fmsg);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_obj_nest_end(fmsg);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_obj_nest_start(fmsg);
+	devlink_fmsg_string_pair_put(fmsg, "channel", "ptp");
+	mlx5e_rx_reporter_build_diagnose_output_rq_common(rq, fmsg);
+	return devlink_fmsg_obj_nest_end(fmsg);
 }
 
 static int mlx5e_rx_reporter_diagnose(struct devlink_health_reporter *reporter,
@@ -484,13 +360,8 @@ static int mlx5e_rx_reporter_diagnose(struct devlink_health_reporter *reporter,
 	if (!test_bit(MLX5E_STATE_OPENED, &priv->state))
 		goto unlock;
 
-	err = mlx5e_rx_reporter_diagnose_common_config(reporter, fmsg);
-	if (err)
-		goto unlock;
-
-	err = devlink_fmsg_arr_pair_nest_start(fmsg, "RQs");
-	if (err)
-		goto unlock;
+	mlx5e_rx_reporter_diagnose_common_config(reporter, fmsg);
+	devlink_fmsg_arr_pair_nest_start(fmsg, "RQs");
 
 	for (i = 0; i < priv->channels.num; i++) {
 		struct mlx5e_channel *c = priv->channels.c[i];
@@ -503,11 +374,8 @@ static int mlx5e_rx_reporter_diagnose(struct devlink_health_reporter *reporter,
 		if (err)
 			goto unlock;
 	}
-	if (ptp_ch && test_bit(MLX5E_PTP_STATE_RX, ptp_ch->state)) {
-		err = mlx5e_rx_reporter_build_diagnose_output_ptp_rq(&ptp_ch->rq, fmsg);
-		if (err)
-			goto unlock;
-	}
+	if (ptp_ch && test_bit(MLX5E_PTP_STATE_RX, ptp_ch->state))
+		mlx5e_rx_reporter_build_diagnose_output_ptp_rq(&ptp_ch->rq, fmsg);
 	err = devlink_fmsg_arr_pair_nest_end(fmsg);
 unlock:
 	mutex_unlock(&priv->state_lock);
@@ -519,165 +387,96 @@ static int mlx5e_rx_reporter_dump_icosq(struct mlx5e_priv *priv, struct devlink_
 {
 	struct mlx5e_txqsq *icosq = ctx;
 	struct mlx5_rsc_key key = {};
-	int err;
 
 	if (!test_bit(MLX5E_STATE_OPENED, &priv->state))
 		return 0;
 
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "SX Slice");
-	if (err)
-		return err;
-
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "SX Slice");
 	key.size = PAGE_SIZE;
 	key.rsc = MLX5_SGMT_TYPE_SX_SLICE_ALL;
-	err = mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_end(fmsg);
-	if (err)
-		return err;
+	mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
+	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "ICOSQ");
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "QPC");
-	if (err)
-		return err;
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "ICOSQ");
 
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "QPC");
 	key.rsc = MLX5_SGMT_TYPE_FULL_QPC;
 	key.index1 = icosq->sqn;
 	key.num_of_obj1 = 1;
+	mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
+	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 
-	err = mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_end(fmsg);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "send_buff");
-	if (err)
-		return err;
-
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "send_buff");
 	key.rsc = MLX5_SGMT_TYPE_SND_BUFF;
 	key.num_of_obj2 = MLX5_RSC_DUMP_ALL;
-
-	err = mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_end(fmsg);
-	if (err)
-		return err;
+	mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
+	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 
 	return mlx5e_health_fmsg_named_obj_nest_end(fmsg);
+
 }
 
 static int mlx5e_rx_reporter_dump_rq(struct mlx5e_priv *priv, struct devlink_fmsg *fmsg,
 				     void *ctx)
 {
 	struct mlx5_rsc_key key = {};
 	struct mlx5e_rq *rq = ctx;
-	int err;
 
 	if (!test_bit(MLX5E_STATE_OPENED, &priv->state))
 		return 0;
 
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "RX Slice");
-	if (err)
-		return err;
-
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "RX Slice");
 	key.size = PAGE_SIZE;
 	key.rsc = MLX5_SGMT_TYPE_RX_SLICE_ALL;
-	err = mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
-	if (err)
-		return err;
+	mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
+	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 
-	err = mlx5e_health_fmsg_named_obj_nest_end(fmsg);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "RQ");
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "QPC");
-	if (err)
-		return err;
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "RQ");
 
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "QPC");
 	key.rsc = MLX5_SGMT_TYPE_FULL_QPC;
 	key.index1 = rq->rqn;
 	key.num_of_obj1 = 1;
+	mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
+	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 
-	err = mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_end(fmsg);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "receive_buff");
-	if (err)
-		return err;
-
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "receive_buff");
 	key.rsc = MLX5_SGMT_TYPE_RCV_BUFF;
 	key.num_of_obj2 = MLX5_RSC_DUMP_ALL;
-	err = mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_end(fmsg);
-	if (err)
-		return err;
+	mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
+	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 
 	return mlx5e_health_fmsg_named_obj_nest_end(fmsg);
+
 }
 
 static int mlx5e_rx_reporter_dump_all_rqs(struct mlx5e_priv *priv,
 					  struct devlink_fmsg *fmsg)
 {
 	struct mlx5e_ptp *ptp_ch = priv->channels.ptp;
 	struct mlx5_rsc_key key = {};
-	int i, err;
 
 	if (!test_bit(MLX5E_STATE_OPENED, &priv->state))
 		return 0;
 
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "RX Slice");
-	if (err)
-		return err;
-
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "RX Slice");
 	key.size = PAGE_SIZE;
 	key.rsc = MLX5_SGMT_TYPE_RX_SLICE_ALL;
-	err = mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
-	if (err)
-		return err;
+	mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
+	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
+	devlink_fmsg_arr_pair_nest_start(fmsg, "RQs");
 
-	err = mlx5e_health_fmsg_named_obj_nest_end(fmsg);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_arr_pair_nest_start(fmsg, "RQs");
-	if (err)
-		return err;
-
-	for (i = 0; i < priv->channels.num; i++) {
+	for (int i = 0; i < priv->channels.num; i++) {
 		struct mlx5e_rq *rq = &priv->channels.c[i]->rq;
+		int err;
 
 		err = mlx5e_health_queue_dump(priv, fmsg, rq->rqn, "RQ");
 		if (err)
 			return err;
 	}
 
-	if (ptp_ch && test_bit(MLX5E_PTP_STATE_RX, ptp_ch->state)) {
-		err = mlx5e_health_queue_dump(priv, fmsg, ptp_ch->rq.rqn, "PTP RQ");
-		if (err)
-			return err;
-	}
+	if (ptp_ch && test_bit(MLX5E_PTP_STATE_RX, ptp_ch->state))
+		mlx5e_health_queue_dump(priv, fmsg, ptp_ch->rq.rqn, "PTP RQ");
 
 	return devlink_fmsg_arr_pair_nest_end(fmsg);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index ff8242f67c54..344d5c0e6909 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -227,162 +227,67 @@ mlx5e_tx_reporter_build_diagnose_output_sq_common(struct devlink_fmsg *fmsg,
 	bool stopped = netif_xmit_stopped(sq->txq);
 	struct mlx5e_priv *priv = sq->priv;
 	u8 state;
-	int err;
-
-	err = mlx5_core_query_sq_state(priv->mdev, sq->sqn, &state);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "tc", tc);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "txq ix", sq->txq_ix);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "sqn", sq->sqn);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u8_pair_put(fmsg, "HW state", state);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_bool_pair_put(fmsg, "stopped", stopped);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "cc", sq->cc);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "pc", sq->pc);
-	if (err)
-		return err;
-
-	err = mlx5e_health_sq_put_sw_state(fmsg, sq);
-	if (err)
-		return err;
-
-	err = mlx5e_health_cq_diag_fmsg(&sq->cq, fmsg);
-	if (err)
-		return err;
 
+	mlx5_core_query_sq_state(priv->mdev, sq->sqn, &state);
+	devlink_fmsg_u32_pair_put(fmsg, "tc", tc);
+	devlink_fmsg_u32_pair_put(fmsg, "txq ix", sq->txq_ix);
+	devlink_fmsg_u32_pair_put(fmsg, "sqn", sq->sqn);
+	devlink_fmsg_u8_pair_put(fmsg, "HW state", state);
+	devlink_fmsg_bool_pair_put(fmsg, "stopped", stopped);
+	devlink_fmsg_u32_pair_put(fmsg, "cc", sq->cc);
+	devlink_fmsg_u32_pair_put(fmsg, "pc", sq->pc);
+	mlx5e_health_sq_put_sw_state(fmsg, sq);
+	mlx5e_health_cq_diag_fmsg(&sq->cq, fmsg);
 	return mlx5e_health_eq_diag_fmsg(sq->cq.mcq.eq, fmsg);
+
 }
 
 static int
 mlx5e_tx_reporter_build_diagnose_output(struct devlink_fmsg *fmsg,
 					struct mlx5e_txqsq *sq, int tc)
 {
-	int err;
-
-	err = devlink_fmsg_obj_nest_start(fmsg);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "channel ix", sq->ch_ix);
-	if (err)
-		return err;
-
-	err = mlx5e_tx_reporter_build_diagnose_output_sq_common(fmsg, sq, tc);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_obj_nest_end(fmsg);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_obj_nest_start(fmsg);
+	devlink_fmsg_u32_pair_put(fmsg, "channel ix", sq->ch_ix);
+	mlx5e_tx_reporter_build_diagnose_output_sq_common(fmsg, sq, tc);
+	return devlink_fmsg_obj_nest_end(fmsg);
 }
 
 static int
 mlx5e_tx_reporter_build_diagnose_output_ptpsq(struct devlink_fmsg *fmsg,
 					      struct mlx5e_ptpsq *ptpsq, int tc)
 {
-	int err;
-
-	err = devlink_fmsg_obj_nest_start(fmsg);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_string_pair_put(fmsg, "channel", "ptp");
-	if (err)
-		return err;
-
-	err = mlx5e_tx_reporter_build_diagnose_output_sq_common(fmsg, &ptpsq->txqsq, tc);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "Port TS");
-	if (err)
-		return err;
-
-	err = mlx5e_health_cq_diag_fmsg(&ptpsq->ts_cq, fmsg);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_end(fmsg);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_obj_nest_end(fmsg);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_obj_nest_start(fmsg);
+	devlink_fmsg_string_pair_put(fmsg, "channel", "ptp");
+	mlx5e_tx_reporter_build_diagnose_output_sq_common(fmsg, &ptpsq->txqsq, tc);
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "Port TS");
+	mlx5e_health_cq_diag_fmsg(&ptpsq->ts_cq, fmsg);
+	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
+	return devlink_fmsg_obj_nest_end(fmsg);
 }
 
 static int
 mlx5e_tx_reporter_diagnose_generic_txqsq(struct devlink_fmsg *fmsg,
 					 struct mlx5e_txqsq *txqsq)
 {
-	u32 sq_stride, sq_sz;
-	bool real_time;
-	int err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "SQ");
-	if (err)
-		return err;
-
-	real_time =  mlx5_is_real_time_sq(txqsq->mdev);
-	sq_sz = mlx5_wq_cyc_get_size(&txqsq->wq);
-	sq_stride = MLX5_SEND_WQE_BB;
-
-	err = devlink_fmsg_u64_pair_put(fmsg, "stride size", sq_stride);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "size", sq_sz);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_string_pair_put(fmsg, "ts_format", real_time ? "RT" : "FRC");
-	if (err)
-		return err;
-
-	err = mlx5e_health_cq_common_diag_fmsg(&txqsq->cq, fmsg);
-	if (err)
-		return err;
-
+	bool real_time =  mlx5_is_real_time_sq(txqsq->mdev);
+	u32 sq_sz = mlx5_wq_cyc_get_size(&txqsq->wq);
+	u32 sq_stride = MLX5_SEND_WQE_BB;
+
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "SQ");
+	devlink_fmsg_u64_pair_put(fmsg, "stride size", sq_stride);
+	devlink_fmsg_u32_pair_put(fmsg, "size", sq_sz);
+	devlink_fmsg_string_pair_put(fmsg, "ts_format", real_time ? "RT" : "FRC");
+	mlx5e_health_cq_common_diag_fmsg(&txqsq->cq, fmsg);
 	return mlx5e_health_fmsg_named_obj_nest_end(fmsg);
+
 }
 
 static int
 mlx5e_tx_reporter_diagnose_generic_tx_port_ts(struct devlink_fmsg *fmsg,
 					      struct mlx5e_ptpsq *ptpsq)
 {
-	int err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "Port TS");
-	if (err)
-		return err;
-
-	err = mlx5e_health_cq_common_diag_fmsg(&ptpsq->ts_cq, fmsg);
-	if (err)
-		return err;
-
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "Port TS");
+	mlx5e_health_cq_common_diag_fmsg(&ptpsq->ts_cq, fmsg);
 	return mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 }
 
@@ -394,37 +299,18 @@ mlx5e_tx_reporter_diagnose_common_config(struct devlink_health_reporter *reporte
 	struct mlx5e_txqsq *generic_sq = priv->txq2sq[0];
 	struct mlx5e_ptp *ptp_ch = priv->channels.ptp;
 	struct mlx5e_ptpsq *generic_ptpsq;
-	int err;
 
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "Common Config");
-	if (err)
-		return err;
-
-	err = mlx5e_tx_reporter_diagnose_generic_txqsq(fmsg, generic_sq);
-	if (err)
-		return err;
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "Common Config");
+	mlx5e_tx_reporter_diagnose_generic_txqsq(fmsg, generic_sq);
 
 	if (!ptp_ch || !test_bit(MLX5E_PTP_STATE_TX, ptp_ch->state))
 		goto out;
 
 	generic_ptpsq = &ptp_ch->ptpsq[0];
-
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "PTP");
-	if (err)
-		return err;
-
-	err = mlx5e_tx_reporter_diagnose_generic_txqsq(fmsg, &generic_ptpsq->txqsq);
-	if (err)
-		return err;
-
-	err = mlx5e_tx_reporter_diagnose_generic_tx_port_ts(fmsg, generic_ptpsq);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_end(fmsg);
-	if (err)
-		return err;
-
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "PTP");
+	mlx5e_tx_reporter_diagnose_generic_txqsq(fmsg, &generic_ptpsq->txqsq);
+	mlx5e_tx_reporter_diagnose_generic_tx_port_ts(fmsg, generic_ptpsq);
+	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 out:
 	return mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 }
@@ -443,13 +329,8 @@ static int mlx5e_tx_reporter_diagnose(struct devlink_health_reporter *reporter,
 	if (!test_bit(MLX5E_STATE_OPENED, &priv->state))
 		goto unlock;
 
-	err = mlx5e_tx_reporter_diagnose_common_config(reporter, fmsg);
-	if (err)
-		goto unlock;
-
-	err = devlink_fmsg_arr_pair_nest_start(fmsg, "SQs");
-	if (err)
-		goto unlock;
+	mlx5e_tx_reporter_diagnose_common_config(reporter, fmsg);
+	devlink_fmsg_arr_pair_nest_start(fmsg, "SQs");
 
 	for (i = 0; i < priv->channels.num; i++) {
 		struct mlx5e_channel *c = priv->channels.c[i];
@@ -476,9 +357,6 @@ static int mlx5e_tx_reporter_diagnose(struct devlink_health_reporter *reporter,
 
 close_sqs_nest:
 	err = devlink_fmsg_arr_pair_nest_end(fmsg);
-	if (err)
-		goto unlock;
-
 unlock:
 	mutex_unlock(&priv->state_lock);
 	return err;
@@ -489,60 +367,32 @@ static int mlx5e_tx_reporter_dump_sq(struct mlx5e_priv *priv, struct devlink_fms
 {
 	struct mlx5_rsc_key key = {};
 	struct mlx5e_txqsq *sq = ctx;
-	int err;
 
 	if (!test_bit(MLX5E_STATE_OPENED, &priv->state))
 		return 0;
 
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "SX Slice");
-	if (err)
-		return err;
-
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "SX Slice");
 	key.size = PAGE_SIZE;
 	key.rsc = MLX5_SGMT_TYPE_SX_SLICE_ALL;
-	err = mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_end(fmsg);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "SQ");
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "QPC");
-	if (err)
-		return err;
+	mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
+	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "SQ");
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "QPC");
 	key.rsc = MLX5_SGMT_TYPE_FULL_QPC;
 	key.index1 = sq->sqn;
 	key.num_of_obj1 = 1;
+	mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
+	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 
-	err = mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_end(fmsg);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "send_buff");
-	if (err)
-		return err;
-
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "send_buff");
 	key.rsc = MLX5_SGMT_TYPE_SND_BUFF;
 	key.num_of_obj2 = MLX5_RSC_DUMP_ALL;
-	err = mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_end(fmsg);
-	if (err)
-		return err;
+	mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
+	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 
 	return mlx5e_health_fmsg_named_obj_nest_end(fmsg);
+
 }
 
 static int mlx5e_tx_reporter_timeout_dump(struct mlx5e_priv *priv, struct devlink_fmsg *fmsg,
@@ -572,23 +422,12 @@ static int mlx5e_tx_reporter_dump_all_sqs(struct mlx5e_priv *priv,
 	if (!test_bit(MLX5E_STATE_OPENED, &priv->state))
 		return 0;
 
-	err = mlx5e_health_fmsg_named_obj_nest_start(fmsg, "SX Slice");
-	if (err)
-		return err;
-
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "SX Slice");
 	key.size = PAGE_SIZE;
 	key.rsc = MLX5_SGMT_TYPE_SX_SLICE_ALL;
-	err = mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
-	if (err)
-		return err;
-
-	err = mlx5e_health_fmsg_named_obj_nest_end(fmsg);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_arr_pair_nest_start(fmsg, "SQs");
-	if (err)
-		return err;
+	mlx5e_health_rsc_fmsg_dump(priv, &key, fmsg);
+	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
+	devlink_fmsg_arr_pair_nest_start(fmsg, "SQs");
 
 	for (i = 0; i < priv->channels.num; i++) {
 		struct mlx5e_channel *c = priv->channels.c[i];
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index 1c220048ae9a..aa074ddd948a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -469,89 +469,48 @@ static int
 mlx5_fw_reporter_ctx_pairs_put(struct devlink_fmsg *fmsg,
 			       struct mlx5_fw_reporter_ctx *fw_reporter_ctx)
 {
-	int err;
-
-	err = devlink_fmsg_u8_pair_put(fmsg, "syndrome",
-				       fw_reporter_ctx->err_synd);
-	if (err)
-		return err;
-	err = devlink_fmsg_u32_pair_put(fmsg, "fw_miss_counter",
-					fw_reporter_ctx->miss_counter);
-	if (err)
-		return err;
-	return 0;
+	devlink_fmsg_u8_pair_put(fmsg, "syndrome", fw_reporter_ctx->err_synd);
+	return devlink_fmsg_u32_pair_put(fmsg, "fw_miss_counter",
+					 fw_reporter_ctx->miss_counter);
 }
 
 static int
 mlx5_fw_reporter_heath_buffer_data_put(struct mlx5_core_dev *dev,
 				       struct devlink_fmsg *fmsg)
 {
 	struct mlx5_core_health *health = &dev->priv.health;
 	struct health_buffer __iomem *h = health->health;
 	u8 rfr_severity;
-	int err;
 	int i;
 
 	if (!ioread8(&h->synd))
 		return 0;
 
-	err = devlink_fmsg_pair_nest_start(fmsg, "health buffer");
-	if (err)
-		return err;
-	err = devlink_fmsg_obj_nest_start(fmsg);
-	if (err)
-		return err;
-	err = devlink_fmsg_arr_pair_nest_start(fmsg, "assert_var");
-	if (err)
-		return err;
-
+	devlink_fmsg_pair_nest_start(fmsg, "health buffer");
+	devlink_fmsg_obj_nest_start(fmsg);
+	devlink_fmsg_arr_pair_nest_start(fmsg, "assert_var");
 	for (i = 0; i < ARRAY_SIZE(h->assert_var); i++) {
+		int err;
+
 		err = devlink_fmsg_u32_put(fmsg, ioread32be(h->assert_var + i));
 		if (err)
 			return err;
 	}
-	err = devlink_fmsg_arr_pair_nest_end(fmsg);
-	if (err)
-		return err;
-	err = devlink_fmsg_u32_pair_put(fmsg, "assert_exit_ptr",
-					ioread32be(&h->assert_exit_ptr));
-	if (err)
-		return err;
-	err = devlink_fmsg_u32_pair_put(fmsg, "assert_callra",
-					ioread32be(&h->assert_callra));
-	if (err)
-		return err;
-	err = devlink_fmsg_u32_pair_put(fmsg, "time", ioread32be(&h->time));
-	if (err)
-		return err;
-	err = devlink_fmsg_u32_pair_put(fmsg, "hw_id", ioread32be(&h->hw_id));
-	if (err)
-		return err;
+	devlink_fmsg_arr_pair_nest_end(fmsg);
+	devlink_fmsg_u32_pair_put(fmsg, "assert_exit_ptr",
+				  ioread32be(&h->assert_exit_ptr));
+	devlink_fmsg_u32_pair_put(fmsg, "assert_callra",
+				  ioread32be(&h->assert_callra));
+	devlink_fmsg_u32_pair_put(fmsg, "time", ioread32be(&h->time));
+	devlink_fmsg_u32_pair_put(fmsg, "hw_id", ioread32be(&h->hw_id));
 	rfr_severity = ioread8(&h->rfr_severity);
-	err = devlink_fmsg_u8_pair_put(fmsg, "rfr", mlx5_health_get_rfr(rfr_severity));
-	if (err)
-		return err;
-	err = devlink_fmsg_u8_pair_put(fmsg, "severity", mlx5_health_get_severity(rfr_severity));
-	if (err)
-		return err;
-	err = devlink_fmsg_u8_pair_put(fmsg, "irisc_index",
-				       ioread8(&h->irisc_index));
-	if (err)
-		return err;
-	err = devlink_fmsg_u8_pair_put(fmsg, "synd", ioread8(&h->synd));
-	if (err)
-		return err;
-	err = devlink_fmsg_u32_pair_put(fmsg, "ext_synd",
-					ioread16be(&h->ext_synd));
-	if (err)
-		return err;
-	err = devlink_fmsg_u32_pair_put(fmsg, "raw_fw_ver",
-					ioread32be(&h->fw_ver));
-	if (err)
-		return err;
-	err = devlink_fmsg_obj_nest_end(fmsg);
-	if (err)
-		return err;
+	devlink_fmsg_u8_pair_put(fmsg, "rfr", mlx5_health_get_rfr(rfr_severity));
+	devlink_fmsg_u8_pair_put(fmsg, "severity", mlx5_health_get_severity(rfr_severity));
+	devlink_fmsg_u8_pair_put(fmsg, "irisc_index", ioread8(&h->irisc_index));
+	devlink_fmsg_u8_pair_put(fmsg, "synd", ioread8(&h->synd));
+	devlink_fmsg_u32_pair_put(fmsg, "ext_synd", ioread16be(&h->ext_synd));
+	devlink_fmsg_u32_pair_put(fmsg, "raw_fw_ver", ioread32be(&h->fw_ver));
+	devlink_fmsg_obj_nest_end(fmsg);
 	return devlink_fmsg_pair_nest_end(fmsg);
 }
 
-- 
2.40.1


