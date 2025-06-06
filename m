Return-Path: <netdev+bounces-195410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 558DCAD004B
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 12:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5993B10B8
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F2A286D6B;
	Fri,  6 Jun 2025 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGsNv4cu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B272F3234;
	Fri,  6 Jun 2025 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749205266; cv=none; b=Sgkg5cUFFCWrrsC0ePxZqGZvNuGBdghIai7AfTqgo5bZzFsiV5GaooU9Nc401rSIviUMnq2oF4/2rCr60vYmRuXwz05Qqv+w1V2nC5ABVeD5EfEF55dEyvDNJBHo227Lk3gCci+5a04xIwdne4Ax3kGtFXchau9qU0fKWFPEjks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749205266; c=relaxed/simple;
	bh=RYf1MBF85kqiyEh6o51lvUtQzZdCLOMiZPIb6M9TABA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qReRdw0RnsqsZ6KldT1bXYjzBYsLOmE0YIROEJXjlOcI7OlaOT6iJlP/+O3MvcJkIUvdf4o0TZa/na9z30e12lQ7CulRDfIaUTp9AbJMLIfzhHUAn7o36U6eiswxXjKDGQCpvzVW9hnrQCWX7hXuqeC49KSe/PktXskig1ZgAcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGsNv4cu; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-606b6dbe316so3596423a12.3;
        Fri, 06 Jun 2025 03:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749205263; x=1749810063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MiiOBFHtT5ZtQA/f0RodEb62SyXtn3/Wda9R6Uedtxg=;
        b=HGsNv4cuy4slWAFFNRswX5oa46IVYHmJ5lWJ9Y+l2b77OHVtwoF4odq33j3h/NXNE+
         Xe89vtnGP6oJ70s4K3n34xzT7qy7+hyg1+CAt8BoTmGaB1cxEpVGWTGgbrVu4B+APF7Z
         R0QyWxWHfPT+VPAQfjPu6gJxHuf5XGZZ43l+qlb2WJvPA4YCsAh2TjqaM7r7hJ5Stw+x
         rJMK1x9vI0juuBmD2NpdjIiBXpu+m7/qJDaf3FoRRrJzz/axO+Ae7ZDc6KS9vt/G1Ft2
         3a5m87iNg+CUUHF5tiNNdhQRyBSfNPbDPOdixRIOr+eut/PFR3SmEGx0itfD1VF+bDKw
         lJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749205263; x=1749810063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MiiOBFHtT5ZtQA/f0RodEb62SyXtn3/Wda9R6Uedtxg=;
        b=ep6Maz8A8C8PKWU2HJxmPOTLlcwKa10+XqrJex/oUa09aJYV/KajboJMNyX99Q6eza
         fr7zrqC6x9Dgk9Tu65MLdDnJ4mqPCh7Bc5lG5uW5QpehorvvNBD4JmItr6GbHfahzKOj
         z1F0indidQrF1Mdwn1vBMeprKveGlem4h+y5oz1ncm27lBjdUmqb+a3VRYoL/Fpp6B33
         qdbgQ5z/w2IsE2kn3tmTRmf5yHLePA2J9KsvlVQXDr47tdXdRXI2YrbLYgYtFV5fihnH
         Ofj0jKVIBdm3NZIG/picKJBxiksLGkB6uAgyr7py6IGAFHC9KIaawDBJ12LtNpQxP1Fc
         dCJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG+ITMQjvMgQSeOk906vra+0uOrlR3PajHwVgStA6rGBh3WcTIgGzYRxtIrEqjIaLD5v3ko3UZQLzIF3M=@vger.kernel.org, AJvYcCXVBug28ZHilqyjodO0rTsL9u4/QoARhhsIMh/CFOjCIHKQD2mOUm1dt4hCi4G3HJ3zFXRwG/M/@vger.kernel.org
X-Gm-Message-State: AOJu0YxkrEoTEbzL1umdIokwNO/qYBGx5gGuERwo6fSb7BeW8czU7qlQ
	uSyV91O7amzPPfT4cOA5AQxQVXhER/Nwgyg/pVSElQG+jCp0GfQesoD0
X-Gm-Gg: ASbGncu7q0TuQDab95EfE7H78UxyK3hJZ75oN6PuECpBXYpnzyxU71ZllaEZmSM6qLb
	O0qgDFoCYXIzaMtZeo2QOC90pqBPRVlhrbJYiGYxv+zcKqXURJiVTzAw68i2quufv5JuVgn6lJ8
	Y2/D6zj5G4KHNvcHtZpyJ+w8AU/eZ1ag64ixqsskFUNfe5NHF0pENHi2HP1X4WyWNwWr2Mg89Qv
	WYw1EXDOpXxiy7p16syrgswRE7NG9IOXpAbloJDSON8rsYfoSwc1Ac88jttuBgxKddMMX7x5ND8
	NmsZTnOWCjkr0olG/P1xkyxBEyBL+/Xpu+69D/J2do3MHKWnf4l+ompKCJb9L0h9KBQPlWQSHLc
	=
X-Google-Smtp-Source: AGHT+IEhapm1K8w4bky257wfwPuqvgCoQuQfxgO95l+/hUIeSvoPyiy84rQ6sHS7x6VE6POMwqilxg==
X-Received: by 2002:a05:6402:1d4b:b0:606:f836:c666 with SMTP id 4fb4d7f45d1cf-60774a856bemr2463366a12.30.1749205262677;
        Fri, 06 Jun 2025 03:21:02 -0700 (PDT)
Received: from archlinux.ad.harman.com ([212.133.80.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783dd3c5sm809256a12.57.2025.06.06.03.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 03:21:02 -0700 (PDT)
From: Bartlomiej Dziag <bartlomiejdziag@gmail.com>
To: 
Cc: bartlomiejdziag@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: Change the busy-wait loops timing
Date: Fri,  6 Jun 2025 12:19:49 +0200
Message-ID: <20250606102100.12576-1-bartlomiejdziag@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After writing a new value to the PTP_TAR or PTP_STSUR registers,
the driver waits for the addend/adjust operations to complete.
Sometimes, the first check operation fails, resulting in
a 10 milliseconds busy-loop before performing the next check.
Since updating the registers takes much less than 10 milliseconds,
the kernel gets stuck unnecessarily. This may increase the CPU usage.
Fix that with changing the busy-loop interval to 5 microseconds.
The registers will be checked more often.

Signed-off-by: Bartlomiej Dziag <bartlomiejdziag@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index e2840fa241f2..f8e1278a1837 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -144,11 +144,11 @@ static int config_addend(void __iomem *ioaddr, u32 addend)
 	writel(value, ioaddr + PTP_TCR);
 
 	/* wait for present addend update to complete */
-	limit = 10;
+	limit = 10000;
 	while (limit--) {
 		if (!(readl(ioaddr + PTP_TCR) & PTP_TCR_TSADDREG))
 			break;
-		mdelay(10);
+		udelay(5);
 	}
 	if (limit < 0)
 		return -EBUSY;
@@ -187,11 +187,11 @@ static int adjust_systime(void __iomem *ioaddr, u32 sec, u32 nsec,
 	writel(value, ioaddr + PTP_TCR);
 
 	/* wait for present system time adjust/update to complete */
-	limit = 10;
+	limit = 10000;
 	while (limit--) {
 		if (!(readl(ioaddr + PTP_TCR) & PTP_TCR_TSUPDT))
 			break;
-		mdelay(10);
+		udelay(5);
 	}
 	if (limit < 0)
 		return -EBUSY;
-- 
2.49.0


