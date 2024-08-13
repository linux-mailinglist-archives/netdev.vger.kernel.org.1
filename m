Return-Path: <netdev+bounces-117926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8029694FE75
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 09:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EF21C2247B
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 07:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E40481D1;
	Tue, 13 Aug 2024 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RkqFcaNc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D736139
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533374; cv=none; b=Y9Z5vSTFqE7t8Ycnd7o9scKX2ug75NQF5JQj7nKiZNQdoes+8DWu5GVJHHTx9+b2JFO4yLsJImi1So8eq2ML9jR7VosZk9i98phVVBHQ2Tb7AxvvV3G7tkUlCxC+GCcVi8q/c+DQuJShJZRjzuxdxPF5DdWqw8T4E3/a/JKrNIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533374; c=relaxed/simple;
	bh=cjetck/ji/G4DJwkOP/ZmT9rxdNEogbxFc4YaqcT9MA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jjYmzDnzo8SJ1Gz+htgQkGfl9MFRebcS1pyayJYtW8bOGXrVwkgrLV8uk7fLj2J793F0puVTvDhXwOxHq5LWf3vx41Zu/WoThv8v2RVGJDgEtHnyqTeLZuRGfqSw6HDzpcOYqgvwTiW72lT6jHJ/amFuFhbWTdP+pYzSGaFDzGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RkqFcaNc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723533373; x=1755069373;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cjetck/ji/G4DJwkOP/ZmT9rxdNEogbxFc4YaqcT9MA=;
  b=RkqFcaNc1awC250d6b0UNEDnlcOmC7YIYDLjeiJDI0qps8ztS+ODzNtM
   56WfDnSZcMWIyB1qUMCXWxsAULvAXq1jWk6CwwExePqZc7QrnHmkloTNZ
   btDq1vH9W669XtAMgRFhbVeSid/2+hgrUvTKxQUu/5dLEP6rtEZT3NLNm
   UWKuoqCE6HrVAwrOIAECxVQxafBQ2/FvURgy9KBUbzVRuTy/C9uC//lvH
   Lt85aRDHI+ht30JuaUOWY4VRncZwYjbmXcqrrDZ1KIA/6QiUyze4mFJkz
   NuNLQxLgPRdUMA3rrMrYWsChCsO+9cEJXL3viw23tt60VOWXXMKexAWoI
   g==;
X-CSE-ConnectionGUID: i9Hb4RTRSXyMcZqmJtPFzg==
X-CSE-MsgGUID: y9wjMo8VRwO7s7aTnEonTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32249620"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="32249620"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 00:16:13 -0700
X-CSE-ConnectionGUID: UZqk3DY/Rkana1e2lyEpMw==
X-CSE-MsgGUID: N7CxY5rlQT+smWHcHM90mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58866749"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa006.jf.intel.com with ESMTP; 13 Aug 2024 00:16:11 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	wojciech.drewek@intel.com,
	jiri@resnulli.us
Subject: [iwl-next v1] ice: use internal pf id instead of function number
Date: Tue, 13 Aug 2024 09:16:10 +0200
Message-ID: <20240813071610.52295-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use always the same pf id in devlink port number. When doing
pass-through the PF to VM bus info func number can be any value.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Suggested-by: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink_port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
index 4abdc40d345e..1fe441bfa0ca 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
@@ -340,7 +340,7 @@ int ice_devlink_create_pf_port(struct ice_pf *pf)
 		return -EIO;
 
 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
-	attrs.phys.port_number = pf->hw.bus.func;
+	attrs.phys.port_number = pf->hw.pf_id;
 
 	/* As FW supports only port split options for whole device,
 	 * set port split options only for first PF.
@@ -458,7 +458,7 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
 		return -EINVAL;
 
 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_VF;
-	attrs.pci_vf.pf = pf->hw.bus.func;
+	attrs.pci_vf.pf = pf->hw.pf_id;
 	attrs.pci_vf.vf = vf->vf_id;
 
 	ice_devlink_set_switch_id(pf, &attrs.switch_id);
-- 
2.42.0


