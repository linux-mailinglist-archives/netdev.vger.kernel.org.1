Return-Path: <netdev+bounces-199475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB22AE06E4
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF763B2058
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 13:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A4C2505D6;
	Thu, 19 Jun 2025 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="IiGc5phL"
X-Original-To: netdev@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7C324DCF7;
	Thu, 19 Jun 2025 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750339305; cv=none; b=HbYvr5nFZEVcxkPhEXx0ue20fw0dW19+1BDaV291TF9vRcCCoX91tfT0BCSMuHtT7JEBoTxxuEYdjKs1qYRJSJV8qb85jcBZvkYrmd3A+i3smDIoefPlm38tnnMNCY6alv4QqglFTIWQpQlyyTUzVxxkDsDrmjb4kobP5pbxSnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750339305; c=relaxed/simple;
	bh=tiLqnmjKL1xeScp1HZ8XPoZ3v5bsYgRhdhmsWJvgaWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTJ+HzKCdJUFB8f1Wpxl0M7mnNVx6KljeNsr47sqEuL9QGXl5sa+mhA/dU9fbLILiHZa0cUboxw6AOKTO/dabXHYr/tWxXMU6Mf8qitpaA17Vt/DbAg7COwjstZMZ29wM5M97/YHJk8pEd6L8eEuqPj+DCKQhwOgN9eQ73ywho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=IiGc5phL; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id 7241361634;
	Thu, 19 Jun 2025 13:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750339295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HS2lUJltRvHPUIa4JQpyFGxD+jJplBBokp6RSnTT/O0=;
	b=IiGc5phLz6zEsG8qlLtRtYkeD0bxYWoox9fQ+43vKyLGjgVxaEeH1iHA5zfIgBSd1ZCEk4
	V1ubV+Y3pQfoZx2RbzOsF54ca/gKjmr8j71jJEn7E1xN1FSAhgAMzMdGx+CInY0Za374fU
	jCekEa0SyjdgSt9Tu9DYJrfkR0itzcU=
Received: from frank-u24.. (fttx-pool-80.245.76.73.bambit.de [80.245.76.73])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 395D21226AA;
	Thu, 19 Jun 2025 13:21:35 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Simon Horman <horms@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	arinc.unal@arinc9.com
Subject: [net-next v6 4/4] net: ethernet: mtk_eth_soc: only use legacy mode on missing IRQ name
Date: Thu, 19 Jun 2025 15:21:24 +0200
Message-ID: <20250619132125.78368-5-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619132125.78368-1-linux@fw-web.de>
References: <20250619132125.78368-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

If platform_get_irq_byname returns -ENXIO fall back to legacy (index
based) mode, but on other errors function should return this error.

Suggested-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 67ba8927be46..f8a907747db4 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3346,6 +3346,13 @@ static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
 	if (eth->irq[MTK_FE_IRQ_TX] >= 0 && eth->irq[MTK_FE_IRQ_RX] >= 0)
 		return 0;
 
+	/* only use legacy mode if platform_get_irq_byname returned -ENXIO */
+	if (eth->irq[MTK_FE_IRQ_TX] != -ENXIO)
+		return eth->irq[MTK_FE_IRQ_TX];
+
+	if (eth->irq[MTK_FE_IRQ_RX] != -ENXIO)
+		return eth->irq[MTK_FE_IRQ_RX];
+
 	/* legacy way:
 	 * On MTK_SHARED_INT SoCs (MT7621 + MT7628) the first IRQ is taken
 	 * from devicetree and used for both RX and TX - it is shared.
-- 
2.43.0


