Return-Path: <netdev+bounces-278804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNdFMkei32miXAAAu9opvQ
	(envelope-from <netdev+bounces-278804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:35:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6294055A8
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BE5130B22A6
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D0D3D47B4;
	Wed, 15 Apr 2026 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CO4VJZbo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27243D3D1E
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263330; cv=none; b=ZXujfnHwE6dYnAsArrp9/LrOKxLxAAUlLvsINWsFud4iBH9GJtQ/6P2LBfoK3DXxJkeDQY5R+RnwWzjSFRxvMTQM5v4xAdC1QfPtesQkCwL+EK0Nu5F9xEA9xD6IzJr/F3v5sqBsLb7I0iqCWiEMieLquJuYsNwASxFImfS9OjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263330; c=relaxed/simple;
	bh=TGdgV50bxeF5VneOtp3k0+KNHoKWBcOE5NH18XEnokc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hq0Fpj6h7pUuK2ynj2Yq1pHcT8UYMyjE2BIeGUYz3qBbRDxR2EwTxSAdHrm5VNasZjBYPdAsOcgEzF6Bxks2UV0Per6CN4BEP+h1uIlW+p3w/Qjxs8EUSEGmTUjHTCAClhsjRYJA1p6UaOeS1lbH/25SegKxtxKXbrlJTC/F53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CO4VJZbo; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776263329; x=1807799329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TGdgV50bxeF5VneOtp3k0+KNHoKWBcOE5NH18XEnokc=;
  b=CO4VJZbolJy7MxG9ZEF7JVdtMMn2HwA5kpUKXE8t7zUai+b3hFHaSn9E
   4kAc2k3lP09wysux5p6tb51WjlQdGTG6PS0aqB7ICYd+532HsOc8LaPtR
   jnr0AVOT4jb0wKdySIVsjy15cXV4vin/72jMXZ/AsfzYN0Zp4FRbIkmnD
   VHhWJWgR3M8DEw8eP+ZEepfiiHaVNqnGls/51RAF+N5DOyr5rCURhzixb
   vp7HqGb0oBsRXj9N+Lt/922YVXQVb/0ZY0kgiN8Ay5x4IUl1QwpKBFhOf
   OIFVxuT9SC05gkC+PMmoH0uK3vk4MBd/Ik/VX2sc55ejZ9KJu/BJGlflo
   g==;
X-CSE-ConnectionGUID: kvndRMRwQYCeG1ZPIsUs3w==
X-CSE-MsgGUID: p/4ZXg9IRN6lour7on3KKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77423738"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77423738"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:28:48 -0700
X-CSE-ConnectionGUID: hEZbVS5VQyS9lDfZNZSLpQ==
X-CSE-MsgGUID: DCC3lyWYQqqoOGpiW8fkbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234467859"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa003.jf.intel.com with ESMTP; 15 Apr 2026 07:28:47 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v3 3/6] ixgbe: call ixgbe_setup_fc() before fc_enable() after NVM update
Date: Wed, 15 Apr 2026 16:28:38 +0200
Message-ID: <20260415142841.3222399-4-aleksandr.loktionov@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278804-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E6294055A8
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

Skip setup_fc() on backplane links: on 82599 backplane interfaces
setup_fc() resolves to prot_autoc_write() ->
ixgbe_reset_pipeline_82599() which toggles IXGBE_AUTOC_AN_RESTART.
Calling it unconditionally on link-up creates an infinite link-flap
loop because each AN-restart triggers another link-up event.  Guard
with a get_media_type() check and skip setup_fc() when the media type
is ixgbe_media_type_backplane; fc_enable() is still called.

Also handle the failure path: if setup_fc() returns an error its output
is invalid and calling fc_enable() on the unchanged hardware state would
repeat the exact MDD-triggering condition the fix is meant to prevent.
Skip fc_enable() in that case while still calling
ixgbe_set_rx_drop_en() which configures the independent RX-drop
behaviour.

Fixes: 93c52dd0033b ("ixgbe: Merge watchdog functionality into service task")
Suggested-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2 -> v3:
 - Skip setup_fc() for ixgbe_media_type_backplane: unconditional call on
   82599 backplane links triggers prot_autoc_write() ->
   ixgbe_reset_pipeline_82599() -> IXGBE_AUTOC_AN_RESTART, causing an
   infinite link-flap loop (Simon Horman).

v1 -> v2:
 - Add Fixes: tag; reroute to iwl-net; handle setup_fc() failure by
   skipping fc_enable() so stale FC state is never committed to hardware.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 210c7b9..fc3bae9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8029,6 +8029,18 @@ static void ixgbe_watchdog_update_link(struct ixgbe_adapter *adapter)
 		pfc_en |= !!(adapter->ixgbe_ieee_pfc->pfc_en);
 
 	if (link_up && !((adapter->flags & IXGBE_FLAG_DCB_ENABLED) && pfc_en)) {
-		hw->mac.ops.fc_enable(hw);
+		/* Skip setup_fc() on backplane links: it resolves to
+		 * prot_autoc_write() -> ixgbe_reset_pipeline_82599() and
+		 * toggles IXGBE_AUTOC_AN_RESTART, causing infinite link-flap
+		 * on 82599 backplane interfaces.
+		 * If setup_fc() fails its output is invalid; skip fc_enable()
+		 * to avoid committing stale capability bits that trigger MDD.
+		 */
+		if (hw->mac.ops.setup_fc &&
+		    hw->mac.ops.get_media_type(hw) != ixgbe_media_type_backplane &&
+		    hw->mac.ops.setup_fc(hw))
+			e_warn(drv, "setup_fc failed, skipping fc_enable\n");
+		else
+			hw->mac.ops.fc_enable(hw);
 		ixgbe_set_rx_drop_en(adapter);
 	}
-- 
2.52.0

