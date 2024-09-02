Return-Path: <netdev+bounces-124239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DF4968A74
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7259E28368C
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1AA1C62BF;
	Mon,  2 Sep 2024 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jTrw63Sg"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF9D1C62B5;
	Mon,  2 Sep 2024 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288932; cv=none; b=d2WKtbQWxVC26EGUf+xPNdJhUEpOGxiVIV7BIKHOsfyC8JsRor3ja42isLcrzBmSyJV41TdyeFSJprUeYbXCvEraE3Bd7DLUKA0ou7fDWVNEaPQIppYFsAPPWX7Xx5qwCJ6jAZ0kEF2obIvLAxLDiJK6VkXVt/6OD+cP9deTo0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288932; c=relaxed/simple;
	bh=aLG08PxBlNupyF1+ErIPnFVlFIj4PCZ139J4QY9jINA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=e8nY3fEhnoh3SccmWy5VrageljS/sU1DSnR7FiOBsnUpSGsGAnTBxWc7X7N2sauOIma9pKVDB1dGj3UVUyOLc9K48JmWu3jqvX7sLfKn8093z8A2eZSr9K3b/QpnZlmF8XqZLYBN30eRuK5EXSjTE/5elo+LSPMRrUQt6fUMRrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jTrw63Sg; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725288931; x=1756824931;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=aLG08PxBlNupyF1+ErIPnFVlFIj4PCZ139J4QY9jINA=;
  b=jTrw63SgvkUVG2MCGSOqpEEIuogyq93w5cK89/OxQWDGS6tTMZpQ2EMF
   54yjAUEDvBXQNJ1grz7DdQP0lrDysnRi7ODTwgYlEysPUR0R1G/GPQm0T
   tjmO2kQRoUeIbnMmQURpy5bHbYpeLnyDVqQFQ+a36QzLSQ6g+z3pFjnoV
   ja2Ujwy4fGPDWyRy07bnwURFklWJ2l3nocDpw0uBaVqXrej38n2Js3MBO
   KHzN9vnEKCkfh2ybqf5CWvbNlWRPkNeBx7tjU3qqMrMakoMV0OfIY3SNw
   12y79SrvAgfSqPp8L5oXluib6uoRoXgGj4nvIh6hRgNsJbBMZfAPPmK9y
   Q==;
X-CSE-ConnectionGUID: 6WD2x+lUSXKxeZe2mffqQA==
X-CSE-MsgGUID: K0Bz7V1LTx6WDCI2utsLfg==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="31128324"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 07:55:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 07:55:00 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 2 Sep 2024 07:54:58 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 2 Sep 2024 16:54:14 +0200
Subject: [PATCH net-next 09/12] net: sparx5: use FDMA library for adding
 DCB's in the tx path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240902-fdma-sparx5-v1-9-1e7d5e5a9f34@microchip.com>
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

Use the fdma_dcb_add() function to add DCB's in the tx path. This gets
rid of the open-coding of nextptr and dataptr handling and leaves it to
the library.

Also, make sure the fdma indexes are advanced using: fdma_dcb_advance(),
so that the correct nextptr and dataptr offsets are retrieved.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    | 39 +++++-----------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 8f721f7671ce..4fc52140752a 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -231,48 +231,27 @@ static int sparx5_fdma_napi_callback(struct napi_struct *napi, int weight)
 	return counter;
 }
 
-static struct fdma_dcb *sparx5_fdma_next_dcb(struct sparx5_tx *tx,
-					     struct fdma_dcb *dcb)
-{
-	struct fdma_dcb *next_dcb;
-	struct fdma *fdma = &tx->fdma;
-
-	next_dcb = dcb;
-	next_dcb++;
-	/* Handle wrap-around */
-	if ((unsigned long)next_dcb >=
-	    ((unsigned long)fdma->dcbs + fdma->n_dcbs * sizeof(*dcb)))
-		next_dcb = fdma->dcbs;
-	return next_dcb;
-}
-
 int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb)
 {
 	struct sparx5_tx *tx = &sparx5->tx;
 	struct fdma *fdma = &tx->fdma;
 	static bool first_time = true;
-	struct fdma_dcb *next_dcb_hw;
-	struct fdma_db *db_hw;
 	struct sparx5_db *db;
 
-	next_dcb_hw = sparx5_fdma_next_dcb(tx, fdma->last_dcb);
-	db_hw = &next_dcb_hw->db[0];
-	if (!(db_hw->status & FDMA_DCB_STATUS_DONE))
+	fdma_dcb_advance(fdma);
+	if (!fdma_db_is_done(fdma_db_get(fdma, fdma->dcb_index, 0)))
 		return -EINVAL;
 	db = list_first_entry(&tx->db_list, struct sparx5_db, list);
-	list_move_tail(&db->list, &tx->db_list);
-	next_dcb_hw->nextptr = FDMA_DCB_INVALID_DATA;
-	fdma->last_dcb->nextptr = fdma->dma +
-		((unsigned long)next_dcb_hw -
-		(unsigned long)fdma->dcbs);
-	fdma->last_dcb = next_dcb_hw;
 	memset(db->cpu_addr, 0, FDMA_XTR_BUFFER_SIZE);
 	memcpy(db->cpu_addr, ifh, IFH_LEN * 4);
 	memcpy(db->cpu_addr + IFH_LEN * 4, skb->data, skb->len);
-	db_hw->status = FDMA_DCB_STATUS_SOF |
-			FDMA_DCB_STATUS_EOF |
-			FDMA_DCB_STATUS_BLOCKO(0) |
-			FDMA_DCB_STATUS_BLOCKL(skb->len + IFH_LEN * 4 + 4);
+
+	fdma_dcb_add(fdma, fdma->dcb_index, 0,
+		     FDMA_DCB_STATUS_SOF |
+		     FDMA_DCB_STATUS_EOF |
+		     FDMA_DCB_STATUS_BLOCKO(0) |
+		     FDMA_DCB_STATUS_BLOCKL(skb->len + IFH_LEN * 4 + 4));
+
 	if (first_time) {
 		sparx5_fdma_tx_activate(sparx5, tx);
 		first_time = false;

-- 
2.34.1


