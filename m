Return-Path: <netdev+bounces-32989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF8479C1FA
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 03:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8901C281046
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 01:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02C01FC9;
	Tue, 12 Sep 2023 01:50:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35111FC5
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 01:50:02 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53897AED3;
	Mon, 11 Sep 2023 18:49:45 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,244,1688396400"; 
   d="scan'208";a="175750581"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Sep 2023 10:49:44 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 56B2841065DE;
	Tue, 12 Sep 2023 10:49:44 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH net 1/2] net: renesas: rswitch: Fix unmasking irq condition
Date: Tue, 12 Sep 2023 10:49:35 +0900
Message-Id: <20230912014936.3175430-2-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912014936.3175430-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230912014936.3175430-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix unmasking irq condition by using napi_complete_done(). Otherwise,
redundant interrupts happen.

Fixes: 3590918b5d07 ("net: ethernet: renesas: Add support for "Ethernet Switch"")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 6083b1c8e4fb..26c8807d7dea 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -816,10 +816,10 @@ static int rswitch_poll(struct napi_struct *napi, int budget)
 
 	netif_wake_subqueue(ndev, 0);
 
-	napi_complete(napi);
-
-	rswitch_enadis_data_irq(priv, rdev->tx_queue->index, true);
-	rswitch_enadis_data_irq(priv, rdev->rx_queue->index, true);
+	if (napi_complete_done(napi, budget - quota)) {
+		rswitch_enadis_data_irq(priv, rdev->tx_queue->index, true);
+		rswitch_enadis_data_irq(priv, rdev->rx_queue->index, true);
+	}
 
 out:
 	return budget - quota;
-- 
2.25.1


