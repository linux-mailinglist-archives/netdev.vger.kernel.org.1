Return-Path: <netdev+bounces-173440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC4FA58D85
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 09:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286F316652F
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 08:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AB1221F25;
	Mon, 10 Mar 2025 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="H66Yd8lL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A83D3B3
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593742; cv=none; b=RGfnhc6b98dBwG7z7sN53zUROQwzDpSNb781LSLqaXTGkSjosnKwMB5sL4lv0elrdslp1PVM+/26JgBIonqsSrSi5+IQBqhBVGWs0aSAwHU769GTGYtrZlB1Mqi2A/Y29gWGFJb8YC2cZI8S5DXOO3wltkxhG1BP/2EGKV8js6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593742; c=relaxed/simple;
	bh=SNrhRQVCrhC16KVBQKdCd872GGIX3K8HIB7+kHFfeAc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HZG2vw/atGiSv/olAlDUeEiTd8QvOvPtqa5DVWDd8tah/VG3IFIcLNPAouvrTXe9pZMG35kw6EoQORYxDPHcufWPzdDC/y+cjf/NukYTlpuqnQ8F6GyVBc6jd1s4NmzjxkZEOWoJO6VDBi93o3/4qvkad3thKtEo6s3e2ClNC/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=H66Yd8lL; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741593742; x=1773129742;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w0vX0YHEEWdqohkDc5X1/rca4id9zTwCxdKpyEmtEck=;
  b=H66Yd8lLzzHryuuDhGlnKGa/APwridkN1NkP7Q2wdGYwA6LlqRjsrutO
   eQbHIZCT1PmPeTkZkqm+Wk5ZGpc/eQtwFiU7JIDsUB2nIJq7tuPnVQgr6
   SxFT6aVpNQz//wnSIZtgGW+6Ao+qWkghMhRyjk4aVDTkQJayXep/IAety
   I=;
X-IronPort-AV: E=Sophos;i="6.14,235,1736812800"; 
   d="scan'208";a="385064732"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:02:15 +0000
Received: from EX19MTAUEA002.ant.amazon.com [10.0.0.204:4159]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.53.105:2525] with esmtp (Farcaster)
 id ab800096-2870-435c-9e5e-60126b4d3cbb; Mon, 10 Mar 2025 08:02:13 +0000 (UTC)
X-Farcaster-Flow-ID: ab800096-2870-435c-9e5e-60126b4d3cbb
Received: from EX19D008UEA002.ant.amazon.com (10.252.134.125) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Mar 2025 08:02:05 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA002.ant.amazon.com (10.252.134.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Mar 2025 08:02:05 +0000
Received: from email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 08:02:05 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.178])
	by email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com (Postfix) with ESMTP id 703264040A;
	Mon, 10 Mar 2025 08:02:00 +0000 (UTC)
From: David Arinzon <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
	"Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
	<ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, "Agroskin,
 Shay" <shayagr@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>
Subject: [PATCH net-next] net: ena: resolve WARN_ON when freeing IRQs
Date: Mon, 10 Mar 2025 10:01:48 +0200
Message-ID: <20250310080149.757-1-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When IRQs are freed, a WARN_ON is triggered as the
affinity notifier is not released.
This results in the below stack trace:

[  484.544586]  ? __warn+0x84/0x130
[  484.544843]  ? free_irq+0x5c/0x70
[  484.545105]  ? report_bug+0x18a/0x1a0
[  484.545390]  ? handle_bug+0x53/0x90
[  484.545664]  ? exc_invalid_op+0x14/0x70
[  484.545959]  ? asm_exc_invalid_op+0x16/0x20
[  484.546279]  ? free_irq+0x5c/0x70
[  484.546545]  ? free_irq+0x10/0x70
[  484.546807]  ena_free_io_irq+0x5f/0x70 [ena]
[  484.547138]  ena_down+0x250/0x3e0 [ena]
[  484.547435]  ena_destroy_device+0x118/0x150 [ena]
[  484.547796]  __ena_shutoff+0x5a/0xe0 [ena]
[  484.548110]  pci_device_remove+0x3b/0xb0
[  484.548412]  device_release_driver_internal+0x193/0x200
[  484.548804]  driver_detach+0x44/0x90
[  484.549084]  bus_remove_driver+0x69/0xf0
[  484.549386]  pci_unregister_driver+0x2a/0xb0
[  484.549717]  ena_cleanup+0xc/0x130 [ena]
[  484.550021]  __do_sys_delete_module.constprop.0+0x176/0x310
[  484.550438]  ? syscall_trace_enter+0xfb/0x1c0
[  484.550782]  do_syscall_64+0x5b/0x170
[  484.551067]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Adding a call to `netif_napi_set_irq` with -1 as the IRQ index,
which frees the notifier.

Fixes: de340d8206bf ("net: ena: use napi's aRFS rmap notifers")
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 6aab85a7..9e007c60 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1716,8 +1716,12 @@ static void ena_free_io_irq(struct ena_adapter *adapter)
 	int i;
 
 	for (i = ENA_IO_IRQ_FIRST_IDX; i < ENA_MAX_MSIX_VEC(io_queue_count); i++) {
+		struct ena_napi *ena_napi;
+
 		irq = &adapter->irq_tbl[i];
 		irq_set_affinity_hint(irq->vector, NULL);
+		ena_napi = (struct ena_napi *)irq->data;
+		netif_napi_set_irq(&ena_napi->napi, -1);
 		free_irq(irq->vector, irq->data);
 	}
 }
-- 
2.47.1


