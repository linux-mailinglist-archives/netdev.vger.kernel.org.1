Return-Path: <netdev+bounces-67082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA402842044
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6085A1F21294
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07E96A03E;
	Tue, 30 Jan 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MKVfR5BZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621C16A334
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608468; cv=none; b=XrAGVVPfFITe+K1yN4Eu9L/qhR1VueAHWnY0Lw7sCGgKLTQN2pciikC/AmyX5HMeiEWVbbmKicn8yjqXXZUo5wdWsJMGTDMeC4UjEwQP08e1As4kw50K7bffK6u+kZyaxg/CniwORaC2pCQuqlbwwnUDM93Yl/hmq2K5GJWrhhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608468; c=relaxed/simple;
	bh=p3knAqVszkmrkxzftPEXxls1qpjxmrhglOR+RLki9YM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYJ4YuDRhBaHYCZ8Y9vBAhKuJ3dPWrIeyjeLSmpbkM7jOWnKS2qL+ffkaFrCW+fMEJKBXX5iUjvC4RP/mS66rq+eBIJ8qYoXuJNG7HgyRNJj1yxuuW/aPsl+YirGFcSKNkJgpWydpuzgfr4FCGVRjiySQ/km2UzU9xKkBBAH0fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MKVfR5BZ; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706608467; x=1738144467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/XJm8N+MOI55xoaLIlbnhT2Ty9SdOQ/y9hA1G8LE2Tk=;
  b=MKVfR5BZIgKZ3ryxb2sGqxEaTRzaBfIZOnXu/0894iqI5Dy3wHCJ/09u
   vAUv2HXKnQyDtpbhONbj+U0j6RfFoUm6In/XJMDTMY06kc2eMW2r689Dp
   PnpMd3W/tmVEZPM6e4wGz8tGoKRrBE344RfRMYUdqI4a+7ZdUjDSw0TXc
   U=;
X-IronPort-AV: E=Sophos;i="6.05,707,1701129600"; 
   d="scan'208";a="377659221"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d8e96288.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:54:26 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-d8e96288.us-east-1.amazon.com (Postfix) with ESMTPS id 0DCCF8354B;
	Tue, 30 Jan 2024 09:54:26 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:64347]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.136:2525] with esmtp (Farcaster)
 id fa2db21c-07fe-460e-9844-f41bc92005b3; Tue, 30 Jan 2024 09:54:25 +0000 (UTC)
X-Farcaster-Flow-ID: fa2db21c-07fe-460e-9844-f41bc92005b3
Received: from EX19D010UWA001.ant.amazon.com (10.13.138.225) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:54:25 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D010UWA001.ant.amazon.com (10.13.138.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:54:24 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Tue, 30 Jan 2024 09:54:21
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
Subject: [PATCH v2 net-next 08/11] net: ena: Relocate skb_tx_timestamp() to improve time stamping accuracy
Date: Tue, 30 Jan 2024 09:53:50 +0000
Message-ID: <20240130095353.2881-9-darinzon@amazon.com>
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


