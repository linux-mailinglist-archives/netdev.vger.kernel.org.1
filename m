Return-Path: <netdev+bounces-278807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE1dC3ih32mBXAAAu9opvQ
	(envelope-from <netdev+bounces-278807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:32:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B4F405515
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3A4C30F10F5
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB413D5237;
	Wed, 15 Apr 2026 14:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1NxEU0L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC0B3D47A9
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263336; cv=none; b=WC3FsuCIJbzKEzt2aPHZqTOi1oC62vr2YpAh2/To62hzXrS4n+xuG9/H2m0FnswGsJkF/JBMYm/MEzFex/BjCAe8PA5R0PpiXmllrXL3EmomNRiwnoNvgSL1Un440s0MI0QFesJ3OAqfOi/Lut/wCvADCGiZ5qlunbf5QUi1IVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263336; c=relaxed/simple;
	bh=G7MmTf1h+5LioLTjjvjCKQN7jxTwWDeJLS/XSkZaGHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMOw8mfLhbT0Oj7pB9ZoV/+L3qrD4rl85rzlkVHyNiYRnYuynITBRKlAeiqizoMqgUk4Md/OSphJ7sXRRJFbG6DuwWtL09d09HPtOU04G/LJpnlWO5xalLRxY7YNlNbciBdBPDPlkAZ02s+bSlXoPDEd0NhikX26lbp3HkRbBRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1NxEU0L; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776263335; x=1807799335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G7MmTf1h+5LioLTjjvjCKQN7jxTwWDeJLS/XSkZaGHM=;
  b=D1NxEU0L62PEAY2xQ2G+vxw3OHXKWrsDm9qp94xPDSjpaznCKrrX9NIz
   dYo4gEMbVMOweYyvvNwKuXez0Lh2rlHmETbkPdgA02kmWGrQxVNcZ07sB
   oyQo8xS7XgtEgKjzHy5nfIWzBPfBrQHOgjoGoE/PJUPNR8SrtrTFLao5l
   GitSYx2hhTmjHaR7yhXFN1g7R6ve38Sh79G/01BcJi7IMnMYybc97zeK3
   KnMg8gK1a8aPoBOVlqv4NJTqAVGIkUuJrWk6P5yZ7QQ92yYpyUY4fBpMf
   udgo7vVbmeRn2sdzHM+iMpE0Bl/7KrMifS4++a08xF0XPOK6bAMlloJ4+
   A==;
X-CSE-ConnectionGUID: 03IxXrY/RYGoUeReoxysfQ==
X-CSE-MsgGUID: Brlnj7x3RHqpp/5XT/LXEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77423749"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77423749"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:28:53 -0700
X-CSE-ConnectionGUID: kgdYO5kKSESFmxxGDfIxZA==
X-CSE-MsgGUID: jS2xfbJPRre/Vr72p4wZYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234467899"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa003.jf.intel.com with ESMTP; 15 Apr 2026 07:28:52 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v3 6/6] ixgbe: fix integer overflow and wrong bit position in ixgbe_validate_rtr()
Date: Wed, 15 Apr 2026 16:28:41 +0200
Message-ID: <20260415142841.3222399-7-aleksandr.loktionov@intel.com>
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
	TAGGED_FROM(0.00)[bounces-278807-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 88B4F405515
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two bugs in the same loop in ixgbe_validate_rtr():

1. The 3-bit traffic-class field was extracted by shifting a u32 and
   assigning the result directly to a u8.  For user priority 0 this is
   harmless; for UP[5..7] the shift leaves bits [15..21] in the u32
   which are then silently truncated when stored in u8.  Mask with
   IXGBE_RTRUP2TC_UP_MASK before the assignment so only the intended
   3 bits are kept.

2. When clearing an out-of-bounds entry the mask was always shifted by
   the fixed constant IXGBE_RTRUP2TC_UP_SHIFT (== 3), regardless of
   which loop iteration was being processed.  This means only UP1 (bit
   position 3) was ever cleared; UP0,2..7 (positions 0, 6, 9, ..., 21)
   were left unreset, so invalid TC mappings persisted in hardware and
   could mis-steer received packets to the wrong traffic class.
   Use i * IXGBE_RTRUP2TC_UP_SHIFT to target the correct 3-bit field
   for each iteration.

Swap the operand order in the mask expression to place the constant
on the right per kernel coding style (noted by David Laight).

Fixes: 8b1c0b24d9af ("ixgbe: configure minimal packet buffers to support TC")
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2 -> v3:
 - Correct Fixes: tag to 8b1c0b24d9af ("ixgbe: configure minimal packet
   buffers to support TC") -- the previously used e7589eab9291 predates
   the buggy code path (Simon Horman); add Reviewed-by: Simon Horman.

v1 -> v2:
 - Add Fixes: tag; reroute to iwl-net (wrong bit positions cause packet
   mis-steering); swap to (reg >> ...) & MASK operand order per David
   Laight.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 210c7b9..c9e4f12 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9772,11 +9772,12 @@ static void ixgbe_validate_rtr(struct ixgbe_adapter *adapter, u8 tc)
 	rsave = reg;
 
 	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
-		u8 up2tc = reg >> (i * IXGBE_RTRUP2TC_UP_SHIFT);
+		u8 up2tc = (reg >> (i * IXGBE_RTRUP2TC_UP_SHIFT)) &
+			   IXGBE_RTRUP2TC_UP_MASK;
 
 		/* If up2tc is out of bounds default to zero */
 		if (up2tc > tc)
-			reg &= ~(0x7 << IXGBE_RTRUP2TC_UP_SHIFT);
+			reg &= ~(IXGBE_RTRUP2TC_UP_MASK << (i * IXGBE_RTRUP2TC_UP_SHIFT));
 	}
 
 	if (reg != rsave)
-- 
2.52.0

