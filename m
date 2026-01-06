Return-Path: <netdev+bounces-247351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98350CF8220
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 12:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93F42311F26B
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 11:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B30E3346A1;
	Tue,  6 Jan 2026 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=horizon.auto header.i=@horizon.auto header.b="DM3weNvX"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw03.horizon.ai (mailgw03.horizon.ai [42.62.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF9326945
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.62.85.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699669; cv=none; b=N5l5vxGUQ5S+z5RlkxtQDPxl6bMCTdLIXhOxBOB6/3h3//wH60el3qRjsO3WEzdLUCfDOtv5ZWywG/XKhgC/cyrcCrRtTMxFqiy0gR1KoCgvmYod3UZqgEK9VcT0AderRgOcl+UVqi1EsEG/C2S7vx+lzYZhiBoTO8KlmeNWiWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699669; c=relaxed/simple;
	bh=xLcp7DxkbZIfaB6Im5TqqQSEtZSUIe6oY8JuffNed4A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KIokwRvjD/uvSEtgfMZAyFnkencmLy1di5GoOFbxMPcsjL2ovBaaOsRQDyPa6cSfPGEwoUJLz/KNKJNmu4EzTElxhzRSxwfO1GlAou7WebhkiwgYhup0wYfhfB6KG/eKrKDlIkZykZSCH9Hq0Fyw8UeUW2si4UygxjIIHnoq3cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto; spf=pass smtp.mailfrom=horizon.auto; dkim=pass (1024-bit key) header.d=horizon.auto header.i=@horizon.auto header.b=DM3weNvX; arc=none smtp.client-ip=42.62.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horizon.auto
DKIM-Signature: v=1; a=rsa-sha256; d=horizon.auto; s=horizonauto; c=relaxed/simple;
	q=dns/txt; i=@horizon.auto; t=1767698751; x=2631612351;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xLcp7DxkbZIfaB6Im5TqqQSEtZSUIe6oY8JuffNed4A=;
	b=DM3weNvXtTX0KIlPI74fvz6LW9wWilmod+80qoRbXQlyvydi+VYcxvP2G81KoIMe
	hyE42TslQerdODj6owZbG3SpQy+oAgKyGlOwb9KMyS2iLxmCdAPUJe62QpeI1GvU
	wAMYQJ1bhk360l3wlfvsoc9OD4gTbdFJWZpZLVxoXMQ=;
X-AuditID: 0a0901b2-df5da70000001406-80-695cf13f1dfe
Received: from mailgw03.horizon.ai ( [10.9.15.211])
	by mailgw03.horizon.ai (Anti-spam for msg) with SMTP id 15.A1.05126.F31FC596; Tue,  6 Jan 2026 19:25:51 +0800 (HKT)
Received: from wangtao-VirtualBox.hobot.cc (10.9.0.252) by
 robotics002.hobot.cc (10.9.15.211) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 6 Jan 2026 19:25:50 +0800
From: Tao Wang <tao03.wang@horizon.auto>
To: <andrew+netdev@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>,
	<alexandre.torgue@foss.st.com>, <rmk+kernel@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <0x1207@gmail.com>,
	<netdev@vger.kernel.org>, Tao Wang <tao03.wang@horizon.auto>
Subject: [PATCH] net: stmmac: fix transmit queue timed out after resume
Date: Tue, 6 Jan 2026 19:24:44 +0800
Message-ID: <20260106112444.93951-1-tao03.wang@horizon.auto>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exchange004.hobot.cc (10.9.15.112) To robotics002.hobot.cc
 (10.9.15.211)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsXCxcl/Wdf+Y0ymwe5uGYufL6cxWix/sIPV
	Ys75FhaLC9v6WC1evt7GbHFsgZjFt9NvGC0u9U9kcuDwuHztIrPHvDXVHltW3mTyeNq/ld1j
	06pONo+dOz4zebzfd5XN4/MmuQCOKC6blNSczLLUIn27BK6MR7PusBa8EKzo3biEvYGxk7+L
	kYNDQsBE4klXbBcjF4eQwEpGiQv3LrNAOG8YJZp7TjB2MXJysAloSNydeo0FxBYRkJZYvOYV
	M0gRs8A6Jont/5rAioQF3CUa2zawgdgsAioST/6vYgaxeQVsJKa2TQNrlhCQl9h/8CxUXFDi
	5MwnYHFmoHjz1tnMELaExMEXL8BsIaA5zSfns0P0ykm83rCfDcKOlbi97BnbBEaBWUhGzUIy
	ahaSUQsYmVcxCucmZuaklxsY62XkF2VW5efpJWZuYgTHAeOmHYxLFnzUO8TIxMF4iFGCg1lJ
	hPeVTHSmEG9KYmVValF+fFFpTmrxIUZpDhYlcd7Jed6ZQgLpiSWp2ampBalFMFkmDk6pBqYw
	P9nkIxPO3nKdl883q2dt3C/O+vWKJ3qSkrf+bqsTlTny9sRzryU6Cyq85Xh+/ZyiLrGkq7fw
	z+Fjnq0aTX9P9ORksrUKbA7mbdx9fS/H070+PsUlj3a0mrgmX317NddBw8bw6dbtTkUPjxpL
	zmTSnDR5952QtteZV2KXTH7zqzJgtZNARvyxWQoFnpPOVP5iag60+vjiQPa1NRNtjPzc7k5N
	SBJ8J6TAFHNfRcl1Yv3Vg5JX9/0zfP36ucxH8w1zmiwdy7QPiWgqJkYzS3h/se89/zvryJX4
	hh0HuCb+XbXv5MTmSYLdMjw9iVvSVXeGx1/pX6N0snmSeXNwyLNWdzX7ZxO+mLYLWwien6DE
	UpyRaKjFXFScCADj+9zd8gIAAA==

When the TSO function sets tx_skbuff_dma[tx_q->cur_tx].last_segment = true
, and the last_segment value is not cleared in stmmac_free_tx_buffer after
 resume, restarting TSO transmission may incorrectly use
tx_q->tx_skbuff_dma[first_entry].last_segment = true for a new TSO packet.

after resume dev_watchdog() message:
"NETDEV WATCHDOG: CPU: x: transmit queue x timed out xx ms"

tx ring descriptor info as follows:
eth0: 221 [0x0000000876d10dd0]: 0x73660cbe 0x8 0x42 0xb04416a0
eth0: 222 [0x0000000876d10de0]: 0x77731d40 0x8 0x16a0 0x90000000

Descriptor 221 is the TSO header, and descriptor 222 is the TSO payload.
 In the tdes3 (0xb04416a0), bit 29 (first descriptor) and bit 28
 (last descriptor) of the TSO packet 221 DMA descriptor cannot both be
 set to 1 simultaneously. Since descriptor 222 is the actual last
 descriptor, failing to set it properly will cause the EMAC DMA to stop
 and hang.

To solve the issue, set last_segment to false in stmmac_free_tx_buffer:
tx_q->tx_skbuff_dma[i].last_segment = false;
Set last_segment to false in stmmac_tso_xmit, and do not use the default
 value: tx_q->tx_skbuff_dma[first_entry].last_segment = false;
This will prevent similar issues from occurring in the future.

Signed-off-by: Tao Wang <tao03.wang@horizon.auto>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b3730312aeed..d786ac3c78f7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1653,6 +1653,7 @@ static void stmmac_free_tx_buffer(struct stmmac_priv *priv,
 
 	tx_q->tx_skbuff_dma[i].buf = 0;
 	tx_q->tx_skbuff_dma[i].map_as_page = false;
+	tx_q->tx_skbuff_dma[i].last_segment = false;
 }
 
 /**
@@ -4448,6 +4449,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (dma_mapping_error(priv->device, des))
 		goto dma_map_err;
 
+	tx_q->tx_skbuff_dma[first_entry].last_segment = false;
 	stmmac_set_desc_addr(priv, first, des);
 	stmmac_tso_allocator(priv, des + proto_hdr_len, pay_len,
 			     (nfrags == 0), queue);
-- 
2.34.1


