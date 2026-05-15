Return-Path: <netdev+bounces-288430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AdcA0huB2rY2gIAu9opvQ
	(envelope-from <netdev+bounces-288430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:04:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB8C55693B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 781903019F1D
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551D4385D77;
	Fri, 15 May 2026 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQwo2b3O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BF9382384
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778871863; cv=none; b=e999jFytGcw2fsJFwMBOcd4UgDrohQdSAaDZA61W3W9jf+3ypQjHj6lsfC9GMpEJd9dgE0Uzy2v20bxTu511j0uS1iHER9VqH7gYGS1o3FQFRlKsm8ToapMhVg/m+hPRUkOHzipCCmPQ3f+DHFnRWl+plFawF1wLkaE0nr5pd3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778871863; c=relaxed/simple;
	bh=GUF4ORCJjHX1uOeyka72W243jz1bbjHEIX86BDqtL08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7vcMwrahj/HkKxjU5rzSuer7bC71pejNb3WzH+LJpQR2I9Rui3Y0ePAY/9dVxpJqSv1fP63eaWtRtGJyZ+Rl29jmo7Zy5JDUs/6qcPv5bEaYPiMZp0wLTkxphaF/2cf+EXYk3N4vpsYKJL3Epf2t34kci/a6U/oSj+Dc1wPoTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQwo2b3O; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778871861; x=1810407861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GUF4ORCJjHX1uOeyka72W243jz1bbjHEIX86BDqtL08=;
  b=dQwo2b3OQJACYtk0mcsXbLLnbW/J4xr+p9clkKPm1G+Ce5TMlM+Lfj8b
   +tmX2Gn5mkOSwt2P91Ew/TBShen3Bb1z/bfu/JJvXrj0l4N0kUhTiXAdV
   6MtWN72kZlHc5nEL+S7NIr7thuF3EQS4CFaYmWY/fXA8p6/zya3vH5zqh
   tJNvfYF8li3/zT7j8yC1B83ww2BJlcFF6knczR+PNBJbboAeZxWM5Phgl
   cJgUAYyH28Tnv+HUtHVaH7I9abOhikHZ2mruq4cIfq8tgnhxuymk1NavQ
   x4mU03/8oRsk+FfAsCZqkX0a+VUX2aFMUbuwAxlOIXIRdNlh25omOKLHZ
   g==;
X-CSE-ConnectionGUID: 8cx21tF1TY2GyJtk0CFKkQ==
X-CSE-MsgGUID: WTfGad3VTiukT5Z47I6wQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79725696"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79725696"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 12:04:21 -0700
X-CSE-ConnectionGUID: V++jsmtkTIO+5h1SVIVAUg==
X-CSE-MsgGUID: 0/3cyI3xQiKauoJoCHYrww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="238895624"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa009.jf.intel.com with ESMTP; 15 May 2026 12:04:20 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-net v5 1/4] ixgbe: fix SWFW semaphore timeout for X550 family
Date: Fri, 15 May 2026 21:04:14 +0200
Message-ID: <20260515090000.5112345-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515090000.5112345-1-aleksandr.loktionov@intel.com>
References: <20260515090000.5112345-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5EB8C55693B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-288430-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

According to FW documentation, the most time-consuming FW operation is
Shadow RAM (SR) dump which takes up to 3.2 seconds.  For X550 family
devices the module-update FW command can take over 4.5 s.  The default
semaphore loop runs 200 iterations with a 5 ms sleep each, giving a
maximum wait of 1 s -- not "200 ms" as previously stated in error.
This is insufficient for X550 family FW update operations and causes
spurious EBUSY failures.

Extend the SW/FW semaphore timeout from 1 s to 5 s (1000 iterations x
5 ms) for all three X550 variants: ixgbe_mac_X550, ixgbe_mac_X550EM_x,
and ixgbe_mac_x550em_a.  All three share the same FW and exhibit the
same worst-case latency.  Use three explicit mac.type comparisons rather
than a range check so future MAC additions are not inadvertently
captured.

The timeout variable is set immediately before the loop so the intent
is clear, with an inline comment stating the resulting maximum delay.

Fixes: 030eaece2d77 ("ixgbe: Add x550 SW/FW semaphore support")
Suggested-by: Soumen Karmakar <soumen.karmakar@intel.com>
Suggested-by: Marta Plantykow <marta.a.plantykow@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
v2 -> v3:
 - Add Reviewed-by: Simon Horman, Reviewed-by: Jacob Keller; no code
   change (Jacob suggested read_poll_timeout() but accepted as-is).

v1 -> v2:
 - Squash with 0015 (X550EM extension); fix commit message ("200ms" was
   wrong, actual default is 1 s); replace >= / <= range check with three
   explicit mac.type == comparisons per Tony Nguyen.

 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index e67e2fe..a3c8f51 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -577,6 +577,15 @@ int ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask)
 
 	swmask |= swi2c_mask;
 	fwmask |= swi2c_mask << 2;
+	/* Extend to 5 s (1000 x 5 ms) for X550 family; default is 1 s
+	 * (200 x 5 ms).  FW SR-dump takes up to 3.2 s; module-update up
+	 * to 4.5 s.
+	 */
+	if (hw->mac.type == ixgbe_mac_X550 ||
+	    hw->mac.type == ixgbe_mac_X550EM_x ||
+	    hw->mac.type == ixgbe_mac_x550em_a)
+		timeout = 1000;
+
 	for (i = 0; i < timeout; i++) {
 		/* SW NVM semaphore bit is used for access to all
 		 * SW_FW_SYNC bits (not just NVM)
-- 
2.52.0

