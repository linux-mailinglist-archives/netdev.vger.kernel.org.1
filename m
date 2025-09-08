Return-Path: <netdev+bounces-220930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E640AB497E7
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 20:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D050188CA11
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F0B315766;
	Mon,  8 Sep 2025 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsJSXMDA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428EA31283B;
	Mon,  8 Sep 2025 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355072; cv=none; b=bWds5oYsiSr7NvZ9TgXl5ejMbpSzGzGrPCGOYTzWzXtoIUZ0SGFInIaEB9Ih45GmSvwReQaukiXU38feRDxkfu04PvMeleRZicGMW6iIifet8AOQuE7nmzK0gVsA9mI9QSM+W3E9ZO+bEgthUXxnEEQNAHsyd4KkNmSk3qBPVBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355072; c=relaxed/simple;
	bh=lfdtXInB87tu2kO8lr4PclPJGDu1MGh0UniOZ5ZFUPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s7S4jX3rcKbfbrRZFvDAB4jj6/raXXNQOQfo02r1H2zFd45SN/TEmHojtVdwzLjyyYOnc4FsEIxjflG3AjGXW8Y9gk0HG3Ti/dNi/LJcEsZbfOnBcy0dbgxF8U/N6vw5Eqe7vWqhEgqXQoKZ+QmwFaDjezIrl8V19icotHxYI2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsJSXMDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BF2C4AF0B;
	Mon,  8 Sep 2025 18:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757355071;
	bh=lfdtXInB87tu2kO8lr4PclPJGDu1MGh0UniOZ5ZFUPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SsJSXMDAgjrWt/CinApi/kfH/8IGCgQE9y6YylGIBATS7IcSBWWNry81z2gxcwVWB
	 tM7RDdrsu+8LA94mFbNDO1MFtYTTIzlMBb2MGExtX0mkOfWrNM76q+d5ZXEgtaAoQL
	 v6dPuMeNcBwaY8UzZiqj2blSBxgH/gBS6+jLsSDSXY1tdaa0m1JmpwlcMf9XtEfvvg
	 h7L7tYWk0ld31Pi5kjxGMkOrVOH7uLPL9EE4/dk2dM1Elm/Fqhhq3OV7WohSU+MLMr
	 RK9e7/6nvodl34f1VixxghUpbatZbmcdPbJnP4KOGfDWAl+RPVD0jbobHFISuYgtnq
	 IawI8k8rQj62A==
Received: by wens.tw (Postfix, from userid 1000)
	id 1BF805FEB3; Tue, 09 Sep 2025 02:11:09 +0800 (CST)
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
Subject: [PATCH net-next v4 04/10] soc: sunxi: sram: register regmap as syscon
Date: Tue,  9 Sep 2025 02:10:53 +0800
Message-Id: <20250908181059.1785605-5-wens@kernel.org>
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

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
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


