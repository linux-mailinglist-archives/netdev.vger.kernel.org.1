Return-Path: <netdev+bounces-34194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C707A293F
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 23:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8351C20A35
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 21:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083FA1B288;
	Fri, 15 Sep 2023 21:22:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17D01B275
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 21:22:34 +0000 (UTC)
X-Greylist: delayed 1254 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Sep 2023 14:22:32 PDT
Received: from mx03lb.world4you.com (mx03lb.world4you.com [81.19.149.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A3BB8
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vIjEEICR1hbXAjJHRShdPxa6IBYkmevzUOX04R5A4XM=; b=dXvxNzTsw8QTkX8zEIcINhahcW
	KCL+kLL3JQeydOzRvBZuwwwCWRZtkZh/NRpOt5r9uOPomHuzelcIVjjMcsmUDqvFAaeY5Up9aUh+w
	e4fUITSYIHgQRgz0JxxbDulqJK0zqer6BlZxw7/RbyUx1QEhG98IvO+7j/ehqVVmkp04=;
Received: from 88-117-56-237.adsl.highway.telekom.at ([88.117.56.237] helo=hornet.engleder.at)
	by mx03lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1qhFwf-0006X1-0Q;
	Fri, 15 Sep 2023 23:01:45 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net 2/3] tsnep: Fix ethtool channels
Date: Fri, 15 Sep 2023 23:01:25 +0200
Message-Id: <20230915210126.74997-3-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230915210126.74997-1-gerhard@engleder-embedded.com>
References: <20230915210126.74997-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

According to the NAPI documentation networking/napi.rst, for the ethtool
API a channel is a IRQ/NAPI which services queues of a given type.

tsnep uses a single IRQ/NAPI instance for every TX/RX queue pair.
Therefore, combined channels shall be returned instead of separate tx/rx
channels.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/ethernet/engleder/tsnep_ethtool.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_ethtool.c b/drivers/net/ethernet/engleder/tsnep_ethtool.c
index 716815dad7d2..65ec1abc9442 100644
--- a/drivers/net/ethernet/engleder/tsnep_ethtool.c
+++ b/drivers/net/ethernet/engleder/tsnep_ethtool.c
@@ -300,10 +300,8 @@ static void tsnep_ethtool_get_channels(struct net_device *netdev,
 {
 	struct tsnep_adapter *adapter = netdev_priv(netdev);
 
-	ch->max_rx = adapter->num_rx_queues;
-	ch->max_tx = adapter->num_tx_queues;
-	ch->rx_count = adapter->num_rx_queues;
-	ch->tx_count = adapter->num_tx_queues;
+	ch->max_combined = adapter->num_queues;
+	ch->combined_count = adapter->num_queues;
 }
 
 static int tsnep_ethtool_get_ts_info(struct net_device *netdev,
-- 
2.30.2


