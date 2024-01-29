Return-Path: <netdev+bounces-66634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF598400AB
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 09:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD85A1C22374
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 08:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD1754BF3;
	Mon, 29 Jan 2024 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GpB1xCQ8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45C854BF5
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518561; cv=none; b=tVv51xlWcL5JtRDMnmCfP8uVBApY83TRk4w4JfBKHuT61z3/cLLSltdYpeXpzJCiSatcdEnacrzTfYFMWqWhBKp6Vyhn5dzf+1bHFAUKTU7ApsAf36RONi5oDJZ/isC2qyR04CbU8Xp3eoVTs6d/N3Sl9dY/+50TE5l3/dv6OSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518561; c=relaxed/simple;
	bh=tc884OSP1l5KwudD90FZD+f02qv4O+U7umLknapxXD8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYbYEmR+5iy3GppJ0hWDaSk+lopTAVusW2hk/4puFRfsplhFBm4aIHlJd3AFjRCKZuPO9vl/LaQR215j7iT2yvmb07xlCdoFVYfsuRUp1U1CrwPxOmsxb9ddlnLmp94dbbYV6CGbsCaoGD+a7Xtirm9OybHGxCJMC8uUUmCv0WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GpB1xCQ8; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706518560; x=1738054560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oj3xul//fd9knzMKifIN8C8QFDz93xbRDYm88s9cUhM=;
  b=GpB1xCQ8pMvFZ8nsWFnA1Y7BXltlUZCQMWUgjRo00j2NDhFmWcxivqFR
   KDp9RZN8yTCzx2LUC4LyHp0PCvlDKzRVGT30e8+YsqEKCyfF0/FKo2DLr
   S6Cmqj+dke7GKoa45+oby4+NtxCX4XsxDehbcs4EE2dAE8K5kdDbWIm1/
   g=;
X-IronPort-AV: E=Sophos;i="6.05,226,1701129600"; 
   d="scan'208";a="630522338"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 08:55:58 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix) with ESMTPS id 59F22A415D;
	Mon, 29 Jan 2024 08:55:57 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:62491]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.214:2525] with esmtp (Farcaster)
 id 353d8de5-68f6-4b6b-bb48-23efd940bd01; Mon, 29 Jan 2024 08:55:56 +0000 (UTC)
X-Farcaster-Flow-ID: 353d8de5-68f6-4b6b-bb48-23efd940bd01
Received: from EX19D010UWA002.ant.amazon.com (10.13.138.242) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:55:56 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D010UWA002.ant.amazon.com (10.13.138.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:55:55 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 08:55:52
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
Subject: [PATCH v1 net-next 04/11] net: ena: Enable DIM by default
Date: Mon, 29 Jan 2024 08:55:24 +0000
Message-ID: <20240129085531.15608-5-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240129085531.15608-1-darinzon@amazon.com>
References: <20240129085531.15608-1-darinzon@amazon.com>
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


