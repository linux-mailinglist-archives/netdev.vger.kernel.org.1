Return-Path: <netdev+bounces-116915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B002E94C15F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB5A1F2B987
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F81191F7C;
	Thu,  8 Aug 2024 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ng2j59qK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5735B191F65;
	Thu,  8 Aug 2024 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130923; cv=none; b=KP2cu1n+hxZhEd6OlGLDmMZ+LeJQZPhEdVWiW0Z+xEp44VzLeI6O3HLYb4xdkowmnl0gMWPm+ep2zgj6o5buraeIyNaHhoFxAwya1DqWAHbMmT7GnpOkpFBE52ohKV7t46l9RnLPjUIb6JE0S8rX0kKV0HauPxXyYg4qxy702bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130923; c=relaxed/simple;
	bh=Tt/Y2d/cs9qfsWV6LthbqZwca4UWolXmQoKccfKAGjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOwrpp/nNRpmwh1C1MO9FBZSOu1Z4abX9/v4D1RpmInGuKcPQ9Jzmt35NO6ksulrq7yQrXK0PW6RWw3SMKlcBqODB/cVAV0PrdcaKfSzW3YX7V8+eaaVojlayAfDTB+TJfjueu1Tc5S7E3+yU9P7w1nf39HUC0jtD0esxJT0Zt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ng2j59qK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723130922; x=1754666922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tt/Y2d/cs9qfsWV6LthbqZwca4UWolXmQoKccfKAGjw=;
  b=Ng2j59qKZ5Uk1OF1oqYug5XLXJNvTDZ4CCunGafB1bh2ouaTxQRVkJ3b
   F7LC5qUFk97p0t0lwfIY70vLAUKmKMjNZUM8L8pMjKmZuVHeoioLuFRMS
   WlxlNp7woWUXUocoR0WGSk62lHLNqH0AJ+MAryUMJOUiXYssQacuMbkEj
   ubETuXj3T8IIw3LTtXkSJdaGKDm7sBCY4bDWru02jTc/aZ+8Y4WccYqOi
   tLgommqEDgTE9VWwXlcZt1lir3yNVqpkD+1r8YfLu2rONWURimrSRZpbl
   H3u6VT7gSsaD8GwHdt4snhPrXTY0000K7Rvq/4MERJQE5JHKQ2mozPm0Q
   g==;
X-CSE-ConnectionGUID: O/eQ2bA1RqeHm0k1CY7s2g==
X-CSE-MsgGUID: bPfsytGLR86slkRq4E3Btw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25025948"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="25025948"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 08:28:42 -0700
X-CSE-ConnectionGUID: LnCAqhfBQI2cnf5hpdVL9Q==
X-CSE-MsgGUID: KHN1F0pwSpO7gbHYEaFWgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="57162772"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa009.jf.intel.com with ESMTP; 08 Aug 2024 08:28:40 -0700
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
Subject: [PATCH net-next v3 2/6] netdev_features: remove unused __UNUSED_NETIF_F_1
Date: Thu,  8 Aug 2024 17:27:53 +0200
Message-ID: <20240808152757.2016725-3-aleksander.lobakin@intel.com>
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


