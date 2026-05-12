Return-Path: <netdev+bounces-287197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEXTNMc2A2pK1wEAu9opvQ
	(envelope-from <netdev+bounces-287197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:18:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB9B522331
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F490310F47B
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EFF3ADBBF;
	Tue, 12 May 2026 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AuhPxCSv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9F73A83B0
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594962; cv=none; b=LUFFuqcKxbzWWFWWkiDrWVaimwphHJ404/M1KA0uxebt21UROyrUN8bxzTsKBtRRm7gyktw09CtiT/YKLOFU2OguS8C5fGtJNtd23JQksCSJught/rLVvASCbkC0TDgBMKSCpWxjNDsGTs/0auxs2DOBWEHubJaLLNxMFJXzFBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594962; c=relaxed/simple;
	bh=VAHyAc2KoEUe2v4Yu2JRFPdha1c8Fnc9na45xhGWkSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdIInFLbG7C0htVwKAF+m+q9wcQFoCt93ACsuAssSTgsV4JeD9J9lEpfpRTuiABB95NnhWkiyPmNEyF8mGLBmaSymdgN4dc3ZQ1j0CcXV72v69lz6cwEOX/cyLYWH9jZ/UEfMljkZaNWDAQuSZtarkdGFpXvd6JoO5ACah+IuwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AuhPxCSv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778594961; x=1810130961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VAHyAc2KoEUe2v4Yu2JRFPdha1c8Fnc9na45xhGWkSk=;
  b=AuhPxCSvHaBn/h4/n/EtG1c5MG03J/6BQAcMR3QSBbdgFjsrP1t0NZ04
   zBk8qbouewN3FX+JHqqMHRyU2ARsYGv7CxiFIrjc5+fsfaHazBjXJOnHw
   35uavlnCIt/chGdyk0F+4MYYHLOTaIOW+Xc16B0V8mQlxtIzONY1/bciq
   QUHxr3f0IrVSLh/XbZLGoI3Gu/yhELCSJwyrMaMuWCJM+/xvQ45qNi6Gv
   tGx2yVyDU6pWUg+Tgi8hpzkj+vFGU2B0Jk2PjYuYMRFadIHb9vma+ZSfV
   2oDgBq9gQNk89q1oLCdl9I6vhr8VNd0d2+RCCkNDqQy8PjqD4lar955FA
   g==;
X-CSE-ConnectionGUID: QVKccMz2S6OFh2tr8sY5DA==
X-CSE-MsgGUID: 6E9RZwMdRhegaQS1tKFg2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="96929684"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="96929684"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:09:20 -0700
X-CSE-ConnectionGUID: wf90NH/7TpWrSl89hfjhlw==
X-CSE-MsgGUID: Ni6M6WAXTFujsPs9OCrmGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="275892507"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 12 May 2026 07:09:19 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2 8/8] ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS constant
Date: Tue, 12 May 2026 16:09:04 +0200
Message-ID: <20260512140904.4105236-9-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260512140904.4105236-1-aleksandr.loktionov@intel.com>
References: <20260512140904.4105236-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7EB9B522331
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287197-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Alexander Duyck <alexander.h.duyck@intel.com>

ixgbe_set_itr() clears the mode flag (IXGBE_ITR_ADAPTIVE_LATENCY, bit 7)
with the open-coded complement expression ~IXGBE_ITR_ADAPTIVE_LATENCY.
This is equivalent to keeping only bits [6:0], i.e. the usecs sub-field.

Add IXGBE_ITR_ADAPTIVE_MASK_USECS = IXGBE_ITR_ADAPTIVE_LATENCY - 1 =
0x7F to name this mask explicitly and replace the open-coded AND-NOT
operation with the cleaner AND form.  The two expressions are
arithmetically identical; the change improves readability.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index cf2df18..20e2a97 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -478,6 +478,7 @@ static inline unsigned int ixgbe_rx_pg_order(struct ixgbe_ring *ring)
 #define IXGBE_ITR_ADAPTIVE_MAX_USECS	126
 #define IXGBE_ITR_ADAPTIVE_LATENCY	0x80
 #define IXGBE_ITR_ADAPTIVE_BULK		0x00
+#define IXGBE_ITR_ADAPTIVE_MASK_USECS	(IXGBE_ITR_ADAPTIVE_LATENCY - 1)
 
 struct ixgbe_ring_container {
 	struct ixgbe_ring *ring;	/* pointer to linked list of rings */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ba7b013..be40655 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2959,7 +2959,7 @@ static void ixgbe_set_itr(struct ixgbe_q_vector *q_vector)
 	new_itr = min(q_vector->rx.itr, q_vector->tx.itr);
 
 	/* Clear latency flag if set, shift into correct position */
-	new_itr &= ~IXGBE_ITR_ADAPTIVE_LATENCY;
+	new_itr &= IXGBE_ITR_ADAPTIVE_MASK_USECS;
 	new_itr <<= 2;
 
 	if (new_itr != q_vector->itr) {
-- 
2.52.0


