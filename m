Return-Path: <netdev+bounces-242288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6C1C8E631
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D05934E7D49
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104662AD04;
	Thu, 27 Nov 2025 13:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S6vqAOtA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2D157480
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764249327; cv=none; b=QSVG3I/VK+FCGlktVlfV+rIU5WPUDstNacQ4mFAg8JMjydLGY3BjJNyVPxu6sE0zQFQItlNlSCAezG0RdgNH27G3t+ppavT/pk84rse7ZlAOC75ZQnuldGsYx804WwNAFyshTco/nIF9H1vJrWvkRyN9a0AwAqmlvWmv3Byot2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764249327; c=relaxed/simple;
	bh=7jM1UtncRIoXqwjpezsk+5Fa42ngJjTjGo1vsyQ0C/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZHpjDdFyzLbmHD3rYzf9q+DSjjDpmJKdXXA2ua0pj+Zd6wIVoGBfz1CxE3NacWJprvLB0x/y7yGGbsqhrdiNQirjHtWtxPqdBDPS1YwPrfM8BfGB0DdMXI2dGH/ZlA2iSnzuWocNLYoElZTWix9vRiaPPGeAuoDTwqbj2chEY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S6vqAOtA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764249325; x=1795785325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7jM1UtncRIoXqwjpezsk+5Fa42ngJjTjGo1vsyQ0C/o=;
  b=S6vqAOtAIRgJeN3gIfRXk/kDAlJbkXzE+JsGLxQsNbWVZKgUzEgeJcKR
   Z+V3t0qWoSXlmsnjZdvJUScO2IOlo00AGUzqrB3OnTewymdtYj/qqh04O
   Z1oghPmwzydrVUCMUuIrD/f9NK5WbmNLOxXB5bvsLRGc1psEBaWQD6mpV
   TRzEoc1vBnP5wxvd6K2qJNrdku4AZ54nRTVJgto4iI/+159x5fwXsO2JF
   ck8KEaCRR1AEtysm4B///M5VjxPBRU2Y2O/NJiAuXrLBtbTUeT6s/u1Cs
   zcdxRSiZNRj0jtBldYqqxTrrlJJ25kX8jhe3wOEd27nHRm339nonTwx0q
   A==;
X-CSE-ConnectionGUID: xWTwLwqFQZyFbv3fcUCWJw==
X-CSE-MsgGUID: M+16KgrkQW2hio8OhGNK1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="70157515"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="70157515"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 05:15:24 -0800
X-CSE-ConnectionGUID: B6gBEf/uQUWn1i7pyGO6/Q==
X-CSE-MsgGUID: YrFjJkF0ScytUHzQB7QBcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="192892759"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 27 Nov 2025 05:15:22 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 49148A2; Thu, 27 Nov 2025 14:15:21 +0100 (CET)
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
Subject: [PATCH net-next 2/3] net: thunderbolt: Allow changing MTU of the device
Date: Thu, 27 Nov 2025 14:15:20 +0100
Message-ID: <20251127131521.2580237-3-mika.westerberg@linux.intel.com>
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

In some cases it is useful to be able to use different MTU than the
default one. Especially when dealing against non-Linux networking stack.
For this reason add possibility to change the MTU of the device.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/thunderbolt/main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 57b226afeb84..20bac55a3e20 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -1257,12 +1257,23 @@ static void tbnet_get_stats64(struct net_device *dev,
 	stats->rx_missed_errors = net->stats.rx_missed_errors;
 }
 
+static int tbnet_change_mtu(struct net_device *dev, int new_mtu)
+{
+	/* Keep the MTU within supported range */
+	if (new_mtu < 68 || new_mtu > (TBNET_MAX_MTU - ETH_HLEN))
+		return -EINVAL;
+
+	dev->mtu = new_mtu;
+	return 0;
+}
+
 static const struct net_device_ops tbnet_netdev_ops = {
 	.ndo_open = tbnet_open,
 	.ndo_stop = tbnet_stop,
 	.ndo_start_xmit = tbnet_start_xmit,
 	.ndo_set_mac_address = eth_mac_addr,
 	.ndo_get_stats64 = tbnet_get_stats64,
+	.ndo_change_mtu	= tbnet_change_mtu,
 };
 
 static void tbnet_generate_mac(struct net_device *dev)
-- 
2.50.1


