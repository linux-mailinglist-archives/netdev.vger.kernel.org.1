Return-Path: <netdev+bounces-67083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26477842046
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F701C23B51
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA6E6A33D;
	Tue, 30 Jan 2024 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fpYTEVlr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15D76A333
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608473; cv=none; b=V7P5+G4MJdblCPvgL07Sj4+BRNTCcMbpFALaoB2mP4K1cXS/hdcgKcdXkXjBIVjjqEIJd7i62+agqSRxDp1BVJcxlXSy8VgeYZVnrdylzQ6TKumJCF0qyiSXmELfueD2w04NVgLEjjPHDhc8XKv69ZxTV1v96UPSDvRPMiBnVKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608473; c=relaxed/simple;
	bh=tc884OSP1l5KwudD90FZD+f02qv4O+U7umLknapxXD8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqCT4UijE8Ih1EijAFBqfYoisD6PBQ7pqzhH1vw/2BNhDJkg/fZnEPejrWMlXkZLB+eB44OQ87juaEwFndnMtzmOcmYN+CMRVqX4IrcPeS25U28+JvmaCb/H9646qPrEcqfMCTUtUzAwRoKfY4MtFJWE28WI7RoysISK7PkIzKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fpYTEVlr; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706608472; x=1738144472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oj3xul//fd9knzMKifIN8C8QFDz93xbRDYm88s9cUhM=;
  b=fpYTEVlrzGx8KG1jULA+vEqC5fBCsN7ULQ77YyzFWqM9jPTKTZlfuxD5
   v91yUp9R6gRymME+GbN1OPPz0I443sGLOiMwzwJxvk4zl7r9vbABVCrsu
   xUMokDm2NbN12AD+D3yIhPueiJo4zEmRrRhTj6y0ZIu44fvI8CQgN8hNd
   4=;
X-IronPort-AV: E=Sophos;i="6.05,707,1701129600"; 
   d="scan'208";a="630821189"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:54:29 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com (Postfix) with ESMTPS id 1039FA0466;
	Tue, 30 Jan 2024 09:54:28 +0000 (UTC)
Received: from EX19MTAUEB002.ant.amazon.com [10.0.0.204:5415]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.32.35:2525] with esmtp (Farcaster)
 id c53ae584-da6b-439e-ade0-b420c1ab517d; Tue, 30 Jan 2024 09:54:27 +0000 (UTC)
X-Farcaster-Flow-ID: c53ae584-da6b-439e-ade0-b420c1ab517d
Received: from EX19D008UEA002.ant.amazon.com (10.252.134.125) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:54:12 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA002.ant.amazon.com (10.252.134.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:54:11 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Tue, 30 Jan 2024 09:54:09
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
Subject: [PATCH v2 net-next 04/11] net: ena: Enable DIM by default
Date: Tue, 30 Jan 2024 09:53:46 +0000
Message-ID: <20240130095353.2881-5-darinzon@amazon.com>
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

Dynamic Interrupt Moderation (DIM) is a technique
designed to balance the need for timely data processing
with the desire to minimize CPU overhead.
Instead of generating an interrupt for every received
packet, the system can dynamically adjust the rate at
which interrupts are generated based on the incoming
traffic patterns.

Enabling DIM by default to improve the user experience.

DIM can be turned on/off through ethtool:
`ethtool -C <interface> adaptive-rx <on/off>`

Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: Osama Abboud <osamaabb@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index d68d081..0b7f94f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2134,6 +2134,12 @@ int ena_up(struct ena_adapter *adapter)
 	 */
 	ena_init_napi_in_range(adapter, 0, io_queue_count);
 
+	/* Enabling DIM needs to happen before enabling IRQs since DIM
+	 * is run from napi routine
+	 */
+	if (ena_com_interrupt_moderation_supported(adapter->ena_dev))
+		ena_com_enable_adaptive_moderation(adapter->ena_dev);
+
 	rc = ena_request_io_irq(adapter);
 	if (rc)
 		goto err_req_irq;
-- 
2.40.1


