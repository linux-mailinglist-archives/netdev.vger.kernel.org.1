Return-Path: <netdev+bounces-146786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAC19D5D34
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 11:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27F65B22803
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 10:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EE51DE8B5;
	Fri, 22 Nov 2024 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XAsBPS+0"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B66B1DE4E6;
	Fri, 22 Nov 2024 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270933; cv=none; b=HmKtl6xun75JVJT4ydDh8oC1OhSXMkzLb4X2eDHQdwlTIZs4zgWp3Zjugu9gjzxVTojQl1rjkjuV/AiKh1m1R9zDqgCctFsLSX4f5Bfv973PEgwLmXOJJu2X279zeFpw6spLgdDL23xetjxdpBU+s4kJ3aQB2h3ywKLkL9WXx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270933; c=relaxed/simple;
	bh=C+YRHsOFK1u/oM6alxv8SMlBUc3rKX/6KNGEi7ylCKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGWlX4w3AK9wwSskKF95WebpDJ7wntaSLHmtBynkrdmJn7dp0BZIVpO+OJSE09V+rPluiFLCtHJrkaufGivpg1VrrBUlp6Mq0ctwbb1FTGk8mRF9/auu0MXx4bAOSN9bwI6XWzfSdSMIfCv2R+sG33N6y5tkYvIGaX5wf5BLup0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XAsBPS+0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732270932; x=1763806932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C+YRHsOFK1u/oM6alxv8SMlBUc3rKX/6KNGEi7ylCKU=;
  b=XAsBPS+0Te4Sqcw+LiWZlf61EgSqOpVNUo9O7JUcUMSmMC/D8O4x24z3
   lwUuKR8mIhYFZizmvSOeKkexVOuuCirbecO00azJd2mwCuF89DSC4kKE5
   2H1XJ10Rba7rKrQ96ouAN1YcdMJbVta1s08GXkb3RzpzcwjixDly/2Kx3
   SHMNOW9UV3pvkJgnhxYHCYrxdWPB6/s5iC+dMgxZJNGRlkLm3yv18fBRT
   o+eAqVfVF3DV33a1ZEg9pfo67iWvQdUDaWLOlGrDUwz5hlh/lH9h423Tz
   YPLaPoEF73RSpBLeXqNcFJvsu+LamrwGaui4Qjw++y15IDFWvsipwX+Yk
   Q==;
X-CSE-ConnectionGUID: MRSRvnTqSAqJLUuhxew2Xw==
X-CSE-MsgGUID: aygkIvAuRYqzHSOhFR2QSw==
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="38251716"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Nov 2024 03:22:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Nov 2024 03:21:50 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 22 Nov 2024 03:21:47 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <parthiban.veerasooran@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<jacob.e.keller@intel.com>
Subject: [PATCH net v2 2/2] net: ethernet: oa_tc6: fix tx skb race condition between reference pointers
Date: Fri, 22 Nov 2024 15:51:35 +0530
Message-ID: <20241122102135.428272-3-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122102135.428272-1-parthiban.veerasooran@microchip.com>
References: <20241122102135.428272-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

There are two skb pointers to manage tx skb's enqueued from n/w stack.
waiting_tx_skb pointer points to the tx skb which needs to be processed
and ongoing_tx_skb pointer points to the tx skb which is being processed.

SPI thread prepares the tx data chunks from the tx skb pointed by the
ongoing_tx_skb pointer. When the tx skb pointed by the ongoing_tx_skb is
processed, the tx skb pointed by the waiting_tx_skb is assigned to
ongoing_tx_skb and the waiting_tx_skb pointer is assigned with NULL.
Whenever there is a new tx skb from n/w stack, it will be assigned to
waiting_tx_skb pointer if it is NULL. Enqueuing and processing of a tx skb
handled in two different threads.

Consider a scenario where the SPI thread processed an ongoing_tx_skb and
it moves next tx skb from waiting_tx_skb pointer to ongoing_tx_skb pointer
without doing any NULL check. At this time, if the waiting_tx_skb pointer
is NULL then ongoing_tx_skb pointer is also assigned with NULL. After
that, if a new tx skb is assigned to waiting_tx_skb pointer by the n/w
stack and there is a chance to overwrite the tx skb pointer with NULL in
the SPI thread. Finally one of the tx skb will be left as unhandled,
resulting packet missing and memory leak.

To overcome the above issue, protect the moving of tx skb reference from
waiting_tx_skb pointer to ongoing_tx_skb pointer so that the other thread
can't access the waiting_tx_skb pointer until the current thread completes
moving the tx skb reference safely.

Fixes: 53fbde8ab21e ("net: ethernet: oa_tc6: implement transmit path to transfer tx ethernet frames")
Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 4c8b0ca922b7..2ddb1faafe55 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -113,6 +113,7 @@ struct oa_tc6 {
 	struct mii_bus *mdiobus;
 	struct spi_device *spi;
 	struct mutex spi_ctrl_lock; /* Protects spi control transfer */
+	struct mutex tx_skb_lock; /* Protects tx skb handling */
 	void *spi_ctrl_tx_buf;
 	void *spi_ctrl_rx_buf;
 	void *spi_data_tx_buf;
@@ -1004,8 +1005,10 @@ static u16 oa_tc6_prepare_spi_tx_buf_for_tx_skbs(struct oa_tc6 *tc6)
 	for (used_tx_credits = 0; used_tx_credits < tc6->tx_credits;
 	     used_tx_credits++) {
 		if (!tc6->ongoing_tx_skb) {
+			mutex_lock(&tc6->tx_skb_lock);
 			tc6->ongoing_tx_skb = tc6->waiting_tx_skb;
 			tc6->waiting_tx_skb = NULL;
+			mutex_unlock(&tc6->tx_skb_lock);
 		}
 		if (!tc6->ongoing_tx_skb)
 			break;
@@ -1240,6 +1243,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 	tc6->netdev = netdev;
 	SET_NETDEV_DEV(netdev, &spi->dev);
 	mutex_init(&tc6->spi_ctrl_lock);
+	mutex_init(&tc6->tx_skb_lock);
 
 	/* Set the SPI controller to pump at realtime priority */
 	tc6->spi->rt = true;
-- 
2.34.1


