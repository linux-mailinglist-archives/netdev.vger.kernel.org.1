Return-Path: <netdev+bounces-277292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMkPFDis2GkmgwgAu9opvQ
	(envelope-from <netdev+bounces-277292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:52:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F0B3D39A6
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 138D23014C1F
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B113038BF67;
	Fri, 10 Apr 2026 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqlbWNml"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95611332EBC
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775807376; cv=none; b=EXZ2Q1/DSYzNAQxdr/re+4XvBDYBE3VH0rp1Eg1X+HRVN6DXAcAF9u+j22h4OPngjiIGISnFlQKV926TSKxNnfMZEQZnwrdGatmIPeuytDI9Wr2mm5TeTeykbApiW0+spJAD1PeTbPYr1tqPFC9kWsdONAp/PItVLRPqcKq3G3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775807376; c=relaxed/simple;
	bh=KyKKiZWFrU6bgfomlOok069woZZROnCpDRvRPVZwUBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qi+pNi8cmN3h47nC9apcX9UP5Z9YeZzGp0mtz6cd7St0C/XQ+LG4VWwqMf2w6g9w6/RvTQJWL7+nC/3vkHLcfFX/J0TpxS9G+txstatxmHbr6CEiMnzY/3wKD0VlCPhsS1UuTgi6Hx5qKOTm4bSqEAzvluCIfdsaq8s08yjaBNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqlbWNml; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775807374; x=1807343374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KyKKiZWFrU6bgfomlOok069woZZROnCpDRvRPVZwUBo=;
  b=OqlbWNmlz0LBpjSa50NXgSgyWoYnxWIueT4wGBRToOylwNF5kn+R7rhu
   MLAyFZnvVxqL/9DIy74ZGfg01VuVek5oWbeaiDRf3Oxvd3FZ/un44lxxD
   xxfQ31uCBe3734M5X7/Qa3aPRtqWkpo+cDW5GafJ3gMnWKHrzkAiSSjF3
   yKPZvsGLbRBMjVDFqWmBcFGw4DzXo7L6huujl4kwW4DoCotonwgKmZ4cH
   j5bHQadlqpMZ+DZ+/YpujSmFgqEUqJNkdzGPTZ6XaF/ypw7GRLqqi1FsD
   Cz61Y4q3Tvgxd/KJmCbjH1snt+ZJWz4DBNcFZWwczUpDFdSJ86JqWPmld
   w==;
X-CSE-ConnectionGUID: xLA+kAhoQ7qrVfPn9YSxvg==
X-CSE-MsgGUID: NHiEsS2lQfuzf1mOhsP5lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="77007933"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="77007933"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 00:49:33 -0700
X-CSE-ConnectionGUID: /p17nqLyRya/B32oUl8oVQ==
X-CSE-MsgGUID: GMYz3NDBTcKgVXhjrmZZzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="228941886"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2026 00:49:32 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next 6/10] ice: increase OICR interrupt moderation rate to 20K interrupts/sec
Date: Fri, 10 Apr 2026 09:49:17 +0200
Message-ID: <20260410074921.1254213-7-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277292-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9F0B3D39A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The miscellaneous interrupt cause (OICR) is throttled to 8K
interrupts per second (124 us minimum spacing). This interrupt
handles VF mailbox messages and Tx timestamps, so the low rate
imposes a minimum latency floor on both use-cases.

Raise the rate to 20K interrupts per second (50 us minimum
spacing) to allow lower latency handling for Tx timestamp
bursts and high VF message rates.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 75a48e5..2921da4 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3501,7 +3501,7 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
 		     ((pf->ll_ts_irq.index + pf_intr_start_offset) &
 		      PFINT_SB_CTL_MSIX_INDX_M) | PFINT_SB_CTL_CAUSE_ENA_M);
 	wr32(hw, GLINT_ITR(ICE_RX_ITR, pf->oicr_irq.index),
-	     ITR_REG_ALIGN(ICE_ITR_8K) >> ICE_ITR_GRAN_S);
+	     ITR_REG_ALIGN(ICE_ITR_20K) >> ICE_ITR_GRAN_S);
 
 	ice_flush(hw);
 	ice_irq_dynamic_ena(hw, NULL, NULL);
-- 
2.52.0


