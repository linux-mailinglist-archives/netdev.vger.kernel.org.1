Return-Path: <netdev+bounces-241277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8748C82266
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B0E54E7FB7
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4DE2D3A96;
	Mon, 24 Nov 2025 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIFmV5ve"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A642BE05E
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764010114; cv=none; b=YlJ0Fuy+XYX+GgWLNx199CqdxSAjfOi6lrXGHki55GfobgUJ3nrxGnrVOwCWYXrQj9iUDtcmgc1VWiM4fCF7mi92Y6oNdLSeib+JNRXI/jwix0km0Fy4Wg3d5ooQ+hyAcW2UYwtu8HBKRPtUaMJ59asvKo3anF/0n3ItiVQfR+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764010114; c=relaxed/simple;
	bh=etSRP1bin/LvJA7hkO/mmT1L6XzYQ6JxdR2TBVK+bpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B6Ar5bANb1T0CmvqBv66h7QyPxF+I927R/OdDkoLGhf6XEH8kAAWJAJjNxzsT5whXyl952CtuIVBPH0kWNhpCQ4lwrCoOOXUDeLxEJKgjgxNNsr5s1A9MYkPgSm1ze2aE9MsB/6h+46FY4Wn048JKIOL8RbIKo21HKHlEXcxaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIFmV5ve; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764010113; x=1795546113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=etSRP1bin/LvJA7hkO/mmT1L6XzYQ6JxdR2TBVK+bpY=;
  b=nIFmV5ve8th2K6NgtHiLSOwEACwzkaxSsxrZDVXwf/+bAEUnDco23ao1
   tiuqhIz6Bm1Suj2jkO68soIhdhkyuKQF3fhuWdwcQMaAHCNAC2dqRBmIs
   h09z6IsBXiX/aFLRXouf47u+deqJsrD7LCCRZCGK2cRdyU0L6OjRYZVNt
   F48bDls2u0hAlD9KYit9yHj0EWSVFREHTi1OkhFrTzdYOdw33AGDsMHkr
   sIZpiEVDlGV5mdS/a2zGCPdcJ3FxxYJc9gVpXaujXnMlu6zutvN4+kNEA
   jg6x3YART+16ejeJJQHPR1+hADLxrZIzxC3OO+88faEtYghJwlZmrphw4
   Q==;
X-CSE-ConnectionGUID: JH1y1qvYRESf9UkswJ4Ckg==
X-CSE-MsgGUID: RFIV6ZBARHq+Rl7jisVTJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="76341858"
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="76341858"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 10:48:33 -0800
X-CSE-ConnectionGUID: MnbvZNVFSjWS2gPl4zBwpw==
X-CSE-MsgGUID: e5titSlLTOqnXFZT4tVTJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="196575020"
Received: from aus-labsrv3.an.intel.com ([10.123.116.23])
  by orviesa003.jf.intel.com with ESMTP; 24 Nov 2025 10:48:32 -0800
From: Sreedevi Joshi <sreedevi.joshi@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sreedevi Joshi <sreedevi.joshi@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>
Subject: [PATCH iwl-net v2 3/3] idpf: Fix RSS LUT NULL ptr issue after soft reset
Date: Mon, 24 Nov 2025 12:47:50 -0600
Message-Id: <20251124184750.3625097-4-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251124184750.3625097-1-sreedevi.joshi@intel.com>
References: <20251124184750.3625097-1-sreedevi.joshi@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During soft reset, the RSS LUT is freed and not restored unless the
interface is up. If an ethtool command that accesses the rss lut is
attempted immediately after reset, it will result in NULL ptr
dereference. Also, there is no need to reset the rss lut if the soft reset
does not involve queue count change.

After soft reset, set the RSS LUT to default values based on the updated
queue count only if the reset was a result of a queue count change and
the LUT was not configured by the user. In all other cases, don't touch
the LUT.

Steps to reproduce:

** Bring the interface down (if up)
ifconfig eth1 down

** update the queue count (eg., 27->20)
ethtool -L eth1 combined 20

** display the RSS LUT
ethtool -x eth1

[82375.558338] BUG: kernel NULL pointer dereference, address: 0000000000000000
[82375.558373] #PF: supervisor read access in kernel mode
[82375.558391] #PF: error_code(0x0000) - not-present page
[82375.558408] PGD 0 P4D 0
[82375.558421] Oops: Oops: 0000 [#1] SMP NOPTI
<snip>
[82375.558516] RIP: 0010:idpf_get_rxfh+0x108/0x150 [idpf]
[82375.558786] Call Trace:
[82375.558793]  <TASK>
[82375.558804]  rss_prepare.isra.0+0x187/0x2a0
[82375.558827]  rss_prepare_data+0x3a/0x50
[82375.558845]  ethnl_default_doit+0x13d/0x3e0
[82375.558863]  genl_family_rcv_msg_doit+0x11f/0x180
[82375.558886]  genl_rcv_msg+0x1ad/0x2b0
[82375.558902]  ? __pfx_ethnl_default_doit+0x10/0x10
[82375.558920]  ? __pfx_genl_rcv_msg+0x10/0x10
[82375.558937]  netlink_rcv_skb+0x58/0x100
[82375.558957]  genl_rcv+0x2c/0x50
[82375.558971]  netlink_unicast+0x289/0x3e0
[82375.558988]  netlink_sendmsg+0x215/0x440
[82375.559005]  __sys_sendto+0x234/0x240
[82375.559555]  __x64_sys_sendto+0x28/0x30
[82375.560068]  x64_sys_call+0x1909/0x1da0
[82375.560576]  do_syscall_64+0x7a/0xfa0
[82375.561076]  ? clear_bhb_loop+0x60/0xb0
[82375.561567]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
<snip>

Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c  | 19 +++----------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  1 +
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index a2fc081fd68a..b5a6aa1209fa 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1484,8 +1484,6 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 	struct idpf_adapter *adapter = vport->adapter;
-	struct idpf_vport_config *vport_config;
-	struct idpf_rss_data *rss_data;
 	int err;
 
 	if (np->state != __IDPF_VPORT_DOWN)
@@ -1579,19 +1577,6 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 
 	idpf_restore_features(vport);
 
-	vport_config = adapter->vport_config[vport->idx];
-	rss_data = &vport_config->user_config.rss_data;
-
-	if (!rss_data->rss_lut) {
-		err = idpf_init_rss_lut(vport);
-		if (err) {
-			dev_err(&adapter->pdev->dev,
-				"Failed to initialize RSS LUT for vport %u: %d\n",
-				vport->vport_id, err);
-			goto disable_vport;
-		}
-	}
-
 	err = idpf_config_rss(vport);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to configure RSS for vport %u: %d\n",
@@ -2059,7 +2044,6 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 		idpf_vport_stop(vport, false);
 	}
 
-	idpf_deinit_rss_lut(vport);
 	/* We're passing in vport here because we need its wait_queue
 	 * to send a message and it should be getting all the vport
 	 * config data out of the adapter but we need to be careful not
@@ -2085,6 +2069,9 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	if (err)
 		goto err_open;
 
+	if (reset_cause == IDPF_SR_Q_CHANGE && !netif_is_rxfh_configured(vport->netdev))
+		idpf_fill_dflt_rss_lut(vport);
+
 	if (current_state == __IDPF_VPORT_UP)
 		err = idpf_vport_open(vport, false);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 21820bd26631..45afdd87fba0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4643,7 +4643,7 @@ int idpf_config_rss(struct idpf_vport *vport)
  * idpf_fill_dflt_rss_lut - Fill the indirection table with the default values
  * @vport: virtual port structure
  */
-static void idpf_fill_dflt_rss_lut(struct idpf_vport *vport)
+void idpf_fill_dflt_rss_lut(struct idpf_vport *vport)
 {
 	struct idpf_adapter *adapter = vport->adapter;
 	u16 num_active_rxq = vport->num_rxq;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 2bfb87b82a9b..423cc9486dce 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1086,6 +1086,7 @@ void idpf_vport_intr_update_itr_ena_irq(struct idpf_q_vector *q_vector);
 void idpf_vport_intr_deinit(struct idpf_vport *vport);
 int idpf_vport_intr_init(struct idpf_vport *vport);
 void idpf_vport_intr_ena(struct idpf_vport *vport);
+void idpf_fill_dflt_rss_lut(struct idpf_vport *vport);
 int idpf_config_rss(struct idpf_vport *vport);
 int idpf_init_rss_lut(struct idpf_vport *vport);
 void idpf_deinit_rss_lut(struct idpf_vport *vport);
-- 
2.43.0


