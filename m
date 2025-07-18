Return-Path: <netdev+bounces-208229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4B2B0AA6A
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461A81C48AF3
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B04E2E9EC3;
	Fri, 18 Jul 2025 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcLpoFXP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFADD2E762A
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864694; cv=none; b=c4r1enX9PyZY4UQqn8lkTGu4/kiXq5yCCvrEggQdj1wfQEgq4VbDHb+z2P1CSIH/OE4knMCNY6n93GV6bH3gAwT/5IYqZPwMxSlqk2bilWFS2Y/8+vKyzJOYOMj4I0YYrBlA3LTwta2SNt8iTxV8grplJAVIcd0LDy+hgj+1psE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864694; c=relaxed/simple;
	bh=MgEEwQu3Sbusza5Xbsj64HrurRHKDxC/bvn5rfAZRGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3GEe/f3iE1siT4taMuKyHbSzvxtWMMQYQ/cZdWobWEeuizi9ocEDwYOZP6vPnOogoDQ0uyp+/lvrTjjE4oWA3lnbjdXXoEOHvetup3z+FCHRnvEYhYhfvVnkwsFtnRA7fMXHfIqT7UW0NNZZZWBA2fZbGkxEtYoCV4ne3Xu6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcLpoFXP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752864693; x=1784400693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MgEEwQu3Sbusza5Xbsj64HrurRHKDxC/bvn5rfAZRGg=;
  b=lcLpoFXPjNu36ufVbqWa2v0p8VzNeQ8xRt2MvR9guTSFCvW4c51nRDDE
   oO+WlZ7mOCR6mnwB1FCzd7HUGBzRCwxDrii7pM+58w5aNNDOinZ05tJJw
   nqxRaLW0FNVVPkJe9E660J0yQLvN/qs+qgJ3g/ntfhzd4cgR6TIlisnms
   mZ9RjPRR7n2haByQfqgJzG0CLJKqPcdH6WwroiS3H/tFaYOVti5rOC49Q
   GBUisp1iPnFT4UZ49Ww46l5r5HQKEOkffWuTZ9xzb1PpWp1MfrR+8bdvK
   ZNuxxYCUrUd5hrc5oMbkRQwpeXFj+z3rYR0bonYYTsOV7tbXyXhYcH7Mh
   A==;
X-CSE-ConnectionGUID: aie8qig+SM2zV33nXDdiWA==
X-CSE-MsgGUID: Dq1L74JhTnOsEELEtU1y+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55320616"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="55320616"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 11:51:25 -0700
X-CSE-ConnectionGUID: SXWw8MkLTraWVN/59pk50g==
X-CSE-MsgGUID: cgq7YFDZTi+dYfL8VavrfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="157506908"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 18 Jul 2025 11:51:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Song Yoong Siang <yoong.siang.song@intel.com>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	hector.blanco.alcaine@intel.com,
	vinicius.gomes@intel.com,
	kevin.tian@intel.com,
	kurt@linutronix.de,
	richardcochran@gmail.com,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	daniel@iogearbox.net,
	corbet@lwn.net,
	brett.creeley@amd.com,
	srasheed@marvell.com,
	ast@kernel.org,
	bcreeley@amd.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net-next 10/13] igc: Relocate RSS field definitions to igc_defines.h
Date: Fri, 18 Jul 2025 11:51:11 -0700
Message-ID: <20250718185118.2042772-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
References: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Yoong Siang <yoong.siang.song@intel.com>

Move the RSS field definitions related to IPv4 and IPv6 UDP from igc.h to
igc_defines.h to consolidate the RSS field definitions in a single header
file, improving code organization and maintainability.

This refactoring does not alter the functionality of the driver but
enhances the logical grouping of related constants

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         | 4 ----
 drivers/net/ethernet/intel/igc/igc_defines.h | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 97b1a2c820ee..fdec66caef4d 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -406,10 +406,6 @@ extern char igc_driver_name[];
 #define IGC_FLAG_RSS_FIELD_IPV4_UDP	BIT(6)
 #define IGC_FLAG_RSS_FIELD_IPV6_UDP	BIT(7)
 
-#define IGC_MRQC_ENABLE_RSS_MQ		0x00000002
-#define IGC_MRQC_RSS_FIELD_IPV4_UDP	0x00400000
-#define IGC_MRQC_RSS_FIELD_IPV6_UDP	0x00800000
-
 /* RX-desc Write-Back format RSS Type's */
 enum igc_rss_type_num {
 	IGC_RSS_TYPE_NO_HASH		= 0,
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 86b346687196..d80254f2a278 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -383,11 +383,14 @@
 #define IGC_RXDEXT_STATERR_IPE		0x40000000
 #define IGC_RXDEXT_STATERR_RXE		0x80000000
 
+#define IGC_MRQC_ENABLE_RSS_MQ		0x00000002
 #define IGC_MRQC_RSS_FIELD_IPV4_TCP	0x00010000
 #define IGC_MRQC_RSS_FIELD_IPV4		0x00020000
 #define IGC_MRQC_RSS_FIELD_IPV6_TCP_EX	0x00040000
 #define IGC_MRQC_RSS_FIELD_IPV6		0x00100000
 #define IGC_MRQC_RSS_FIELD_IPV6_TCP	0x00200000
+#define IGC_MRQC_RSS_FIELD_IPV4_UDP	0x00400000
+#define IGC_MRQC_RSS_FIELD_IPV6_UDP	0x00800000
 
 /* Header split receive */
 #define IGC_RFCTL_IPV6_EX_DIS	0x00010000
-- 
2.47.1


