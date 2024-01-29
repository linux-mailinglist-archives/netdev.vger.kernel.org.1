Return-Path: <netdev+bounces-66637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A018400AE
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 09:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421CB28304B
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 08:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A8854BF7;
	Mon, 29 Jan 2024 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="b5MZLhix"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B513F54BE1
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518576; cv=none; b=XrkZokLBvXKzzgLdLNMn6y1wH+8B2MSjfNknuTcnhDFwQ0ha96pv+Fqu/ICfsP9i4Cc8x5ym8X3p1xrXl7f7k7qebC78J4l+CjrTNPz/iNzGNNZWw88EtBSAVNDC6KSRKBGDkYrn30HfjFmKfufDNpRmErXyLxRcCOyX63oqotg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518576; c=relaxed/simple;
	bh=p3knAqVszkmrkxzftPEXxls1qpjxmrhglOR+RLki9YM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIWvEkkeE8Oh/APCa2b2UoLr7Xn8mgruGkba74Ce1mu/IX6fSChZ3DAfwbE2b68ou0e7ZFO4HnCXqCb9TCC5myIx4RdeDADXUkj/ZvZY6w6nvMvqygpBBG0nmPuUQg+1xdiu1i6XSCYsQDpt4u2ARal2awM3xRy/iHkAqsYrtL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=b5MZLhix; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706518574; x=1738054574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/XJm8N+MOI55xoaLIlbnhT2Ty9SdOQ/y9hA1G8LE2Tk=;
  b=b5MZLhix5GLMOJhFlJeeCN9ainP5n7nl+cFUhbQHWlMFJw3sqVX5WlP7
   3SQA5IJcGcdw+uNnm4B7yL67vmHB7kaZwEadDZKe1/+JQeQV9W8dt1WuT
   19qMGnvXI0/42rAjpNAW8LkBubniHoY3rWV/IX6s84u/YBmzyxDNKX2Rs
   I=;
X-IronPort-AV: E=Sophos;i="6.05,226,1701129600"; 
   d="scan'208";a="61883172"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 08:56:13 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com (Postfix) with ESMTPS id C7B9140BBE;
	Mon, 29 Jan 2024 08:56:12 +0000 (UTC)
Received: from EX19MTAUEB002.ant.amazon.com [10.0.44.209:26700]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.32.35:2525] with esmtp (Farcaster)
 id a83c0ccc-1d62-4bd3-a566-b420b8fe3788; Mon, 29 Jan 2024 08:56:11 +0000 (UTC)
X-Farcaster-Flow-ID: a83c0ccc-1d62-4bd3-a566-b420b8fe3788
Received: from EX19D008UEC001.ant.amazon.com (10.252.135.232) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:56:11 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D008UEC001.ant.amazon.com (10.252.135.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:56:11 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 08:56:09
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
Subject: [PATCH v1 net-next 08/11] net: ena: Relocate skb_tx_timestamp() to improve time stamping accuracy
Date: Mon, 29 Jan 2024 08:55:28 +0000
Message-ID: <20240129085531.15608-9-darinzon@amazon.com>
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

Move skb_tx_timestamp() closer to the actual time the driver sends the
packets to the device.

Signed-off-by: Osama Abboud <osamaabb@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index ae9291b..d4ca406 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2614,8 +2614,6 @@ static netdev_tx_t ena_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (unlikely(rc))
 		goto error_drop_packet;
 
-	skb_tx_timestamp(skb);
-
 	next_to_use = tx_ring->next_to_use;
 	req_id = tx_ring->free_ids[next_to_use];
 	tx_info = &tx_ring->tx_buffer_info[req_id];
@@ -2679,6 +2677,8 @@ static netdev_tx_t ena_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 
+	skb_tx_timestamp(skb);
+
 	if (netif_xmit_stopped(txq) || !netdev_xmit_more())
 		/* trigger the dma engine. ena_ring_tx_doorbell()
 		 * calls a memory barrier inside it.
-- 
2.40.1


