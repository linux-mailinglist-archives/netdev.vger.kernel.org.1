Return-Path: <netdev+bounces-278803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDTgFT+h32kEWwAAu9opvQ
	(envelope-from <netdev+bounces-278803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:31:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B004054E2
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 203F130DDEB7
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1A83D34BF;
	Wed, 15 Apr 2026 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xi0OEULs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3DF3D522F
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263328; cv=none; b=Z/t9ssFrFKOST6tFGEr1z/aiPlhLMLzdYRbiEnHZzPPZrDuwdUn/qaAufNkqYo6gTxBV7TnYh+zvKTkFCp/atrQb+Ff9E1G+bWCQ97ZuPr0o1tYJS2w8HGQVPmUi6wFKJ1uMPIf/GTnY+8slOm0xLdjYUqOXivumW5AAu4jUQGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263328; c=relaxed/simple;
	bh=7SKNB46uDZXM8jxmPX4sCXW57soOfjv8FO2okC82C6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFmmZ2TLp3DlBW9lC4y7n9DL6BWJDutMxbEUDfGdz+qnjXebA1UplhLYmEcGwb0XBzMrOPNwjFoFMLXRkrrfQp/j42iIecDJXIxBk8bbQTZambYQvSkaJEuXbSZ6kZY3Fo02PdBOAkW5IY8B7TvU02RUoR/R/VCYtPBJa9ojGNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xi0OEULs; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776263327; x=1807799327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7SKNB46uDZXM8jxmPX4sCXW57soOfjv8FO2okC82C6E=;
  b=Xi0OEULszxz0vtcTeR7IBK0IbQr/1O3YVbnSDvYE0LqbvMXcd01AVPJr
   Pf4QZ60yr9t3t3tXT0dMYuIr8Fm8aMq+k17VRU6gKDKmRGkPHmCrCIZks
   4QXjbPCBlqQ3RMoKPjXkK+HCToG1Wll/NTMk/TYHUpt5LzF1HrkvVDiUa
   1iELFbg8aDid7GUdsA5QYnnsLcK/IPWCRz1k8uxGJWns5cCL2QKaiAd9Y
   C+b24tuPA10h2dJDPyY/b6cFoz3nMtZzrdspREY6Ztz/i3HhlVVc4g1sg
   21SEhftmIorJ1o/REyq4wnHXO6n3yT2nZQavdtRpzwxUPnevC4wxWuCVI
   w==;
X-CSE-ConnectionGUID: S8fiEsUWQUKDGLx/zXIUHw==
X-CSE-MsgGUID: 4F12zDBOSGq7oxVuJe4z/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77423732"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77423732"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:28:47 -0700
X-CSE-ConnectionGUID: SOHqTdJeQsaxJ5FIc2m7SA==
X-CSE-MsgGUID: a9nUnyS4SQCZ01l5LPg53g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234467850"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa003.jf.intel.com with ESMTP; 15 Apr 2026 07:28:45 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v3 2/6] ixgbe: add bounds check for debugfs register access
Date: Wed, 15 Apr 2026 16:28:37 +0200
Message-ID: <20260415142841.3222399-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260415142841.3222399-1-aleksandr.loktionov@intel.com>
References: <20260415142841.3222399-1-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278803-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1B004054E2
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
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2 -> v3:
 - Add Reviewed-by: Simon Horman; no code change.

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

