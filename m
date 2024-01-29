Return-Path: <netdev+bounces-66636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 314548400AD
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 09:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FA61F22ED5
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 08:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1594954BEC;
	Mon, 29 Jan 2024 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tKUL3w15"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675BF54BE1
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518570; cv=none; b=NCfljdwVN0SqsjF5m5QlxqaNjG/P3Zj4hQlvq5MQZfMNoQXnZHN4t8tFQR64n5FO9Qs9OHmr5m0n89p8ITaHDFBmqshktjZOSZ0SOoeplDuGxxX9sFwTmAyzwLmAH9jKOcHzn+y0xxW50gtPbXP19Lm+btVE8ZTRcmaqhbLiMCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518570; c=relaxed/simple;
	bh=QDcdsBs13RZu01K3X9ndaimnDjibKIW0uWiJ1PUzU9I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OBwCRkc7WMyBbGZoDs7VAAh5xt+pTd55nYuZip+EBxFOPzUrQEWRNZfJkoqthKKaJRyjbVN09FM5nseziadmJwNfATwhY8ogVKid5ACVOr0kvm2wYMl8UugQxOjhlgSk7t6WfJIpA/3uqhyx9AzQexPN135D7dYIgNjQWmcUaRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tKUL3w15; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706518569; x=1738054569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pITjmpnl+RzydiZdCQnhlYTbWGoxjIFXYGSb1wk8CzQ=;
  b=tKUL3w15NEsk/TMc3MRgyy5m6AXGwpQ/0uR7OTu6iINqdPaDfC6ejdWc
   GD7fWRibcOYozXppp1NW0PFQO1v8DEDEEbiPR5rHbyYe2vT6Gz8HwxO9D
   YAdy/agFtKlX2mmg0xoMBoclUMx5xO36P9uyHZi89zfmUn7KsyDRXbhxm
   U=;
X-IronPort-AV: E=Sophos;i="6.05,226,1701129600"; 
   d="scan'208";a="630522351"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 08:56:07 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id 49B2D40BD2;
	Mon, 29 Jan 2024 08:56:05 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:46347]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.103:2525] with esmtp (Farcaster)
 id 1f5f1718-4fff-4484-89e2-aba2edefa5e4; Mon, 29 Jan 2024 08:56:05 +0000 (UTC)
X-Farcaster-Flow-ID: 1f5f1718-4fff-4484-89e2-aba2edefa5e4
Received: from EX19D010UWB003.ant.amazon.com (10.13.138.81) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:56:04 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D010UWB003.ant.amazon.com (10.13.138.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:56:03 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 08:56:00
 +0000
From: <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
	<alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky, Evgeny"
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, "Koler, Nati"
	<nkolder@amazon.com>
Subject: [PATCH v1 net-next 06/11] net: ena: Change error print during ena_device_init()
Date: Mon, 29 Jan 2024 08:55:26 +0000
Message-ID: <20240129085531.15608-7-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240129085531.15608-1-darinzon@amazon.com>
References: <20240129085531.15608-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: Bulk

From: David Arinzon <darinzon@amazon.com>

The print was re-worded to a more informative one.

Signed-off-by: Shahar Itzko <itzko@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index cd75e5a..18acb76 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3071,6 +3071,7 @@ static int ena_device_init(struct ena_adapter *adapter, struct pci_dev *pdev,
 			   bool *wd_state)
 {
 	struct ena_com_dev *ena_dev = adapter->ena_dev;
+	struct net_device *netdev = adapter->netdev;
 	struct ena_llq_configurations llq_config;
 	struct device *dev = &pdev->dev;
 	bool readless_supported;
@@ -3160,7 +3161,7 @@ static int ena_device_init(struct ena_adapter *adapter, struct pci_dev *pdev,
 	rc = ena_set_queues_placement_policy(pdev, ena_dev, &get_feat_ctx->llq,
 					     &llq_config);
 	if (rc) {
-		dev_err(dev, "ENA device init failed\n");
+		netdev_err(netdev, "Cannot set queues placement policy rc= %d\n", rc);
 		goto err_admin_init;
 	}
 
-- 
2.40.1


