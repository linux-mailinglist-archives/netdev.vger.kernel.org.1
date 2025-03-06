Return-Path: <netdev+bounces-172534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9F2A553B7
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 18:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C7277AB815
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 17:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2835C25D522;
	Thu,  6 Mar 2025 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTmdmg9+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036DB25D1F8
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283819; cv=none; b=YYHCLMgmMSMrSkuu2WTgaXCrOl9xtMkZv1LNinAn7KM1IFBdT8yOCTbgtImmkCJe+0Eu2YkA6qqeD6xh/cKSfm4ijRfnmRcUkiEN3ztuLLbt4iv9zBA0G90kd3duMKzB+dzS8W14wFvv22v0HcHJK9h0X9V99BTGd5wPhrQDKDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283819; c=relaxed/simple;
	bh=9La0ODpzt9XGnL00Cb5mnMsFzrpzsSQqAsTJATJZY7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sTkO3NLKO5mI6XCMtku5/zN+FpBUxFECvKYtd+StIe36XJdt8clxoifKeR5vHdckoGpyoDYIAxnfEzcgwN01Uffb0erproVZUnnqJ07GIxGNSVfT0jMy2AHNi3G+5hrv0WQUpBf+k7dwbfSElsNpyy+JlKiJGfQpp8fItENrBTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTmdmg9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1E1C4CEE4;
	Thu,  6 Mar 2025 17:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283818;
	bh=9La0ODpzt9XGnL00Cb5mnMsFzrpzsSQqAsTJATJZY7o=;
	h=From:To:Cc:Subject:Date:From;
	b=uTmdmg9+fgVzLKCmmGOm73A60ihWA3KyG9NwYPN+HHuejinouIyr64J4YbW2s5KaJ
	 piE3g5rmi/n0zVSGeEl7mSyPuUAjTqeVCA2ZXf7G/L50Jwg+4++KsuJsnKSk2/0+b1
	 Y3NdC006uuC44KV7BnVbf0xrU8UV65zR/5xiuWGpg2t8Q5u3KS+ZTK+WTCMT81VPzP
	 aC2fuJGL33h6CU+AHJgU+hJ7x3IGEFEtc3gc3/p6oiP/7TJqBvYd4KD8nNVltoQjNv
	 QRo4NcBUNA254X/yyLDLmLRXVKJH3WeZVSRR6lY82xzL0vgnh6EO0MPP8orORQGBnW
	 oGnyvndBMPZwQ==
From: Jesse Brandeburg <jbrandeb@kernel.org>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>,
	netdev@vger.kernel.org,
	kernel-team@cloudflare.com,
	jbrandeb@kernel.org,
	leon@kernel.org,
	przemyslaw.kitszel@intel.com,
	Dave Ertman <david.m.ertman@intel.com>
Subject: [PATCH intel-net v2] ice: fix reservation of resources for RDMA when disabled
Date: Thu,  6 Mar 2025 09:56:34 -0800
Message-ID: <20250306175640.29565-1-jbrandeb@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesse Brandeburg <jbrandeburg@cloudflare.com>

If the CONFIG_INFINIBAND_IRDMA symbol is not enabled as a module or a
built-in, then don't let the driver reserve resources for RDMA. The result
of this change is a large savings in resources for older kernels, and a
cleaner driver configuration for the IRDMA=n case for old and new kernels.

Implement this by avoiding enabling the RDMA capability when scanning
hardware capabilities.

Note: Loading the out-of-tree irdma driver in connection to the in-kernel
ice driver, is not supported, and should not be attempted, especially when
disabling IRDMA in the kernel config.

Fixes: d25a0fc41c1f ("ice: Initialize RDMA support")
Signed-off-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Acked-by: Dave Ertman <david.m.ertman@intel.com>
---
v2: resend with acks, add note about oot irdma (Leon), reword commit
message
v1: https://lore.kernel.org/netdev/20241114000105.703740-1-jbrandeb@kernel.org/
---
 drivers/net/ethernet/intel/ice/ice_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 7a2a2e8da8fa..1e801300310e 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2271,7 +2271,8 @@ ice_parse_common_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps,
 			  caps->nvm_unified_update);
 		break;
 	case ICE_AQC_CAPS_RDMA:
-		caps->rdma = (number == 1);
+		if (IS_ENABLED(CONFIG_INFINIBAND_IRDMA))
+			caps->rdma = (number == 1);
 		ice_debug(hw, ICE_DBG_INIT, "%s: rdma = %d\n", prefix, caps->rdma);
 		break;
 	case ICE_AQC_CAPS_MAX_MTU:
-- 
2.43.0


