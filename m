Return-Path: <netdev+bounces-211376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F059AB18690
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 19:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D20F74E0211
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBB227932B;
	Fri,  1 Aug 2025 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHMU+YgP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7813726B75F
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068973; cv=none; b=Mht7eN4ySrHBJEC9AKk1fevbrfLuZUb8RHGDBKAY9+4kY37zKWqeGF6q3/p93Ht5L76zgccWOxIrd0RuPaTntOv3IErWJZ+oKCZT3Zzbx1Q3PQp/DlL1O+N/1q5ZHy33jNdUjs6XNq0ViFda8pe7lwEJrrS2Lcd6BQ88NSVrZuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068973; c=relaxed/simple;
	bh=WVO/16bk77qELjughOGaRrI04Xjwd/+unsnwkLeI34A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rx7Mqsa56LHCoQu3umEs9iie+T2loSLIK7ZRaUin6CPUcNlSVrSYv4onOTiBAopP4qW9EU9HA272HnAGRuRajt31tpsTDkWpZbDsVUN7rYRHMx3iotKP/cIsEljzpLKdiRSrnNSpIM7DGokOlLwftQ3XU9X9GY+plOf6KiVJnGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iHMU+YgP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754068973; x=1785604973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WVO/16bk77qELjughOGaRrI04Xjwd/+unsnwkLeI34A=;
  b=iHMU+YgPfDuaaLaqfH4ckqjE3Js/F7xdkG9AMOlyp1HJXV0bHjKegSLf
   nF9xGIhHNHscNCNbKyPl+Pnl/pVShKRfuTSVsxmhBZu1dJXgnEjJy+8OO
   LRpRwWD5ptbgrtnR0UjjLDTdNKPi58pxPuM2M2JLbLZNuC8u6qwIZkpXk
   ZPYIjRSOU1ID02VQ6knrI1AUSrFBfpFoMj6vfP+t1KgfgLDYy0LDcvKwK
   uerRqsfDnw2N847HD4NorwNce3lURZn3RBHRjRcq6sRsTXnBiSiLDmJeK
   Y0M4H5vcgDmfjpp/tQn0bEyj7v72YjJMrW79Sz8c9ZublqRCmxp3tG5pw
   w==;
X-CSE-ConnectionGUID: O6tin7zgQyCNh1puX/21Bw==
X-CSE-MsgGUID: d0Wn5cnfRv22ak+VBC9BYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="59044393"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="59044393"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 10:22:50 -0700
X-CSE-ConnectionGUID: gbERCWveT2u81pIcYSJUlQ==
X-CSE-MsgGUID: xBUkFWZ6TL+I/oOyKozncg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="168915250"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 01 Aug 2025 10:22:49 -0700
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
	jiri@resnulli.us,
	horms@kernel.org,
	David.Kaplan@amd.com,
	dhowells@redhat.com,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 2/2] ixgbe: prevent from unwanted interface name changes
Date: Fri,  1 Aug 2025 10:22:38 -0700
Message-ID: <20250801172240.3105730-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250801172240.3105730-1-anthony.l.nguyen@intel.com>
References: <20250801172240.3105730-1-anthony.l.nguyen@intel.com>
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
configs got broken due to unwanted changes of interfaces names. It's
caused by changing names by devlink port initialization flow.

To prevent from that set skip_phys_port_name_get flag for ixgbe devlink
ports.

Reported-by: David Howells <dhowells@redhat.com>
Closes: https://lore.kernel.org/netdev/3452224.1745518016@warthog.procyon.org.uk/
Reported-by: David Kaplan <David.Kaplan@amd.com>
Closes: https://lore.kernel.org/netdev/LV3PR12MB92658474624CCF60220157199470A@LV3PR12MB9265.namprd12.prod.outlook.com/
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Fixes: a0285236ab93 ("ixgbe: add initial devlink support")
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.47.1


