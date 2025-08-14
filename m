Return-Path: <netdev+bounces-213864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF91B272C3
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E551BC8A7E
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCDD2877E9;
	Thu, 14 Aug 2025 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LM1Kp7jb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B6828751A
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212948; cv=none; b=TB91DXMDKAmE1CQdXkJEMiyCv5vuzU2SBs5qVFdJU0NJ4RTckN9YylB7qg2OslYtCTvWXYq7cLHj/FesmRlF3huYKbfqUDdPSh8CQ+mmxiCVCiGXzzDminpx4zofVG9Y+nvTuku3a0Lz9GRRn7DWxr6i93QnhI2lKIH7Dv5vG1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212948; c=relaxed/simple;
	bh=FFv18lEdZsib+DAOmLgkGpMX433Y0yH7NNkJX7jUvlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHDfZs7+DPzGOMEGDDR3s6dyxDYpg7b60Q5nvJGvrPwCZZVt93Ew4bJq8GXjGfJsodqT8TC5hRR6ROabxarzRzEXrWwslRuURcSFKwBRJtJG0R37UXHcn3litOLFD1mlKgFNbz7hbFcG1TAomCzYrXWSIEhuVoZ4Zu/mFjQrrDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LM1Kp7jb; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755212946; x=1786748946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FFv18lEdZsib+DAOmLgkGpMX433Y0yH7NNkJX7jUvlI=;
  b=LM1Kp7jbNhoWeXd/DEKjvd9Pmu4Dn1RzqWSO1IldEqnEJBZoIhUg6fJd
   vI0ou5sU6nghPtt5PHv7iWmRHNIxXSUkZVum1fZz+ROzYuKkZw0cgoPyI
   ntRzM+ShqX2Dagn/hQu9tIpL80jq21z2JJhHYqyBLRmC+pd/efQrQ5zJV
   KTEkRuNCpNFlj5mEvcVlcxeW5shuKDjrBJhn1cRhfSJbQVYeLsCjytmLQ
   UOH3KkRy1zovMeKe19w8LVBumuRXvI2+qsycKAYB58JCt1wQSUmlCjci1
   aKUPF5cxME6rv1Bz2rl2Nrx0C1kPvVZkv8cotF28yxrpjFYEiHR3YYjIV
   w==;
X-CSE-ConnectionGUID: 7Pkgp79IQ5izfF8z8Egylg==
X-CSE-MsgGUID: Svld0C+ZRlqmhiz/rit1Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="45117961"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="45117961"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 16:09:04 -0700
X-CSE-ConnectionGUID: C2fQEQv2SE6pwqPm4uI3Fw==
X-CSE-MsgGUID: 46XM7EL+RPqbyEmCDqDntg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166848125"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 14 Aug 2025 16:09:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dave Ertman <david.m.ertman@intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 1/7] ice: Remove casts on void pointers in LAG code
Date: Thu, 14 Aug 2025 16:08:48 -0700
Message-ID: <20250814230855.128068-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250814230855.128068-1-anthony.l.nguyen@intel.com>
References: <20250814230855.128068-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Ertman <david.m.ertman@intel.com>

This series will be touching on the LAG code in the ice driver,
to prevent moving or propagating casting on void pointers, clean
them up first.

This also allows for moving the variable initialization into the
variable declaration.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index b1129da72139..96b11d8f1422 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -321,7 +321,7 @@ ice_lag_cfg_drop_fltr(struct ice_lag *lag, bool add)
 static void
 ice_lag_cfg_pf_fltrs(struct ice_lag *lag, void *ptr)
 {
-	struct netdev_notifier_bonding_info *info;
+	struct netdev_notifier_bonding_info *info = ptr;
 	struct netdev_bonding_info *bonding_info;
 	struct net_device *event_netdev;
 	struct device *dev;
@@ -331,7 +331,6 @@ ice_lag_cfg_pf_fltrs(struct ice_lag *lag, void *ptr)
 	if (event_netdev != lag->netdev)
 		return;
 
-	info = (struct netdev_notifier_bonding_info *)ptr;
 	bonding_info = &info->bonding_info;
 	dev = ice_pf_to_dev(lag->pf);
 
@@ -873,13 +872,12 @@ void ice_lag_complete_vf_reset(struct ice_lag *lag, u8 act_prt)
  */
 static void ice_lag_info_event(struct ice_lag *lag, void *ptr)
 {
-	struct netdev_notifier_bonding_info *info;
+	struct netdev_notifier_bonding_info *info = ptr;
 	struct netdev_bonding_info *bonding_info;
 	struct net_device *event_netdev;
 	const char *lag_netdev_name;
 
 	event_netdev = netdev_notifier_info_to_dev(ptr);
-	info = ptr;
 	lag_netdev_name = netdev_name(lag->netdev);
 	bonding_info = &info->bonding_info;
 
@@ -1344,11 +1342,10 @@ static void ice_lag_init_feature_support_flag(struct ice_pf *pf)
  */
 static void ice_lag_changeupper_event(struct ice_lag *lag, void *ptr)
 {
-	struct netdev_notifier_changeupper_info *info;
+	struct netdev_notifier_changeupper_info *info = ptr;
 	struct ice_lag *primary_lag;
 	struct net_device *netdev;
 
-	info = ptr;
 	netdev = netdev_notifier_info_to_dev(ptr);
 
 	/* not for this netdev */
@@ -1408,7 +1405,7 @@ static void ice_lag_changeupper_event(struct ice_lag *lag, void *ptr)
  */
 static void ice_lag_monitor_link(struct ice_lag *lag, void *ptr)
 {
-	struct netdev_notifier_changeupper_info *info;
+	struct netdev_notifier_changeupper_info *info = ptr;
 	struct ice_hw *prim_hw, *active_hw;
 	struct net_device *event_netdev;
 	struct ice_pf *pf;
@@ -1425,7 +1422,6 @@ static void ice_lag_monitor_link(struct ice_lag *lag, void *ptr)
 	prim_hw = &pf->hw;
 	prim_port = prim_hw->port_info->lport;
 
-	info = (struct netdev_notifier_changeupper_info *)ptr;
 	if (info->upper_dev != lag->upper_netdev)
 		return;
 
@@ -1454,8 +1450,8 @@ static void ice_lag_monitor_link(struct ice_lag *lag, void *ptr)
  */
 static void ice_lag_monitor_active(struct ice_lag *lag, void *ptr)
 {
+	struct netdev_notifier_bonding_info *info = ptr;
 	struct net_device *event_netdev, *event_upper;
-	struct netdev_notifier_bonding_info *info;
 	struct netdev_bonding_info *bonding_info;
 	struct ice_netdev_priv *event_np;
 	struct ice_pf *pf, *event_pf;
@@ -1480,7 +1476,6 @@ static void ice_lag_monitor_active(struct ice_lag *lag, void *ptr)
 	event_port = event_pf->hw.port_info->lport;
 	prim_port = pf->hw.port_info->lport;
 
-	info = (struct netdev_notifier_bonding_info *)ptr;
 	bonding_info = &info->bonding_info;
 
 	if (!bonding_info->slave.state) {
@@ -1527,8 +1522,8 @@ static void ice_lag_monitor_active(struct ice_lag *lag, void *ptr)
 static bool
 ice_lag_chk_comp(struct ice_lag *lag, void *ptr)
 {
+	struct netdev_notifier_bonding_info *info = ptr;
 	struct net_device *event_netdev, *event_upper;
-	struct netdev_notifier_bonding_info *info;
 	struct netdev_bonding_info *bonding_info;
 	struct list_head *tmp;
 	struct device *dev;
@@ -1554,7 +1549,6 @@ ice_lag_chk_comp(struct ice_lag *lag, void *ptr)
 		return false;
 	}
 
-	info = (struct netdev_notifier_bonding_info *)ptr;
 	bonding_info = &info->bonding_info;
 	lag->bond_mode = bonding_info->master.bond_mode;
 	if (lag->bond_mode != BOND_MODE_ACTIVEBACKUP) {
@@ -1664,10 +1658,9 @@ ice_lag_unregister(struct ice_lag *lag, struct net_device *event_netdev)
 static void
 ice_lag_monitor_rdma(struct ice_lag *lag, void *ptr)
 {
-	struct netdev_notifier_changeupper_info *info;
+	struct netdev_notifier_changeupper_info *info = ptr;
 	struct net_device *netdev;
 
-	info = ptr;
 	netdev = netdev_notifier_info_to_dev(ptr);
 
 	if (netdev != lag->netdev)
@@ -1837,9 +1830,8 @@ ice_lag_event_handler(struct notifier_block *notif_blk, unsigned long event,
 	lag_work->lag = lag;
 	lag_work->event = event;
 	if (event == NETDEV_CHANGEUPPER) {
-		struct netdev_notifier_changeupper_info *info;
+		struct netdev_notifier_changeupper_info *info = ptr;
 
-		info = ptr;
 		upper_netdev = info->upper_dev;
 	} else {
 		upper_netdev = netdev_master_upper_dev_get(netdev);
-- 
2.47.1


