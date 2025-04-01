Return-Path: <netdev+bounces-178701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDB5A78549
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 01:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165841885A39
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 23:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC32E21CA18;
	Tue,  1 Apr 2025 23:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAhTWCX+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC8F21B905
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 23:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743550570; cv=none; b=eUYFcatGpQqiJySm7UIeSjM3RPW8ZgB0MU24Vf58WEtVTyWgKx93ZwC+3TI4ZPRQC6oRYGkUE0VrHcA9n6gyj/tXpLfQYmVPCMElB2KZN7VoLvV+S3ejJT+t4hWvDdSCyuCnv26D2RFNvOwr7lO0QMvlatbQu+P4ip6F6olgdjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743550570; c=relaxed/simple;
	bh=r1stb9zG3U0cmql7UEZ+eh55cn6cQhuUE/KePWRVdk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pqqv0ocq0iK37TE/FaTfjJ6UfbY4ubfCFq7D90PN6nVQEwoI9LHHi2sxyiTGwVYm6rP0ZNanHMtHC8S6MYZxeDlmdtEEMQ3j+cvPS1ynXhTa2QtWEMuvoAPXK9w5iCNrltLf9md8m5dxR5XeE8msKZxTsJcNJ5tGLNqa5m3kg28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAhTWCX+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743550569; x=1775086569;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=r1stb9zG3U0cmql7UEZ+eh55cn6cQhuUE/KePWRVdk4=;
  b=FAhTWCX+KcHK1pnPK8VUnZ5b7I98nEIFJQTML6hVSpJUrtvKbzPq546v
   C5zwFm6Un9eMMT077W0RIkPsM5iqlgTX1chXm3JJztYsuH0LbNwMgJg6J
   0QQ3hz5HsX2BqJaSfAleJQ85ARBobeYZc8SiyNP2fOwUmcqE89yvlJgpp
   rDsSAkTSfJDrx9g3RRWwgoPCXnX9riAqZtn8rTipkI4Jb6dGVYjuV9O0d
   Kp8N0fHMRKogrO5mxvL3F0AC3WmSWvtUjRSV2aAc+WhCBaOCZfmQvG85V
   DVncHClBA7c2+6VfsOiacf7tNXv4ofd1jo5zC3Zx8PpbDm0a8Z/M2fR2k
   g==;
X-CSE-ConnectionGUID: pHZqA+ADSNyu1tIJ8xZJqg==
X-CSE-MsgGUID: cOONe3Y4RSKUy6bzgn+0XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="55527608"
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="55527608"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 16:36:06 -0700
X-CSE-ConnectionGUID: Jm9bToE/RSCCtHL7weBXKg==
X-CSE-MsgGUID: I/vHSDDzRFuPGFhbX0mcFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="127354854"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 16:36:06 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 01 Apr 2025 16:35:32 -0700
Subject: [PATCH iwl-net v4 4/6] igc: handle the IGC_PTP_ENABLED flag
 correctly
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-jk-igc-ptm-fixes-v4-v4-4-c0efb82bbf85@intel.com>
References: <20250401-jk-igc-ptm-fixes-v4-v4-0-c0efb82bbf85@intel.com>
In-Reply-To: <20250401-jk-igc-ptm-fixes-v4-v4-0-c0efb82bbf85@intel.com>
To: Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: david.zage@intel.com, vinicius.gomes@intel.com, 
 rodrigo.cadore@l-acoustics.com, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Christopher S M Hall <christopher.s.hall@intel.com>, 
 Corinna Vinschen <vinschen@redhat.com>
X-Mailer: b4 0.14.2

From: Christopher S M Hall <christopher.s.hall@intel.com>

All functions in igc_ptp.c called from igc_main.c should check the
IGC_PTP_ENABLED flag. Adding check for this flag to stop and reset
functions.

Fixes: 5f2958052c58 ("igc: Add basic skeleton for PTP")
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
Reviewed-by: Corinna Vinschen <vinschen@redhat.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 516abe7405deee94866c22ccc3d101db1a21dbb6..343205bffc355022306bcb1db35109e2113bb430 100644
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
2.48.1.397.gec9d649cc640


