Return-Path: <netdev+bounces-218242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB286B3B9EE
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 13:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3AAA217A8
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 11:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2752A311587;
	Fri, 29 Aug 2025 11:27:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE75304BCD;
	Fri, 29 Aug 2025 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756466839; cv=none; b=ToIhgf1p1sd3R/fnwreYgC6ma55Xp6BpaeuzXb6mAi7C4hi5bjNLvdhZVhAAdUIVIF2aEy8r0WjGC2IUMvywzdDz13OxQaqu9RdP7g8Rjl7W5HiC4MrlBpgw8fOtbYDaBEM/YmOweh3/m6+WUELFwDofaogBpZUQlCvRNKbbSBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756466839; c=relaxed/simple;
	bh=v1QwxvGexcHl08iOWEax22YWQ1qUHHbOOVYtwn3kd5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VexqznvqWwK8vgw65F4j+fNeh266B8CTwCgmnHXL09j5iqYZuuENgcgB0XKnNxwImsx3kFq5FatB9y2ChhBuJJY2HH2zZ8nIfJ5QQvtAnvPZWer1Mkdo44yNdhURR0r9zvoDkd11UarGCYYhUGEEtcGkEe1rxlTr+ALS73Y0lSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB5CC4CEF0;
	Fri, 29 Aug 2025 11:27:14 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Luo Jie <quic_luoj@quicinc.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] net: ethernet: qualcomm: QCOM_PPE should depend on ARCH_QCOM
Date: Fri, 29 Aug 2025 13:27:06 +0200
Message-ID: <eb7bd6e6ce27eb6d602a63184d9daa80127e32bd.1756466786.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Qualcomm Technologies, Inc. Packet Process Engine (PPE) is only
present on Qualcomm IPQ SoCs.  Hence add a dependency on ARCH_QCOM, to
prevent asking the user about this driver when configuring a kernel
without Qualcomm platform support,

Fixes: 353a0f1d5b27606b ("net: ethernet: qualcomm: Add PPE driver for IPQ9574 SoC")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/qualcomm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/Kconfig b/drivers/net/ethernet/qualcomm/Kconfig
index 29e6d746ad31ad7e..ba7efb108637cc15 100644
--- a/drivers/net/ethernet/qualcomm/Kconfig
+++ b/drivers/net/ethernet/qualcomm/Kconfig
@@ -62,8 +62,8 @@ config QCOM_EMAC
 
 config QCOM_PPE
 	tristate "Qualcomm Technologies, Inc. PPE Ethernet support"
-	depends on HAS_IOMEM && OF
-	depends on COMMON_CLK
+	depends on COMMON_CLK && HAS_IOMEM && OF
+	depends on ARCH_QCOM || COMPILE_TEST
 	select REGMAP_MMIO
 	help
 	  This driver supports the Qualcomm Technologies, Inc. packet
-- 
2.43.0


