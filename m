Return-Path: <netdev+bounces-159183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B89EA14AB1
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 09:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BED8F16707F
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 08:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE661F8670;
	Fri, 17 Jan 2025 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yy1Evh2J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937381F76CA
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737101294; cv=none; b=JqC24j7oc1v8qgINYsUST+HOHgqTWRxiH6mwtY0RAIokeSGR+8nJ7DcayNdgd25bNwCkq6RejJeJZXPm+dAU5HUPE4PNZUOK6ySdr3Kiof+PQIG6WTdULGfz0JF36vS1eg9bkrxQyg1s1mSPgRSpmho9tYHiddz/8CjEEN71wJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737101294; c=relaxed/simple;
	bh=CAk2sP6hixxAfhzaCRYZ3AnAe0FKOzwh0ciqFvjUOtY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uAZRLv4pulF1jWQMwTpaDGJOUu60j778pfJfp0i/znsT1xSHqRr2/Z0QHyDhXaSjafzZ9fQoKI5RIPXDW1ac4s+0QK/ULgQ3jtfNpM2Shk4+E5GL+fCyqK5w9L2rBMxbhkdkcQFapU27ssvcp/5qo5n8HgFkzJu1fes2C8kEUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yy1Evh2J; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737101293; x=1768637293;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CAk2sP6hixxAfhzaCRYZ3AnAe0FKOzwh0ciqFvjUOtY=;
  b=Yy1Evh2JZ1eiW0wzEXIyA4Qrqy80SZZI5ekuBSE9BHYOfmO8qiuKk7cw
   IWYseTAWCaXwohg4TBBHO2hJpN+n0F/KPk3vxhagnLOZGBzCTPGqGCItc
   OlJvwRMy78EgVZkWsKXb10+6aL5arihUD5blCoQp9PgRq8R2fmH9FW/ZE
   8HpqBMvio4iCLWW0QJ3bjYaaKxcNZWGseaifyKC9HYGLyII/Vbn6j1jVL
   wGh9nRMkj51ztkj2q8yjYfR090COOYPg3lS0W4kdXbMr66CM5Mco839EM
   txa7K6cxpLivatiTtmAjUrjBLTo17XZsJs8NbMn1PLRrPZwcAaKZZfCB4
   g==;
X-CSE-ConnectionGUID: ADBC0QwfT+iJKWML5b0x9Q==
X-CSE-MsgGUID: OXEW4lfXQRuaF5zQ0C2NpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="25122741"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="25122741"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 00:08:11 -0800
X-CSE-ConnectionGUID: y1sZW+PHTRGdavo3OoClCA==
X-CSE-MsgGUID: QOewXgDMS1OxdgmhAVwoIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="136582898"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 17 Jan 2025 00:08:10 -0800
Received: from metan.igk.intel.com (metan.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 52C3D27BA8;
	Fri, 17 Jan 2025 08:08:08 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v1] ice: refactor ice_fdir_create_dflt_rules() function
Date: Fri, 17 Jan 2025 09:06:32 +0100
Message-Id: <20250117080632.10053-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Flow Director function ice_fdir_create_dflt_rules() calls few
times function ice_create_init_fdir_rule() each time with different
enum ice_fltr_ptype parameter. Next step is to return error code if
error occurred.

Change the code to store all necessary default rules in constant array
and call ice_create_init_fdir_rule() in the loop. It makes it easy to
extend the list of default rules in the future, without the need of
duplicate code more and more.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 21 ++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index ee9862ddfe15..1d118171de37 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -1605,22 +1605,19 @@ void ice_fdir_replay_fltrs(struct ice_pf *pf)
  */
 int ice_fdir_create_dflt_rules(struct ice_pf *pf)
 {
+	const enum ice_fltr_ptype dflt_rules[] = {
+		ICE_FLTR_PTYPE_NONF_IPV4_TCP, ICE_FLTR_PTYPE_NONF_IPV4_UDP,
+		ICE_FLTR_PTYPE_NONF_IPV6_TCP, ICE_FLTR_PTYPE_NONF_IPV6_UDP,
+	};
 	int err;
 
 	/* Create perfect TCP and UDP rules in hardware. */
-	err = ice_create_init_fdir_rule(pf, ICE_FLTR_PTYPE_NONF_IPV4_TCP);
-	if (err)
-		return err;
-
-	err = ice_create_init_fdir_rule(pf, ICE_FLTR_PTYPE_NONF_IPV4_UDP);
-	if (err)
-		return err;
+	for (int i = 0; i < ARRAY_SIZE(dflt_rules); i++) {
+		err = ice_create_init_fdir_rule(pf, dflt_rules[i]);
 
-	err = ice_create_init_fdir_rule(pf, ICE_FLTR_PTYPE_NONF_IPV6_TCP);
-	if (err)
-		return err;
-
-	err = ice_create_init_fdir_rule(pf, ICE_FLTR_PTYPE_NONF_IPV6_UDP);
+		if (err)
+			break;
+	}
 
 	return err;
 }
-- 
2.38.1


