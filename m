Return-Path: <netdev+bounces-133361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50824995BBC
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC07288EB8
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8542218D7B;
	Tue,  8 Oct 2024 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNRUChme"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2CD2185B8
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430493; cv=none; b=LKHi38RD7pIBWB58TDdB/2B15t2yf4q50vKvH3ScW3ESm9Aeiidodi85plnzbGTXIJkb/ha8rKVhLM3KAVAsQvZcvTYoJrfNmqsJYgRQR/9gQEMAvYPEDeiXPk6htBiAhv3Lbpcd9x2MllcGyfA7EBmpRstxmvcR+LiWBu777Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430493; c=relaxed/simple;
	bh=MlT/aShe1bRUQy/c5PkmJqGeMWhq6R7qDTfL6PBPQIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgAdBQVejYNOl4BUe5v/B2FI6f9Khki8G7xJPqpsyPwvihAIzM8WMGNHPJJbReOA18yNIGeb42eODeT8HTSQne+Pa7AnVMLkc/xp+b9rOfyEiAFXKBBHx3ng3yfdP2r4thsgqvyK5KB2P/aCvbyJupM+TDRU7dwhMXTB161B4LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNRUChme; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728430492; x=1759966492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MlT/aShe1bRUQy/c5PkmJqGeMWhq6R7qDTfL6PBPQIw=;
  b=TNRUChme+ZXNs0ZCvqkT/uHbdAiRt9irehF8RfzcXhDSP5+5ZbUKof4Z
   K5xayq4zhVvJT/KDxFpfEjdWTWKFec0WQiXw9fDyqYh9bo7lKr718p2ty
   76MlThQSaxc0TBkKlaibQnsJNVxUEoU36LibfD8x1iTOi+lFPW7CPdf8N
   wJIldVUAbbjBOmZdh2zn/SrBIrrd+PxAe2u5hsOZ4xd4/NeUVx5MDAHlM
   wfTgYAN7AFQtjdV8Ty6FiaoDf9wTRb11jW50Bv1/3iufGAAD7IdyuGs7K
   OviPdO7BXUmMaqoWKuXpSqNcpWc5zWigkI+SR1bL8gYYbrFhk/ZcOsC2n
   Q==;
X-CSE-ConnectionGUID: dRRKzT9uSdazjmNLOdJX8A==
X-CSE-MsgGUID: w36Ix4ejRB+DMHjc2E/uKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27779881"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="27779881"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:34:49 -0700
X-CSE-ConnectionGUID: GOO2KyEST2WQwyimXRVcJg==
X-CSE-MsgGUID: LXfiVc3uSdeSfTVEZA04PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106794191"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 16:34:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Hongbo Li <lihongbo22@huawei.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	George Kuruvinakunnel <george.kuruvinakunnel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 05/12] ice: Make use of assign_bit() API
Date: Tue,  8 Oct 2024 16:34:31 -0700
Message-ID: <20241008233441.928802-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
References: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongbo Li <lihongbo22@huawei.com>

We have for some time the assign_bit() API to replace open coded

    if (foo)
            set_bit(n, bar);
    else
            clear_bit(n, bar);

Use this API to clean the code. No functional change intended.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9f6e8a5508a2..255ae9325c69 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6549,8 +6549,7 @@ ice_set_features(struct net_device *netdev, netdev_features_t features)
 	if (changed & NETIF_F_HW_TC) {
 		bool ena = !!(features & NETIF_F_HW_TC);
 
-		ena ? set_bit(ICE_FLAG_CLS_FLOWER, pf->flags) :
-		      clear_bit(ICE_FLAG_CLS_FLOWER, pf->flags);
+		assign_bit(ICE_FLAG_CLS_FLOWER, pf->flags, ena);
 	}
 
 	if (changed & NETIF_F_LOOPBACK)
-- 
2.42.0


