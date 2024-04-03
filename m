Return-Path: <netdev+bounces-84616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE01A8979B3
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCA31C217E8
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8B2156226;
	Wed,  3 Apr 2024 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9W9CZjG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6992155A25
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175581; cv=none; b=Aj8jjlNPYNFm2X5mav1Ep89SFEoT8hGzatWwisDOxmncXmJAaeZYv9Z/zugS77x3S6AbE/UoTW7bC0VIfteBQYD8EiNtms1P3mi86dJvikGVwaeZe3g5wesQ4jI6cmVJT+/hCF9ygU9RD5TmO5JrlRu7/zQFWrwxDteKjNKPEcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175581; c=relaxed/simple;
	bh=hegHlUhBasKUMZObKcLkJqe/zOi+DJrgrHKeq2FG/SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFZIALNTSqi5TwhdpucxCj+UJymtKjCRnWFH4Jb3UcDZmgMT3n2G6/YzbnCM3Wh3FbRYZorYZz1FxTVnuzdWev7fiaNZOgexe+6bkmL+UFdZZshsKOE8FKRDWBoY3tGEO4D2pbylf8UrtCu2Kd6H7ihKvstZmoho0ks+WxIk2xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9W9CZjG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712175580; x=1743711580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hegHlUhBasKUMZObKcLkJqe/zOi+DJrgrHKeq2FG/SE=;
  b=R9W9CZjGoCVTwKyuPUGnILzNT+M+5ZcXIGffX963oVZ+Vm3mKhNug/C1
   R4jxFo4OGxZAvKV8KrO3YTufzBH/LxCixNbhrcote+aRUQ9WhUisWI2yZ
   7jbzEpc5Virrl0rl2rzPlpskKKhc891p1edhNIGmNN68rBVrCsbvDAW0i
   O485MuFiSy5Bs+DIT42wIyZlGvLP2mUsLgSzDLTU+d28+ZmfeAu2wxcH9
   4UpKVXsye04GBYjfM9TKPQCIiib4egotyF9esP5z4+Vz/uegxuXBfJRkY
   SQk8wZWw5hzCLuhlwcuGZt6CeOgIu8kZWCfHbowj8lSaeg7y446SvTZfa
   A==;
X-CSE-ConnectionGUID: pRQ3Zx2ISum1dq2IJByOaw==
X-CSE-MsgGUID: bumTY+8pQjGX1aEKsnb6/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18165815"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18165815"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 13:19:38 -0700
X-CSE-ConnectionGUID: S4QR8hmARO2slCFPSocE9w==
X-CSE-MsgGUID: I80dzmceSG+G87y0fIuAjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18662698"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 03 Apr 2024 13:19:37 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Joshua Hay <joshua.a.hay@intel.com>,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	Balazs Nemeth <bnemeth@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Salvatore Daniele <sdaniele@redhat.com>,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net 3/3] idpf: fix kernel panic on unknown packet types
Date: Wed,  3 Apr 2024 13:19:28 -0700
Message-ID: <20240403201929.1945116-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240403201929.1945116-1-anthony.l.nguyen@intel.com>
References: <20240403201929.1945116-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

In the very rare case where a packet type is unknown to the driver,
idpf_rx_process_skb_fields would return early without calling
eth_type_trans to set the skb protocol / the network layer handler.
This is especially problematic if tcpdump is running when such a
packet is received, i.e. it would cause a kernel panic.

Instead, call eth_type_trans for every single packet, even when
the packet type is unknown.

Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
Reported-by: Balazs Nemeth <bnemeth@redhat.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Salvatore Daniele <sdaniele@redhat.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 6dd7a66bb897..f5bc4a278074 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2941,6 +2941,8 @@ static int idpf_rx_process_skb_fields(struct idpf_queue *rxq,
 	rx_ptype = le16_get_bits(rx_desc->ptype_err_fflags0,
 				 VIRTCHNL2_RX_FLEX_DESC_ADV_PTYPE_M);
 
+	skb->protocol = eth_type_trans(skb, rxq->vport->netdev);
+
 	decoded = rxq->vport->rx_ptype_lkup[rx_ptype];
 	/* If we don't know the ptype we can't do anything else with it. Just
 	 * pass it up the stack as-is.
@@ -2951,8 +2953,6 @@ static int idpf_rx_process_skb_fields(struct idpf_queue *rxq,
 	/* process RSS/hash */
 	idpf_rx_hash(rxq, skb, rx_desc, &decoded);
 
-	skb->protocol = eth_type_trans(skb, rxq->vport->netdev);
-
 	if (le16_get_bits(rx_desc->hdrlen_flags,
 			  VIRTCHNL2_RX_FLEX_DESC_ADV_RSC_M))
 		return idpf_rx_rsc(rxq, skb, rx_desc, &decoded);
-- 
2.41.0


