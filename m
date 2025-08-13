Return-Path: <netdev+bounces-213378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57028B24CAC
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA6C3AA63B
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1332FFDF6;
	Wed, 13 Aug 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKjmu7gD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8A22FFDCC;
	Wed, 13 Aug 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096950; cv=none; b=FWrg7ez/Ea187q8MkHcQUFhe3la3GhoFV2p6Vw1ACfE30Ph9YqtbxQ9GWAfTEUTJoUF0JFqFuGkViwSqji7rRVPKAEstnbgLRPn7BRO/qDKchfXAfu0mFdvJQfh9YqjQn6uwnq+2sRZdVk+lazD/tafEY06Vi4J7nv7rwYd20zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096950; c=relaxed/simple;
	bh=W5wn3NeKGRyaF5afVGlpCWkJIlaztzO4EVZV0lTaqQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bS/z5mYbZ3bhR9h+3qj3dq3oNvkxy2Bjmpp2/mqF+3hT3SZ4V9j08kcR8DsSvJn+Y0/R7z7JXRh/zIQ0Crlz0w6ZPsZhxfp4lL72lAVe3wItJZLda6l5rtzFRKW2y7skMlvTUdmogNUXTJ1SinPQZoxPvmA/9K6BBCb674ozXeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKjmu7gD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CE7C116B1;
	Wed, 13 Aug 2025 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755096950;
	bh=W5wn3NeKGRyaF5afVGlpCWkJIlaztzO4EVZV0lTaqQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKjmu7gDM/sY1ung+b2oB69H9t9KqVNJfZZG37yj0ObpM930lYQpvllOBqy57EVBb
	 BYqjyn77jC9dpRjHpPpBFufMN/jl3clDlr5WPou97L63ucspEq6u7JFy0XYc4X0PXX
	 SdyDkwbhXhpagqemeI2U66L1rSFi++CLCfbjmXNcTaAahu1KUqq8Lzuj23I9fw3xgR
	 wAIXot0CwvTBXFjN29c36eSgEoFcyIIWdS3fsX/uiK+jOb4kw+0zLbtfq/NYDklvhq
	 YvH6l6B1Q3zb0qe7/veWRGMicVkemt+H1NaNIoOZ6Dmx4zNkTT3wXZGTU41C5zm9P+
	 YrWKodIMh+YSw==
Received: by wens.tw (Postfix, from userid 1000)
	id 341B15FF5B; Wed, 13 Aug 2025 22:55:45 +0800 (CST)
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
Subject: [PATCH net-next v2 04/10] soc: sunxi: sram: register regmap as syscon
Date: Wed, 13 Aug 2025 22:55:34 +0800
Message-Id: <20250813145540.2577789-5-wens@kernel.org>
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

If the system controller had a ethernet controller glue layer control
register, a limited access regmap would be registered and tied to the
system controller struct device for the ethernet driver to use.

Until now, for the ethernet driver to acquire this regmap, it had to
do a of_parse_phandle() + find device + dev_get_regmap() sequence.
Since the syscon framework allows a provider to register a custom
regmap for its device node, and the ethernet driver already uses
syscon for one platform, this provides a much more easier way to
pass the regmap.

Use of_syscon_register_regmap() to register our regmap with the
syscon framework so that consumers can retrieve it that way.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>

---
Changes since v1:
- Fix check on return value
- Expand commit message
---
 drivers/soc/sunxi/sunxi_sram.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 4f8d510b7e1e..1837e1b5dce8 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -12,6 +12,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -377,6 +378,7 @@ static int __init sunxi_sram_probe(struct platform_device *pdev)
 	const struct sunxi_sramc_variant *variant;
 	struct device *dev = &pdev->dev;
 	struct regmap *regmap;
+	int ret;
 
 	sram_dev = &pdev->dev;
 
@@ -394,6 +396,10 @@ static int __init sunxi_sram_probe(struct platform_device *pdev)
 		regmap = devm_regmap_init_mmio(dev, base, &sunxi_sram_regmap_config);
 		if (IS_ERR(regmap))
 			return PTR_ERR(regmap);
+
+		ret = of_syscon_register_regmap(dev->of_node, regmap);
+		if (ret)
+			return ret;
 	}
 
 	of_platform_populate(dev->of_node, NULL, NULL, dev);
-- 
2.39.5


