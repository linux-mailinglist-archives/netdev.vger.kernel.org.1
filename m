Return-Path: <netdev+bounces-124242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFFF968A79
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14011F225B3
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F222139A6;
	Mon,  2 Sep 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cqSc7JI5"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0871C62CA;
	Mon,  2 Sep 2024 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288935; cv=none; b=PJSYMPhZT2m1qmIZFwQvUmRsEnaIgAt3+tIp+LVbfPVuVPH5N3Xy2Jsa5QSx0fpWXEBz6KmsangjvdlpebIq2NjX9HqfyBDzuL8t5WtBvJmki0M/ij3d98Xox1bhMZWUHYX/yfflx3YtpxNnADCSE1bZtGM7uut7iOxiVMS/OYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288935; c=relaxed/simple;
	bh=xRg5RV5ook/I7L7TEqs4RihaENNMpGqSI1p9RqlWG78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=sAyWop3D06WeUb1iJjtBqzOEiRSC/Rj401A0yZVBz3Xw+BSQQ0/nG0SCAeXsIOW+no0mA5ETJLa6BhDljW0xdlnEuOxGx1Kxwe1+xs+eJMTLJqd/Vv/hnH30u4t9rEqxOS72YsgXDigFWjkqzWHJ/IxbWfGwgOvUFfiF0Ie5iLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cqSc7JI5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725288933; x=1756824933;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xRg5RV5ook/I7L7TEqs4RihaENNMpGqSI1p9RqlWG78=;
  b=cqSc7JI5OL27L4zNhOPOZT/uhCnDx1GOA7+fbh+wqalxfVm8Ytdpc8Qy
   /s9md0Z2Qc/DXPdiE3ZwUVOzChwyZ7LK51k3iWicblcbOjZox0UBGONOR
   bRPKdulYxHB3cNzFNB6DxFi6XD3oAg5f+hmdDhC4Af//vwznmzE5KCdpH
   nS2dgDRqIwUxWpj2EcAD3Fz3b+fzt01Ef8G8bj55IOSPeY1kfg1fKVBXf
   ttgPVu0VnkDJG9aT5VVk+yNWC6hZJdX8dSmfUbgIRJFF+FfjCf1bympK7
   eMpTkXI8iDQgvYEjSFwSq5lInPOabeu+637roFxkPo9ZNpfBx7dDNFDzP
   Q==;
X-CSE-ConnectionGUID: 6WD2x+lUSXKxeZe2mffqQA==
X-CSE-MsgGUID: RqWNjkf+SjaOBDncqe/Qpg==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="31128333"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 07:55:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 07:55:08 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 2 Sep 2024 07:55:05 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 2 Sep 2024 16:54:17 +0200
Subject: [PATCH net-next 12/12] net: sparx5: ditch
 sparx5_fdma_rx/tx_reload() functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240902-fdma-sparx5-v1-12-1e7d5e5a9f34@microchip.com>
References: <20240902-fdma-sparx5-v1-0-1e7d5e5a9f34@microchip.com>
In-Reply-To: <20240902-fdma-sparx5-v1-0-1e7d5e5a9f34@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<rdunlap@infradead.org>, <horms@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.14-dev

These direction specific functions can be ditched in favor of a single
function: sparx5_fdma_reload(), which retrieves the channel id from the
fdma struct instead.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 7e1bdd0344d0..61df874b7623 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -133,16 +133,10 @@ static void sparx5_fdma_tx_deactivate(struct sparx5 *sparx5, struct sparx5_tx *t
 		 sparx5, FDMA_CH_ACTIVATE);
 }
 
-static void sparx5_fdma_rx_reload(struct sparx5 *sparx5, struct sparx5_rx *rx)
+static void sparx5_fdma_reload(struct sparx5 *sparx5, struct fdma *fdma)
 {
 	/* Reload the RX channel */
-	spx5_wr(BIT(rx->fdma.channel_id), sparx5, FDMA_CH_RELOAD);
-}
-
-static void sparx5_fdma_tx_reload(struct sparx5 *sparx5, struct sparx5_tx *tx)
-{
-	/* Reload the TX channel */
-	spx5_wr(BIT(tx->fdma.channel_id), sparx5, FDMA_CH_RELOAD);
+	spx5_wr(BIT(fdma->channel_id), sparx5, FDMA_CH_RELOAD);
 }
 
 static bool sparx5_fdma_rx_get_frame(struct sparx5 *sparx5, struct sparx5_rx *rx)
@@ -213,7 +207,7 @@ static int sparx5_fdma_napi_callback(struct napi_struct *napi, int weight)
 			 sparx5, FDMA_INTR_DB_ENA);
 	}
 	if (counter)
-		sparx5_fdma_rx_reload(sparx5, rx);
+		sparx5_fdma_reload(sparx5, fdma);
 	return counter;
 }
 
@@ -246,7 +240,7 @@ int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb)
 		sparx5_fdma_tx_activate(sparx5, tx);
 		first_time = false;
 	} else {
-		sparx5_fdma_tx_reload(sparx5, tx);
+		sparx5_fdma_reload(sparx5, fdma);
 	}
 	return NETDEV_TX_OK;
 }

-- 
2.34.1


