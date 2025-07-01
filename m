Return-Path: <netdev+bounces-203002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A25AF0104
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 19:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E394F165221
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1105027EFF1;
	Tue,  1 Jul 2025 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzqPmrkJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B61C3306;
	Tue,  1 Jul 2025 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389088; cv=none; b=ntUdkxiwwLxa5s7fMImKPWjjBbmrvSTBmpbZdIcAzzaekCmx1NgfuM6D6UON93/4ptp/UAFhI3M0MS3HMzpxIG1gfyTy18+bhlSUaIVd+d0Py3xUkx8NedxIBtlce3PCwbdO0InpLOba1urIPFEnqHLeNju2Id4ck5hASwu79rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389088; c=relaxed/simple;
	bh=0IUVHkNpNiVd4dKfHNtccXkcqQYA1UMken7l+DdOKgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oMYR1nSnUihOWx/5BMxz6mxedjII5FY5GLVcTejz9Wy5AQHt0y3rpzLqCtwElRWug/TSoMO5X6qhCpMsltRNFH3Y27JcQiH3Nwk8jJ9Rgwu9J8syHGAWWWtmlaR6s0275e26cyf/B2uI3r02Ne3mhXnYiPdEqvtFtHlu8iQCKQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzqPmrkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C180C4CEF1;
	Tue,  1 Jul 2025 16:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751389088;
	bh=0IUVHkNpNiVd4dKfHNtccXkcqQYA1UMken7l+DdOKgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EzqPmrkJSXDobG8Cftd0U3VOn3jfDO2MBYR8l0KjwwDC5sb0WcSqifUIklSpyS6B8
	 hGBzKY6PlmgnMyHqusPLyjZKWU0Su37Ke/8HHW0lXgwmON29eGHsepuzKwzDbjA6kG
	 Up6M5W238qd3RivHPfG+DvdkHg+jpCwzngBAT+/XoFrEOevluBVa1iQ93+78wSiKkN
	 bYiMG4jdJOKwWAr+NPPp5LmhhyLfLp4jl+d75i3bqjQ0vzsIYOQGto9q/kva34/CB3
	 0qqv5+WShzBU/Ce2ySHCXa2o7pwe/ZFEdhmBZ1dhM/CDogb2FMI1Go48hJfYJ7HbNO
	 OgLLJfMA2Pgzg==
Received: by wens.tw (Postfix, from userid 1000)
	id D6EC25FEE9; Wed,  2 Jul 2025 00:58:05 +0800 (CST)
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
Subject: [PATCH RFT net-next 03/10] soc: sunxi: sram: add entry for a523
Date: Wed,  2 Jul 2025 00:57:49 +0800
Message-Id: <20250701165756.258356-4-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701165756.258356-1-wens@kernel.org>
References: <20250701165756.258356-1-wens@kernel.org>
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


