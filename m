Return-Path: <netdev+bounces-47800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9A87EB677
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D061C20B6F
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF1B33CF1;
	Tue, 14 Nov 2023 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKRFhAUo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060AA26AC8;
	Tue, 14 Nov 2023 18:37:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10AF121;
	Tue, 14 Nov 2023 10:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699987020; x=1731523020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vwSrgks23E9tdXTtDZ45sDhv3Z4KkMvAYvLOigetJuY=;
  b=nKRFhAUo60EN+odcIZ1l1JJ4hdo9m5lg3jZ/RIJ/grmZQzpAgFvZVeD6
   m5bDbHzedu81IMpBVVqOoJ2s1Eh+AH7gP96ElOXSNNnnO6+SdutVmPw4p
   RSKTHOgcm36G0bnd4YKUyiLhMtmzKmmDoK2UXqBRTUiUT1TEUKgKRM/Kq
   P7YWYSVRAGrMPNMPte7kkmHiHlC+9czvkg8OuDtEngZk2Hbj2LuQMBHj3
   4rd9DCJpskxvvrTM0+5LeUqgYcI/lxB5gurVVMQOUmfhVRfIHlwor4SGb
   tRWKOliElJtM4vZR0PkkinkgGbm2sww6GGIds6l5ShIbpkx4PhZ/L13E1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="370918136"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="370918136"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:36:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741174191"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741174191"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2023 10:36:59 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	richardcochran@gmail.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net-next 1/2] igc: Simplify setting flags in the TX data descriptor
Date: Tue, 14 Nov 2023 10:36:37 -0800
Message-ID: <20231114183640.1303163-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114183640.1303163-1-anthony.l.nguyen@intel.com>
References: <20231114183640.1303163-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

We can re-use the IGC_SET_FLAG() macro to simplify setting some values
in the TX data descriptor. With the macro it's easier to get the
meaning of the operations.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e9bb403bbacf..7059710154eb 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1299,14 +1299,12 @@ static void igc_tx_olinfo_status(struct igc_ring *tx_ring,
 	u32 olinfo_status = paylen << IGC_ADVTXD_PAYLEN_SHIFT;
 
 	/* insert L4 checksum */
-	olinfo_status |= (tx_flags & IGC_TX_FLAGS_CSUM) *
-			  ((IGC_TXD_POPTS_TXSM << 8) /
-			  IGC_TX_FLAGS_CSUM);
+	olinfo_status |= IGC_SET_FLAG(tx_flags, IGC_TX_FLAGS_CSUM,
+				      (IGC_TXD_POPTS_TXSM << 8));
 
 	/* insert IPv4 checksum */
-	olinfo_status |= (tx_flags & IGC_TX_FLAGS_IPV4) *
-			  (((IGC_TXD_POPTS_IXSM << 8)) /
-			  IGC_TX_FLAGS_IPV4);
+	olinfo_status |= IGC_SET_FLAG(tx_flags, IGC_TX_FLAGS_IPV4,
+				      (IGC_TXD_POPTS_IXSM << 8));
 
 	tx_desc->read.olinfo_status = cpu_to_le32(olinfo_status);
 }
-- 
2.41.0


