Return-Path: <netdev+bounces-41866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1C27CC12F
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB22281AC0
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E9F4123D;
	Tue, 17 Oct 2023 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FaJouv6w"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF2741226
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 10:54:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927A4191;
	Tue, 17 Oct 2023 03:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697540083; x=1729076083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ykBbT/V5s6xuzCf7Q0Ibo9y525QLhIA0rV2N995s/U=;
  b=FaJouv6wkiCs/fTEQ2oDNdkmsiy/L4SYN7G0YQL2slnB4U+W8Sws7Bmy
   8yd6K0eiJ4KD12BIBaHZfctHbd6U63tuclf+NKmWu7Qzz1gnRYdjv3NFi
   ADhWxjxjl5MkHLF9FuO50qqRIz5WimwCUJTIiZ4euGpQA0KNqvVlolKxc
   uRPS6eiGP+0H+jYrVZa0zs2uEgl/R3T+JbxTNDg/X+FIYshO98WxR9o6G
   MZoMNjXSBJtlENB4sQRtchyAdyTUZ75XxyASOiZHmjfx8vx2g5LNkfx6g
   MiJIhIhiqi3L00Tu8i1yZYqu/HeZG7K2NfaUcxVjkByTA6/AlUnIT4wSv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="366012757"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="366012757"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 03:54:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785445364"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="785445364"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2023 03:54:36 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6BF45312DE;
	Tue, 17 Oct 2023 11:54:33 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	George Cherian <george.cherian@marvell.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	Coiby Xu <coiby.xu@gmail.com>
Cc: Brett Creeley <brett.creeley@amd.com>,
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
	linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 10/11] staging: qlge: devlink health: use retained error fmsg API
Date: Tue, 17 Oct 2023 12:53:40 +0200
Message-Id: <20231017105341.415466-11-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Drop unneeded error checking.

devlink_fmsg_*() family of functions is now retaining errors,
so there is no need to check for them after each call.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/staging/qlge/qlge_devlink.c | 60 ++++++++---------------------
 1 file changed, 16 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/qlge/qlge_devlink.c b/drivers/staging/qlge/qlge_devlink.c
index 0ab02d6d3817..0b19363ca2e9 100644
--- a/drivers/staging/qlge/qlge_devlink.c
+++ b/drivers/staging/qlge/qlge_devlink.c
@@ -2,51 +2,29 @@
 #include "qlge.h"
 #include "qlge_devlink.h"
 
-static int qlge_fill_seg_(struct devlink_fmsg *fmsg,
-			  struct mpi_coredump_segment_header *seg_header,
-			  u32 *reg_data)
+static void qlge_fill_seg_(struct devlink_fmsg *fmsg,
+			   struct mpi_coredump_segment_header *seg_header,
+			   u32 *reg_data)
 {
 	int regs_num = (seg_header->seg_size
 			- sizeof(struct mpi_coredump_segment_header)) / sizeof(u32);
-	int err;
 	int i;
 
-	err = devlink_fmsg_pair_nest_start(fmsg, seg_header->description);
-	if (err)
-		return err;
-	err = devlink_fmsg_obj_nest_start(fmsg);
-	if (err)
-		return err;
-	err = devlink_fmsg_u32_pair_put(fmsg, "segment", seg_header->seg_num);
-	if (err)
-		return err;
-	err = devlink_fmsg_arr_pair_nest_start(fmsg, "values");
-	if (err)
-		return err;
+	devlink_fmsg_pair_nest_start(fmsg, seg_header->description);
+	devlink_fmsg_obj_nest_start(fmsg);
+	devlink_fmsg_u32_pair_put(fmsg, "segment", seg_header->seg_num);
+	devlink_fmsg_arr_pair_nest_start(fmsg, "values");
 	for (i = 0; i < regs_num; i++) {
-		err = devlink_fmsg_u32_put(fmsg, *reg_data);
-		if (err)
-			return err;
+		devlink_fmsg_u32_put(fmsg, *reg_data);
 		reg_data++;
 	}
-	err = devlink_fmsg_obj_nest_end(fmsg);
-	if (err)
-		return err;
-	err = devlink_fmsg_arr_pair_nest_end(fmsg);
-	if (err)
-		return err;
-	err = devlink_fmsg_pair_nest_end(fmsg);
-	return err;
+	devlink_fmsg_obj_nest_end(fmsg);
+	devlink_fmsg_arr_pair_nest_end(fmsg);
+	devlink_fmsg_pair_nest_end(fmsg);
 }
 
-#define FILL_SEG(seg_hdr, seg_regs)			                    \
-	do {                                                                \
-		err = qlge_fill_seg_(fmsg, &dump->seg_hdr, dump->seg_regs); \
-		if (err) {					            \
-			kvfree(dump);                                       \
-			return err;				            \
-		}                                                           \
-	} while (0)
+#define FILL_SEG(seg_hdr, seg_regs) \
+	qlge_fill_seg_(fmsg, &dump->seg_hdr, dump->seg_regs)
 
 static int qlge_reporter_coredump(struct devlink_health_reporter *reporter,
 				  struct devlink_fmsg *fmsg, void *priv_ctx,
@@ -114,14 +92,8 @@ static int qlge_reporter_coredump(struct devlink_health_reporter *reporter,
 	FILL_SEG(xfi_hss_tx_hdr, serdes_xfi_hss_tx);
 	FILL_SEG(xfi_hss_rx_hdr, serdes_xfi_hss_rx);
 	FILL_SEG(xfi_hss_pll_hdr, serdes_xfi_hss_pll);
-
-	err = qlge_fill_seg_(fmsg, &dump->misc_nic_seg_hdr,
-			     (u32 *)&dump->misc_nic_info);
-	if (err) {
-		kvfree(dump);
-		return err;
-	}
-
+	qlge_fill_seg_(fmsg, &dump->misc_nic_seg_hdr,
+		       (u32 *)&dump->misc_nic_info);
 	FILL_SEG(intr_states_seg_hdr, intr_states);
 	FILL_SEG(cam_entries_seg_hdr, cam_entries);
 	FILL_SEG(nic_routing_words_seg_hdr, nic_routing_words);
@@ -140,7 +112,7 @@ static int qlge_reporter_coredump(struct devlink_health_reporter *reporter,
 	FILL_SEG(sem_regs_seg_hdr, sem_regs);
 
 	kvfree(dump);
-	return err;
+	return 0;
 }
 
 static const struct devlink_health_reporter_ops qlge_reporter_ops = {
-- 
2.40.1


