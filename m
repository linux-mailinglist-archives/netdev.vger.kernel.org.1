Return-Path: <netdev+bounces-287196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHkyIW02A2of1wEAu9opvQ
	(envelope-from <netdev+bounces-287196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:17:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 110E05222BA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D2723036976
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296D03A83B2;
	Tue, 12 May 2026 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lI/i22Kn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD93ADB96
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594961; cv=none; b=KLN1M+WAkrzsk0VSdZti49rCZ4zUuFfGJnhyAwFBzKpz2X8kCQOu1imHbmJnxsUBB0iUrflWpPXb8I9YVQk/jBol3p7iceEOW/nMWmx9sMgs3nOZOyeFU2I67NLwpsISUiDBccK8EZ3e+Fp2urRPhhzooHiohTu3w5t8upmTeoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594961; c=relaxed/simple;
	bh=XhjYF6YgT7wG4QoZpcdRqG5xDSZ6EcbpZMT/yoo8tAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rP1Zlk1sQO2Y+AKbhR0xwqObR6K55eG9m+JgfDu7neOf2q+b6xEiFfaMnjTEFBTRe2WXR+FCnui/yL2u1rODthcPiE5vUvYHRRCNJ6vnaiEzcSV68jdLDmPJMpIaAR2CwQn4YO0sxLV44dBJdU2UJnsXEI+VzmnJs7oDYVjAQUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lI/i22Kn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778594959; x=1810130959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XhjYF6YgT7wG4QoZpcdRqG5xDSZ6EcbpZMT/yoo8tAs=;
  b=lI/i22KnITg0Z5E3J8Vl4LGYYLAp1ibbHVcroui4li/MxANh2sHkswkR
   jmLbO7FeUxPiJU/VCRoIxx3AzlP4uIViCqAqfweNSDXXl8kMw+gkcjG9D
   LmBcbqEDvWyAVRtvFsEuld2foTXLi1Ym98+WoVMzxO6cc5FSs5FPu0Vsh
   j0Y4rqaOX1kLr0FnlXvDkL8MiTpAJT47eueERk0Lsy9HtfTld70FCqBkH
   IZieBTKgI6ABEAtvRZFIalrfBOowChQv90ALl7vN+pPc3977UsfUB93iV
   WYCrOXoiV07KAO68UFDHCKukNzdqB0Xil5biJtuFh+z6qdq9XBtTyr+kk
   g==;
X-CSE-ConnectionGUID: hl66HdxjQgWqHe94sbb0vg==
X-CSE-MsgGUID: z5J3Fft9Tbm0q4xI1+udnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="96929679"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="96929679"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:09:19 -0700
X-CSE-ConnectionGUID: op5ukAZsQem+bchG3sP8tQ==
X-CSE-MsgGUID: kFNpEySKQO2WW/mgGEvckQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="275892500"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 12 May 2026 07:09:18 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2 7/8] ixgbe: limit ITR decrease in latency mode to prevent ACK overdrive
Date: Tue, 12 May 2026 16:09:03 +0200
Message-ID: <20260512140904.4105236-8-aleksandr.loktionov@intel.com>
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
X-Rspamd-Queue-Id: 110E05222BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287196-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Alexander Duyck <alexander.h.duyck@intel.com>

When operating in latency mode and the computed ITR is lower than the
current setting, the algorithm can reduce the interrupt rate too
aggressively in a single step.  For a TCP workload this means the ACK
stream (a latency-sensitive, low-packet-rate workload) can drive the
moderation down to very high interrupt rates, starving CPU time from
the sender side.

After the speed-based ITR calculation is complete, check whether the
result is in latency mode and would decrease below the current setting.
If so, limit the decrease to at most IXGBE_ITR_ADAPTIVE_MIN_INC (2 us)
per update.  This ensures the number of interrupts grows by no more
than 2x per adjustment step for latency-class workloads, dialling in
smoothly rather than overshooting.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index aea76b3..ba7b013 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2888,6 +2888,17 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 		break;
 	}
 
+	/* In the case of a latency specific workload only allow us to
+	 * reduce the ITR by at most 2us. By doing this we should dial
+	 * in so that our number of interrupts is no more than 2x the number
+	 * of packets for the least busy workload. So for example in the case
+	 * of a TCP workload the ACK packets being received would set the
+	 * interrupt rate as they are a latency specific workload.
+	 */
+	if ((itr & IXGBE_ITR_ADAPTIVE_LATENCY) && itr < ring_container->itr)
+		itr = max_t(unsigned int, itr,
+			    ring_container->itr - IXGBE_ITR_ADAPTIVE_MIN_INC);
+
 clear_counts:
 	/* write back value */
 	ring_container->itr = itr;
-- 
2.52.0


