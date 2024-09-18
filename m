Return-Path: <netdev+bounces-128854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E6297BFF8
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 20:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA16B215D4
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 18:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748851C9EA7;
	Wed, 18 Sep 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CynhBh8a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3505517C98E
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726682607; cv=none; b=Ct3wxclkfcTd5EWNDIjShtpsuE6Kw21cWWGS6uRsHFVhZop98z2A/5EekCmgskeUV1XJmWzjrHN+8XkqlwY47aTYWN3unpEqaxgyxtifG1vsZXyDo8NwHOEUkurWjexYNdcq2fkbRTUQzlte7cHiH3fXLmZ85CXYmVcU1f5SMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726682607; c=relaxed/simple;
	bh=kNX00Lkbwh1M2MCbd5GSbWJBYMHt077VeCR6pylzuHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QoesRolS/YIZDdOHl2xHt7imV2MlhXh/bChR+5pz2vyJsq0AY2JJXxANOV0DkETzXYheA9e+7cstgSl/QEzhVHdHbKyuGWLAvGv5TntYme/EsYs47ZmBEfn2/iwj6cc8SMIKrB3A1cidTXTjtwFfU+sJHIbxJC9/qcr5U6fo0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CynhBh8a; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726682605; x=1758218605;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kNX00Lkbwh1M2MCbd5GSbWJBYMHt077VeCR6pylzuHY=;
  b=CynhBh8acKkkipr6yOsm21NVs927WNUB93SjmZZkkvhLvDm4oc4HkE7p
   zs5GGafGNV01WYIgk8yONxXCpeLvzqhBwb3HRJvMe7eCHcxSL9vXkmVCS
   U0KjrBy8UHgDqh/sMV+1UU274Gb+fCL/o8pcMS5rxxfjpN3svVufL0K8h
   Ho8KhY13tlZhm0GohqaotwNCkPBAzb9XTigSthgA0BQy15+kOyDr0bEKE
   NdRsZYgI7u+q6wXi5RCh/mWq2VrNsUNB9gBsALbevFcyjQWtlbXlZbF/H
   cRgzlzQkUM2UrnswlNDjraNZjQQNPq0mid5/3NAHP1Y6kkwKn+EfahH3a
   w==;
X-CSE-ConnectionGUID: S7y5Yx2lQWWvIWrnwbsofQ==
X-CSE-MsgGUID: bIeXFCjTRJSQ7Ng+0LCUNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="36185772"
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="36185772"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 11:03:25 -0700
X-CSE-ConnectionGUID: 88Dmh8OATVea+axgXbhF5Q==
X-CSE-MsgGUID: Ewips44WSIitHpp4H5MkhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="69954257"
Received: from dmert-vmdev.jf.intel.com ([10.165.18.186])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 11:03:24 -0700
From: Dave Ertman <david.m.ertman@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net] ice: fix VLAN replay after reset
Date: Wed, 18 Sep 2024 14:02:56 -0400
Message-ID: <20240918180256.419235-1-david.m.ertman@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a bug currently when there are more than one VLAN defined
and any reset that affects the PF is initiated, after the reset rebuild
no traffic will pass on any VLAN but the last one created.

This is caused by the iteration though the VLANs during replay each
clearing the vsi_map bitmap of the VSI that is being replayed.  The
problem is that during rhe replay, the pointer to the vsi_map bitmap
is used by each successive vlan to determine if it should be replayed
on this VSI.

The logic was that the replay of the VLAN would replace the bit in the map
before the next VLAN would iterate through.  But, since the replay copies
the old bitmap pointer to filt_replay_rules and creates a new one for the
recreated VLANS, it does not do this, and leaves the old bitmap broken
to be used to replay the remaining VLANs.

Since the old bitmap will be cleaned up in post replay cleanup, there is
no need to alter it and break following VLAN replay, so don't clear the
bit.

Fixes: 334cb0626de1 ("ice: Implement VSI replay framework")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 79d91e95358c..0e740342e294 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -6322,8 +6322,6 @@ ice_replay_vsi_fltr(struct ice_hw *hw, u16 vsi_handle, u8 recp_id,
 		if (!itr->vsi_list_info ||
 		    !test_bit(vsi_handle, itr->vsi_list_info->vsi_map))
 			continue;
-		/* Clearing it so that the logic can add it back */
-		clear_bit(vsi_handle, itr->vsi_list_info->vsi_map);
 		f_entry.fltr_info.vsi_handle = vsi_handle;
 		f_entry.fltr_info.fltr_act = ICE_FWD_TO_VSI;
 		/* update the src in case it is VSI num */
-- 
2.46.0


