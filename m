Return-Path: <netdev+bounces-139896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D7B9B48C0
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8337283D51
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 11:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859E9206979;
	Tue, 29 Oct 2024 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GNwaBCtE"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6A205E26;
	Tue, 29 Oct 2024 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202877; cv=none; b=EMRbkdvlU7HS9ioEnxqKgyDzewWR19Rr8ayTsmP+7wOFzRpNHgKKL6WW9fBwDn9mHLoKwaf/GIalhDhfbivrz+qilwMAmoxr0+DUt6mSu5SY+SSTGsHLhzPC4WsOtCMdUNH2Uhv1tjtWc7ZzLiQTxR+nIv9OhcNGGIV9ijN8ico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202877; c=relaxed/simple;
	bh=gMvH0XNmkM3xvVyxhMszpLwJEXLT7j2FVIrMLp76smw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJycKWHiKUSb5O7EK8vv6gwaslAS9dtkx9bxIatYdIQj+zgD2FAthmb9mA2sPXviqqyfNiA1bX0CFDDxespP74y/sG0Sn82CiOakPhqbGt2GncLwHAzsZfEQdDj0wyOhsbp5CU0DqvP2yIawW9SraCXE9DVgAQTG13kvNUCoiDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GNwaBCtE; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B18B71C000E;
	Tue, 29 Oct 2024 11:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730202868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUD7v1wm0Jg5VpltZUrd0TSJuZblbrkqsBeqp691CjA=;
	b=GNwaBCtEDNN5Vtvtqfbwo/7F8ONXzQ6v5nt0z2SdjKzWqPCJq1/aIlYovSp1dCy2uNc1JS
	kfXhxirXXt81klReWhrCRVPXaDM7CCPuGVTUFPZJQo9evFC2rK5/5ru5vVMA8cxvR5/WdQ
	g/KV7QTTx0PmM8+OujqpratJ504Lac0vquiWKyIae9BupmCrtsXdUAo/Wp6fx3sstme784
	voTA6xpCtPPq17SlBn4s4DcxR63Slur0haH7BKFkWvhhzT1iWDIDPX5DjAOzkXmS+30JXt
	yKyxoJg1c5IHfja6KdLPe0HyabP2lRhZYeFNVCuT/w3VW4Xr6PtD43WQj0EH+Q==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/7] net: stmmac: Enable timestamping interrupt on dwmac1000
Date: Tue, 29 Oct 2024 12:54:14 +0100
Message-ID: <20241029115419.1160201-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029115419.1160201-1-maxime.chevallier@bootlin.com>
References: <20241029115419.1160201-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The default configuration for the interrupts on dwmac1000 have the
timestamping interrupt masked. Now that the timestamping has been
adapted to dwmac1000, enable the timestamping interrupt on these
platforms.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
index 600fea8f712f..9cc98f21a83f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
@@ -41,8 +41,7 @@
 #define	GMAC_INT_DISABLE_PCS	(GMAC_INT_DISABLE_RGMII | \
 				 GMAC_INT_DISABLE_PCSLINK | \
 				 GMAC_INT_DISABLE_PCSAN)
-#define	GMAC_INT_DEFAULT_MASK	(GMAC_INT_DISABLE_TIMESTAMP | \
-				 GMAC_INT_DISABLE_PCS)
+#define	GMAC_INT_DEFAULT_MASK	GMAC_INT_DISABLE_PCS
 
 /* PMT Control and Status */
 #define GMAC_PMT		0x0000002c
-- 
2.47.0


