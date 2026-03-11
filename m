Return-Path: <netdev+bounces-266643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Hj6HKxpsWnsugIAu9opvQ
	(envelope-from <netdev+bounces-266643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:10:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A16B82642D5
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A939300A256
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4892FD1AA;
	Wed, 11 Mar 2026 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2icMr5t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494322EBB8D
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234387; cv=none; b=Vh/2iH6F2EshraaBBXS0QlCf+7y3S98yFV/oIu7amlLSbW8jJv+Qp8UAN7uwN1/aAWCeUO/beFURzTkhVktIzrGDvnhcqNMr/gXFWXbSGQ+bLpaHQEyR7OTcFuZ1bp3CTw/nrSS0SEmMNE6D/41T83hWFL6LHICPOt/bRwWzKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234387; c=relaxed/simple;
	bh=G8Eu5sLBsgIP3MHr/7kyhP862zPvwqnYs7v1uXIFa+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AuIL8wmlHLRpPzbU+VEyBF/8iLAZ41qH78yxBS4i7j5HU+kHwKuuy++OFznfN4ciGX05nG7/dtSkYiXCKlbb2Lu4u2nh3LynE0091tCunIBPtg969GaUKkzOjml7razMfqB+nzcknHDsIfsWSEjDnqEt1w5Xrq7iL4YtGccl7xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2icMr5t; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773234381; x=1804770381;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G8Eu5sLBsgIP3MHr/7kyhP862zPvwqnYs7v1uXIFa+I=;
  b=W2icMr5tOfPecb5zpnM32nVPsWLU5fy7Je5vWTAjeskJrH8155b1TKwF
   6MYf179+0Fd7vXiNRrlNiNaM93ZrMUjpiEQPXhoSwVkpHZ8cehezaExIH
   bVUAKxdWNm35SIgMMKrowx8ZPyCqIrAWH72Z0pwASuczkeGiEzva3Y6MF
   8Onre2elcuX9n8rRTI8ZQN6RBNASbKY3uKm45U3WkIlM4lMvDpQRhs0Ga
   s+sXm0gdU/XdJHTeBWILG4Mhqy8q0w4LDMU++L82/zMv4GrvFCFzbAiNi
   wgUeudt5C0O4YNGynGA2du1PatMIoaGgUJodji5p8Chb3B0BO9asnmkA7
   w==;
X-CSE-ConnectionGUID: ReeqhVpASjGOj+yHnReMvA==
X-CSE-MsgGUID: T7cMTq9fQjGh8jNr0nMKYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="91680785"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="91680785"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 06:06:20 -0700
X-CSE-ConnectionGUID: ubb2e6H6SD+EMhcxpGYDyg==
X-CSE-MsgGUID: iq3HSNHeRxmLCsXjRDNAeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="217931221"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by fmviesa007.fm.intel.com with ESMTP; 11 Mar 2026 06:06:19 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-next v2] i40e: PTP: set supported flags in ptp_clock_info
Date: Wed, 11 Mar 2026 14:05:37 +0100
Message-ID: <20260311130743.353632-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A16B82642D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266643-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

Since upstream commit d9f3e9ecc456 ("net: ptp: introduce
.supported_perout_flags to ptp_clock_info") and commit 7c571ac57d9d ("net:
ptp: introduce .supported_extts_flags to ptp_clock_info"), kernel core now
requires that the driver set the .supported_perout_flags and
.supported_extts_flags fields in PTP clock info. Otherwise, the additional
flags will be rejected by the kernel automatically.

i40e does not support perout flags, so reject any request with perout
flags.

Fixes: d9f3e9ecc456 ("net: ptp: introduce .supported_perout_flags to ptp_clock_info")
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
v2:
- add fixes tag
- remove old TODO comment
v1: https://lore.kernel.org/intel-wired-lan/20260309141220.343224-1-przemyslaw.korba@intel.com/

 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 7bcea7d9720f..41ae6d78aacb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -598,13 +598,20 @@ static int i40e_ptp_feature_enable(struct ptp_clock_info *ptp,
 	enum ptp_pin_function func;
 	unsigned int chan;
 
-	/* TODO: Implement flags handling for EXTTS and PEROUT */
 	switch (rq->type) {
 	case PTP_CLK_REQ_EXTTS:
+		if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
+					PTP_RISING_EDGE |
+					PTP_FALLING_EDGE |
+					PTP_STRICT_FLAGS))
+			return -EOPNOTSUPP;
+
 		func = PTP_PF_EXTTS;
 		chan = rq->extts.index;
 		break;
 	case PTP_CLK_REQ_PEROUT:
+		if (rq->perout.flags)
+			return -EOPNOTSUPP;
 		func = PTP_PF_PEROUT;
 		chan = rq->perout.index;
 		break;
@@ -1340,7 +1347,9 @@ static int i40e_init_pin_config(struct i40e_pf *pf)
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


