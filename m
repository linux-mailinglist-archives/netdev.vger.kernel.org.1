Return-Path: <netdev+bounces-158724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 446FBA1311E
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 03:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFA43A5514
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 02:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5451C8635C;
	Thu, 16 Jan 2025 02:10:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EA574059;
	Thu, 16 Jan 2025 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736993414; cv=none; b=RNOAjcl/u+WhZVXPyS6hvagkezMHz3wYA0QBCwGjDN/mR49vtP3VeVpGLqTfizBbedm4b5Pqcy1dT9VXHYx6dcVzWdB/4x4B4iVuRBA/0CEOcYXGE/vJZqjVvm2ZibEypIxXOWslrclc7o/drU5wpepeZdgVoLueM88G5s49amk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736993414; c=relaxed/simple;
	bh=V/9nExnpkF1RQPTnxy0A6QYwxq8JNFrk5GHUVYMX8Zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pmTuamtjd3QK8j071dKN8w/T+v1rf/kJyFWGPeYWXseNQF6mkdju3mdSSjZlnybZm2RV+JzxzC1Ige+TI7z4Ica2FHiJQfiHkbPEV9GF2bMjkQ6SUko86yk2m+qgNw3hlXK6gBDYi3bi6ui5eyEOOrOlbEdUc97e5Wtgf1yRKnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 16 Jan 2025 11:09:00 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id CF9BA200C4F1;
	Thu, 16 Jan 2025 11:09:00 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Thu, 16 Jan 2025 11:09:00 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 1055EAB187;
	Thu, 16 Jan 2025 11:09:00 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net 2/2] net: stmmac: Limit the number of MTL queues to maximum value
Date: Thu, 16 Jan 2025 11:08:53 +0900
Message-Id: <20250116020853.2835521-2-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116020853.2835521-1-hayashi.kunihiko@socionext.com>
References: <20250116020853.2835521-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The number of MTL queues to use is specified by the parameter
"snps,{tx,rx}-queues-to-use" from the platform layer.

However, the maximum number of queues is determined by
the macro MTL_MAX_{TX,RX}_QUEUES. It's appropriate to limit the
values not to exceed the upper limit values.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index ad868e8d195d..471eb1a99d90 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -165,6 +165,8 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 	if (of_property_read_u32(rx_node, "snps,rx-queues-to-use",
 				 &plat->rx_queues_to_use))
 		plat->rx_queues_to_use = 1;
+	if (plat->rx_queues_to_use > MTL_MAX_RX_QUEUES)
+		plat->rx_queues_to_use = MTL_MAX_RX_QUEUES;
 
 	if (of_property_read_bool(rx_node, "snps,rx-sched-sp"))
 		plat->rx_sched_algorithm = MTL_RX_ALGORITHM_SP;
@@ -224,6 +226,8 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 	if (of_property_read_u32(tx_node, "snps,tx-queues-to-use",
 				 &plat->tx_queues_to_use))
 		plat->tx_queues_to_use = 1;
+	if (plat->tx_queues_to_use > MTL_MAX_TX_QUEUES)
+		plat->tx_queues_to_use = MTL_MAX_TX_QUEUES;
 
 	if (of_property_read_bool(tx_node, "snps,tx-sched-wrr"))
 		plat->tx_sched_algorithm = MTL_TX_ALGORITHM_WRR;
-- 
2.25.1


