Return-Path: <netdev+bounces-174816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDA4A60AE6
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 09:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32557174457
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 08:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C2519DF4B;
	Fri, 14 Mar 2025 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1GJgZ7x"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D806197A68
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 08:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939890; cv=none; b=RPk6r1DvE52TZJUcMP6oBOcTbiZUstWNk169v4uSFUn2ytdjGR1rKeVGCWnWSBGq38ImQdkc+/NG9tQVRqrWzqomF5mLKsr0gMeUDZjK70zppFGMyHF6mzJ22pN6R+gfGL6oGPSNNJzsp5lgddeFnfGHHS2vT/K5AE+wNz0mFgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939890; c=relaxed/simple;
	bh=DwsxhvSHFHvGVK5HJjjQ84jrLvARo9kZN3j7K83T6Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kV8RrwEfq2kzp5iNFf5daJiK1UtADUrVsM4fImdIpxzTvBAy/B2RBEvwUMHfWnthcK9Yz8OdmHXHkVcSn4DVQUK9ARu54/OfDHCKgjypHKeWE1k73iKUGr6qvbRkbubM0b0947FF74jX6gjUC8zL/nx+tnWCUms06jrwlKqGuG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1GJgZ7x; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741939889; x=1773475889;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DwsxhvSHFHvGVK5HJjjQ84jrLvARo9kZN3j7K83T6Vg=;
  b=e1GJgZ7x9C27mPQYMIYItfUFBITZ7vZYjfgdz2MUgbi8VpV+gRECI1q5
   KFhSkOoGAVppwVXQ03NUvYndB8NbYFiBBfCl5i8narrUgMtU2APeBz6y5
   vMHSxXqGxuo2zrigB8j3IF1uPB/6h0nPLL/Bfl67pcm5nJy30acdrjphd
   AhLS1C6wh/dgcpfDRW7Lcl10vU7bT5Hyuw/ut1cFRSD1/kXr2bD0Bz4fw
   gqEqScFUsiEQyzt/D9QkucvcL895VPax9Pc+eWIjtn2IRQ1qGkv9Zu8qm
   ghatszWV9wiKHBwuJnedfj0OsXmeKVozTZeRFta0zcw1geBofmQjaWZ6q
   w==;
X-CSE-ConnectionGUID: dCy9TfgDTc+njrvVyo6eVA==
X-CSE-MsgGUID: As/K4e1qQoCav1oxjDmELA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42812850"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="42812850"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 01:11:28 -0700
X-CSE-ConnectionGUID: ao8rK11JSTiZS/SBkJY+Pw==
X-CSE-MsgGUID: tw1/TXdHR9GoQZ27IFoMwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121150021"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa010.jf.intel.com with ESMTP; 14 Mar 2025 01:11:27 -0700
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next] ice: improve error message for insufficient filter space
Date: Fri, 14 Mar 2025 09:11:11 +0100
Message-ID: <20250314081110.34694-2-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adding a rule to switch through tc, if the operation fails
due to not enough free recipes (-ENOSPC), provide a clearer
error message: "Unable to add filter: insufficient space available."

This improves user feedback by distinguishing space limitations from
other generic failures.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index ea39b999a0d0..5acfa72fe7d8 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -846,6 +846,9 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 		NL_SET_ERR_MSG_MOD(fltr->extack, "Unable to add filter because it already exist");
 		ret = -EINVAL;
 		goto exit;
+	} else if (ret == -ENOSPC) {
+		NL_SET_ERR_MSG_MOD(fltr->extack, "Unable to add filter: insufficient space available.");
+		goto exit;
 	} else if (ret) {
 		NL_SET_ERR_MSG_MOD(fltr->extack, "Unable to add filter due to error");
 		goto exit;
@@ -1071,6 +1074,10 @@ ice_add_tc_flower_adv_fltr(struct ice_vsi *vsi,
 				   "Unable to add filter because it already exist");
 		ret = -EINVAL;
 		goto exit;
+	} else if (ret == -ENOSPC) {
+		NL_SET_ERR_MSG_MOD(tc_fltr->extack,
+				   "Unable to add filter: insufficient space available.");
+		goto exit;
 	} else if (ret) {
 		NL_SET_ERR_MSG_MOD(tc_fltr->extack,
 				   "Unable to add filter due to error");
-- 
2.47.0


