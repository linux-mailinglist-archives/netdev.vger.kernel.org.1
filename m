Return-Path: <netdev+bounces-60734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C22A382151D
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 20:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A285281ADD
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 19:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95E1D529;
	Mon,  1 Jan 2024 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="W0DE8TXc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6F8D527
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704136142; x=1735672142;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5WnHdauGnjp6VGAOHDDlapMKEyUJH/dd8OjE2zqBZi8=;
  b=W0DE8TXcdQGZI7MIzfH18jEjQ7G1Q7ac9OQHbH3rs2Pj/W4MSXJNIKQ8
   p0ve4y8OUgU7CKhfsORFRRlV6IKxJC2nu9Q/63P/JMfrxNnKwX/OuLuDE
   yM6vbT8DfM0P89PRaBXnl28aU6nMeUfTBS/Se99uVCeWp3j8hA+7pDjqo
   0=;
X-IronPort-AV: E=Sophos;i="6.04,322,1695686400"; 
   d="scan'208";a="175422709"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 19:09:00 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com (Postfix) with ESMTPS id CC3321A0058;
	Mon,  1 Jan 2024 19:08:59 +0000 (UTC)
Received: from EX19MTAUEB001.ant.amazon.com [10.0.44.209:34828]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.23.15:2525] with esmtp (Farcaster)
 id c299b1e3-f3e0-41fe-936e-541eaedfb29f; Mon, 1 Jan 2024 19:08:59 +0000 (UTC)
X-Farcaster-Flow-ID: c299b1e3-f3e0-41fe-936e-541eaedfb29f
Received: from EX19D008UEA002.ant.amazon.com (10.252.134.125) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 19:08:59 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D008UEA002.ant.amazon.com (10.252.134.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 19:08:58 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 1 Jan 2024 19:08:57 +0000
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
Subject: [PATCH v2 net-next 00/11] ENA driver XDP changes
Date: Mon, 1 Jan 2024 19:08:44 +0000
Message-ID: <20240101190855.18739-1-darinzon@amazon.com>
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

Changes in v2:
- Moved changes to right commits in order to avoid compilation errors

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


