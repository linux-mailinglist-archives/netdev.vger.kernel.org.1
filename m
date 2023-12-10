Return-Path: <netdev+bounces-55596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB63980B9DF
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 09:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC851F20FAF
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 08:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070635388;
	Sun, 10 Dec 2023 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ROi4yhSz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D06DF
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 00:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702197080; x=1733733080;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Lk7GT1pkouwxpGcT8s3iz1vgQXqUrHtgsNi4Sx9dJNI=;
  b=ROi4yhSzr0X/Tlmp2o9qdFzChUOLSZcVKIqUIYSvuGSapV9sgilCmNVI
   qbWqC5cpg+Tyq3XL/dP02y0cciFc858KdHVPpAxOeDhsyz5KklSDKiuO/
   /TfwwX18s0vOfU2qoqRdFvJY3m5Gk7lThxBjVECuZx1cL4XpxCmEkI5Dg
   0=;
X-IronPort-AV: E=Sophos;i="6.04,265,1695686400"; 
   d="scan'208";a="171041489"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 08:31:18 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com (Postfix) with ESMTPS id EB58482964;
	Sun, 10 Dec 2023 08:31:16 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:62125]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.170:2525] with esmtp (Farcaster)
 id 5d295eb0-6523-4669-b0fb-896e3ca4bac9; Sun, 10 Dec 2023 08:31:16 +0000 (UTC)
X-Farcaster-Flow-ID: 5d295eb0-6523-4669-b0fb-896e3ca4bac9
Received: from EX19D010UWB003.ant.amazon.com (10.13.138.81) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 10 Dec 2023 08:31:16 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D010UWB003.ant.amazon.com (10.13.138.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 10 Dec 2023 08:31:15 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Sun, 10 Dec 2023 08:31:13
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
Subject: [PATCH v1 net 0/4] ENA driver XDP bug fixes
Date: Sun, 10 Dec 2023 08:30:52 +0000
Message-ID: <20231210083056.30357-1-darinzon@amazon.com>
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

This patchset contains multiple XDP-related bug fixes
in the ENA driver.

David Arinzon (4):
  net: ena: Destroy correct number of xdp queues upon failure
  net: ena: Fix xdp drops handling due to multibuf packets
  net: ena: Fix DMA syncing in XDP path when SWIOTLB is on
  net: ena: Fix XDP redirection error

 drivers/net/ethernet/amazon/ena/ena_eth_com.c |  3 --
 drivers/net/ethernet/amazon/ena/ena_netdev.c  | 53 +++++++++----------
 2 files changed, 26 insertions(+), 30 deletions(-)

-- 
2.40.1


