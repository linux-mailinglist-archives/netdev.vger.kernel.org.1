Return-Path: <netdev+bounces-67078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9A6842038
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE3E1C214EF
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB40566B49;
	Tue, 30 Jan 2024 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="krMg7uNb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389D066B24
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608443; cv=none; b=iWF5nS1fnl3A1ZxUvn/B3BrVM8j1bQ8xHy8rhruUh80sgYRMlnwCnTRiy5fY/pVufpLP2PambUOioTB5YZvqAfvlUYnwujSpEp0c9kzOikT30PIo6skxF3Y0NvBg79SXbXVaJ/1j8v0w4WvnMmcoxqrd7MefhcsGARBT6WNft9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608443; c=relaxed/simple;
	bh=2YhXRM31uQlb+YotBMY81xTfdWe3dz1ueIazkZ1RBUY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LrypsOmw4lHctd0LwEEZChpOHGySSS53cblaEEiM1R8FUhTEOEqfeGLyuqFAKP1NRh/GMQiLktUzYnJz0hXLSv5a9yX+VG2y+l2qG/r++sG0vMho8N6BCsvmz0xmI0HORUeiw9L/27pYsaFKqCmL69JJ0zthQeoFYRs8c1FYTDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=krMg7uNb; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706608442; x=1738144442;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y9HPxUEtClAdks6AaPfxR3O9DWlyepl71/VGZjaLuhw=;
  b=krMg7uNb28OEK6NjNKa8pW65KMVn6z8AANlpcI8ZDWPPZ5UUXZAc01iu
   csKPt5+jq5YxsidIPxPEAIX7tUfamQrwPms5rtSx3pkRUA5ZgGXoZcFNZ
   vWRq+/Q+xqfAFv1PTuoC7tcAsevIUCaBU1JNV/H59C/hw4O7e+cGoYKsv
   s=;
X-IronPort-AV: E=Sophos;i="6.05,707,1701129600"; 
   d="scan'208";a="270507041"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:54:00 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id BF8744B0F3;
	Tue, 30 Jan 2024 09:53:58 +0000 (UTC)
Received: from EX19MTAUEC002.ant.amazon.com [10.0.29.78:35738]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.46.110:2525] with esmtp (Farcaster)
 id 60c4519d-4cf0-4b3f-9b50-72c70705748a; Tue, 30 Jan 2024 09:53:58 +0000 (UTC)
X-Farcaster-Flow-ID: 60c4519d-4cf0-4b3f-9b50-72c70705748a
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:53:57 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:53:57 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Tue, 30 Jan 2024 09:53:55
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
Subject: [PATCH v2 net-next 00/11] ENA driver changes
Date: Tue, 30 Jan 2024 09:53:42 +0000
Message-ID: <20240130095353.2881-1-darinzon@amazon.com>
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

Changes from v1:
- Address comments from Shannon Nelson

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
 drivers/net/ethernet/amazon/ena/ena_com.h     |   7 +-
 drivers/net/ethernet/amazon/ena/ena_eth_com.c |  49 ++-
 drivers/net/ethernet/amazon/ena/ena_eth_com.h |  39 +--
 drivers/net/ethernet/amazon/ena/ena_netdev.c  | 161 ++++++---
 .../net/ethernet/amazon/ena/ena_regs_defs.h   |   1 +
 drivers/net/ethernet/amazon/ena/ena_xdp.c     |   1 -
 8 files changed, 258 insertions(+), 329 deletions(-)

-- 
2.40.1


