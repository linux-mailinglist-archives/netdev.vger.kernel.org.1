Return-Path: <netdev+bounces-213096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C75AB23A39
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 22:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BECA57B8F0E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 20:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517DA2D6E6E;
	Tue, 12 Aug 2025 20:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAGmBIIc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A758B2D0624
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755031958; cv=none; b=Wxp9mPlO6WnQVUTUFiiQHfL5bH9A0obk088m1ZC1O0bkuXa50+UKhWXMrECu3p44Wa9PhDfx6OK/l+FRoO+fnO82hwho4+HHx8P3LXdn5RbfqGWy7OQsrPocXPOt974lDGKNa+VTe0oftllX4Xxqew+ft5Qgw6Ze/uVdXUVDIsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755031958; c=relaxed/simple;
	bh=NQaKrFTVkYTvd9WbtbFWTA1AuASNp+vEtdnNuj9Dx+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgfcOSWDIJeBytSCwDy6iB+clp/og2olvju75fqxRW2omrHdtOTClghAq9cKeJkcf/RKyFX6kP0MnMK9LBQa+CaAwz+7vXQz6E1jDCzIocX8OMcPgwc4peR9XH1ILt9mXijlZ5FaOfjB2kqCk4TD13UFrl9E4T0BDrm1okAAuDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAGmBIIc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755031957; x=1786567957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NQaKrFTVkYTvd9WbtbFWTA1AuASNp+vEtdnNuj9Dx+o=;
  b=VAGmBIIcWQPfHrvwGDMeA/ASg/QXNsv8u5z5z5M6JkqtSz2YbnjvDwiX
   wOCSi0EueaNUFS0ADN2Ivy3ZVAEutjNy1aw2ESNVsKOK0sBpv6sOUwiUJ
   fxoW0dJsTJJQB3htvXz5V/Pxg2LBmrA661Rt/1Es5MzVu7aTyLi5zJ4qf
   KdPW36lydeFLYwVtZ3Khe5B6d+h0wBIFqEi1e536NtrVWvnjdBJFZJKJe
   oC26WchD6Tw4MPUuqmXJ/GlMo6Qhm4JoVpXFkIAe+AxEAMSyfnheeKiIR
   bB2xNpqsQg5mdRkEjJQcmjrEWIqoWxIafJaWtyJgAIvuFr7Gf0blLjTXS
   g==;
X-CSE-ConnectionGUID: klr+P1MpRLS1VOM8EgLHcw==
X-CSE-MsgGUID: J7+BYKZ+QDClhXeaws6mrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68775091"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="68775091"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 13:52:35 -0700
X-CSE-ConnectionGUID: nBT52srTTkOqfq0ukQdHsQ==
X-CSE-MsgGUID: xPrb74trQ2aHwzaue+m86A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="203474838"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 12 Aug 2025 13:52:34 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	David.Kaplan@amd.com,
	dhowells@redhat.com,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net v3 2/2] ixgbe: prevent from unwanted interface name changes
Date: Tue, 12 Aug 2025 13:52:24 -0700
Message-ID: <20250812205226.1984369-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250812205226.1984369-1-anthony.l.nguyen@intel.com>
References: <20250812205226.1984369-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Users of the ixgbe driver report that after adding devlink support by
the commit a0285236ab93 ("ixgbe: add initial devlink support") their
configs got broken due to unwanted changes of interface names. It's
caused by automatic phys_port_name generation during devlink port
initialization flow.

To prevent from that set no_phys_port_name flag for ixgbe devlink ports.

Reported-by: David Howells <dhowells@redhat.com>
Closes: https://lore.kernel.org/netdev/3452224.1745518016@warthog.procyon.org.uk/
Reported-by: David Kaplan <David.Kaplan@amd.com>
Closes: https://lore.kernel.org/netdev/LV3PR12MB92658474624CCF60220157199470A@LV3PR12MB9265.namprd12.prod.outlook.com/
Fixes: a0285236ab93 ("ixgbe: add initial devlink support")
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index 54f1b83dfe42..d227f4d2a2d1 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -543,6 +543,7 @@ int ixgbe_devlink_register_port(struct ixgbe_adapter *adapter)
 
 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
 	attrs.phys.port_number = adapter->hw.bus.func;
+	attrs.no_phys_port_name = 1;
 	ixgbe_devlink_set_switch_id(adapter, &attrs.switch_id);
 
 	devlink_port_attrs_set(devlink_port, &attrs);
-- 
2.47.1


