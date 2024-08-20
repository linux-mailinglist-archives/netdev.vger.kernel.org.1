Return-Path: <netdev+bounces-120341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4F1959006
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 23:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE321C21F18
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 21:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828191C68B2;
	Tue, 20 Aug 2024 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuWgsOZy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067901C57B2
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724190990; cv=none; b=e8ejMokZFUJgP46ro8M4VZCM8VyguIwSAwYfCWIY3NGwUD7tt7daitPeQLJNw7CxQphHpXopdsoGX1l92HQI1HVbpOAFySxxnCntS8qnMJuFFyZPy5T8tff9nJGwiKgbvBgvyMtDS6QuTM6tdj81xB4Pvw/OfxVLKflf2XIKNN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724190990; c=relaxed/simple;
	bh=wsKf9eE9kJGkLbzW/JeheBQsVn5U8J67ATi0Kasp2kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDWse1UjSDFGL7OV8uVZAWtnZXq/CMPgCB9sETW8Ptn8jQ1xYJgoY+fEPN9neUA3IJQDafK7jBz0NfQFEprr6Pzml7Lxd9WQtadxHO/Gd5hFmRIuYe6zjqpcK9bELQR5ou7XY4OytulYz4V2x5G/yxMHHQxotisu+q9ID8SMbJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuWgsOZy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724190989; x=1755726989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wsKf9eE9kJGkLbzW/JeheBQsVn5U8J67ATi0Kasp2kA=;
  b=iuWgsOZyIDPCIymQx7iuvyhkMk72K1TDFCaIcZ+LtOhs2BDGK8uLYSeJ
   2oota+hivfY9vecruFBhnrBsNt5B92jvD+NKs10MYdz7ueRHyJCgZ/cRN
   QFp8gzoApaoL2Re44UBiegq2txvsILIapu5MP/H8ofMdnTwErmAGZZUkM
   GK0N7AqINJ09CMgVCQSl1ARhXwBikMxJc0qnrOGM8YDKbK5uThJfPZPxD
   cTtCH1bu9ahXVAmKjBJh296yGydIiRNkwHj3dpE5zu1Y16D8j2cmKH1xs
   ZnBsdkbcP7/XGcW73C3oeVDnooyWeooUYoO7dDX7Fjj/S3gyLdzkbALWM
   A==;
X-CSE-ConnectionGUID: aaBI0hGaQqC4Aaa/hwznuQ==
X-CSE-MsgGUID: N+3vvny6SkCdxwL03aJDsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="39979352"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="39979352"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 14:56:27 -0700
X-CSE-ConnectionGUID: hiFpdIwLRqmJdxOmOsKJKg==
X-CSE-MsgGUID: vOcB/TNqRJW+AUD6MTjDTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="65833195"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 20 Aug 2024 14:56:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	Luiz Capitulino <luizcap@redhat.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net 2/4] ice: fix ICE_LAST_OFFSET formula
Date: Tue, 20 Aug 2024 14:56:16 -0700
Message-ID: <20240820215620.1245310-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240820215620.1245310-1-anthony.l.nguyen@intel.com>
References: <20240820215620.1245310-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

For bigger PAGE_SIZE archs, ice driver works on 3k Rx buffers.
Therefore, ICE_LAST_OFFSET should take into account ICE_RXBUF_3072, not
ICE_RXBUF_2048.

Fixes: 7237f5b0dba4 ("ice: introduce legacy Rx flag")
Suggested-by: Luiz Capitulino <luizcap@redhat.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.42.0


