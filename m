Return-Path: <netdev+bounces-262568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMuKAAhTpWkR9AUAu9opvQ
	(envelope-from <netdev+bounces-262568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:06:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 853B61D53A3
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB3C6304AD2D
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 09:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693E638D014;
	Mon,  2 Mar 2026 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kaUsNlQl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFEF38CFF5;
	Mon,  2 Mar 2026 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442193; cv=none; b=HS+zOQP3yA6WIbOxeiw5Owkw83tofElBWchw5UGhwnrGYs3YJn/cuMRa2vpH7YXB+3HiVTpwo4Heg4t7MYb8du8nBcAzeJ2brISZBkpaWNbp2cqXj6KJrfBWXx/0eFzMWRxPCXiInZUUnER0clIU2ByH5L4RZyzvCdHWUbqnZAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442193; c=relaxed/simple;
	bh=tjwDfVUOCv7OweMTrTAC/NmQxTm0fJ23jK+CFiLTyI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OON8Bo7+oYmwlulM+o18IvdUFWsEGztRpyaVtaNhM1dC2UQMnJlbT9uzomP9w7jxb67mIKndqjMoFb0L0OfVLX7JyvdWigxORgOVNJS7BODLikSvNlzTGgzdrMKVD0qccPXQPjf38ChpsOAFIb73u5UP9QmzI8JV9WJzj5NHdHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kaUsNlQl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772442192; x=1803978192;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tjwDfVUOCv7OweMTrTAC/NmQxTm0fJ23jK+CFiLTyI4=;
  b=kaUsNlQl1eECcFI+nV0zkHEMKo+H3RMivCGj+ZnyOd+lczlpeSc5hyr6
   APFVeMCLomUBV+rlkM6Pn6sfGIeHwGG9Hm32HDRWh+pjHb4n2q55cFK/b
   l65Q46bVpGHfP7J1A1+bUiswvf0FjoHpBamcXE694LED41ndNtYkGe0LW
   D4R00qP6MxxXzaMa9SeUUfcvko0Ew51L1lKV6AqvGitco9INQ7eLFH9C/
   TuIXAQCTieDfVJdVpGciS17ooFfzHhgPWdUkBBAS7gd9gjAC1CTeCZvVq
   ArIUC9YfRk0pVPeW5VwMc0rJ42gmrL5BGTqiXq3Eswp2Gnuenxi5h7X4h
   Q==;
X-CSE-ConnectionGUID: 07ALBzDQSJ+Fn6ZT+8z1oA==
X-CSE-MsgGUID: Eusb5h5qQBuKy4US1+qaXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73555654"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="73555654"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 01:03:12 -0800
X-CSE-ConnectionGUID: N2d4dtcCSnuGVyy6n//y6g==
X-CSE-MsgGUID: GH8A692CSNqesEH/CbG2HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="221741553"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 02 Mar 2026 01:03:09 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D053895; Mon, 02 Mar 2026 10:03:07 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1 1/1] i40e: Add missing header
Date: Mon,  2 Mar 2026 10:03:05 +0100
Message-ID: <20260302090305.2193349-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262568-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 853B61D53A3
X-Rspamd-Action: no action

When cleaning up another header I have met this build error:

drivers/net/ethernet/intel/i40e/i40e_hmc.h:105:22: error: implicit declaration of function 'upper_32_bits' [-Wimplicit-function-declaration]
  105 |         val1 = (u32)(upper_32_bits(pa));                                \

This is due to missing header, add it to fix the possible issue.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_hmc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.h b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
index 480e3a883cc7..967711405919 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
@@ -4,6 +4,8 @@
 #ifndef _I40E_HMC_H_
 #define _I40E_HMC_H_
 
+#include <linux/wordpart.h>
+
 #include "i40e_alloc.h"
 #include "i40e_io.h"
 #include "i40e_register.h"
-- 
2.50.1


