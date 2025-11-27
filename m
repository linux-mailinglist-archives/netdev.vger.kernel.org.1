Return-Path: <netdev+bounces-242289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DE9C8E634
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CE8C3507B3
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE762367D9;
	Thu, 27 Nov 2025 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gaVjUP00"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0153FBA7
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764249328; cv=none; b=iAtKt37//zbf8Pu5iBIekqCBzu28707i9Gufi1jnZlclTbgHN5LfYTX5gNpn71obYQSqFPKBzxRBy9x3LHVaBY2c/qGi1ZBA1lYhPLxMT8S5VEQoX/MTxVCpKuJuxOK7I34pXW/Z0KBJvtkqVjNkDc1VdA2RbqIaVLkBY9eMkx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764249328; c=relaxed/simple;
	bh=JeNVMxLNQksaOSVxvp7aogxutMh6uMS78QpCd3Tk+Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMu1cTPu3n4AcooKDh779Sd7lChy2TW3gSnFH/8mCCaDm4ZsBa0oBmILSiXs4Jv7rU7QxOyZQe7ROOkYA4373M7466KvLPrMmcZ0ydZimy0uvZ8uRooxuufJkLuuPUH6b5Wx/nuMj3piTusW14bCLAhgNDXWciL74OBiSAXMwKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gaVjUP00; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764249325; x=1795785325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JeNVMxLNQksaOSVxvp7aogxutMh6uMS78QpCd3Tk+Mk=;
  b=gaVjUP00r/DW9pPy2UWvsEIWNFP7hfhQyVeHTbD0OeQKIndfedt0vVGI
   no4JdL4QMQFS22eikXtn41pHK3ORQhOrLM+kWzGHnA2rXbvqnVcNTwPjv
   bt8GtJSbO8rif/dNLw5X0EiwpImGf/pMq6AIoQArMNil7lg7ftZCTAqDy
   CSq83Ra0M2A1Bl5mfdHTwvttEvAeoAXD2v622gjMkKid8W0X7yMABzJ2y
   dE2/Oy5shyLeSJJo5TJkjzpFN46hgO1lW1tUQ6rhqxgCGMB6CMeajVAF+
   FNW7uSnVSfWGp/BU4EjPEq4RfEL1JnFWC+xlNHv0d3pou+14ll2D37VsI
   Q==;
X-CSE-ConnectionGUID: kegVfRD3SFOADmNuBGGFWA==
X-CSE-MsgGUID: teauIk9ZQNm7wAhnSYkgZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="68888484"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="68888484"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 05:15:25 -0800
X-CSE-ConnectionGUID: GpHHB34wTEGSmSR+TaZcMg==
X-CSE-MsgGUID: Sfpw7QcdS0uWj2w7z7ZF0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="193675687"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 27 Nov 2025 05:15:23 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 45CD9A1; Thu, 27 Nov 2025 14:15:21 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>,
	Ian MacDonald <ian@netstatz.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH net-next 1/3] net: thunderbolt: Allow changing MAC address of the device
Date: Thu, 27 Nov 2025 14:15:19 +0100
Message-ID: <20251127131521.2580237-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251127131521.2580237-1-mika.westerberg@linux.intel.com>
References: <20251127131521.2580237-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAC address we use is based on a suggestion in the USB4 Inter-domain
spec but it is not really used in the USB4NET protocol. It is more
targeted for the upper layers of the network stack. There is no reason
why it should not be changed by the userspace for example if needed for
bonding.

Reported-by: Ian MacDonald <ian@netstatz.com>
Closes: https://lore.kernel.org/netdev/CAFJzfF9N4Hak23sc-zh0jMobbkjK7rg4odhic1DQ1cC+=MoQoA@mail.gmail.com/
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/thunderbolt/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index dcaa62377808..57b226afeb84 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -1261,6 +1261,7 @@ static const struct net_device_ops tbnet_netdev_ops = {
 	.ndo_open = tbnet_open,
 	.ndo_stop = tbnet_stop,
 	.ndo_start_xmit = tbnet_start_xmit,
+	.ndo_set_mac_address = eth_mac_addr,
 	.ndo_get_stats64 = tbnet_get_stats64,
 };
 
@@ -1281,6 +1282,9 @@ static void tbnet_generate_mac(struct net_device *dev)
 	hash = jhash2((u32 *)xd->local_uuid, 4, hash);
 	addr[5] = hash & 0xff;
 	eth_hw_addr_set(dev, addr);
+
+	/* Allow changing it if needed */
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 }
 
 static int tbnet_probe(struct tb_service *svc, const struct tb_service_id *id)
-- 
2.50.1


