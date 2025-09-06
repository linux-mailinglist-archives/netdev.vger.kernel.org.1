Return-Path: <netdev+bounces-220556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 702D3B468D3
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 06:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182DBA4801C
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 04:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C944260575;
	Sat,  6 Sep 2025 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGOCCKyv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A49A25BEF1;
	Sat,  6 Sep 2025 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132022; cv=none; b=MvUymzW6Cfp632MLmKoTdP0nMAZJIafY2sITOjZELd5Uyaw2b9u0K4MFlDOnEOJZMBfE/GDpjNaMCTY9BWG1QerBHIQ3tV6uuJe/iWTV2ZGjncIy9xpWf9onbFW7Oq0pyATZPh3xzt3hzhIzSnArwYnKOyJg05at1N8+VDbGQM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132022; c=relaxed/simple;
	bh=e0tQSO9pJI2jVvlvL9W4OBbAj83puHTjG+o0KV+3bdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p7kVozkxKcuf/VX/RjRenZoRMoW01BAnxh0Y0aw1S1xZzCPzDkfgEQQyVfkK937O8L9uPlcNknRTDokt+3SczLbtwlO6+GP0/4+3FUgopC/4RjDaI/mSLnO9hZ8nH43XqcZQfDr6qpI1ev2xjDz10VK/n45qk/SMzRXc60II2GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGOCCKyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6F5C4CEFA;
	Sat,  6 Sep 2025 04:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757132022;
	bh=e0tQSO9pJI2jVvlvL9W4OBbAj83puHTjG+o0KV+3bdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EGOCCKyvtKQUB2Yp7JXOHuMuYZTKhFou+gUmvaZSudPcnsXWZbxp+Ak58iQAVKgKY
	 gEYGre0Qtmg2KCOk6IpzBSiGSHy8zltK8m+VEf/e+22/0BXy4/IWWwu5XY5JQwNXpq
	 F/TaPGQS5uFbXVqzfip1eyjKEZIwE/PsS1Vu+7+0iHOE9/um5naRykJK2bWoscQgNk
	 PBp1RWgqH3QrFCgXX6qaqu4E0EFMh2KxzbWYWN4PUuAFtYzBrifpq7tIj1tl5lQcR3
	 T0i2DRm5W/x9oKLgQReyU2clkAzCdJJ+I8I0GNpjcMZTbg1+/NXf8RfGozg4r4B0KW
	 fK1sFc4mp0xvA==
Received: by wens.tw (Postfix, from userid 1000)
	id B6DFC5FE60; Sat, 06 Sep 2025 12:13:38 +0800 (CST)
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
Subject: [PATCH net-next v3 03/10] soc: sunxi: sram: add entry for a523
Date: Sat,  6 Sep 2025 12:13:26 +0800
Message-Id: <20250906041333.642483-4-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250906041333.642483-1-wens@kernel.org>
References: <20250906041333.642483-1-wens@kernel.org>
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


