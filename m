Return-Path: <netdev+bounces-220932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A208CB497E6
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 20:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1632A168270
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895D731577E;
	Mon,  8 Sep 2025 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGfuiBkn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A42313E14;
	Mon,  8 Sep 2025 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355072; cv=none; b=cDTAvEw4n4fTnC0p8E9j2zaWtmEJsQBlfaW7dzsov9WWXD2SN3HRumEiutHo5nLKVIeG/Kvi3C/PHKnxuWaThdVkiDiPhlE8MuOopAbHrxjJJsU9+0tYtjBQYloT7LkM5sUlYQMY/fF7jqAcCT5erHVT9ppCqbkFVsb1FVLbK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355072; c=relaxed/simple;
	bh=e0tQSO9pJI2jVvlvL9W4OBbAj83puHTjG+o0KV+3bdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mrqC9XtdVm8tKf3j5BUeehx14NCoo/kDv+9MoWVb4VypYPUMPuHSW63ms5k/8nGxCGx/5omvYiHyG1XMTW/fkQfefZ/0Gio7BsPoKkqnDH8S8793crcDpFyI8tn7506grIWGWtKOJqgF2jdA2c9Sz/lLGFyTmYlYu2S43xIhn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGfuiBkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6C8C4CEF9;
	Mon,  8 Sep 2025 18:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757355071;
	bh=e0tQSO9pJI2jVvlvL9W4OBbAj83puHTjG+o0KV+3bdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XGfuiBknyZewEytJ/+sWeCVFnZqN99cWs8KQAMSWVX2/XB7wV2n64s5ROdA62JhqR
	 KKtEEZ/ZLQQpfU6N8wJpYtSca+N88owhvtfBytXnInqufA4EK/og1+MmVdTz8WH7d9
	 5kXTctapjv6J0Bs7F7vdvegV6PAnddgqiEcYjT2/1mHbh8ftEuBK/JXmSEGzF/470O
	 sQpaJpjCeD9YUKES5Na8l69N/gSoFIm3ZoLdxmRW1Csa6uCUxCknH4OZcxOhSc44/9
	 9T4PIJZDmP648eKZWZtuP2EXiTsTkssAkmRzGI7DHrXgXKv0xx4lWLz7FDAJVXPybM
	 X5OEvD5qwQZkQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 342895FEF5; Tue, 09 Sep 2025 02:11:08 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH net-next v4 03/10] soc: sunxi: sram: add entry for a523
Date: Tue,  9 Sep 2025 02:10:52 +0800
Message-Id: <20250908181059.1785605-4-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250908181059.1785605-1-wens@kernel.org>
References: <20250908181059.1785605-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The A523 has two Ethernet controllers. So in the system controller
address space, there are two registers for Ethernet clock delays,
one for each controller.

Add a new entry for the A523 system controller that allows access to
the second register.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/soc/sunxi/sunxi_sram.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 08e264ea0697..4f8d510b7e1e 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -320,6 +320,10 @@ static const struct sunxi_sramc_variant sun50i_h616_sramc_variant = {
 	.has_ths_offset = true,
 };
 
+static const struct sunxi_sramc_variant sun55i_a523_sramc_variant = {
+	.num_emac_clocks = 2,
+};
+
 #define SUNXI_SRAM_THS_OFFSET_REG	0x0
 #define SUNXI_SRAM_EMAC_CLOCK_REG	0x30
 #define SUNXI_SYS_LDO_CTRL_REG		0x150
@@ -440,6 +444,10 @@ static const struct of_device_id sunxi_sram_dt_match[] = {
 		.compatible = "allwinner,sun50i-h616-system-control",
 		.data = &sun50i_h616_sramc_variant,
 	},
+	{
+		.compatible = "allwinner,sun55i-a523-system-control",
+		.data = &sun55i_a523_sramc_variant,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sunxi_sram_dt_match);
-- 
2.39.5


