Return-Path: <netdev+bounces-67081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4517842041
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE282845F0
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4966A00B;
	Tue, 30 Jan 2024 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UMq2GsTl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5361867E8E
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608456; cv=none; b=Y6LMIAuH7PZFGi5TTmlPXSDoTEeQ1hmLFDmO2P1PhT5Q8GWr4Pa3zbBvwt9fC7WqoaKFYQz/wbB0lillqaM8WXmpSxJ74dBFufoIm8NeivD7OhIoiT7t17l9yrXFiS3Yggaumx3YnnW7ML4WmXv30h6mhsW2Tf0xePim0xKNKRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608456; c=relaxed/simple;
	bh=WbNTg5mIuDPxbwAiWs4O2PNVCMYqhtbc+AFKIbjU9YE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sd/5Ex6kE7AcoHM/XJujalXhJMd3DiBmacDqvS4ULLticO7DtX2CMBmcAwsT/PyzTKcyzi4QPsswq+ifz8Qhm0WEn/St5QpGW87V5jsCGukCb9w94xOJL++aGObi34hYOusN5nKlZJBZdTFe4JsRdQO3xpkcEnFjWCygdgLbhLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UMq2GsTl; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706608456; x=1738144456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AOHM2cJ1bM613iSGC4IQPu8u0ZxSwuCtpMaQ0EYrFYY=;
  b=UMq2GsTl4NEwLpkgkcR7AbzY0QDONgSfHHWOJNCkjfDI7kh5MWFuzKi6
   P8kn/MXsVnHRdQMDJuX1Wdpi+xfexCH/pd/CNIBsWa3985J/6VPwarjIM
   R3ePJzPbL6JC32MvhhYB4q9biJZU7HrlCZJGX1VwL8O/v2lG/4hM6d/0u
   0=;
X-IronPort-AV: E=Sophos;i="6.05,707,1701129600"; 
   d="scan'208";a="700756132"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:54:09 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com (Postfix) with ESMTPS id 764D4803B8;
	Tue, 30 Jan 2024 09:54:08 +0000 (UTC)
Received: from EX19MTAUEA002.ant.amazon.com [10.0.29.78:62635]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.46.110:2525] with esmtp (Farcaster)
 id 5ae768a1-cef2-46d4-8ba9-c39c7bf6eef1; Tue, 30 Jan 2024 09:54:07 +0000 (UTC)
X-Farcaster-Flow-ID: 5ae768a1-cef2-46d4-8ba9-c39c7bf6eef1
Received: from EX19D008UEC002.ant.amazon.com (10.252.135.242) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:54:07 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEC002.ant.amazon.com (10.252.135.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:54:06 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Tue, 30 Jan 2024 09:54:05
 +0000
From: <darinzon@amazon.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
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
	<nkoler@amazon.com>
Subject: [PATCH v2 net-next 03/11] net: ena: Minor cosmetic changes
Date: Tue, 30 Jan 2024 09:53:45 +0000
Message-ID: <20240130095353.2881-4-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240130095353.2881-1-darinzon@amazon.com>
References: <20240130095353.2881-1-darinzon@amazon.com>
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

A few changes for better readability and style

1. Adding / Removing newlines
2. Removing an unnecessary and confusing comment
3. Using an existing variable rather than re-checking a field

Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 1c0a782..d68d081 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2197,8 +2197,6 @@ void ena_down(struct ena_adapter *adapter)
 	/* After this point the napi handler won't enable the tx queue */
 	ena_napi_disable_in_range(adapter, 0, io_queue_count);
 
-	/* After destroy the queue there won't be any new interrupts */
-
 	if (test_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags)) {
 		int rc;
 
@@ -3226,7 +3224,7 @@ static void ena_destroy_device(struct ena_adapter *adapter, bool graceful)
 	if (!graceful)
 		ena_com_set_admin_running_state(ena_dev, false);
 
-	if (test_bit(ENA_FLAG_DEV_UP, &adapter->flags))
+	if (dev_up)
 		ena_down(adapter);
 
 	/* Stop the device from sending AENQ events (in case reset flag is set
@@ -4040,8 +4038,8 @@ static void __ena_shutoff(struct pci_dev *pdev, bool shutdown)
 		free_irq_cpu_rmap(netdev->rx_cpu_rmap);
 		netdev->rx_cpu_rmap = NULL;
 	}
-#endif /* CONFIG_RFS_ACCEL */
 
+#endif /* CONFIG_RFS_ACCEL */
 	/* Make sure timer and reset routine won't be called after
 	 * freeing device resources.
 	 */
-- 
2.40.1


