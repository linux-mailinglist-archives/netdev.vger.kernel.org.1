Return-Path: <netdev+bounces-138244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E16EE9ACAE3
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A771B216A0
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D5B1C82F0;
	Wed, 23 Oct 2024 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPT05Tc3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAAD1C727F;
	Wed, 23 Oct 2024 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689220; cv=none; b=mfTbj8EWDuQMHky9etfrytOCB4ZDGrAdPKoWnsEtkaD7LX+KZiW/Gu6c5UB1R4WhzEZ8tVlUYbQisSXt44kjMJL+bvEezvazrr/JbuhZyhS/pFLL67m/eN6Iz504wVM2w9SBJYXIO5bVcYOTYTuIl2XSz1AOmg0zdSMsY6zYsqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689220; c=relaxed/simple;
	bh=jlr9PKPb+PVipw4Vu1aww5E0P8JdXjTuJjzC5cVxEh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OByq+Cwkip6L8FV89FzN1TonRr1dPWQvBZ3TtgBVDzzeQwHQ+lYuKRUNxgYS9ht/fgfXUARSCTYWdi2pDKrEPU3iMBWoiu1cuS1EK9hqhK7z0XrmonsjUnARqBfDDO92zjtgP4nsF/71wNCBDczETf4X0/3EDua8uzaysY1Wr10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPT05Tc3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729689219; x=1761225219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jlr9PKPb+PVipw4Vu1aww5E0P8JdXjTuJjzC5cVxEh4=;
  b=RPT05Tc3lEuyYU0R+qVMr+S6xcw2bj0XhLo1PX22b4epGwHdcdjT8+0s
   lj8Yr1e4io74JIhLeg5cZPtpRTkCwWYNQDrAC/Nm4+rsRebF37kw9OZIy
   R1aPRWxxryH6DPwI4gZJ06ihqGS/TFXMToJeOg+60MecvyyCGKKxBflOL
   zkzra/t93jUAjOvyHV+f0UFQ8LyaPpaNBLJu9s8aaNqM/JJh7F9fNFfLS
   +iNlgBq3M4IZ1k4Fy9HFqwfNEwLPHnItjHXqc2tymNX4DBH+BEhldixVC
   rxZjfdUeJ4g9IUiXVUrXimMWFQwiSTUC5rg+3NMkgwl3SrynzRZZbhUwg
   Q==;
X-CSE-ConnectionGUID: VBO0tRciTMWCnkfp85DJsw==
X-CSE-MsgGUID: HEbQ+vDaQvmtAG4s5r+U2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="46758617"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="46758617"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 06:13:38 -0700
X-CSE-ConnectionGUID: pyWXoMVJTZKZNLSotEYmxw==
X-CSE-MsgGUID: WmZKZxVVRRmjdLMC1AZn7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="84820134"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 23 Oct 2024 06:13:35 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.71])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 63CA22877E;
	Wed, 23 Oct 2024 14:13:32 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH net-next v2 7/7] devlink: remove unused devlink_resource_register()
Date: Wed, 23 Oct 2024 15:09:07 +0200
Message-ID: <20241023131248.27192-8-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241023131248.27192-1-przemyslaw.kitszel@intel.com>
References: <20241023131248.27192-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused devlink_resource_register(); all the drivers use
devl_resource_register() variant instead.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 include/net/devlink.h  |  6 ------
 net/devlink/resource.c | 33 ---------------------------------
 2 files changed, 39 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index fdd6a0f9891d..fbb9a2668e24 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1779,12 +1779,6 @@ int devl_resource_register(struct devlink *devlink,
 			   u64 resource_id,
 			   u64 parent_resource_id,
 			   const struct devlink_resource_size_params *size_params);
-int devlink_resource_register(struct devlink *devlink,
-			      const char *resource_name,
-			      u64 resource_size,
-			      u64 resource_id,
-			      u64 parent_resource_id,
-			      const struct devlink_resource_size_params *size_params);
 void devl_resources_unregister(struct devlink *devlink);
 void devlink_resources_unregister(struct devlink *devlink);
 int devl_resource_size_get(struct devlink *devlink,
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index a923222bbde8..2d6324f3d91f 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -381,39 +381,6 @@ int devl_resource_register(struct devlink *devlink,
 }
 EXPORT_SYMBOL_GPL(devl_resource_register);
 
-/**
- *	devlink_resource_register - devlink resource register
- *
- *	@devlink: devlink
- *	@resource_name: resource's name
- *	@resource_size: resource's size
- *	@resource_id: resource's id
- *	@parent_resource_id: resource's parent id
- *	@size_params: size parameters
- *
- *	Generic resources should reuse the same names across drivers.
- *	Please see the generic resources list at:
- *	Documentation/networking/devlink/devlink-resource.rst
- *
- *	Context: Takes and release devlink->lock <mutex>.
- */
-int devlink_resource_register(struct devlink *devlink,
-			      const char *resource_name,
-			      u64 resource_size,
-			      u64 resource_id,
-			      u64 parent_resource_id,
-			      const struct devlink_resource_size_params *size_params)
-{
-	int err;
-
-	devl_lock(devlink);
-	err = devl_resource_register(devlink, resource_name, resource_size,
-				     resource_id, parent_resource_id, size_params);
-	devl_unlock(devlink);
-	return err;
-}
-EXPORT_SYMBOL_GPL(devlink_resource_register);
-
 static void devlink_resource_unregister(struct devlink *devlink,
 					struct devlink_resource *resource)
 {
-- 
2.46.0


