Return-Path: <netdev+bounces-181699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5302EA86340
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DAE417CDEB
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 16:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C9921D5A2;
	Fri, 11 Apr 2025 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sizx99c3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747D621CA12
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744388953; cv=none; b=Bvwuzd1eJkcFwbKGHowrOBjAYaryM2uhTfzQ/eJUGfbiNeFJXo89qzkIBgDfGbfJzZ3vIM7wPo7DFohCrIHPyCmAaktQ/7MROHZJZCOf1Mt6GVIsLebYRayfof786LnTOp2EmanS29pFIlq90nX0X744W90nihdjgtZw+KItpjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744388953; c=relaxed/simple;
	bh=J3sK9XZVogFI5LcMOlER+V7H7/Mx34m+L+70HTXps7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5eGzIbpij+KKyEcHeZNW0WKtGZOTAkRBeoJaCSDGXx9RGegUvypeCFZV6DS36Jjt4+q1dfXlwx0e9WOD9AWYaNvxxLEO/DTCx93b3kg1UH1b3IUFBMKTeBL1wsRFlM319YJio7Oz+7AulxLO4uH0TgXqjCARRokb4T9WMdeMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sizx99c3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744388951; x=1775924951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J3sK9XZVogFI5LcMOlER+V7H7/Mx34m+L+70HTXps7I=;
  b=Sizx99c3g8euOfhpeRSTuoNo5u21zZbXKlJx24PMD0d6S7RliZeCazl9
   ePP6udVtqr0Xk0Jioo0/2plF5xUu0uHVSYG7Swkwv5iypGupcSvbA8Ytr
   7wa3fFNr0cv/MTLXMchqVtDKE5HkG8sQdpJnkoZDcmxlCowtgfWnBaIzZ
   OXjmwKgMg5XtjgRzSXwKGtWpon8iQBx0rcqHLdhCsFnHpwilCCRLmZHgz
   kthXzDggtIc15Z8m/XT875ojAzXKKd5KX5R11CJnitwJ2faz587Dp6/oT
   /panJ5GAe4mWA6g85upjLXZpkozRbwhRmOfbrZpkxu70M6xS+zqF2aJl+
   g==;
X-CSE-ConnectionGUID: 2YscRlUzRVupLDN+hEKoqw==
X-CSE-MsgGUID: uA6UMtTlQ4i7pZoc4n2q4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="56610965"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="56610965"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 09:29:09 -0700
X-CSE-ConnectionGUID: 9uNDzdVPS4uDnTl44CKZ3g==
X-CSE-MsgGUID: 3Ct0krctTsur+AE3DmCLhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="133343143"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 11 Apr 2025 09:29:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Christopher S M Hall <christopher.s.hall@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	vinicius.gomes@intel.com,
	david.zage@intel.com,
	michal.swiatkowski@linux.intel.com,
	richardcochran@gmail.com,
	vinschen@redhat.com,
	rodrigo.cadore@l-acoustics.com,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net 4/6] igc: handle the IGC_PTP_ENABLED flag correctly
Date: Fri, 11 Apr 2025 09:28:53 -0700
Message-ID: <20250411162857.2754883-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411162857.2754883-1-anthony.l.nguyen@intel.com>
References: <20250411162857.2754883-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christopher S M Hall <christopher.s.hall@intel.com>

All functions in igc_ptp.c called from igc_main.c should check the
IGC_PTP_ENABLED flag. Adding check for this flag to stop and reset
functions.

Fixes: 5f2958052c58 ("igc: Add basic skeleton for PTP")
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
Reviewed-by: Corinna Vinschen <vinschen@redhat.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 516abe7405de..343205bffc35 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -1244,8 +1244,12 @@ void igc_ptp_suspend(struct igc_adapter *adapter)
  **/
 void igc_ptp_stop(struct igc_adapter *adapter)
 {
+	if (!(adapter->ptp_flags & IGC_PTP_ENABLED))
+		return;
+
 	igc_ptp_suspend(adapter);
 
+	adapter->ptp_flags &= ~IGC_PTP_ENABLED;
 	if (adapter->ptp_clock) {
 		ptp_clock_unregister(adapter->ptp_clock);
 		netdev_info(adapter->netdev, "PHC removed\n");
@@ -1266,6 +1270,9 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 	unsigned long flags;
 	u32 timadj;
 
+	if (!(adapter->ptp_flags & IGC_PTP_ENABLED))
+		return;
+
 	/* reset the tstamp_config */
 	igc_ptp_set_timestamp_mode(adapter, &adapter->tstamp_config);
 
-- 
2.47.1


