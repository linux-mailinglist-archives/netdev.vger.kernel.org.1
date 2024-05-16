Return-Path: <netdev+bounces-96767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164FC8C7A7C
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 18:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4761A1C20D5F
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 16:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F7D443D;
	Thu, 16 May 2024 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jFJK9VU7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973D48BFD
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715877694; cv=none; b=hpINFeWUe1DTZ0cxUVQlvv+IGy/KnqgkUy7vLpj/LE5PlLUQD//ojgbv90fS5aTRvWkuChT8zLOviP0k36s8X8i3aHf8EQ14QyKkurAOI9edn/ttAdMknr924Yn4t+cnfos+XpHnF/BYaftlgpvaiFsa2vfoTeGfcFjCtZlwnEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715877694; c=relaxed/simple;
	bh=KKc5YzIGflCFVRWirSlgWVS98jJqwHzUqZyoeAjsiFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cd6kmhCidcjQgJZ3z/9xLSQKR9g6ztgQJr25M33V2aTOIK9zTeVCiKSMM+jT9ewMF3eHUP58zRXiEmxk8HPQ0d8wC46e6+jRa5P2zCdSmqg592LWZBjk8BU3guBrL57kbai4aGaFt4+TcIIAQ4N6e0tX9JkLqRR3TWGlo25d4Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jFJK9VU7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715877693; x=1747413693;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KKc5YzIGflCFVRWirSlgWVS98jJqwHzUqZyoeAjsiFY=;
  b=jFJK9VU7sL3n7ju09vXet3Lz8MexxTfnk6JqgMtOJ6ZVn84O2pSFE6bO
   cnBLAL4i/cPppxx1myqJstgplvV4VXvPlWQydUGmW/ga+PuN63Zw+xMH5
   mM2gf5JHwv44ngLHM1RVoRWKhJJBnYkqXSOMgaQwSNsW1SIqD/BKorvLm
   906ihXfoT/Vpz1A8l2lL0kDpce7J5OjQ7Lc9cWWoZ9XjBg6kzHFZyegq9
   Rnm1PzZJExqbJN5KfMFX2ZQU1E2V7pzodjo/gmtb76qUsUMOrPR8EQLQM
   tj4C7KniadvFH9GmPva5szRgduvLw3N1VPk/FHnWDK59BqRvJNVoZiyjU
   w==;
X-CSE-ConnectionGUID: H1xfjbCrSpaLMceQ4t65kw==
X-CSE-MsgGUID: pZ/6HlwUTvuqmmMma2onbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15831389"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="15831389"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 09:41:32 -0700
X-CSE-ConnectionGUID: 70hJClljT9qHePJ18wTgVA==
X-CSE-MsgGUID: eMhh/MtoQOebtSvF5uVSVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="68942623"
Received: from kkazimiedevpc.igk.intel.com (HELO localhost.igk.intel.com) ([10.102.102.224])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 09:41:30 -0700
From: Michal Kubiak <michal.kubiak@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: maciej.fijalkowski@intel.com,
	netdev@vger.kernel.org,
	Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH iwl-net] i40e: Fix XDP program unloading while removing the driver
Date: Thu, 16 May 2024 18:41:08 +0200
Message-Id: <20240516164108.1482192-1-michal.kubiak@intel.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 6533e558c650 ("i40e: Fix reset path while removing
the driver") introduced a new PF state "__I40E_IN_REMOVE" to block
modifying the XDP program while the driver is being removed.
Unfortunately, such a change is useful only if the ".ndo_bpf()"
callback was called out of the rmmod context because unloading the
existing XDP program is also a part of driver removing procedure.
In other words, from the rmmod context the driver is expected to
unload the XDP program without reporting any errors. Otherwise,
the kernel warning with callstack is printed out to dmesg.

Example failing scenario:
 1. Load the i40e driver.
 2. Load the XDP program.
 3. Unload the i40e driver (using "rmmod" command).

Fix this by improving checks in ".ndo_bpf()" to determine if that
callback was called from the removing context and if the kernel
wants to unload the XDP program. Allow for unloading the XDP program
in such a case.

Fixes: 6533e558c650 ("i40e: Fix reset path while removing the driver")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ffb9f9f15c52..19fc043e351f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13264,6 +13264,20 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
 	bool need_reset;
 	int i;
 
+	/* Called from netdev unregister context. Unload the XDP program. */
+	if (vsi->netdev->reg_state == NETREG_UNREGISTERING) {
+		xdp_features_clear_redirect_target(vsi->netdev);
+		old_prog = xchg(&vsi->xdp_prog, NULL);
+		if (old_prog)
+			bpf_prog_put(old_prog);
+
+		return 0;
+	}
+
+	/* VSI shall be deleted in a moment, just return EINVAL */
+	if (test_bit(__I40E_IN_REMOVE, pf->state))
+		return -EINVAL;
+
 	/* Don't allow frames that span over multiple buffers */
 	if (vsi->netdev->mtu > frame_size - I40E_PACKET_HDR_PAD) {
 		NL_SET_ERR_MSG_MOD(extack, "MTU too large for linear frames and XDP prog does not support frags");
@@ -13272,14 +13286,9 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
 
 	/* When turning XDP on->off/off->on we reset and rebuild the rings. */
 	need_reset = (i40e_enabled_xdp_vsi(vsi) != !!prog);
-
 	if (need_reset)
 		i40e_prep_for_reset(pf);
 
-	/* VSI shall be deleted in a moment, just return EINVAL */
-	if (test_bit(__I40E_IN_REMOVE, pf->state))
-		return -EINVAL;
-
 	old_prog = xchg(&vsi->xdp_prog, prog);
 
 	if (need_reset) {
-- 
2.33.1


