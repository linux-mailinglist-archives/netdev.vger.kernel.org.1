Return-Path: <netdev+bounces-106448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C70191669C
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B6AB24281
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 11:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D018D154C18;
	Tue, 25 Jun 2024 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8+zYMHr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE3B153506;
	Tue, 25 Jun 2024 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316203; cv=none; b=BDwyLGOUnoVtxvCI9nTTTAOWMfJbgJGYtwT5nUxqmEBM3D7GJWlFrqf3vn0x4OXla+nrkeXh43YROYHc+40TX0bgZ/3dpfZMu+ryzWRe1PcS00faAzi+/7/va+A095l9kXQhyS/s/1qWMa6wsMrUaJSdpUZm25hY7NvyC5Grmh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316203; c=relaxed/simple;
	bh=Tt/Y2d/cs9qfsWV6LthbqZwca4UWolXmQoKccfKAGjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipYSSKeaKp2/uf+jmxc+GCjJXVso1e364lzejF6IAWPMyrg7LCez1iHGOWQpf/0Cl0l4yHDGzQKjC+sOxJW8OJQPIZ7PU5QwBcW62piQjn6EZkWv16iTLd0nx+S5r993gVWigOMcrzY//B3h4O3IWCoY3vhfUKTBzuqryh0pT5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8+zYMHr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719316203; x=1750852203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tt/Y2d/cs9qfsWV6LthbqZwca4UWolXmQoKccfKAGjw=;
  b=J8+zYMHrpZQM4viFeAOuc3fdrl7Zx5dh5SRTeqJB/AL1E6K5yK2WAonu
   oxdJHFArbVIDp0FchwiM4N8b8NNp2Yj//l0fOuCJz3kCw+LMvREcJ4Wv4
   N+imvp+ykXl7m2u2tSfX3Lb7GLXkxWyr0ja4f27NRw5fJTlsLykCdAwJ9
   8ang+F0GFXzak1WWljTe6n0AzdTIUx7jMdeLvHfjZ8ljIC2uneBT60Z5+
   H4XHAkpmbuH71Eq05ScHuX8RKiwgsogR6rzKWm0HyQBjd538urSzlFoJ5
   0q/Dri+m8vSY2TXhp7G6d3n0kEt4ApW1/UpL/UJ638MDuq4BGOFAXELr1
   w==;
X-CSE-ConnectionGUID: oU0uhnPAS/yf44mZlInsRg==
X-CSE-MsgGUID: 88fnYQR2SC2KHbmwwUH9Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="20104396"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="20104396"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 04:50:02 -0700
X-CSE-ConnectionGUID: rpunUw2MTFiBxbX1KmMFYQ==
X-CSE-MsgGUID: aYzjDNOmT4C92yHeGjEyrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="43724728"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa009.jf.intel.com with ESMTP; 25 Jun 2024 04:49:59 -0700
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
Subject: [PATCH net-next 2/5] netdev_features: remove unused __UNUSED_NETIF_F_1
Date: Tue, 25 Jun 2024 13:44:29 +0200
Message-ID: <20240625114432.1398320-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625114432.1398320-1-aleksander.lobakin@intel.com>
References: <20240625114432.1398320-1-aleksander.lobakin@intel.com>
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


