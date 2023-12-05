Return-Path: <netdev+bounces-54123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DBB806096
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C23E1F217CB
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A68692A8;
	Tue,  5 Dec 2023 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VP48O7FG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CD11A4
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 13:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701811184; x=1733347184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M3aNYRUQkpb4vtx8FhPs0rIk8J3vGX+5n01a55rmOhE=;
  b=VP48O7FGEQmR7HedvBeMLIwrOWLYgJdWxSw+vjSoQ2vlUqMELC5W/4QD
   HGLG99TypnA8UZNfvSSyisWXBmEtorcZZIn+Ect0bz6/4nzY4+770QVVH
   tN76t1Fjv2jn2zfS4CrI1FbXwBI8Bjh8hPvP2rddLuhaPm9o5FU+Z8wd+
   XTq4FBn66fY0EOxJBca21FLWTbU+9T3DVZrqwXcMADPy7XwB88e+J66IU
   Ah2CbqvaREEL6pRaFWZrKoGOw+kyEVoIjtCUS4f7VxAUFE6XydzsTYLxh
   Ls5lTxqS8jTMTbCiRpO2P+ZCvbcHCNjbpM1llOhgGgNqXkNY+NhoWnncv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="393693816"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="393693816"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:19:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="894510110"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="894510110"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 05 Dec 2023 13:19:26 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 4/4] iavf: validate tx_coalesce_usecs even if rx_coalesce_usecs is zero
Date: Tue,  5 Dec 2023 13:19:15 -0800
Message-ID: <20231205211918.2123019-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205211918.2123019-1-anthony.l.nguyen@intel.com>
References: <20231205211918.2123019-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

In __iavf_set_coalesce, the driver checks both ec->rx_coalesce_usecs and
ec->tx_coalesce_usecs for validity. It does this via a chain if if/else-if
blocks. If every single branch of the series of if statements exited, this
would be fine. However, the rx_coalesce_usecs is checked against zero to
print an informative message if use_adaptive_rx_coalesce is enabled. If
this check is true, it short circuits the entire chain of statements,
preventing validation of the tx_coalesce_usecs field.

Indeed, since commit e792779e6b63 ("iavf: Prevent changing static ITR
values if adaptive moderation is on") the iavf driver actually rejects any
change to the tx_coalesce_usecs or rx_coalesce_usecs when
use_adaptive_tx_coalesce or use_adaptive_rx_coalesce is enabled, making
this checking a bit redundant.

Fix this error by removing the unnecessary and redundant checks for
use_adaptive_rx_coalesce and use_adaptive_tx_coalesce. Since zero is a
valid value, and since the tx_coalesce_usecs and rx_coalesce_usecs fields
are already unsigned, remove the minimum value check. This allows assigning
an ITR value ranging from 0-8160 as described by the printed message.

Fixes: 65e87c0398f5 ("i40evf: support queue-specific settings for interrupt moderation")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 12 ++----------
 drivers/net/ethernet/intel/iavf/iavf_txrx.h    |  1 -
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 6f236d1a6444..19cbfe554689 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -827,18 +827,10 @@ static int __iavf_set_coalesce(struct net_device *netdev,
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	int i;
 
-	if (ec->rx_coalesce_usecs == 0) {
-		if (ec->use_adaptive_rx_coalesce)
-			netif_info(adapter, drv, netdev, "rx-usecs=0, need to disable adaptive-rx for a complete disable\n");
-	} else if ((ec->rx_coalesce_usecs < IAVF_MIN_ITR) ||
-		   (ec->rx_coalesce_usecs > IAVF_MAX_ITR)) {
+	if (ec->rx_coalesce_usecs > IAVF_MAX_ITR) {
 		netif_info(adapter, drv, netdev, "Invalid value, rx-usecs range is 0-8160\n");
 		return -EINVAL;
-	} else if (ec->tx_coalesce_usecs == 0) {
-		if (ec->use_adaptive_tx_coalesce)
-			netif_info(adapter, drv, netdev, "tx-usecs=0, need to disable adaptive-tx for a complete disable\n");
-	} else if ((ec->tx_coalesce_usecs < IAVF_MIN_ITR) ||
-		   (ec->tx_coalesce_usecs > IAVF_MAX_ITR)) {
+	} else if (ec->tx_coalesce_usecs > IAVF_MAX_ITR) {
 		netif_info(adapter, drv, netdev, "Invalid value, tx-usecs range is 0-8160\n");
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index 7e6ee32d19b6..10ba36602c0c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -15,7 +15,6 @@
  */
 #define IAVF_ITR_DYNAMIC	0x8000	/* use top bit as a flag */
 #define IAVF_ITR_MASK		0x1FFE	/* mask for ITR register value */
-#define IAVF_MIN_ITR		     2	/* reg uses 2 usec resolution */
 #define IAVF_ITR_100K		    10	/* all values below must be even */
 #define IAVF_ITR_50K		    20
 #define IAVF_ITR_20K		    50
-- 
2.41.0


