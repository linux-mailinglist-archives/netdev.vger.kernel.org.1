Return-Path: <netdev+bounces-262580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHduJwlWpWnR9AUAu9opvQ
	(envelope-from <netdev+bounces-262580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:19:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FCB1D56A7
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FB62300426E
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 09:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF61B7080E;
	Mon,  2 Mar 2026 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2kCxwiX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974F1430BA2;
	Mon,  2 Mar 2026 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772443142; cv=none; b=F4Cv3z6U525PVmHOajP6sT18SacmYyZk+ACzwWa9nQA6AV55lrVVdrP+yZPalIoLHJS1NteajQXagqyCViclUln0rvcx+U6iFAYVjcbMsyFYYs+lyJsmBRSq90JOFMynA2Eoyt1i/x4cOXvPQ29B5H9rRNQbtu99BkWiMAIGmSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772443142; c=relaxed/simple;
	bh=1T5jU8BM8aGqH2YE4YCnDvTDBiGjYhdQnvpP2XUVzG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czTHhLwGOzBO4hV6qXAf07FtljtusKcqlrLAT9qnRPfXZCLMEP4m1K/QDz++NSX90W/YAXU++gAxYJMyHFyF868CZrS8O7K4jSDpEuzyZE9IE40gy4DrvfrAQwfr3pQv7zDfcMAMACgtlQ/hT+Vx167h5sumMQMvbkW8xc8VqdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2kCxwiX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772443141; x=1803979141;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1T5jU8BM8aGqH2YE4YCnDvTDBiGjYhdQnvpP2XUVzG4=;
  b=n2kCxwiX+VE7eCOoL5Ix7GBBOr1XQxF1e2s3N+Kf6fWsV027mMbQjNs4
   hC6oouw1YIBODJ1tBgZo4bVOOy0PY/E7CGIyP/Mbe/9xtXzizCF5h/n03
   xkfiaf6mZARbHvjT86ABQDBKAwyshMqKYeZYdJ3O0ouaFKHZhmh/5OM/0
   W6Yfv+zGiMAnUSh3Vccl+H8HbOQmUhyozYoYeU+jGOp8Z94K6tGu3nAU1
   pqVQ0jCTOGSjR34z8Zv0Ltn3Fajb2FBzztOgDl4qx8N9MZdg7lZXAnSFX
   aAtI4JSDZcrWNHH7kT102+iUPIiwS8AF1+4C43lLUoymMd4kKeH9JCAdD
   Q==;
X-CSE-ConnectionGUID: TUX6ZuaaQZi8SvKZhuNUTQ==
X-CSE-MsgGUID: gRaHKvgNReiHXWQTGnHYUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="72647451"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="72647451"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 01:19:01 -0800
X-CSE-ConnectionGUID: 2ghGkbMwSH2TPOwL7mno6Q==
X-CSE-MsgGUID: EoY13vYkSg2GHvAEBPzpQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="240613153"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 02 Mar 2026 01:18:58 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5B91B95; Mon, 02 Mar 2026 10:18:57 +0100 (CET)
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
	Paolo Abeni <pabeni@redhat.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v2 1/1] i40e: Add missing wordpart.h header
Date: Mon,  2 Mar 2026 10:18:31 +0100
Message-ID: <20260302091856.2222240-1-andriy.shevchenko@linux.intel.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262580-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,mpg.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 21FCB1D56A7
X-Rspamd-Action: no action

When cleaning up another header I have met this build error:

drivers/net/ethernet/intel/i40e/i40e_hmc.h:105:22: error: implicit declaration of function 'upper_32_bits' [-Wimplicit-function-declaration]
  105 |         val1 = (u32)(upper_32_bits(pa));                                \

This is due to missing header, add it to fix the possible issue.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: elaborated the header in the Subject (Paul), added tag (Paul)

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


