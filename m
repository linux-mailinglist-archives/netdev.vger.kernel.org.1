Return-Path: <netdev+bounces-23371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B6876BB7E
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 19:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED7A1C2108B
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F7E25164;
	Tue,  1 Aug 2023 17:37:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED97A253C8
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 17:37:48 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EE41708
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690911467; x=1722447467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XwfjhEGyMYvR9ai6kEKgQv4N0rK0INtMUCIILuw7h2w=;
  b=EVOdBJUzLiBVXOFRv99JGc8TgkaR8pbxMF2WcpjG/3/SnSWLaVtYzHS5
   K+h4fq1gM9hLwIpAGEaVyS4VUKqBv87VbFyox//R/vw8aiVlRHCKKb9m1
   Y53z54oE434AqeeDJdCz4CEgwm2KqdEQhcx/wHHz93DWn4Ka+n7DzK92c
   4UzVYKOyi5L6FBIWzLhlBoBfla4G33RweO4UkSDI7QazxBMGLskJuQK0j
   2LpocOO0n6gatONoAkISbBVDZG9PLrQP/AAjVsS+MmIqLDGiEqndABYYI
   Gx1DkztG7QhkTDQP89yqhAPbyZ5f5E89WRRzH2jKCWNB0DN+k+V+zsk7t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="455740699"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="455740699"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 10:37:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="798769706"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="798769706"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga004.fm.intel.com with ESMTP; 01 Aug 2023 10:37:35 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jan Sokolowski <jan.sokolowski@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 6/7] ice: add FW load wait
Date: Tue,  1 Aug 2023 10:31:11 -0700
Message-Id: <20230801173112.3625977-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230801173112.3625977-1-anthony.l.nguyen@intel.com>
References: <20230801173112.3625977-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jan Sokolowski <jan.sokolowski@intel.com>

As some cards load FW from external sources, we have to wait
to be sure that FW is ready before setting link up.

Add check and wait for FW readiness

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  2 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 37 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index a92dc9a16035..fb590b4c1053 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -335,6 +335,8 @@
 #define VP_MDET_TX_TCLAN_VALID_M		BIT(0)
 #define VP_MDET_TX_TDPU(_VF)			(0x00040000 + ((_VF) * 4))
 #define VP_MDET_TX_TDPU_VALID_M			BIT(0)
+#define GL_MNG_FWSM				0x000B6134
+#define GL_MNG_FWSM_FW_LOADING_M		BIT(30)
 #define GLNVM_FLA				0x000B6108
 #define GLNVM_FLA_LOCKED_M			BIT(6)
 #define GLNVM_GENS				0x000B6100
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 20d5ed572a8c..964edf4b8b33 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4520,6 +4520,31 @@ static void ice_deinit_eth(struct ice_pf *pf)
 	ice_decfg_netdev(vsi);
 }
 
+/**
+ * ice_wait_for_fw - wait for full FW readiness
+ * @hw: pointer to the hardware structure
+ * @timeout: milliseconds that can elapse before timing out
+ */
+static int ice_wait_for_fw(struct ice_hw *hw, u32 timeout)
+{
+	int fw_loading;
+	u32 elapsed = 0;
+
+	while (elapsed <= timeout) {
+		fw_loading = rd32(hw, GL_MNG_FWSM) & GL_MNG_FWSM_FW_LOADING_M;
+
+		/* firmware was not yet loaded, we have to wait more */
+		if (fw_loading) {
+			elapsed += 100;
+			msleep(100);
+			continue;
+		}
+		return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
 static int ice_init_dev(struct ice_pf *pf)
 {
 	struct device *dev = ice_pf_to_dev(pf);
@@ -4532,6 +4557,18 @@ static int ice_init_dev(struct ice_pf *pf)
 		return err;
 	}
 
+	/* Some cards require longer initialization times
+	 * due to necessity of loading FW from an external source.
+	 * This can take even half a minute.
+	 */
+	if (ice_is_pf_c827(hw)) {
+		err = ice_wait_for_fw(hw, 30000);
+		if (err) {
+			dev_err(dev, "ice_wait_for_fw timed out");
+			return err;
+		}
+	}
+
 	ice_init_feature_support(pf);
 
 	ice_request_fw(pf);
-- 
2.38.1


