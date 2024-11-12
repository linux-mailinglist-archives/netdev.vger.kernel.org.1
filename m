Return-Path: <netdev+bounces-144172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BE09C5E7D
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907C02824DF
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 17:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0EA21A4AA;
	Tue, 12 Nov 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pCZ3G208"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3510C2194BE;
	Tue, 12 Nov 2024 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431232; cv=none; b=i+O6O8gUx/HPFKbjW3iFaKpsbk1WUYD1v7m+R0MdVDy6E5CnYDWC2hOYguxfcnZh/LLsRKdbDLdcnRWjUzuS1bgE0CfrX6aBxBHX5+BQypmkRDSIcTsNCMbF5X5/8XQ+t/6aVlUIuRENt+vtbaTDbTffsj0NGwO6bhWOFp9ZuZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431232; c=relaxed/simple;
	bh=bet8NvkH1uCnuHOjXChUask37g3j8KJesxq8Pe/nu7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFy5WwAxk6QBdXCZ+lETUEVk1/a94i8B1C6M72DDEmAzskJC7KZfxm9cy4IilCI8GeJmZdWn0eDODXfBZEydI2djsgY+rVk2SFVLBTbCsFJksAwNKBTBbhGBtGXiq2FOsdh90uqpQGnxAwTwQI/9DpnPXFr84ber3FQvta6s7Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pCZ3G208; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE45BE0006;
	Tue, 12 Nov 2024 17:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731431228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/dDOU3IXt6wqdCpft8g2WA+gm1F7IyRLWSAkath9us=;
	b=pCZ3G208S6C7+vr6FbnjjLuPSZn1hB6+bG/Sw0rV2pLS3RY+60iMBN+iTvTtFc3YGhaY4U
	eKYsJYIVbwmY0fkH1W8W84zLs0HUTcPkAoLr55oVXgM7z/MOrpqy379XMdpFtmIcm2jF5m
	8MRuw1Ste6W3uavBZqWPYDfzv+Nb1mJ4Uew/7GCyU0Q9n64sNBGbfnevPA9jnCZtCu8Lvd
	J+HJWr/SKdVRgJsbFYfV+ix4TKeslx12ZcBtcrsi4VqzRU90bb8E5LV7CcTY4HLQ4blmA/
	dA5o/VBcl9EDyGxch8efc1c2LkADJMGF67rF2Nt358z36JcXn43TO8MTN+MAHg==
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
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 7/9] net: stmmac: Don't include dwmac4 definitions in stmmac_ptp
Date: Tue, 12 Nov 2024 18:06:55 +0100
Message-ID: <20241112170658.2388529-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112170658.2388529-1-maxime.chevallier@bootlin.com>
References: <20241112170658.2388529-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The stmmac_ptp code doesn't need the dwmac4 register definitions, remove
the inclusion.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 430905f591b2..429b2d357813 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -9,7 +9,6 @@
 *******************************************************************************/
 #include "stmmac.h"
 #include "stmmac_ptp.h"
-#include "dwmac4.h"
 
 /**
  * stmmac_adjust_freq
-- 
2.47.0


