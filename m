Return-Path: <netdev+bounces-66633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 684F18400AA
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 09:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE661F219B8
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 08:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC91654BCC;
	Mon, 29 Jan 2024 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fczBmjY+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0802754BE2
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518557; cv=none; b=HMC3nfd4hRyIgOImh6vH2cTtoBCd1gYU5lIHXJHowj5LrviboLYNhyB4Af2yfdHoEXeg4XgKSyQEIYXbiAvABwwzvmb5VBt/viht9TaYrGuqBmV4HWqunRMPSkRB46zZOO8iX9XrC3FcMg/tVEV+NVtUpk+dY7WbxptZ86JWNE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518557; c=relaxed/simple;
	bh=WbNTg5mIuDPxbwAiWs4O2PNVCMYqhtbc+AFKIbjU9YE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edZ/SDMuTZOM6Z1pZubJ7kBCd3hledPW0DK9vy1K7G1zhaWHf5aQ6t5nhpBib9JQEgIcWf1IUR58tSKR03etZ7W3gOXihS7MCnRTmgu7fe3eAxycq22EEUq7z4kS046IPoppHyPh2edmn8W6Mege+HdbrmFonKj7KSajF9yAHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fczBmjY+; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706518556; x=1738054556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AOHM2cJ1bM613iSGC4IQPu8u0ZxSwuCtpMaQ0EYrFYY=;
  b=fczBmjY+o4vln7nFNJPOVA1oUpFSWbXU7cqgQgEgtia7zO5hUbLT5TBI
   F4kSm20eaDD4K7aqq9M95K6Z8RejCmeMab5w+TAz1pjOl70PfvepVY7Fy
   w729Ktz8gWBkwYRye1SMhx+76exYvjEssjxbJON67kaND2xtetgK6dkqW
   Y=;
X-IronPort-AV: E=Sophos;i="6.05,226,1701129600"; 
   d="scan'208";a="634147400"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 08:55:53 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix) with ESMTPS id 0FDEE80471;
	Mon, 29 Jan 2024 08:55:52 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:18734]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.214:2525] with esmtp (Farcaster)
 id 4b62c572-d780-422a-9e17-eba01254526e; Mon, 29 Jan 2024 08:55:51 +0000 (UTC)
X-Farcaster-Flow-ID: 4b62c572-d780-422a-9e17-eba01254526e
Received: from EX19D021UWA002.ant.amazon.com (10.13.139.48) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:55:51 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D021UWA002.ant.amazon.com (10.13.139.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:55:51 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 08:55:48
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
Subject: [PATCH v1 net-next 03/11] net: ena: Minor cosmetic changes
Date: Mon, 29 Jan 2024 08:55:23 +0000
Message-ID: <20240129085531.15608-4-darinzon@amazon.com>
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


