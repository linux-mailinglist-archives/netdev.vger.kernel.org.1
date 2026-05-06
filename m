Return-Path: <netdev+bounces-285009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHstBqqW+2ladAMAu9opvQ
	(envelope-from <netdev+bounces-285009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:29:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6544DFC89
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 355BD3026F3C
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 19:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8089F31F98C;
	Wed,  6 May 2026 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="SUJuNm4O"
X-Original-To: netdev@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC52317170;
	Wed,  6 May 2026 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778095708; cv=none; b=ENyr/FzLGbJ6vZKEopvsp8f4R90q9Ia8I0Zsv4Ov2dGEn03q+TlAnHy2KFt7ZlMDvhYmkXA2JsSSQenh2rdQfAd/8jgNHHBTXQgVuWIs93RqiifxsGKWvtm0oTcgmUtbY4ReIe0J1DtcNoBU0U6UAyF4M3fBWXmvQMxwU5W+Kys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778095708; c=relaxed/simple;
	bh=vsrtrJ9buHwdzmdyF82x8HdFrwpQnmtnlmltzMTO8Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFtWdDu1Us9evhZiHr0e3lhiluLnQVzjlyld5INuVrusRg3L9/u25MuKi9UpavRJs9UGJrHSHcfItLQKM3rufiMteMSxtj6Wz/j6o80rBylLLmTwtZi7Hzi9XKOvqGQL/JQqxFNXvfb1+DJk53THx79XzUJO2k7IO4nUHYcIw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=SUJuNm4O; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id 5382D605AC;
	Wed,  6 May 2026 19:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1778095696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQOo6i5L4AWlWVMmz8x/g6xSz6/gFVtG0BN+RVJuYk8=;
	b=SUJuNm4OTdX8ID2xAHaTEYaUuPC1I4k+QAdbbx40lrakO9MAhB/ZsVwTkBRRqrTM92iypj
	bycWW9Oj2g810faQYsNhr/ivsgZDTQ9XVqij3IAn2KVrrPQJPIEqt+v2arXdOxXAM3Qv61
	MCbiBhGFITBuoESTIo23V0I1ILyUQew=
Received: from frank-u24.. (unknown [217.61.157.0])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 0664F1226F3;
	Wed,  6 May 2026 19:28:16 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Mason Chang <mason-cw.chang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: [net-next v7 1/3] net: ethernet: mtk_eth_soc: Add register definitions for RSS and LRO
Date: Wed,  6 May 2026 21:28:01 +0200
Message-ID: <20260506192806.143725-2-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506192806.143725-1-linux@fw-web.de>
References: <20260506192806.143725-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5F6544DFC89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mailerdienst.de:s=routing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285009-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,collabora.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[public-files.de,vger.kernel.org,lists.infradead.org,mediatek.com,makrotopia.org];
	DMARC_NA(0.00)[fw-web.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@fw-web.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailerdienst.de:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fw-web.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,public-files.de:email,mediatek.com:email]

From: Mason Chang <mason-cw.chang@mediatek.com>

Add definitions for Receive Side Scaling and Large Receive Offload support.

Signed-off-by: Mason Chang <mason-cw.chang@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 23 +++++++++++++++
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 32 +++++++++++++++------
 2 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 8d225bc9f063..d25e0b96c26e 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -50,13 +50,18 @@ static const struct mtk_reg_map mtk_reg_map = {
 		.rx_ptr		= 0x0900,
 		.rx_cnt_cfg	= 0x0904,
 		.pcrx_ptr	= 0x0908,
+		.lro_ctrl_dw0   = 0x0980,
 		.glo_cfg	= 0x0a04,
 		.rst_idx	= 0x0a08,
 		.delay_irq	= 0x0a0c,
 		.irq_status	= 0x0a20,
 		.irq_mask	= 0x0a28,
 		.adma_rx_dbg0	= 0x0a38,
+		.lro_alt_score_delta	= 0x0a4c,
 		.int_grp	= 0x0a50,
+		.lro_rx1_dly_int	= 0x0a70,
+		.lro_ring_dip_dw0	= 0x0b04,
+		.lro_ring_ctrl_dw1	= 0x0b28,
 	},
 	.qdma = {
 		.qtx_cfg	= 0x1800,
@@ -113,6 +118,7 @@ static const struct mtk_reg_map mt7986_reg_map = {
 	.tx_irq_mask		= 0x461c,
 	.tx_irq_status		= 0x4618,
 	.pdma = {
+		.rss_glo_cfg    = 0x2800,
 		.rx_ptr		= 0x4100,
 		.rx_cnt_cfg	= 0x4104,
 		.pcrx_ptr	= 0x4108,
@@ -123,6 +129,12 @@ static const struct mtk_reg_map mt7986_reg_map = {
 		.irq_mask	= 0x4228,
 		.adma_rx_dbg0	= 0x4238,
 		.int_grp	= 0x4250,
+		.int_grp3	= 0x422c,
+		.lro_ctrl_dw0	= 0x4180,
+		.lro_alt_score_delta	= 0x424c,
+		.lro_rx1_dly_int	= 0x4270,
+		.lro_ring_dip_dw0	= 0x4304,
+		.lro_ring_ctrl_dw1	= 0x4328,
 	},
 	.qdma = {
 		.qtx_cfg	= 0x4400,
@@ -170,10 +182,21 @@ static const struct mtk_reg_map mt7988_reg_map = {
 		.glo_cfg	= 0x6a04,
 		.rst_idx	= 0x6a08,
 		.delay_irq	= 0x6a0c,
+		.rx_cfg		= 0x6a10,
 		.irq_status	= 0x6a20,
 		.irq_mask	= 0x6a28,
 		.adma_rx_dbg0	= 0x6a38,
 		.int_grp	= 0x6a50,
+		.int_grp3	= 0x6a58,
+		.tx_delay_irq	= 0x6ab0,
+		.rx_delay_irq	= 0x6ac0,
+		.lro_ctrl_dw0	= 0x6c08,
+		.lro_alt_score_delta	= 0x6c1c,
+		.lro_ring_dip_dw0	= 0x6c14,
+		.lro_ring_ctrl_dw1	= 0x6c38,
+		.lro_alt_dbg	= 0x6c40,
+		.lro_alt_dbg_data	= 0x6c44,
+		.rss_glo_cfg	= 0x7000,
 	},
 	.qdma = {
 		.qtx_cfg	= 0x4400,
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 0168e2fbc619..334625814b97 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -1143,16 +1143,30 @@ struct mtk_reg_map {
 	u32	tx_irq_mask;
 	u32	tx_irq_status;
 	struct {
-		u32	rx_ptr;		/* rx base pointer */
-		u32	rx_cnt_cfg;	/* rx max count configuration */
-		u32	pcrx_ptr;	/* rx cpu pointer */
-		u32	glo_cfg;	/* global configuration */
-		u32	rst_idx;	/* reset index */
-		u32	delay_irq;	/* delay interrupt */
-		u32	irq_status;	/* interrupt status */
-		u32	irq_mask;	/* interrupt mask */
+		u32	rx_ptr;			/* rx base pointer */
+		u32	rx_cnt_cfg;		/* rx max count configuration */
+		u32	pcrx_ptr;		/* rx cpu pointer */
+		u32	pdrx_ptr;		/* rx dma pointer */
+		u32	glo_cfg;		/* global configuration */
+		u32	rst_idx;		/* reset index */
+		u32	rx_cfg;			/* rx dma configuration */
+		u32	delay_irq;		/* delay interrupt */
+		u32	irq_status;		/* interrupt status */
+		u32	irq_mask;		/* interrupt mask */
 		u32	adma_rx_dbg0;
-		u32	int_grp;
+		u32	int_grp;		/* interrupt group1 */
+		u32	int_grp3;		/* interrupt group3 */
+		u32	tx_delay_irq;		/* tx delay interrupt */
+		u32	rx_delay_irq;		/* rx delay interrupt */
+		u32	lro_ctrl_dw0;		/* lro ctrl dword0 */
+		u32	lro_alt_score_delta;	/* lro auto-learn score delta */
+		u32	lro_rx1_dly_int;	/* lro rx ring1 delay interrupt */
+		u32	lro_ring_dip_dw0;	/* lro ring dip dword0 */
+		u32	lro_ring_ctrl_dw1;	/* lro ring ctrl dword1 */
+		u32	lro_alt_dbg;		/* lro auto-learn debug */
+		u32	lro_alt_dbg_data;	/* lro auto-learn debug data */
+		u32	rss_glo_cfg;		/* rss global configuration */
+
 	} pdma;
 	struct {
 		u32	qtx_cfg;	/* tx queue configuration */
-- 
2.43.0


