Return-Path: <netdev+bounces-230842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5828BF060E
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D2418A089E
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 10:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A1D2F60D8;
	Mon, 20 Oct 2025 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDCEeMvs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D3A227EB9
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954658; cv=none; b=bQ0XkXEPwJVcwwjghLKS2SOS6rI5M3kdNhXXLWbmvfsjwQPdlDAE1zpMnA23gYOnYsOU/2lOrbwr+xfU07yDgTzFwdrocqCyhdBwhICmEoKLyYB6nEi2CoCOXsrtavR63CdQGxCN63BYCEIyb0rnZeGo4vQRUXwoE9zvbc7MH2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954658; c=relaxed/simple;
	bh=9J53g8OkOar041dBgVIu5tJM5irhNs/KlVbqvUfq4f4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SKxj1Hp9ZlJXt7pqsWQD2nRU3znOwKoCd48eogavt+xD+dbtG3wcW840n+LKgxTcf4F89Llzy2KxBKLeCXLKnYAyEMPUARkYXRuSoVQVahL3T+ZlsDB5itwRTAapwsNv/jBTYv7Zpo9MXwEaSjddHqryZu+cBi69wrJYmu270QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDCEeMvs; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760954656; x=1792490656;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9J53g8OkOar041dBgVIu5tJM5irhNs/KlVbqvUfq4f4=;
  b=iDCEeMvst115oGi2wD0PHXcvvGl4V5QN23zWhDCMJtwGNDW2nnH8fTSu
   UAEBcGeci0aWV3bzMlvuDuStN3TTLFXipKbxettN/v+RCjcdzklWFYNSC
   D7khwG+zh41LZIhdEzAYmtFayuKVbjHrhiBTA8Y+b3HX16bx5/2gdB57I
   tvpakuylFKs4I+39lJGfB4Lb9/mghmmA1E4Gie1AcSvLHck4psK+WALR/
   cdsEDu4q90suej+3VgbSo11WOTKFaX2G8NdJJsQ0groneoL+UJb7W4Jaa
   MSfq1wcXg2BjzRE9MdP1BxMigZMNzYtVr9u4toFUbF+DXQ8pgryMfHCud
   g==;
X-CSE-ConnectionGUID: vyjDNPcdRn2qM5/1VKapSQ==
X-CSE-MsgGUID: QDxmWk58SpiKIfBt9EBS4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62986203"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62986203"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 03:04:16 -0700
X-CSE-ConnectionGUID: AIRKNdgyS9Ky68AKUzdH6g==
X-CSE-MsgGUID: grlaK72RQVW7I3b2gwIHIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="188390664"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa005.jf.intel.com with ESMTP; 20 Oct 2025 03:04:15 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH v2 iwl-net] ice: fix PTP cleanup on driver removal in error path
Date: Mon, 20 Oct 2025 12:02:16 +0200
Message-Id: <20251020100216.4144401-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the cleanup on releasing PTP resources in error path.
The error case might happen either at the driver probe and PTP
feature initialization or on PTP restart (errors in reset handling, NVM
update etc). In both cases, calls to PF PTP cleanup (ice_ptp_cleanup_pf
function) and 'ps_lock' mutex deinitialization were missed.
Additionally, ptp clock was not unregistered in the latter case.

Keep PTP state as 'uninitialized' on init to distinguish between error
scenarios and to avoid resource release duplication at driver removal.

The consequence of missing ice_ptp_cleanup_pf call is the following call
trace dumped when ice_adapter object is freed (port list is not empty,
as it is required at this stage):

[  T93022] ------------[ cut here ]------------
[  T93022] WARNING: CPU: 10 PID: 93022 at
ice/ice_adapter.c:67 ice_adapter_put+0xef/0x100 [ice]
...
[  T93022] RIP: 0010:ice_adapter_put+0xef/0x100 [ice]
...
[  T93022] Call Trace:
[  T93022]  <TASK>
[  T93022]  ? ice_adapter_put+0xef/0x100 [ice
33d2647ad4f6d866d41eefff1806df37c68aef0c]
[  T93022]  ? __warn.cold+0xb0/0x10e
[  T93022]  ? ice_adapter_put+0xef/0x100 [ice
33d2647ad4f6d866d41eefff1806df37c68aef0c]
[  T93022]  ? report_bug+0xd8/0x150
[  T93022]  ? handle_bug+0xe9/0x110
[  T93022]  ? exc_invalid_op+0x17/0x70
[  T93022]  ? asm_exc_invalid_op+0x1a/0x20
[  T93022]  ? ice_adapter_put+0xef/0x100 [ice
33d2647ad4f6d866d41eefff1806df37c68aef0c]
[  T93022]  pci_device_remove+0x42/0xb0
[  T93022]  device_release_driver_internal+0x19f/0x200
[  T93022]  driver_detach+0x48/0x90
[  T93022]  bus_remove_driver+0x70/0xf0
[  T93022]  pci_unregister_driver+0x42/0xb0
[  T93022]  ice_module_exit+0x10/0xdb0 [ice
33d2647ad4f6d866d41eefff1806df37c68aef0c]
...
[  T93022] ---[ end trace 0000000000000000 ]---
[  T93022] ice: module unloaded

Fixes: e800654e85b5 ("ice: Use ice_adapter for PTP shared data instead of auxdev")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1->v2:
 - rebased
 - complete full cleanup if failure in PTP intialization path (no need
   to do a cleanup on PTP release then) and added a comment with clarification
   why keeping PTP_UNINIT state on failure at init
 - setting ptp->clock to NULL explicitly in error path
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index fb0f6365a6d6..13b73f835f06 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3246,7 +3246,7 @@ void ice_ptp_init(struct ice_pf *pf)
 
 	err = ice_ptp_init_port(pf, &ptp->port);
 	if (err)
-		goto err_exit;
+		goto err_clean_pf;
 
 	/* Start the PHY timestamping block */
 	ice_ptp_reset_phy_timestamping(pf);
@@ -3263,13 +3263,19 @@ void ice_ptp_init(struct ice_pf *pf)
 	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
 	return;
 
+err_clean_pf:
+	mutex_destroy(&ptp->port.ps_lock);
+	ice_ptp_cleanup_pf(pf);
 err_exit:
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
 		ptp_clock_unregister(ptp->clock);
 		pf->ptp.clock = NULL;
 	}
-	ptp->state = ICE_PTP_ERROR;
+	/* Keep ICE_PTP_UNINIT state to avoid ambiguity at driver unload
+	 * and to avoid duplicated resources release.
+	 */
+	ptp->state = ICE_PTP_UNINIT;
 	dev_err(ice_pf_to_dev(pf), "PTP failed %d\n", err);
 }
 
@@ -3282,9 +3288,19 @@ void ice_ptp_init(struct ice_pf *pf)
  */
 void ice_ptp_release(struct ice_pf *pf)
 {
-	if (pf->ptp.state != ICE_PTP_READY)
+	if (pf->ptp.state == ICE_PTP_UNINIT)
 		return;
 
+	if (pf->ptp.state != ICE_PTP_READY) {
+		ice_ptp_cleanup_pf(pf);
+		mutex_destroy(&pf->ptp.port.ps_lock);
+		if (pf->ptp.clock) {
+			ptp_clock_unregister(pf->ptp.clock);
+			pf->ptp.clock = NULL;
+		}
+		return;
+	}
+
 	pf->ptp.state = ICE_PTP_UNINIT;
 
 	/* Disable timestamping for both Tx and Rx */

base-commit: 978b03527a6c24f908b24c51da32daca02f0fec8
-- 
2.39.3


