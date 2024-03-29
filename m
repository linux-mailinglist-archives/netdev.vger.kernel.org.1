Return-Path: <netdev+bounces-83410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E403289230F
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 18:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20FD6B23E0E
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 17:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643A6139CE7;
	Fri, 29 Mar 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+9TOyK3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F5137751
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735004; cv=none; b=GNDkljZEbEgQQIr000sjMCbF4jF0X23dye9HWOXtqAhjMvYRscAeuxmAcjjYyFJGM9TOkmGt+hKutbhe9E4yxSlU1vyRhISfqoa1QINMJmzxCn4jqVbcGcEhZ0k/JHR2FR0QLo9Y/d8TlHvWxEYoqyvJlrLCzgAtP61IASG3wkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735004; c=relaxed/simple;
	bh=/BYtb1csQAbm8n8zLqtmSXuGIi11WDK1JR2l0HNqiGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSd5Kr595LKrWm5BsBwUrKFVbUqOFSwCGcJ5Ub/sa+CNxd2XWP++jeppzdT0DriGP6gDqwAufkIe//9fakBzVvrtqVcJuJ83XWW8wufullrk+8xExiJyjtFcRtUP1WZ0sQtsxAhghRDRKxbX7IIKcEI8Hn3lmK1Gu1bRC9Eh5d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+9TOyK3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711735001; x=1743271001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/BYtb1csQAbm8n8zLqtmSXuGIi11WDK1JR2l0HNqiGg=;
  b=I+9TOyK3uBs/K632vI2G46R5yUyQvPUlFAhWZ4KPUAEayLvOR8dW6gVi
   bBzNhJy3bJM9NPumQRYiC8P37Z1NUlGFP1apo8rod72trrJngQRsvkhev
   7G2Vlx1p1/XJ4FezbRau/ZCWQeTmXF2kOfuEp2zfT94yc63ph0rlR282w
   hKF/sCm10uhrS19DZYM8sozrJ4yO4qKrfqTJ5t+/vtnbKfiGwahoRDIyh
   p4zVIHCPcVZLYltwpb8Bu5OOAL8bDr8E5vn3tLaRGbWhCQGf+2SZO9lVB
   5u+Pa344mBJX/EDPmoiF5ytjnA29uKUJfAVtAm52JDnEfOcu/eyubIfQA
   A==;
X-CSE-ConnectionGUID: QCD6EtmRQy6xigosHHGXgA==
X-CSE-MsgGUID: Br8aB9m1THCySyXI+NeBNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="24422472"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="24422472"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 10:56:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="21499371"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 29 Mar 2024 10:56:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 4/4] i40e: avoid forward declarations in i40e_nvm.c
Date: Fri, 29 Mar 2024 10:56:27 -0700
Message-ID: <20240329175632.211340-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240329175632.211340-1-anthony.l.nguyen@intel.com>
References: <20240329175632.211340-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Move code around to get rid of forward declarations. No functional
changes.

After a plain code juggling, checkpatch reported:
total: 0 errors, 7 warnings, 12 checks, 1581 lines checked

so while at it let's address old issues as well. Should we ever address
the remaining unnecessary forward declarations within
drivers/net/ethernet/intel/, consider this change as a starting
point/reference.

As reported in [0], there would be a lot more of work to do...if we
care.

[0]: https://lore.kernel.org/intel-wired-lan/Zeh8qadiTGf413YU@boxer/T/#u
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 1050 ++++++++++----------
 1 file changed, 509 insertions(+), 541 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 605fd82f5d20..7f0936f4e05e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -734,37 +734,7 @@ int i40e_validate_nvm_checksum(struct i40e_hw *hw,
 	return ret_code;
 }
 
-static int i40e_nvmupd_state_init(struct i40e_hw *hw,
-				  struct i40e_nvm_access *cmd,
-				  u8 *bytes, int *perrno);
-static int i40e_nvmupd_state_reading(struct i40e_hw *hw,
-				     struct i40e_nvm_access *cmd,
-				     u8 *bytes, int *perrno);
-static int i40e_nvmupd_state_writing(struct i40e_hw *hw,
-				     struct i40e_nvm_access *cmd,
-				     u8 *bytes, int *errno);
-static enum i40e_nvmupd_cmd i40e_nvmupd_validate_command(struct i40e_hw *hw,
-						struct i40e_nvm_access *cmd,
-						int *perrno);
-static int i40e_nvmupd_nvm_erase(struct i40e_hw *hw,
-				 struct i40e_nvm_access *cmd,
-				 int *perrno);
-static int i40e_nvmupd_nvm_write(struct i40e_hw *hw,
-				 struct i40e_nvm_access *cmd,
-				 u8 *bytes, int *perrno);
-static int i40e_nvmupd_nvm_read(struct i40e_hw *hw,
-				struct i40e_nvm_access *cmd,
-				u8 *bytes, int *perrno);
-static int i40e_nvmupd_exec_aq(struct i40e_hw *hw,
-			       struct i40e_nvm_access *cmd,
-			       u8 *bytes, int *perrno);
-static int i40e_nvmupd_get_aq_result(struct i40e_hw *hw,
-				     struct i40e_nvm_access *cmd,
-				     u8 *bytes, int *perrno);
-static int i40e_nvmupd_get_aq_event(struct i40e_hw *hw,
-				    struct i40e_nvm_access *cmd,
-				    u8 *bytes, int *perrno);
-static inline u8 i40e_nvmupd_get_module(u32 val)
+static u8 i40e_nvmupd_get_module(u32 val)
 {
 	return (u8)(val & I40E_NVM_MOD_PNT_MASK);
 }
@@ -799,146 +769,433 @@ static const char * const i40e_nvm_update_state_str[] = {
 };
 
 /**
- * i40e_nvmupd_command - Process an NVM update command
+ * i40e_nvmupd_validate_command - Validate given command
  * @hw: pointer to hardware structure
- * @cmd: pointer to nvm update command
- * @bytes: pointer to the data buffer
+ * @cmd: pointer to nvm update command buffer
  * @perrno: pointer to return error code
  *
- * Dispatches command depending on what update state is current
+ * Return one of the valid command types or I40E_NVMUPD_INVALID
  **/
-int i40e_nvmupd_command(struct i40e_hw *hw,
-			struct i40e_nvm_access *cmd,
-			u8 *bytes, int *perrno)
+static enum i40e_nvmupd_cmd
+i40e_nvmupd_validate_command(struct i40e_hw *hw, struct i40e_nvm_access *cmd,
+			     int *perrno)
 {
 	enum i40e_nvmupd_cmd upd_cmd;
-	int status;
-
-	/* assume success */
-	*perrno = 0;
+	u8 module, transaction;
 
-	/* early check for status command and debug msgs */
-	upd_cmd = i40e_nvmupd_validate_command(hw, cmd, perrno);
+	/* anything that doesn't match a recognized case is an error */
+	upd_cmd = I40E_NVMUPD_INVALID;
 
-	i40e_debug(hw, I40E_DEBUG_NVM, "%s state %d nvm_release_on_hold %d opc 0x%04x cmd 0x%08x config 0x%08x offset 0x%08x data_size 0x%08x\n",
-		   i40e_nvm_update_state_str[upd_cmd],
-		   hw->nvmupd_state,
-		   hw->nvm_release_on_done, hw->nvm_wait_opcode,
-		   cmd->command, cmd->config, cmd->offset, cmd->data_size);
+	transaction = i40e_nvmupd_get_transaction(cmd->config);
+	module = i40e_nvmupd_get_module(cmd->config);
 
-	if (upd_cmd == I40E_NVMUPD_INVALID) {
-		*perrno = -EFAULT;
+	/* limits on data size */
+	if (cmd->data_size < 1 || cmd->data_size > I40E_NVMUPD_MAX_DATA) {
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "i40e_nvmupd_validate_command returns %d errno %d\n",
-			   upd_cmd, *perrno);
+			   "%s data_size %d\n", __func__, cmd->data_size);
+		*perrno = -EFAULT;
+		return I40E_NVMUPD_INVALID;
 	}
 
-	/* a status request returns immediately rather than
-	 * going into the state machine
-	 */
-	if (upd_cmd == I40E_NVMUPD_STATUS) {
-		if (!cmd->data_size) {
-			*perrno = -EFAULT;
-			return -EINVAL;
+	switch (cmd->command) {
+	case I40E_NVM_READ:
+		switch (transaction) {
+		case I40E_NVM_CON:
+			upd_cmd = I40E_NVMUPD_READ_CON;
+			break;
+		case I40E_NVM_SNT:
+			upd_cmd = I40E_NVMUPD_READ_SNT;
+			break;
+		case I40E_NVM_LCB:
+			upd_cmd = I40E_NVMUPD_READ_LCB;
+			break;
+		case I40E_NVM_SA:
+			upd_cmd = I40E_NVMUPD_READ_SA;
+			break;
+		case I40E_NVM_EXEC:
+			if (module == 0xf)
+				upd_cmd = I40E_NVMUPD_STATUS;
+			else if (module == 0)
+				upd_cmd = I40E_NVMUPD_GET_AQ_RESULT;
+			break;
+		case I40E_NVM_AQE:
+			upd_cmd = I40E_NVMUPD_GET_AQ_EVENT;
+			break;
 		}
+		break;
 
-		bytes[0] = hw->nvmupd_state;
-
-		if (cmd->data_size >= 4) {
-			bytes[1] = 0;
-			*((u16 *)&bytes[2]) = hw->nvm_wait_opcode;
+	case I40E_NVM_WRITE:
+		switch (transaction) {
+		case I40E_NVM_CON:
+			upd_cmd = I40E_NVMUPD_WRITE_CON;
+			break;
+		case I40E_NVM_SNT:
+			upd_cmd = I40E_NVMUPD_WRITE_SNT;
+			break;
+		case I40E_NVM_LCB:
+			upd_cmd = I40E_NVMUPD_WRITE_LCB;
+			break;
+		case I40E_NVM_SA:
+			upd_cmd = I40E_NVMUPD_WRITE_SA;
+			break;
+		case I40E_NVM_ERA:
+			upd_cmd = I40E_NVMUPD_WRITE_ERA;
+			break;
+		case I40E_NVM_CSUM:
+			upd_cmd = I40E_NVMUPD_CSUM_CON;
+			break;
+		case (I40E_NVM_CSUM | I40E_NVM_SA):
+			upd_cmd = I40E_NVMUPD_CSUM_SA;
+			break;
+		case (I40E_NVM_CSUM | I40E_NVM_LCB):
+			upd_cmd = I40E_NVMUPD_CSUM_LCB;
+			break;
+		case I40E_NVM_EXEC:
+			if (module == 0)
+				upd_cmd = I40E_NVMUPD_EXEC_AQ;
+			break;
 		}
+		break;
+	}
 
-		/* Clear error status on read */
-		if (hw->nvmupd_state == I40E_NVMUPD_STATE_ERROR)
-			hw->nvmupd_state = I40E_NVMUPD_STATE_INIT;
+	return upd_cmd;
+}
 
-		return 0;
-	}
+/**
+ * i40e_nvmupd_nvm_erase - Erase an NVM module
+ * @hw: pointer to hardware structure
+ * @cmd: pointer to nvm update command buffer
+ * @perrno: pointer to return error code
+ *
+ * module, offset, data_size and data are in cmd structure
+ **/
+static int i40e_nvmupd_nvm_erase(struct i40e_hw *hw,
+				 struct i40e_nvm_access *cmd,
+				 int *perrno)
+{
+	struct i40e_asq_cmd_details cmd_details;
+	u8 module, transaction;
+	int status = 0;
+	bool last;
 
-	/* Clear status even it is not read and log */
-	if (hw->nvmupd_state == I40E_NVMUPD_STATE_ERROR) {
+	transaction = i40e_nvmupd_get_transaction(cmd->config);
+	module = i40e_nvmupd_get_module(cmd->config);
+	last = (transaction & I40E_NVM_LCB);
+
+	memset(&cmd_details, 0, sizeof(cmd_details));
+	cmd_details.wb_desc = &hw->nvm_wb_desc;
+
+	status = i40e_aq_erase_nvm(hw, module, cmd->offset, (u16)cmd->data_size,
+				   last, &cmd_details);
+	if (status) {
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "Clearing I40E_NVMUPD_STATE_ERROR state without reading\n");
-		hw->nvmupd_state = I40E_NVMUPD_STATE_INIT;
+			   "%s mod 0x%x  off 0x%x len 0x%x\n",
+			   __func__, module, cmd->offset, cmd->data_size);
+		i40e_debug(hw, I40E_DEBUG_NVM,
+			   "%s status %d aq %d\n",
+			   __func__, status, hw->aq.asq_last_status);
+		*perrno = i40e_aq_rc_to_posix(status, hw->aq.asq_last_status);
 	}
 
-	/* Acquire lock to prevent race condition where adminq_task
-	 * can execute after i40e_nvmupd_nvm_read/write but before state
-	 * variables (nvm_wait_opcode, nvm_release_on_done) are updated.
-	 *
-	 * During NVMUpdate, it is observed that lock could be held for
-	 * ~5ms for most commands. However lock is held for ~60ms for
-	 * NVMUPD_CSUM_LCB command.
-	 */
-	mutex_lock(&hw->aq.arq_mutex);
-	switch (hw->nvmupd_state) {
-	case I40E_NVMUPD_STATE_INIT:
-		status = i40e_nvmupd_state_init(hw, cmd, bytes, perrno);
-		break;
-
-	case I40E_NVMUPD_STATE_READING:
-		status = i40e_nvmupd_state_reading(hw, cmd, bytes, perrno);
-		break;
+	return status;
+}
 
-	case I40E_NVMUPD_STATE_WRITING:
-		status = i40e_nvmupd_state_writing(hw, cmd, bytes, perrno);
-		break;
+/**
+ * i40e_nvmupd_nvm_write - Write NVM
+ * @hw: pointer to hardware structure
+ * @cmd: pointer to nvm update command buffer
+ * @bytes: pointer to the data buffer
+ * @perrno: pointer to return error code
+ *
+ * module, offset, data_size and data are in cmd structure
+ **/
+static int i40e_nvmupd_nvm_write(struct i40e_hw *hw,
+				 struct i40e_nvm_access *cmd,
+				 u8 *bytes, int *perrno)
+{
+	struct i40e_asq_cmd_details cmd_details;
+	u8 module, transaction;
+	u8 preservation_flags;
+	int status = 0;
+	bool last;
 
-	case I40E_NVMUPD_STATE_INIT_WAIT:
-	case I40E_NVMUPD_STATE_WRITE_WAIT:
-		/* if we need to stop waiting for an event, clear
-		 * the wait info and return before doing anything else
-		 */
-		if (cmd->offset == 0xffff) {
-			i40e_nvmupd_clear_wait_state(hw);
-			status = 0;
-			break;
-		}
+	transaction = i40e_nvmupd_get_transaction(cmd->config);
+	module = i40e_nvmupd_get_module(cmd->config);
+	last = (transaction & I40E_NVM_LCB);
+	preservation_flags = i40e_nvmupd_get_preservation_flags(cmd->config);
 
-		status = -EBUSY;
-		*perrno = -EBUSY;
-		break;
+	memset(&cmd_details, 0, sizeof(cmd_details));
+	cmd_details.wb_desc = &hw->nvm_wb_desc;
 
-	default:
-		/* invalid state, should never happen */
+	status = i40e_aq_update_nvm(hw, module, cmd->offset,
+				    (u16)cmd->data_size, bytes, last,
+				    preservation_flags, &cmd_details);
+	if (status) {
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "NVMUPD: no such state %d\n", hw->nvmupd_state);
-		status = -EOPNOTSUPP;
-		*perrno = -ESRCH;
-		break;
+			   "%s mod 0x%x off 0x%x len 0x%x\n",
+			   __func__, module, cmd->offset, cmd->data_size);
+		i40e_debug(hw, I40E_DEBUG_NVM,
+			   "%s status %d aq %d\n",
+			   __func__, status, hw->aq.asq_last_status);
+		*perrno = i40e_aq_rc_to_posix(status, hw->aq.asq_last_status);
 	}
 
-	mutex_unlock(&hw->aq.arq_mutex);
 	return status;
 }
 
 /**
- * i40e_nvmupd_state_init - Handle NVM update state Init
+ * i40e_nvmupd_nvm_read - Read NVM
  * @hw: pointer to hardware structure
  * @cmd: pointer to nvm update command buffer
  * @bytes: pointer to the data buffer
  * @perrno: pointer to return error code
  *
- * Process legitimate commands of the Init state and conditionally set next
- * state. Reject all other commands.
+ * cmd structure contains identifiers and data buffer
  **/
-static int i40e_nvmupd_state_init(struct i40e_hw *hw,
-				  struct i40e_nvm_access *cmd,
-				  u8 *bytes, int *perrno)
+static int i40e_nvmupd_nvm_read(struct i40e_hw *hw,
+				struct i40e_nvm_access *cmd,
+				u8 *bytes, int *perrno)
 {
-	enum i40e_nvmupd_cmd upd_cmd;
-	int status = 0;
+	struct i40e_asq_cmd_details cmd_details;
+	u8 module, transaction;
+	int status;
+	bool last;
 
-	upd_cmd = i40e_nvmupd_validate_command(hw, cmd, perrno);
+	transaction = i40e_nvmupd_get_transaction(cmd->config);
+	module = i40e_nvmupd_get_module(cmd->config);
+	last = (transaction == I40E_NVM_LCB) || (transaction == I40E_NVM_SA);
 
-	switch (upd_cmd) {
-	case I40E_NVMUPD_READ_SA:
-		status = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
-		if (status) {
-			*perrno = i40e_aq_rc_to_posix(status,
-						     hw->aq.asq_last_status);
-		} else {
+	memset(&cmd_details, 0, sizeof(cmd_details));
+	cmd_details.wb_desc = &hw->nvm_wb_desc;
+
+	status = i40e_aq_read_nvm(hw, module, cmd->offset, (u16)cmd->data_size,
+				  bytes, last, &cmd_details);
+	if (status) {
+		i40e_debug(hw, I40E_DEBUG_NVM,
+			   "%s mod 0x%x  off 0x%x  len 0x%x\n",
+			   __func__, module, cmd->offset, cmd->data_size);
+		i40e_debug(hw, I40E_DEBUG_NVM,
+			   "%s status %d aq %d\n",
+			   __func__, status, hw->aq.asq_last_status);
+		*perrno = i40e_aq_rc_to_posix(status, hw->aq.asq_last_status);
+	}
+
+	return status;
+}
+
+/**
+ * i40e_nvmupd_exec_aq - Run an AQ command
+ * @hw: pointer to hardware structure
+ * @cmd: pointer to nvm update command buffer
+ * @bytes: pointer to the data buffer
+ * @perrno: pointer to return error code
+ *
+ * cmd structure contains identifiers and data buffer
+ **/
+static int i40e_nvmupd_exec_aq(struct i40e_hw *hw,
+			       struct i40e_nvm_access *cmd,
+			       u8 *bytes, int *perrno)
+{
+	struct i40e_asq_cmd_details cmd_details;
+	struct i40e_aq_desc *aq_desc;
+	u32 buff_size = 0;
+	u8 *buff = NULL;
+	u32 aq_desc_len;
+	u32 aq_data_len;
+	int status;
+
+	i40e_debug(hw, I40E_DEBUG_NVM, "NVMUPD: %s\n", __func__);
+	if (cmd->offset == 0xffff)
+		return 0;
+
+	memset(&cmd_details, 0, sizeof(cmd_details));
+	cmd_details.wb_desc = &hw->nvm_wb_desc;
+
+	aq_desc_len = sizeof(struct i40e_aq_desc);
+	memset(&hw->nvm_wb_desc, 0, aq_desc_len);
+
+	/* get the aq descriptor */
+	if (cmd->data_size < aq_desc_len) {
+		i40e_debug(hw, I40E_DEBUG_NVM,
+			   "NVMUPD: not enough aq desc bytes for exec, size %d < %d\n",
+			   cmd->data_size, aq_desc_len);
+		*perrno = -EINVAL;
+		return -EINVAL;
+	}
+	aq_desc = (struct i40e_aq_desc *)bytes;
+
+	/* if data buffer needed, make sure it's ready */
+	aq_data_len = cmd->data_size - aq_desc_len;
+	buff_size = max_t(u32, aq_data_len, le16_to_cpu(aq_desc->datalen));
+	if (buff_size) {
+		if (!hw->nvm_buff.va) {
+			status = i40e_allocate_virt_mem(hw, &hw->nvm_buff,
+							hw->aq.asq_buf_size);
+			if (status)
+				i40e_debug(hw, I40E_DEBUG_NVM,
+					   "NVMUPD: i40e_allocate_virt_mem for exec buff failed, %d\n",
+					   status);
+		}
+
+		if (hw->nvm_buff.va) {
+			buff = hw->nvm_buff.va;
+			memcpy(buff, &bytes[aq_desc_len], aq_data_len);
+		}
+	}
+
+	if (cmd->offset)
+		memset(&hw->nvm_aq_event_desc, 0, aq_desc_len);
+
+	/* and away we go! */
+	status = i40e_asq_send_command(hw, aq_desc, buff,
+				       buff_size, &cmd_details);
+	if (status) {
+		i40e_debug(hw, I40E_DEBUG_NVM,
+			   "%s err %pe aq_err %s\n",
+			   __func__, ERR_PTR(status),
+			   i40e_aq_str(hw, hw->aq.asq_last_status));
+		*perrno = i40e_aq_rc_to_posix(status, hw->aq.asq_last_status);
+		return status;
+	}
+
+	/* should we wait for a followup event? */
+	if (cmd->offset) {
+		hw->nvm_wait_opcode = cmd->offset;
+		hw->nvmupd_state = I40E_NVMUPD_STATE_INIT_WAIT;
+	}
+
+	return status;
+}
+
+/**
+ * i40e_nvmupd_get_aq_result - Get the results from the previous exec_aq
+ * @hw: pointer to hardware structure
+ * @cmd: pointer to nvm update command buffer
+ * @bytes: pointer to the data buffer
+ * @perrno: pointer to return error code
+ *
+ * cmd structure contains identifiers and data buffer
+ **/
+static int i40e_nvmupd_get_aq_result(struct i40e_hw *hw,
+				     struct i40e_nvm_access *cmd,
+				     u8 *bytes, int *perrno)
+{
+	u32 aq_total_len;
+	u32 aq_desc_len;
+	int remainder;
+	u8 *buff;
+
+	i40e_debug(hw, I40E_DEBUG_NVM, "NVMUPD: %s\n", __func__);
+
+	aq_desc_len = sizeof(struct i40e_aq_desc);
+	aq_total_len = aq_desc_len + le16_to_cpu(hw->nvm_wb_desc.datalen);
+
+	/* check offset range */
+	if (cmd->offset > aq_total_len) {
+		i40e_debug(hw, I40E_DEBUG_NVM, "%s: offset too big %d > %d\n",
+			   __func__, cmd->offset, aq_total_len);
+		*perrno = -EINVAL;
+		return -EINVAL;
+	}
+
+	/* check copylength range */
+	if (cmd->data_size > (aq_total_len - cmd->offset)) {
+		int new_len = aq_total_len - cmd->offset;
+
+		i40e_debug(hw, I40E_DEBUG_NVM, "%s: copy length %d too big, trimming to %d\n",
+			   __func__, cmd->data_size, new_len);
+		cmd->data_size = new_len;
+	}
+
+	remainder = cmd->data_size;
+	if (cmd->offset < aq_desc_len) {
+		u32 len = aq_desc_len - cmd->offset;
+
+		len = min(len, cmd->data_size);
+		i40e_debug(hw, I40E_DEBUG_NVM, "%s: aq_desc bytes %d to %d\n",
+			   __func__, cmd->offset, cmd->offset + len);
+
+		buff = ((u8 *)&hw->nvm_wb_desc) + cmd->offset;
+		memcpy(bytes, buff, len);
+
+		bytes += len;
+		remainder -= len;
+		buff = hw->nvm_buff.va;
+	} else {
+		buff = hw->nvm_buff.va + (cmd->offset - aq_desc_len);
+	}
+
+	if (remainder > 0) {
+		int start_byte = buff - (u8 *)hw->nvm_buff.va;
+
+		i40e_debug(hw, I40E_DEBUG_NVM, "%s: databuf bytes %d to %d\n",
+			   __func__, start_byte, start_byte + remainder);
+		memcpy(bytes, buff, remainder);
+	}
+
+	return 0;
+}
+
+/**
+ * i40e_nvmupd_get_aq_event - Get the Admin Queue event from previous exec_aq
+ * @hw: pointer to hardware structure
+ * @cmd: pointer to nvm update command buffer
+ * @bytes: pointer to the data buffer
+ * @perrno: pointer to return error code
+ *
+ * cmd structure contains identifiers and data buffer
+ **/
+static int i40e_nvmupd_get_aq_event(struct i40e_hw *hw,
+				    struct i40e_nvm_access *cmd,
+				    u8 *bytes, int *perrno)
+{
+	u32 aq_total_len;
+	u32 aq_desc_len;
+
+	i40e_debug(hw, I40E_DEBUG_NVM, "NVMUPD: %s\n", __func__);
+
+	aq_desc_len = sizeof(struct i40e_aq_desc);
+	aq_total_len = aq_desc_len + le16_to_cpu(hw->nvm_aq_event_desc.datalen);
+
+	/* check copylength range */
+	if (cmd->data_size > aq_total_len) {
+		i40e_debug(hw, I40E_DEBUG_NVM,
+			   "%s: copy length %d too big, trimming to %d\n",
+			   __func__, cmd->data_size, aq_total_len);
+		cmd->data_size = aq_total_len;
+	}
+
+	memcpy(bytes, &hw->nvm_aq_event_desc, cmd->data_size);
+
+	return 0;
+}
+
+/**
+ * i40e_nvmupd_state_init - Handle NVM update state Init
+ * @hw: pointer to hardware structure
+ * @cmd: pointer to nvm update command buffer
+ * @bytes: pointer to the data buffer
+ * @perrno: pointer to return error code
+ *
+ * Process legitimate commands of the Init state and conditionally set next
+ * state. Reject all other commands.
+ **/
+static int i40e_nvmupd_state_init(struct i40e_hw *hw,
+				  struct i40e_nvm_access *cmd,
+				  u8 *bytes, int *perrno)
+{
+	enum i40e_nvmupd_cmd upd_cmd;
+	int status = 0;
+
+	upd_cmd = i40e_nvmupd_validate_command(hw, cmd, perrno);
+
+	switch (upd_cmd) {
+	case I40E_NVMUPD_READ_SA:
+		status = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
+		if (status) {
+			*perrno = i40e_aq_rc_to_posix(status,
+						      hw->aq.asq_last_status);
+		} else {
 			status = i40e_nvmupd_nvm_read(hw, cmd, bytes, perrno);
 			i40e_release_nvm(hw);
 		}
@@ -948,7 +1205,7 @@ static int i40e_nvmupd_state_init(struct i40e_hw *hw,
 		status = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
 		if (status) {
 			*perrno = i40e_aq_rc_to_posix(status,
-						     hw->aq.asq_last_status);
+						      hw->aq.asq_last_status);
 		} else {
 			status = i40e_nvmupd_nvm_read(hw, cmd, bytes, perrno);
 			if (status)
@@ -962,7 +1219,7 @@ static int i40e_nvmupd_state_init(struct i40e_hw *hw,
 		status = i40e_acquire_nvm(hw, I40E_RESOURCE_WRITE);
 		if (status) {
 			*perrno = i40e_aq_rc_to_posix(status,
-						     hw->aq.asq_last_status);
+						      hw->aq.asq_last_status);
 		} else {
 			status = i40e_nvmupd_nvm_erase(hw, cmd, perrno);
 			if (status) {
@@ -979,7 +1236,7 @@ static int i40e_nvmupd_state_init(struct i40e_hw *hw,
 		status = i40e_acquire_nvm(hw, I40E_RESOURCE_WRITE);
 		if (status) {
 			*perrno = i40e_aq_rc_to_posix(status,
-						     hw->aq.asq_last_status);
+						      hw->aq.asq_last_status);
 		} else {
 			status = i40e_nvmupd_nvm_write(hw, cmd, bytes, perrno);
 			if (status) {
@@ -996,7 +1253,7 @@ static int i40e_nvmupd_state_init(struct i40e_hw *hw,
 		status = i40e_acquire_nvm(hw, I40E_RESOURCE_WRITE);
 		if (status) {
 			*perrno = i40e_aq_rc_to_posix(status,
-						     hw->aq.asq_last_status);
+						      hw->aq.asq_last_status);
 		} else {
 			status = i40e_nvmupd_nvm_write(hw, cmd, bytes, perrno);
 			if (status) {
@@ -1012,7 +1269,7 @@ static int i40e_nvmupd_state_init(struct i40e_hw *hw,
 		status = i40e_acquire_nvm(hw, I40E_RESOURCE_WRITE);
 		if (status) {
 			*perrno = i40e_aq_rc_to_posix(status,
-						     hw->aq.asq_last_status);
+						      hw->aq.asq_last_status);
 		} else {
 			status = i40e_update_nvm_checksum(hw);
 			if (status) {
@@ -1185,7 +1442,7 @@ static int i40e_nvmupd_state_writing(struct i40e_hw *hw,
 	 * so here we try to reacquire the semaphore then retry the write.
 	 * We only do one retry, then give up.
 	 */
-	if (status && (hw->aq.asq_last_status == I40E_AQ_RC_EBUSY) &&
+	if (status && hw->aq.asq_last_status == I40E_AQ_RC_EBUSY &&
 	    !retry_attempt) {
 		u32 old_asq_status = hw->aq.asq_last_status;
 		int old_status = status;
@@ -1215,457 +1472,168 @@ static int i40e_nvmupd_state_writing(struct i40e_hw *hw,
 }
 
 /**
- * i40e_nvmupd_clear_wait_state - clear wait state on hw
- * @hw: pointer to the hardware structure
+ * i40e_nvmupd_command - Process an NVM update command
+ * @hw: pointer to hardware structure
+ * @cmd: pointer to nvm update command
+ * @bytes: pointer to the data buffer
+ * @perrno: pointer to return error code
+ *
+ * Dispatches command depending on what update state is current
  **/
-void i40e_nvmupd_clear_wait_state(struct i40e_hw *hw)
+int i40e_nvmupd_command(struct i40e_hw *hw,
+			struct i40e_nvm_access *cmd,
+			u8 *bytes, int *perrno)
 {
-	i40e_debug(hw, I40E_DEBUG_NVM,
-		   "NVMUPD: clearing wait on opcode 0x%04x\n",
-		   hw->nvm_wait_opcode);
-
-	if (hw->nvm_release_on_done) {
-		i40e_release_nvm(hw);
-		hw->nvm_release_on_done = false;
-	}
-	hw->nvm_wait_opcode = 0;
+	enum i40e_nvmupd_cmd upd_cmd;
+	int status;
 
-	if (hw->aq.arq_last_status) {
-		hw->nvmupd_state = I40E_NVMUPD_STATE_ERROR;
-		return;
-	}
+	/* assume success */
+	*perrno = 0;
 
-	switch (hw->nvmupd_state) {
-	case I40E_NVMUPD_STATE_INIT_WAIT:
-		hw->nvmupd_state = I40E_NVMUPD_STATE_INIT;
-		break;
+	/* early check for status command and debug msgs */
+	upd_cmd = i40e_nvmupd_validate_command(hw, cmd, perrno);
 
-	case I40E_NVMUPD_STATE_WRITE_WAIT:
-		hw->nvmupd_state = I40E_NVMUPD_STATE_WRITING;
-		break;
+	i40e_debug(hw, I40E_DEBUG_NVM, "%s state %d nvm_release_on_hold %d opc 0x%04x cmd 0x%08x config 0x%08x offset 0x%08x data_size 0x%08x\n",
+		   i40e_nvm_update_state_str[upd_cmd],
+		   hw->nvmupd_state,
+		   hw->nvm_release_on_done, hw->nvm_wait_opcode,
+		   cmd->command, cmd->config, cmd->offset, cmd->data_size);
 
-	default:
-		break;
+	if (upd_cmd == I40E_NVMUPD_INVALID) {
+		*perrno = -EFAULT;
+		i40e_debug(hw, I40E_DEBUG_NVM,
+			   "i40e_nvmupd_validate_command returns %d errno %d\n",
+			   upd_cmd, *perrno);
 	}
-}
 
-/**
- * i40e_nvmupd_check_wait_event - handle NVM update operation events
- * @hw: pointer to the hardware structure
- * @opcode: the event that just happened
- * @desc: AdminQ descriptor
- **/
-void i40e_nvmupd_check_wait_event(struct i40e_hw *hw, u16 opcode,
-				  struct i40e_aq_desc *desc)
-{
-	u32 aq_desc_len = sizeof(struct i40e_aq_desc);
+	/* a status request returns immediately rather than
+	 * going into the state machine
+	 */
+	if (upd_cmd == I40E_NVMUPD_STATUS) {
+		if (!cmd->data_size) {
+			*perrno = -EFAULT;
+			return -EINVAL;
+		}
 
-	if (opcode == hw->nvm_wait_opcode) {
-		memcpy(&hw->nvm_aq_event_desc, desc, aq_desc_len);
-		i40e_nvmupd_clear_wait_state(hw);
-	}
-}
+		bytes[0] = hw->nvmupd_state;
 
-/**
- * i40e_nvmupd_validate_command - Validate given command
- * @hw: pointer to hardware structure
- * @cmd: pointer to nvm update command buffer
- * @perrno: pointer to return error code
- *
- * Return one of the valid command types or I40E_NVMUPD_INVALID
- **/
-static enum i40e_nvmupd_cmd i40e_nvmupd_validate_command(struct i40e_hw *hw,
-						 struct i40e_nvm_access *cmd,
-						 int *perrno)
-{
-	enum i40e_nvmupd_cmd upd_cmd;
-	u8 module, transaction;
+		if (cmd->data_size >= 4) {
+			bytes[1] = 0;
+			*((u16 *)&bytes[2]) = hw->nvm_wait_opcode;
+		}
 
-	/* anything that doesn't match a recognized case is an error */
-	upd_cmd = I40E_NVMUPD_INVALID;
+		/* Clear error status on read */
+		if (hw->nvmupd_state == I40E_NVMUPD_STATE_ERROR)
+			hw->nvmupd_state = I40E_NVMUPD_STATE_INIT;
 
-	transaction = i40e_nvmupd_get_transaction(cmd->config);
-	module = i40e_nvmupd_get_module(cmd->config);
+		return 0;
+	}
 
-	/* limits on data size */
-	if ((cmd->data_size < 1) ||
-	    (cmd->data_size > I40E_NVMUPD_MAX_DATA)) {
+	/* Clear status even it is not read and log */
+	if (hw->nvmupd_state == I40E_NVMUPD_STATE_ERROR) {
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "i40e_nvmupd_validate_command data_size %d\n",
-			   cmd->data_size);
-		*perrno = -EFAULT;
-		return I40E_NVMUPD_INVALID;
+			   "Clearing I40E_NVMUPD_STATE_ERROR state without reading\n");
+		hw->nvmupd_state = I40E_NVMUPD_STATE_INIT;
 	}
 
-	switch (cmd->command) {
-	case I40E_NVM_READ:
-		switch (transaction) {
-		case I40E_NVM_CON:
-			upd_cmd = I40E_NVMUPD_READ_CON;
-			break;
-		case I40E_NVM_SNT:
-			upd_cmd = I40E_NVMUPD_READ_SNT;
-			break;
-		case I40E_NVM_LCB:
-			upd_cmd = I40E_NVMUPD_READ_LCB;
-			break;
-		case I40E_NVM_SA:
-			upd_cmd = I40E_NVMUPD_READ_SA;
-			break;
-		case I40E_NVM_EXEC:
-			if (module == 0xf)
-				upd_cmd = I40E_NVMUPD_STATUS;
-			else if (module == 0)
-				upd_cmd = I40E_NVMUPD_GET_AQ_RESULT;
-			break;
-		case I40E_NVM_AQE:
-			upd_cmd = I40E_NVMUPD_GET_AQ_EVENT;
-			break;
-		}
+	/* Acquire lock to prevent race condition where adminq_task
+	 * can execute after i40e_nvmupd_nvm_read/write but before state
+	 * variables (nvm_wait_opcode, nvm_release_on_done) are updated.
+	 *
+	 * During NVMUpdate, it is observed that lock could be held for
+	 * ~5ms for most commands. However lock is held for ~60ms for
+	 * NVMUPD_CSUM_LCB command.
+	 */
+	mutex_lock(&hw->aq.arq_mutex);
+	switch (hw->nvmupd_state) {
+	case I40E_NVMUPD_STATE_INIT:
+		status = i40e_nvmupd_state_init(hw, cmd, bytes, perrno);
 		break;
 
-	case I40E_NVM_WRITE:
-		switch (transaction) {
-		case I40E_NVM_CON:
-			upd_cmd = I40E_NVMUPD_WRITE_CON;
-			break;
-		case I40E_NVM_SNT:
-			upd_cmd = I40E_NVMUPD_WRITE_SNT;
-			break;
-		case I40E_NVM_LCB:
-			upd_cmd = I40E_NVMUPD_WRITE_LCB;
-			break;
-		case I40E_NVM_SA:
-			upd_cmd = I40E_NVMUPD_WRITE_SA;
-			break;
-		case I40E_NVM_ERA:
-			upd_cmd = I40E_NVMUPD_WRITE_ERA;
-			break;
-		case I40E_NVM_CSUM:
-			upd_cmd = I40E_NVMUPD_CSUM_CON;
-			break;
-		case (I40E_NVM_CSUM|I40E_NVM_SA):
-			upd_cmd = I40E_NVMUPD_CSUM_SA;
-			break;
-		case (I40E_NVM_CSUM|I40E_NVM_LCB):
-			upd_cmd = I40E_NVMUPD_CSUM_LCB;
-			break;
-		case I40E_NVM_EXEC:
-			if (module == 0)
-				upd_cmd = I40E_NVMUPD_EXEC_AQ;
-			break;
-		}
+	case I40E_NVMUPD_STATE_READING:
+		status = i40e_nvmupd_state_reading(hw, cmd, bytes, perrno);
 		break;
-	}
-
-	return upd_cmd;
-}
-
-/**
- * i40e_nvmupd_exec_aq - Run an AQ command
- * @hw: pointer to hardware structure
- * @cmd: pointer to nvm update command buffer
- * @bytes: pointer to the data buffer
- * @perrno: pointer to return error code
- *
- * cmd structure contains identifiers and data buffer
- **/
-static int i40e_nvmupd_exec_aq(struct i40e_hw *hw,
-			       struct i40e_nvm_access *cmd,
-			       u8 *bytes, int *perrno)
-{
-	struct i40e_asq_cmd_details cmd_details;
-	struct i40e_aq_desc *aq_desc;
-	u32 buff_size = 0;
-	u8 *buff = NULL;
-	u32 aq_desc_len;
-	u32 aq_data_len;
-	int status;
-
-	i40e_debug(hw, I40E_DEBUG_NVM, "NVMUPD: %s\n", __func__);
-	if (cmd->offset == 0xffff)
-		return 0;
-
-	memset(&cmd_details, 0, sizeof(cmd_details));
-	cmd_details.wb_desc = &hw->nvm_wb_desc;
 
-	aq_desc_len = sizeof(struct i40e_aq_desc);
-	memset(&hw->nvm_wb_desc, 0, aq_desc_len);
-
-	/* get the aq descriptor */
-	if (cmd->data_size < aq_desc_len) {
-		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "NVMUPD: not enough aq desc bytes for exec, size %d < %d\n",
-			   cmd->data_size, aq_desc_len);
-		*perrno = -EINVAL;
-		return -EINVAL;
-	}
-	aq_desc = (struct i40e_aq_desc *)bytes;
-
-	/* if data buffer needed, make sure it's ready */
-	aq_data_len = cmd->data_size - aq_desc_len;
-	buff_size = max_t(u32, aq_data_len, le16_to_cpu(aq_desc->datalen));
-	if (buff_size) {
-		if (!hw->nvm_buff.va) {
-			status = i40e_allocate_virt_mem(hw, &hw->nvm_buff,
-							hw->aq.asq_buf_size);
-			if (status)
-				i40e_debug(hw, I40E_DEBUG_NVM,
-					   "NVMUPD: i40e_allocate_virt_mem for exec buff failed, %d\n",
-					   status);
-		}
+	case I40E_NVMUPD_STATE_WRITING:
+		status = i40e_nvmupd_state_writing(hw, cmd, bytes, perrno);
+		break;
 
-		if (hw->nvm_buff.va) {
-			buff = hw->nvm_buff.va;
-			memcpy(buff, &bytes[aq_desc_len], aq_data_len);
+	case I40E_NVMUPD_STATE_INIT_WAIT:
+	case I40E_NVMUPD_STATE_WRITE_WAIT:
+		/* if we need to stop waiting for an event, clear
+		 * the wait info and return before doing anything else
+		 */
+		if (cmd->offset == 0xffff) {
+			i40e_nvmupd_clear_wait_state(hw);
+			status = 0;
+			break;
 		}
-	}
 
-	if (cmd->offset)
-		memset(&hw->nvm_aq_event_desc, 0, aq_desc_len);
+		status = -EBUSY;
+		*perrno = -EBUSY;
+		break;
 
-	/* and away we go! */
-	status = i40e_asq_send_command(hw, aq_desc, buff,
-				       buff_size, &cmd_details);
-	if (status) {
+	default:
+		/* invalid state, should never happen */
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "%s err %pe aq_err %s\n",
-			   __func__, ERR_PTR(status),
-			   i40e_aq_str(hw, hw->aq.asq_last_status));
-		*perrno = i40e_aq_rc_to_posix(status, hw->aq.asq_last_status);
-		return status;
-	}
-
-	/* should we wait for a followup event? */
-	if (cmd->offset) {
-		hw->nvm_wait_opcode = cmd->offset;
-		hw->nvmupd_state = I40E_NVMUPD_STATE_INIT_WAIT;
+			   "NVMUPD: no such state %d\n", hw->nvmupd_state);
+		status = -EOPNOTSUPP;
+		*perrno = -ESRCH;
+		break;
 	}
 
+	mutex_unlock(&hw->aq.arq_mutex);
 	return status;
 }
 
 /**
- * i40e_nvmupd_get_aq_result - Get the results from the previous exec_aq
- * @hw: pointer to hardware structure
- * @cmd: pointer to nvm update command buffer
- * @bytes: pointer to the data buffer
- * @perrno: pointer to return error code
- *
- * cmd structure contains identifiers and data buffer
- **/
-static int i40e_nvmupd_get_aq_result(struct i40e_hw *hw,
-				     struct i40e_nvm_access *cmd,
-				     u8 *bytes, int *perrno)
-{
-	u32 aq_total_len;
-	u32 aq_desc_len;
-	int remainder;
-	u8 *buff;
-
-	i40e_debug(hw, I40E_DEBUG_NVM, "NVMUPD: %s\n", __func__);
-
-	aq_desc_len = sizeof(struct i40e_aq_desc);
-	aq_total_len = aq_desc_len + le16_to_cpu(hw->nvm_wb_desc.datalen);
-
-	/* check offset range */
-	if (cmd->offset > aq_total_len) {
-		i40e_debug(hw, I40E_DEBUG_NVM, "%s: offset too big %d > %d\n",
-			   __func__, cmd->offset, aq_total_len);
-		*perrno = -EINVAL;
-		return -EINVAL;
-	}
-
-	/* check copylength range */
-	if (cmd->data_size > (aq_total_len - cmd->offset)) {
-		int new_len = aq_total_len - cmd->offset;
-
-		i40e_debug(hw, I40E_DEBUG_NVM, "%s: copy length %d too big, trimming to %d\n",
-			   __func__, cmd->data_size, new_len);
-		cmd->data_size = new_len;
-	}
-
-	remainder = cmd->data_size;
-	if (cmd->offset < aq_desc_len) {
-		u32 len = aq_desc_len - cmd->offset;
-
-		len = min(len, cmd->data_size);
-		i40e_debug(hw, I40E_DEBUG_NVM, "%s: aq_desc bytes %d to %d\n",
-			   __func__, cmd->offset, cmd->offset + len);
-
-		buff = ((u8 *)&hw->nvm_wb_desc) + cmd->offset;
-		memcpy(bytes, buff, len);
-
-		bytes += len;
-		remainder -= len;
-		buff = hw->nvm_buff.va;
-	} else {
-		buff = hw->nvm_buff.va + (cmd->offset - aq_desc_len);
-	}
-
-	if (remainder > 0) {
-		int start_byte = buff - (u8 *)hw->nvm_buff.va;
-
-		i40e_debug(hw, I40E_DEBUG_NVM, "%s: databuf bytes %d to %d\n",
-			   __func__, start_byte, start_byte + remainder);
-		memcpy(bytes, buff, remainder);
-	}
-
-	return 0;
-}
-
-/**
- * i40e_nvmupd_get_aq_event - Get the Admin Queue event from previous exec_aq
- * @hw: pointer to hardware structure
- * @cmd: pointer to nvm update command buffer
- * @bytes: pointer to the data buffer
- * @perrno: pointer to return error code
- *
- * cmd structure contains identifiers and data buffer
+ * i40e_nvmupd_clear_wait_state - clear wait state on hw
+ * @hw: pointer to the hardware structure
  **/
-static int i40e_nvmupd_get_aq_event(struct i40e_hw *hw,
-				    struct i40e_nvm_access *cmd,
-				    u8 *bytes, int *perrno)
+void i40e_nvmupd_clear_wait_state(struct i40e_hw *hw)
 {
-	u32 aq_total_len;
-	u32 aq_desc_len;
-
-	i40e_debug(hw, I40E_DEBUG_NVM, "NVMUPD: %s\n", __func__);
-
-	aq_desc_len = sizeof(struct i40e_aq_desc);
-	aq_total_len = aq_desc_len + le16_to_cpu(hw->nvm_aq_event_desc.datalen);
+	i40e_debug(hw, I40E_DEBUG_NVM,
+		   "NVMUPD: clearing wait on opcode 0x%04x\n",
+		   hw->nvm_wait_opcode);
 
-	/* check copylength range */
-	if (cmd->data_size > aq_total_len) {
-		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "%s: copy length %d too big, trimming to %d\n",
-			   __func__, cmd->data_size, aq_total_len);
-		cmd->data_size = aq_total_len;
+	if (hw->nvm_release_on_done) {
+		i40e_release_nvm(hw);
+		hw->nvm_release_on_done = false;
 	}
+	hw->nvm_wait_opcode = 0;
 
-	memcpy(bytes, &hw->nvm_aq_event_desc, cmd->data_size);
-
-	return 0;
-}
-
-/**
- * i40e_nvmupd_nvm_read - Read NVM
- * @hw: pointer to hardware structure
- * @cmd: pointer to nvm update command buffer
- * @bytes: pointer to the data buffer
- * @perrno: pointer to return error code
- *
- * cmd structure contains identifiers and data buffer
- **/
-static int i40e_nvmupd_nvm_read(struct i40e_hw *hw,
-				struct i40e_nvm_access *cmd,
-				u8 *bytes, int *perrno)
-{
-	struct i40e_asq_cmd_details cmd_details;
-	u8 module, transaction;
-	int status;
-	bool last;
-
-	transaction = i40e_nvmupd_get_transaction(cmd->config);
-	module = i40e_nvmupd_get_module(cmd->config);
-	last = (transaction == I40E_NVM_LCB) || (transaction == I40E_NVM_SA);
-
-	memset(&cmd_details, 0, sizeof(cmd_details));
-	cmd_details.wb_desc = &hw->nvm_wb_desc;
-
-	status = i40e_aq_read_nvm(hw, module, cmd->offset, (u16)cmd->data_size,
-				  bytes, last, &cmd_details);
-	if (status) {
-		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "i40e_nvmupd_nvm_read mod 0x%x  off 0x%x  len 0x%x\n",
-			   module, cmd->offset, cmd->data_size);
-		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "i40e_nvmupd_nvm_read status %d aq %d\n",
-			   status, hw->aq.asq_last_status);
-		*perrno = i40e_aq_rc_to_posix(status, hw->aq.asq_last_status);
+	if (hw->aq.arq_last_status) {
+		hw->nvmupd_state = I40E_NVMUPD_STATE_ERROR;
+		return;
 	}
 
-	return status;
-}
-
-/**
- * i40e_nvmupd_nvm_erase - Erase an NVM module
- * @hw: pointer to hardware structure
- * @cmd: pointer to nvm update command buffer
- * @perrno: pointer to return error code
- *
- * module, offset, data_size and data are in cmd structure
- **/
-static int i40e_nvmupd_nvm_erase(struct i40e_hw *hw,
-				 struct i40e_nvm_access *cmd,
-				 int *perrno)
-{
-	struct i40e_asq_cmd_details cmd_details;
-	u8 module, transaction;
-	int status = 0;
-	bool last;
-
-	transaction = i40e_nvmupd_get_transaction(cmd->config);
-	module = i40e_nvmupd_get_module(cmd->config);
-	last = (transaction & I40E_NVM_LCB);
+	switch (hw->nvmupd_state) {
+	case I40E_NVMUPD_STATE_INIT_WAIT:
+		hw->nvmupd_state = I40E_NVMUPD_STATE_INIT;
+		break;
 
-	memset(&cmd_details, 0, sizeof(cmd_details));
-	cmd_details.wb_desc = &hw->nvm_wb_desc;
+	case I40E_NVMUPD_STATE_WRITE_WAIT:
+		hw->nvmupd_state = I40E_NVMUPD_STATE_WRITING;
+		break;
 
-	status = i40e_aq_erase_nvm(hw, module, cmd->offset, (u16)cmd->data_size,
-				   last, &cmd_details);
-	if (status) {
-		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "i40e_nvmupd_nvm_erase mod 0x%x  off 0x%x len 0x%x\n",
-			   module, cmd->offset, cmd->data_size);
-		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "i40e_nvmupd_nvm_erase status %d aq %d\n",
-			   status, hw->aq.asq_last_status);
-		*perrno = i40e_aq_rc_to_posix(status, hw->aq.asq_last_status);
+	default:
+		break;
 	}
-
-	return status;
 }
 
 /**
- * i40e_nvmupd_nvm_write - Write NVM
- * @hw: pointer to hardware structure
- * @cmd: pointer to nvm update command buffer
- * @bytes: pointer to the data buffer
- * @perrno: pointer to return error code
- *
- * module, offset, data_size and data are in cmd structure
+ * i40e_nvmupd_check_wait_event - handle NVM update operation events
+ * @hw: pointer to the hardware structure
+ * @opcode: the event that just happened
+ * @desc: AdminQ descriptor
  **/
-static int i40e_nvmupd_nvm_write(struct i40e_hw *hw,
-				 struct i40e_nvm_access *cmd,
-				 u8 *bytes, int *perrno)
+void i40e_nvmupd_check_wait_event(struct i40e_hw *hw, u16 opcode,
+				  struct i40e_aq_desc *desc)
 {
-	struct i40e_asq_cmd_details cmd_details;
-	u8 module, transaction;
-	u8 preservation_flags;
-	int status = 0;
-	bool last;
-
-	transaction = i40e_nvmupd_get_transaction(cmd->config);
-	module = i40e_nvmupd_get_module(cmd->config);
-	last = (transaction & I40E_NVM_LCB);
-	preservation_flags = i40e_nvmupd_get_preservation_flags(cmd->config);
-
-	memset(&cmd_details, 0, sizeof(cmd_details));
-	cmd_details.wb_desc = &hw->nvm_wb_desc;
+	u32 aq_desc_len = sizeof(struct i40e_aq_desc);
 
-	status = i40e_aq_update_nvm(hw, module, cmd->offset,
-				    (u16)cmd->data_size, bytes, last,
-				    preservation_flags, &cmd_details);
-	if (status) {
-		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "i40e_nvmupd_nvm_write mod 0x%x off 0x%x len 0x%x\n",
-			   module, cmd->offset, cmd->data_size);
-		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "i40e_nvmupd_nvm_write status %d aq %d\n",
-			   status, hw->aq.asq_last_status);
-		*perrno = i40e_aq_rc_to_posix(status, hw->aq.asq_last_status);
+	if (opcode == hw->nvm_wait_opcode) {
+		memcpy(&hw->nvm_aq_event_desc, desc, aq_desc_len);
+		i40e_nvmupd_clear_wait_state(hw);
 	}
-
-	return status;
 }
-- 
2.41.0


