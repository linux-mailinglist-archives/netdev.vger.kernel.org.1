Return-Path: <netdev+bounces-198756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B668DADDAA7
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9555B16A0FA
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 17:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6211E28507A;
	Tue, 17 Jun 2025 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cz0W+RDj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA6628505A
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750181093; cv=none; b=LvqM5sfucTT7GI9x3SUAZJm9OVr0V+LYSU8AXsu1NJfOYjmB1frPDL4IRJ/OA58eORE7rUGybw/lldsnt2CSTcWnECAWMyRdn9nquEsnjgnJ2w+BSOhXhFzxIjWwaSmRrdNi/Suu6qFIKBHBHQZzNTmHooeNQD2S795eUSqw0Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750181093; c=relaxed/simple;
	bh=+FKYhC65acRjCptcBCdTfvJjihtOo3kpZIKtCE8VtpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNsN8Y0YyIqR+jnopWe4Pr847k6hn0qxRlX7Ph0Y4sagCY0sHN2tSS8jTCCSvJ/BEasbqXtAyfM68drJKg3la4GnbN4QYvEL8P1joV7+LLYdutQw6BS78nhiOYZQDy0v9ITmlAn81X44KkCTZFUq3gvEOI8bsbQf6BnKuPaXDYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cz0W+RDj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750181092; x=1781717092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+FKYhC65acRjCptcBCdTfvJjihtOo3kpZIKtCE8VtpY=;
  b=cz0W+RDjCyWYyA/q1PX6O2aCUCnnAddMNZpAw3+Kw8hD188wUm2iCU5F
   VzyOMLEZtntpuHqYw3jdEM2yOVOP4pGIcI1oIsqxIIkoQZBkino8pYPfq
   /3dCKKTpKuSjWcqrNV//2zO0HLEHYVSUM5+i9z3i7ExhFlNK0zuEJMQzd
   PmPHNums59XrooyVNrsTWxgoV7eVfuFtspsArqRl3KafnsDRb7yX9ZD3/
   ajRrOME8paU5xf1M4NndIi1/hAUFaH4QGyKpjyzgmNNyRBwYUkYEYkAvG
   GIQmMBlUJyR9v/aONd2ik1AgerC5wynDcFjtB5ykIAS1AGtNNTmsjkGQK
   w==;
X-CSE-ConnectionGUID: ZdGNgEneRnKRMtCipnaKPA==
X-CSE-MsgGUID: FgzysDKoTpqaCIxMQWtg+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="69820132"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="69820132"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 10:24:50 -0700
X-CSE-ConnectionGUID: rxzOTzKjR86z6LQ5bGP7KA==
X-CSE-MsgGUID: t8ok117BQ2qE17MQjNorQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="152741178"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 17 Jun 2025 10:24:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	richardcochran@gmail.com,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>,
	Gil Fine <gil.fine@linux.intel.com>
Subject: [PATCH net 3/3] e1000e: set fixed clock frequency indication for Nahum 11 and Nahum 13
Date: Tue, 17 Jun 2025 10:24:43 -0700
Message-ID: <20250617172444.1419560-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250617172444.1419560-1-anthony.l.nguyen@intel.com>
References: <20250617172444.1419560-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

On some systems with Nahum 11 and Nahum 13 the value of the XTAL clock in
the software STRAP is incorrect. This causes the PTP timer to run at the
wrong rate and can lead to synchronization issues.

The STRAP value is configured by the system firmware, and a firmware
update is not always possible. Since the XTAL clock on these systems
always runs at 38.4MHz, the driver may ignore the STRAP and just set
the correct value.

Fixes: cc23f4f0b6b9 ("e1000e: Add support for Meteor Lake")
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Reviewed-by: Gil Fine <gil.fine@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 14 +++++++++++---
 drivers/net/ethernet/intel/e1000e/ptp.c    |  8 +++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index a96f4cfa6e17..7719e15813ee 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3534,9 +3534,6 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca)
 	case e1000_pch_cnp:
 	case e1000_pch_tgp:
 	case e1000_pch_adp:
-	case e1000_pch_mtp:
-	case e1000_pch_lnp:
-	case e1000_pch_ptp:
 	case e1000_pch_nvp:
 		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI) {
 			/* Stable 24MHz frequency */
@@ -3552,6 +3549,17 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca)
 			adapter->cc.shift = shift;
 		}
 		break;
+	case e1000_pch_mtp:
+	case e1000_pch_lnp:
+	case e1000_pch_ptp:
+		/* System firmware can misreport this value, so set it to a
+		 * stable 38400KHz frequency.
+		 */
+		incperiod = INCPERIOD_38400KHZ;
+		incvalue = INCVALUE_38400KHZ;
+		shift = INCVALUE_SHIFT_38400KHZ;
+		adapter->cc.shift = shift;
+		break;
 	case e1000_82574:
 	case e1000_82583:
 		/* Stable 25MHz frequency */
diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index 89d57dd911dc..ea3c3eb2ef20 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -295,15 +295,17 @@ void e1000e_ptp_init(struct e1000_adapter *adapter)
 	case e1000_pch_cnp:
 	case e1000_pch_tgp:
 	case e1000_pch_adp:
-	case e1000_pch_mtp:
-	case e1000_pch_lnp:
-	case e1000_pch_ptp:
 	case e1000_pch_nvp:
 		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI)
 			adapter->ptp_clock_info.max_adj = MAX_PPB_24MHZ;
 		else
 			adapter->ptp_clock_info.max_adj = MAX_PPB_38400KHZ;
 		break;
+	case e1000_pch_mtp:
+	case e1000_pch_lnp:
+	case e1000_pch_ptp:
+		adapter->ptp_clock_info.max_adj = MAX_PPB_38400KHZ;
+		break;
 	case e1000_82574:
 	case e1000_82583:
 		adapter->ptp_clock_info.max_adj = MAX_PPB_25MHZ;
-- 
2.47.1


