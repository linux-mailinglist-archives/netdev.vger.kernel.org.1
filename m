Return-Path: <netdev+bounces-272415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEgWFs8yxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:33:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D1334077D
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99BF030474AE
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75433CD8C6;
	Fri, 27 Mar 2026 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/q9SHZA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C26C3CCFDE
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596670; cv=none; b=cp4kOWcjrjiHo0WVhPDN9eDE7B5In9eH+XfEd3xOQpT6+iC7YKwEp2npveepSLlXc/DC7SS8GpXF6wEojFqQfO3LCIybRAwG6Z6YkG/219aVtX5KxTAsD2mYJP8S+hszMmwiHoZwGopP7+cOsLU8CkZn4UXQ4GCRAPuDHLYUDCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596670; c=relaxed/simple;
	bh=Hilwd6wmLhVdcH05Km0NTcg0JGgAPDArrIlWyELkXNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxcnNT+yZKb+dh5887WKk5biS6EFl38zOYDg1HKQADLAlcg32Ehfa7S5ZC7C4NV+Scz3Wp0xGGW/u/sBsRkMzy20WJvx0UJVS4CX1d9EtAHIf5J2so5S8nS804JhTWDeALPV0uZj+VrEZrl82i3cKzAUaihO+xpOJaIh4ldCm90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/q9SHZA; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596663; x=1806132663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hilwd6wmLhVdcH05Km0NTcg0JGgAPDArrIlWyELkXNU=;
  b=G/q9SHZAuiJCTVTUaCr9khWWsN9N8H4UV3K+eIvyGcMUv1xIy3STTupq
   AXbEKoSpotMnImsd74zszHOn7QYLOK7kt+RN/fJb2KaIeM9kmFM0sW5P8
   MNKGsFj89IDc8YPtERbTzR43qOC33L6dYCtUY41uIgHfvCJkpKObidL2T
   oMQvNdqbr7NX4anooh0PqmJisqo6S9fpQIdVIgq6JXxuAzN3vwu6TSqf2
   ZljfNuXWg6cw1+h1/H2xkbXb1AWSsD3v6Raw+Wnc368IxYJ7mjNGsgcjn
   5KzWE15j1eNGvOju+2sILVR3Matlnhqd6j6xvfSLeDgZxvlytmHV85iZj
   Q==;
X-CSE-ConnectionGUID: LgBHb9h+R0CFm6OMmBhEXw==
X-CSE-MsgGUID: oVCSWF+KTPS5tM/1yJzsTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75734319"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75734319"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:30:56 -0700
X-CSE-ConnectionGUID: NfVt3QrVR9SQ3aRWJamXHQ==
X-CSE-MsgGUID: IDICe1k5S/m3D9QIyM3DWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255740381"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:30:55 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next] ixgbe: call ixgbe_setup_fc() before fc_enable() after NVM update
Date: Fri, 27 Mar 2026 08:30:40 +0100
Message-ID: <20260327073046.134085-6-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272415-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 58D1334077D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Radoslaw Tyl <radoslawx.tyl@intel.com>

During an NVM update the PHY reset clears the Technology Ability Field
(IEEE 802.3 clause 37 register 7.10) back to hardware defaults.  When
the driver subsequently calls only hw->mac.ops.fc_enable() the SRRCTL
register is recalculated from the stale autonegotiated capability bits,
which the MDD (Malicious Driver Detect) logic treats as an invalid
change and halts traffic on the PF.

Fix by calling ixgbe_setup_fc() immediately before fc_enable() in
ixgbe_watchdog_update_link() so that flow-control autoneg and the
PHY registers are re-programmed in the correct order after any reset.

Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 52f0cdc..db954e9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8041,6 +8041,12 @@ static void ixgbe_watchdog_update_link(struct ixgbe_adapter *adapter)
 		pfc_en |= !!(adapter->ixgbe_ieee_pfc->pfc_en);
 
 	if (link_up && !((adapter->flags & IXGBE_FLAG_DCB_ENABLED) && pfc_en)) {
+		if (hw->mac.ops.setup_fc) {
+			int err = hw->mac.ops.setup_fc(hw);
+
+			if (err)
+				e_warn(drv, "setup_fc failed: %d\n", err);
+		}
 		hw->mac.ops.fc_enable(hw);
 		ixgbe_set_rx_drop_en(adapter);
 	}
-- 
2.52.0


