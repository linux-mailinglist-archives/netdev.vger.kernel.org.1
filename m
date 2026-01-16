Return-Path: <netdev+bounces-250491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0388D2EE30
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 10:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38EA6303E0C3
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DF73587AB;
	Fri, 16 Jan 2026 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=horizon.auto header.i=@horizon.auto header.b="VmTeKKYY"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw03.horizon.ai (mailgw03.horizon.ai [42.62.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206B23587A1
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.62.85.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768556399; cv=none; b=RzhZWUsMINNLBpT+COVAc9Os0vqteIwQZLB51+VSQgHwHNmNRt1t5ZzFCBiv1JNEa6q+8UGyMlA7qqnylDtlRluODMLg0/yOnWDEqoq101L7xea34lC2OXN9PKZfgfaes2cjkmh2MX9b33DqNPalaplovWDDJOnYlHig1s9RC24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768556399; c=relaxed/simple;
	bh=a4gfC11GKOCqy9sxLvnmGbXidmAXWWeVuphhN34RDLA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RqnpypEj0o5G7+wTHsmwzlsa3YmVJMdTGSGqVYRDtRw2sBn/RqjYE2hRnqWFTYuzX/EcIGHVSZ1kgoO6NOtrVIrWHDbPCTusN8ZLlo4qIxb/N4KvhPP1G1SEh+H39eTzyn5G37NjyvOxWKNudD958K19ZsUOr1zJoClwUoZrUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto; spf=pass smtp.mailfrom=horizon.auto; dkim=pass (1024-bit key) header.d=horizon.auto header.i=@horizon.auto header.b=VmTeKKYY; arc=none smtp.client-ip=42.62.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horizon.auto
DKIM-Signature: v=1; a=rsa-sha256; d=horizon.auto; s=horizonauto; c=relaxed/simple;
	q=dns/txt; i=@horizon.auto; t=1768556386; x=2632469986;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a4gfC11GKOCqy9sxLvnmGbXidmAXWWeVuphhN34RDLA=;
	b=VmTeKKYYbQZ/V14t568JLOTRp+3Rz3NThRX7O4qfzDpIVCkOsRJmBZXIFuDKL3o+
	02IRYptJWbLqsoKLCCPgDbbBQAMdwe8AVHBR5PnTbqtezZPHXuymobWbCqwI7o5v
	1FqbzWhkyQ1i7RLa+yIGsUJB4uf/mPefF6HVVHNeUo0=;
X-AuditID: 0a0901b2-dfddb70000001406-f6-696a07629f97
Received: from mailgw03.horizon.ai ( [10.69.1.10])
	by mailgw03.horizon.ai (Anti-spam for msg) with SMTP id BB.6D.05126.2670A696; Fri, 16 Jan 2026 17:39:46 +0800 (HKT)
Received: from wangtao-VirtualBox.hobot.cc (10.9.0.252) by
 exchange003.hobot.cc (10.69.1.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.27; Fri, 16 Jan 2026
 17:39:45 +0800
From: Tao Wang <tao03.wang@horizon.auto>
To: <kuba@kernel.org>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <mcoquelin.stm32@gmail.com>,
	<alexandre.torgue@foss.st.com>, <rmk+kernel@armlinux.org.uk>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Tao Wang
	<tao03.wang@horizon.auto>
Subject: [PATCH net v3] net: stmmac: fix transmit queue timed out after resume for tso
Date: Fri, 16 Jan 2026 17:39:31 +0800
Message-ID: <20260116093931.126457-1-tao03.wang@horizon.auto>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exchange001.hobot.cc (10.9.15.110) To exchange003.hobot.cc
 (10.69.1.10)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LhcmXk0k1iz8o0OP3I3OLny2mMFssf7GC1
	mHO+hcXi6bFH7BaP+k+wWVzY1sdqsbBtCYvF5V1z2CwOTd3LaPHy9TZmi3l/17JaHFsgZvHt
	9BtGi0v9E5kc+DwuX7vI7DFvTbXHlpU3mTye9m9l99g56y67x4JNpR6bVnWyeezc8ZnJ4/2+
	q2wenzfJBXBFcdmkpOZklqUW6dslcGXcf3yOrWA3f8XV++2MDYxtvF2MnBwSAiYSx46tY+xi
	5OIQEljBKLH51n5WCOc5o8TEdRPYQarYBDQk7k69xgKSEBHYwyRx+UUnM0iCWSBVYu/un2C2
	sECYxIT5a1hBbBYBVYlHbeuBbA4OXgFbifMbTSC2yUtcn3KAEcTmFRCUODnzCQvEGHmJ5q2z
	oUZKSBx88QLMFhJQkWg+OZ8doldO4vWG/WwQdozElQcdTBMYBWYhGTULyahZSEYtYGRexSic
	m5iZk15uYKyXkV+UWZWfp5eYuYkRFFWcjJt2MC5Z8FHvECMTB+MhRgkOZiURXt7faZlCvCmJ
	lVWpRfnxRaU5qcWHGKU5WJTEebUV4zKFBNITS1KzU1MLUotgskwcnFINTF5Tw3Tubih8WF3o
	dXZps8aMEkGzSx83v88VrJSPmaCQcn6Pyy+J1nZ1qe2Tm52vRHT6i+241fy57nba7G86iUbh
	DrdFagR7Pz84YTdxWfTxTX+PH11zdj2DebVlYVo481Hnjz0bYrsKf00Uc/xwMOqo9Yl0k/WM
	qWm7s9rY3rJ6fwjuMP9gVVHlf8/5q6W1nbRU65ZNO5qijkh1v79q+bslIdMtZuLOt6dz/6tH
	Nj5fbriEZbfg/Oidpz8+Czrl5vw84v4Kz5qz/f6nFCaniGqfmZj8/sjDPT/eXym0XO7E33Ak
	prJc55jVg4WCPzfwzzmldLRTl13aVrYh/IbCzqwlEybuV7kUuPB28dLanUosxRmJhlrMRcWJ
	AN3aH7EZAwAA

after resume dev_watchdog() message:
"NETDEV WATCHDOG: CPU: x: transmit queue x timed out xx ms"

The trigging scenario is as follows:
When the TSO function sets tx_skbuff_dma[tx_q->cur_tx].last_segment = true,
 and the last_segment value is not cleared in stmmac_free_tx_buffer after
 resume, restarting TSO transmission may incorrectly use
tx_q->tx_skbuff_dma[first_entry].last_segment = true for a new TSO packet.

When the tx queue has timed out, and the emac TX descriptor is as follows:
eth0: 221 [0x0000000876d10dd0]: 0x73660cbe 0x8 0x42 0xb04416a0
eth0: 222 [0x0000000876d10de0]: 0x77731d40 0x8 0x16a0 0x90000000

Descriptor 221 is the TSO header, and descriptor 222 is the TSO payload.
In the tdes3 (0xb04416a0), bit 29 (first descriptor) and bit 28
(last descriptor) of the TSO packet 221 DMA descriptor cannot both be
set to 1 simultaneously. Since descriptor 222 is the actual last
descriptor, failing to set it properly will cause the EMAC DMA to stop
and hang.

To solve the issue, Do not use the last_segment  default value and set
 last_segment to false in stmmac_tso_xmit.

Fixes: c2837423cb54 ("net: stmmac: Rework TX Coalesce logic")
Signed-off-by: Tao Wang <tao03.wang@horizon.auto>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b3730312aeed..1735f1b50a71 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4448,6 +4448,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (dma_mapping_error(priv->device, des))
 		goto dma_map_err;
 
+	tx_q->tx_skbuff_dma[first_entry].last_segment = false;
 	stmmac_set_desc_addr(priv, first, des);
 	stmmac_tso_allocator(priv, des + proto_hdr_len, pay_len,
 			     (nfrags == 0), queue);
-- 
2.52.0


