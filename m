Return-Path: <netdev+bounces-136948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518D19A3B5F
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB6D2841D1
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D39203705;
	Fri, 18 Oct 2024 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ea1Rmby6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41D0202F8F
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246844; cv=none; b=CCF4WFmrbb6gKy06MPMb658ScpJNB5xT8Wu+yoIH6CLf7OKi4BjWUn14oTTJZkOrQyDfOHSR/79D+g8fdWBIWJZtB9fa7ig7i/w5W/oOlWcSjQj4YrADcOaiRJoPv1uzbeh4bg1+ZHxJxU6CfUa8htWvqJWhGTjoSOOp/C9rRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246844; c=relaxed/simple;
	bh=vJPsK944NJrtOQB0n80EHOxwLO+0L4GwTXAhQOqbP/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDnEgB92mEq7qJF00YjKm6zwXRROefvcdy5zgGcP9PGPbincxyUpnfMsGmr/eCiGo3GwckN8VS+IgZf+UldvhG2vkcC2E3tm07EeHSbAryDrIfJoDZ/zXJt8ZCuBwMsPe9GhyLcxNXe8yVK/96SzZC8Xu2uDv/tbsDiVFsEsQrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ea1Rmby6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729246840; x=1760782840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vJPsK944NJrtOQB0n80EHOxwLO+0L4GwTXAhQOqbP/4=;
  b=Ea1Rmby6XMot5FUWDma3lZLi9+KgaEWb4phGx2xuEnr2UT1mLlLVmYMS
   ZkBw8FjsBYHeIqDEivapaZ6oweOkAhtX+44RNXrBHnyzt3Qf/I+gBULIP
   TkuK6PyO5tQXA/Psf2d6dHLNdQZimjf779uOX76/syKA1ix8nqIFl4+0n
   vX7K9fy1nSCFWcdBoizwCj96hU1FdkEfZQTmGqLe7GzJB9FgDwYTOJZEg
   JxxdJFuhjP9+33alp+bSRgYQL4Hkj1TcpwvHDZW1OZgYI5VNhLq5LGCLl
   MkPkJBhTnAe7uvR+JbksHHuiJyyNYSbnNslf3F/B4uk9FJvZT6pklnUz2
   w==;
X-CSE-ConnectionGUID: /tmkOKTpR1WQhQYLZDPCyg==
X-CSE-MsgGUID: b+45W5tNQSeSIuEHVQDtKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="39401233"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="39401233"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 03:20:39 -0700
X-CSE-ConnectionGUID: 5xC6vYotTpKMrkCiaKCTMg==
X-CSE-MsgGUID: 7LgbhV1OQrm47bCQF1hFLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="78789341"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa010.jf.intel.com with ESMTP; 18 Oct 2024 03:20:38 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.186])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D6B2D28196;
	Fri, 18 Oct 2024 11:20:36 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH v1 7/7] devlink: remove unused devlink_resource_register()
Date: Fri, 18 Oct 2024 12:18:36 +0200
Message-ID: <20241018102009.10124-8-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241018102009.10124-1-przemyslaw.kitszel@intel.com>
References: <20241018102009.10124-1-przemyslaw.kitszel@intel.com>
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


