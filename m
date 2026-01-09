Return-Path: <netdev+bounces-248374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AFCD077DF
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 08:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 811D63049FC4
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 07:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC272E7BB6;
	Fri,  9 Jan 2026 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=horizon.auto header.i=@horizon.auto header.b="tMGgv0oR"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw03.horizon.ai (mailgw03.horizon.ai [42.62.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9942586FE
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 07:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.62.85.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767942161; cv=none; b=fLMupn03MjyLYAv/ZYg/VHwtVobvUSIx35+1AMZ1OhHFm+HSSjzqIPINz3LHk4ZhpR9xkYtPcwo6Q7r9yNVwMFLmDGePdRfX+YSFIoWbeWfMHWUNlYq+Aajs9DdY7ej4405AZQdPNaLeuWfIZpM7pgIUG5hHSS3uObuuJZit0nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767942161; c=relaxed/simple;
	bh=Y64n2Qv//UyAC/rV14nyXSTMyZ+t04xMntNuy1XuNfk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eUOXAgVbMjOAc6anS2Ojy5Um/smCkCQkhhXg2VLb5tiXqgYT+vdxoyrVH1PMJwBrkTIE8JhwYPSnQafB1PM+lGWlFlGl63uING4qvqPOvLmBE6cfdUFS/HMF5VIQ9pW72y/jKyIehPWxLNqzLchLDK6+DckDUhtjX/q+at9S2Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto; spf=pass smtp.mailfrom=horizon.auto; dkim=pass (1024-bit key) header.d=horizon.auto header.i=@horizon.auto header.b=tMGgv0oR; arc=none smtp.client-ip=42.62.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horizon.auto
DKIM-Signature: v=1; a=rsa-sha256; d=horizon.auto; s=horizonauto; c=relaxed/simple;
	q=dns/txt; i=@horizon.auto; t=1767942145; x=2631855745;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y64n2Qv//UyAC/rV14nyXSTMyZ+t04xMntNuy1XuNfk=;
	b=tMGgv0oRIFe+lRHjoOsdO5TBGTRhAuzGlRkQpWxSkr//Rgo9tDxucEbqo9Ct6EUs
	3Lw5QiMyaWmHk0MsAxebLmCMVAAZEHZ3IQWOdgu4voHqnJqHLfD7uEApmxob9MVD
	qIPmV31orHDJwoU3gf76mZaWsy9feX7kVqbQx3XJNBg=;
X-AuditID: 0a0901b2-df5da70000001406-04-6960a8010822
Received: from mailgw03.horizon.ai ( [10.9.15.111])
	by mailgw03.horizon.ai (Anti-spam for msg) with SMTP id C0.2C.05126.108A0696; Fri,  9 Jan 2026 15:02:25 +0800 (HKT)
Received: from wangtao-VirtualBox.hobot.cc (10.9.0.252) by
 exchange002.hobot.cc (10.9.15.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.27;
 Fri, 9 Jan 2026 15:02:24 +0800
From: Tao Wang <tao03.wang@horizon.auto>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>, <mcoquelin.stm32@gmail.com>,
	<alexandre.torgue@foss.st.com>, <rmk+kernel@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Tao Wang
	<tao03.wang@horizon.auto>
Subject: [PATCH net Resend] net: stmmac: fix transmit queue timed out after resume
Date: Fri, 9 Jan 2026 15:02:11 +0800
Message-ID: <20260109070211.101076-1-tao03.wang@horizon.auto>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exchange004.hobot.cc (10.9.15.112) To exchange002.hobot.cc
 (10.9.15.111)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsXCxcmfr8u4IiHTYP5UU4ufL6cxWix/sIPV
	Ys75FhaLR/0n2CwubOtjtVjYtoTF4vKuOWwWL19vY7Y4tkDM4tvpN4wWl/onMjlwe1y+dpHZ
	Y96aao8tK28yeTzt38rusWlVJ5vHzh2fmTze77vK5vF5k1wARxSXTUpqTmZZapG+XQJXxqmn
	+9kLDglVbNnxhqWB8Rh/FyMnh4SAicSJpknsILaQwEpGifON7l2MXED2c0aJS7ceMYIk2AQ0
	JO5OvcYCkhARWMwk0Xl6KhNIglkgVWLv7p/MILawQJDE1oeHWEFsFgEViaMzNgA1cHDwCthK
	fOhhgVgmL7H/4Fmwcl4BQYmTM5+wQIyRl2jeOpsZwpaQOPjiBTPEQSoSzSfns0P0ykm83rCf
	DcKOlfj2YgbLBEaBWUhGzUIyahaSUQsYmVcxCucmZuaklxsY62XkF2VW5efpJWZuYgTHCOOm
	HYxLFnzUO8TIxMF4iFGCg1lJhLdZMD5TiDclsbIqtSg/vqg0J7X4EKM0B4uSOK+2YlymkEB6
	YklqdmpqQWoRTJaJg1OqgSmB/aZb6obw65sXzW3n01K5v9xD6OxBzp17l+iynn01dWpBGo+q
	hNUFlq/Ci/ce/HlP+liB5cmf3PcteYRWb5tR/m/DAnXD5muODW4xMxhFXOvarnflZUyLvtPX
	+/rUaYdtG4/6pmU63LtXa3Rg1Zfd926pFHL1H/hpq/ciedmTA99z2AuWp/bam2Rzhh7lKmHv
	Wn5aQ0bcmL28Z9slj92bjUwz7yQ+/lPDlXn2p9sTli1z3q7fEmY60fHW/Crefy9NkxQZUp2E
	t/Fu4VvoZt1t+f3U6SWME5lrDYsXOub//hJ//4SWXPMCW+HIvKPin9dcYV/by7VeZdbLLJUN
	E3P2WvTtXbd2WoiM4En5lcuUWIozEg21mIuKEwG9m0ZvAAMAAA==

after resume dev_watchdog() message:
"NETDEV WATCHDOG: CPU: x: transmit queue x timed out xx ms"

The trigging scenario is as follows:

When the TSO function sets tx_skbuff_dma[tx_q->cur_tx].last_segment = true

, and the last_segment value is not cleared in stmmac_free_tx_buffer after

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


