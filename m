Return-Path: <netdev+bounces-60739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A64821522
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 20:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262EE281D6D
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE18DD530;
	Mon,  1 Jan 2024 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LxnvVKn9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EAEDDA0
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704136175; x=1735672175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N5Sb/yCDpP8VXxDVpdf7Ob9o+dhbHUQyN+8AhuSuvUE=;
  b=LxnvVKn9F8ezt5hIhn2ho8zUC1Z5iZB8cRtumvP7fs+tyB3U7Af+R4ey
   48qc3nLhyU5J9kfNiROm6952ndx3v8M9G5lnFClN6wGDI4QQGOyyKXf4Y
   1SlZ9LSswFzHhHMebX4jOPxYaFHJlgTyvyeW68YhZhNVGcwK/lwMuil9q
   o=;
X-IronPort-AV: E=Sophos;i="6.04,322,1695686400"; 
   d="scan'208";a="175422727"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 19:09:34 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix) with ESMTPS id 03DC4A0DE8;
	Mon,  1 Jan 2024 19:09:32 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:7102]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.123:2525] with esmtp (Farcaster)
 id 67bccd41-d525-4131-a72f-850dc2f140a3; Mon, 1 Jan 2024 19:09:31 +0000 (UTC)
X-Farcaster-Flow-ID: 67bccd41-d525-4131-a72f-850dc2f140a3
Received: from EX19D010UWB003.ant.amazon.com (10.13.138.81) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 19:09:31 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D010UWB003.ant.amazon.com (10.13.138.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 19:09:31 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 1 Jan 2024 19:09:28 +0000
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
Subject: [PATCH v2 net-next 06/11] net: ena: Don't check if XDP program is loaded in ena_xdp_execute()
Date: Mon, 1 Jan 2024 19:08:50 +0000
Message-ID: <20240101190855.18739-7-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240101190855.18739-1-darinzon@amazon.com>
References: <20240101190855.18739-1-darinzon@amazon.com>
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

This check is already done in ena_clean_rx_irq() which indirectly
calls it.
This function is called in napi context and the driver doesn't
allow to change the XDP program without performing destruction and
reinitialization of napi context (part of ena_down/ena_up sequence).

Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_xdp.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_xdp.h b/drivers/net/ethernet/amazon/ena/ena_xdp.h
index 3fa8e80..25204fb 100644
--- a/drivers/net/ethernet/amazon/ena/ena_xdp.h
+++ b/drivers/net/ethernet/amazon/ena/ena_xdp.h
@@ -87,9 +87,6 @@ static inline int ena_xdp_execute(struct ena_ring *rx_ring, struct xdp_buff *xdp
 
 	xdp_prog = READ_ONCE(rx_ring->xdp_bpf_prog);
 
-	if (!xdp_prog)
-		return verdict;
-
 	verdict = bpf_prog_run_xdp(xdp_prog, xdp);
 
 	switch (verdict) {
-- 
2.40.1


