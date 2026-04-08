Return-Path: <netdev+bounces-276547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN74IX9U1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:13:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6723BCAC9
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9038430651E4
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 13:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23EC3CE493;
	Wed,  8 Apr 2026 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfQoJFkF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA9D3C873F
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653947; cv=none; b=nC4vnmDDcxfYJjB8RAAKQQZf1GVabtleVQ0kcCfiVIDK+uBApJlx0z1hVbC03n+wzKcLEbyAeL1QMoRZtNOUNR6spXrS2TD7wxip3ZoggI7arn4fDu2/xjaXxKcPTn80w9qknMRh4h8zF1jVVfn5KQKO/8ua+Tm9LlrArFDzs4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653947; c=relaxed/simple;
	bh=Kqq495al0fixHxITQwzw8FJCfkmaTNXmJ8mDt7IdcGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpYL+ewZIFnLwlzBj7ISWr0O06vWsP4BWIJwR82etg1gc2fKTX+JRMU4RcOt0rmdqeI2cRh8y+y7B4XKsOHmYnjPVfehvZVswtT/cZncfCvBmzDX1bYsB73ZyrSGNCiWSDPzotAAxmajwwAJW3MUyjUOvNzFJ0Iw7ILWpsEzSvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfQoJFkF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775653946; x=1807189946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kqq495al0fixHxITQwzw8FJCfkmaTNXmJ8mDt7IdcGo=;
  b=OfQoJFkFzV+tvpr3sX1CUS3DTFB67Ys8v/aLlr2pvBBejcQsgFBtCtuq
   JCXLDqFVn9zGjbJHfxBqonYOSVcFSaX6rnhXNfrsky7ywvciqj2p2JVwr
   L2ARAilihZVHl6grG94Y6WSXCjgqP3U2pd0yDDuMaGMis0Obp3x4pAccn
   Qx4XKsj19VpvlWNCGfedZAt3b9CQp5zXdShOkPhKGE0r89lHZO9c+a25A
   I2p3rX5X/sgDREcQAZZyzJIYYHLxkGcfLi3SScYsJEkKxGK+t7NRTUNY6
   jPbU9mBQV/GVhEnrWFGSi+HefXUxjoYnb95RzURuEeqqMs3VBcKE9hWtw
   g==;
X-CSE-ConnectionGUID: PsmlFdYyTsOyS6NX6LLbUQ==
X-CSE-MsgGUID: j/98SvjVSCyApwVHIMDQGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="102087282"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="102087282"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 06:12:26 -0700
X-CSE-ConnectionGUID: +B6SeTRFSZyabaTTLmNT2g==
X-CSE-MsgGUID: rX3SN5HwTG+tC10sUiu4Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="228715100"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa007.jf.intel.com with ESMTP; 08 Apr 2026 06:12:25 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v2 5/8] ixgbe: remove ixgbe_ping_all_vfs() from link state change handlers
Date: Wed,  8 Apr 2026 15:12:13 +0200
Message-ID: <20260408131216.2662245-6-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
References: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276547-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F6723BCAC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When multiple VFs are brought up simultaneously, a VF can receive a
CTS (Clear To Send) mailbox message instead of the expected RESET |
(N)ACK response, because the watchdog fires a gratuitous ping right as
the VF mailbox transaction is in progress.

Remove the ixgbe_ping_all_vfs() call from both ixgbe_watchdog_link_is_up()
and ixgbe_watchdog_link_is_down().  Both paths contain an identical call
with the same race window during VF initialization: link-state changes
(up or down) can arrive while VFs are mid-initialization, and the
gratuitous ping from either direction collides with the VF mailbox state
machine for the same reason.

Link-state changes are already communicated to VFs through the normal
mailbox protocol; these extra pings are redundant on both paths.

Suggested-by: Sebastian Basierski <sebastianx.basierski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1 -> v2:
 - Extend fix to also remove ixgbe_ping_all_vfs() from
   ixgbe_watchdog_link_is_down(), which carries the same race window;
   justifies the asymmetry by eliminating it.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 1885fe8..7c3d821 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8151,9 +8151,6 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 
 	/* update the default user priority for VFs */
 	ixgbe_update_default_up(adapter);
-
-	/* ping all the active vfs to let them know link has changed */
-	ixgbe_ping_all_vfs(adapter);
 }
 
 /**
@@ -8183,8 +8180,5 @@ static void ixgbe_watchdog_link_is_down(struct ixgbe_adapter *adapter)
 	e_info(drv, "NIC Link is Down\n");
 	netif_carrier_off(netdev);
-
-	/* ping all the active vfs to let them know link has changed */
-	ixgbe_ping_all_vfs(adapter);
 }
 
 static bool ixgbe_ring_tx_pending(struct ixgbe_adapter *adapter)
-- 
2.52.0

