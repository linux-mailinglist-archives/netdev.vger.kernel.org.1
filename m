Return-Path: <netdev+bounces-66639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197F78400B0
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 09:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6706B21425
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 08:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25AD54FA5;
	Mon, 29 Jan 2024 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IHax5C2D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B37454BE8
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518578; cv=none; b=IVArWWX37Fz3u/qTgxkrlobNdT3sVFzwJ5FZlHV23kOGhQ/rSuDuktz/wYI2bX04Tjm++aT00hjpBiVcYqJ9r+3jmpOqxuRAn9LBk3aeyqbbqi5OHZCPjtVVmMhu7LKaD8CKw4uTkaqlnCeNBW9GhDqM5NPTNcEYP7zdL9wjK14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518578; c=relaxed/simple;
	bh=us69zVGCUBWs2TF3IYxqGzvKNWcIGv6S6Y8u2d9kfd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4Ft7U7MMxDwC+Fw4fKNcx5FwcmVwqGcxCcdvN5BRseeaPQlGeHW8srx80402TMyLRO7HT9gP7QQmr+ILCdQMLDh0ptvig9/aSgcX1HDylzeH5vuWcfQU80xBP+L2luSBuu78MswjgKGac0T23oF6XRVb67jhZ5loRFausZjS8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IHax5C2D; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706518577; x=1738054577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Q9fAz4UfKDgIZ+ckd9rfNZR/KOKAT8r7M1gVe6PoOw=;
  b=IHax5C2DYdiY4H2uLDoJFKBiWE9NNpe/JXlQ9mWX2s8gf//O1Wt6Vv1M
   P4Y7AK5733Mn1Dci7AhcuiMbiSiaBisAGlEka2rMdFVvEjtcmZW+uYAZ1
   z8iQdcfPINaziHX+dOSG4+/R9ff6qN2/h9ZOU09seG2ONbaExSaXpNIyE
   c=;
X-IronPort-AV: E=Sophos;i="6.05,226,1701129600"; 
   d="scan'208";a="61883181"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 08:56:16 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com (Postfix) with ESMTPS id AAC53A0AA3;
	Mon, 29 Jan 2024 08:56:15 +0000 (UTC)
Received: from EX19MTAUEC001.ant.amazon.com [10.0.29.78:29063]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.19.21:2525] with esmtp (Farcaster)
 id c438139d-538f-46f5-93df-d0235b3e024c; Mon, 29 Jan 2024 08:56:15 +0000 (UTC)
X-Farcaster-Flow-ID: c438139d-538f-46f5-93df-d0235b3e024c
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:56:14 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:56:14 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 08:56:12
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
Subject: [PATCH v1 net-next 09/11] net: ena: Change default print level for netif_ prints
Date: Mon, 29 Jan 2024 08:55:29 +0000
Message-ID: <20240129085531.15608-10-darinzon@amazon.com>
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

The netif_* functions are used by the driver to log events into the
kernel ring (dmesg) similar to the netdev_* ones. Unlike the latter,
the netif_* function family allow the user to choose what events get
logged using ethtool:
	sudo ethtool -s [interface] msglvl [msg_type] on

By default the events which get logged are slow-path related and aren't
printed often (e.g. interface up related prints). This patch removes the
NETIF_MSG_TX_DONE type (called every TX completion polling) from the
defaults and adds NETIF_MSG_IFDOWN instead as it makes more sensible
defaults.

This patch also transforms ena_down() print from netif_info into
netif_dbg (same as the analogue print in ena_up()) as it suits it
better.

Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index d4ca406..8d99904 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -32,7 +32,7 @@ MODULE_LICENSE("GPL");
 #define ENA_MAX_RINGS min_t(unsigned int, ENA_MAX_NUM_IO_QUEUES, num_possible_cpus())
 
 #define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_IFUP | \
-		NETIF_MSG_TX_DONE | NETIF_MSG_TX_ERR | NETIF_MSG_RX_ERR)
+		NETIF_MSG_IFDOWN | NETIF_MSG_TX_ERR | NETIF_MSG_RX_ERR)
 
 static struct ena_aenq_handlers aenq_handlers;
 
@@ -2212,7 +2212,7 @@ void ena_down(struct ena_adapter *adapter)
 {
 	int io_queue_count = adapter->num_io_queues + adapter->xdp_num_queues;
 
-	netif_info(adapter, ifdown, adapter->netdev, "%s\n", __func__);
+	netif_dbg(adapter, ifdown, adapter->netdev, "%s\n", __func__);
 
 	clear_bit(ENA_FLAG_DEV_UP, &adapter->flags);
 
-- 
2.40.1


