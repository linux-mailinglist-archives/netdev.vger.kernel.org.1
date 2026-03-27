Return-Path: <netdev+bounces-272418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMicGPcyxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:34:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDD53407A0
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3DD95303CA02
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1803BF696;
	Fri, 27 Mar 2026 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKzwCyXR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EE13CD8CC
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596679; cv=none; b=UzeBNaghRz4aV9HUiB7T/pxtUwNqYSdQLpjTotI/AVLE7PrCvydOJt/40CNCD7UHx5OHJW13m3i+Z+LXg/6utD75SRAzvy17MVZeP9o30IPsl6hYrK46WKaMud51DdpKecTubvbKBQCjxA9sMSn8u9kqIn2rCOsTS/NbquTHzk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596679; c=relaxed/simple;
	bh=PBQkM0oDq4CzXOVzrITHfcyD1KP6EOMIbnUXu+hWNak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etTupy5oHtcg4m/kGgimoTwxptX8dFCuOtMvEmnw5QaXbHz9aUwzXk6wQbXS2npUo3rW0C4flp5BulIkXyOO512/tjMJULr55Vi02hqfU+TCDTBjO307A5E8yYt6f1VAcjepk2kjZKxIKOqOyKCA2WuGj/FD7SgvKr6EcWk1OtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKzwCyXR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596675; x=1806132675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PBQkM0oDq4CzXOVzrITHfcyD1KP6EOMIbnUXu+hWNak=;
  b=AKzwCyXRB4/OFhW2pZRv56mUJsqe5hjO4Mp0jAOwqGGV9d8qWVj6B6YP
   osoxaVyd2iBzP96D0jncNJbUtymTfiiZvQWYb1VxMITt70vTYRHxapJ7S
   esb+ug9CH4dd8VB+Y9dER2FQQbmr47L76eCZuocjjq4LSbmjY8UludsQb
   A9sMRyOgI82zjQPgjndYdqhUAMXDHTHhcxxvt0GM1by5h6/efN2uHG7lF
   FsqhU8q5k/ZVyHTbqAXjORpZ+RwBMNB4R6LKG1rvwYo+J+mNZmwuJsQ6r
   7EvVJH55I9IupSr6yM5lfY0ZgblF3VOGKjr5ZdbVqg81YtGE99uIc2Plx
   g==;
X-CSE-ConnectionGUID: mrGa9YbyTwq7x4GVjKiNzw==
X-CSE-MsgGUID: IjttlYwjTtm+s7OY7VBUtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75734330"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75734330"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:31:01 -0700
X-CSE-ConnectionGUID: 1BTtfh0LSuChAT0utFp2Lg==
X-CSE-MsgGUID: CKhl9GRwQpmkmc23e/gMCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255740420"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:31:00 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next] ixgbe: fix integer overflow and wrong bit position in ixgbe_validate_rtr()
Date: Fri, 27 Mar 2026 08:30:44 +0100
Message-ID: <20260327073046.134085-10-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272418-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 8BDD53407A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two bugs in the same loop in ixgbe_validate_rtr():

1. When extracting 3-bit traffic class values from the IXGBE_RTRUP2TC
   register the shifted value was assigned directly to a u8, silently
   truncating any bits above bit 7.  Mask with IXGBE_RTRUP2TC_UP_MASK
   before the assignment so only the intended 3 bits are kept.

2. When clearing an out-of-bounds entry the mask was always shifted by
   the fixed constant IXGBE_RTRUP2TC_UP_SHIFT (== 3), regardless of
   which loop iteration was being processed.  This means only the entry
   at bit position 3 was ever cleared; entries at bit positions 0, 6, 9,
   ..., 21 were left unreset.  Use i * IXGBE_RTRUP2TC_UP_SHIFT to target
   the correct field for each iteration.

Also replace the hardcoded 0x7 literal with the IXGBE_RTRUP2TC_UP_MASK
constant for consistency with other parts of the driver.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 9aec66c..53b82a5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9798,11 +9798,12 @@ static void ixgbe_validate_rtr(struct ixgbe_adapter *adapter, u8 tc)
 	rsave = reg;
 
 	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
-		u8 up2tc = reg >> (i * IXGBE_RTRUP2TC_UP_SHIFT);
+		u8 up2tc = IXGBE_RTRUP2TC_UP_MASK &
+			   (reg >> (i * IXGBE_RTRUP2TC_UP_SHIFT));
 
 		/* If up2tc is out of bounds default to zero */
 		if (up2tc > tc)
-			reg &= ~(0x7 << IXGBE_RTRUP2TC_UP_SHIFT);
+			reg &= ~(IXGBE_RTRUP2TC_UP_MASK << (i * IXGBE_RTRUP2TC_UP_SHIFT));
 	}
 
 	if (reg != rsave)
-- 
2.52.0


