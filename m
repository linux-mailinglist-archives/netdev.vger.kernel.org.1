Return-Path: <netdev+bounces-32120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE44C792D40
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 20:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CA32812FD
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 18:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368B1DDC3;
	Tue,  5 Sep 2023 18:15:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9C7DDC2
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 18:15:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACF56E95
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 11:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693937708; x=1725473708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fdt13GRtXit9i8zPvNj5JLY8nf+XYqm3GzpVN95r1hg=;
  b=elHfI5idVUjKl02Zi1bwLz9/lsJ/Kqu9OQfYYIMhECDrVhRinV+oa1RT
   BnEKMwqbnU52KoXwYGeD0jYyo6WFfsIKWaBm5yNIxbOJuzg2J+Ibd/pyO
   9H+tUszdOj5e1rKAvxCE4CebXJgNTAcWEui+/31xE8m5oBXK4ef12IWnv
   TF3wRbD0TNDcAnBjhoG7IHBVkyQHzLIu6Y4WxGISIigXFBOKnkwpj9MW2
   xuh7DiZ4mvbCkv8yLvCIWsyv+zDrchj7pCjiG6RfCpK6FoU9rx8RV+SsA
   UsTVHQB1MtWnDHAdwcIPUVLKPg0eH4StwgdbeqVBr0jx4+ZMCRSXtwpJh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="356360179"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="356360179"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 11:14:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="741197747"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="741197747"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 05 Sep 2023 11:14:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Olga Zaborska <olga.zaborska@intel.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net 1/3] igc: Change IGC_MIN to allow set rx/tx value between 64 and 80
Date: Tue,  5 Sep 2023 11:07:06 -0700
Message-Id: <20230905180708.887924-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230905180708.887924-1-anthony.l.nguyen@intel.com>
References: <20230905180708.887924-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Olga Zaborska <olga.zaborska@intel.com>

Change the minimum value of RX/TX descriptors to 64 to enable setting the rx/tx
value between 64 and 80. All igc devices can use as low as 64 descriptors.
This change will unify igc with other drivers.
Based on commit 7b1be1987c1e ("e1000e: lower ring minimum size to 64")

Fixes: 0507ef8a0372 ("igc: Add transmit and receive fastpath and interrupt handlers")
Signed-off-by: Olga Zaborska <olga.zaborska@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 8ebe6999a528..f48f82d5e274 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -379,11 +379,11 @@ static inline u32 igc_rss_type(const union igc_adv_rx_desc *rx_desc)
 /* TX/RX descriptor defines */
 #define IGC_DEFAULT_TXD		256
 #define IGC_DEFAULT_TX_WORK	128
-#define IGC_MIN_TXD		80
+#define IGC_MIN_TXD		64
 #define IGC_MAX_TXD		4096
 
 #define IGC_DEFAULT_RXD		256
-#define IGC_MIN_RXD		80
+#define IGC_MIN_RXD		64
 #define IGC_MAX_RXD		4096
 
 /* Supported Rx Buffer Sizes */
-- 
2.38.1


