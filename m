Return-Path: <netdev+bounces-138243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 821139ACAE1
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393ED1F20CAC
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E550B1C726D;
	Wed, 23 Oct 2024 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJuuHUia"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392F21C3F26;
	Wed, 23 Oct 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689218; cv=none; b=CYncUuMhXd9g4hZ+oLe68E3h7hVu/gpnoh+RFUlS3PwGcgC+j+j2+6J/oZXA0LyR1hi7DpwREkM3TR/FsFP64GMobNVoQ+tHd99jbSyQCXNPizcnbncpGrUh85iUc9pqVxyyvbpP+dxbARkkszOnLTs4MGGOQ7Stxc0jh0Vequ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689218; c=relaxed/simple;
	bh=lD1NtL7Hk81JQJLAmJRDC3Ndm3BotD4JGmSHT1DrU0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDfNhvdpAJDZm87c6N4KPxLcpQiX9ixjYL82zgtbLxlybf13ugN2CT1JYVD17jYwpWt3/RtMSrDzIt0nHS1ruVaal54PeZdHIiKLt+1gXUmFtUeevXx4ZiKdIDrc6bgSwS5YXO9iQ8FIj5WrnXy8w+PZdJ3w5d9H0srUtqzl7sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJuuHUia; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729689217; x=1761225217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lD1NtL7Hk81JQJLAmJRDC3Ndm3BotD4JGmSHT1DrU0M=;
  b=MJuuHUiasi0WaYAGperzECkBPAYbzmjAzQxLUqK9C/NPJPdoJ5IeovxT
   osnj0n6TtuuT7sYb9T9bM9UyQt3siQTZDr+BZA1+MRi9noJZqudbJdJfE
   a5gNThDoXA4Qh+PgDLHfdB2eJSi6jnl+1w2LEege1AK+xGJm1KlXdXYm9
   fv0hFgF8yip1MgOW0PSN6ui0NdHeQ9lnJusMqA+CiJn8tsSMfLZWHUUMl
   DHiMIT3b3E9dUSzum+WIATPdMJ5zXzRa3tz0/7Nog7FxnPMqgtdAqiI+a
   p81qdZankqtUUuxU0Wq+SRJNp9GsBk9C4eXif6H2mMbswxx0tZoGVX5Bt
   Q==;
X-CSE-ConnectionGUID: F5QPXEsZQBuBCyoNsWh9+A==
X-CSE-MsgGUID: bdN9+DjYS1ikGHa9gFp88w==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="46758605"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="46758605"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 06:13:36 -0700
X-CSE-ConnectionGUID: 8FZMuWqUQdSDJhtoiuGoJg==
X-CSE-MsgGUID: 533S3WnjT8CdmTnpRZ3oLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="84820130"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 23 Oct 2024 06:13:33 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.71])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6D15C2877A;
	Wed, 23 Oct 2024 14:13:30 +0100 (IST)
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
Subject: [PATCH net-next v2 6/7] devlink: remove unused devlink_resource_occ_get_register() and _unregister()
Date: Wed, 23 Oct 2024 15:09:06 +0200
Message-ID: <20241023131248.27192-7-przemyslaw.kitszel@intel.com>
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

Remove not used devlink_resource_occ_get_register() and
devlink_resource_occ_get_unregister() functions; current devlink resource
users are fine with devl_ variants of the two.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
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


