Return-Path: <netdev+bounces-116442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B50FD94A667
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 12:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702A82841C7
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 10:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1886F1E288B;
	Wed,  7 Aug 2024 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ijsb0U2S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4C41E2860
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028124; cv=none; b=Xc1/NIsctVkvm/x0lwg20NjPv/JpRpwyRHXDybwS7ewYSts6m5ZCn5xoFDhMx54kMbsBrWm/OYtFqkZO/9SSCTK9uRYCxsDRm+eqETJYQRfTXlB4lepMT2uH9jgb82V0MHXhsoHXFwzTcsz/O6kPAqK2bvc9rRsyZS/Do7tjlAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028124; c=relaxed/simple;
	bh=tzexPoIfOlUtrPzVq0Y+xdSBYhn5+Dywu4gsjG+uR5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WDTXcAnUk+WMjHTKM/0LG0qw6kZgzJJ0z0iyZIAWrCu3oIfPzbhc+xzNwXnJMZss/f0x9Vrk8VxBR4BVMqWdNgSlDHphWNkFR8ht6FX2MkVvHg69BokacNRNlginqoRuF+3XMIqkYmivu02RSTEeyJMH8uadtymRXuAs5Xkguzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ijsb0U2S; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723028122; x=1754564122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tzexPoIfOlUtrPzVq0Y+xdSBYhn5+Dywu4gsjG+uR5A=;
  b=Ijsb0U2SZwslYXGuGLsXYWYNPcAfdHwnHHy2fPp4fw/AFjpeHI2OVyAD
   /oj3DMhVoL2ZBPJlYQymu7IFOaL+okwT0emmHqJmTYKHV11qVAPcPNmqp
   LKjLvtcd6oZl3rCoPZteGLcdYAUOFqaKcyl7aSlA8kM8a99S+w8tTNYGj
   NQB+4mzbXu8WoSRu005IrcbaTIiyql4TK7sAz4dhxWlGYkwMIAzn2lpHm
   znSRQhdWuOoR5FLisKUbH98wgv90RzcE6tBRxxVd8vul45jffuDkGdE/c
   HjpiRo7rSUCHN66ZoOlNpTwAmldk8T1QgLsqSFgGoxWdhOGxAtAbMr+Fm
   w==;
X-CSE-ConnectionGUID: KSSWOF8YRbeKtydcDbBnLA==
X-CSE-MsgGUID: 1NF1m3vlTXiSbqx0njPdnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31664396"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="31664396"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 03:55:21 -0700
X-CSE-ConnectionGUID: 5xGkPkfkS5CJhjyvpeZv7Q==
X-CSE-MsgGUID: 5ALGpwbMQCOiZHC5Be/jZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="87757285"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2024 03:55:19 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	luizcap@redhat.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-net 2/3] ice: fix ICE_LAST_OFFSET formula
Date: Wed,  7 Aug 2024 12:53:25 +0200
Message-Id: <20240807105326.86665-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240807105326.86665-1-maciej.fijalkowski@intel.com>
References: <20240807105326.86665-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For bigger PAGE_SIZE archs, ice driver works on 3k Rx buffers.
Therefore, ICE_LAST_OFFSET should take into account ICE_RXBUF_3072, not
ICE_RXBUF_2048.

Fixes: 7237f5b0dba4 ("ice: introduce legacy Rx flag")
Suggested-by: Luiz Capitulino <luizcap@redhat.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 50211188c1a7..4b690952bb40 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -842,7 +842,7 @@ ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf)
 		return false;
 #if (PAGE_SIZE >= 8192)
 #define ICE_LAST_OFFSET \
-	(SKB_WITH_OVERHEAD(PAGE_SIZE) - ICE_RXBUF_2048)
+	(SKB_WITH_OVERHEAD(PAGE_SIZE) - ICE_RXBUF_3072)
 	if (rx_buf->page_offset > ICE_LAST_OFFSET)
 		return false;
 #endif /* PAGE_SIZE >= 8192) */
-- 
2.34.1


