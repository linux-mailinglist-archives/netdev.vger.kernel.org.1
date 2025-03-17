Return-Path: <netdev+bounces-175192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81154A64307
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1FCA1680E4
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 07:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6286C21506D;
	Mon, 17 Mar 2025 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DUrNgQlX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A0E21ABBC
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195528; cv=none; b=XLdu55clVPZnUhA7n1RotaPVvM2Vn05DaIJPeC+pC3kjNMomsMbTkQg/5SvepTnGGM05O4ecoYb4cBIOn3ogPOJxZq85atDYn/BeRGSwjChfcjbFFevOTGSjD2QXGMBaJJhzdQat+/XoDwRZMiD1xaGatB5a5ETvJA4uWO0nYKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195528; c=relaxed/simple;
	bh=XaoGzoSd4+DMOue9Qeo8FUW6Jbk6hQfwUT8swY2Ry3I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PbcP/7QV9hPj2s9ETzv3/aFzy4z8zuzQBRGfLzld67ol0LmNO5H2DEdGvlC3j1/ZbAo/vj7ILFM/FRmUae3oOIWLJ8swJaMkiWgvN3gMDgDrXMveHbm15vari6EHdYOIsEGlW6EiHPWKNmVXxIxfrdjG1T84qOZjYAR2MR1awjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DUrNgQlX; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742195527; x=1773731527;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I/JTemISKXr2LCxUz2k1XAzsN3l2PzZBF8J95tQqeDY=;
  b=DUrNgQlX4UVre9uDJZJj8+a8ROuP6GsX7oj6eLm0no0iicc0qti0KFQf
   uMTa7OyNJsJmRo5jL02w1iNt0iFdHwgrOxnxUtLQT6OTDPz2d8HZJjg9F
   PRbDv9hI+fS8XffJHkdQJqP64bRn4N6ci6iR32L6y7WVwszd/Dvfrh0sW
   s=;
X-IronPort-AV: E=Sophos;i="6.14,253,1736812800"; 
   d="scan'208";a="387235735"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 07:12:05 +0000
Received: from EX19MTAUEB001.ant.amazon.com [10.0.44.209:46829]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.46.185:2525] with esmtp (Farcaster)
 id 1bd349c6-41d4-4499-a565-bf7bb74886c0; Mon, 17 Mar 2025 07:12:03 +0000 (UTC)
X-Farcaster-Flow-ID: 1bd349c6-41d4-4499-a565-bf7bb74886c0
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Mar 2025 07:11:57 +0000
Received: from EX19MTAUEA002.ant.amazon.com (10.252.134.9) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Mar 2025 07:11:56 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 07:11:56 +0000
Received: from HFA15-G9FV5D3.amazon.com (unknown [10.85.143.178])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTP id 71DDBA0607;
	Mon, 17 Mar 2025 07:11:50 +0000 (UTC)
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
Subject: [PATCH net-next v2] net: ena: resolve WARN_ON when freeing IRQs
Date: Mon, 17 Mar 2025 09:11:47 +0200
Message-ID: <20250317071147.1105-1-darinzon@amazon.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
Changes in v2:
- Remove an unnecessary cast

Link to v1: https://lore.kernel.org/netdev/20250312143929.GT4159220@kernel.org/T/
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 6aab85a7..70fa3adb 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1716,8 +1716,12 @@ static void ena_free_io_irq(struct ena_adapter *adapter)
 	int i;
 
 	for (i = ENA_IO_IRQ_FIRST_IDX; i < ENA_MAX_MSIX_VEC(io_queue_count); i++) {
+		struct ena_napi *ena_napi;
+
 		irq = &adapter->irq_tbl[i];
 		irq_set_affinity_hint(irq->vector, NULL);
+		ena_napi = irq->data;
+		netif_napi_set_irq(&ena_napi->napi, -1);
 		free_irq(irq->vector, irq->data);
 	}
 }
-- 
2.47.1


