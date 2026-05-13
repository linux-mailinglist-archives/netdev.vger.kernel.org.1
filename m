Return-Path: <netdev+bounces-287462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULoCNM0vBGo/FAIAu9opvQ
	(envelope-from <netdev+bounces-287462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:01:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB4052F403
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AF8D305B5BC
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 07:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46E73D4104;
	Wed, 13 May 2026 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.b="NRzl3BKr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB037388860
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659036; cv=none; b=h/cUoaRJElwRx7Frax3ooCFq2DPBJU8Fr5K2qTsO9XvWjKtVhOxAZEVmpwVNObUhnY9PrnYScALT/5jGCoc8ZPZj0rEE47dYxiDmwRA2CiHsFmfL3oas2+0c2i9agYW8knWmgRRXu3InFc1hW8EA9hGTm2kjsv6/IcCsUAz1rsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659036; c=relaxed/simple;
	bh=sFtA+HgQm3ShT9dWVbPWcfXsIzN0gORmR58s42PMidE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 MIME-Version; b=m9m+EcYSbUEQXGd9HjjP0n4Dlsmw6MdFOtGf6qL3Ag4SjnlKZ+wWwdPHvXN/OgJifrMCqBeNQfULCK9uZWLyD7tGV4g6A2e5HhKJ4Pfoer0YzlqD4AomFzdFVBvjOmOm6rzvm9ahsqVmVozw4sqHqfe7PJvVvPMwdpCI2v6RPic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=fail (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.b=NRzl3BKr reason="signature verification failed"; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-CSE-ConnectionGUID: Smg6HJz4RCiY6ESsRSsFMw==
X-CSE-MsgGUID: h2G7M3CnTFuu8y3Sr4DEUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83452589"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="83452589"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 00:57:15 -0700
X-CSE-ConnectionGUID: SZA11QtnRyyzKXVNNlTiyw==
X-CSE-MsgGUID: Z4mS42wGTyGshimAKfhEIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="261759670"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa001.fm.intel.com with ESMTP; 13 May 2026 00:57:12 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	"Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>
Subject: [Intel-wired-lan] [PATCH iwl-net v4 0/5] ixgbe: five bug fixes
Date: Wed, 13 May 2026 09:57:05 +0200
Message-ID: <20260415142841.3222399-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Submitter: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Patchwork-Id: 2223534
X-Original-To: incoming@patchwork.ozlabs.org
Delivered-To: patchwork-incoming@legolas.ozlabs.org
Authentication-Results: legolas.ozlabs.org; dkim=pass (2048-bit key; unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=NRzl3BKr; dkim-atps=neutral
Authentication-Results: legolas.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=osuosl.org (client-ip=2605:bc80:3010::136; helo=smtp3.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=patchwork.ozlabs.org)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384) (No client certificate requested) by legolas.ozlabs.org (Postfix) with ESMTPS id 4fwk6B1nqKz1yHc for <incoming@patchwork.ozlabs.org>; Thu, 16 Apr 2026 00:28:50 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1]) by smtp3.osuosl.org (Postfix) with ESMTP id 894586F74C; Wed, 15 Apr 2026 14:28:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1]) by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP id FnbI4ZRmUeo1; Wed, 15 Apr 2026 14:28:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B622360A99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org; s=default; t=1776263327; bh=ZfNvl0Kunf0DdZLk/YTbsgC+1j2q8T2AlszBZI08EeM=; h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive: List-Post:List-Help:List-Subscribe:From; b=NRzl3BKr/YHPlAqIULugIgAJCSV1OpwCYQ2O8jx+tVuY4W6bf5ESXynJpgwLl3K52 ETsmb2mEHpYdzfIvrNj6+TAzif2Ji0lbuCC8l6xb97vO8HmT7eADpaDiTCb/TTbDIL t27SbPOQxSMvtlwW4S8o7SmeVRXfndzHMRjaT6NfW+fsYby9MCtTsV2FeP0skwe5/0 EpeU/nf2WQXBWIPxxFbtEB5nZCfrNHWw27hoQ9DQENmvQELTICzu6MX2mIUg0B/+hH 1psag83uqewSFXaoGb0Fx6eEMUNiCKYYFoIueuFOe9Ir11hyK3HQatAALXTC3ocmSi +fxN59EmtRcbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142]) by smtp3.osuosl.org (Postfix) with ESMTP id B622360A99; Wed, 15 Apr 2026 14:28:47 +0000 (UTC)
X-Original-To: intel-wired-lan@lists.osuosl.org
Delivered-To: intel-wired-lan@lists.osuosl.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137]) by lists1.osuosl.org (Postfix) with ESMTP id C09B0375 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1]) by smtp4.osuosl.org (Postfix) with ESMTP id A94674B0ED for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1]) by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP id IixoYCJvafrd for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C67AA4AF73
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C67AA4AF73
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16]) by smtp4.osuosl.org (Postfix) with ESMTPS id C67AA4AF73 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:44 +0000 (UTC)
X-CSE-ConnectionGUID: zbt6vZWKS9KwjrC+8s4Nfw==
X-CSE-MsgGUID: no0+SUdcSoCwNbAX6bTQ1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77423726"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="77423726"
Received: from orviesa003.jf.intel.com ([10.64.159.143]) by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:28:43 -0700
X-CSE-ConnectionGUID: 3CeTPOSiQZ6o5qn6eSGebw==
X-CSE-MsgGUID: HNKefGP3R3a9pY2lsv6PCQ==
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="234467814"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225]) by orviesa003.jf.intel.com with ESMTP; 15 Apr 2026 07:28:42 -0700
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=intel.com; i=@intel.com; q=dns/txt; s=Intel; t=1776263325; x=1807799325; h=from:to:cc:subject:date:message-id:mime-version: content-transfer-encoding; bh=hGYpdPt5f7E7jW84kiyLG0thuZ8oo2TpL9uLwiLJ2N4=; b=CS23Bf8dqLFTshtEgaioP/FGn31MUZbaqGNCy8h01L8fyeJDgc/MxQOA vpW8Prbe6hhVjjxSfo6tznH+42hlaCbNeHCcvALUULYnsIWkIPRnq3CLr gYZX+ifJwOobBr5QUtbxkDHJkNyNyD0b+mdxFUZ34z6ac8HglsLNgto8X GcAzXWCFCgcTHiIlbt3JMEpM1/a2XWiE/T0w0quaijLwSsAzwCK901Uti CmwFUMX4oVE1DOefS4SWO3g1ZZuy9PDqliJ1yVFw3b6508Sla1fUgkoqB r0kJDlOPdLi20fihdenABFP2W7Xhhs9S76k3AKS1m/UxjciC+r20EAZ1o w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CS23Bf8d
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3BB4052F403
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.59 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[osuosl.org:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.20)[mailman];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[intel.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287462-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[osuosl.org:-];
	RCVD_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.473];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid]
X-Rspamd-Action: no action

Five fixes for the ixgbe driver, covering a SWFW semaphore timeout
miscalculation, a broken flow-control NVM-reset path, a false-success
return in the cls_u32 nexthdr path, an adaptive-ITR u8 overflow, and
wrong bit positions in the UP-to-TC register normalisation.

Patches 1-2 fix issues that could result in functional regressions
(FW update failures, traffic stall after NVM update).
Patches 3-5 fix correctness bugs with user-visible effects.

Patch 2 guards against calling setup_fc() on 82599 backplane links:
on those interfaces setup_fc() resolves to prot_autoc_write() ->
ixgbe_reset_pipeline_82599(), which toggles IXGBE_AUTOC_AN_RESTART
and causes an infinite link-flap loop.  setup_fc() is now skipped for
ixgbe_media_type_backplane; fc_enable() is still called.  The failure-
path guard introduced in v2 (skip fc_enable when setup_fc fails) is
preserved.

Patch 4 reworks the ITR write-back to keep the mode flag
(IXGBE_ITR_ADAPTIVE_LATENCY, bit 7) and the usec delay in separate
operands until the final store, and clamps the delay to
[IXGBE_ITR_ADAPTIVE_MIN_USECS, IXGBE_ITR_ADAPTIVE_MAX_USECS] via
clamp_val().

Patch 5 corrects the Fixes: tag to 8b1c0b24d9af ("ixgbe: configure
minimal packet buffers to support TC") per Simon Horman.

Changes in v4:
 - DROPPED "ixgbe: add bounds check for debugfs register access"
   (was 2/6 in v3).  The WARN_ON_ONCE(reg > IXGBE_HFDR) guard added
   to ixgbe_read_reg() fires on legitimate driver code paths on
   X550EM_a / E610 (LKV): probe reads IXGBE_EEC(hw), which on those
   parts resolves to IXGBE_EEC_X550EM_a == 0x15FF8, exceeding
   IXGBE_HFDR == 0x15FE8.  IXGBE_LINKS_10G_LANE_SYNC (0x17000) is
   another in-driver register beyond IXGBE_HFDR.  The premise of the
   patch -- that IXGBE_HFDR is the highest valid MMIO offset -- is
   incorrect, so the read-side guard cannot be retained as written,
   and the debugfs-side bound suffers from the same wrong ceiling.
   A correct debugfs-only bound (against pci_resource_len(BAR0)) will
   be sent separately if/when needed; that work is outside the scope
   of these -net fixes.  Reported by Larysa Zaremba.
 - 1/5 (was 1/6), 2/5 (was 3/6), 3/5 (was 4/6), 4/5 (was 5/6),
   5/5 (was 6/6): renumbered only; no code or commit-message change.

Changes in v3:
 - cover: removed Patch 1 squash-history description (v1->v2 background
          no longer needed in the cover letter).
 - 1/6: add Reviewed-by: Simon Horman, Reviewed-by: Jacob Keller;
        no code change (Jacob suggested read_poll_timeout() but
        accepted as-is for net).
 - 2/6: add Reviewed-by: Simon Horman; no code change.
 - 3/6: add backplane-link guard in ixgbe_watchdog_update_link();
        skip setup_fc() when media type is ixgbe_media_type_backplane
        to prevent infinite link-flap on 82599 backplane interfaces.
 - 4/6: add Reviewed-by: Simon Horman; no code change.
 - 5/6: rework clamping -- use clamp_val() with mode and delay as
        separate operands; clamp to [IXGBE_ITR_ADAPTIVE_MIN_USECS,
        IXGBE_ITR_ADAPTIVE_MAX_USECS] instead of LATENCY-1.
 - 6/6: correct Fixes: tag to 8b1c0b24d9af; add Reviewed-by:
        Simon Horman.

Changes in v2:
 - 1/6: Squash two patches; fix commit msg ("200ms" -> "1s"); three
        explicit mac.type == comparisons instead of range check.
 - 2/6: Add Fixes: tag; reroute from iwl-next to iwl-net.
 - 3/6: Add Fixes: tag; reroute to iwl-net; skip fc_enable() when
        setup_fc() fails to avoid committing stale FC state.
 - 4/6: Add Fixes: tag; reroute from iwl-next to iwl-net.
 - 5/6: Add proper [N/M] patch numbering.
 - 6/6: Reroute to iwl-net; swap to (expr >> ..) & MASK operand order.
---

Aleksandr Loktionov (5):
  ixgbe: fix SWFW semaphore timeout for X550 family
  ixgbe: call ixgbe_setup_fc() before fc_enable() after NVM update
  ixgbe: fix cls_u32 nexthdr path returning success when no entry installed
  ixgbe: fix ITR value overflow in adaptive interrupt throttling
  ixgbe: fix integer overflow and wrong bit position in ixgbe_validate_rtr()

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 16 ++++++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |  8 ++++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

