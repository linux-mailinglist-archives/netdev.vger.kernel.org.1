Return-Path: <netdev+bounces-276537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPkcNF9V1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:17:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE273BCB7D
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 038D63064CE5
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7520F3CBE95;
	Wed,  8 Apr 2026 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HigbuAdB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185893CCFB0
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653921; cv=none; b=eCtbWep/IxH+D4OZjW0gyJIzSTxk+wqPFXpxD9gG+yhGA2A+T+ZVRLmq5VYy/5ZvMNSFEMxyqsdZZJnf4j77RrmAlHyrSeRAmCUGUhwWzWBGx1L9P9/E/tREHop12bPwESSIOeEf0DXDT2Wf9/nyZ+cxBMDW+QWjDWWXHY1d790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653921; c=relaxed/simple;
	bh=6Gpm78H9t2C6etiRw2hqX9OI9lfPgYaJTQ33kuwqqOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3p9DK2CZZFIFddR/DKPmTvMKT6YfKXPvaHAfbGI6v0iaHMNlVb1S37yXeDDd5O0GIURo5mrJllat1BT+CjQnOl9hdB3Z4AohUjIuILHMtR9CjsyjHzb4p3snoRevILQGRlH/AEwanKExIZxnWBvyRUB1eB6Umb7P0YV2k5P5Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HigbuAdB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775653920; x=1807189920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Gpm78H9t2C6etiRw2hqX9OI9lfPgYaJTQ33kuwqqOU=;
  b=HigbuAdBkW4Vv6v7C600E1vMlYMLodfhRfIyj1rKP8tmIa1T0fu8Snyy
   iP3v5JTeOlK2eiljFkdkaAEJz6wulCi6qWDePEvbDU88X9yge7O7MMmH/
   TL6nrig0W0HiYn1j62g1Bx0G2r7BNc64jFAw9EmMVOHVeOjxrRhfLnfCi
   TZyltFRUAgc512jfCH9RxJe463PMYAld+rZ8e5zeQ8FCa0TbDCsZxMg3R
   2zz4F/mq5aw/XmXyhV7dC/Moco/u+Hd3XMNPupTudRWRnSfpQlOJQK7EK
   5GXCEkD2m3Ahi0k7zsD8Y7K+MNHyx5HbusQY6VzBJeaIFDp6kdBF1VrMi
   A==;
X-CSE-ConnectionGUID: syc2Kc15SZu6F3HXxRnVAw==
X-CSE-MsgGUID: oupka7XVTliMGx0TGBflZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="102087229"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="102087229"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 06:12:00 -0700
X-CSE-ConnectionGUID: rUHFCMYtRA2GMS7NnUPfyA==
X-CSE-MsgGUID: 50q468FFT7aSpIcd5UV7jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="228714949"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa007.jf.intel.com with ESMTP; 08 Apr 2026 06:11:59 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-net v2 2/6] ixgbe: add bounds check for debugfs register access
Date: Wed,  8 Apr 2026 15:11:50 +0200
Message-ID: <20260408131154.2661818-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408131154.2661818-1-aleksandr.loktionov@intel.com>
References: <20260408131154.2661818-1-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276537-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CE273BCB7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paul Greenwalt <paul.greenwalt@intel.com>

Prevent out-of-bounds MMIO accesses triggered through user-controlled
register offsets.  IXGBE_HFDR (0x15FE8) is the highest valid MMIO
register in the ixgbe register map; any offset beyond it would address
unmapped memory.

Add a defense-in-depth check at two levels:

1. ixgbe_read_reg() -- the noinline register read accessor.  A
   WARN_ON_ONCE() guard here catches any future code path (including
   ioctl extensions) that might inadvertently pass an out-of-range
   offset without relying on higher layers to catch it first.
   ixgbe_write_reg() is a static inline called from the TX/RX hot path;
   adding WARN_ON_ONCE there would inline the check at every call site,
   so only the read path gets this guard.

2. ixgbe_dbg_reg_ops_write() -- the debugfs 'reg_ops' interface is the
   only current path where a raw, user-supplied offset enters the driver.
   Gating it before invoking the register accessors provides a clean,
   user-visible failure (silent ignore with no kernel splat) for
   deliberately malformed debugfs writes.

Add a reg <= IXGBE_HFDR guard to both the read and write paths in
ixgbe_dbg_reg_ops_write(), and a WARN_ON_ONCE + early-return guard to
ixgbe_read_reg().

Fixes: 91fbd8f081e2 ("ixgbe: added reg_ops file to debugfs")
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1 -> v2:
 - Add Fixes: tag; reroute from iwl-next to iwl-net (security-relevant
   hardening for user-controllable out-of-bounds MMIO).

 drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c | 6 ++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
index 5b1cf49d..a6a19c0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
@@ -86,7 +86,8 @@ static ssize_t ixgbe_dbg_reg_ops_write(struct file *filp,
 		u32 reg, value;
 		int cnt;
 		cnt = sscanf(&ixgbe_dbg_reg_ops_buf[5], "%x %x", &reg, &value);
-		if (cnt == 2) {
+		/* bounds-check register offset */
+		if (cnt == 2 && reg <= IXGBE_HFDR) {
 			IXGBE_WRITE_REG(&adapter->hw, reg, value);
 			value = IXGBE_READ_REG(&adapter->hw, reg);
 			e_dev_info("write: 0x%08x = 0x%08x\n", reg, value);
@@ -97,7 +98,8 @@ static ssize_t ixgbe_dbg_reg_ops_write(struct file *filp,
 		u32 reg, value;
 		int cnt;
 		cnt = sscanf(&ixgbe_dbg_reg_ops_buf[4], "%x", &reg);
-		if (cnt == 1) {
+		/* bounds-check register offset */
+		if (cnt == 1 && reg <= IXGBE_HFDR) {
 			value = IXGBE_READ_REG(&adapter->hw, reg);
 			e_dev_info("read 0x%08x = 0x%08x\n", reg, value);
 		} else {

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 210c7b9..4a1f3c2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -354,4 +354,6 @@ u32 ixgbe_read_reg(struct ixgbe_hw *hw, u32 reg)
 	if (ixgbe_removed(reg_addr))
 		return IXGBE_FAILED_READ_REG;
+	if (WARN_ON_ONCE(reg > IXGBE_HFDR))
+		return IXGBE_FAILED_READ_REG;
 	if (unlikely(hw->phy.nw_mng_if_sel &
 		     IXGBE_NW_MNG_IF_SEL_SGMII_ENABLE)) {
-- 
2.52.0

