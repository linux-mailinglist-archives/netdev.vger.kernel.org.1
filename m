Return-Path: <netdev+bounces-141604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09F39BBB07
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD7E1C2082F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 17:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F4F1CEEA0;
	Mon,  4 Nov 2024 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dmkVavHt"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACDE1CC163;
	Mon,  4 Nov 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739785; cv=none; b=ETMab6B2yqucACVuJhRDRIRpJK60o/zsDaMBl/soNbx7MlF4WaCtkYlnsqtpsxtvEYx79lJZCz00fCDMEsYnJDTj+iXY42fUteR5CUYBUyQEGNQaIcZQadP327L9lm6cCZnjcT0RvCyK4oRsYt5ZgodCVlahjKrHvABoh4zn6rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739785; c=relaxed/simple;
	bh=taCm7jGrsMwVaRpcMPC8pIyj/uNkzIXNqh9XL7lssJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZeSdfYJzveBXfR55EKlGk5O5nyGc8fYRZ0CqyfvRJR+D0bAC5Nv+mCZG9DySaXkpq5Vfgh0e2drGa7asiOrQP8HtxD84nlaDeUMAAVY4zuKiYoCVEQea2OiHPlKp89lAH7kBIa07MttkM8NAVD5OXVU53OeIP9v7OblUp/desc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dmkVavHt; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 07D286000F;
	Mon,  4 Nov 2024 17:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730739781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OkO1POXX6QJMBWryIQ5Nked+++Y4eOh+hwdKXFwqivE=;
	b=dmkVavHtsJHHquw13b+tInggEp3vFcIPTe/P4Zu28rz+dP5Z6MqAgxx7F9d/N7iqDXUmjT
	tkGWlU7UUoEiOkPQ2A5VRJrmX4uI7XpZ5XvA4XN4c7nzW2UCSZKZTMiZ8ihFLWhbWAtJm3
	4gm6AtGc0QCTspcni2MmBL6JVMRgrxqY9tsbYUIHjsNI+APqD3fP7gP6MqG5o8wgejwS0M
	wORiWBvpJAjeCBG1z7gY+Wb49CJo0Wy+EX51M/7qRK/Ai9It1eNkqey3YQ89VFUnP0jHJz
	jCWeS4uoOlIOK/5Oxia0F5J0vre17T8oj9yn3RdkXmxqVPkfO0hWnpBp+h2O5g==
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
Subject: [PATCH net-next v2 7/9] net: stmmac: Don't include dwmac4 definitions in stmmac_ptp
Date: Mon,  4 Nov 2024 18:02:47 +0100
Message-ID: <20241104170251.2202270-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104170251.2202270-1-maxime.chevallier@bootlin.com>
References: <20241104170251.2202270-1-maxime.chevallier@bootlin.com>
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

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: No changes

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


