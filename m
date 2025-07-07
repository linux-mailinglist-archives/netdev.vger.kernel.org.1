Return-Path: <netdev+bounces-204512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867B2AFAF58
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 11:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D1D17F6CF
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 09:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56E128CF79;
	Mon,  7 Jul 2025 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5jnQYb0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7845B28CF6D
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751879707; cv=none; b=bann8pzHKhku79BOyCyRqBogvtTZjCsohBNN8x85fSLuxjqaV0tZEtVG0X+PwlTT8MluBpB+KClvAitr+UdqVOWzQfWU+KJCt1megmo2gqlv31C35CS9AQANH8mzRI7R8TGBpvLZJAkMp7zDyX0ysd6cscD+RUdCsFCeJ977Edw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751879707; c=relaxed/simple;
	bh=Fnk2ILkbvf/XI4Kx3G6gmlk0qASx3GjBL2OnPBfp2pI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NA3qLgkcYG/vQPzeCryyBwXOn4u6CoURjXdw5kUDlmjeKhmMstq52/dujTh+HJx0cC/Odv/7oQaL3u/lTFKRvabmDE0pZxGeGCBA14ASE1NjaHfMj4n8K4tz5jnRfjeR1aFM6HguZ/yXNPNuKElIrEaDjL3Glr01lIivKGyAxz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5jnQYb0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751879705; x=1783415705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fnk2ILkbvf/XI4Kx3G6gmlk0qASx3GjBL2OnPBfp2pI=;
  b=O5jnQYb0ec+Or+ZPmJDjV9FFiI4khu0UMVCC3kfB7E2UA8zkF5YUtgLl
   agW2zYwmDDRr9L5aqYiAC7QXYGglrFCSMNjmBgNCgJ2g71CN/AOE5qNhY
   9wXVtqh9tkw9d1C7N9mf+n4B4PhRKGIFZ6G74WYNz/WqpkPjcbTT3ObSl
   RU91Je9+BLEu2/SOv4Hkh7OsPq8JLpG83mn1zFbzRIk9XRb6OjK+2pKFH
   el8A0eExX7y89fjgNTR7S9moASv0tYHaDe2MV6vTX9i7YzTaLyxC99V13
   TyZ0jAKKZlB7PeHrfnh4DWUNMa+ExOmuXijaBVUZNLHP18O5M/j1edbep
   Q==;
X-CSE-ConnectionGUID: aJz+LsbATa+5B8ia/LDsPA==
X-CSE-MsgGUID: zQjJjc6+QgWkHc6D0fUozg==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="57897114"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="57897114"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 02:15:04 -0700
X-CSE-ConnectionGUID: EuHg3E3kRq6NYjZ3RsTS1Q==
X-CSE-MsgGUID: HGQa/TbHR3Cjf3qgr3SoJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="154578671"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa006.jf.intel.com with ESMTP; 07 Jul 2025 02:15:01 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	dhowells@redhat.com,
	David.Kaplan@amd.com,
	jiri@resnulli.us,
	przemyslaw.kitszel@intel.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH iwl-net v2 2/2] ixgbe: prevent from unwanted interface name changes
Date: Mon,  7 Jul 2025 10:58:37 +0200
Message-Id: <20250707085837.1461086-2-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250707085837.1461086-1-jedrzej.jagielski@intel.com>
References: <20250707085837.1461086-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users of the ixgbe driver report that after adding devlink
support by the commit a0285236ab93 ("ixgbe: add initial devlink support")
their configs got broken due to unwanted changes of interfaces names.
It's caused by changing names by devlink port initialization flow.

To prevent from that set skip_phys_port_name_get flag for ixgbe
devlink ports.

Reported-by: David Howells <dhowells@redhat.com>
Closes: https://lkml.org/lkml/2025/4/24/2052
Reported-by: David Kaplan <David.Kaplan@amd.com>
Closes: https://www.spinics.net/lists/netdev/msg1099410.html
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Fixes: a0285236ab93 ("ixgbe: add initial devlink support")
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v2: use new flag instead of creating blank implementation of
    ndo_get_phys_port_name()
---
 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index 54f1b83dfe42..47fae5035b9f 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -543,6 +543,7 @@ int ixgbe_devlink_register_port(struct ixgbe_adapter *adapter)
 
 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
 	attrs.phys.port_number = adapter->hw.bus.func;
+	attrs.skip_phys_port_name_get = 1;
 	ixgbe_devlink_set_switch_id(adapter, &attrs.switch_id);
 
 	devlink_port_attrs_set(devlink_port, &attrs);
-- 
2.31.1


