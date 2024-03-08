Return-Path: <netdev+bounces-78693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0156F87628E
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 11:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9568D1F24CDB
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 10:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE77955E6E;
	Fri,  8 Mar 2024 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ip2yxXD1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0E855C07
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895558; cv=none; b=OvZMq9iSlagVHwPtX1m5QOfAsqdddi3slvpByZaQnEcQcgMUKorrNCBtLzhbEvlrxOZCXnWna6BZ9pv8Twtvii9VzbozKRqKgD92efdnI5d6l/4D18RxaBwFubDlpBjyLPkZraC48om1uA0klKMtlVxfMkHHQv0fhzu6xNlmwhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895558; c=relaxed/simple;
	bh=f0q/a0xnG5kf2q9i0qrlrTW4lXpdu1y5FLz5rkNT36w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8sjFFk7pQdsFGj4sBPq+iYGRJNuWxtAjJaAINOorV5mB+1KxeCMAisyjpAm4gTE23tDDjEVl3jWEJrXLUlM97/JKBAsWZOtQaj3KFZVigjhSmYcpmGdaBw+MGUa5nqLki95c+oWAjtjr97TUHtin3QTFdRf7f1IppzfnVXz3FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ip2yxXD1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709895557; x=1741431557;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f0q/a0xnG5kf2q9i0qrlrTW4lXpdu1y5FLz5rkNT36w=;
  b=ip2yxXD1E1y6iQO24rkn+ZSd9DicbREp4/SnPW8xf9aouSlzroUYwCow
   qRwo3QAmzQiwPXc0nqARhEh6yFciNjbMCfQ0lSS04UfCyoPy+yp9FCyG9
   shw3NQdJ6oUJb1o+3vdKe149L6C71/jM39UvYVuArRWbTJJuy7/K1oaUf
   CEBhC/u2Swgdcwi7MpNqqtnJSasX1LAhBpCx20lr/CfcdZdNvVNKhrZ4J
   hgRSH02/ziyOPC7U3jFM+Ys9tcZCvzEOMt+531wyxpY9dt4AQsyJZ2k3p
   SqVR6V5oK5D+XStdPTCj7yyFpYkK4TibElLsN1BPRzS/rlbvN6GnEns13
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="22061214"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="22061214"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 02:59:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10471781"
Received: from ngic1.igk.intel.com (HELO Oahu.igk.intel.com) ([10.237.112.172])
  by orviesa009.jf.intel.com with ESMTP; 08 Mar 2024 02:59:16 -0800
From: Dariusz Aftanski <dariusz.aftanski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Dariusz Aftanski <dariusz.aftanski@linux.intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v1] ice: Remove ndo_get_phys_port_name
Date: Fri,  8 Mar 2024 11:58:42 +0100
Message-ID: <20240308105842.141723-1-dariusz.aftanski@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ndo_get_phys_port_name is never actually used, as in switchdev
devklink is always being created.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Dariusz Aftanski <dariusz.aftanski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_repr.c | 34 -----------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 5f30fb131f74..1f2242a4990e 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -8,39 +8,6 @@
 #include "ice_tc_lib.h"
 #include "ice_dcb_lib.h"
 
-/**
- * ice_repr_get_sw_port_id - get port ID associated with representor
- * @repr: pointer to port representor
- */
-static int ice_repr_get_sw_port_id(struct ice_repr *repr)
-{
-	return repr->src_vsi->back->hw.port_info->lport;
-}
-
-/**
- * ice_repr_get_phys_port_name - get phys port name
- * @netdev: pointer to port representor netdev
- * @buf: write here port name
- * @len: max length of buf
- */
-static int
-ice_repr_get_phys_port_name(struct net_device *netdev, char *buf, size_t len)
-{
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_repr *repr = np->repr;
-	int res;
-
-	/* Devlink port is registered and devlink core is taking care of name formatting. */
-	if (repr->vf->devlink_port.devlink)
-		return -EOPNOTSUPP;
-
-	res = snprintf(buf, len, "pf%dvfr%d", ice_repr_get_sw_port_id(repr),
-		       repr->id);
-	if (res <= 0)
-		return -EOPNOTSUPP;
-	return 0;
-}
-
 /**
  * ice_repr_get_stats64 - get VF stats for VFPR use
  * @netdev: pointer to port representor netdev
@@ -240,7 +207,6 @@ ice_repr_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 }
 
 static const struct net_device_ops ice_repr_netdev_ops = {
-	.ndo_get_phys_port_name = ice_repr_get_phys_port_name,
 	.ndo_get_stats64 = ice_repr_get_stats64,
 	.ndo_open = ice_repr_open,
 	.ndo_stop = ice_repr_stop,
-- 
2.44.0


