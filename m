Return-Path: <netdev+bounces-66631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B99B98400A8
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 09:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40B42831C3
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 08:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C61054BCB;
	Mon, 29 Jan 2024 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fn3ooGCh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8755354BE4
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518549; cv=none; b=igMkDsJgY1c9sshoEScysMKo1tkwyvBCm7S/BDboCEVvW8glldn+KYSCVfkzb49zgwj3VEfZ9w8CQ/9uOzUHLq9vTGC/Ocyfnxz2COnqI4GV1pZyMKi1BxIWH380J0jJqyW/XCyCIOqS50Gcp/MsTDY0KeQvAWeI5q6amXoGO4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518549; c=relaxed/simple;
	bh=kmr7XFSzGq7/jYSEDUOqfYiTv7flit74qjKjHCdJdpA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b5VcSL8/a286pPnbEwr6aRk2/hyM8MT6Kcvhuliza4H2mWbIkA5vyWfTcP2yS27fBxrL0wveENQG8hd2vkkmX/JRoMzpJhSobSEMB4aos/K7io9KaZxObdtbJcRhtRjR5uL8SdiAney6QonjyDX1+gkEVnFA3Z+5QeezyQ2UExo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fn3ooGCh; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706518549; x=1738054549;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8d4/0I2C6EGi4NGCqFt6CeTTkm3qWoONsBnRO3jUqL0=;
  b=fn3ooGCh7ZZXOujEqpGyaePkWolN+EfsdW1LaUyrxwbFC4kI171O546c
   /HIivR5cQUniNECaokn8dhT4dTHvh1tKJPRnnkPhQtBiQvnQ/m+GPdlOj
   gkUo68Ky+gbgAeutgG8CHYnLAh7bmh3JZSUuovRtqsM4rOqsHQQZ7iyM0
   g=;
X-IronPort-AV: E=Sophos;i="6.05,226,1701129600"; 
   d="scan'208";a="701032187"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 08:55:41 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com (Postfix) with ESMTPS id 10E5F40B6E;
	Mon, 29 Jan 2024 08:55:40 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:54739]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.214:2525] with esmtp (Farcaster)
 id 3ea7404c-e7a1-47ec-a619-bb0c24f5347f; Mon, 29 Jan 2024 08:55:39 +0000 (UTC)
X-Farcaster-Flow-ID: 3ea7404c-e7a1-47ec-a619-bb0c24f5347f
Received: from EX19D010UWA003.ant.amazon.com (10.13.138.199) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:55:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D010UWA003.ant.amazon.com (10.13.138.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:55:38 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 08:55:35
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
Subject: [PATCH v1 net-next 00/11] ENA driver changes
Date: Mon, 29 Jan 2024 08:55:20 +0000
Message-ID: <20240129085531.15608-1-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
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

This patchset contains a set of minor and cosmetic
changes to the ENA driver.

David Arinzon (11):
  net: ena: Remove an unused field
  net: ena: Add more documentation for RX copybreak
  net: ena: Minor cosmetic changes
  net: ena: Enable DIM by default
  net: ena: Remove CQ tail pointer update
  net: ena: Change error print during ena_device_init()
  net: ena: Add more information on TX timeouts
  net: ena: Relocate skb_tx_timestamp() to improve time stamping
    accuracy
  net: ena: Change default print level for netif_ prints
  net: ena: handle ena_calc_io_queue_size() possible errors
  net: ena: Reduce lines with longer column width boundary

 .../device_drivers/ethernet/amazon/ena.rst    |   6 +
 drivers/net/ethernet/amazon/ena/ena_com.c     | 323 ++++++------------
 drivers/net/ethernet/amazon/ena/ena_com.h     |   6 +-
 drivers/net/ethernet/amazon/ena/ena_eth_com.c |  49 ++-
 drivers/net/ethernet/amazon/ena/ena_eth_com.h |  39 +--
 drivers/net/ethernet/amazon/ena/ena_netdev.c  | 161 ++++++---
 .../net/ethernet/amazon/ena/ena_regs_defs.h   |   1 +
 drivers/net/ethernet/amazon/ena/ena_xdp.c     |   1 -
 8 files changed, 258 insertions(+), 328 deletions(-)

-- 
2.40.1


