Return-Path: <netdev+bounces-169167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA3AA42C52
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 20:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EE81891E30
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6985E1FECD5;
	Mon, 24 Feb 2025 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SleyUcsG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E1E1FCFD9
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424021; cv=none; b=k9BKnWMtBem6Zk9OoUfnMLJZ8zsJ4/SztfS2N29YHdPDdLNKx5UWE9wrw7qNFsbQWP+c/MQkfyX3J323WxoMV9r6HmXqnzVSGDcLxRhnYJjWDVaGaHu63HZaza1SotEgusc675oq/IbZ0HSu1Qkc5bJDdOeYSsjyJWiA5b/W3jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424021; c=relaxed/simple;
	bh=6KJ3WfDuHrHmdx+KLYqYOepx6d79l0cHoc86UKibcA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKscv8rG5myaNQ6idx5Jx7hDs2URmAvoCan7moq0YjB0YQPwsomOMDk/88WJxqnzYI2Byd/2dMLFG86/5ZWspQqbYj8vIV6XcC1MrtYpCZCSLNBX7vuXNEAc/JVGEOxjHrPd7d/viLsEaNfnq7L8R2UckRY7Jutq5AOLqckysfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SleyUcsG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740424020; x=1771960020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6KJ3WfDuHrHmdx+KLYqYOepx6d79l0cHoc86UKibcA0=;
  b=SleyUcsGKHORXDFPzYYim3eSxEASHvMLMjkQKmddo0DS+hp2Xu9puLKx
   q0zXWBPKnwN3Qv28RgM32zLVFYpZapLKigbeOrkvW9GXlhc2eiR2kM8Ty
   WMVQU2aNs0JalbwdvpKtUOJduUM2PMEphGy4vmObKinSwH4R54gMCowbi
   Ec5m72VhyLePPTZ6sTOXO6CLiZZsiaO+5vfqe7hgL9JheXluqeK4qORQQ
   cyjy2BZxH8hNQprN/Sni/dQVigOPV6CyMYrNJh31PeXsoyLwFAbEP8n+N
   +x4l5vMA+l/fAAIrjtLrdP5QGX+J00rvX2DyPziZAwOtsNSekaV2BR9zI
   w==;
X-CSE-ConnectionGUID: I6zNdJa4Q3uRfz5fzLnrZQ==
X-CSE-MsgGUID: NrWNjn7BQf6K5U3q2MOHtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58614213"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="58614213"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 11:06:55 -0800
X-CSE-ConnectionGUID: Q3bMzdu5Tr2lZszrf5DbPQ==
X-CSE-MsgGUID: teVHScsXRjmKJvOo+E71vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153358468"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 24 Feb 2025 11:06:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	anthony.l.nguyen@intel.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Bharath R <bharath.r@intel.com>
Subject: [PATCH net 5/5] ixgbe: fix media cage present detection for E610 device
Date: Mon, 24 Feb 2025 11:06:45 -0800
Message-ID: <20250224190647.3601930-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250224190647.3601930-1-anthony.l.nguyen@intel.com>
References: <20250224190647.3601930-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

The commit 23c0e5a16bcc ("ixgbe: Add link management support for E610
device") introduced incorrect checking of media cage presence for E610
device. Fix it.

Fixes: 23c0e5a16bcc ("ixgbe: Add link management support for E610 device")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/e7d73b32-f12a-49d1-8b60-1ef83359ec13@stanley.mountain/
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Bharath R <bharath.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 683c668672d6..cb07ecd8937d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1122,7 +1122,7 @@ static bool ixgbe_is_media_cage_present(struct ixgbe_hw *hw)
 	 * returns error (ENOENT), then no cage present. If no cage present then
 	 * connection type is backplane or BASE-T.
 	 */
-	return ixgbe_aci_get_netlist_node(hw, cmd, NULL, NULL);
+	return !ixgbe_aci_get_netlist_node(hw, cmd, NULL, NULL);
 }
 
 /**
-- 
2.47.1


