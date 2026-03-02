Return-Path: <netdev+bounces-262635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLYHMaB7pWm6CAYAu9opvQ
	(envelope-from <netdev+bounces-262635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:59:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 511141D7F98
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 334DE300A118
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 11:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D2D355F56;
	Mon,  2 Mar 2026 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kWoo1kLm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591A2363C66
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 11:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452764; cv=none; b=ZZFW19A5cCrr3MlG2Akj/cLtdh+1CfeIRF7RZuv1KSI5ZQnRHGS+u4dZ7OgjcUSLC6+lAXGoxKDSdAymg3VnL+GZdh++rRQFI2OG/zJd3PHX99Q6x/zuyUW6g0la2f4MiE9rXQmLg3mDgrNcsKatt7QWYToHv2dDifpmPb+W5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452764; c=relaxed/simple;
	bh=0SQavlJE1tFWPxlo5oSgcJMUbpV7Y+RT1GMZ3NqL/QE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GRNkjodKpbZzwMW8ba9APmQL3IY8MwlXzYWjAQ46hykQMy16hsy2zNhSECbSWG4OAsqY1SYidstiuj/8cGe1NH3Y4owNw6pfusYouIj/ak3rPajAkf5boYhRNrLF4G7+G/gErGY9vHGAgaIOAc9w2KG0ca9KBsvkN0SjWIEnXEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kWoo1kLm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772452762; x=1803988762;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0SQavlJE1tFWPxlo5oSgcJMUbpV7Y+RT1GMZ3NqL/QE=;
  b=kWoo1kLmFAM/sci9wyt2vkzpgfzU9XqVdhBYwRM37rlboxAN2+STHDxd
   FSXq2I1GhDfX641XCFy10Ea9R8dv3u25pHm6F3pbto7n89enqJEon7unz
   KXNI7cput5574EsCreA9Aoc99VbHaAwW/qkWl/MyJ2izIlA+YgxdbsfdH
   2MEa/z84fFAmJaTIRw6JaPOnZ3tJEtxCRlPtwY0UnftRLSvTnbS5qnTEF
   Y1eXATcC5LC73eMmLZRsviOzZ1dJsUxLNNItMBpoJL4Wmu81dZZQ55QLO
   +MbbMIMaUnSOfuzDQAh8aXWf994cKe0yhAy9bRTBf2ywsFIWtwz0h/bbl
   w==;
X-CSE-ConnectionGUID: pL8CpBUdQc+FgcX6WokzGg==
X-CSE-MsgGUID: lstHRq04SqC4xz0CMSlFow==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73568225"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="73568225"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 03:59:22 -0800
X-CSE-ConnectionGUID: 5OFrZn9vQ9WCxyx+u2Ihiw==
X-CSE-MsgGUID: V6JRpJeBSxq8W2HGz3grng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="216095873"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by fmviesa008.fm.intel.com with ESMTP; 02 Mar 2026 03:59:20 -0800
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-next] ice: dpll: Fix compilation warning
Date: Mon,  2 Mar 2026 12:59:40 +0100
Message-ID: <20260302120044.298362-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-262635-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 511141D7F98
X-Rspamd-Action: no action

Introduced by commit ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and
dynamic pin discovery"):

ice_dpll.c: In function ‘ice_dpll_init’:
ice_dpll.c:3588:59: error: ‘%u’ directive output may be truncated
writing between 1 and 10 bytes into a region of size 4
[-Werror=format-truncation=] snprintf(pin_name, sizeof(pin_name),
"rclk%u", i);

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index e7d37a2fd1a2..1d89372b4840 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -3605,7 +3605,7 @@ static int
 ice_dpll_init_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
 			  int start_idx)
 {
-	char pin_name[8];
+	char pin_name[16];
 	int i, ret;
 
 	pf->dplls.wq = create_singlethread_workqueue("ice_dpll_wq");

base-commit: d5fbc991435eac7a1ead7cd2ddb5a743528718bb
-- 
2.43.0


