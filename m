Return-Path: <netdev+bounces-42033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733757CCBAC
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 21:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8A61C20CC6
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 19:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5902EB03;
	Tue, 17 Oct 2023 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4gzw87x"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D862DF92;
	Tue, 17 Oct 2023 19:04:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62943F5;
	Tue, 17 Oct 2023 12:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697569471; x=1729105471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d7FDOP7CsaCZrBn6l9ubPcTsZCF3dmd9cR8EUzjjCc8=;
  b=D4gzw87xx0TqhsitHjxYs9UbvM0cYfhbd/6fsgyqNzXILBmc7kEFvPMX
   LcwyM8/3RfE8/BTh1Xx4LptrIvApa6XuM72OMkXRY6rc9XbcmzrdLK2sr
   yFyfaI478jHhTFAwWXjF2gkyyUvu46OMHm1sHgwknH5Nv0K0NU1qM4hO4
   AGlZXMmzgYxZxyKItjRJwKxOFQD1QY819hV+5GeWWRKLTTNzlxI/332cf
   /hry4qjSXKV42P/aee9x5KJr7ENF3Yt4K470/QAB/XamSZ/aNTUi/2ATU
   MBMmG5alqIre4zApuc25F8hzHUGd+AiCRPOHiT5MU0ApQ6Xo5l9UeW+5u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384739821"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="384739821"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 12:04:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="822108794"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="822108794"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 12:04:20 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 9/9] igc: replace deprecated strncpy with strscpy
Date: Tue, 17 Oct 2023 12:04:11 -0700
Message-ID: <20231017190411.2199743-10-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017190411.2199743-1-jacob.e.keller@intel.com>
References: <20231017190411.2199743-1-jacob.e.keller@intel.com>
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

From: Justin Stitt <justinstitt@google.com>

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect netdev->name to be NUL-terminated based on its use with format
strings:
|       if (q_vector->rx.ring && q_vector->tx.ring)
|               sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,

Furthermore, we do not need NUL-padding as netdev is already
zero-allocated:
|       netdev = alloc_etherdev_mq(sizeof(struct igc_adapter),
|                                  IGC_MAX_TX_QUEUES);
...
alloc_etherdev() -> alloc_etherdev_mq() -> alloc_etherdev_mqs() ->
alloc_netdev_mqs() ...
|       p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 98de34d0ce07..e9bb403bbacf 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6935,7 +6935,7 @@ static int igc_probe(struct pci_dev *pdev,
 	 */
 	igc_get_hw_control(adapter);
 
-	strncpy(netdev->name, "eth%d", IFNAMSIZ);
+	strscpy(netdev->name, "eth%d", sizeof(netdev->name));
 	err = register_netdev(netdev);
 	if (err)
 		goto err_register;
-- 
2.41.0


