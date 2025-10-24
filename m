Return-Path: <netdev+bounces-232708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFD9C081EB
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B50C33583B6
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41EA2FD676;
	Fri, 24 Oct 2025 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buPX/xnI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D226E2FCC01
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338881; cv=none; b=Z5GCv1KqDx8mPs9DmZATlv0VvBMmRPmfFnMAJIqS7PV1Qzx4rh7Iz0+h8xqrnSs9zGTxWANMV10b2vBVmuP8el3gnvinmatnK7xJ2zb+2l/wQ83hwJMZd1ABtbhNL0Ntsp9pDNQPAe6z9Ztcthu0qiRpK2J38kQcW7xYnqrCdj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338881; c=relaxed/simple;
	bh=q47f6aSH3pivXnXfV/Z0UzuZKghwTc7vhNYmcNNOL4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lgwx300CKGY2U/rCbPPamtr+EqoRSRhmy5HB8yTGUKTGRtUNCm8gzzgqkpf/iqpd3n0arPhTd0000xqC/mqygTHohrKuQVN86Whs39QT7DRS5CPpp4ziHQCXDJlKmlwYnlpiiG8ULhgsZpTsyXU4kcKPPzigXcEBHPtGi2xdFHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buPX/xnI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761338879; x=1792874879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q47f6aSH3pivXnXfV/Z0UzuZKghwTc7vhNYmcNNOL4I=;
  b=buPX/xnI0yleU3MDvFDejRzDUfNTtcL4KWXUnPVSepSBVZ6BH4nQZGe9
   6aJpSXFdIQCcaYfjKEkO57WI882J50grtGYlW54F44L4wasE4NHSVItB6
   nz4jF1WnYFJ8WUkO+6K3JzXwqRYGDDBlT3eWo1VsQUJHMBB0NTx9irsJg
   xPB82aanydE9Khs1rzXBE4QZnGaEOpJ4CkekspqBZujCC9/0ckwk4S7fh
   sTaLD/KBT+9kCyMC5JJierd1afaIh9hRc1ftAuEOoCxulAORuMzJjYesz
   C3HExpEFV1HsPnOgu8VWEeaBXNn/xAAXtEWX/81X04aWqGwAop9VijZYK
   Q==;
X-CSE-ConnectionGUID: gLsLdKr3T769rO3XWngurg==
X-CSE-MsgGUID: nrKwu6iPSN+TF4t47HK24g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66139510"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="66139510"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 13:47:54 -0700
X-CSE-ConnectionGUID: iSvUL5njSrWT8UIdd0oSpQ==
X-CSE-MsgGUID: FsN5DIj+ReGcMlktZg/sRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="188821536"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 24 Oct 2025 13:47:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	mschmidt@redhat.com,
	poros@redhat.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 8/9] ice: move ice_deinit_dev() to the end of deinit paths
Date: Fri, 24 Oct 2025 13:47:43 -0700
Message-ID: <20251024204746.3092277-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024204746.3092277-1-anthony.l.nguyen@intel.com>
References: <20251024204746.3092277-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

ice_deinit_dev() takes care of turning off adminq processing, which is
much needed during driver teardown (remove, reset, error path). Move it
to the very end where applicable.
For example, ice_deinit_hw() called after adminq deinit slows rmmod on
my two-card setup by about 60 seconds.

ice_init_dev() and ice_deinit_dev() scopes were reduced by previous
commits of the series, with a final touch of extracting ice_init_dev_hw()
out now (there is no deinit counterpart).

Note that removed ice_service_task_stop() call from ice_remove() is placed
in the ice_deinit_dev() (and stopping twice makes no sense).

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.c  |  5 +++-
 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  3 +++
 drivers/net/ethernet/intel/ice/ice_main.c     | 23 ++++++++++++-------
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index c354a03c950c..938914abbe06 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1233,6 +1233,7 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
 {
 	struct ice_vsi *vsi = ice_get_main_vsi(pf);
 	struct device *dev = ice_pf_to_dev(pf);
+	bool need_dev_deinit = false;
 	int err;
 
 	err = ice_init_hw(&pf->hw);
@@ -1276,9 +1277,11 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
 unroll_pf_init:
 	ice_deinit_pf(pf);
 unroll_dev_init:
-	ice_deinit_dev(pf);
+	need_dev_deinit = true;
 unroll_hw_init:
 	ice_deinit_hw(&pf->hw);
+	if (need_dev_deinit)
+		ice_deinit_dev(pf);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 9a1abd457337..9ee596773f34 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1033,6 +1033,7 @@ void ice_start_service_task(struct ice_pf *pf);
 int ice_load(struct ice_pf *pf);
 void ice_unload(struct ice_pf *pf);
 void ice_adv_lnk_speed_maps_init(void);
+void ice_init_dev_hw(struct ice_pf *pf);
 int ice_init_dev(struct ice_pf *pf);
 void ice_deinit_dev(struct ice_pf *pf);
 int ice_init_pf(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 2250426ec91b..b097cc8b175c 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1161,6 +1161,9 @@ int ice_init_hw(struct ice_hw *hw)
 	status = ice_init_hw_tbls(hw);
 	if (status)
 		goto err_unroll_fltr_mgmt_struct;
+
+	ice_init_dev_hw(hw->back);
+
 	mutex_init(&hw->tnl_lock);
 	ice_init_chk_recipe_reuse_support(hw);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9a817c3c8b99..a1fe2d363adb 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4742,9 +4742,8 @@ static void ice_decfg_netdev(struct ice_vsi *vsi)
 	vsi->netdev = NULL;
 }
 
-int ice_init_dev(struct ice_pf *pf)
+void ice_init_dev_hw(struct ice_pf *pf)
 {
-	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
 	int err;
 
@@ -4764,6 +4763,12 @@ int ice_init_dev(struct ice_pf *pf)
 		 */
 		ice_set_safe_mode_caps(hw);
 	}
+}
+
+int ice_init_dev(struct ice_pf *pf)
+{
+	struct device *dev = ice_pf_to_dev(pf);
+	int err;
 
 	ice_set_pf_caps(pf);
 	err = ice_init_interrupt_scheme(pf);
@@ -5220,6 +5225,7 @@ static int
 ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 {
 	struct device *dev = &pdev->dev;
+	bool need_dev_deinit = false;
 	struct ice_adapter *adapter;
 	struct ice_pf *pf;
 	struct ice_hw *hw;
@@ -5342,11 +5348,13 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	devl_unlock(priv_to_devlink(pf));
 	ice_deinit(pf);
 unroll_dev_init:
-	ice_deinit_dev(pf);
+	need_dev_deinit = true;
 unroll_adapter:
 	ice_adapter_put(pdev);
 unroll_hw_init:
 	ice_deinit_hw(hw);
+	if (need_dev_deinit)
+		ice_deinit_dev(pf);
 	return err;
 }
 
@@ -5441,10 +5449,6 @@ static void ice_remove(struct pci_dev *pdev)
 
 	ice_hwmon_exit(pf);
 
-	ice_service_task_stop(pf);
-	ice_aq_cancel_waiting_tasks(pf);
-	set_bit(ICE_DOWN, pf->state);
-
 	if (!ice_is_safe_mode(pf))
 		ice_remove_arfs(pf);
 
@@ -5456,13 +5460,16 @@ static void ice_remove(struct pci_dev *pdev)
 	devl_unlock(priv_to_devlink(pf));
 
 	ice_deinit(pf);
-	ice_deinit_dev(pf);
 	ice_vsi_release_all(pf);
 
 	ice_setup_mc_magic_wake(pf);
 	ice_set_wake(pf);
 
 	ice_adapter_put(pdev);
+
+	ice_deinit_dev(pf);
+	ice_aq_cancel_waiting_tasks(pf);
+	set_bit(ICE_DOWN, pf->state);
 }
 
 /**
-- 
2.47.1


