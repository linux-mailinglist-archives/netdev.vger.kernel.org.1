Return-Path: <netdev+bounces-136947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FEF9A3B5E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5EA1C23EC2
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0F9202F72;
	Fri, 18 Oct 2024 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CjpYeC9C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C724202F82
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246841; cv=none; b=he4eItwjRJglDEjrKMwx9ySidfXxutzurB2wGK8Jkl+a1nkyG6/zlS105fO4Tas3YCnfjhPsZZLL/2IFd07vKRdaT6DRoldXg7foIvfMhXl9zoq/3GXAywO0C53ktfRipHuSeANRGLaWrhKT18YZlfw7pzcKQ3EdFpgXiakQ460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246841; c=relaxed/simple;
	bh=toIiZ4XBO93qQfD79LNoPMfRAYeyGyVEuXHBg/5+yYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRHfdNTw0yqfNAGu3h4PBvRU5oftzZE/b26Hd2cfdPiCS28LxcESfuiDWA/dWrFwbRH7izMKe8jhbx8XtJf3tXrdzgg7SqHzu6ApERm9Ly0TDYmkFlghcyftrBMo+vfKFPao9hmrT1+6/gsjcpV4THmHJHNwRFRbe5rpFGFi+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CjpYeC9C; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729246839; x=1760782839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=toIiZ4XBO93qQfD79LNoPMfRAYeyGyVEuXHBg/5+yYA=;
  b=CjpYeC9CdzUyKOkz2Ab1feFjKFApxw7mOpZVvbX7zhN2bG3DysxuAuZo
   zBKNral1ONwPbsVGSYvIrHxJ3SeIf1xeT394wclcN1riVyaJHKxwhm4ZS
   9d9TKzpglhcTHNVgywqgAO4ZJhFMYnXkCo93t51jnsmfaI9A8bZyFTxt5
   PeEtUAOIX8P2HJ11qwpd/BQAuZH5NmfG977u4xp/JfBFr+spixo+ysqQv
   rL9VxTaXjKwC9x2nNrycON7/zo5MtTwKtXCm015ZVp5r5bCN/CGvX0yg2
   RS8cA17PRTeBkYEvznc+C2ZoTrDYYJkM0nBNH2+r69vtnxxJBnAUwxjGK
   g==;
X-CSE-ConnectionGUID: WmWmdC5+TQOc8RiV9n/GUw==
X-CSE-MsgGUID: LGetxB/dTJWlOmkreEIF5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="39401231"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="39401231"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 03:20:39 -0700
X-CSE-ConnectionGUID: 7boX34nuTX61niSKtOrzIw==
X-CSE-MsgGUID: IQ9trskNQY+7MIbyEVj+og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="78789335"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa010.jf.intel.com with ESMTP; 18 Oct 2024 03:20:37 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.186])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DD14D28195;
	Fri, 18 Oct 2024 11:20:35 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH v1 6/7] devlink: remove unused devlink_resource_occ_get_register() and _unregister()
Date: Fri, 18 Oct 2024 12:18:35 +0200
Message-ID: <20241018102009.10124-7-przemyslaw.kitszel@intel.com>
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

Remove not used devlink_resource_occ_get_register() and
devlink_resource_occ_get_unregister() functions; current devlink resource
users are fine with devl_ variants of the two.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 include/net/devlink.h  |  7 -------
 net/devlink/resource.c | 39 ---------------------------------------
 2 files changed, 46 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index db5eff6cb60f..fdd6a0f9891d 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1797,15 +1797,8 @@ void devl_resource_occ_get_register(struct devlink *devlink,
 				    u64 resource_id,
 				    devlink_resource_occ_get_t *occ_get,
 				    void *occ_get_priv);
-void devlink_resource_occ_get_register(struct devlink *devlink,
-				       u64 resource_id,
-				       devlink_resource_occ_get_t *occ_get,
-				       void *occ_get_priv);
 void devl_resource_occ_get_unregister(struct devlink *devlink,
 				      u64 resource_id);
-
-void devlink_resource_occ_get_unregister(struct devlink *devlink,
-					 u64 resource_id);
 int devl_params_register(struct devlink *devlink,
 			 const struct devlink_param *params,
 			 size_t params_count);
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 96c0ff24b65a..a923222bbde8 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -513,28 +513,6 @@ void devl_resource_occ_get_register(struct devlink *devlink,
 }
 EXPORT_SYMBOL_GPL(devl_resource_occ_get_register);
 
-/**
- *	devlink_resource_occ_get_register - register occupancy getter
- *
- *	@devlink: devlink
- *	@resource_id: resource id
- *	@occ_get: occupancy getter callback
- *	@occ_get_priv: occupancy getter callback priv
- *
- *	Context: Takes and release devlink->lock <mutex>.
- */
-void devlink_resource_occ_get_register(struct devlink *devlink,
-				       u64 resource_id,
-				       devlink_resource_occ_get_t *occ_get,
-				       void *occ_get_priv)
-{
-	devl_lock(devlink);
-	devl_resource_occ_get_register(devlink, resource_id,
-				       occ_get, occ_get_priv);
-	devl_unlock(devlink);
-}
-EXPORT_SYMBOL_GPL(devlink_resource_occ_get_register);
-
 /**
  * devl_resource_occ_get_unregister - unregister occupancy getter
  *
@@ -557,20 +535,3 @@ void devl_resource_occ_get_unregister(struct devlink *devlink,
 	resource->occ_get_priv = NULL;
 }
 EXPORT_SYMBOL_GPL(devl_resource_occ_get_unregister);
-
-/**
- *	devlink_resource_occ_get_unregister - unregister occupancy getter
- *
- *	@devlink: devlink
- *	@resource_id: resource id
- *
- *	Context: Takes and release devlink->lock <mutex>.
- */
-void devlink_resource_occ_get_unregister(struct devlink *devlink,
-					 u64 resource_id)
-{
-	devl_lock(devlink);
-	devl_resource_occ_get_unregister(devlink, resource_id);
-	devl_unlock(devlink);
-}
-EXPORT_SYMBOL_GPL(devlink_resource_occ_get_unregister);
-- 
2.46.0


