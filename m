Return-Path: <netdev+bounces-60708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB1C8213EE
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 15:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760FD1F21651
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 14:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FB64691;
	Mon,  1 Jan 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EScTVsa+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472938BF2
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704118084; x=1735654084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HHgHU0gPLlD9f3cMWo1rD8AAnY/5mOYfVdgcEdxUFPw=;
  b=EScTVsa+pmuC15jK4GP3O4XvASJxAnaJxv2Yf6yW5hBBNq2V+t6xG6M2
   Lr8cZTylcQch/hyKFHS4RojtoDAsXzknKFjr2c82WYBwxveh8htmmPGTh
   XncDkaZYxZN/Y4pmQosm3gJibSdIxrrDK3+STiuLVag9NHg24zie4/Qzi
   k=;
X-IronPort-AV: E=Sophos;i="6.04,322,1695686400"; 
   d="scan'208";a="379573528"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 14:08:01 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id D4AF74A985;
	Mon,  1 Jan 2024 14:08:00 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:25745]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.93:2525] with esmtp (Farcaster)
 id 9da3fce5-d644-46ad-9566-3e6a75e76ea6; Mon, 1 Jan 2024 14:07:59 +0000 (UTC)
X-Farcaster-Flow-ID: 9da3fce5-d644-46ad-9566-3e6a75e76ea6
Received: from EX19D010UWA003.ant.amazon.com (10.13.138.199) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 14:07:59 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D010UWA003.ant.amazon.com (10.13.138.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 14:07:59 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 1 Jan 2024 14:07:56 +0000
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
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>
Subject: [PATCH v1 net-next 08/11] net: ena: Add more debug prints to XDP related function
Date: Mon, 1 Jan 2024 14:07:21 +0000
Message-ID: <20240101140724.26232-9-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240101140724.26232-1-darinzon@amazon.com>
References: <20240101140724.26232-1-darinzon@amazon.com>
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

Used for better readability and debugging of XDP
flow.

Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_xdp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_xdp.c b/drivers/net/ethernet/amazon/ena/ena_xdp.c
index dd01b41..c9992ce 100644
--- a/drivers/net/ethernet/amazon/ena/ena_xdp.c
+++ b/drivers/net/ethernet/amazon/ena/ena_xdp.c
@@ -301,6 +301,8 @@ static int ena_xdp_set(struct net_device *netdev, struct netdev_bpf *bpf)
 			}
 			ena_xdp_exchange_program(adapter, prog);
 
+			netif_dbg(adapter, drv, adapter->netdev, "Set a new XDP program\n");
+
 			if (is_up && !old_bpf_prog) {
 				rc = ena_up(adapter);
 				if (rc)
@@ -309,6 +311,8 @@ static int ena_xdp_set(struct net_device *netdev, struct netdev_bpf *bpf)
 			xdp_features_set_redirect_target(netdev, false);
 		} else if (old_bpf_prog) {
 			xdp_features_clear_redirect_target(netdev);
+			netif_dbg(adapter, drv, adapter->netdev, "Removing XDP program\n");
+
 			rc = ena_destroy_and_free_all_xdp_queues(adapter);
 			if (rc)
 				return rc;
-- 
2.40.1


