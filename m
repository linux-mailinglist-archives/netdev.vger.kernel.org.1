Return-Path: <netdev+bounces-39507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3037BF90C
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA381C20B60
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E240FC00;
	Tue, 10 Oct 2023 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPFv21Db"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87699FBF8
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:53:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582E6AC
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 03:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696935179; x=1728471179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hlFtO2Iqrh8dAiY4kloq33W+nG5fKuo2T+2VxGcxC8U=;
  b=HPFv21DbBLVNF2zz/JtFRHnGIPKaCHkMCUs9ZTB99DAcLaKrVn8BZW5L
   NTUC3her8eqj5oo/Pb5XMxx4en+b9qA71mNDJ5GsBew9yC4WDQns8xiOT
   EcXTUAm7QYN4/j4tzuN5rDbUjYbEGcvI4Kwiqm/6q/7DyIu2N3fF67zPN
   o8IPVRRFEVdqwORUu8q56QuecumLvcfivKUPkuH8C33Z/mw6JUsxyhCXV
   56IhdHYVvVodd4RN3yvmY9lCatbRDbB/ulT1B9kgaj5E9F8A731ztdc3S
   bui3p06bbAl+/ol4kcd+ZeXaaiwXtJvBAI2UPIs0+A/AxdsvArqCBnl6g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="381624172"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="381624172"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:51:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="877182906"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="877182906"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 10 Oct 2023 03:50:58 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 22E3F38C9C;
	Tue, 10 Oct 2023 11:50:54 +0100 (IST)
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
Subject: [PATCH net-next v1 3/8] pds_core: devlink health: use retained error fmsg API
Date: Tue, 10 Oct 2023 12:43:13 +0200
Message-Id: <20231010104318.3571791-4-przemyslaw.kitszel@intel.com>
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
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-57 (-57)
---
 drivers/net/ethernet/amd/pds_core/devlink.c | 27 ++++++---------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index d9607033bbf2..fcb407bdb25e 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -154,33 +154,20 @@ int pdsc_fw_reporter_diagnose(struct devlink_health_reporter *reporter,
 			      struct netlink_ext_ack *extack)
 {
 	struct pdsc *pdsc = devlink_health_reporter_priv(reporter);
-	int err;
 
 	mutex_lock(&pdsc->config_lock);
-
 	if (test_bit(PDSC_S_FW_DEAD, &pdsc->state))
-		err = devlink_fmsg_string_pair_put(fmsg, "Status", "dead");
+		devlink_fmsg_string_pair_put(fmsg, "Status", "dead");
 	else if (!pdsc_is_fw_good(pdsc))
-		err = devlink_fmsg_string_pair_put(fmsg, "Status", "unhealthy");
+		devlink_fmsg_string_pair_put(fmsg, "Status", "unhealthy");
 	else
-		err = devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
-
+		devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
 	mutex_unlock(&pdsc->config_lock);
 
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "State",
-					pdsc->fw_status &
-						~PDS_CORE_FW_STS_F_GENERATION);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_pair_put(fmsg, "Generation",
-					pdsc->fw_generation >> 4);
-	if (err)
-		return err;
-
+	devlink_fmsg_u32_pair_put(fmsg, "State",
+				  pdsc->fw_status & ~PDS_CORE_FW_STS_F_GENERATION);
+	devlink_fmsg_u32_pair_put(fmsg, "Generation", pdsc->fw_generation >> 4);
 	return devlink_fmsg_u32_pair_put(fmsg, "Recoveries",
 					 pdsc->fw_recoveries);
+
 }
-- 
2.40.1


