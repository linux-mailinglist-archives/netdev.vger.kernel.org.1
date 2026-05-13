Return-Path: <netdev+bounces-287463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKabHegvBGo/FAIAu9opvQ
	(envelope-from <netdev+bounces-287463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:01:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB5052F418
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 337B430789E4
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 07:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF013D7A14;
	Wed, 13 May 2026 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.b="eEddseY7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB183EDE4C
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659038; cv=none; b=oRH7vwtDUawrpvOym01lFgGLckaB3EUxr+7iV0FLvS/uuYmC0xH1tUAEcBbInCSNx+HjdIQgmd5U9Il//MQqVvtlTKywJ5aUewbqTpAS5nToZCa9FniWZvW0DbEPkMwsPKStm3zuyLDljmi0jnJOsmNrLFciEu8QNpR+fozDvv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659038; c=relaxed/simple;
	bh=KZoB+xveeT+KuN6nEyMuNnQ/ld1ZWDs6D9auT1RYmBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version:MIME-Version; b=BhOQZdX3E1Lx6eeLZBnarqfRcW3lpZLj1fHbl475oDZ5uQ01v1MyTFvXtlN9TAfYj4D5koOfo3OE3jIuUXRMjvi3EgI8JEe30limfA8ieMxhyJLkMrbxidLjaMQ1AYkk/6O09xgMlu9ZfpHvfYR1BCFupiMZoSInMtNY1t5fyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=fail (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.b=eEddseY7 reason="signature verification failed"; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-CSE-ConnectionGUID: cwbOjZOiSDKt06xQEo7MWA==
X-CSE-MsgGUID: N/8Amfj1SJiRYmByI0hHlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83452595"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="83452595"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 00:57:16 -0700
X-CSE-ConnectionGUID: 1rlKStmBR9GNBnWqEi/JWQ==
X-CSE-MsgGUID: SDPhhe/wTiW5WZdX9FR2mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="261759674"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa001.fm.intel.com with ESMTP; 13 May 2026 00:57:14 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>
Subject: [Intel-wired-lan] [PATCH iwl-net v4 1/5] ixgbe: fix SWFW semaphore timeout for X550 family
Date: Wed, 13 May 2026 09:57:06 +0200
Message-ID: <20260415142841.3222399-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260415142841.3222399-1-aleksandr.loktionov@intel.com>
References: <20260415142841.3222399-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Submitter: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Patchwork-Id: 2223535
X-Patchwork-Delegate: anthony.l.nguyen@intel.com
X-Original-To: incoming@patchwork.ozlabs.org
Delivered-To: patchwork-incoming@legolas.ozlabs.org
Authentication-Results: legolas.ozlabs.org; dkim=pass (2048-bit key; unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=eEddseY7; dkim-atps=neutral
Authentication-Results: legolas.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=osuosl.org (client-ip=140.211.166.137; helo=smtp4.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=patchwork.ozlabs.org)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384) (No client certificate requested) by legolas.ozlabs.org (Postfix) with ESMTPS id 4fwk6G1pjPz1yHc for <incoming@patchwork.ozlabs.org>; Thu, 16 Apr 2026 00:28:54 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1]) by smtp4.osuosl.org (Postfix) with ESMTP id EA7924B0ED; Wed, 15 Apr 2026 14:28:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1]) by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP id UHn1yJIM_1MU; Wed, 15 Apr 2026 14:28:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 931654B08F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org; s=default; t=1776263330; bh=OcZDITMIuszZw8Rk9/XENma4MVinhqEcJqCy5y9ZdC0=; h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id: List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe: From; b=eEddseY7Yj83BxrkpoYjoH6/DoqWZ5t4Q/Nli4zYwUHLTKG4vJpDF6ibE3ZByow9+ p5WvqvFkXJhWX8E6XUYiroRJlCo7Pve0Q2loUMCtDqGZHmAB/qHFoqnQQs2Snlbznn KsEa7UI41+v3x0ssWfwuRmLlJVUA15OacDNbaE6SQe3N0wJz68v0ReMPUjHg4PeZkR vI/vOXLsU/ohc5jvFwW5Qm+1YQE/8tDB2/wX/q4yEmxNpwQSeDD0VIBDZtGEKme9ve KveXHHJVa6SnRC9l2Xo4YHfN8EOsh/YJWvpij9n+nho6Q6wqNcKfiAyE5zhY98bGSM hu3ngSRjVj+Og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142]) by smtp4.osuosl.org (Postfix) with ESMTP id 931654B08F; Wed, 15 Apr 2026 14:28:50 +0000 (UTC)
X-Original-To: intel-wired-lan@lists.osuosl.org
Delivered-To: intel-wired-lan@lists.osuosl.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137]) by lists1.osuosl.org (Postfix) with ESMTP id D2217283 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1]) by smtp4.osuosl.org (Postfix) with ESMTP id B7C2D4AF73 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1]) by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP id Gr95nognu6PK for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B95C54B08F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B95C54B08F
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16]) by smtp4.osuosl.org (Postfix) with ESMTPS id B95C54B08F for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:45 +0000 (UTC)
X-CSE-ConnectionGUID: 7K5yiF+VSfKyilbjddlI7w==
X-CSE-MsgGUID: 1iRrIEQjRnK8/WuKtoMecQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77423729"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="77423729"
Received: from orviesa003.jf.intel.com ([10.64.159.143]) by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:28:45 -0700
X-CSE-ConnectionGUID: p8WwbvmeQryNK1OaKDX03Q==
X-CSE-MsgGUID: LFzYkiuVSZuRDUCnJd0bmQ==
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="234467829"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225]) by orviesa003.jf.intel.com with ESMTP; 15 Apr 2026 07:28:43 -0700
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=intel.com; i=@intel.com; q=dns/txt; s=Intel; t=1776263325; x=1807799325; h=from:to:cc:subject:date:message-id:in-reply-to: references:mime-version:content-transfer-encoding; bh=GUF4ORCJjHX1uOeyka72W243jz1bbjHEIX86BDqtL08=; b=nDdDUI5kNjOW8zdwoPmL/eBlW6q3GxuvnhVudc1gJB9uOgMK0d/qVHcW DiJtK/eVvxGf590rUHu3JZgTNJQvOrxObU/IrEXQhlc+ji744cYdT2Ngs 76E6QVcIacXxURkKvcd3/cIDzMOBYP+mHSZXXL0ctoLF5YECxNcmc7iOs MgSfZCk0oaRrSudxM6cgY7hOVD06Rhcg8QBPI8pVkckQbr6iEFgdQ9mIM Wbi99VnfUTxlmnsYRG9ZCUGl+0AG8NF0lVyMLezE6BEx9as2V6XeasU0M FQJcCxkuoEl2i05T4CFKD7DE0fXp08V9p9L8Sa1hgjhS2npQf6FnFdxfG A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nDdDUI5k
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0AB5052F418
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.59 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[osuosl.org:s=default];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.20)[mailman];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[intel.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287463-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[osuosl.org:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[intel.com:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[intel.com:query timed out];
	NEURAL_HAM(-0.00)[-0.490];
	RCVD_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid]
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

