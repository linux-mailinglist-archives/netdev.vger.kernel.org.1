Return-Path: <netdev+bounces-267466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBYOEb0btGlLhQAAu9opvQ
	(envelope-from <netdev+bounces-267466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:14:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85062284B10
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6768D30F48C8
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9E739B94A;
	Fri, 13 Mar 2026 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVrR7k3y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48A38A73E
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410206; cv=none; b=CAGKwcTGCNjZ2K1RHRJfyTDAZVMUTtWUYs6yI5Abgd0h2+fMETicIEOUTYbaTv/TaEsUkNo74ndykYl9OVGfJ5BlW+LISL69pXpJpqvRdSDGZ24ewwToNnM6TQ1ezsuuDwH9RA0kPWRaFXjrQStfpa2EkcEva6mHrJ6vGwBPFgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410206; c=relaxed/simple;
	bh=k1o+8ednU+pN1tcSX1+1/PDr4H4RUWJrqtWTJzuBfM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YDW29hfMRB2S6wvJNkF2zJaMKDGtGalAqnRVbeHmYGzmJDhDuv14D3sVEGiJfEWZTzpAnEcoLSpJ7s6gLDTj5NeT1qRBojdCoZGpBUGENELePdziCekai31jx1I5FVP5GXJ8lbGa7mErLOnIC9Y7qRYgLE2ypXco93LPeFFXuSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVrR7k3y; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773410203; x=1804946203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k1o+8ednU+pN1tcSX1+1/PDr4H4RUWJrqtWTJzuBfM8=;
  b=DVrR7k3yIsw3UKNJ8WChfG3Kk/Ef4WpCnlUVtWIrV2t1WfSmmiBh0tzI
   RtTffQW1TZYN2Q00QFoAkUGahms9VyPU00c3uryaHZBgMHH4Mor/wckyJ
   2yzAtgb/StQUtWm+8OK+eM4b8vgU3X5HYBmp+5VWaSeggecuqlMYmQf4d
   dnE4xRga5SqG9oOC79eABHhA+ImCjz1V7g7ZoP3+jtNAb/ZoR51jZcC33
   cBGFEUvYSryFjuEBcE9qAZPxbc5VEov4hgK+jfrTdxxIIP5AjE9yBxnhq
   H+x86lK47s3YHm3aZSGEMw4O3ER1qeRMCan1NNpkT5y19ufxNipj1JUoB
   A==;
X-CSE-ConnectionGUID: XgbQ8zObRQaSCT4rju8p0Q==
X-CSE-MsgGUID: 96n2YWWBSQCd4/77Wp8ong==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="62086314"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="62086314"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 06:56:42 -0700
X-CSE-ConnectionGUID: e/3J9FkJTJK/X1Wx2+joEQ==
X-CSE-MsgGUID: 9MFof3REQJuJUCplZ+APbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="217176828"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by fmviesa006.fm.intel.com with ESMTP; 13 Mar 2026 06:56:41 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-next v3] i40e: PTP: set supported flags in ptp_clock_info
Date: Fri, 13 Mar 2026 14:54:10 +0100
Message-ID: <20260313135802.499837-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267466-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85062284B10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since upstream commit d9f3e9ecc456 ("net: ptp: introduce
.supported_perout_flags to ptp_clock_info") and commit 7c571ac57d9d ("net:
ptp: introduce .supported_extts_flags to ptp_clock_info"), kernel core now
requires that the driver set the .supported_perout_flags and
.supported_extts_flags fields in PTP clock info. Otherwise, the additional
flags will be rejected by the kernel automatically.

Set supported flags field so we can set extts pins.

Fixes: d9f3e9ecc456 ("net: ptp: introduce .supported_perout_flags to ptp_clock_info")
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
v3:
- remove unnecessary flag checks for newer kernels and update commit
message
v2:
- add fixes tag
- remove old TODO comment
v1: https://lore.kernel.org/intel-wired-lan/20260309141220.343224-1-przemyslaw.korba@intel.com/

 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 7bcea7d9720f..e7c4f871beec 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -598,7 +598,6 @@ static int i40e_ptp_feature_enable(struct ptp_clock_info *ptp,
 	enum ptp_pin_function func;
 	unsigned int chan;
 
-	/* TODO: Implement flags handling for EXTTS and PEROUT */
 	switch (rq->type) {
 	case PTP_CLK_REQ_EXTTS:
 		func = PTP_PF_EXTTS;
@@ -1340,7 +1339,9 @@ static int i40e_init_pin_config(struct i40e_pf *pf)
 	pf->ptp_caps.n_ext_ts = 2;
 	pf->ptp_caps.pps = 1;
 	pf->ptp_caps.n_per_out = 2;
-
+	pf->ptp_caps.supported_extts_flags = PTP_RISING_EDGE |
+					     PTP_FALLING_EDGE |
+					     PTP_STRICT_FLAGS;
 	pf->ptp_caps.pin_config = kzalloc_objs(*pf->ptp_caps.pin_config,
 					       pf->ptp_caps.n_pins);
 	if (!pf->ptp_caps.pin_config)

base-commit: d5fbc991435eac7a1ead7cd2ddb5a743528718bb
-- 
2.43.0


