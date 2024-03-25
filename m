Return-Path: <netdev+bounces-81770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BD788B152
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B855304046
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1574B53E2E;
	Mon, 25 Mar 2024 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvXw1Dgf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B92C45038
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398398; cv=none; b=tI1D1rwEplAApj4WzRtcai9RhzyCLtEKnNsPOmZHej+xTTv6/yIQrfp5p4WBSHiSwpaZOhSAATLG6fssImW8MtnKuhijsWcvEtgIVj/QdbnQv+U2RI8zOX9AVcHROR3zCguRL3K9DIGq+dcIahfrqu+CTTKUbX7UPDS4fAYcvOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398398; c=relaxed/simple;
	bh=Bg/E2T9YV+zl9q9k6Ym3xl8T7bWu/W5vK1jtxIJgQN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhmOXDglpoRVtz4TonVNt6EY9Fe7eQX/RhhltVxSOL1Wu+SOrbxruxvTtFHnT1fsVgsUi3q77PDD2auzuUfQ3RzqVQhM3oOaa8IU8k4T7+ylxApVGt5MVLWSsU6CWvXT8BKXKqROA+viXPy1tMNIy9nhexlr9SFvssfgecV52Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvXw1Dgf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711398397; x=1742934397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bg/E2T9YV+zl9q9k6Ym3xl8T7bWu/W5vK1jtxIJgQN8=;
  b=jvXw1DgfJ+dMA3zzJ5oxR12H7mugLn+AzVhVFcqrreKNXTh/Zi9ojg38
   7waDYfWh8k0XAar1kLSjN3I0PXJlYkbBBZa15aPNg4F8MjV7EJUMD9m40
   Ah04/0FdKtz8JCXPdEfdf+Jz9a9mH8ken9zTHNCUBpItXTcEVjCfWleMc
   h4GXPjjUE4O5i2b3BD1RqnrHFEIEWyXTBUajPslUXmoV1+Kkw7Pe+Oq9z
   Br6/ZIZW7CcqM6n/bcnvV1UHmAzF/G+j2/9o2i3BqvObz0GxhfsAkpSpO
   EzYgVs8HjdiM6kUXfJEFWat8Biee8AhWkpygz6dW981sbZQQ6aZ7Igs8t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="10219662"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="10219662"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 13:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15787381"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 25 Mar 2024 13:26:32 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 6/8] ice: change repr::id values
Date: Mon, 25 Mar 2024 13:26:14 -0700
Message-ID: <20240325202623.1012287-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240325202623.1012287-1-anthony.l.nguyen@intel.com>
References: <20240325202623.1012287-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Instead of getting repr::id from xa_alloc() value, set it to the
src_vsi::num_vsi value. It is unique for each PR.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 5 ++---
 drivers/net/ethernet/intel/ice/ice_repr.c    | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 76fa114f22c9..5eba8dec9f94 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -319,7 +319,7 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
 
 		dev_info(ice_pf_to_dev(pf), "PF %d changed eswitch mode to switchdev",
 			 pf->hw.pf_id);
-		xa_init_flags(&pf->eswitch.reprs, XA_FLAGS_ALLOC);
+		xa_init(&pf->eswitch.reprs);
 		NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to switchdev");
 		break;
 	}
@@ -426,8 +426,7 @@ ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
 	if (err)
 		goto err_setup_repr;
 
-	err = xa_alloc(&pf->eswitch.reprs, &repr->id, repr,
-		       XA_LIMIT(1, INT_MAX), GFP_KERNEL);
+	err = xa_insert(&pf->eswitch.reprs, repr->id, repr, GFP_KERNEL);
 	if (err)
 		goto err_xa_alloc;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index a5c24da31b88..b4fb74271811 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -345,6 +345,7 @@ ice_repr_add(struct ice_pf *pf, struct ice_vsi *src_vsi, const u8 *parent_mac)
 	}
 
 	repr->src_vsi = src_vsi;
+	repr->id = src_vsi->vsi_num;
 	np = netdev_priv(repr->netdev);
 	np->repr = repr;
 
-- 
2.41.0


