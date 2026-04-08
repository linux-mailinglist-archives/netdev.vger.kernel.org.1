Return-Path: <netdev+bounces-276538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPpHIIpV1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:18:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3E03BCB94
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 125A1306EB49
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 13:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A2D3B9D89;
	Wed,  8 Apr 2026 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHjJ4RLw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5F23CAE7D
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653925; cv=none; b=Ug7QJCR6WZBwbZyypxAlJqyFqc1pJRaRdApd2XXnsmZTIT6ttdUfRUUqSLDiJu3P80n/k/FfJGUWluBwxeC9ktPDlr8A4o22LcAgQNjjc4WDumhxMNjDcT/rojnniFdiXuBVb4UvYXxKUrLubVwVxSTxLtaPL/fvaWj/09jGpoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653925; c=relaxed/simple;
	bh=yQAXDpgBHYrZWGNoOaXRbwm61fkcniHXP8DOyif6ekw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBY+ZlnuyMcJqNd1gGXkrvyt/G7nF3BzVLoO0UqmzAuAx+JbZk0JLk5ZqnZoUKqwrNQhTWtbjJ3uhvHii3IqPE72YD+5J4IKa/fwSK2rcAxG4yLX+EZsuW5BrQl/o/3qY0eIMA3WS+RdTX62wKag0P6GH6fA+8xEqU6ItOUaJ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHjJ4RLw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775653921; x=1807189921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yQAXDpgBHYrZWGNoOaXRbwm61fkcniHXP8DOyif6ekw=;
  b=lHjJ4RLwdqVFWMI0d4nX/fpjtLGIIZ9N8BEzfE55kZf3aatPBgqsiogU
   ij/P1ps02l/P7ApHXGrUhPXMR5fyLndgp5svRiTle3Egh+J67QPfbBJnq
   esqtoMQMTCNQNXhJJkNVnabpL1XMxzn8ynL751wMeviub84NvXIgSut1g
   4OorICsq31LzJemJnWTXqpq59aQK0v9Hc+YhDLcBSP9Q7j35pKNTfv2ft
   zz8tjipT4xMPdR8LNFwgnfCKY0GLHQ0PgYsiqujfxe3+Iz0zNUKwboBDT
   vt9COB5vhGOafGJGRKsod/hkul6uLzcjXPzjjuhTCajVfM3yrqsiJbISc
   w==;
X-CSE-ConnectionGUID: y6lQ+HwfS725t8xD9DedUg==
X-CSE-MsgGUID: Un6Vmg6iT++heGZUxTL6MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="102087231"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="102087231"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 06:12:01 -0700
X-CSE-ConnectionGUID: PE5/I+TxTr6jA8UzHR0T5A==
X-CSE-MsgGUID: 1fLCnSvsQXiQYuldeXuDaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="228714957"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa007.jf.intel.com with ESMTP; 08 Apr 2026 06:12:00 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v2 3/6] ixgbe: call ixgbe_setup_fc() before fc_enable() after NVM update
Date: Wed,  8 Apr 2026 15:11:51 +0200
Message-ID: <20260408131154.2661818-4-aleksandr.loktionov@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276538-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC3E03BCB94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During an NVM update the PHY reset clears the Technology Ability Field
(IEEE 802.3 clause 37 register 7.10) back to hardware defaults.  When
the driver subsequently calls only hw->mac.ops.fc_enable() the SRRCTL
register is recalculated from stale autonegotiated capability bits,
which the MDD (Malicious Driver Detect) logic treats as an invalid
change and halts traffic on the PF.

Fix by calling ixgbe_setup_fc() immediately before fc_enable() in
ixgbe_watchdog_update_link() so that flow-control autoneg and the PHY
registers are re-programmed in the correct order after any reset.

Handle the failure path explicitly: if setup_fc() returns an error its
output is invalid and calling fc_enable() on the unchanged hardware
state would repeat the exact MDD-triggering condition the fix is meant
to prevent.  Skip fc_enable() in that case while still calling
ixgbe_set_rx_drop_en() which configures the independent RX-drop
behaviour.

Fixes: 93c52dd0033b ("ixgbe: Merge watchdog functionality into service task")
Suggested-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1 -> v2:
 - Add Fixes: tag; reroute to iwl-net; handle setup_fc() failure by
   skipping fc_enable() so stale FC state is never committed to hardware.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 210c7b9..fc3bae9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8029,6 +8029,13 @@ static void ixgbe_watchdog_update_link(struct ixgbe_adapter *adapter)
 		pfc_en |= !!(adapter->ixgbe_ieee_pfc->pfc_en);
 
 	if (link_up && !((adapter->flags & IXGBE_FLAG_DCB_ENABLED) && pfc_en)) {
-		hw->mac.ops.fc_enable(hw);
+		/* Re-program flow-control autoneg before applying the result.
+		 * If setup_fc() fails its output is invalid; skip fc_enable()
+		 * to avoid committing stale capability bits that trigger MDD.
+		 */
+		if (hw->mac.ops.setup_fc && hw->mac.ops.setup_fc(hw))
+			e_warn(drv, "setup_fc failed, skipping fc_enable\n");
+		else
+			hw->mac.ops.fc_enable(hw);
 		ixgbe_set_rx_drop_en(adapter);
 	}
-- 
2.52.0

