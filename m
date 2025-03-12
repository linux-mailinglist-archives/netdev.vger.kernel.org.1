Return-Path: <netdev+bounces-174278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FDDA5E1D9
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9EC3B8A84
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 16:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3EF1D5CF2;
	Wed, 12 Mar 2025 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7XI3XO7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA8C1CD215;
	Wed, 12 Mar 2025 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741797273; cv=none; b=gsydrADGFyOosQ9xpQfzVI/KRzQGm969C6SP8fugshzDOkvBo37WvrSTtWKuY1cnU4+/iBypnhD/pCcugxSA4XVdBovassqCb7yZQgXRZKEz3xldDK3iRA1V7fAQ2BgW1YNyQNsxs2NGdK/5EKzAoN5wJtdiwTiAsr8UFFlnXBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741797273; c=relaxed/simple;
	bh=TrqwpzyHwOhx55DeV4/s86mTsh9lYCPM7W7wIRkTwn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cYvjMwKCWkCEVRe13qsxSTq1M5MJwu3HXtHE/96R3Th2jIDApvgV3o2l25Cu+UwrBzKlBHFzgQ0ezDcMjTtYBGe59TEEbf1wcR9gKAmD+ord8aVaRChGP+B44k5dQxH4xVwIAewu4jGqpXj2oT8Ba1E8/yR3d+1eJip+GXL7Eh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7XI3XO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB91C4CEDD;
	Wed, 12 Mar 2025 16:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741797273;
	bh=TrqwpzyHwOhx55DeV4/s86mTsh9lYCPM7W7wIRkTwn4=;
	h=From:To:Cc:Subject:Date:From;
	b=d7XI3XO7Io7+7Mm0zhchHjlSOqTm3nhhUoH04TKNMo8T1HCNfrJUZ5cCJYN4HzEYE
	 HWx5NnqhLcrwYnm2sDQGH+EiipCf32aZxyvKjDaG24V1uq5dULMG8+O+5j5UCvtobT
	 0D5vxcFKvZQ2JpQGcDsWliX7YjpSftCqY7uTw/EA4ofYPj8hggDsJjtleuYb7UTQA6
	 ZAWkshyeLFWBvpt7HbTlhikUDcIH/rhWD6U9jKQfi41OURjTx9xcCZwEFc6pXkApW0
	 V/Wdpv5gngnM4MIot8Eyk+89MqTNkPs8MsloLQ0qiSQUMNq5MHiKlq07AfbrWrx/Nx
	 sVoXYLx/7135g==
Received: by wens.tw (Postfix, from userid 1000)
	id 2512F5FC08; Thu, 13 Mar 2025 00:34:30 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Chen-Yu Tsai <wens@csie.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH RESEND net-next v2] net: stmmac: dwmac-rk: Provide FIFO sizes for DWMAC 1000
Date: Thu, 13 Mar 2025 00:34:26 +0800
Message-Id: <20250312163426.2178314-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The DWMAC 1000 DMA capabilities register does not provide actual
FIFO sizes, nor does the driver really care. If they are not
provided via some other means, the driver will work fine, only
disallowing changing the MTU setting.

Provide the FIFO sizes through the driver's platform data to enable
MTU changes. The FIFO sizes are confirmed to be the same across RK3288,
RK3328, RK3399 and PX30, based on their respective manuals. It is
likely that Rockchip synthesized their DWMAC 1000 with the same
parameters on all their chips that have it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Resent with correct subject tag.

Changes since v1:
- Removed references to breakage from commit message as it is already fixed
- Removed Cc stable and Fixes tags
- Rebased onto latest -next
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 003fa5cf42c3..e57181ce5f84 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1969,8 +1969,11 @@ static int rk_gmac_probe(struct platform_device *pdev)
 	/* If the stmmac is not already selected as gmac4,
 	 * then make sure we fallback to gmac.
 	 */
-	if (!plat_dat->has_gmac4)
+	if (!plat_dat->has_gmac4) {
 		plat_dat->has_gmac = true;
+		plat_dat->rx_fifo_size = 4096;
+		plat_dat->tx_fifo_size = 2048;
+	}
 
 	plat_dat->set_clk_tx_rate = rk_set_clk_tx_rate;
 
-- 
2.39.5


