Return-Path: <netdev+bounces-213373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9056FB24C9B
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D76720263
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D86B2F746B;
	Wed, 13 Aug 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sx9Yd2Ey"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CE32F291A;
	Wed, 13 Aug 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096948; cv=none; b=LwqLdmIAD0+9C3Vs31UDaGuaw6B68khoBK4kqvfTs5j8djMdoqaopIHo3UZEp2LkHE7g229msQklE91LJmjB/x9IEC5WcDpp7ghjW6qWjKwfIwWTVt3MU6nW7JZ8jj5inXKM+6lNnQMA4MZkGR0ZYQkxmunxVsKNkT5zAmNU9Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096948; c=relaxed/simple;
	bh=0IUVHkNpNiVd4dKfHNtccXkcqQYA1UMken7l+DdOKgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m69KgqZq57PFF3gmfj/WdUns0mvP10ytvkzfqsPbfyd2j73B1PLLhMhp0d83F7i3FAAc+mzirptcB5wZ5xpdm3ajzYrQOaZo/lmNwLbmxQiL6aHc4fUoxUK6+2knUBNECaxxFhkVLhGzUoee0CBhRHcZjLyELPLqUHnez87actA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sx9Yd2Ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FF2C4CEF7;
	Wed, 13 Aug 2025 14:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755096947;
	bh=0IUVHkNpNiVd4dKfHNtccXkcqQYA1UMken7l+DdOKgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sx9Yd2EydQjztnnpSEbWNgnePm2SzoWEmawHNyY1iaTZyU0Q0m5Efl/ryspfKRvSz
	 5cO0hlFkGO46n6/ZE0k2WB0PJJ0cjfDqjCGqfJxccRDjwnCkR45t84zLTRthAVEJ5/
	 yMHXcjNoGE4NUgKcUjpEAiPQtCJPv+cHXzOsH9h03FqRmp7O7lO+xYEwsdPlxXsbe1
	 VsVFPVrsKPXhqPDykufgDRfZu+ooiDSW4/cEkokwazTTDObTiHmnpCfQpCgJRqS+py
	 yb8KiMse7KuH4OoHA2Z8clDZNddv8RqjA8EU5fDcLfP6YrW2ZLE0xcQRRwc6d5dzmh
	 2/yhI+JRjbbDA==
Received: by wens.tw (Postfix, from userid 1000)
	id 209F45FE68; Wed, 13 Aug 2025 22:55:45 +0800 (CST)
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
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH net-next v2 03/10] soc: sunxi: sram: add entry for a523
Date: Wed, 13 Aug 2025 22:55:33 +0800
Message-Id: <20250813145540.2577789-4-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813145540.2577789-1-wens@kernel.org>
References: <20250813145540.2577789-1-wens@kernel.org>
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


