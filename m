Return-Path: <netdev+bounces-214478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B182B29D03
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06B9A7A7F45
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 09:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144A530C375;
	Mon, 18 Aug 2025 09:02:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3978D23C8AA
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507759; cv=none; b=HUEhJMXL/NsdJVA7qb/vwxkhLZVzZcub1W/fIuG9bZbrzW694s52zVjrPnOLtx81UhVeeHxt78zyFa4YPFg/PwM4ztGPpkD4jzvvvw4DJcYrjmpxCbcDSX+C5YsZwMbjNAH1JYJBpveqQaJruAgF27knXSyvZBVdx7jbMqPYVas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507759; c=relaxed/simple;
	bh=uKYQ0tdjtCa0wFAdlSAcUwKA3G0GVY0grpdrfMbjVGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CUDJsP50Pl6Wbn/g1D59f3thnfPll9mKfmyuUXOAhF6kweaME6I/Jh8WnXq2Mgs68tdEX7WhBsE8ypYuamt9ERhbhZmofkuOa2dOuFiI2hlcB1h5eWqwJOADSWvtNFUnZD/PiNyKSawmS50sIQ/98eE8WObkGPHo9mYR3CyYCds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1unvky-0003N4-Rd; Mon, 18 Aug 2025 11:02:20 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1unvkw-000sBD-2N;
	Mon, 18 Aug 2025 11:02:18 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1unvkw-00Bhh0-28;
	Mon, 18 Aug 2025 11:02:18 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v1 2/3] net: stmmac: dwmac4: report Rx checksum errors in status
Date: Mon, 18 Aug 2025 11:02:16 +0200
Message-Id: <20250818090217.2789521-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250818090217.2789521-1-o.rempel@pengutronix.de>
References: <20250818090217.2789521-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Propagate hardware checksum failures from the descriptor parser to the
caller.

Currently, dwmac4_wrback_get_rx_status() updates stats when the Rx
descriptor signals an IP header or payload checksum error, but it does
not reflect this in its return value. The higher-level stmmac_rx() code
therefore cannot tell that hardware checksum validation failed.

Set the csum_none flag in the returned status when either
RDES1_IP_HDR_ERROR or RDES1_IP_PAYLOAD_ERROR is present. This aligns
dwmac4 with enh_desc_coe_rdes0() and lets stmmac_rx() mark the skb as
CHECKSUM_NONE for software verification.

This is a preparatory step for disabling the hardware filter that drops
frames which do not pass checksum validation.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index a5fb31eb0192..aac68dc28dc1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -110,16 +110,20 @@ static int dwmac4_wrback_get_rx_status(struct stmmac_extra_stats *x,
 
 	message_type = (rdes1 & ERDES4_MSG_TYPE_MASK) >> 8;
 
-	if (rdes1 & RDES1_IP_HDR_ERROR)
+	if (rdes1 & RDES1_IP_HDR_ERROR) {
 		x->ip_hdr_err++;
+		ret |= csum_none;
+	}
 	if (rdes1 & RDES1_IP_CSUM_BYPASSED)
 		x->ip_csum_bypassed++;
 	if (rdes1 & RDES1_IPV4_HEADER)
 		x->ipv4_pkt_rcvd++;
 	if (rdes1 & RDES1_IPV6_HEADER)
 		x->ipv6_pkt_rcvd++;
-	if (rdes1 & RDES1_IP_PAYLOAD_ERROR)
+	if (rdes1 & RDES1_IP_PAYLOAD_ERROR) {
 		x->ip_payload_err++;
+		ret |= csum_none;
+	}
 
 	if (message_type == RDES_EXT_NO_PTP)
 		x->no_ptp_rx_msg_type_ext++;
-- 
2.39.5


