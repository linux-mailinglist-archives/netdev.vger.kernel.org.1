Return-Path: <netdev+bounces-269789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBMlK7rVvGkk3gIAu9opvQ
	(envelope-from <netdev+bounces-269789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:06:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D18D2D5E4E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A46E1300CCA4
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 05:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E8A2DCF7D;
	Fri, 20 Mar 2026 05:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYiYxp6o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68612F49FD
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 05:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773983156; cv=none; b=sL8DSF8NDTCEsWLCUCJatBU+EY9SjostTgnDHPOII53A79lUh7M4hzGTWn6y8un8q34P31WVbWEIjONKglNhS4RU/hB0UvbhHrRvZQEizk0z3RKUMW1jPPbNjO150TvWBkdiOD3EuCBEITG6YrvfczGpK5L07UXfDTA0Bfljr7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773983156; c=relaxed/simple;
	bh=J/TdUYhUCnswK/mCgN8pCjPl17WB9+oNDkEPXVBSo8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aWOHUbc+klr/n7ShA6T+w4cdL7ZIj4SoyqaJzrXVye9/kNoRCorRtgJ3sdtM40tC1qAdGlpCW36jl7wbTDuzrADYPAOngA39nt06s3CXmaHHrDakBFhk0n+BIasRRrWeQ7zsC0yi3U3NbWuCJKMOSyUjKrOseezA0+MQmUrVmsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYiYxp6o; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773983155; x=1805519155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J/TdUYhUCnswK/mCgN8pCjPl17WB9+oNDkEPXVBSo8Q=;
  b=SYiYxp6oSz7f0lzQJ/9anf62Z8oqF6Zv1Thgj8/RusF/lk493x92vpQU
   Iw+oM+Jd9VLBCngNC9K5XJ81Ae4e4dXBKLisXzsNaZ2iM+N4vcIwadV3C
   hrEGH6waMOECu3SisBJIPlou0ac26f9FL0JrlOPqXBULKkjc2gsZxhUJo
   wL/CJQWpC2tTy6cNevqb6Ifgv8JXUYRvr4+qseIeuZ3xPbDPmtajRGeab
   1x9iX0o0nJsZwdJPd6wLU57CCe3psd8F/cHtFxtz9rTRaD2o1QrtuWpAg
   kwI5KoE3j+o+MUo5suPP5L1TbElyVXlmL/Ukunh42D1T1IFIk8Gb4F3I2
   A==;
X-CSE-ConnectionGUID: TIPLT8nOQLaJj0SVBC34Yw==
X-CSE-MsgGUID: H0wcTExrQja02hV7WmsYBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75251820"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75251820"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 22:05:55 -0700
X-CSE-ConnectionGUID: 0Bonq9lmT4uKSouOENriOA==
X-CSE-MsgGUID: LxlWx0osRNeiuEMkhq0vyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222399184"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa010.jf.intel.com with ESMTP; 19 Mar 2026 22:05:53 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next] ice: update ice_link_mode_str_high() with 200G
Date: Fri, 20 Mar 2026 06:05:52 +0100
Message-ID: <20260320050552.422715-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269789-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 5D18D2D5E4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paul Greenwalt <paul.greenwalt@intel.com>

Update ice_link_mode_str_high() with string for 200G PHY types.
Without these entries the ice_dump_phy_type() debug helper prints
nothing for phy_type_high bits [5..15], covering all 200G and
400GBASE-FR8 PHY types supported by E825C hardware.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index ce11fea..7cdd6a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -84,6 +84,17 @@ static const char * const ice_link_mode_str_high[] = {
 	[2] = "100G_CAUI2",
 	[3] = "100G_AUI2_AOC_ACC",
 	[4] = "100G_AUI2",
+	[5] = "200G_CR4_PAM4",
+	[6] = "200G_SR4",
+	[7] = "200G_FR4",
+	[8] = "200G_LR4",
+	[9] = "200G_DR4",
+	[10] = "200G_KR4_PAM4",
+	[11] = "200G_AUI4_AOC_ACC",
+	[12] = "200G_AUI4",
+	[13] = "200G_AUI8_AOC_ACC",
+	[14] = "200G_AUI8",
+	[15] = "400GBASE_FR8",
 };
 
 /**
-- 
2.52.0


