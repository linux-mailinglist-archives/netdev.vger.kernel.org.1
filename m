Return-Path: <netdev+bounces-116919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA9194C169
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A083D1F2B98B
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BF8192B7E;
	Thu,  8 Aug 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJxS3d8O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F0F192B69;
	Thu,  8 Aug 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130938; cv=none; b=alperNG+tRkYY4pgs94/DOgI7lvvCMfV9VrbFP8PxCECdYqf9piFPou3cCJ8FkgkCzpGRkGRtNCdcuRY3Cn1TyVMMdTUOECDQX//NaBYSuOh57zb1pweDIfxvEfInQ888muLKGZIQjqY863Oef2MiBMt/4cgL6IoPiA5h45jVss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130938; c=relaxed/simple;
	bh=1ByWN//vxwzQp1zeAY4VDNzEuKxwPun8DERkhqw2wZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGShGCW271GPbf99xakyjsTuxpKBQmjSCImlGw+xlKKj5tk42wdavFQ1eTmKoAs4uH/tlUbloLWn8gBL5AUc79RCzRGsp4LHu7lZUCigl22AiBs8QjtW0tMe6IP95V5ed0Z0mzw65IuqwwJiHIm1gLQ2cgAYDutwFdyLcO3Q0Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJxS3d8O; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723130937; x=1754666937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ByWN//vxwzQp1zeAY4VDNzEuKxwPun8DERkhqw2wZw=;
  b=KJxS3d8OpltMu8pp6T0wCURCXCoSMqV3I8ox3RjyIJjJzKqmnqMHfn0e
   D8qpZSFmuKBmlbYKwa4teuujN4QvQKaWrkUkFMVOll7/vxndCY60y3UXY
   M3k61uyNg9XZg2fAN8jN9bp6WzEFUWHTLC8xYfjZoYGvX0txDCVrG+pVT
   CAzbKtgieb9OE6SIkXCe9zRA9c5aMUr+Y4acZoXYVlY9pSPoYcaZOt9af
   t6QMO5QHUje7nZ95KN9xThY/OywKRRhROwNldNJ1JO/rGX9f+jEpV50Cd
   mz9/7HdF7ibZMshS2efthKRK8qlOY2SOlo9ut1HwUcf2wwojzBr7pG1dU
   Q==;
X-CSE-ConnectionGUID: +ZAaWVqTRieGtbcj3ycdlw==
X-CSE-MsgGUID: moUrHLseTnGrH0wA+IeCXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25026019"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="25026019"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 08:28:57 -0700
X-CSE-ConnectionGUID: ZTvO872OQICTSM3RldUgWg==
X-CSE-MsgGUID: /9/VbftkQseQ67sOnqDVrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="57162827"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa009.jf.intel.com with ESMTP; 08 Aug 2024 08:28:53 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 6/6] net: netdev_features: remove NETIF_F_ALL_FCOE
Date: Thu,  8 Aug 2024 17:27:57 +0200
Message-ID: <20240808152757.2016725-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240808152757.2016725-1-aleksander.lobakin@intel.com>
References: <20240808152757.2016725-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NETIF_F_ALL_FCOE is used only in vlan_dev.c, 2 times. Now that it's only
2 bits, open-code it and remove the definition from netdev_features.h.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/netdev_features.h | 2 --
 net/8021q/vlan_dev.c            | 5 +++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 1e9c4da181af..e41cd8af2a72 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -205,8 +205,6 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 #define NETIF_F_ALL_TSO 	(NETIF_F_TSO | NETIF_F_TSO6 | \
 				 NETIF_F_TSO_ECN | NETIF_F_TSO_MANGLEID)
 
-#define NETIF_F_ALL_FCOE	(NETIF_F_FCOE_CRC | NETIF_F_FSO)
-
 /* List of features with software fallbacks. */
 #define NETIF_F_GSO_SOFTWARE	(NETIF_F_ALL_TSO | NETIF_F_GSO_SCTP |	     \
 				 NETIF_F_GSO_UDP_L4 | NETIF_F_GSO_FRAGLIST)
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 09b46b057ab2..458040e8a0e0 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -564,7 +564,7 @@ static int vlan_dev_init(struct net_device *dev)
 			   NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE |
 			   NETIF_F_GSO_ENCAP_ALL |
 			   NETIF_F_HIGHDMA | NETIF_F_SCTP_CRC |
-			   NETIF_F_ALL_FCOE;
+			   NETIF_F_FCOE_CRC | NETIF_F_FSO;
 
 	if (real_dev->vlan_features & NETIF_F_HW_MACSEC)
 		dev->hw_features |= NETIF_F_HW_MACSEC;
@@ -576,7 +576,8 @@ static int vlan_dev_init(struct net_device *dev)
 	if (dev->features & NETIF_F_VLAN_FEATURES)
 		netdev_warn(real_dev, "VLAN features are set incorrectly.  Q-in-Q configurations may not work correctly.\n");
 
-	dev->vlan_features = real_dev->vlan_features & ~NETIF_F_ALL_FCOE;
+	dev->vlan_features = real_dev->vlan_features &
+			     ~(NETIF_F_FCOE_CRC | NETIF_F_FSO);
 	dev->hw_enc_features = vlan_tnl_features(real_dev);
 	dev->mpls_features = real_dev->mpls_features;
 
-- 
2.45.2


