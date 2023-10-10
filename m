Return-Path: <netdev+bounces-39509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C077BF90E
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9B2281F68
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061C214A8B;
	Tue, 10 Oct 2023 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gCqxLudO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AFAFBF8
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:53:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1245AC6
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 03:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696935183; x=1728471183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bpez1i/mxpQLXjVZcqTN8OadnNeAZwA7b+cKduVzbLM=;
  b=gCqxLudOgZymgUtfMRXFqA/2wicfvVMnUmOFYyf2R5wWwpLAwVDCzTCH
   9zuorFglKpQysarS3/q9t/LlG2u/kD2rYUgPGEMoqeQRAZf5nHtjylZcG
   M5mwPjk3EG7C0yMgL32WqYd01aK7PliVtfigN3BYzWvV2XLy4oGWlVKZe
   qUqVbspNDhIZyKN5QUn7ho3klhyJYxRJ+e/Bfaz6TelVTemMdOB1cozmj
   Ghg/0Xk6FrKe/+vrQs4yRWwlZ8pLKoXY1IlbYdy9ofPkMRbsZwRR1N2px
   z2EzK+/8Dh3Ct0rfGCXdRPQrJK/HIisCUBCIhb2s4gyJpWquan9YJLmeV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="381624196"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="381624196"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:51:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="877182911"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="877182911"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 10 Oct 2023 03:50:59 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DBE38386C1;
	Tue, 10 Oct 2023 11:50:56 +0100 (IST)
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
Subject: [PATCH net-next v1 4/8] bnxt_en: devlink health: use retained error fmsg API
Date: Tue, 10 Oct 2023 12:43:14 +0200
Message-Id: <20231010104318.3571791-5-przemyslaw.kitszel@intel.com>
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
add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-125 (-125)
---
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c | 59 ++++---------------
 1 file changed, 13 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 8b3e7697390f..fbe71d1b8d41 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -115,68 +115,42 @@ static int bnxt_fw_diagnose(struct devlink_health_reporter *reporter,
 	mutex_lock(&h->lock);
 	fw_status = bnxt_fw_health_readl(bp, BNXT_FW_HEALTH_REG);
 	if (BNXT_FW_IS_BOOTING(fw_status)) {
-		rc = devlink_fmsg_string_pair_put(fmsg, "Status", "initializing");
-		if (rc)
-			goto unlock;
+		devlink_fmsg_string_pair_put(fmsg, "Status", "initializing");
 	} else if (h->severity || fw_status != BNXT_FW_STATUS_HEALTHY) {
 		if (!h->severity) {
 			h->severity = SEVERITY_FATAL;
 			h->remedy = REMEDY_POWER_CYCLE_DEVICE;
 			h->diagnoses++;
 			devlink_health_report(h->fw_reporter,
 					      "FW error diagnosed", h);
 		}
-		rc = devlink_fmsg_string_pair_put(fmsg, "Status", "error");
-		if (rc)
-			goto unlock;
-		rc = devlink_fmsg_u32_pair_put(fmsg, "Syndrome", fw_status);
-		if (rc)
-			goto unlock;
+		devlink_fmsg_string_pair_put(fmsg, "Status", "error");
+		devlink_fmsg_u32_pair_put(fmsg, "Syndrome", fw_status);
 	} else {
-		rc = devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
-		if (rc)
-			goto unlock;
+		devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
 	}
 
 	rc = devlink_fmsg_string_pair_put(fmsg, "Severity",
 					  bnxt_health_severity_str(h->severity));
-	if (rc)
-		goto unlock;
 
 	if (h->severity) {
 		rc = devlink_fmsg_string_pair_put(fmsg, "Remedy",
 						  bnxt_health_remedy_str(h->remedy));
-		if (rc)
-			goto unlock;
-		if (h->remedy == REMEDY_DEVLINK_RECOVER) {
+		if (h->remedy == REMEDY_DEVLINK_RECOVER)
 			rc = devlink_fmsg_string_pair_put(fmsg, "Impact",
 							  "traffic+ntuple_cfg");
-			if (rc)
-				goto unlock;
-		}
 	}
 
-unlock:
 	mutex_unlock(&h->lock);
 	if (rc || !h->resets_reliable)
 		return rc;
 
 	fw_resets = bnxt_fw_health_readl(bp, BNXT_FW_RESET_CNT_REG);
-	rc = devlink_fmsg_u32_pair_put(fmsg, "Resets", fw_resets);
-	if (rc)
-		return rc;
-	rc = devlink_fmsg_u32_pair_put(fmsg, "Arrests", h->arrests);
-	if (rc)
-		return rc;
-	rc = devlink_fmsg_u32_pair_put(fmsg, "Survivals", h->survivals);
-	if (rc)
-		return rc;
-	rc = devlink_fmsg_u32_pair_put(fmsg, "Discoveries", h->discoveries);
-	if (rc)
-		return rc;
-	rc = devlink_fmsg_u32_pair_put(fmsg, "Fatalities", h->fatalities);
-	if (rc)
-		return rc;
+	devlink_fmsg_u32_pair_put(fmsg, "Resets", fw_resets);
+	devlink_fmsg_u32_pair_put(fmsg, "Arrests", h->arrests);
+	devlink_fmsg_u32_pair_put(fmsg, "Survivals", h->survivals);
+	devlink_fmsg_u32_pair_put(fmsg, "Discoveries", h->discoveries);
+	devlink_fmsg_u32_pair_put(fmsg, "Fatalities", h->fatalities);
 	return devlink_fmsg_u32_pair_put(fmsg, "Diagnoses", h->diagnoses);
 }
 
@@ -203,19 +177,12 @@ static int bnxt_fw_dump(struct devlink_health_reporter *reporter,
 
 	rc = bnxt_get_coredump(bp, BNXT_DUMP_LIVE, data, &dump_len);
 	if (!rc) {
-		rc = devlink_fmsg_pair_nest_start(fmsg, "core");
-		if (rc)
-			goto exit;
-		rc = devlink_fmsg_binary_pair_put(fmsg, "data", data, dump_len);
-		if (rc)
-			goto exit;
-		rc = devlink_fmsg_u32_pair_put(fmsg, "size", dump_len);
-		if (rc)
-			goto exit;
+		devlink_fmsg_pair_nest_start(fmsg, "core");
+		devlink_fmsg_binary_pair_put(fmsg, "data", data, dump_len);
+		devlink_fmsg_u32_pair_put(fmsg, "size", dump_len);
 		rc = devlink_fmsg_pair_nest_end(fmsg);
 	}
 
-exit:
 	vfree(data);
 	return rc;
 }
-- 
2.40.1


