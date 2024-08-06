Return-Path: <netdev+bounces-116129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2526394932A
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54C4281DF3
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C41F1BE85C;
	Tue,  6 Aug 2024 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+fdvjKz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA85166F1B
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954893; cv=none; b=pnABZ3/e2EjPvoVYpSuT9sSguwZUr1EY+4E3e8C3cLXAlMKEyN5W7FIS1Gd0npErThtDljF3JT3+/jRRZ8Lpjov1NOOLnKmFWuGhTPgIsOzrFGsp3zPPq44Blmc8+FndX+ZsRilKVX/+BaxPHxo8m9TAJp5OT/2OFalFO/ia24c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954893; c=relaxed/simple;
	bh=l2+DWoxrNzXQLMwKZYrnPWRwkQteaDc39IHsxX467Tc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qek7kirToja+zezqoIZ30YM1y21llnpCkf0Cn+hlFEzlRdHWoiGJcmVu9xdqgbqAaVPzbskZHOfzVDv3UdK3IHyhs0Rzm58z34sm2vy0W3X/CBU7HdMo5VrmWx05hcXRamqB+c65cHAVTH0fGlRZvnhxKRqBLpxYBBxXKIAY960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+fdvjKz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722954893; x=1754490893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l2+DWoxrNzXQLMwKZYrnPWRwkQteaDc39IHsxX467Tc=;
  b=T+fdvjKzPUSM4Z8ulOzYQ2Q2EcplWQ8PCjyrpYdaOsoHu7jh80YDPkne
   BzFL+xC8VQqJ136/lqoXhQpQFIBVRdUHfeM6X5OVFgNzzd+7WwyT0uqKN
   9dECf4QmHVFQirwnTT+I96ijGqlgWVV6JIBnNu34APJW47IcBNj3+U6RK
   ++Lwfhux6g33vA0Ynulb3oUeF3pK3PjIyayEImfu/mLybWBPqh6OKPEWM
   5diY7MB//n9apwTzsA+dYNdp5W5rPJpUvDW0jbgzvz2qwuFIGQrgYKCEV
   d8sujvHLZ6U2jZSGXqLadIu9put0hjikTPcZx9jJcAMuJWDXGrxOlSHov
   Q==;
X-CSE-ConnectionGUID: qZ1SGg9TRMWf7v4kVCFMuw==
X-CSE-MsgGUID: GtkTZ58iSdeCI7xuw2XNAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38428570"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38428570"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 07:34:51 -0700
X-CSE-ConnectionGUID: iCgJhR3iS1qISEFpsRSvMQ==
X-CSE-MsgGUID: BHnq8UedQwePcm6P5tQUcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56502644"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 06 Aug 2024 07:34:47 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2144B28795;
	Tue,  6 Aug 2024 15:34:45 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH net-next 1/5] net: dsa: replace devlink resource registration calls by devl_ variants
Date: Tue,  6 Aug 2024 16:33:03 +0200
Message-Id: <20240806143307.14839-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240806143307.14839-1-przemyslaw.kitszel@intel.com>
References: <20240806143307.14839-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace devlink_resource_register(), devlink_resource_occ_get_register(),
and devlink_resource_occ_get_unregister() calls by respective devl_*
variants. Mentioned functions have no direct users in any drivers, and are
going to be removed in subsequent patches.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 net/dsa/devlink.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/dsa/devlink.c b/net/dsa/devlink.c
index 0aac887d0098..f41f9fc2194e 100644
--- a/net/dsa/devlink.c
+++ b/net/dsa/devlink.c
@@ -229,10 +229,15 @@ int dsa_devlink_resource_register(struct dsa_switch *ds,
 				  u64 parent_resource_id,
 				  const struct devlink_resource_size_params *size_params)
 {
-	return devlink_resource_register(ds->devlink, resource_name,
-					 resource_size, resource_id,
-					 parent_resource_id,
-					 size_params);
+	int ret;
+
+	devl_lock(ds->devlink);
+	ret = devl_resource_register(ds->devlink, resource_name, resource_size,
+				     resource_id, parent_resource_id,
+				     size_params);
+	devl_unlock(ds->devlink);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dsa_devlink_resource_register);
 
@@ -247,15 +252,19 @@ void dsa_devlink_resource_occ_get_register(struct dsa_switch *ds,
 					   devlink_resource_occ_get_t *occ_get,
 					   void *occ_get_priv)
 {
-	return devlink_resource_occ_get_register(ds->devlink, resource_id,
-						 occ_get, occ_get_priv);
+	devl_lock(ds->devlink);
+	devl_resource_occ_get_register(ds->devlink, resource_id, occ_get,
+				       occ_get_priv);
+	devl_unlock(ds->devlink);
 }
 EXPORT_SYMBOL_GPL(dsa_devlink_resource_occ_get_register);
 
 void dsa_devlink_resource_occ_get_unregister(struct dsa_switch *ds,
 					     u64 resource_id)
 {
-	devlink_resource_occ_get_unregister(ds->devlink, resource_id);
+	devl_lock(ds->devlink);
+	devl_resource_occ_get_unregister(ds->devlink, resource_id);
+	devl_unlock(ds->devlink);
 }
 EXPORT_SYMBOL_GPL(dsa_devlink_resource_occ_get_unregister);
 
-- 
2.39.3


