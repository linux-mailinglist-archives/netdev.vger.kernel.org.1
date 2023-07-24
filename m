Return-Path: <netdev+bounces-20330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDFC75F171
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8D42814EB
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F4D79F1;
	Mon, 24 Jul 2023 09:51:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74AE748A
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:51:21 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A75D59CD
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690192262; x=1721728262;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OioHk1ChN5JiT7QsVymWpXuiBzyoD3qR9bpeqjbMExQ=;
  b=T99Tah0Gi+ulJvMBzhKx19XcPOETSG4YZAblyU51szAsPKJxJLQ62To6
   OtgZpmidWFHSuc1oI8l4mJ1y3muZKYJqfVeW2S8wYh6gOg3ht4t7CmBOY
   8DFlq6aNFCqfnP2e8PXDAtbaFkPiEyoplrODrJvucLIcrsdnYkv9jv0ie
   DWitvv5GCcdK/wfV3uVlvRKhXO8gHzDDwYKy51PDb7blg1Wo7H9HF0xnr
   tEjECHqlak3Jv4O40Ytf30sXfaFOxVXA5TCWHjPI5ykZS1MwMnPx0SO1P
   nyG7gVM8DXAMd62iOA3sb2VvU0qgClqC8W64w2+r8VeijM0VCvl6Mp3MQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="367423349"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="367423349"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 02:50:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="795709749"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="795709749"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2023 02:50:20 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	Grzegorz Szczurek <grzegorzx.szczurek@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v1] i40e: Clear stats after deleting tc
Date: Mon, 24 Jul 2023 11:43:19 +0200
Message-Id: <20230724094319.57359-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>

There was an issue with ethtool stats that
have not been cleared after tc had been deleted.

Fix this by resetting stats after deleting tc
by calling i40e_vsi_reset_stats() function after
distroying qdisc.

Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 29ad1797adce..6f604bfe7437 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5885,6 +5885,11 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
 
 	/* Update the netdev TC setup */
 	i40e_vsi_config_netdev_tc(vsi, enabled_tc);
+
+	/* After distroying qdisc reset all stats of the vsi */
+	if (!vsi->mqprio_qopt.qopt.hw)
+		i40e_vsi_reset_stats(vsi);
+
 out:
 	return ret;
 }
-- 
2.31.1


