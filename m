Return-Path: <netdev+bounces-37767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3D77B7105
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 20:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A84B4281679
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 18:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCFD36AF5;
	Tue,  3 Oct 2023 18:36:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA633C6A4
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 18:36:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DF4B0
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696358181; x=1727894181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vLNQw5vUoKVEkuo2dxFseegUK+bNnKUQmgs4VSrKwJU=;
  b=GnG+4kb5BoBsx24UrDtmoHT858QhVvWrLNNMw7GhOasGdfWkBwW8Sh2P
   MdK7yoPfSmzlkAX3eYblnzb9p5UQzQLeOTIi2VqUX0ypDz+m0bRw6kp7l
   ZQ4bfXB585Kn3lgzPRLl25hRMtvgTCIXu1cWb8xlrf69zigrx2uDh3I/e
   iGY7k/252emdJxqyXkjaYG5BWsWwG7F9sDnFZYzaUhYAhQ12PPFLl49Fx
   ElPnehI/o/2BIAIn1hoVJUw5B+Iyb5U5y5T6JxVn7kDsK6ucL+fbj7Ks1
   klt2aV+2dpVlCVWuXgcTZBBo1oTFe2u0ji6f0socF5mQYRC5ntsXwSyHJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="4516717"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="4516717"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 11:36:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="874786508"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="874786508"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 11:36:18 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH iwl-next v1 2/2] intel: fix format warnings
Date: Tue,  3 Oct 2023 11:36:03 -0700
Message-Id: <20231003183603.3887546-3-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231003183603.3887546-1-jesse.brandeburg@intel.com>
References: <20231003183603.3887546-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Get ahead of the game and fix all the -Wformat=2 noted warnings in the
intel drivers directory.

There are one set of i40e and iavf warnings I couldn't figure out how to
fix because the driver is already using vsnprintf without an explicit
"const char *" format string.

Tested with both gcc-12 and clang-15. I found gcc-12 runs clean after
this series but clang-15 is a little worried about the vsnprintf lines.

summary of warnings:

drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c:148:34: warning: format string is not a string literal [-Wformat-nonliteral]
drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1416:24: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1416:24: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1421:6: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1421:6: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/igc/igc_ethtool.c:776:24: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/igc/igc_ethtool.c:776:24: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/igc/igc_ethtool.c:779:6: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/igc/igc_ethtool.c:779:6: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/iavf/iavf_ethtool.c:199:34: warning: format string is not a string literal [-Wformat-nonliteral]
drivers/net/ethernet/intel/igb/igb_ethtool.c:2360:6: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/igb/igb_ethtool.c:2360:6: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/igb/igb_ethtool.c:2363:6: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/igb/igb_ethtool.c:2363:6: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:208:34: warning: format string is not a string literal [-Wformat-nonliteral]
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2515:23: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2515:23: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2519:23: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2519:23: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/ice/ice_ethtool.c:1064:6: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/ice/ice_ethtool.c:1064:6: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/ice/ice_ethtool.c:1084:6: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/ice/ice_ethtool.c:1084:6: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/ice/ice_ethtool.c:1100:24: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/ice/ice_ethtool.c:1100:24: note: treat the string as an argument to avoid this

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
clang-15 warnings before the patch:

drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c:148:34: warning: format string is not a string literal [-Wformat-nonliteral]
                vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
                                               ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1416:24: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
                        ethtool_sprintf(&p, ixgbe_gstrings_test[i]);
                                            ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1416:24: note: treat the string as an argument to avoid this
                        ethtool_sprintf(&p, ixgbe_gstrings_test[i]);
                                            ^
                                            "%s",
drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1421:6: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
                                        ixgbe_gstrings_stats[i].stat_string);
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1421:6: note: treat the string as an argument to avoid this
                                        ixgbe_gstrings_stats[i].stat_string);
                                        ^
                                        "%s",
drivers/net/ethernet/intel/igc/igc_ethtool.c:776:24: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
                        ethtool_sprintf(&p, igc_gstrings_stats[i].stat_string);
                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/igc/igc_ethtool.c:776:24: note: treat the string as an argument to avoid this
                        ethtool_sprintf(&p, igc_gstrings_stats[i].stat_string);
                                            ^
                                            "%s",
drivers/net/ethernet/intel/igc/igc_ethtool.c:779:6: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
                                        igc_gstrings_net_stats[i].stat_string);
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/igc/igc_ethtool.c:779:6: note: treat the string as an argument to avoid this
                                        igc_gstrings_net_stats[i].stat_string);
                                        ^
                                        "%s",
drivers/net/ethernet/intel/iavf/iavf_ethtool.c:199:34: warning: format string is not a string literal [-Wformat-nonliteral]
                vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
                                               ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/igb/igb_ethtool.c:2360:6: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
                                        igb_gstrings_stats[i].stat_string);
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/igb/igb_ethtool.c:2360:6: note: treat the string as an argument to avoid this
                                        igb_gstrings_stats[i].stat_string);
                                        ^
                                        "%s",
drivers/net/ethernet/intel/igb/igb_ethtool.c:2363:6: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
                                        igb_gstrings_net_stats[i].stat_string);
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/igb/igb_ethtool.c:2363:6: note: treat the string as an argument to avoid this
                                        igb_gstrings_net_stats[i].stat_string);
                                        ^
                                        "%s",
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:208:34: warning: format string is not a string literal [-Wformat-nonliteral]
                vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
                                               ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2515:23: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
                ethtool_sprintf(&p, i40e_gstrings_priv_flags[i].flag_string);
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2515:23: note: treat the string as an argument to avoid this
                ethtool_sprintf(&p, i40e_gstrings_priv_flags[i].flag_string);
                                    ^
                                    "%s",
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2519:23: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
                ethtool_sprintf(&p, i40e_gl_gstrings_priv_flags[i].flag_string);
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2519:23: note: treat the string as an argument to avoid this
                ethtool_sprintf(&p, i40e_gl_gstrings_priv_flags[i].flag_string);
                                    ^
                                    "%s",
drivers/net/ethernet/intel/ice/ice_ethtool.c:1064:6: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
                                        ice_gstrings_vsi_stats[i].stat_string);
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ice/ice_ethtool.c:1064:6: note: treat the string as an argument to avoid this
                                        ice_gstrings_vsi_stats[i].stat_string);
                                        ^
                                        "%s",
drivers/net/ethernet/intel/ice/ice_ethtool.c:1084:6: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
                                        ice_gstrings_pf_stats[i].stat_string);
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ice/ice_ethtool.c:1084:6: note: treat the string as an argument to avoid this
                                        ice_gstrings_pf_stats[i].stat_string);
                                        ^
                                        "%s",
drivers/net/ethernet/intel/ice/ice_ethtool.c:1100:24: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
                        ethtool_sprintf(&p, ice_gstrings_priv_flags[i].name);
                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ice/ice_ethtool.c:1100:24: note: treat the string as an argument to avoid this
                        ethtool_sprintf(&p, ice_gstrings_priv_flags[i].name);
                                            ^
                                            "%s",
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c   | 6 ++++--
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c   | 8 +++-----
 drivers/net/ethernet/intel/ice/ice_ethtool.c     | 7 ++++---
 drivers/net/ethernet/intel/igb/igb_ethtool.c     | 4 ++--
 drivers/net/ethernet/intel/igc/igc_ethtool.c     | 5 +++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 4 ++--
 6 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index bd1321bf7e26..1d57225eeefc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2512,11 +2512,13 @@ static void i40e_get_priv_flag_strings(struct net_device *netdev, u8 *data)
 	u8 *p = data;
 
 	for (i = 0; i < I40E_PRIV_FLAGS_STR_LEN; i++)
-		ethtool_sprintf(&p, i40e_gstrings_priv_flags[i].flag_string);
+		ethtool_sprintf(&p, "%s",
+				i40e_gstrings_priv_flags[i].flag_string);
 	if (pf->hw.pf_id != 0)
 		return;
 	for (i = 0; i < I40E_GL_PRIV_FLAGS_STR_LEN; i++)
-		ethtool_sprintf(&p, i40e_gl_gstrings_priv_flags[i].flag_string);
+		ethtool_sprintf(&p, "%s",
+				i40e_gl_gstrings_priv_flags[i].flag_string);
 }
 
 static void i40e_get_strings(struct net_device *netdev, u32 stringset,
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 9246172c9c33..6f236d1a6444 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -395,11 +395,9 @@ static void iavf_get_priv_flag_strings(struct net_device *netdev, u8 *data)
 {
 	unsigned int i;
 
-	for (i = 0; i < IAVF_PRIV_FLAGS_STR_LEN; i++) {
-		strscpy(data, iavf_gstrings_priv_flags[i].flag_string,
-			ETH_GSTRING_LEN);
-		data += ETH_GSTRING_LEN;
-	}
+	for (i = 0; i < IAVF_PRIV_FLAGS_STR_LEN; i++)
+		ethtool_sprintf(&data, "%s",
+				iavf_gstrings_priv_flags[i].flag_string);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index d3cb08e66dcb..5545906f39af 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1060,7 +1060,7 @@ __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < ICE_VSI_STATS_LEN; i++)
-			ethtool_sprintf(&p,
+			ethtool_sprintf(&p, "%s",
 					ice_gstrings_vsi_stats[i].stat_string);
 
 		if (ice_is_port_repr_netdev(netdev))
@@ -1080,7 +1080,7 @@ __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
 			return;
 
 		for (i = 0; i < ICE_PF_STATS_LEN; i++)
-			ethtool_sprintf(&p,
+			ethtool_sprintf(&p, "%s",
 					ice_gstrings_pf_stats[i].stat_string);
 
 		for (i = 0; i < ICE_MAX_USER_PRIORITY; i++) {
@@ -1097,7 +1097,8 @@ __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
 		break;
 	case ETH_SS_PRIV_FLAGS:
 		for (i = 0; i < ICE_PRIV_FLAG_ARRAY_SIZE; i++)
-			ethtool_sprintf(&p, ice_gstrings_priv_flags[i].name);
+			ethtool_sprintf(&p, "%s",
+					ice_gstrings_priv_flags[i].name);
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 319ed601eaa1..9cbd35b6df43 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2356,10 +2356,10 @@ static void igb_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IGB_GLOBAL_STATS_LEN; i++)
-			ethtool_sprintf(&p,
+			ethtool_sprintf(&p, "%s",
 					igb_gstrings_stats[i].stat_string);
 		for (i = 0; i < IGB_NETDEV_STATS_LEN; i++)
-			ethtool_sprintf(&p,
+			ethtool_sprintf(&p, "%s",
 					igb_gstrings_net_stats[i].stat_string);
 		for (i = 0; i < adapter->num_tx_queues; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 7ab6dd58e400..bf4f611286ae 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -773,9 +773,10 @@ static void igc_ethtool_get_strings(struct net_device *netdev, u32 stringset,
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IGC_GLOBAL_STATS_LEN; i++)
-			ethtool_sprintf(&p, igc_gstrings_stats[i].stat_string);
+			ethtool_sprintf(&p, "%s",
+					igc_gstrings_stats[i].stat_string);
 		for (i = 0; i < IGC_NETDEV_STATS_LEN; i++)
-			ethtool_sprintf(&p,
+			ethtool_sprintf(&p, "%s",
 					igc_gstrings_net_stats[i].stat_string);
 		for (i = 0; i < adapter->num_tx_queues; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 0bbad4a5cc2f..4dd897806fa5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1413,11 +1413,11 @@ static void ixgbe_get_strings(struct net_device *netdev, u32 stringset,
 	switch (stringset) {
 	case ETH_SS_TEST:
 		for (i = 0; i < IXGBE_TEST_LEN; i++)
-			ethtool_sprintf(&p, ixgbe_gstrings_test[i]);
+			ethtool_sprintf(&p, "%s", ixgbe_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IXGBE_GLOBAL_STATS_LEN; i++)
-			ethtool_sprintf(&p,
+			ethtool_sprintf(&p, "%s",
 					ixgbe_gstrings_stats[i].stat_string);
 		for (i = 0; i < netdev->num_tx_queues; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
-- 
2.39.3


