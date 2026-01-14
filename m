Return-Path: <netdev+bounces-249809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D10FD1E485
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 12:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5A4D3000EA0
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E121B395255;
	Wed, 14 Jan 2026 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=horizon.auto header.i=@horizon.auto header.b="jBM9JE5y"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw03.horizon.ai (mailgw03.horizon.ai [42.62.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313FB395264
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.62.85.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768388504; cv=none; b=BtErvT17MVVseOrPGy3z7YnmLgUy+68+X4XZ3NWUQN2zScJmcYEeF8v/hsoTh+J2eQvxplvkV7JrBcrHLYcLBye4Mo4mlzomcrvTYe6/pEUfQQM5XPNROIYW4HJErIaIhxHDTcy6sN0ZI3yNXSOpmq6TkCCcrErGJ8oNYlV7+D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768388504; c=relaxed/simple;
	bh=VugPVUJMd+z7HOlqndsVEWJlVsudafHzu3nkiEkg/oA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lbuxm4wFRwHimmimR/aQe2dPWF8PGVK0JWkgUjoHBz9EYicGo0T1mQa4nZa/MnV32WkA+8djzyXk7pS4WwFOhAQcqQSdUJzlQo/860GQEPgGZ6mG/s6Y0hu/CKZs1z4J1nKoZsms6eec8lNbBnVHUMEbxH0NDabGokWHaQZ3UAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto; spf=pass smtp.mailfrom=horizon.auto; dkim=pass (1024-bit key) header.d=horizon.auto header.i=@horizon.auto header.b=jBM9JE5y; arc=none smtp.client-ip=42.62.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horizon.auto
DKIM-Signature: v=1; a=rsa-sha256; d=horizon.auto; s=horizonauto; c=relaxed/simple;
	q=dns/txt; i=@horizon.auto; t=1768388445; x=2632302045;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VugPVUJMd+z7HOlqndsVEWJlVsudafHzu3nkiEkg/oA=;
	b=jBM9JE5yJid1r+mIEInToqhFd0Tb677SLRzUo5KOEouTzs4UwOVI2i6Kk58muZi1
	xqud11w/SYLCmzdWS2y1WvwkLoLlkDVqhdMMnUzASjk5n2OOvvNpH22wb0PdPFuY
	BisGoqSxGIXgqvBcBWWSngz62bEDWlBTj15RBdwlvEE=;
X-AuditID: 0a0901b2-df5da70000001406-c3-6967775d57e1
Received: from mailgw03.horizon.ai ( [10.69.1.10])
	by mailgw03.horizon.ai (Anti-spam for msg) with SMTP id F6.EA.05126.D5777696; Wed, 14 Jan 2026 19:00:45 +0800 (HKT)
Received: from wangtao-VirtualBox.hobot.cc (10.9.0.252) by
 exchange003.hobot.cc (10.69.1.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.27; Wed, 14 Jan 2026
 19:00:43 +0800
From: Tao Wang <tao03.wang@horizon.auto>
To: <kuba@kernel.org>
CC: <alexandre.torgue@foss.st.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<maxime.chevallier@bootlin.com>, <mcoquelin.stm32@gmail.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <rmk+kernel@armlinux.org.uk>,
	<tao03.wang@horizon.auto>
Subject: [PATCH net v2] net: stmmac: fix transmit queue timed out after resume
Date: Wed, 14 Jan 2026 19:00:31 +0800
Message-ID: <20260114110031.113367-1-tao03.wang@horizon.auto>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260112200550.2cd3c212@kernel.org>
References: <20260112200550.2cd3c212@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exchange004.hobot.cc (10.9.15.112) To exchange003.hobot.cc
 (10.69.1.10)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsXC5crIpRtbnp5pMGemuMXPl9MYLZY/2MFq
	Med8C4vF02OP2C0e9Z9gs7iwrY/VYmHbEhaLy7vmsFm8fL2N2WLe37WsFscWiFl8O/2G0eJS
	/0QmB16Py9cuMnvMW1PtsWXlTSaPp/1b2T12zrrL7rFgU6nHplWdbB47d3xm8ni/7yqbx+dN
	cgFcUVw2Kak5mWWpRfp2CVwZbW+3MhasFq44Onk3UwPjAoEuRk4OCQETidb1LexdjFwcQgIr
	GCXmf73NCOE8Z5ToefyGGaSKTUBD4u7UaywgtoiAqMT2DevAOpgFXjFJ9N6YzgqSEBbwk1g/
	ZTE7iM0ioCoxp+UiWJxXwFZi/70WVoh18hL7D54FG8opYCjR8Wo2WL2QgIHE9YuH2SHqBSVO
	znwCtowZqL5562xmCFtC4uCLF8wQ9SoSzSfns0PMlJN4vWE/G4QdI7F90jG2CYxCs5CMmoVk
	1CwkoxYwMq9iFM5NzMxJLzcw1svIL8qsys/TS8zcxAiKPk7GTTsYlyz4qHeIkYmD8RCjBAez
	kggv7++0TCHelMTKqtSi/Pii0pzU4kOM0hwsSuK82opxmUIC6YklqdmpqQWpRTBZJg5OqQYm
	7bnRuunRBf+kUv5aN9fN23DRnfVSmPaVTcnHwtKF2FIPaArsf5b8Surm5YMLfU50aPIeURKy
	PLGEZ73g/GXX+FySv9z4ple85nZv4yaOt4I5z9b+3KTG/8fLUzJHbfW2nPVx/Uuvztp5vHSm
	8JH1vrHNq3hPmB7eKGgkJ1jc7NjoyiOf9HVaabvOI46f06p5VzqnNWZPVvYyDV/4KDAjruxC
	0dOzt9dF/S495sHilx3oMVknL0Tg0a/LN4Mnxi10Fz9j+2zNkbO/PN3XqTJUrW937tPwjhDm
	v7ZpEpvQZduXUu9mvtmQX/k0feGkfJ+mgMo7R36kbC4UOpCrnLzlxqTTJ/tP8Ly6IW5l+2WK
	EktxRqKhFnNRcSIARoYp4S0DAAA=

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

To solve the issue, set last_segment to false in stmmac_free_tx_buffer:
tx_q->tx_skbuff_dma[i].last_segment = false.  Do not use the last_segment
 default value and set last_segment to false in stmmac_tso_xmit. This
will prevent similar issues from occurring in the future.

Fixes: c2837423cb54 ("net: stmmac: Rework TX Coalesce logic")

changelog:
v1 -> v2:
	- Modify commit message, del empty line, add fixed commit
	 information.

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


