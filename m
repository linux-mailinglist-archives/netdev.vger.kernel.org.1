Return-Path: <netdev+bounces-174191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBA0A5DCEA
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7143B9FEB
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 12:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78A9243374;
	Wed, 12 Mar 2025 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqBg9Ngv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0F7242938;
	Wed, 12 Mar 2025 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783331; cv=none; b=gwHrxhEPFV/3pja/aQLXNIUU6kFO0FVeVSs2oP6EM78lFH60pB/inmD0+Ssa1TrTaW2UqDVtChQUSTM/2kee9OUaqiuwaLuweaH9C9jdLg6CKOObrZpUuNlG2U7fvC6sBvjaeIVbx62+G1FpwdA5HVF7Wy6WGe/dIgOzBzIJk5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783331; c=relaxed/simple;
	bh=okfRAyhj/OuF18kxT3pwOtemMTI22dYU0tMF9Ccp3Ew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oWtyGffytkWuoitxJlZiJRWczRLXnbhoSbHDsWGNkuGZ5Cu+sbGvCpi8cBmXBzk9kONZIPuSAWMvafq4NZWs3TUdzlVvUL3qhNb0BNxjaOhULEtbqLPX4Iym7SH1lL/oseBCEtp82rrAbg5CgMJXpXbTPiMpKWpikPWP0yoXUhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqBg9Ngv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E537FC4CEE3;
	Wed, 12 Mar 2025 12:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741783331;
	bh=okfRAyhj/OuF18kxT3pwOtemMTI22dYU0tMF9Ccp3Ew=;
	h=From:To:Cc:Subject:Date:From;
	b=BqBg9NgvEYowDAXhggHexPbakfdHGBqC9wV2b0Rl3ZCRXVOYhZK8zNCqd2dVsCmg0
	 nsgU8+m2ARQk966pA+cSTqO3DO7eNW1iLEYCnfTd/xpcsbaY5IisSQ/GpCoFpFjMDX
	 wFtpLjg0M3QrZ8RWNW78ZJ5ElAKMGLWdjWP0oueIvKB8sO6GpIzd8P+OSoEnKWNzKj
	 1PjndwBzMgbsJ/WMtO1iRNUVJc42HTE0weQFBuY2EciUIs2YQ4zgLtGkzVqRcZP4hw
	 7MYmOUt2jfkLBR2j1OClwVzzEqytddTW/hKAAhuxpn76BLX5WRXc4NmhTtu6IahG6M
	 YWgtg1BDqcu1w==
Received: by wens.tw (Postfix, from userid 1000)
	id D50745FC08; Wed, 12 Mar 2025 20:42:07 +0800 (CST)
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
Subject: [PATCH netdev v2] net: stmmac: dwmac-rk: Provide FIFO sizes for DWMAC 1000
Date: Wed, 12 Mar 2025 20:42:06 +0800
Message-Id: <20250312124206.2108476-1-wens@kernel.org>
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


