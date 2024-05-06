Return-Path: <netdev+bounces-93628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 776FA8BC814
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 09:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D141F2239A
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 07:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4949E5464A;
	Mon,  6 May 2024 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ibxIv+q2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC95337A
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979122; cv=none; b=HNwOP4ey7qOn2RK4boprw+Lojs5xwUMk0RKvCEKr2bXHkpPvCVhNN7YkqOcDPXnNx1IuCf6VBJPhWEpCAMMSoFGGvRP2U2MhwWpFJ+Bwk393nT1Iz3f9JjlbsQqCJyUco1nLOth2Pdv5Kqq4YmnMp0pyGCiLsp/RDenaqwEgSVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979122; c=relaxed/simple;
	bh=v1SW2LD1kKZnEBcIlJ8oI3sqvyUjqR2fDIZIkhd7Xzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kS4vk0nEwc5yT0N0LG7ayLocir62Lvo/fNc7aKY4m1bK3SWHznYgXjFcSlufLK4k9WMTRkju4GfejX+hd2LWK+XZ69IYaWvhIueXwn6AeBOcBIkiXirOH6bDcJ7gaDZIWz+PIh0nz4/UhxKxMEhEjhKuRdlc/NBpa8hZDOri3X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ibxIv+q2; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714979121; x=1746515121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w+ZtxqWVAmNISxxyTCRftYBBDFRc+t3aZY2luzMzLXM=;
  b=ibxIv+q2X823jUAlgUULl/uZbO0sEROdzk4pJY6a0xSOjLkDdqOcqAcT
   l4KWBpJbojrEu0kBA91Okm7h3H8WHL0wGKNEdeox4d5K5iqX6Em2hWzPN
   qCAIPJlutUnftYlBNXZEwd03lvZw8BTtScX6CH1UlLoFJePVoJBOxvcTF
   0=;
X-IronPort-AV: E=Sophos;i="6.07,257,1708387200"; 
   d="scan'208";a="394633732"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:05:20 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:2249]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.38:2525] with esmtp (Farcaster)
 id edfab993-9d86-49eb-a4fa-f5e88534080d; Mon, 6 May 2024 07:05:18 +0000 (UTC)
X-Farcaster-Flow-ID: edfab993-9d86-49eb-a4fa-f5e88534080d
Received: from EX19D010UWA003.ant.amazon.com (10.13.138.199) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 6 May 2024 07:05:18 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D010UWA003.ant.amazon.com (10.13.138.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 6 May 2024 07:05:18 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Mon, 6 May 2024 07:05:15 +0000
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
Subject: [PATCH v1 net-next 5/6] net: ena: Change initial rx_usec interval
Date: Mon, 6 May 2024 07:04:52 +0000
Message-ID: <20240506070453.17054-6-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240506070453.17054-1-darinzon@amazon.com>
References: <20240506070453.17054-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: David Arinzon <darinzon@amazon.com>

For the purpose of obtaining better CPU utilization,
minimum rx moderation interval is set to 20 usec.

Signed-off-by: Osama Abboud <osamaabb@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
index fdae0cc9..924f03f5 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -47,7 +47,7 @@
 /* ENA adaptive interrupt moderation settings */
 
 #define ENA_INTR_INITIAL_TX_INTERVAL_USECS 64
-#define ENA_INTR_INITIAL_RX_INTERVAL_USECS 0
+#define ENA_INTR_INITIAL_RX_INTERVAL_USECS 20
 #define ENA_DEFAULT_INTR_DELAY_RESOLUTION 1
 
 #define ENA_HASH_KEY_SIZE 40
-- 
2.40.1


