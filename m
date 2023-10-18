Return-Path: <netdev+bounces-42398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6E87CE8E0
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 22:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F2E28264A
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073E73DFEF;
	Wed, 18 Oct 2023 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdlENQ/N"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960403DFE6
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 20:29:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F64B19B;
	Wed, 18 Oct 2023 13:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697660951; x=1729196951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PZ8f3OZuezOZo142PHMaLRSZJL/PRKIZGCjiSFaWGRc=;
  b=gdlENQ/Nos8jCYrBcT1Yd+/i4iDotNS1XJiYbIExemGlNKACPEMT/6Rf
   +euzMMLTfRa7EVhqDfMLpl+o6W3deoxSw3nxvdcUcx0mb28kR4I0v9FSc
   0yLg0pMSCaCMG+BvIH0cbSogzEolDGGSp+CfvyrJUSpzFXjCFJZB11G2F
   T6sx0/ylcJT8hLagNYHDri1h8fBoqJLq0ijqNwbuPFYhgXoL9bkS5lJRk
   OP05eOHtEV3hAPn5EI4z4Zvwnjtq7HG7/8LzMjbWc9+ottozraQpSRsVl
   KDIUnmeFViTv4Z0z6moqsX2Lf80nBH4S2gAiTcj+G0Xk8wVDkcvEwttfQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="389984432"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="389984432"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 13:28:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1003937708"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="1003937708"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga006.fm.intel.com with ESMTP; 18 Oct 2023 13:28:15 -0700
Received: from pkitszel-desk.intel.com (unknown [10.255.194.180])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 3880A33BF5;
	Wed, 18 Oct 2023 21:28:09 +0100 (IST)
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
	Coiby Xu <coiby.xu@gmail.com>,
	Simon Horman <horms@kernel.org>
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
	Benjamin Poirier <bpoirier@suse.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v3 09/11] qed: devlink health: use retained error fmsg API
Date: Wed, 18 Oct 2023 22:26:45 +0200
Message-Id: <20231018202647.44769-10-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
References: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop unneeded error checking.

devlink_fmsg_*() family of functions is now retaining errors,
so there is no need to check for them after each call.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-2 (-2)
---
 drivers/net/ethernet/qlogic/qed/qed_devlink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_devlink.c b/drivers/net/ethernet/qlogic/qed/qed_devlink.c
index be5cc8b79bd5..dad8e617c393 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_devlink.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_devlink.c
@@ -66,12 +66,12 @@ qed_fw_fatal_reporter_dump(struct devlink_health_reporter *reporter,
 		return err;
 	}
 
-	err = devlink_fmsg_binary_pair_put(fmsg, "dump_data",
-					   p_dbg_data_buf, dbg_data_buf_size);
+	devlink_fmsg_binary_pair_put(fmsg, "dump_data", p_dbg_data_buf,
+				     dbg_data_buf_size);
 
 	vfree(p_dbg_data_buf);
 
-	return err;
+	return 0;
 }
 
 static int
-- 
2.38.1


