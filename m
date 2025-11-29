Return-Path: <netdev+bounces-242650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D1EC936FD
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 04:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B723A7061
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 03:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BFC221F15;
	Sat, 29 Nov 2025 03:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSnrFOJd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523E413A86C;
	Sat, 29 Nov 2025 03:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764385629; cv=none; b=NcMoBvdsZseb6BQOzroi/oq4oVaVaHtTs1bLrsm4a7FY4Ashi0dUPudxiyuXLZMLhqAuQkCLzYThI2yq/ip67Jx2egQxiBYishCK2nrHBVThWYwG0ONiXOy57JGyZufwK5eh9m4Oh0+Jd6cRR1iGx/xvDO4F2SXWSalCjVnVX5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764385629; c=relaxed/simple;
	bh=oSrDrkLL0unf1zQp33y275Hq4OhWlbnPmE5nxZPWLGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Qj6LZgm8gvSKV1sCyTOcPFC1HSLlvL8I4Y3wijynCgenc91MfManrkY1LceDFpWOy8maPboKQI0w6hlQX1FvyET+0zietl5yTsctEUK3TT8MLc79dGZ8/9WkXmXZe4h7GyVHsFf4ifESKm2HcbOmJyUqL1OImtxUfQIR7EbF+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSnrFOJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C81CAC4CEF1;
	Sat, 29 Nov 2025 03:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764385628;
	bh=oSrDrkLL0unf1zQp33y275Hq4OhWlbnPmE5nxZPWLGQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=RSnrFOJdrIcDIDsS63ZzQFUUFV7zsaYa8bLRg+RSmbHbi2HuYpqWT5C/I7I2E4GRc
	 xTxJbuJ3y9oR3VWVhYJYM0MPFsnxMgwIE6Ek2Eu5ZxhrCbE7gpUGK6L2p04iPH0xbV
	 pGrSd51LFelolglloYGyc0Z2wlO5EZxEectD5s6T9Pom1qij41pqeRqkPIaCytciaB
	 N3RiscsnTbud050XDacA8Sf30LSV2I5y8w5TffI3evHyVfhe5wFzadS0mYke6OX1EZ
	 ZNnRz0FltmvTEDy8DNnBxYMXk0Hf6oYIadDRcbwYPKWMYj1RkUaO10ZGLuPz0Hxquy
	 NkiU+W+7jU7IA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC340CFD376;
	Sat, 29 Nov 2025 03:07:08 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Sat, 29 Nov 2025 11:07:05 +0800
Subject: [PATCH net v2] net: stmmac: Fix E2E delay mechanism
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251129-ext-ptp-2v-v2-1-d23aca3e694f@altera.com>
X-B4-Tracking: v=1; b=H4sIAFhjKmkC/x3MQQqAIBBA0avErBvIiQi7SrRQm2o2JioSSHdPW
 r7F/xUSR+EES1chcpEkt2+gvgN3GX8yyt4MNNCkFGnkJ2PIAamgJedGO1tjJg0tCJEPef7ZCp4
 zbO/7AXYW/YxhAAAA
X-Change-ID: 20251129-ext-ptp-2v-b2cc3b7baa59
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Jose Abreu <Jose.Abreu@synopsys.com>, Fugang Duan <fugang.duan@nxp.com>, 
 Kurt Kanzenbach <kurt@linutronix.de>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764385627; l=2236;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=Vs44KaAN7n7X6+9HvqUBUtY37vLPXrYhMYfOJlZqUys=;
 b=ypg60oy/Dq2QN4TFD9EqHDMaOwPxa/g2c6RB6k+kdjcWlbpXEr4zWM2FB81DBAhG2qhirq7o5
 UOB5pBk6njBBKZaiVooSWo3wK5OrXnH96mGtc2G/POG28scDk2eNeg4
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

From: Rohan G Thomas <rohan.g.thomas@altera.com>

For E2E delay mechanism, "received DELAY_REQ without timestamp" error
messages show up for dwmac v3.70+ and dwxgmac IPs.

This issue affects socfpga platforms, Agilex7 (dwmac 3.70) and
Agilex5 (dwxgmac). According to the databook, to enable timestamping
for all events, the SNAPTYPSEL bits in the MAC_Timestamp_Control
register must be set to 2'b01, and the TSEVNTENA bit must be cleared
to 0'b0.

Commit 3cb958027cb8 ("net: stmmac: Fix E2E delay mechanism") already
addresses this problem for all dwmacs above version v4.10. However,
same holds true for v3.70 and above, as well as for dwxgmac. Updates
the check accordingly.

Fixes: 14f347334bf2 ("net: stmmac: Correctly take timestamp for PTPv2")
Fixes: f2fb6b6275eb ("net: stmmac: enable timestamp snapshot for required PTP packets in dwmac v5.10a")
Fixes: 3cb958027cb8 ("net: stmmac: Fix E2E delay mechanism")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
---
v1 -> v2:
   - Rebased patch to net tree
   - Replace core_type with has_xgmac
   - Nit changes in the commit message
   - Link: https://lore.kernel.org/all/20251125-ext-ptp-fix-v1-1-83f9f069cb36@altera.com/
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7b90ecd3a55e600458b0c87d6125831626f4683d..cfc6e5aaf6f631b9d00dab9f6339778123d4bc75 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -590,7 +590,8 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
 			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			snap_type_sel = PTP_TCR_SNAPTYPSEL_1;
-			if (priv->synopsys_id < DWMAC_CORE_4_10)
+			if (priv->synopsys_id < DWMAC_CORE_3_70 &&
+			    !priv->plat->has_xgmac)
 				ts_event_en = PTP_TCR_TSEVNTENA;
 			ptp_over_ipv4_udp = PTP_TCR_TSIPV4ENA;
 			ptp_over_ipv6_udp = PTP_TCR_TSIPV6ENA;

---
base-commit: 527d39cba164fd11e5a46dc38d8f330c72cf992b
change-id: 20251129-ext-ptp-2v-b2cc3b7baa59

Best regards,
-- 
Rohan G Thomas <rohan.g.thomas@altera.com>



