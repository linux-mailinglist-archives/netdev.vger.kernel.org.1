Return-Path: <netdev+bounces-55599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 314E580B9E2
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 09:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B447E280F15
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 08:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1A153BD;
	Sun, 10 Dec 2023 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="m0TQSl0q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98267E6
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 00:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702197099; x=1733733099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=57ZbMDl0JWa4IowwphmUMfBV6V05V75wN4qJ4+sjs6w=;
  b=m0TQSl0q/5xY7DdCij7MYdgRlrglqwgfIxgc2Y0Jsizgn3WrtshTke5K
   G3Cda1TW69ybRMSKcjzoh43MNocIyuJftsRMGxkBf/KFXXJc6L9PZXfwh
   NZMbh6E9EJh1CvQXERFqxT46tonFzj8ebqc5TCN/Zv0qqkhGyK53E4S2p
   0=;
X-IronPort-AV: E=Sophos;i="6.04,265,1695686400"; 
   d="scan'208";a="171041499"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-86a02d5e.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 08:31:39 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-86a02d5e.us-east-1.amazon.com (Postfix) with ESMTPS id 6F7EEE0676;
	Sun, 10 Dec 2023 08:31:37 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:54348]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.61:2525] with esmtp (Farcaster)
 id eb82224f-4999-46b7-be44-bc3fe9c5f293; Sun, 10 Dec 2023 08:31:36 +0000 (UTC)
X-Farcaster-Flow-ID: eb82224f-4999-46b7-be44-bc3fe9c5f293
Received: from EX19D002UWA002.ant.amazon.com (10.13.138.246) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 10 Dec 2023 08:31:36 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D002UWA002.ant.amazon.com (10.13.138.246) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 10 Dec 2023 08:31:36 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Sun, 10 Dec 2023 08:31:33
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
	<evostrov@amazon.com>
Subject: [PATCH v1 net 4/4] net: ena: Fix XDP redirection error
Date: Sun, 10 Dec 2023 08:30:56 +0000
Message-ID: <20231210083056.30357-5-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231210083056.30357-1-darinzon@amazon.com>
References: <20231210083056.30357-1-darinzon@amazon.com>
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

When sending TX packets, the meta descriptor can be all zeroes
as no meta information is required (as in XDP).

This patch removes the validity check, as when
`disable_meta_caching` is enabled, such TX packets will be
dropped otherwise.

Fixes: 0e3a3f6dacf0 ("net: ena: support new LLQ acceleration mode")
Signed-off-by: Shay Agroskin <shayagr@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_eth_com.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_eth_com.c b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
index 3d6f0a4..f9f8862 100644
--- a/drivers/net/ethernet/amazon/ena/ena_eth_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
@@ -328,9 +328,6 @@ static int ena_com_create_and_store_tx_meta_desc(struct ena_com_io_sq *io_sq,
 	 * compare it to the stored version, just create the meta
 	 */
 	if (io_sq->disable_meta_caching) {
-		if (unlikely(!ena_tx_ctx->meta_valid))
-			return -EINVAL;
-
 		*have_meta = true;
 		return ena_com_create_meta(io_sq, ena_meta);
 	}
-- 
2.40.1


