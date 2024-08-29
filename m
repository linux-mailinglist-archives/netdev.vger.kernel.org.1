Return-Path: <netdev+bounces-123255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 292B29644BC
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA1FBB276B1
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836871B373F;
	Thu, 29 Aug 2024 12:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HuVBptxK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB01B372E;
	Thu, 29 Aug 2024 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934873; cv=none; b=cOQKIu+RYkWoQ2H4X95oPWa/sNAD/yXCOpulRJc1P8W7PJ3iN3lOEjxxW2D8yTlsIkpT/6jHzdIxNUjrtIvro0625YXrRw0IRmjwo0MUPPQlZvPRSnBGj6PpLk3wFxqombVeh0ZqYCOiJNOy7ttQVrcTnyqc8BPKm5HAFYc5AQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934873; c=relaxed/simple;
	bh=DZB7qu5vEbhhjIgEPoBTWvmR4XZ7sUV9Q0Y4Fzdk7mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYKxxaByI15SDHXhGurageJzX6lRyeoxkCHvpCmixYj1rbKESEFSiZ+w5CB8kYN8sVGbrgUe9J9dphUjVA/x4cLqknGdFJR3ZLGvb+CUxU7PLJDxBXxd3YcJDevMWoHurG2tLZg5tFREtKsVx1Hm5qrJUHsmjzkMg/hSQH886Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HuVBptxK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724934872; x=1756470872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DZB7qu5vEbhhjIgEPoBTWvmR4XZ7sUV9Q0Y4Fzdk7mM=;
  b=HuVBptxKX8mExIGk1nBdU3JrDWm7wZjiscdhiQsTEarmC1W5l4Wn28hN
   eSlQUD7ULC6+SwJXqdtxTOX2N2Fh3xxeoew85YYpKXryFvszPq4eklgIM
   IuzTPUcjAFEESCmRK4kvnikeTbM7y7KmuSV2frTedwblTv+Pob/BHuH1F
   NSPk0rNJ3E8rbLZbfWYTcdeqhkU20OyBFMw80iCrMKfoUe5x8lLtSjaO+
   +Vh8QTAa4/uCN+Z23/2VT8ymIBpFVayPiFyzmzFlXIh85U365gPcFR7SW
   79ErN6tyUP3uVyiGxS0UeafZFuCz15KRjRbkXzDHpmqlAm1QeWSuVH1Z9
   g==;
X-CSE-ConnectionGUID: oYiugDbXRaeHJwhCLGoNJg==
X-CSE-MsgGUID: obmswvnuSxuVPqm2qaylsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="46038230"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="46038230"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:34:32 -0700
X-CSE-ConnectionGUID: hAX0QOYZTZejBkNl5KPLEg==
X-CSE-MsgGUID: NAeMWS/2S+WpkI7vWtw85Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63188515"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa006.fm.intel.com with ESMTP; 29 Aug 2024 05:34:29 -0700
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
Subject: [PATCH net-next v5 5/5] netdev_features: remove NETIF_F_ALL_FCOE
Date: Thu, 29 Aug 2024 14:33:40 +0200
Message-ID: <20240829123340.789395-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829123340.789395-1-aleksander.lobakin@intel.com>
References: <20240829123340.789395-1-aleksander.lobakin@intel.com>
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
index 37af2c6e7caf..66e7d26b70a4 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -209,8 +209,6 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
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
2.46.0


