Return-Path: <netdev+bounces-269406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOw9LeLau2k6pAIAu9opvQ
	(envelope-from <netdev+bounces-269406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:15:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BCB2CA214
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C689C3017265
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FCE3C6A5F;
	Thu, 19 Mar 2026 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hoAIAzCA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD7E379EFD
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918942; cv=none; b=BIJb+t1iflhR/5PwXc+MP9SB6fpQFqx5zWvPqwdrreMZCC2HYc8Yz9yHcE7o3qZ6g1BwOI7orZpae3sNBkPjt+IJl6mwFr6D/xxVBzVAa2B67+eAfQC0Z4UlgVF8Uq7Ck8Zc2fVdeWrX1x2qNjfUtkyMmzs5sxqnF33mUGwP7TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918942; c=relaxed/simple;
	bh=b3u8qHqjs+0jCYSUxvjLhz4Rrt+YcdNbJ5aChfrAIdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sK9jP3+OHcQvFB+LBRZMqdVZimeDBV28GXZg111qQYQNxa249/5hqN/uNRt50khpnehX3VJBsXgk6awSXj4lxllJbIewsG2E2bugmzwBtdMYou0/pcaHrLxLPpw2dO9qKn60306dW+IG6DT0EdKh32AGVrSJqVL8qJEy/irLYGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoAIAzCA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773918940; x=1805454940;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b3u8qHqjs+0jCYSUxvjLhz4Rrt+YcdNbJ5aChfrAIdg=;
  b=hoAIAzCAtKZ6x005r8aqxzRJLGfkf9iJ+STY2VG7Zim4ncoxS6oIArvp
   UmYvxOuU3govG146B2DNCW6Bb4PKnfacRo9s+238luuW8NApP5HrBClsI
   uO8GdaqbQKBCVk3z3gJImItLp+ZWh4S5jLbqMPGni65osfaOl2CXb+UVK
   /qQ803uzVK0l/jRCPxUH4ttys1Pvpl2q4rWRy9bri0OTYRAOkbsAd8bsE
   15VNnoJvqsmPf4/gspw9U5Kvr0+OrslRs5pORvNFjrATGm4x5kGiBsEzX
   RBUBp7M3zEnFHTPBUz9xjC0z1XeM9t+6ki5Agz6cwPXzIVmLjvZPCku1P
   Q==;
X-CSE-ConnectionGUID: VrIS6EI4QTeNuejPk0R/QA==
X-CSE-MsgGUID: Gs+5mRUXR++WyAPZBIb80Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="100446753"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="100446753"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 04:15:40 -0700
X-CSE-ConnectionGUID: AffE8heKRyec2BTK0xZLsw==
X-CSE-MsgGUID: RLvw22A1RIih9nqtA2HKzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227871884"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by orviesa005.jf.intel.com with ESMTP; 19 Mar 2026 04:15:37 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-net v2] ice: fix posted write support for sideband queue operations
Date: Thu, 19 Mar 2026 12:13:27 +0100
Message-ID: <20260319111659.551039-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269406-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msg.data:url,intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32BCB2CA214
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On E830, PTP time adjustment commands sent via
SBQ don't generate completion responses, causing the driver to
timeout waiting and return -EIO, when trying:

phc_ctl eth8 get adj 2 get
dmesg: ice 0000:1a:00.0: PTP failed to adjust time, err -5

Add support for posted mode not to wait for completion response.

Fixes: 8f5ee3c477a8 ("ice: add support for sideband messages")
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
v2:
- change "postpone" to "posted"
- init struct with {} instead of {0}
v1:
https://lore.kernel.org/intel-wired-lan/20260310110700.345904-1-przemyslaw.korba@intel.com/

 drivers/net/ethernet/intel/ice/ice_common.c   | 7 ++++++-
 drivers/net/ethernet/intel/ice/ice_controlq.c | 4 ++++
 drivers/net/ethernet/intel/ice/ice_controlq.h | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 8866902efb91..c89c6ca1281b 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1765,6 +1765,7 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flags)
 {
 	struct ice_sbq_cmd_desc desc = {0};
 	struct ice_sbq_msg_req msg = {0};
+	struct ice_sq_cd cd = {};
 	u16 msg_len;
 	int status;
 
@@ -1785,10 +1786,14 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flags)
 		 */
 		msg_len -= sizeof(msg.data);
 
+	if (in->opcode == ice_sbq_msg_wr)
+		cd.posted = 1;
+
 	desc.flags = cpu_to_le16(flags);
 	desc.opcode = cpu_to_le16(ice_sbq_opc_neigh_dev_req);
 	desc.param0.cmd_len = cpu_to_le16(msg_len);
-	status = ice_sbq_send_cmd(hw, &desc, &msg, msg_len, NULL);
+	status = ice_sbq_send_cmd(hw, &desc, &msg, msg_len, &cd);
+
 	if (!status && !in->opcode)
 		in->data = le32_to_cpu
 			(((struct ice_sbq_msg_cmpl *)&msg)->data);
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index dcb837cadd18..a6008dc77fa4 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -1086,6 +1086,10 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	wr32(hw, cq->sq.tail, cq->sq.next_to_use);
 	ice_flush(hw);
 
+	/* If the message is posted, don't wait for completion. */
+	if (cd && cd->posted)
+		goto sq_send_command_error;
+
 	/* Wait for the command to complete. If it finishes within the
 	 * timeout, copy the descriptor back to temp.
 	 */
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
index 788040dd662e..c50d6fcbacba 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.h
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
@@ -77,6 +77,7 @@ struct ice_ctl_q_ring {
 /* sq transaction details */
 struct ice_sq_cd {
 	struct libie_aq_desc *wb_desc;
+	u8 posted : 1;
 };
 
 /* rq event information */

base-commit: acd2abc52dea91c3bc3d1b6dd8a92b9631d48bbf
-- 
2.43.0


