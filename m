Return-Path: <netdev+bounces-39506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A4C7BF906
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA85F281C89
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D92EEDF;
	Tue, 10 Oct 2023 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWYgBId5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996B9FBED
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:51:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC429F
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 03:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696935089; x=1728471089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mtakw7wOOCt6uRRVnrSg+UPut2IO2rGjhVgXOlHPwOE=;
  b=DWYgBId59X8XHG0FWSjRr2OisYYDrrzS5CTtI0C8RooYZUlKQtxkCZ+t
   jUIRYbXZOdWkh47maC/sQeYm/4aala6R9FGKguAoIcQth2c8Qxl5ls144
   4/RlBzAJhSygHkWnV+PvxMCn3si4ux7iTx8MQggO6vJoEEd6ngM2svzqC
   1h96zUYHGt4sZz7ORMu54re8EEr4LXQh6iZsrZKgJCtMY8K8Vaup5a4bY
   u3sMV0iSMfGLLuUkzGIe8T7Jg65+C2YWZ5/wTW2qM2iReKtjfhsOTa7fh
   +UrdKwElmzeeUdJzSN7I5uKxq48xwPO6S3oVnYu2HRizysIazQb+cLhDq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="450859606"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="450859606"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1084726167"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="1084726167"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga005.fm.intel.com with ESMTP; 10 Oct 2023 03:50:54 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E121338C94;
	Tue, 10 Oct 2023 11:50:51 +0100 (IST)
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
Subject: [PATCH net-next v1 2/8] netdevsim: devlink health: use retained error fmsg API
Date: Tue, 10 Oct 2023 12:43:12 +0200
Message-Id: <20231010104318.3571791-3-przemyslaw.kitszel@intel.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Drop unneeded error checking.

devlink_fmsg_*() family of functions is now retaining errors,
so there is no need to check for them after each call.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
add/remove: 2/2 grow/shrink: 0/2 up/down: 449/-705 (-256)
---
 drivers/net/netdevsim/health.c | 103 +++++++++------------------------
 1 file changed, 27 insertions(+), 76 deletions(-)

diff --git a/drivers/net/netdevsim/health.c b/drivers/net/netdevsim/health.c
index eb04ed715d2d..0d16cdf80715 100644
--- a/drivers/net/netdevsim/health.c
+++ b/drivers/net/netdevsim/health.c
@@ -66,18 +66,10 @@ static int nsim_dev_dummy_fmsg_put(struct devlink_fmsg *fmsg, u32 binary_len)
 	int err;
 	int i;
 
-	err = devlink_fmsg_bool_pair_put(fmsg, "test_bool", true);
-	if (err)
-		return err;
-	err = devlink_fmsg_u8_pair_put(fmsg, "test_u8", 1);
-	if (err)
-		return err;
-	err = devlink_fmsg_u32_pair_put(fmsg, "test_u32", 3);
-	if (err)
-		return err;
-	err = devlink_fmsg_u64_pair_put(fmsg, "test_u64", 4);
-	if (err)
-		return err;
+	devlink_fmsg_bool_pair_put(fmsg, "test_bool", true);
+	devlink_fmsg_u8_pair_put(fmsg, "test_u8", 1);
+	devlink_fmsg_u32_pair_put(fmsg, "test_u32", 3);
+	devlink_fmsg_u64_pair_put(fmsg, "test_u64", 4);
 	err = devlink_fmsg_string_pair_put(fmsg, "test_string", "somestring");
 	if (err)
 		return err;
@@ -88,64 +80,31 @@ static int nsim_dev_dummy_fmsg_put(struct devlink_fmsg *fmsg, u32 binary_len)
 	get_random_bytes(binary, binary_len);
 	err = devlink_fmsg_binary_pair_put(fmsg, "test_binary", binary, binary_len);
 	kfree(binary);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_pair_nest_start(fmsg, "test_nest");
-	if (err)
-		return err;
-	err = devlink_fmsg_obj_nest_start(fmsg);
-	if (err)
-		return err;
-	err = devlink_fmsg_bool_pair_put(fmsg, "nested_test_bool", false);
-	if (err)
-		return err;
-	err = devlink_fmsg_u8_pair_put(fmsg, "nested_test_u8", false);
-	if (err)
-		return err;
-	err = devlink_fmsg_obj_nest_end(fmsg);
-	if (err)
-		return err;
-	err = devlink_fmsg_pair_nest_end(fmsg);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_arr_pair_nest_end(fmsg);
-	if (err)
-		return err;
 
+	devlink_fmsg_pair_nest_start(fmsg, "test_nest");
+	devlink_fmsg_obj_nest_start(fmsg);
+	devlink_fmsg_bool_pair_put(fmsg, "nested_test_bool", false);
+	devlink_fmsg_u8_pair_put(fmsg, "nested_test_u8", false);
+	devlink_fmsg_obj_nest_end(fmsg);
+	devlink_fmsg_pair_nest_end(fmsg);
+	devlink_fmsg_arr_pair_nest_end(fmsg);
 	err = devlink_fmsg_arr_pair_nest_start(fmsg, "test_u32_array");
-	if (err)
-		return err;
-	for (i = 0; i < 10; i++) {
-		err = devlink_fmsg_u32_put(fmsg, i);
-		if (err)
-			return err;
-	}
-	err = devlink_fmsg_arr_pair_nest_end(fmsg);
 	if (err)
 		return err;
 
+	for (i = 0; i < 10; i++)
+		devlink_fmsg_u32_put(fmsg, i);
+	devlink_fmsg_arr_pair_nest_end(fmsg);
 	err = devlink_fmsg_arr_pair_nest_start(fmsg, "test_array_of_objects");
 	if (err)
 		return err;
+
 	for (i = 0; i < 10; i++) {
-		err = devlink_fmsg_obj_nest_start(fmsg);
-		if (err)
-			return err;
-		err = devlink_fmsg_bool_pair_put(fmsg,
-						 "in_array_nested_test_bool",
-						 false);
-		if (err)
-			return err;
-		err = devlink_fmsg_u8_pair_put(fmsg,
-					       "in_array_nested_test_u8",
-					       i);
-		if (err)
-			return err;
-		err = devlink_fmsg_obj_nest_end(fmsg);
-		if (err)
-			return err;
+		devlink_fmsg_obj_nest_start(fmsg);
+		devlink_fmsg_bool_pair_put(fmsg, "in_array_nested_test_bool",
+					   false);
+		devlink_fmsg_u8_pair_put(fmsg, "in_array_nested_test_u8", i);
+		devlink_fmsg_obj_nest_end(fmsg);
 	}
 	return devlink_fmsg_arr_pair_nest_end(fmsg);
 }
@@ -157,32 +116,24 @@ nsim_dev_dummy_reporter_dump(struct devlink_health_reporter *reporter,
 {
 	struct nsim_dev_health *health = devlink_health_reporter_priv(reporter);
 	struct nsim_dev_dummy_reporter_ctx *ctx = priv_ctx;
-	int err;
 
-	if (ctx) {
-		err = devlink_fmsg_string_pair_put(fmsg, "break_message",
-						   ctx->break_msg);
-		if (err)
-			return err;
-	}
+	if (ctx)
+		devlink_fmsg_string_pair_put(fmsg, "break_message", ctx->break_msg);
+
 	return nsim_dev_dummy_fmsg_put(fmsg, health->binary_len);
 }
 
 static int
 nsim_dev_dummy_reporter_diagnose(struct devlink_health_reporter *reporter,
 				 struct devlink_fmsg *fmsg,
 				 struct netlink_ext_ack *extack)
 {
 	struct nsim_dev_health *health = devlink_health_reporter_priv(reporter);
-	int err;
 
-	if (health->recovered_break_msg) {
-		err = devlink_fmsg_string_pair_put(fmsg,
-						   "recovered_break_message",
-						   health->recovered_break_msg);
-		if (err)
-			return err;
-	}
+	if (health->recovered_break_msg)
+		devlink_fmsg_string_pair_put(fmsg, "recovered_break_message",
+					     health->recovered_break_msg);
+
 	return nsim_dev_dummy_fmsg_put(fmsg, health->binary_len);
 }
 
-- 
2.40.1


