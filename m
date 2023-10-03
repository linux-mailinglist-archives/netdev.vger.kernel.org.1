Return-Path: <netdev+bounces-37766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6AB7B7104
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 20:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 10C16281366
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 18:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF4C3C6A7;
	Tue,  3 Oct 2023 18:36:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7967A36AF5
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 18:36:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5215AF
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696358181; x=1727894181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=50uTpvppzbHW/LgPOYCEhbC77cKO8kPbxDdP0gYnzbA=;
  b=nJ9C8oVFh6fRS2WBbKC/8ynIG76YiAeZ2AtfnEmAjHxA859PLgt/12TK
   t+9lJ62kE/KkiyqLhjbK9bzD/Iz2jthUj6ZNVVP5pDlmAx+Fm+pe/Uloj
   tIMdQ9MmgtXko9smN020K5ErFFap8msmdGxJILbnQeG5lIlChFOypJxtr
   t6G/sM0nHyRNrAdj+Gi93JE06jeiXEP3Et20r8HudzV8dJOrV6k56d7Dm
   AkEmlr4FxZaYwl7GvYuafijIMxvL9BuyRftZMazUMALstDAzh5IrmtBMt
   vfiCrGAfXRWJX4r1puIi73JGj5YgXscAxhiqpbkzh+3EHRP28Nig8mJEt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="4516713"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="4516713"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 11:36:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="874786505"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="874786505"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 11:36:18 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH iwl-next v1 1/2] intel: fix string truncation warnings
Date: Tue,  3 Oct 2023 11:36:02 -0700
Message-Id: <20231003183603.3887546-2-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231003183603.3887546-1-jesse.brandeburg@intel.com>
References: <20231003183603.3887546-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix -Wformat-truncated warnings to complete the intel directories' W=1
clean efforts. The W=1 recently got enhanced with a few new flags and
this brought up some new warnings.

Switch to using kasprintf() when possible so we always allocate the
right length strings.

summary of warnings:
drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1425:60: warning: ‘%s’ directive output may be truncated writing 4 bytes into a region of size between 1 and 11 [-Wformat-truncation=]
drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1425:17: note: ‘snprintf’ output between 7 and 17 bytes into a destination of size 13
drivers/net/ethernet/intel/ice/ice_ptp.c:43:27: warning: ‘%s’ directive output may be truncated writing up to 479 bytes into a region of size 64 [-Wformat-truncation=]
drivers/net/ethernet/intel/ice/ice_ptp.c:42:17: note: ‘snprintf’ output between 1 and 480 bytes into a destination of size 64
drivers/net/ethernet/intel/igb/igb_main.c:3092:53: warning: ‘%d’ directive output may be truncated writing between 1 and 5 bytes into a region of size between 1 and 13 [-Wformat-truncation=]
drivers/net/ethernet/intel/igb/igb_main.c:3092:34: note: directive argument in the range [0, 65535]
drivers/net/ethernet/intel/igb/igb_main.c:3092:34: note: directive argument in the range [0, 65535]
drivers/net/ethernet/intel/igb/igb_main.c:3090:25: note: ‘snprintf’ output between 23 and 43 bytes into a destination of size 32

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
I thought this was fine to go to -next since there isn't really urgency
to drive this change.
---
/linux/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c: In function ‘iavf_virtchnl_completion’:
/linux/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1425:60: warning: ‘%s’ directive output may be truncated writing 4 bytes into a region of size between 1 and 11 [-Wformat-truncation=]
 1425 |                 snprintf(speed, IAVF_MAX_SPEED_STRLEN, "%d %s",
      |                                                            ^~
 1426 |                          link_speed_mbps, "Mbps");
      |                                           ~~~~~~
/linux/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1425:17: note: ‘snprintf’ output between 7 and 17 bytes into a destination of size 13
 1425 |                 snprintf(speed, IAVF_MAX_SPEED_STRLEN, "%d %s",
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1426 |                          link_speed_mbps, "Mbps");
      |                          ~~~~~~~~~~~~~~~~~~~~~~~~
/linux/drivers/net/ethernet/intel/ice/ice_ptp.c: In function ‘ice_get_sma_config_e810t’:
/linux/drivers/net/ethernet/intel/ice/ice_ptp.c:43:27: warning: ‘%s’ directive output may be truncated writing up to 479 bytes into a region of size 64 [-Wformat-truncation=]
   43 |                          "%s", ice_pin_desc_e810t[i].name);
      |                           ^~
/linux/drivers/net/ethernet/intel/ice/ice_ptp.c:42:17: note: ‘snprintf’ output between 1 and 480 bytes into a destination of size 64
   42 |                 snprintf(ptp_pins[i].name, sizeof(ptp_pins[i].name),
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   43 |                          "%s", ice_pin_desc_e810t[i].name);
      |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/linux/drivers/net/ethernet/intel/igb/igb_main.c: In function ‘igb_set_fw_version’:
/linux/drivers/net/ethernet/intel/igb/igb_main.c:3092:53: warning: ‘%d’ directive output may be truncated writing between 1 and 5 bytes into a region of size between 1 and 13 [-Wformat-truncation=]
 3092 |                                  "%d.%d, 0x%08x, %d.%d.%d",
      |                                                     ^~
/linux/drivers/net/ethernet/intel/igb/igb_main.c:3092:34: note: directive argument in the range [0, 65535]
 3092 |                                  "%d.%d, 0x%08x, %d.%d.%d",
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
/linux/drivers/net/ethernet/intel/igb/igb_main.c:3092:34: note: directive argument in the range [0, 65535]
/linux/drivers/net/ethernet/intel/igb/igb_main.c:3090:25: note: ‘snprintf’ output between 23 and 43 bytes into a destination of size 32
 3090 |                         snprintf(adapter->fw_version,
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 3091 |                                  sizeof(adapter->fw_version),
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 3092 |                                  "%d.%d, 0x%08x, %d.%d.%d",
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~
 3093 |                                  fw.eep_major, fw.eep_minor, fw.etrack_id,
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 3094 |                                  fw.or_major, fw.or_build, fw.or_patch);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
---
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  4 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 22 ++++-------
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  4 +-
 drivers/net/ethernet/intel/igb/igb_main.c     | 37 +++++++++----------
 4 files changed, 30 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 90397293525f..9246172c9c33 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -396,8 +396,8 @@ static void iavf_get_priv_flag_strings(struct net_device *netdev, u8 *data)
 	unsigned int i;
 
 	for (i = 0; i < IAVF_PRIV_FLAGS_STR_LEN; i++) {
-		snprintf(data, ETH_GSTRING_LEN, "%s",
-			 iavf_gstrings_priv_flags[i].flag_string);
+		strscpy(data, iavf_gstrings_priv_flags[i].flag_string,
+			ETH_GSTRING_LEN);
 		data += ETH_GSTRING_LEN;
 	}
 }
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 8ce6389b5815..82b84a93bcc8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1378,8 +1378,6 @@ void iavf_disable_vlan_insertion_v2(struct iavf_adapter *adapter, u16 tpid)
 				  VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2);
 }
 
-#define IAVF_MAX_SPEED_STRLEN	13
-
 /**
  * iavf_print_link_message - print link up or down
  * @adapter: adapter structure
@@ -1397,10 +1395,6 @@ static void iavf_print_link_message(struct iavf_adapter *adapter)
 		return;
 	}
 
-	speed = kzalloc(IAVF_MAX_SPEED_STRLEN, GFP_KERNEL);
-	if (!speed)
-		return;
-
 	if (ADV_LINK_SUPPORT(adapter)) {
 		link_speed_mbps = adapter->link_speed_mbps;
 		goto print_link_msg;
@@ -1438,17 +1432,17 @@ static void iavf_print_link_message(struct iavf_adapter *adapter)
 
 print_link_msg:
 	if (link_speed_mbps > SPEED_1000) {
-		if (link_speed_mbps == SPEED_2500)
-			snprintf(speed, IAVF_MAX_SPEED_STRLEN, "2.5 Gbps");
-		else
+		if (link_speed_mbps == SPEED_2500) {
+			speed = kasprintf(GFP_KERNEL, "%s", "2.5 Gbps");
+		} else {
 			/* convert to Gbps inline */
-			snprintf(speed, IAVF_MAX_SPEED_STRLEN, "%d %s",
-				 link_speed_mbps / 1000, "Gbps");
+			speed = kasprintf(GFP_KERNEL, "%d Gbps",
+					  link_speed_mbps / 1000);
+		}
 	} else if (link_speed_mbps == SPEED_UNKNOWN) {
-		snprintf(speed, IAVF_MAX_SPEED_STRLEN, "%s", "Unknown Mbps");
+		speed = kasprintf(GFP_KERNEL, "%s", "Unknown Mbps");
 	} else {
-		snprintf(speed, IAVF_MAX_SPEED_STRLEN, "%d %s",
-			 link_speed_mbps, "Mbps");
+		speed = kasprintf(GFP_KERNEL, "%d Mbps", link_speed_mbps);
 	}
 
 	netdev_info(netdev, "NIC Link is Up Speed is %s Full Duplex\n", speed);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 5293df2d57a8..1eddcbe89b0c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -39,8 +39,8 @@ ice_get_sma_config_e810t(struct ice_hw *hw, struct ptp_pin_desc *ptp_pins)
 
 	/* initialize with defaults */
 	for (i = 0; i < NUM_PTP_PINS_E810T; i++) {
-		snprintf(ptp_pins[i].name, sizeof(ptp_pins[i].name),
-			 "%s", ice_pin_desc_e810t[i].name);
+		strscpy(ptp_pins[i].name, ice_pin_desc_e810t[i].name,
+			sizeof(ptp_pins[i].name));
 		ptp_pins[i].index = ice_pin_desc_e810t[i].index;
 		ptp_pins[i].func = ice_pin_desc_e810t[i].func;
 		ptp_pins[i].chan = ice_pin_desc_e810t[i].chan;
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 2ac9dffd0bf8..fdadf3e84f59 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3069,6 +3069,7 @@ void igb_set_fw_version(struct igb_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	struct e1000_fw_version fw;
+	char *lbuf;
 
 	igb_get_fw_version(hw, &fw);
 
@@ -3076,36 +3077,34 @@ void igb_set_fw_version(struct igb_adapter *adapter)
 	case e1000_i210:
 	case e1000_i211:
 		if (!(igb_get_flash_presence_i210(hw))) {
-			snprintf(adapter->fw_version,
-				 sizeof(adapter->fw_version),
-				 "%2d.%2d-%d",
-				 fw.invm_major, fw.invm_minor,
-				 fw.invm_img_type);
+			lbuf = kasprintf(GFP_KERNEL, "%2d.%2d-%d",
+					 fw.invm_major, fw.invm_minor,
+					 fw.invm_img_type);
 			break;
 		}
 		fallthrough;
 	default:
-		/* if option is rom valid, display its version too */
+		/* if option rom is valid, display its version too */
 		if (fw.or_valid) {
-			snprintf(adapter->fw_version,
-				 sizeof(adapter->fw_version),
-				 "%d.%d, 0x%08x, %d.%d.%d",
-				 fw.eep_major, fw.eep_minor, fw.etrack_id,
-				 fw.or_major, fw.or_build, fw.or_patch);
+			lbuf = kasprintf(GFP_KERNEL, "%d.%d, 0x%08x, %d.%d.%d",
+					 fw.eep_major, fw.eep_minor,
+					 fw.etrack_id, fw.or_major, fw.or_build,
+					 fw.or_patch);
 		/* no option rom */
 		} else if (fw.etrack_id != 0X0000) {
-			snprintf(adapter->fw_version,
-			    sizeof(adapter->fw_version),
-			    "%d.%d, 0x%08x",
-			    fw.eep_major, fw.eep_minor, fw.etrack_id);
+			lbuf = kasprintf(GFP_KERNEL, "%d.%d, 0x%08x",
+					 fw.eep_major, fw.eep_minor,
+					 fw.etrack_id);
 		} else {
-		snprintf(adapter->fw_version,
-		    sizeof(adapter->fw_version),
-		    "%d.%d.%d",
-		    fw.eep_major, fw.eep_minor, fw.eep_build);
+			lbuf = kasprintf(GFP_KERNEL, "%d.%d.%d", fw.eep_major,
+					 fw.eep_minor, fw.eep_build);
 		}
 		break;
 	}
+
+	/* the truncate happens here if it doesn't fit */
+	strscpy(adapter->fw_version, lbuf, sizeof(adapter->fw_version));
+	kfree(lbuf);
 }
 
 /**

base-commit: e643597346c72ebb961ee79ebec34acc042e8ac2
-- 
2.39.3


