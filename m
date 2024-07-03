Return-Path: <netdev+bounces-108933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D1892643F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195B51F23EB3
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1331A181316;
	Wed,  3 Jul 2024 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHskP0IU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F75C17F51E;
	Wed,  3 Jul 2024 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019099; cv=none; b=dmL8O3hfRpzxDGuiu5T+a2yjy6zkK2kuqvvh8fXErTOQz4i8CktCDmENQGuP9whzL0hU8T5ubMpIzefTv9tkTBiy3NTVRKfroPSjMcysWmPITAp/0kMJIRIgLq03+RvggVmeIIFfwqAE2XJ2FSvv8IrfQ7mnSZi/NIWNqDpr4hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019099; c=relaxed/simple;
	bh=Tt/Y2d/cs9qfsWV6LthbqZwca4UWolXmQoKccfKAGjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mf9xfhfLnmU/xq9GE/CxzC64aHGTLqcmqIgDUwZfhn9ac43JKmryaw1xRyFOxwUpPnh7SNKLoLiDst42OJXAc853iqC7iSIQGBopnJ8poW5X5KcNhZFln8TTqAAx7DFceVZTm8H0OVg4PGMSThhjqjf4ymynOE3XqQpWaS+nLWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHskP0IU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720019097; x=1751555097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tt/Y2d/cs9qfsWV6LthbqZwca4UWolXmQoKccfKAGjw=;
  b=bHskP0IUBNx3eL78EanQiwD0ISLrUG/CQICqvN/weDPcDcQt4TK+HpTQ
   y6ktg4/9g3oxljoT5bK+v9j2rQ36Tr4m+lB39ui5+uKEqwPj1g5QB+s13
   /3pPryv0lDSCQYvM/Ls7oApndFBSIYApO/feoW3DHfSkZiiJpLIcq6NOV
   mwEljm+nRw7VX+FYECwYggzEMfhWSGNhAVcvToKhZKb1OGEBaPNdYtcJv
   MhlXwGpzwxMhEVO+OD08VqN3Ewkdm7x+ZvqTNI/pXvxoWd4KVUpvXc0TU
   yhZ6FOuqVSZICePLJtZFAKlOBTJky6stsk9KbmvOmFfvti4AdzxHYXGvB
   Q==;
X-CSE-ConnectionGUID: wVZIPriTS06BJE1fFk3RvQ==
X-CSE-MsgGUID: Xmf98d0LRaCsy40mUWmv7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17079146"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17079146"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 08:04:55 -0700
X-CSE-ConnectionGUID: qU1qlJrDQxaHoVTiI8gIYw==
X-CSE-MsgGUID: MqK227XERdW6ozSSh7a8Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="77016648"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 03 Jul 2024 08:04:52 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew@lunn.ch>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/5] netdev_features: remove unused __UNUSED_NETIF_F_1
Date: Wed,  3 Jul 2024 17:03:39 +0200
Message-ID: <20240703150342.1435976-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703150342.1435976-1-aleksander.lobakin@intel.com>
References: <20240703150342.1435976-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NETIF_F_NO_CSUM was removed in 3.2-rc2 by commit 34324dc2bf27
("net: remove NETIF_F_NO_CSUM feature bit") and became
__UNUSED_NETIF_F_1. It's not used anywhere in the code.
Remove this bit waste.

It wasn't needed to rename the flag instead of removing it as
netdev features are not uAPI/ABI. Ethtool passes their names
and values separately with no fixed positions and the userspace
Ethtool code doesn't have any hardcoded feature names/bits, so
that new Ethtool will work on older kernels and vice versa.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/netdev_features.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 7c2d77d75a88..44c428d62db4 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -14,7 +14,6 @@ typedef u64 netdev_features_t;
 enum {
 	NETIF_F_SG_BIT,			/* Scatter/gather IO. */
 	NETIF_F_IP_CSUM_BIT,		/* Can checksum TCP/UDP over IPv4. */
-	__UNUSED_NETIF_F_1,
 	NETIF_F_HW_CSUM_BIT,		/* Can checksum all the packets. */
 	NETIF_F_IPV6_CSUM_BIT,		/* Can checksum TCP/UDP over IPV6 */
 	NETIF_F_HIGHDMA_BIT,		/* Can DMA to high memory. */
-- 
2.45.2


