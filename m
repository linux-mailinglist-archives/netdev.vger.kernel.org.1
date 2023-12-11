Return-Path: <netdev+bounces-55721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFA380C14F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 07:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A25FB20801
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 06:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FE81F5FC;
	Mon, 11 Dec 2023 06:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tw4IncrT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E32CD
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 22:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702276095; x=1733812095;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hlgpyZ9au5E9dtzzKBVBju0852fwEYRub5KSI8EFO6k=;
  b=tw4IncrTFrLbFEQbFP8fzKiiLb2qxpVXsIZZy5iXY0b/A6LUwK/m0f1a
   rKAD5oFUaZEU+F4++TRo3zLAge4yNIcvVG6hPe8npmNRxX1jAtquznmSp
   DQSRWMUF0HIELckXYwvs58Ba+NhuhvtrtxZf9dD1ZA7Mpz5Q5uEKS5io8
   U=;
X-IronPort-AV: E=Sophos;i="6.04,267,1695686400"; 
   d="scan'208";a="258123741"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 06:28:13 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix) with ESMTPS id B451440D52;
	Mon, 11 Dec 2023 06:28:12 +0000 (UTC)
Received: from EX19MTAUEA001.ant.amazon.com [10.0.44.209:51980]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.54.31:2525] with esmtp (Farcaster)
 id a1b7aef5-9783-47eb-90f2-4d0e00ecfc2a; Mon, 11 Dec 2023 06:28:11 +0000 (UTC)
X-Farcaster-Flow-ID: a1b7aef5-9783-47eb-90f2-4d0e00ecfc2a
Received: from EX19D008UEA003.ant.amazon.com (10.252.134.116) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 06:28:11 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA003.ant.amazon.com (10.252.134.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 06:28:10 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 11 Dec 2023 06:28:09
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
	<evostrov@amazon.com>, Sameeh Jubran <sameehj@amazon.com>
Subject: [PATCH v2 net 0/4] ENA driver XDP bug fixes
Date: Mon, 11 Dec 2023 06:27:57 +0000
Message-ID: <20231211062801.27891-1-darinzon@amazon.com>
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

Changes in v2:
- Added missing Signed-off-by as well as relevant Cc.

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


