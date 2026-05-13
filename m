Return-Path: <netdev+bounces-287467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PotKFAvBGo/FAIAu9opvQ
	(envelope-from <netdev+bounces-287467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:59:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFD952F377
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1ED3730B52E9
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 07:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDF33D6698;
	Wed, 13 May 2026 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.b="0jZvNNfC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036DC3D7D77
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659046; cv=none; b=DFAfUDopbus53wu2X3SOETLr6CtRw3aPD3v3XxcL2INOgTGTmEmYlNEU1kQ2Bh3M+ZHyhtU4sdLWKBifgIkWXtlzEGMhjJ6UPQY4YqMcUIRGhwelW4RWxKO88tggqYiH7VPga7zKSBF5wctvgwApxwnneR6zm7l8pgQurGXtsOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659046; c=relaxed/simple;
	bh=QIEEEBNc3gm+OmfgriT3rIOLfpDf7vX/Sd0R60v70Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version:MIME-Version; b=ZipiXB1LWUt4dz1UYMKbe6iz6LUcTb7ueChAAddyUPEqgrnVLO/aGyMk4rKRisREGZaLNjOaKk0o0WIf9Y+mrUn3VsgnXQ0RznqWQmsjvbsopLjBUCHaC3AwTIK2PYK7vR2STJZp+od0QeUkwNckXh2QLXPSzV6qU8tBr3aO0CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=fail (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.b=0jZvNNfC reason="signature verification failed"; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-CSE-ConnectionGUID: 5aX1jBbWQdK4IaEyA1xWGQ==
X-CSE-MsgGUID: JW21nUyeSACe7vEbOS18sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83452613"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="83452613"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 00:57:24 -0700
X-CSE-ConnectionGUID: TBWb0mfwQACTOab1UOuWPA==
X-CSE-MsgGUID: Qflrrsf1QNKnbGXVOg80Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="261759691"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa001.fm.intel.com with ESMTP; 13 May 2026 00:57:21 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	"Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>
Subject: [Intel-wired-lan] [PATCH iwl-net v4 5/5] ixgbe: fix integer overflow and wrong bit position in ixgbe_validate_rtr()
Date: Wed, 13 May 2026 09:57:10 +0200
Message-ID: <20260415142841.3222399-7-aleksandr.loktionov@intel.com>
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
X-Patchwork-Id: 2223539
X-Patchwork-Delegate: anthony.l.nguyen@intel.com
X-Original-To: incoming@patchwork.ozlabs.org
Delivered-To: patchwork-incoming@legolas.ozlabs.org
Authentication-Results: legolas.ozlabs.org; dkim=pass (2048-bit key; unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=0jZvNNfC; dkim-atps=neutral
Authentication-Results: legolas.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=osuosl.org (client-ip=2605:bc80:3010::136; helo=smtp3.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=patchwork.ozlabs.org)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384) (No client certificate requested) by legolas.ozlabs.org (Postfix) with ESMTPS id 4fwk6L0TB8z1yHc for <incoming@patchwork.ozlabs.org>; Thu, 16 Apr 2026 00:28:58 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1]) by smtp3.osuosl.org (Postfix) with ESMTP id 841DB6F74D; Wed, 15 Apr 2026 14:28:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1]) by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP id hBoTrrce-4SJ; Wed, 15 Apr 2026 14:28:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 04BA66F753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org; s=default; t=1776263335; bh=it6igKY4qrJSpTkvyk0lUrw+wOK84Nrlw0QVHK9iASU=; h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id: List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe: From; b=0jZvNNfCLhkpU+R1jvDBhCFSkDzFYuNHSY16I5+2T34YcSacUmDRfN1iyhApTFLXw 3wJUGiBU8Ipph/IYRsCFGBLqZMAI2wha7Y0krjXnqdEAtKEaPlCgLac4Dc+ypOih5Q syg8+Cv7M4abmAw3Q9xuh8XqawPpFix9PqT47PlaV0z+2VlLzjutV+78f9ncVkchsq 0Jv8PGpjdI44JRBLMwyE98/O39nPXwnz/8QEWys4MKuGLAWV7u1lJ9x3vIFzkiXsbc NrTbm+ZkEu6yjXlcwAK6s0N5DC5Sh8Z4Y6QH71xVvGHSvJte8uj7zJE9HCzxiWxOov pWodpeeVK/mTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142]) by smtp3.osuosl.org (Postfix) with ESMTP id 04BA66F753; Wed, 15 Apr 2026 14:28:55 +0000 (UTC)
X-Original-To: intel-wired-lan@lists.osuosl.org
Delivered-To: intel-wired-lan@lists.osuosl.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138]) by lists1.osuosl.org (Postfix) with ESMTP id 5F570375 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1]) by smtp1.osuosl.org (Postfix) with ESMTP id 4E82685476 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1]) by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP id yuVAl-ppuZ-B for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 75BF585479
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75BF585479
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16]) by smtp1.osuosl.org (Postfix) with ESMTPS id 75BF585479 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:53 +0000 (UTC)
X-CSE-ConnectionGUID: xkO6mPoqQZWE+juOq0ESXw==
X-CSE-MsgGUID: 0tdYNp1/QneG/Ov1v7YKxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77423750"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="77423750"
Received: from orviesa003.jf.intel.com ([10.64.159.143]) by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:28:53 -0700
X-CSE-ConnectionGUID: kgdYO5kKSESFmxxGDfIxZA==
X-CSE-MsgGUID: jS2xfbJPRre/Vr72p4wZYA==
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="234467899"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225]) by orviesa003.jf.intel.com with ESMTP; 15 Apr 2026 07:28:52 -0700
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=intel.com; i=@intel.com; q=dns/txt; s=Intel; t=1776263333; x=1807799333; h=from:to:cc:subject:date:message-id:in-reply-to: references:mime-version:content-transfer-encoding; bh=G7MmTf1h+5LioLTjjvjCKQN7jxTwWDeJLS/XSkZaGHM=; b=fl5Hybet6jl4TUbG1pG4jkV6NzpjT/xeaO+qumu8kvaoguxHnjwZntpU D5gXhWbG6HqoCljXjKy5f8yisKDoWYBANRfysjLeIILehSM0MngDmeJ0v LaLtFdEZ4+FuzggDtmy+hS7240DZvjphwEQTqBNSpZv9NqzAVrxpxXN7y lHEr1wKnB1m+8H7bqGcvk6K6rbLXmeMjOfq6NpizcmcwJafr9IBUXrORE D3VwIaE8Qk0wL5LI4/QpxyRHp0o4YCQHCZKbNt8IxVKhMMoirIi+sbEqA 0l5Y5xCVjEIUWyeF5444CDQTnkv0z3ovE2gdppMlfHqnj7ZpmkYgE7u2r w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fl5Hybet
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1AFD952F377
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.59 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[osuosl.org:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.20)[mailman];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[intel.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287467-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[osuosl.org:-];
	RCVD_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.507];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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

