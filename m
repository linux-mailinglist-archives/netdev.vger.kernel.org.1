Return-Path: <netdev+bounces-287466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNg6DBMwBGo/FAIAu9opvQ
	(envelope-from <netdev+bounces-287466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:02:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0FC52F427
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BD823116E5C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 07:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A033D7A14;
	Wed, 13 May 2026 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.b="57JK3xJv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6953EDE4C
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659043; cv=none; b=krkKF8PC9GIGjYp64SqeApPpPz+J4rCfjjCnyelWuR7XMW4PpXWrUc7UaCA4TgCQJRgtnpOI/ZgIPsMGjBDlKy6eq3MzUqpvQpEyS32zhawANKEn+OvRgBNYXS4sL1vTAeXfSf03UtolHNNdc4ijoH68fbOyVYwZ/wsTxo+ZLzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659043; c=relaxed/simple;
	bh=yAz+RglgdAEAtekFUqS6ZccWAI7t+8xdmqjOslHrP3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version:MIME-Version; b=Xc/Dm3NWdhwcpaB+gm7u3XTMkDFMlVQQ4lqnrTqNK1UuUPmaxxWnp+41QCxSYANp/8SLHUopTW1UsWocXV2Ava8HPRIUe5QxRIsQiKKM/qsVxYqrea327Ef9vfhjLqNz7Z0NgL+wOVWPRqeKeJQAeafWamdCUPwh6FS9074kk2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=fail (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.b=57JK3xJv reason="signature verification failed"; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-CSE-ConnectionGUID: wrb/4+llSXSNfxV1dz2OxQ==
X-CSE-MsgGUID: s2LQEIeVQMCvsi5v6T8oTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83452609"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="83452609"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 00:57:22 -0700
X-CSE-ConnectionGUID: nt1Ilq+RTamz2iBiEBriaQ==
X-CSE-MsgGUID: 3/nIvSFpQYqqKw3pcRdFXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="261759686"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa001.fm.intel.com with ESMTP; 13 May 2026 00:57:20 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	"Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>,
	Simon Horman <horms@kernel.org>
Subject: [Intel-wired-lan] [PATCH iwl-net v4 4/5] ixgbe: fix ITR value overflow in adaptive interrupt throttling
Date: Wed, 13 May 2026 09:57:09 +0200
Message-ID: <20260415142841.3222399-6-aleksandr.loktionov@intel.com>
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
X-Patchwork-Id: 2223540
X-Patchwork-Delegate: anthony.l.nguyen@intel.com
X-Original-To: incoming@patchwork.ozlabs.org
Delivered-To: patchwork-incoming@legolas.ozlabs.org
Authentication-Results: legolas.ozlabs.org; dkim=pass (2048-bit key; unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=57JK3xJv; dkim-atps=neutral
Authentication-Results: legolas.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=osuosl.org (client-ip=2605:bc80:3010::137; helo=smtp4.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=patchwork.ozlabs.org)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384) (No client certificate requested) by legolas.ozlabs.org (Postfix) with ESMTPS id 4fwk6M4B7Nz1yHc for <incoming@patchwork.ozlabs.org>; Thu, 16 Apr 2026 00:28:59 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1]) by smtp4.osuosl.org (Postfix) with ESMTP id AE4E84B6DA; Wed, 15 Apr 2026 14:28:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1]) by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP id XPM04BgcUUeJ; Wed, 15 Apr 2026 14:28:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D25994B795
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org; s=default; t=1776263335; bh=uaWujFJLTGPpo7w6VGd0NHUa6CrH2MRaI6NNhTf/Zag=; h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id: List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe: From; b=57JK3xJv8odpQmi6PS8uTrCNuSbViac5FmJsNertnZE3tGZTouJJLUBsQlfRO6HBJ YaWiVpHS93r3MXxxm1qmJXmY9kEkK6rjEHIXRsMjLB5Yf7KBACk7mgXOfcN3WmbO+q EG7PPuzBdBL0iZoOxQJK0wsC5P2XgsC2eFEUhUYHJTpguG1jI6GK351Fz+be0qOWl6 eqBcrb2Db2tZqHyJ4WTiyXvNwZMlDpWWuywFO5ImP7fNWwt3cJEJrL6pJiTuYYkLmM utwPkdOCwRmRy7Z0a+Qd2qmalrVAKe43jDIODx3LorDXJs/95XAxpOjKfeqIfipxwR Zup6NVg+6k13A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142]) by smtp4.osuosl.org (Postfix) with ESMTP id D25994B795; Wed, 15 Apr 2026 14:28:55 +0000 (UTC)
X-Original-To: intel-wired-lan@lists.osuosl.org
Delivered-To: intel-wired-lan@lists.osuosl.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138]) by lists1.osuosl.org (Postfix) with ESMTP id 6AE50283 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1]) by smtp1.osuosl.org (Postfix) with ESMTP id 511A48301D for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1]) by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP id FZBmWnwz4fvN for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 00E4D85477
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 00E4D85477
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16]) by smtp1.osuosl.org (Postfix) with ESMTPS id 00E4D85477 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:52 +0000 (UTC)
X-CSE-ConnectionGUID: zqMQCO8dSdWMSwMzLds/fQ==
X-CSE-MsgGUID: aY4V/0F1RJ6anHQYL6WhMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77423746"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="77423746"
Received: from orviesa003.jf.intel.com ([10.64.159.143]) by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:28:51 -0700
X-CSE-ConnectionGUID: 4umZa15tQv22yAIkuPCDRQ==
X-CSE-MsgGUID: DtpY65ZfSrGKTtIAJzAdfg==
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="234467884"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225]) by orviesa003.jf.intel.com with ESMTP; 15 Apr 2026 07:28:50 -0700
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=intel.com; i=@intel.com; q=dns/txt; s=Intel; t=1776263333; x=1807799333; h=from:to:cc:subject:date:message-id:in-reply-to: references:mime-version:content-transfer-encoding; bh=KqWXBLN1y2tBAU5MfQdxigjBV0ykVvzEk82ODCrBxvE=; b=WFTOA1zJr8SNk8kXL5sI0hkr6g4Mzo5GngMD/aa1RhUn8XBUQYuBManT EKvGO/G8V/2VUBZDn9wGVWr+omIgjbbCfuHJzYaxYDrRuMfpzIdbhL7Ho c3H5Zgq7c2XT8OqFpHYU4ITrZVNSFSbMyGLDAl3xR+9eTvTwOxTm2CZXl ZqKayf7doY84Xsw3H4eo1S7P3vBHkd4JwfRPsU2tCpNYGxnh3b3xAo3fY oC4+EFjq/thTGE6EROAF4ybIPm8dLgrKBeqwCLI4VMTKTy/4uO13DE2u+ LlEHa2R0CgUeeXqA8VtU+c7wpbCCfTlo5CY0uyh+BuTinSpjzF4ADCRF5 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WFTOA1zJ
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9C0FC52F427
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
	TAGGED_FROM(0.00)[bounces-287466-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[osuosl.org:-];
	RCVD_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.547];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

ixgbe_update_itr() packs a mode flag (IXGBE_ITR_ADAPTIVE_LATENCY,
bit 7) and a usecs delay (bits [6:0]) into an unsigned int, then
stores the combined value in ring_container->itr which is declared as
u8.  Values above 0xFF wrap on truncation, corrupting both the delay
and the mode flag on the next readback.

Keep the mode bit (IXGBE_ITR_ADAPTIVE_LATENCY) and the usec delay as
separate operands in the final store expression.  Clamp only the usecs
portion to [IXGBE_ITR_ADAPTIVE_MIN_USECS, IXGBE_ITR_ADAPTIVE_MAX_USECS]
using clamp_val() so that:
 - overflow cannot bleed into the mode bit (bit 7),
 - the delay cannot exceed 126 us (IXGBE_ITR_ADAPTIVE_MAX_USECS),
 - the delay cannot drop below 10 us (IXGBE_ITR_ADAPTIVE_MIN_USECS).

Fixes: b4ded8327fea ("ixgbe: Update adaptive ITR algorithm")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2 -> v3:
 - Use clamp_val() instead of min_t() to also guard the lower bound
   (IXGBE_ITR_ADAPTIVE_MIN_USECS); keep mode and delay as separate
   operands until final store; use IXGBE_ITR_ADAPTIVE_MAX_USECS (126)
   as upper bound instead of IXGBE_ITR_ADAPTIVE_LATENCY - 1 (127)
   (Simon Horman).

v1 -> v2:
 - Add proper [N/M] numbering so patchwork tracks it as part of the set;
   no code change.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 +++++++---
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 210c7b9..9f3ae21 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2886,11 +2886,17 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 				    IXGBE_ITR_ADAPTIVE_MIN_INC * 64) *
 		       IXGBE_ITR_ADAPTIVE_MIN_INC;
 		break;
 	}
 
 clear_counts:
-	/* write back value */
-	ring_container->itr = itr;
+	/* Separate mode bit (IXGBE_ITR_ADAPTIVE_LATENCY) from usec delay;
+	 * clamp delay to [MIN_USECS, MAX_USECS] before storing to prevent
+	 * u8 truncation from corrupting the mode flag or delay on readback.
+	 */
+	ring_container->itr = (itr & IXGBE_ITR_ADAPTIVE_LATENCY) |
+		clamp_val(itr & ~IXGBE_ITR_ADAPTIVE_LATENCY,
+			  IXGBE_ITR_ADAPTIVE_MIN_USECS,
+			  IXGBE_ITR_ADAPTIVE_MAX_USECS);
 
 	/* next update should occur within next jiffy */
 	ring_container->next_update = next_update + 1;

