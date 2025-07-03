Return-Path: <netdev+bounces-203783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0BBAF72D4
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892E23AED65
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9344256C71;
	Thu,  3 Jul 2025 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGwyaWD9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6AB238C0D
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543202; cv=none; b=u12MBFmIPgZXnbEreDo4mfovrMR5c1+gSnxYcmkkde8IJQiNnLkc2kwvMgyTpf4CZQWszQ41iZY/8inXB6ptgclLFowpvKSJS6qxDU3JbiIJTqEFqUk3F/R1HY9bYELYFO812YtCGqdM5OTJNqog25JB+eH7KxEP5+/p52nkusY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543202; c=relaxed/simple;
	bh=cgMuh17xA1ql/xkR2cAotkaIPYhgV1dPC0GUwBHrweQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K78DjfGNAzaedGSkilktR5rTZm+E6YzsG+xmPw3gbs9T0PCQ/4xnJ9vkpxc2Nj+CuDvVhAmsjjxnGT6u7XLMCsrpPkguKjNkTRHseoYVapx5o/WalRTvD/R22+Xd0CB3KgyKz20PcxuzVrdXmX5sXOoJ7m0bAemCLXrCQeaYNS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGwyaWD9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751543202; x=1783079202;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cgMuh17xA1ql/xkR2cAotkaIPYhgV1dPC0GUwBHrweQ=;
  b=iGwyaWD9mHgFnp0+u1bhZhOJQCtOJrvUdTIjyNhsp1qfQMd4fgEKQc7W
   p+73jZXy2wtkeWMeig/8CLLPSGeoH6gTAKj14p97Iv81eD11dbpetFXI/
   EzWLSdy70JSHd877MtlJYa6o/QzUv+x63/TKOBbBjRnyl5qq8wMpW2OdV
   hPWC5yAYwwWXsOO79Kqv58KNmrwWmr64Rs6uY+bJLefbwYWKDGSnylCyh
   7wyFQnQDnURurKwbAuhFUFeH3+LpdprMrsrHpjzWO6OsXEHBO8rHAjgtR
   wFGVS8YLDYjt0PVQ3qHrRcUqxTx8wQ8TnOEymHyngkmwgxqZhYOYeLjZS
   A==;
X-CSE-ConnectionGUID: exYEp//hQoSZKDN+JAiXIQ==
X-CSE-MsgGUID: R+CDUV8oTyeCH29kEI7g1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="76411120"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="76411120"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 04:46:41 -0700
X-CSE-ConnectionGUID: RcthAU26TCegUM8ad0krlA==
X-CSE-MsgGUID: CWKNUrJmSgSMWUd1meejsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="153780323"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa006.jf.intel.com with ESMTP; 03 Jul 2025 04:46:39 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	david.kaplan@amd.com,
	dhowells@redhat.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v1 1/2] devlink: allow driver to freely name interfaces
Date: Thu,  3 Jul 2025 13:30:21 +0200
Message-Id: <20250703113022.1451223-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently when adding devlink port it is prohibited to let
a driver name an interface on its own. In some scenarios
it would not be preferable to provide such limitation.

Remove triggering the warning when ndo_get_phys_port_name() is
implemented for driver which interface is about to get a devlink
port on.

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 net/devlink/port.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/net/devlink/port.c b/net/devlink/port.c
index 939081a0e615..f885c8e73307 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -1161,23 +1161,6 @@ static void devlink_port_type_netdev_checks(struct devlink_port *devlink_port,
 {
 	const struct net_device_ops *ops = netdev->netdev_ops;
 
-	/* If driver registers devlink port, it should set devlink port
-	 * attributes accordingly so the compat functions are called
-	 * and the original ops are not used.
-	 */
-	if (ops->ndo_get_phys_port_name) {
-		/* Some drivers use the same set of ndos for netdevs
-		 * that have devlink_port registered and also for
-		 * those who don't. Make sure that ndo_get_phys_port_name
-		 * returns -EOPNOTSUPP here in case it is defined.
-		 * Warn if not.
-		 */
-		char name[IFNAMSIZ];
-		int err;
-
-		err = ops->ndo_get_phys_port_name(netdev, name, sizeof(name));
-		WARN_ON(err != -EOPNOTSUPP);
-	}
 	if (ops->ndo_get_port_parent_id) {
 		/* Some drivers use the same set of ndos for netdevs
 		 * that have devlink_port registered and also for
-- 
2.31.1


