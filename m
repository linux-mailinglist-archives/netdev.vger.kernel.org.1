Return-Path: <netdev+bounces-30053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B82785C08
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 17:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8321C20CE7
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E91FC2F1;
	Wed, 23 Aug 2023 15:26:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800AB9448
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 15:26:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5EAE4E
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 08:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692804359; x=1724340359;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UDKQB90LukgVvwXUE6br17Wy9glJCaN/n9QLnq05EEU=;
  b=fmNA1gRnGPnwqQsyvEc6F8lCmmyd5hFqiMLjFgw3MXvxwad9YJSjNagj
   NFX1e3+RMyAOPtfLLuapilZk2xvSXipJnediNuVemiyL9VSMQXiPxe9f3
   ldqdAQKrfG8Me+ffBfi3A7F9+2nWq9CvqqDhEwtPqXPyzEAp39g2ZrnPX
   jviEO+zj7F9Qyqy9CGhwF6+SQkhIxwcvUhoXHtFb/VuV+TYayz92IKYcE
   iWfKyhe/TUi8E9fFoFnussS5g2DhRtgy6HmpybAbZ2qp9ksvIA9T2xAj1
   eqdSbCAR/Gsb10/oTLt/+qSLdeRimtUCztZL4U0f+v1AgsGRIO2eCY1nv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="440547410"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="440547410"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 08:25:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="713612068"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="713612068"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 23 Aug 2023 08:25:24 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Siddaraju DH <siddaraju.dh@intel.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net] ice: avoid executing commands on other ports when driving sync
Date: Wed, 23 Aug 2023 08:18:14 -0700
Message-Id: <20230823151814.3492480-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
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

From: Jacob Keller <jacob.e.keller@intel.com>

The ice hardware has a synchronization mechanism used to drive the
simultaneous application of commands on both PHY ports and the source timer
in the MAC.

When issuing a sync via ice_ptp_exec_tmr_cmd(), the hardware will
simultaneously apply the commands programmed for the main timer and each
PHY port. Neither the main timer command register, nor the PHY port command
registers auto clear on command execution.

During the execution of a timer command intended for a single port on E822
devices, such as those used to configure a PHY during link up, the driver
is not correctly clearing the previous commands.

This results in unintentionally executing the last programmed command on
the main timer and other PHY ports whenever performing reconfiguration on
E822 ports after link up. This results in unintended side effects on other
timers, depending on what command was previously programmed.

To fix this, the driver must ensure that the main timer and all other PHY
ports are properly initialized to perform no action.

The enumeration for timer commands does not include an enumeration value
for doing nothing. Introduce ICE_PTP_NOP for this purpose. When writing a
timer command to hardware, leave the command bits set to zero which
indicates that no operation should be performed on that port.

Modify ice_ptp_one_port_cmd() to always initialize all ports. For all ports
other than the one being configured, write their timer command register to
ICE_PTP_NOP. This ensures that no side effect happens on the timer command.

To fix this for the PHY ports, modify ice_ptp_one_port_cmd() to always
initialize all other ports to ICE_PTP_NOP. This ensures that no side
effects happen on the other ports.

Call ice_ptp_src_cmd() with a command value if ICE_PTP_NOP in
ice_sync_phy_timer_e822() and ice_start_phy_timer_e822().

With both of these changes, the driver should no longer execute a stale
command on the main timer or another PHY port when reconfiguring one of the
PHY ports after link up.

Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")
Signed-off-by: Siddaraju DH <siddaraju.dh@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 55 +++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  3 +-
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index a38614d21ea8..de1d83300481 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -131,6 +131,8 @@ static void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	case READ_TIME:
 		cmd_val |= GLTSYN_CMD_READ_TIME;
 		break;
+	case ICE_PTP_NOP:
+		break;
 	}
 
 	wr32(hw, GLTSYN_CMD, cmd_val);
@@ -1226,18 +1228,18 @@ ice_ptp_read_port_capture(struct ice_hw *hw, u8 port, u64 *tx_ts, u64 *rx_ts)
 }
 
 /**
- * ice_ptp_one_port_cmd - Prepare a single PHY port for a timer command
+ * ice_ptp_write_port_cmd_e822 - Prepare a single PHY port for a timer command
  * @hw: pointer to HW struct
  * @port: Port to which cmd has to be sent
  * @cmd: Command to be sent to the port
  *
  * Prepare the requested port for an upcoming timer sync command.
  *
- * Note there is no equivalent of this operation on E810, as that device
- * always handles all external PHYs internally.
+ * Do not use this function directly. If you want to configure exactly one
+ * port, use ice_ptp_one_port_cmd() instead.
  */
 static int
-ice_ptp_one_port_cmd(struct ice_hw *hw, u8 port, enum ice_ptp_tmr_cmd cmd)
+ice_ptp_write_port_cmd_e822(struct ice_hw *hw, u8 port, enum ice_ptp_tmr_cmd cmd)
 {
 	u32 cmd_val, val;
 	u8 tmr_idx;
@@ -1261,6 +1263,8 @@ ice_ptp_one_port_cmd(struct ice_hw *hw, u8 port, enum ice_ptp_tmr_cmd cmd)
 	case ADJ_TIME_AT_TIME:
 		cmd_val |= PHY_CMD_ADJ_TIME_AT_TIME;
 		break;
+	case ICE_PTP_NOP:
+		break;
 	}
 
 	/* Tx case */
@@ -1306,6 +1310,39 @@ ice_ptp_one_port_cmd(struct ice_hw *hw, u8 port, enum ice_ptp_tmr_cmd cmd)
 	return 0;
 }
 
+/**
+ * ice_ptp_one_port_cmd - Prepare one port for a timer command
+ * @hw: pointer to the HW struct
+ * @configured_port: the port to configure with configured_cmd
+ * @configured_cmd: timer command to prepare on the configured_port
+ *
+ * Prepare the configured_port for the configured_cmd, and prepare all other
+ * ports for ICE_PTP_NOP. This causes the configured_port to execute the
+ * desired command while all other ports perform no operation.
+ */
+static int
+ice_ptp_one_port_cmd(struct ice_hw *hw, u8 configured_port,
+		     enum ice_ptp_tmr_cmd configured_cmd)
+{
+	u8 port;
+
+	for (port = 0; port < ICE_NUM_EXTERNAL_PORTS; port++) {
+		enum ice_ptp_tmr_cmd cmd;
+		int err;
+
+		if (port == configured_port)
+			cmd = configured_cmd;
+		else
+			cmd = ICE_PTP_NOP;
+
+		err = ice_ptp_write_port_cmd_e822(hw, port, cmd);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /**
  * ice_ptp_port_cmd_e822 - Prepare all ports for a timer command
  * @hw: pointer to the HW struct
@@ -1322,7 +1359,7 @@ ice_ptp_port_cmd_e822(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	for (port = 0; port < ICE_NUM_EXTERNAL_PORTS; port++) {
 		int err;
 
-		err = ice_ptp_one_port_cmd(hw, port, cmd);
+		err = ice_ptp_write_port_cmd_e822(hw, port, cmd);
 		if (err)
 			return err;
 	}
@@ -2252,6 +2289,9 @@ static int ice_sync_phy_timer_e822(struct ice_hw *hw, u8 port)
 	if (err)
 		goto err_unlock;
 
+	/* Do not perform any action on the main timer */
+	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
+
 	/* Issue the sync to activate the time adjustment */
 	ice_ptp_exec_tmr_cmd(hw);
 
@@ -2372,6 +2412,9 @@ int ice_start_phy_timer_e822(struct ice_hw *hw, u8 port)
 	if (err)
 		return err;
 
+	/* Do not perform any action on the main timer */
+	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
+
 	ice_ptp_exec_tmr_cmd(hw);
 
 	err = ice_read_phy_reg_e822(hw, port, P_REG_PS, &val);
@@ -2847,6 +2890,8 @@ static int ice_ptp_port_cmd_e810(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	case ADJ_TIME_AT_TIME:
 		cmd_val = GLTSYN_CMD_ADJ_INIT_TIME;
 		break;
+	case ICE_PTP_NOP:
+		return 0;
 	}
 
 	/* Read, modify, write */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 3b68cb91bd81..096685237ca6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -9,7 +9,8 @@ enum ice_ptp_tmr_cmd {
 	INIT_INCVAL,
 	ADJ_TIME,
 	ADJ_TIME_AT_TIME,
-	READ_TIME
+	READ_TIME,
+	ICE_PTP_NOP,
 };
 
 enum ice_ptp_serdes {
-- 
2.38.1


