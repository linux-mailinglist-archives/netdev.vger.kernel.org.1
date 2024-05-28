Return-Path: <netdev+bounces-98788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E298D27BF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5616E1C22286
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 22:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABB313E05F;
	Tue, 28 May 2024 22:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNYusU5k"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3615713DDC7
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716933983; cv=none; b=a9oAnx7MaN/7xERRXxJDBQ666vcgwB2OpLIpTNQrUb926kxaNx0ZuNg7m+04+r4L3n11vkBtxHVFZe2K+I9ce7cgHamAY78tFb+w9cLnTvLb7JGa8zwHosTs8tqOAmWPSVS/r0VVzHVGbCFHj0DNbAM3f4wkhCX8OD5+nMn6g1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716933983; c=relaxed/simple;
	bh=LUSg/BcqkKtZ3DblQ0iY1meBW43bgd//ZMzLCkYZHUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qrRPFT4uI6YwxtED3FdlVThrafkVBSI8Ln/hs0Uk6Dk3G5vIB6KzyvUKkkfNwSgfU31TalkEv4IaQsbChpRZ2V8pn1HdVUMEXFudAQTWPXk7Gd2lFPWdQ4lehwOLequdCaYGuCYV2zex6F9cOaSOQXOG2XC1DOgled6/CRZAuhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNYusU5k; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716933983; x=1748469983;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=LUSg/BcqkKtZ3DblQ0iY1meBW43bgd//ZMzLCkYZHUU=;
  b=iNYusU5k9JXNljS7gWEIw+PEC202eQvrXzf6hnEieYpQtcUUxOLfjqBz
   7vSxgs/KRZhsuXW34o0pN7MsRQs+BkmNlE85nK95mKw5XQ9MB5OZkNjdB
   wVDowYxyk0pNfMqMwccoQRRoQQcWPWvRK+tUEKIl6brntZSnRSK8N5cXM
   5/3N1Zez54gS84mV1Gr8QGHtnu89Ns/Z+nyjR3obYqZN6rR4RHT5ukdT7
   G+JQnRca7C9azmPh+hqm4OwXDIt1tdUgNZ0owW6twAV04R7JNkA8vfnXH
   GT7CW9qm4ClWAP1mrT+cwG0KovnoGz3FILpcYhIs+DaCVfepPNLIZxuL6
   w==;
X-CSE-ConnectionGUID: Z+vBKvRLRKirN1QZaXVoQg==
X-CSE-MsgGUID: aDjMM9/zTKCj0PWXoAtIPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13439618"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13439618"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:06:19 -0700
X-CSE-ConnectionGUID: CEk/c6icQySaFTKh9XpMGQ==
X-CSE-MsgGUID: 7F8q0eOGQ1mx5RvGOsqjfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="40087522"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:06:18 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 28 May 2024 15:06:07 -0700
Subject: [PATCH net 4/8] i40e: Fix XDP program unloading while removing the
 driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-net-2024-05-28-intel-net-fixes-v1-4-dc8593d2bbc6@intel.com>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
In-Reply-To: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Wojciech Drewek <wojciech.drewek@intel.com>, 
 George Kuruvinakunnel <george.kuruvinakunnel@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
X-Mailer: b4 0.13.0

From: Michal Kubiak <michal.kubiak@intel.com>

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
Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 284c3fad5a6e..2f478edb9f9f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13293,6 +13293,20 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
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
@@ -13301,14 +13315,9 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
 
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
2.44.0.53.g0f9d4d28b7e6


