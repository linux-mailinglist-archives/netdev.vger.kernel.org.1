Return-Path: <netdev+bounces-60706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6F38213EC
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 15:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE71B2144C
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 14:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C361C610B;
	Mon,  1 Jan 2024 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pTpOH4ev"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862356FAF
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704118076; x=1735654076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N5Sb/yCDpP8VXxDVpdf7Ob9o+dhbHUQyN+8AhuSuvUE=;
  b=pTpOH4evso1nK5FClmnCdtQLNX1oHU4U0g+uxvF/GWP2qOBKBkKAOKpE
   vy4g7CEZMVgLCjgeojg76XCIGq2Ckfihk394Rua0Ij+2nuDtWXGqOejzR
   YHUh/rAnaqKldpfv+/6psPFQUKiJiryc9SWI0Hr+VJ1a30EovoFkFOmOA
   8=;
X-IronPort-AV: E=Sophos;i="6.04,322,1695686400"; 
   d="scan'208";a="319661597"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 14:07:55 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com (Postfix) with ESMTPS id C8BA68061D;
	Mon,  1 Jan 2024 14:07:54 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:9816]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.59:2525] with esmtp (Farcaster)
 id 67789d20-54a6-41ec-a811-3a59b7a87797; Mon, 1 Jan 2024 14:07:54 +0000 (UTC)
X-Farcaster-Flow-ID: 67789d20-54a6-41ec-a811-3a59b7a87797
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 14:07:50 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 14:07:50 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 1 Jan 2024 14:07:47 +0000
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
Subject: [PATCH v1 net-next 06/11] net: ena: Don't check if XDP program is loaded in ena_xdp_execute()
Date: Mon, 1 Jan 2024 14:07:19 +0000
Message-ID: <20240101140724.26232-7-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240101140724.26232-1-darinzon@amazon.com>
References: <20240101140724.26232-1-darinzon@amazon.com>
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


