Return-Path: <netdev+bounces-154790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFABE9FFCD7
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9CF3A313C
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFED188904;
	Thu,  2 Jan 2025 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Nxg9V8MU"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDDE17C208;
	Thu,  2 Jan 2025 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839462; cv=none; b=r2ytShR3vElta05gJwzGrKjbUTP4bddj1PHq7AUtqvSg5LYVwTIyY7zN6/y6DA3nJKlMEy5dYzbjH8OhgLjI9Vx0TlFNCLybW2w29BOILAbLOW+N3y4qOlgYvn7zeJnAfTqbrc2zFxLvlCpWi6gWlsCXnnCX1z5PF/hUfa8QJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839462; c=relaxed/simple;
	bh=THk/CI6IGG4//+bLjYWD00OFy96eGO0DJEBYF+Mto0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHoDe01cNS54VMux0Asv47adzj3JHDQx9jMZagPX/Bjs8LJQ+DVAdXvejcMFoQC1JPq3nyG09qcDOuw0jgUICQAoCePptOH6R8rRkO/tZcEERpgQhEg1SWSFaKMAuWeaQWEWwkP+zJwX/sNFoYC+mCOLkRu5JBkZYUkp34kSQLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Nxg9V8MU; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=6RZC6qGh6bLupeUDC/pC2m87XKKYdykRY/VXQqRmfA4=; b=Nxg9V8MU8CsMt2DE
	vWIglnnKDKZ4P7QdcWQKY019ECtG8gnI8PVj1OwYIv0aySfvwJoWQgLcPZ6aLxbr2RTtaF6Y+A/l5
	w/yush7SokyKF6K0or98aF9vMgSN41npCTvvf3UAbstsL6Ar1lVB+I19h8nPps383fnGkANol+lLP
	gxYoLkvds6RrGvyWD7g7UTqfgdgs7cCON0TTwQx1XkFWZLf1gE/QfeOmu5AbSjBBTnjbiyKRaRoXb
	STp8ErK91MM8G9BDcMOAxuyuBWHfvtS9NjoYg+j5JHkezflAxbWXWjyGetY7nN7gRaQQBwTqUm/qH
	Xqrxz2GxbNaOvCuAAA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tTP8K-007tod-2p;
	Thu, 02 Jan 2025 17:37:20 +0000
From: linux@treblig.org
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next 1/9] i40e: Deadcode i40e_aq_*
Date: Thu,  2 Jan 2025 17:37:09 +0000
Message-ID: <20250102173717.200359-2-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102173717.200359-1-linux@treblig.org>
References: <20250102173717.200359-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

i40e_aq_add_mirrorrule(), i40e_aq_delete_mirrorrule() and
i40e_aq_set_vsi_vlan_promisc() were added in 2016 by
commit 7bd6875bef70 ("i40e: APIs to Add/remove port mirroring rules")
but haven't been used.

They were the last user of i40e_mirrorrule_op().

i40e_aq_rearrange_nvm() was added in 2018 by
commit f05798b4ff82 ("i40e: Add AQ command for rearrange NVM structure")
but hasn't been used.

i40e_aq_restore_lldp() was added in 2019 by
commit c65e78f87f81 ("i40e: Further implementation of LLDP")
but hasn't been used.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 234 ------------------
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  17 --
 2 files changed, 251 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index e8031f1a9b4f..47e71f72d87b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1804,37 +1804,6 @@ int i40e_aq_set_vsi_broadcast(struct i40e_hw *hw,
 	return status;
 }
 
-/**
- * i40e_aq_set_vsi_vlan_promisc - control the VLAN promiscuous setting
- * @hw: pointer to the hw struct
- * @seid: vsi number
- * @enable: set MAC L2 layer unicast promiscuous enable/disable for a given VLAN
- * @cmd_details: pointer to command details structure or NULL
- **/
-int i40e_aq_set_vsi_vlan_promisc(struct i40e_hw *hw,
-				 u16 seid, bool enable,
-				 struct i40e_asq_cmd_details *cmd_details)
-{
-	struct i40e_aq_desc desc;
-	struct i40e_aqc_set_vsi_promiscuous_modes *cmd =
-		(struct i40e_aqc_set_vsi_promiscuous_modes *)&desc.params.raw;
-	u16 flags = 0;
-	int status;
-
-	i40e_fill_default_direct_cmd_desc(&desc,
-					i40e_aqc_opc_set_vsi_promiscuous_modes);
-	if (enable)
-		flags |= I40E_AQC_SET_VSI_PROMISC_VLAN;
-
-	cmd->promiscuous_flags = cpu_to_le16(flags);
-	cmd->valid_flags = cpu_to_le16(I40E_AQC_SET_VSI_PROMISC_VLAN);
-	cmd->seid = cpu_to_le16(seid);
-
-	status = i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
-
-	return status;
-}
-
 /**
  * i40e_aq_get_vsi_params - get VSI configuration info
  * @hw: pointer to the hw struct
@@ -2435,136 +2404,6 @@ i40e_aq_remove_macvlan_v2(struct i40e_hw *hw, u16 seid,
 						 cmd_details, true, aq_status);
 }
 
-/**
- * i40e_mirrorrule_op - Internal helper function to add/delete mirror rule
- * @hw: pointer to the hw struct
- * @opcode: AQ opcode for add or delete mirror rule
- * @sw_seid: Switch SEID (to which rule refers)
- * @rule_type: Rule Type (ingress/egress/VLAN)
- * @id: Destination VSI SEID or Rule ID
- * @count: length of the list
- * @mr_list: list of mirrored VSI SEIDs or VLAN IDs
- * @cmd_details: pointer to command details structure or NULL
- * @rule_id: Rule ID returned from FW
- * @rules_used: Number of rules used in internal switch
- * @rules_free: Number of rules free in internal switch
- *
- * Add/Delete a mirror rule to a specific switch. Mirror rules are supported for
- * VEBs/VEPA elements only
- **/
-static int i40e_mirrorrule_op(struct i40e_hw *hw,
-			      u16 opcode, u16 sw_seid, u16 rule_type, u16 id,
-			      u16 count, __le16 *mr_list,
-			      struct i40e_asq_cmd_details *cmd_details,
-			      u16 *rule_id, u16 *rules_used, u16 *rules_free)
-{
-	struct i40e_aq_desc desc;
-	struct i40e_aqc_add_delete_mirror_rule *cmd =
-		(struct i40e_aqc_add_delete_mirror_rule *)&desc.params.raw;
-	struct i40e_aqc_add_delete_mirror_rule_completion *resp =
-	(struct i40e_aqc_add_delete_mirror_rule_completion *)&desc.params.raw;
-	u16 buf_size;
-	int status;
-
-	buf_size = count * sizeof(*mr_list);
-
-	/* prep the rest of the request */
-	i40e_fill_default_direct_cmd_desc(&desc, opcode);
-	cmd->seid = cpu_to_le16(sw_seid);
-	cmd->rule_type = cpu_to_le16(rule_type &
-				     I40E_AQC_MIRROR_RULE_TYPE_MASK);
-	cmd->num_entries = cpu_to_le16(count);
-	/* Dest VSI for add, rule_id for delete */
-	cmd->destination = cpu_to_le16(id);
-	if (mr_list) {
-		desc.flags |= cpu_to_le16((u16)(I40E_AQ_FLAG_BUF |
-						I40E_AQ_FLAG_RD));
-		if (buf_size > I40E_AQ_LARGE_BUF)
-			desc.flags |= cpu_to_le16((u16)I40E_AQ_FLAG_LB);
-	}
-
-	status = i40e_asq_send_command(hw, &desc, mr_list, buf_size,
-				       cmd_details);
-	if (!status ||
-	    hw->aq.asq_last_status == I40E_AQ_RC_ENOSPC) {
-		if (rule_id)
-			*rule_id = le16_to_cpu(resp->rule_id);
-		if (rules_used)
-			*rules_used = le16_to_cpu(resp->mirror_rules_used);
-		if (rules_free)
-			*rules_free = le16_to_cpu(resp->mirror_rules_free);
-	}
-	return status;
-}
-
-/**
- * i40e_aq_add_mirrorrule - add a mirror rule
- * @hw: pointer to the hw struct
- * @sw_seid: Switch SEID (to which rule refers)
- * @rule_type: Rule Type (ingress/egress/VLAN)
- * @dest_vsi: SEID of VSI to which packets will be mirrored
- * @count: length of the list
- * @mr_list: list of mirrored VSI SEIDs or VLAN IDs
- * @cmd_details: pointer to command details structure or NULL
- * @rule_id: Rule ID returned from FW
- * @rules_used: Number of rules used in internal switch
- * @rules_free: Number of rules free in internal switch
- *
- * Add mirror rule. Mirror rules are supported for VEBs or VEPA elements only
- **/
-int i40e_aq_add_mirrorrule(struct i40e_hw *hw, u16 sw_seid,
-			   u16 rule_type, u16 dest_vsi, u16 count,
-			   __le16 *mr_list,
-			   struct i40e_asq_cmd_details *cmd_details,
-			   u16 *rule_id, u16 *rules_used, u16 *rules_free)
-{
-	if (!(rule_type == I40E_AQC_MIRROR_RULE_TYPE_ALL_INGRESS ||
-	    rule_type == I40E_AQC_MIRROR_RULE_TYPE_ALL_EGRESS)) {
-		if (count == 0 || !mr_list)
-			return -EINVAL;
-	}
-
-	return i40e_mirrorrule_op(hw, i40e_aqc_opc_add_mirror_rule, sw_seid,
-				  rule_type, dest_vsi, count, mr_list,
-				  cmd_details, rule_id, rules_used, rules_free);
-}
-
-/**
- * i40e_aq_delete_mirrorrule - delete a mirror rule
- * @hw: pointer to the hw struct
- * @sw_seid: Switch SEID (to which rule refers)
- * @rule_type: Rule Type (ingress/egress/VLAN)
- * @count: length of the list
- * @rule_id: Rule ID that is returned in the receive desc as part of
- *		add_mirrorrule.
- * @mr_list: list of mirrored VLAN IDs to be removed
- * @cmd_details: pointer to command details structure or NULL
- * @rules_used: Number of rules used in internal switch
- * @rules_free: Number of rules free in internal switch
- *
- * Delete a mirror rule. Mirror rules are supported for VEBs/VEPA elements only
- **/
-int i40e_aq_delete_mirrorrule(struct i40e_hw *hw, u16 sw_seid,
-			      u16 rule_type, u16 rule_id, u16 count,
-			      __le16 *mr_list,
-			      struct i40e_asq_cmd_details *cmd_details,
-			      u16 *rules_used, u16 *rules_free)
-{
-	/* Rule ID has to be valid except rule_type: INGRESS VLAN mirroring */
-	if (rule_type == I40E_AQC_MIRROR_RULE_TYPE_VLAN) {
-		/* count and mr_list shall be valid for rule_type INGRESS VLAN
-		 * mirroring. For other rule_type, count and rule_type should
-		 * not matter.
-		 */
-		if (count == 0 || !mr_list)
-			return -EINVAL;
-	}
-
-	return i40e_mirrorrule_op(hw, i40e_aqc_opc_delete_mirror_rule, sw_seid,
-				  rule_type, rule_id, count, mr_list,
-				  cmd_details, NULL, rules_used, rules_free);
-}
-
 /**
  * i40e_aq_send_msg_to_vf
  * @hw: pointer to the hardware structure
@@ -3179,41 +3018,6 @@ int i40e_aq_update_nvm(struct i40e_hw *hw, u8 module_pointer,
 	return status;
 }
 
-/**
- * i40e_aq_rearrange_nvm
- * @hw: pointer to the hw struct
- * @rearrange_nvm: defines direction of rearrangement
- * @cmd_details: pointer to command details structure or NULL
- *
- * Rearrange NVM structure, available only for transition FW
- **/
-int i40e_aq_rearrange_nvm(struct i40e_hw *hw,
-			  u8 rearrange_nvm,
-			  struct i40e_asq_cmd_details *cmd_details)
-{
-	struct i40e_aqc_nvm_update *cmd;
-	struct i40e_aq_desc desc;
-	int status;
-
-	cmd = (struct i40e_aqc_nvm_update *)&desc.params.raw;
-
-	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_nvm_update);
-
-	rearrange_nvm &= (I40E_AQ_NVM_REARRANGE_TO_FLAT |
-			 I40E_AQ_NVM_REARRANGE_TO_STRUCT);
-
-	if (!rearrange_nvm) {
-		status = -EINVAL;
-		goto i40e_aq_rearrange_nvm_exit;
-	}
-
-	cmd->command_flags |= rearrange_nvm;
-	status = i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
-
-i40e_aq_rearrange_nvm_exit:
-	return status;
-}
-
 /**
  * i40e_aq_get_lldp_mib
  * @hw: pointer to the hw struct
@@ -3334,44 +3138,6 @@ int i40e_aq_cfg_lldp_mib_change_event(struct i40e_hw *hw,
 	return status;
 }
 
-/**
- * i40e_aq_restore_lldp
- * @hw: pointer to the hw struct
- * @setting: pointer to factory setting variable or NULL
- * @restore: True if factory settings should be restored
- * @cmd_details: pointer to command details structure or NULL
- *
- * Restore LLDP Agent factory settings if @restore set to True. In other case
- * only returns factory setting in AQ response.
- **/
-int
-i40e_aq_restore_lldp(struct i40e_hw *hw, u8 *setting, bool restore,
-		     struct i40e_asq_cmd_details *cmd_details)
-{
-	struct i40e_aq_desc desc;
-	struct i40e_aqc_lldp_restore *cmd =
-		(struct i40e_aqc_lldp_restore *)&desc.params.raw;
-	int status;
-
-	if (!test_bit(I40E_HW_CAP_FW_LLDP_PERSISTENT, hw->caps)) {
-		i40e_debug(hw, I40E_DEBUG_ALL,
-			   "Restore LLDP not supported by current FW version.\n");
-		return -ENODEV;
-	}
-
-	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_lldp_restore);
-
-	if (restore)
-		cmd->command |= I40E_AQ_LLDP_AGENT_RESTORE;
-
-	status = i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
-
-	if (setting)
-		*setting = cmd->command & 1;
-
-	return status;
-}
-
 /**
  * i40e_aq_stop_lldp
  * @hw: pointer to the hw struct
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 5a0699ca7ce5..29f6a903a30c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -141,9 +141,6 @@ int i40e_aq_set_vsi_uc_promisc_on_vlan(struct i40e_hw *hw,
 int i40e_aq_set_vsi_bc_promisc_on_vlan(struct i40e_hw *hw,
 				       u16 seid, bool enable, u16 vid,
 				       struct i40e_asq_cmd_details *cmd_details);
-int i40e_aq_set_vsi_vlan_promisc(struct i40e_hw *hw,
-				 u16 seid, bool enable,
-				 struct i40e_asq_cmd_details *cmd_details);
 int i40e_aq_get_vsi_params(struct i40e_hw *hw,
 			   struct i40e_vsi_context *vsi_ctx,
 			   struct i40e_asq_cmd_details *cmd_details);
@@ -176,14 +173,6 @@ i40e_aq_remove_macvlan_v2(struct i40e_hw *hw, u16 seid,
 			  struct i40e_aqc_remove_macvlan_element_data *mv_list,
 			  u16 count, struct i40e_asq_cmd_details *cmd_details,
 			  enum i40e_admin_queue_err *aq_status);
-int i40e_aq_add_mirrorrule(struct i40e_hw *hw, u16 sw_seid,
-			   u16 rule_type, u16 dest_vsi, u16 count, __le16 *mr_list,
-			   struct i40e_asq_cmd_details *cmd_details,
-			   u16 *rule_id, u16 *rules_used, u16 *rules_free);
-int i40e_aq_delete_mirrorrule(struct i40e_hw *hw, u16 sw_seid,
-			      u16 rule_type, u16 rule_id, u16 count, __le16 *mr_list,
-			      struct i40e_asq_cmd_details *cmd_details,
-			      u16 *rules_used, u16 *rules_free);
 
 int i40e_aq_send_msg_to_vf(struct i40e_hw *hw, u16 vfid,
 			   u32 v_opcode, u32 v_retval, u8 *msg, u16 msglen,
@@ -220,9 +209,6 @@ int i40e_aq_update_nvm(struct i40e_hw *hw, u8 module_pointer,
 		       u32 offset, u16 length, void *data,
 		       bool last_command, u8 preservation_flags,
 		       struct i40e_asq_cmd_details *cmd_details);
-int i40e_aq_rearrange_nvm(struct i40e_hw *hw,
-			  u8 rearrange_nvm,
-			  struct i40e_asq_cmd_details *cmd_details);
 int i40e_aq_get_lldp_mib(struct i40e_hw *hw, u8 bridge_type,
 			 u8 mib_type, void *buff, u16 buff_size,
 			 u16 *local_len, u16 *remote_len,
@@ -234,9 +220,6 @@ i40e_aq_set_lldp_mib(struct i40e_hw *hw,
 int i40e_aq_cfg_lldp_mib_change_event(struct i40e_hw *hw,
 				      bool enable_update,
 				      struct i40e_asq_cmd_details *cmd_details);
-int
-i40e_aq_restore_lldp(struct i40e_hw *hw, u8 *setting, bool restore,
-		     struct i40e_asq_cmd_details *cmd_details);
 int i40e_aq_stop_lldp(struct i40e_hw *hw, bool shutdown_agent,
 		      bool persist,
 		      struct i40e_asq_cmd_details *cmd_details);
-- 
2.47.1


