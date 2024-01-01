Return-Path: <netdev+bounces-60700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FC18213E6
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 15:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E4A1C20A36
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 14:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE81D3C39;
	Mon,  1 Jan 2024 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Oq65X8IU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7465546AD
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704118057; x=1735654057;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D7cJ5v9awK/e8jSf3taXhspo1mpZLE7NFl2SHUsOAJ4=;
  b=Oq65X8IUyZqdqBtxa3YKMNB9nNvzjuM0m0ulIsBW9ySeEc4seChRcmED
   PHWu5ZhxipP0blo03o0zhj7AaDpdDRoB/En7liXeagIOoVBk+feaBVqfM
   Fa+WZWcKZRxEFCmpNkkaN25Th9pLoZAl1Mrc5FYA8MoC3jpLg8s+hV/wH
   M=;
X-IronPort-AV: E=Sophos;i="6.04,322,1695686400"; 
   d="scan'208";a="319661552"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 14:07:31 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix) with ESMTPS id 02E8980461;
	Mon,  1 Jan 2024 14:07:29 +0000 (UTC)
Received: from EX19MTAUEC001.ant.amazon.com [10.0.0.204:38284]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.57.126:2525] with esmtp (Farcaster)
 id 7114b63c-a2d8-41e8-9b5b-69ed7ed49476; Mon, 1 Jan 2024 14:07:29 +0000 (UTC)
X-Farcaster-Flow-ID: 7114b63c-a2d8-41e8-9b5b-69ed7ed49476
Received: from EX19D008UEA003.ant.amazon.com (10.252.134.116) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 14:07:29 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D008UEA003.ant.amazon.com (10.252.134.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 14:07:28 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 1 Jan 2024 14:07:27 +0000
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
Subject: [PATCH v1 net-next 00/11] ENA driver XDP changes
Date: Mon, 1 Jan 2024 14:07:13 +0000
Message-ID: <20240101140724.26232-1-darinzon@amazon.com>
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

This patchset contains multiple XDP-related changes
in the ENA driver, including moving the XDP code to
dedicated files.

David Arinzon (11):
  net: ena: Move XDP code to its new files
  net: ena: Pass ena_adapter instead of net_device to ena_xmit_common()
  net: ena: Put orthogonal fields in ena_tx_buffer in a union
  net: ena: Introduce total_tx_size field in ena_tx_buffer struct
  net: ena: Use tx_ring instead of xdp_ring for XDP channel TX
  net: ena: Don't check if XDP program is loaded in ena_xdp_execute()
  net: ena: Refactor napi functions
  net: ena: Add more debug prints to XDP related function
  net: ena: Always register RX queue info
  net: ena: Make queue stats code cleaner by removing the if block
  net: ena: Take xdp packets stats into account in ena_get_stats64()

 .../device_drivers/ethernet/amazon/ena.rst    |   1 +
 drivers/net/ethernet/amazon/ena/Makefile      |   2 +-
 drivers/net/ethernet/amazon/ena/ena_ethtool.c |  18 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c  | 689 ++----------------
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |  99 ++-
 drivers/net/ethernet/amazon/ena/ena_xdp.c     | 468 ++++++++++++
 drivers/net/ethernet/amazon/ena/ena_xdp.h     | 151 ++++
 7 files changed, 736 insertions(+), 692 deletions(-)
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_xdp.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_xdp.h

-- 
2.40.1


