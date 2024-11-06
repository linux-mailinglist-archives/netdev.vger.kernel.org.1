Return-Path: <netdev+bounces-142277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A759BE1A9
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2EA1F23A52
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE791DD0F2;
	Wed,  6 Nov 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QSZdGVv3"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415A81DB522;
	Wed,  6 Nov 2024 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883825; cv=none; b=duix6AHawu2Z1ettOFdyHOEp3M59reXgPwf4memt0NH+x1mkhxc08qBY+Sa9hubI7a3i64eGpci6arK7gA8n5xDF0xrQeNPnfFkWuoumO4QMkSoqcwi1Xg9ZecRJc7JvjbQp6PuSpbf2N0fXyqeapBKEovCy+IyGxKexp9l3YlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883825; c=relaxed/simple;
	bh=1gVOx7nJBT2hbmD/H6fKlrhljqTLUC8tKX9QCyRhVqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQ74G7qt+6C6Fc0fI6ngCatcqhP984rwbe4rAGpSqF0JzEX/DRqyIV/GAu/RrGOY7vD86QNf+43N+BlFHzZTwfgXDYkloqJ2q8240chfZBxuq1JGdeBk8wxfb1dk7lcZ2gWKIzwbREx9eTImuHv+9/VHVRbup76EFSMH8JXObQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QSZdGVv3; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 06823C0011;
	Wed,  6 Nov 2024 09:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730883821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+tS5coFjCL1GpMVLn+Jt4VDJfqi7WRWtEsSocGUBw08=;
	b=QSZdGVv3ycCS5kk4vrRroi+FE3i7NJdyKHC9j0KU6LTlVP+FToYYrp6RlSu4WylUgNfVqN
	sNwVLKIPIZ2E6wIFjZUKv/zKjRY3MdR4SYvFlK1MB4pwPWcnkgg2q5NvxRuj/Ih6tRpvnV
	JSyQFFjdckBWVY1F496Gh278MnqbIhxweZ+m48A4W/yvvzhwyQ/gN5+9L+FxWZroWSsrpL
	vIL+28Ve0Amya4LMns9oMXdq4oBO04NDVit+lqtjbXJKTxU9LMOH6rkPTG7c6upxBHl2FP
	ResMKZzz1cL4lAmvXPeIQFMON2mopaJjqA2irerfsB0mgnx5QspMgrdMbzil1w==
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
Subject: [PATCH net-next v3 7/9] net: stmmac: Don't include dwmac4 definitions in stmmac_ptp
Date: Wed,  6 Nov 2024 10:03:28 +0100
Message-ID: <20241106090331.56519-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106090331.56519-1-maxime.chevallier@bootlin.com>
References: <20241106090331.56519-1-maxime.chevallier@bootlin.com>
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


