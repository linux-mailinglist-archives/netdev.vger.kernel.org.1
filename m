Return-Path: <netdev+bounces-131883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 046B598FD93
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 08:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF09C1F21530
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 06:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88464129E93;
	Fri,  4 Oct 2024 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9QoQALh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFF382499
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728024930; cv=none; b=fgQsYFwdTZzGJb6ULuP36R2hg2NRwP+NtUemQYElgAnCMtCiYwavxaFHmxrvKmWHb4xOm1jDN1/TRjIUqhVweEsOzOe4gbWwFoaWcgDxtEUwNFMyRbWXBqUHwM7OseiYe+vpooyaNjpf1mpF7KuXcb625Yq+czOpMbf3OSulDnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728024930; c=relaxed/simple;
	bh=Cyh7Ua2jGouYHzGE+b7S2AoRHtkTUzXF0bkm+UuK2ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uVidMTvLfhXMoPCyu09xXTky2bnj/DmJuP+PZJuRQgwA8K2cXFK162aUtD6TeRhSGw6cXkliqWuQJMNBUdHM+0uZ4eliNJzMilGcA+JB7RewaD1ZRv7DXCzmPXRfqxzumzKq/XvB9Ig8/YSAVEPo3SPbkivH4Eg6t/yzIzbPoNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9QoQALh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728024928; x=1759560928;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Cyh7Ua2jGouYHzGE+b7S2AoRHtkTUzXF0bkm+UuK2ow=;
  b=D9QoQALh3rUGvtO93JcQew5nifhXWA8ubBavbHwXOOvzgJ69j0hYh8e/
   N685FmNxJWY2JV/C7jyBBTjvsM/R2lBazyWAgeCEpXCsZHVKb/q+CbfSE
   3A98ZCSuGLASEABgDFzvJpiyq4U2m0SbNW/3RjgtSdDYr33a6GdddHHDG
   J8wqq0BfUa0AglXD1rfVEu+40RrVG6MrCAsuayas5gAVKhlECF3ftp2OO
   VycEOD70ZS98DSMlKw3LA2ZvStIDVLeuCkdtUG4/deLnUwghQfvQqOAhP
   5ejIJWtD2bkJ3jvoIYeIZ9uovJI0FbA34ZaS0PtvSGPvhRLfZ05S/SXQv
   g==;
X-CSE-ConnectionGUID: AuBJRW0tQnawsWaSkUl7Ig==
X-CSE-MsgGUID: 3BB3DBICRFimX3OZUMysVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="38627190"
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="38627190"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 23:55:28 -0700
X-CSE-ConnectionGUID: B8vUTS9MRfmeHm5B0Fdo6Q==
X-CSE-MsgGUID: L7ZtoNUmTQO5Lnv5eXI5Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="79583977"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa004.jf.intel.com with ESMTP; 03 Oct 2024 23:55:27 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [iwl-net v1] ice: block SF port creation in legacy mode
Date: Fri,  4 Oct 2024 08:55:26 +0200
Message-ID: <20241004065526.7306-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no support for SF in legacy mode. Reflect it in the code.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Fixes: eda69d654c7e ("ice: add basic devlink subfunctions support")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink_port.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
index 928c8bdb6649..c6779d9dffff 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
@@ -989,5 +989,11 @@ ice_devlink_port_new(struct devlink *devlink,
 	if (err)
 		return err;
 
+	if (!ice_is_eswitch_mode_switchdev(pf)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "SF ports are only supported in eswitch switchdev mode");
+		return -EOPNOTSUPP;
+	}
+
 	return ice_alloc_dynamic_port(pf, new_attr, extack, devlink_port);
 }
-- 
2.42.0


